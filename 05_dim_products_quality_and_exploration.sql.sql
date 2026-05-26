--total products
SELECT
COUNT(DISTINCT product_card_id) AS total_products
FROM gold.dim_products;


--total_product_value
SELECT
category_name,
SUM(product_price) AS total_product_value
FROM gold.dim_products
GROUP BY category_name

--duplicate products
SELECT
product_card_id,
category_name,
COUNT(*) AS duplicates
FROM gold.dim_products
GROUP BY product_card_id, category_name
HAVING COUNT(*) > 1;

--null checks
SELECT
SUM(CASE WHEN product_card_id IS NULL THEN 1 ELSE 0 END) AS product_id_nulls,
SUM(CASE WHEN category_name IS NULL THEN 1 ELSE 0 END) AS category_nulls,
SUM(CASE WHEN department_name IS NULL THEN 1 ELSE 0 END) AS department_nulls
FROM gold.dim_products;

--category distribution
SELECT
category_name,
COUNT(*) AS products
FROM gold.dim_products
GROUP BY category_name
ORDER BY products DESC;

--department distribution
SELECT
department_name,
COUNT(*) AS products
FROM gold.dim_products
GROUP BY department_name
ORDER BY products DESC;

--product status distribution
SELECT
product_status,
COUNT(*) AS products
FROM gold.dim_products
GROUP BY product_status
ORDER BY products DESC;

--missing products
SELECT
COUNT(*) AS missing_products
FROM gold.fact_orders_cleaned_v2 f
LEFT JOIN gold.dim_products p
ON f.product_card_id = p.product_card_id
WHERE p.product_card_id IS NULL;