
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;


-- ===========================================================
-- FIX DATATYPES FOR ID COLUMNS
-- ===========================================================

ALTER TABLE products MODIFY product_id VARCHAR(255);
ALTER TABLE sellers MODIFY seller_id VARCHAR(255);
ALTER TABLE orders MODIFY order_id VARCHAR(255);

ALTER TABLE order_items 
    MODIFY order_id VARCHAR(255), 
    MODIFY product_id VARCHAR(255), 
    MODIFY seller_id VARCHAR(255);

ALTER TABLE payments MODIFY order_id VARCHAR(255);

-- ===========================================================
-- ADD PRIMARY & UNIQUE KEYS
-- ===========================================================

ALTER TABLE customers 
    ADD PRIMARY KEY (customer_id);

ALTER TABLE products 
    ADD UNIQUE KEY idx_product_id (product_id);

ALTER TABLE sellers 
    ADD UNIQUE KEY idx_seller_id (seller_id);

ALTER TABLE orders 
    ADD PRIMARY KEY (order_id);

ALTER TABLE order_items
    ADD PRIMARY KEY (order_id, order_item_id);

-- ===========================================================
-- ADD FOREIGN KEY RELATIONSHIPS
-- ===========================================================

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customer
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE order_items
ADD CONSTRAINT fk_orderitems_order
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
    ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT fk_orderitems_product
    FOREIGN KEY (product_id) REFERENCES products(product_id)
    ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT fk_orderitems_seller
    FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
    ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE payments
ADD CONSTRAINT fk_payments_order
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
    ON UPDATE CASCADE ON DELETE CASCADE;

-- ===========================================================
-- VERIFY RELATIONSHIPS 
-- ===========================================================

-- Run this query to check all foreign key relationships 
-- established successfully in the ecommerce database.

SELECT 
    TABLE_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'ecommerce'
  AND REFERENCED_TABLE_NAME IS NOT NULL;


-- ===========================================================
-- VERIFY Tables
-- ===========================================================

DESCRIBE customers;
DESCRIBE orders;
DESCRIBE order_items;
DESCRIBE payments;
