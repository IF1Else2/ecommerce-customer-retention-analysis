-- ============================================================
-- 01_create_tables.sql
-- ============================================================

DROP TABLE IF EXISTS order_reviews CASCADE;
DROP TABLE IF EXISTS order_payments CASCADE;
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS sellers CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS geolocation CASCADE;
DROP TABLE IF EXISTS product_category_translation CASCADE;

-- Tablas "padre"  

CREATE TABLE customers (
    customer_id              VARCHAR(50) PRIMARY KEY,
    customer_unique_id       VARCHAR(50) NOT NULL,   
    customer_zip_code_prefix VARCHAR(10),
    customer_city            VARCHAR(100),
    customer_state           VARCHAR(5)
);

CREATE TABLE sellers (
    seller_id              VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix VARCHAR(10),
    seller_city            VARCHAR(100),
    seller_state           VARCHAR(5)
);

CREATE TABLE products (
    product_id                 VARCHAR(50) PRIMARY KEY,
    product_category_name      VARCHAR(100),  
    product_name_length        INTEGER,        
    product_description_length INTEGER,
    product_photos_qty         INTEGER,
    product_weight_g           INTEGER,
    product_length_cm          INTEGER,
    product_height_cm          INTEGER,
    product_width_cm           INTEGER
);

CREATE TABLE product_category_translation (
    product_category_name         VARCHAR(100) PRIMARY KEY,
    product_category_name_english VARCHAR(100)
);

CREATE TABLE geolocation (
    geolocation_zip_code_prefix VARCHAR(10),        
    geolocation_lat             DOUBLE PRECISION,
    geolocation_lng             DOUBLE PRECISION,
    geolocation_city            VARCHAR(100),
    geolocation_state           VARCHAR(5)
);

-- Tabla central 

CREATE TABLE orders (
    order_id                      VARCHAR(50) PRIMARY KEY,
    customer_id                   VARCHAR(50) NOT NULL,
    order_status                  VARCHAR(20),
    order_purchase_timestamp      TIMESTAMP,
    order_approved_at             TIMESTAMP,
    order_delivered_carrier_date  TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

-- Tablas "hijas" 

CREATE TABLE order_items (
    order_id            VARCHAR(50) NOT NULL,
    order_item_id       INTEGER     NOT NULL,   
    product_id          VARCHAR(50),
    seller_id           VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price               NUMERIC(10,2),
    freight_value       NUMERIC(10,2),
    PRIMARY KEY (order_id, order_item_id)
);

CREATE TABLE order_payments (
    order_id             VARCHAR(50) NOT NULL,
    payment_sequential   INTEGER     NOT NULL,
    payment_type         VARCHAR(20),
    payment_installments INTEGER,
    payment_value        NUMERIC(10,2),
    PRIMARY KEY (order_id, payment_sequential)
);

CREATE TABLE order_reviews (
    review_id               VARCHAR(50),   
    order_id                VARCHAR(50) NOT NULL,
    review_score            INTEGER,
    review_comment_title    TEXT,
    review_comment_message  TEXT,
    review_creation_date    TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);
