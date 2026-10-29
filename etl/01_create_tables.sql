-- ================================================================
-- E-COMMERCE DATABASE CREATION SCRIPT
-- ================================================================
-- This script creates the database and all necessary tables
-- for the e-commerce project using MySQL
-- ================================================================

CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Drop existing tables if they exist (to allow re-running)
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS sellers;
DROP TABLE IF EXISTS geolocation;

-- ================================================================
-- CREATE TABLES (Initial structure for CSV loading)
-- ================================================================

-- Table: customers
CREATE TABLE IF NOT EXISTS customers (
    customer_id TEXT,
    customer_unique_id TEXT,
    customer_zip_code_prefix INT,
    customer_city TEXT,
    customer_state TEXT
);

-- Table: orders
CREATE TABLE IF NOT EXISTS orders (
    order_id TEXT,
    customer_id TEXT,
    order_status TEXT,
    order_purchase_timestamp TEXT,
    order_approved_at TEXT,
    order_delivered_carrier_date TEXT,
    order_delivered_customer_date TEXT,
    order_estimated_delivery_date TEXT
);

-- Table: sellers
CREATE TABLE IF NOT EXISTS sellers (
    seller_id TEXT,
    seller_zip_code_prefix INT,
    seller_city TEXT,
    seller_state TEXT
);

-- Table: products
CREATE TABLE IF NOT EXISTS products (
    product_id TEXT,
    product_category TEXT,
    product_name_length FLOAT,
    product_description_length FLOAT,
    product_photos_qty FLOAT,
    product_weight_g FLOAT,
    product_length_cm FLOAT,
    product_height_cm FLOAT,
    product_width_cm FLOAT
);

-- Table: geolocation
CREATE TABLE IF NOT EXISTS geolocation (
    geolocation_zip_code_prefix INT,
    geolocation_lat FLOAT,
    geolocation_lng FLOAT,
    geolocation_city TEXT,
    geolocation_state TEXT
);

-- Table: payments
CREATE TABLE IF NOT EXISTS payments (
    order_id TEXT,
    payment_sequential INT,
    payment_type TEXT,
    payment_installments INT,
    payment_value FLOAT
);

-- Table: order_items
CREATE TABLE IF NOT EXISTS order_items (
    order_id TEXT,
    order_item_id INT,
    product_id TEXT,
    seller_id TEXT,
    shipping_limit_date TEXT,
    price FLOAT,
    freight_value FLOAT
);

-- ================================================================
-- VERIFICATION
-- ================================================================

-- Show all created tables
SHOW TABLES;

-- Verify table structures
DESCRIBE customers;
DESCRIBE orders;
DESCRIBE sellers;
DESCRIBE products;
DESCRIBE geolocation;
DESCRIBE payments;
DESCRIBE order_items;
