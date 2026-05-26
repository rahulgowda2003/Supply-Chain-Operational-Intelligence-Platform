--customer segmentation
WITH customer_sales AS (

SELECT
customer_id,
SUM(sales) AS total_sales
FROM gold.fact_orders_cleaned_v2
GROUP BY customer_id
)

SELECT
CASE
    WHEN total_sales >= 5000 THEN 'High Value'
    WHEN total_sales >= 2000 THEN 'Medium Value'
    ELSE 'Low Value'
END AS customer_segment,
COUNT(*) AS customers,
SUM(total_sales) AS revenue
FROM customer_sales
GROUP BY
CASE
    WHEN total_sales >= 5000 THEN 'High Value'
    WHEN total_sales >= 2000 THEN 'Medium Value'
    ELSE 'Low Value'
END
ORDER BY revenue DESC;