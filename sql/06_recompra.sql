-- ============================================================
-- 06_recompra.sql
--   * customer_id        -> distinto en cada pedido (une customers y orders)
--   * customer_unique_id -> identifica a la PERSONA real (para medir recompra)
-- uso solo pedidos 'delivered'.
-- ============================================================


-- 1) Numerar los pedidos de cada cliente por orden de fecha ----
-- Window function ROW_NUMBER: numera los pedidos DENTRO de cada
-- cliente (PARTITION BY), ordenados por fecha (ORDER BY).
-- El nº 1 es la primera compra de cada persona; llegar al nº 2
-- significa que repitio. Ordenando por num_pedido DESC sale
-- los clientes con más recompras.
SELECT
    c.customer_unique_id,
    o.order_purchase_timestamp,
    ROW_NUMBER() OVER (
        PARTITION BY c.customer_unique_id
        ORDER BY o.order_purchase_timestamp
    ) AS num_pedido
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
WHERE o.order_status = 'delivered'
ORDER BY c.customer_unique_id, num_pedido;


-- 2) Distribucion de recompra (HALLAZGO CENTRAL) 
-- Patron de dos niveles:
--   dentro -> nº de pedidos de cada cliente
--   fuera  -> cuantos clientes hay con cada nº de pedidos
--
-- Resultado:
--   1 pedido  -> 90.557 clientes
--   2 pedidos -> 2.573
--   3 pedidos -> 181 
--
-- Tasa de recompra = clientes con 2+ pedidos / total
--   = 2.801 / 93.358 = 3.0%
-- => El 97% de los clientes compra UNA vez y no vuelve.
--    La mayor caida esta entre el 1er y el 2o pedido.
SELECT
    num_pedidos_cliente,
    COUNT(*) AS num_clientes
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(*) AS num_pedidos_cliente
    FROM customers AS c
    JOIN orders AS o ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
) AS conteo
GROUP BY num_pedidos_cliente
ORDER BY num_pedidos_cliente;


-- 3) Dias entre una compra y la siguiente
-- Window function LAG: trae la fecha del pedido ANTERIOR de cada
-- cliente. Se envuelve en subconsulta porque el WHERE se procesa
-- antes que las window functions (no se puede filtrar el LAG en
-- el mismo nivel donde se calcula).
-- Filtros del WHERE de fuera:
--   * fecha_anterior IS NOT NULL -> deja solo recompras (el 1er
--     pedido no tiene anterior).
--   * >= INTERVAL '1 day' -> descarta "pedidos partidos". Una misma
--     compra registrada como 2 pedidos con segundos de diferencia.
--     No son recompras reales.
SELECT
    customer_unique_id,
    fecha_pedido,
    fecha_anterior,
    fecha_pedido - fecha_anterior AS dias_entre_compras
FROM (
    SELECT
        c.customer_unique_id,
        o.order_purchase_timestamp AS fecha_pedido,
        LAG(o.order_purchase_timestamp) OVER (
            PARTITION BY c.customer_unique_id
            ORDER BY o.order_purchase_timestamp
        ) AS fecha_anterior
    FROM customers AS c
    JOIN orders AS o ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
) AS con_fecha_anterior
WHERE fecha_anterior IS NOT NULL
  AND fecha_pedido - fecha_anterior >= INTERVAL '1 day'
ORDER BY dias_entre_compras;


-- 4) Resumen de los tiempos entre compras (HALLAZGO) 
-- Tres niveles: la consulta del LAG (interno), EXTRACT para pasar
-- el intervalo a numero de dias (medio), y las agregaciones (externo).
--
-- Resultado:
--   num_recompras = 2.198
--   min = 1 dia | media = 111.8 | MEDIANA = 71 | max = 608
--
-- => Quien vuelve, tarda ~71 dias (mediana; +2 meses) en volver.
--    No hay recompra temprana. La ventana de reenganche de las
--    primeras semanas esta desaprovechada.
SELECT
    COUNT(*)                                    AS num_recompras,
    MIN(dias)                                   AS min_dias,
    ROUND(AVG(dias), 1)                         AS media_dias,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY dias) AS mediana_dias,
    MAX(dias)                                   AS max_dias
FROM (
    SELECT
        EXTRACT(DAY FROM (fecha_pedido - fecha_anterior)) AS dias
    FROM (
        SELECT
            c.customer_unique_id,
            o.order_purchase_timestamp AS fecha_pedido,
            LAG(o.order_purchase_timestamp) OVER (
                PARTITION BY c.customer_unique_id
                ORDER BY o.order_purchase_timestamp
            ) AS fecha_anterior
        FROM customers AS c
        JOIN orders AS o ON c.customer_id = o.customer_id
        WHERE o.order_status = 'delivered'
    ) AS con_fecha_anterior
    WHERE fecha_anterior IS NOT NULL
      AND fecha_pedido - fecha_anterior >= INTERVAL '1 day'
) AS recompras;
