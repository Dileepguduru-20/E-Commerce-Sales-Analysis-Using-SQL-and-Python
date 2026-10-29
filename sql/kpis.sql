-- ================================================================
-- KEY PERFORMANCE INDICATORS (KPIs)
-- ================================================================
-- This script calculates essential business metrics:
-- 1. GMV (Gross Merchandise Value / Total Revenue)
-- 2. Total Orders
-- 3. AOV (Average Order Value)
-- 4. Conversion metrics
-- ================================================================

USE ecommerce;

-- ================================================================
-- KPI 1: TOTAL REVENUE (GMV - Gross Merchandise Value)
-- ================================================================
SELECT 
    ROUND(SUM(payment_value), 2) AS total_revenue_gmv
FROM payments;

-- ================================================================
-- KPI 2: TOTAL ORDERS
-- ================================================================
SELECT 
    COUNT(DISTINCT order_id) AS total_orders
FROM orders;

-- ================================================================
-- KPI 3: AVERAGE ORDER VALUE (AOV)
-- ================================================================
SELECT 
    ROUND(SUM(payment_value) / COUNT(DISTINCT o.order_id), 2) AS average_order_value_aov
FROM orders o
JOIN payments p ON o.order_id = p.order_id;

-- ================================================================
-- KPI 4: REVENUE BY CATEGORY
-- ================================================================
SELECT 
    UPPER(pr.product_category) AS category,
    ROUND(SUM(p.payment_value), 2) AS revenue,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(AVG(p.payment_value), 2) AS avg_order_value
FROM products pr
JOIN order_items oi ON pr.product_id = oi.product_id
JOIN payments p ON p.order_id = oi.order_id
JOIN orders o ON o.order_id = oi.order_id
WHERE pr.product_category IS NOT NULL
GROUP BY pr.product_category
ORDER BY revenue DESC
LIMIT 10;

-- ================================================================
-- KPI 5: REVENUE BY STATE (Geographic Performance)
-- ================================================================
SELECT 
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(p.payment_value), 2) AS total_revenue,
    ROUND(AVG(p.payment_value), 2) AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC;

-- ================================================================
-- KPI 6: MONTHLY REVENUE TREND
-- ================================================================
SELECT 
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(SUM(p.payment_value), 2) AS revenue
FROM orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY month
ORDER BY month;

-- ================================================================
-- KPI 7: PAYMENT METHOD DISTRIBUTION
-- ================================================================
SELECT 
    payment_type,
    COUNT(*) AS count,
    ROUND(SUM(payment_value), 2) AS total_value,
    ROUND(AVG(payment_value), 2) AS avg_value,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM payments), 2) AS percentage
FROM payments
GROUP BY payment_type
ORDER BY total_value DESC;

-- ================================================================
-- KPI 8: DELIVERY PERFORMANCE
-- ================================================================
SELECT 
    COUNT(*) AS total_delivered_orders,
    ROUND(AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)), 2) AS avg_delivery_days,
    ROUND(AVG(DATEDIFF(order_estimated_delivery_date, order_purchase_timestamp)), 2) AS avg_estimated_days,
    SUM(CASE 
        WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 1 
        ELSE 0 
    END) * 100.0 / COUNT(*) AS on_time_delivery_rate
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

-- ================================================================
-- KPI 9: TOP PERFORMING SELLERS
-- ================================================================
SELECT 
    s.seller_id,
    s.seller_city,
    s.seller_state,
    COUNT(DISTINCT oi.order_id) AS orders,
    ROUND(SUM(p.payment_value), 2) AS revenue
FROM sellers s
JOIN order_items oi ON s.seller_id = oi.seller_id
JOIN payments p ON oi.order_id = p.order_id
GROUP BY s.seller_id, s.seller_city, s.seller_state
ORDER BY revenue DESC
LIMIT 20;

-- ================================================================
-- KPI 10: CUSTOMER ORDER FREQUENCY
-- ================================================================
SELECT 
    CASE 
        WHEN order_count = 1 THEN '1 order'
        WHEN order_count = 2 THEN '2 orders'
        WHEN order_count >= 3 THEN '3+ orders'
    END AS customer_segment,
    COUNT(*) AS customers,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(DISTINCT customer_id) FROM orders), 2) AS percentage
FROM (
    SELECT 
        customer_id,
        COUNT(DISTINCT order_id) AS order_count
    FROM orders
    GROUP BY customer_id
) AS customer_orders
GROUP BY customer_segment
ORDER BY customer_segment;
