-- ================================================================
-- COHORT ANALYSIS
-- ================================================================
-- Analyze customer behavior over time by grouping customers
-- based on their first purchase month
-- ================================================================

USE ecommerce;

-- ================================================================
-- Customer First Purchase Date
-- ================================================================
CREATE TEMPORARY TABLE customer_cohorts AS
SELECT 
    customer_id,
    MIN(DATE(order_purchase_timestamp)) AS first_purchase_date,
    DATE_FORMAT(MIN(order_purchase_timestamp), '%Y-%m') AS cohort_month
FROM orders
GROUP BY customer_id;

-- ================================================================
-- Cohort Analysis: Customer Retention by Month
-- ================================================================
SELECT 
    cc.cohort_month,
    COUNT(DISTINCT cc.customer_id) AS cohort_size,
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(DISTINCT o.customer_id) AS customers_returned,
    ROUND(COUNT(DISTINCT o.customer_id) * 100.0 / COUNT(DISTINCT cc.customer_id), 2) AS retention_rate
FROM customer_cohorts cc
LEFT JOIN orders o ON cc.customer_id = o.customer_id
GROUP BY cc.cohort_month, order_month
ORDER BY cc.cohort_month, order_month;

-- ================================================================
-- Cohort Analysis: Revenue by Cohort
-- ================================================================
SELECT 
    cc.cohort_month,
    COUNT(DISTINCT cc.customer_id) AS cohort_size,
    ROUND(SUM(p.payment_value), 2) AS total_revenue,
    ROUND(AVG(p.payment_value), 2) AS avg_order_value,
    ROUND(SUM(p.payment_value) / COUNT(DISTINCT cc.customer_id), 2) AS revenue_per_customer
FROM customer_cohorts cc
JOIN orders o ON cc.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY cc.cohort_month
ORDER BY cc.cohort_month;

-- ================================================================
-- Time to Second Purchase Analysis
-- ================================================================
WITH order_sequence AS (
    SELECT 
        customer_id,
        order_purchase_timestamp,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_purchase_timestamp) AS order_number
    FROM orders
)
SELECT 
    ROUND(AVG(DATEDIFF(second_order.order_purchase_timestamp, first_order.order_purchase_timestamp)), 2) AS avg_days_to_second_purchase,
    COUNT(DISTINCT second_order.customer_id) AS customers_with_repeat_purchase
FROM order_sequence first_order
JOIN order_sequence second_order 
    ON first_order.customer_id = second_order.customer_id
WHERE first_order.order_number = 1 
    AND second_order.order_number = 2;

-- ================================================================
-- Customer Lifetime Analysis
-- ================================================================
SELECT 
    DATEDIFF(MAX(order_purchase_timestamp), MIN(order_purchase_timestamp)) AS customer_lifetime_days,
    COUNT(DISTINCT customer_id) AS customer_count
FROM orders
GROUP BY customer_lifetime_days
ORDER BY customer_count DESC
LIMIT 20;
