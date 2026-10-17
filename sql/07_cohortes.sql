-- ============================================================
-- 07_cohortes.sql
-- Cohortes de clientes según el mes de su primera compra.
-- Mide cuántos clientes de cada cohorte vuelven a comprar
-- en los meses posteriores (usando customer_unique_id).
-- ============================================================

WITH primera_compra AS (
    SELECT 
        c.customer_unique_id,
        MIN(o.order_purchase_timestamp) AS fecha_primera
    FROM customers AS c
    JOIN orders AS o ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
),
pedidos_cohorte AS (
    SELECT 
        pc.customer_unique_id,
        DATE_TRUNC('month', pc.fecha_primera) AS cohorte,
        (EXTRACT(YEAR FROM o.order_purchase_timestamp) - EXTRACT(YEAR FROM pc.fecha_primera)) * 12
        + (EXTRACT(MONTH FROM o.order_purchase_timestamp) - EXTRACT(MONTH FROM pc.fecha_primera)) AS mes_numero
    FROM primera_compra AS pc
    JOIN customers AS c ON pc.customer_unique_id = c.customer_unique_id
    JOIN orders AS o ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
)
SELECT 
    cohorte,
    mes_numero,
    COUNT(DISTINCT customer_unique_id) AS clientes_activos
FROM pedidos_cohorte
GROUP BY cohorte, mes_numero
ORDER BY cohorte, mes_numero;