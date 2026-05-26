/* 
===============================
dim_customers
===============================
*/


--total customers
SELECT
COUNT(DISTINCT customer_id) AS	total_customers
FROM gold.dim_customers


--duplicate customer id
SELECT
customer_id,
COUNT(*) AS duplicates
FROM gold.dim_customers
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC


--null check
SELECT
SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) customer_id_nulls,
SUM(CASE WHEN customer_segment IS NULL THEN 1 ELSE 0 END) segment_nulls,
SUM(CASE WHEN customer_country IS NULL THEN 1 ELSE 0 END) country_nulls
FROM gold.dim_customers;


--dimension exploration customer_segment
SELECT
customer_segment,
COUNT(*) AS customers
FROM gold.dim_customers
GROUP BY customer_segment
ORDER BY customers DESC


--customer_country
SELECT
customer_country,
COUNT(*) customers
FROM gold.dim_customers
GROUP BY customer_country
ORDER BY customers DESC;


--customer geography_state
SELECT
customer_state,
COUNT(*) AS customers
FROM gold.dim_customers
GROUP BY customer_state
ORDER BY customers DESC;


--customer_city
SELECT
customer_city,
COUNT(*) AS customers
FROM gold.dim_customers
GROUP BY customer_city
ORDER BY customers DESC;


--customer_segment %
SELECT
customer_segment,
COUNT(*) AS customers,
ROUND(
    COUNT(*)*100.0/ 
    SUM(COUNT(*)) OVER(), 
    2
    ) AS customers_percentage
FROM gold.dim_customers
GROUP BY customer_segment
ORDER BY customers DESC


--check missing customers
SELECT
COUNT(*) AS missing_customers
FROM gold.fact_orders_cleaned_v2 f
LEFT JOIN gold.dim_customers c
ON f.customer_id = c.customer_id
WHERE c.customer_id IS NULL;