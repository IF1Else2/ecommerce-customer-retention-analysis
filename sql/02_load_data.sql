-- ============================================================
-- 02_load_data.sql
-- Carga los 9 CSV con \copy.

-- Ejecutar: psql -U postgres -d olist -f 02_load_data.sql

-- Uso \copy (no COPY) porque lee los ficheros desde este PC.
-- COPY suele fallar por permisos al intentar leer desde el servidor.
-- Cada \copy va en una sola línea. Si mueves los CSV, cambia las rutas.
-- ============================================================

\copy customers FROM 'C:/Users/Usuario/Documents/Brazilian-dataset-ecommerce-proyecto/olist_brazilian_ecommerce_dataset/olist_customers_dataset.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');

\copy sellers FROM 'C:/Users/Usuario/Documents/Brazilian-dataset-ecommerce-proyecto/olist_brazilian_ecommerce_dataset/olist_sellers_dataset.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');

\copy products FROM 'C:/Users/Usuario/Documents/Brazilian-dataset-ecommerce-proyecto/olist_brazilian_ecommerce_dataset/olist_products_dataset.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');

\copy product_category_translation FROM 'C:/Users/Usuario/Documents/Brazilian-dataset-ecommerce-proyecto/olist_brazilian_ecommerce_dataset/product_category_name_translation.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');

\copy geolocation FROM 'C:/Users/Usuario/Documents/Brazilian-dataset-ecommerce-proyecto/olist_brazilian_ecommerce_dataset/olist_geolocation_dataset.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');

\copy orders FROM 'C:/Users/Usuario/Documents/Brazilian-dataset-ecommerce-proyecto/olist_brazilian_ecommerce_dataset/olist_orders_dataset.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');

\copy order_items FROM 'C:/Users/Usuario/Documents/Brazilian-dataset-ecommerce-proyecto/olist_brazilian_ecommerce_dataset/olist_order_items_dataset.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');

\copy order_payments FROM 'C:/Users/Usuario/Documents/Brazilian-dataset-ecommerce-proyecto/olist_brazilian_ecommerce_dataset/olist_order_payments_dataset.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');

\copy order_reviews FROM 'C:/Users/Usuario/Documents/Brazilian-dataset-ecommerce-proyecto/olist_brazilian_ecommerce_dataset/olist_order_reviews_dataset.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');
