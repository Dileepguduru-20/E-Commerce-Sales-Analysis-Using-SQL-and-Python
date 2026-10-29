-- ================================================================
-- RFM ANALYSIS (Recency, Frequency, Monetary)
-- ================================================================
-- Customer segmentation based on:
-- - Recency: How recently did customer make a purchase?
-- - Frequency: How often do they purchase?
-- - Monetary: How much do they spend?
-- ================================================================

USE ecommerce;

-- ================================================================
-- Calculate RFM Metrics
-- ================================================================
WITH rfm_calc AS (
    SELECT 
        c.customer_id,
        c.customer_state,
        DATEDIFF('2018-09-03', MAX(o.order_purchase_timestamp)) AS recency,
        COUNT(DISTINCT o.order_id) AS frequency,
        ROUND(SUM(p.payment_value), 2) AS monetary
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN payments p ON o.order_id = p.order_id
    GROUP BY c.customer_id, c.customer_state
),

-- ================================================================
-- Assign RFM Scores (1-5 scale)
-- ================================================================
rfm_scores AS (
    SELECT 
        *,
        NTILE(5) OVER (ORDER BY recency DESC) AS recency_score,
        NTILE(5) OVER (ORDER BY frequency) AS frequency_score,
        NTILE(5) OVER (ORDER BY monetary) AS monetary_score
    FROM rfm_calc
),

-- ================================================================
-- Calculate Combined RFM Score
-- ================================================================
rfm_combined AS (
    SELECT 
        *,
        CONCAT(recency_score, frequency_score, monetary_score) AS rfm_score,
        (recency_score + frequency_score + monetary_score) / 3.0 AS rfm_avg_score
    FROM rfm_scores
)

-- ================================================================
-- Customer Segmentation Based on RFM
-- ================================================================
SELECT 
    customer_id,
    customer_state,
    recency,
    frequency,
    monetary,
    rfm_score,
    ROUND(rfm_avg_score, 2) AS rfm_avg_score,
    CASE 
        WHEN rfm_avg_score >= 4.5 THEN 'Champions'
        WHEN rfm_avg_score >= 4.0 THEN 'Loyal Customers'
        WHEN rfm_avg_score >= 3.5 THEN 'Potential Loyalists'
        WHEN rfm_avg_score >= 3.0 THEN 'Recent Customers'
        WHEN rfm_avg_score >= 2.5 THEN 'Promising'
        WHEN rfm_avg_score >= 2.0 THEN 'Customers Needing Attention'
        WHEN rfm_avg_score >= 1.5 THEN 'About To Sleep'
        ELSE 'At Risk'
    END AS customer_segment
FROM rfm_combined
ORDER BY rfm_avg_score DESC;

-- ================================================================
-- RFM Segment Distribution
-- ================================================================
WITH rfm_calc AS (
    SELECT 
        c.customer_id,
        DATEDIFF('2018-09-03', MAX(o.order_purchase_timestamp)) AS recency,
        COUNT(DISTINCT o.order_id) AS frequency,
        ROUND(SUM(p.payment_value), 2) AS monetary
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN payments p ON o.order_id = p.order_id
    GROUP BY c.customer_id
),
rfm_scores AS (
    SELECT 
        *,
        NTILE(5) OVER (ORDER BY recency DESC) AS recency_score,
        NTILE(5) OVER (ORDER BY frequency) AS frequency_score,
        NTILE(5) OVER (ORDER BY monetary) AS monetary_score
    FROM rfm_calc
),
rfm_segments AS (
    SELECT 
        *,
        (recency_score + frequency_score + monetary_score) / 3.0 AS rfm_avg_score,
        CASE 
            WHEN (recency_score + frequency_score + monetary_score) / 3.0 >= 4.5 THEN 'Champions'
            WHEN (recency_score + frequency_score + monetary_score) / 3.0 >= 4.0 THEN 'Loyal Customers'
            WHEN (recency_score + frequency_score + monetary_score) / 3.0 >= 3.5 THEN 'Potential Loyalists'
            WHEN (recency_score + frequency_score + monetary_score) / 3.0 >= 3.0 THEN 'Recent Customers'
            WHEN (recency_score + frequency_score + monetary_score) / 3.0 >= 2.5 THEN 'Promising'
            WHEN (recency_score + frequency_score + monetary_score) / 3.0 >= 2.0 THEN 'Customers Needing Attention'
            WHEN (recency_score + frequency_score + monetary_score) / 3.0 >= 1.5 THEN 'About To Sleep'
            ELSE 'At Risk'
        END AS customer_segment
    FROM rfm_scores
)

SELECT 
    customer_segment,
    COUNT(*) AS customer_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM rfm_segments), 2) AS percentage,
    ROUND(AVG(recency), 2) AS avg_recency_days,
    ROUND(AVG(frequency), 2) AS avg_frequency,
    ROUND(AVG(monetary), 2) AS avg_monetary_value
FROM rfm_segments
GROUP BY customer_segment
ORDER BY avg_monetary_value DESC;
