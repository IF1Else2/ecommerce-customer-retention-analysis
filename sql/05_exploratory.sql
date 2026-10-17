-- ============================================================
-- 05_exploratory.sql
-- ============================================================


-- 1) Precio: media vs mediana 
-- La mediana (74.99 R$) es muy inferior a la media (120.65 R$):
-- distribucion sesgada a la derecha (pocos productos caros tiran
-- de la media). El producto "tipico" cuesta ~75 R$, no 120.
-- Leccion: para "precio tipico" se reporta la MEDIANA.
SELECT
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS mediana,
    AVG(price) AS media
FROM order_items;


-- 2) Reparto de pedidos por estado 
-- 'delivered' = 97% (96.478 de 99.441). El resto son colas minimas
-- (cancelados, en transito, etc.).
-- DECISION DE ANALISIS: para recompra y tiempos se usan solo pedidos
-- 'delivered'.
SELECT
    order_status,
    COUNT(*) AS cantidad
FROM orders
GROUP BY order_status
ORDER BY cantidad DESC;


-- 3) Metodos de pago y numero medio de plazos 
-- credit_card domina (74%), y es el UNICO metodo que se fracciona
-- (media 3.51 plazos). boleto, voucher y debit_card van a 1 plazo..
-- La media de plazos solo es interpretable para credit_card.
SELECT
    payment_type,
    COUNT(*) AS cantidad,
    AVG(payment_installments) AS media_plazos
FROM order_payments
GROUP BY payment_type
ORDER BY cantidad DESC;


-- 4) Categorias mas vendidas 
-- (products es el catalogo). Dos JOINs encadenados:
--   order_items -> products -> product_category_translation
-- Top: bed_bath_table, health_beauty, sports_leisure.
-- Marketplace de hogar, belleza y ocio; productos de consumo.
SELECT
    t.product_category_name_english AS categoria,
    COUNT(*) AS ventas
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id
JOIN product_category_translation AS t
    ON p.product_category_name = t.product_category_name
GROUP BY categoria
ORDER BY ventas DESC;


-- 5) Lineas por pedido 
-- Patron de dos niveles (subconsulta):
--   dentro  -> nº de lineas de cada pedido
--   fuera   -> cuantos pedidos hay con cada nº de lineas
-- Resultado: ~90% de los pedidos tienen una sola linea.
-- Compras pequeñas.
SELECT
    lineas,
    COUNT(*) AS num_pedidos
FROM (
    SELECT
        order_id,
        COUNT(*) AS lineas
    FROM order_items
    GROUP BY order_id
) AS conteo_por_pedido
GROUP BY lineas
ORDER BY lineas;
