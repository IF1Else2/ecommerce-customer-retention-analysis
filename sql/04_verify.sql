-- ============================================================
-- 04_verify.sql
-- ============================================================

-- 1) Numero de filas por tabla 
-- Compara con las cifras esperadas.
SELECT 'customers'      AS tabla, COUNT(*) AS filas FROM customers
UNION ALL SELECT 'sellers',        COUNT(*) FROM sellers
UNION ALL SELECT 'products',       COUNT(*) FROM products
UNION ALL SELECT 'categoria_trad', COUNT(*) FROM product_category_translation
UNION ALL SELECT 'geolocation',    COUNT(*) FROM geolocation
UNION ALL SELECT 'orders',         COUNT(*) FROM orders
UNION ALL SELECT 'order_items',    COUNT(*) FROM order_items
UNION ALL SELECT 'order_payments', COUNT(*) FROM order_payments
UNION ALL SELECT 'order_reviews',  COUNT(*) FROM order_reviews;

-- 2) Pedidos totales 
SELECT COUNT(*) AS pedidos_totales FROM orders;

-- 3) Clientes reales (personas) vs filas de customers -------------
-- hay casi tantas filas como pedidos, pero menos personas reales.
SELECT
    COUNT(*)                           AS filas_customers,
    COUNT(DISTINCT customer_unique_id) AS personas_reales
FROM customers;

-- 4) Rango de fechas de los pedidos 
SELECT
    MIN(order_purchase_timestamp) AS primer_pedido,
    MAX(order_purchase_timestamp) AS ultimo_pedido
FROM orders;
