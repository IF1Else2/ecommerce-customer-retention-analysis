-- ============================================================
-- 03_add_constraints.sql
-- Se añaden las claves foraneas e índices después de cargar los datos.
-- ============================================================

--  Relaciones principales 

ALTER TABLE orders
    ADD CONSTRAINT fk_orders_customer
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id);

ALTER TABLE order_items
    ADD CONSTRAINT fk_items_order
    FOREIGN KEY (order_id) REFERENCES orders (order_id);

ALTER TABLE order_items
    ADD CONSTRAINT fk_items_product
    FOREIGN KEY (product_id) REFERENCES products (product_id);

ALTER TABLE order_items
    ADD CONSTRAINT fk_items_seller
    FOREIGN KEY (seller_id) REFERENCES sellers (seller_id);

ALTER TABLE order_payments
    ADD CONSTRAINT fk_payments_order
    FOREIGN KEY (order_id) REFERENCES orders (order_id);

ALTER TABLE order_reviews
    ADD CONSTRAINT fk_reviews_order
    FOREIGN KEY (order_id) REFERENCES orders (order_id);

-- Hay categorías en products que no están en product_category_translation.
-- Por eso, dejo la FK comentada (si la activas, falla).

-- ALTER TABLE products
--     ADD CONSTRAINT fk_products_category
--     FOREIGN KEY (product_category_name)
--     REFERENCES product_category_translation (product_category_name);

--  Indices utiles 
CREATE INDEX idx_orders_customer  ON orders (customer_id);
CREATE INDEX idx_customers_unique ON customers (customer_unique_id);  -- clave para recompra
CREATE INDEX idx_items_order      ON order_items (order_id);
CREATE INDEX idx_payments_order   ON order_payments (order_id);
CREATE INDEX idx_reviews_order    ON order_reviews (order_id);
