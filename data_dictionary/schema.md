# E-Commerce Database Schema

## Overview
This database contains e-commerce transaction data from a Brazilian marketplace, covering orders placed between 2016-2018.

---

## Tables

### 1. **customers**
Customer information including location details.

| Column | Type | Description |
|--------|------|-------------|
| customer_id | VARCHAR(255) | Unique customer identifier (Primary Key) |
| customer_unique_id | VARCHAR(255) | Unique customer ID across all orders |
| customer_zip_code_prefix | INT | Customer postal code prefix |
| customer_city | VARCHAR(255) | Customer city |
| customer_state | VARCHAR(255) | Customer state (2-letter code) |

---

### 2. **orders**
Order transaction details and status tracking.

| Column | Type | Description |
|--------|------|-------------|
| order_id | VARCHAR(255) | Unique order identifier (Primary Key) |
| customer_id | VARCHAR(255) | Foreign Key to customers table |
| order_status | VARCHAR(255) | Order status (delivered, shipped, etc.) |
| order_purchase_timestamp | DATETIME | Order purchase date and time |
| order_approved_at | DATETIME | Order approval timestamp |
| order_delivered_carrier_date | DATETIME | Date handed to carrier |
| order_delivered_customer_date | DATETIME | Actual delivery date to customer |
| order_estimated_delivery_date | DATETIME | Estimated delivery date |

**Foreign Keys:**
- `customer_id` → customers(customer_id)

---

### 3. **order_items**
Individual items within each order.

| Column | Type | Description |
|--------|------|-------------|
| order_id | VARCHAR(255) | Foreign Key to orders table |
| order_item_id | INT | Item sequence number within order |
| product_id | VARCHAR(255) | Foreign Key to products table |
| seller_id | VARCHAR(255) | Foreign Key to sellers table |
| shipping_limit_date | DATETIME | Shipping deadline |
| price | FLOAT | Item price |
| freight_value | FLOAT | Shipping cost |

**Primary Key:** (order_id, order_item_id)

**Foreign Keys:**
- `order_id` → orders(order_id)
- `product_id` → products(product_id)
- `seller_id` → sellers(seller_id)

---

### 4. **products**
Product catalog with specifications.

| Column | Type | Description |
|--------|------|-------------|
| product_id | VARCHAR(255) | Unique product identifier |
| product_category | VARCHAR(255) | Product category name |
| product_name_length | FLOAT | Length of product name |
| product_description_length | FLOAT | Length of product description |
| product_photos_qty | FLOAT | Number of product photos |
| product_weight_g | FLOAT | Product weight in grams |
| product_length_cm | FLOAT | Product length in cm |
| product_height_cm | FLOAT | Product height in cm |
| product_width_cm | FLOAT | Product width in cm |

---

### 5. **sellers**
Seller information and location.

| Column | Type | Description |
|--------|------|-------------|
| seller_id | VARCHAR(255) | Unique seller identifier |
| seller_zip_code_prefix | INT | Seller postal code prefix |
| seller_city | VARCHAR(255) | Seller city |
| seller_state | VARCHAR(255) | Seller state (2-letter code) |

---

### 6. **payments**
Payment transaction details for orders.

| Column | Type | Description |
|--------|------|-------------|
| order_id | VARCHAR(255) | Foreign Key to orders table |
| payment_sequential | INT | Payment sequence number |
| payment_type | VARCHAR(255) | Payment method (credit_card, boleto, etc.) |
| payment_installments | INT | Number of installments |
| payment_value | FLOAT | Payment amount |

**Foreign Keys:**
- `order_id` → orders(order_id)

---

### 7. **geolocation**
Geographic coordinates for zip codes.

| Column | Type | Description |
|--------|------|-------------|
| geolocation_zip_code_prefix | INT | Postal code prefix |
| geolocation_lat | FLOAT | Latitude |
| geolocation_lng | FLOAT | Longitude |
| geolocation_city | VARCHAR(255) | City name |
| geolocation_state | VARCHAR(255) | State code |

---

## Entity Relationship Diagram

```
customers (1) ──→ (M) orders
                     ↓
                  (1:M)
                     ↓
              order_items (M) ──→ (1) products
                     ↓
                  (M:1)
                     ↓
                  sellers

orders (1) ──→ (M) payments
```

---

## Key Metrics Available

- **Total Revenue:** Sum of payment_value
- **Total Orders:** Count of distinct order_id
- **Average Order Value (AOV):** Total Revenue / Total Orders
- **Customer Lifetime Value:** Revenue per customer
- **Delivery Time:** order_delivered_customer_date - order_purchase_timestamp
- **On-Time Delivery Rate:** Percentage of orders delivered before estimated date
