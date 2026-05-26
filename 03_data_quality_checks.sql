/**********************************
data quality validatioin
**********************************/


--record count
SELECT
    COUNT(*) AS total_records
FROM gold.fact_orders_cleaned_v2;


--validating the convertion
SELECT
MIN(order_date) first_order_date,
MAX(order_date) last_order_date,
MIN(shipping_date) first_shipping_date,
MIN(shipping_date) last_shipping_date
FROM gold.fact_orders

UNION ALL

SELECT
MIN(order_date) first_order_date,
MAX(order_date) last_order_date,
MIN(shipping_date) first_shipping_date,
MIN(shipping_date) last_shipping_date
FROM gold.fact_orders_cleaned_v2


--check the null values for order date and shipping date
SELECT
COUNT(*) order_date_null
FROM gold.fact_orders_cleaned_v2
WHERE order_date IS NULL

SELECT
COUNT(*) shipping_date_null
FROM gold.fact_orders_cleaned_v2
WHERE shipping_date IS NULL

--check the total records after transformation of dates
SELECT
COUNT(*) AS total_records
from gold.fact_orders_cleaned_v2

--Check for duplicates in order_id
WITH duplicates AS(
SELECT
order_id,
COUNT(*) AS duplicates_count
FROM GOLD.fact_orders_cleaned_v2
GROUP BY order_id
HAVING COUNT(*) > 1
)
SELECT
order_id,
duplicates_count,
COUNT(duplicates_count) OVER() AS total_duplicates,
MAX(duplicates_count) OVER() AS most_duplicates
FROM duplicates
--duplicates in this mean that multiple products in same order


--duplicate check in order_customer_id
WITH duplicates_ AS(
SELECT
order_customer_id,
COUNT(*) AS duplicates_count
FROM GOLD.fact_orders_cleaned_v2
GROUP BY order_customer_id
HAVING COUNT(*) > 1
)
SELECT
order_customer_id,
duplicates_count,
COUNT(duplicates_count) OVER() AS total_duplicates,
MAX(duplicates_count) OVER() AS most_duplicates
FROM duplicates_
--duplicates in this mean that the same customer appears multiple times because they bought multiple times.


--check primary key candidates i.e. what uniqely identifies a row
SELECT
COUNT(*) AS total_rows,
COUNT(DISTINCT order_item_id) AS unique_order_items
FROM gold.fact_orders_cleaned_v2;


--check negative sales
SELECT 
*
FROM gold.fact_orders_cleaned_v2
WHERE sales < 0;


--check negative profit
SELECT
COUNT(*) OVER() AS total_negative_orders,
SUM(order_profit_per_order) OVER() AS total_amt_negative_orders,
AVG(order_profit_per_order) OVER() AS avg_amt_negative_orders_per_order,
*
FROM gold.fact_orders_cleaned_v2
WHERE order_profit_per_order < 0;


--check duplicates in customer_id
SELECT
customer_id,
COUNT(*) AS customer_id_duplicates
FROM gold.fact_orders_cleaned_v2
GROUP BY customer_id
HAVING COUNT(*) > 1
--duplicates in this mean that the same customer appears multiple times because they bought multiple times.


--date logic checks
SELECT
MIN(DATEDIFF(DAY, shipping_date, order_date)) AS min_gap,
MAX(DATEDIFF(DAY, shipping_date, order_date)) AS max_gap
FROM gold.fact_orders_cleaned_v2
WHERE shipping_date < order_date

/********************
geography validation
********************/


--state corrupted check
SELECT 
DISTINCT order_state
FROM gold.fact_orders_cleaned_v2
WHERE order_state LIKE '%[^A-Za-z0-9 .''-]%'
ORDER BY order_state;


--country corrupted check
SELECT 
DISTINCT order_country
FROM gold.fact_orders_cleaned_v2
WHERE order_country LIKE '%[^A-Za-z0-9 .''-]%'
ORDER BY order_country;


--city corrupted check
SELECT 
DISTINCT order_city
FROM gold.fact_orders_cleaned_v2
WHERE order_city LIKE '%[^A-Za-z0-9 .''-]%'
ORDER BY order_city;

--dimension exploration
WITH dim AS (
SELECT
type,
market,
shipping_mode,
delivery_status,
order_status
FROM gold.fact_orders_cleaned_v2
)
SELECT 'Type' AS dimension_name, type AS dimension_value
FROM dim

UNION

SELECT 'Market', market
FROM dim

UNION

SELECT 'Shipping Mode', shipping_mode
FROM dim

UNION

SELECT 'Delivery Status', delivery_status
FROM dim

UNION

SELECT 'Order Status', order_status
FROM dim;


--check missing customers
SELECT
COUNT(*) AS missing_customers
FROM gold.fact_orders_cleaned_v2 f
LEFT JOIN gold.dim_customers c
ON f.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


--check missing products
SELECT
COUNT(*) AS missing_products
FROM gold.fact_orders_cleaned_v2 f
LEFT JOIN gold.dim_products p
ON f.product_card_id = p.product_card_id
WHERE p.product_card_id IS NULL;