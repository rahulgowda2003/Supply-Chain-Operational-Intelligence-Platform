/******************************************************
initial data type conversion
******************************************************/


SELECT
type,
--CAST() fails if one bad value exists and TRY_CAST() returns "NULL" instead of crashing
TRY_CAST(order_id AS INT) AS order_id,
TRY_CAST(order_customer_id AS INT) AS order_customer_id,
TRY_CAST(order_item_id AS INT) AS order_item_id,
TRY_CAST(order_date AS DATETIME) AS order_date,
TRY_CAST(shipping_date AS DATETIME) AS shipping_date,
order_city,
order_country,
order_region,
order_state,
market,
TRY_CAST(customer_id AS INT) AS customer_id,
TRY_CAST(product_card_id AS INT) AS product_card_id,
TRY_CAST(sales AS DECIMAL(12,2)) AS sales,
TRY_CAST(benefit_per_order AS DECIMAL(12,2)) AS benefit_per_order,
TRY_CAST(order_item_discount AS DECIMAL(12,2)) AS order_item_discount,
TRY_CAST(order_item_discount_rate AS DECIMAL(12,2)) AS order_item_discount_rate,
TRY_CAST(order_item_product_price AS DECIMAL(12,2)) AS order_item_product_price,
TRY_CAST(order_item_profit_ratio AS DECIMAL(12,2)) AS order_item_profit_ratio,
TRY_CAST(order_profit_per_order AS DECIMAL(12,2)) AS order_profit_per_order,
TRY_CAST(order_item_quantity AS INT) AS order_item_quantity,
TRY_CAST(order_item_total AS DECIMAL(12,2)) AS order_item_total,
order_status,
shipping_mode,
delivery_status,
TRY_CAST(days_for_shipping_real AS INT) AS days_for_shipping_real,
TRY_CAST(days_for_shipment_scheduled AS INT) AS days_for_shipment_scheduled,
TRY_CAST(late_delivery_risk AS INT) AS late_delivery_risk

INTO gold.fact_orders_cleaned
FROM gold.fact_orders;


/******************************************************************************************
As the inconsistencies look time series data from excel, converting them into actual
date and time will lead to fill those values with real date. It is better than removing
39% of the data. 
Excel stores the date starting from January, 01, 1900.
******************************************************************************************/


SELECT
type,
TRY_CAST(order_id AS INT) AS order_id,
TRY_CAST(order_customer_id AS INT) AS order_customer_id,
TRY_CAST(order_item_id AS INT) AS order_item_id,
--order_date fix
CASE
    --if already a valid datetime string
    WHEN TRY_CAST(order_date AS DATETIME) IS NOT NULL
    THEN TRY_CAST(order_date AS DATETIME)
    --if excel serial numeric date
    WHEN TRY_CAST(order_date AS FLOAT) IS NOT NULL
    THEN DATEADD(
                DAY,
                TRY_CAST(order_date AS FLOAT),
                '1899-12-30'
                )
    ELSE NULL
END AS order_date,
--shipping_date fx
CASE
    -- If already valid datetime string
    WHEN TRY_CAST(shipping_date AS DATETIME) IS NOT NULL
    THEN TRY_CAST(shipping_date AS DATETIME)
    -- If Excel serial numeric date
    WHEN TRY_CAST(shipping_date AS FLOAT) IS NOT NULL
    THEN DATEADD(
                DAY,
                TRY_CAST(shipping_date AS FLOAT),
                '1899-12-30'
             )
    ELSE NULL
END AS shipping_date,

order_city,
order_country,
order_region,
order_state,
market,
TRY_CAST(customer_id AS INT) AS customer_id,
TRY_CAST(product_card_id AS INT) AS product_card_id,
TRY_CAST(sales AS DECIMAL(12,2)) AS sales,
TRY_CAST(benefit_per_order AS DECIMAL(12,2)) AS benefit_per_order,
TRY_CAST(order_item_discount AS DECIMAL(12,2)) AS order_item_discount,
TRY_CAST(order_item_discount_rate AS DECIMAL(12,2)) AS order_item_discount_rate,
TRY_CAST(order_item_product_price AS DECIMAL(12,2)) AS order_item_product_price,
TRY_CAST(order_item_profit_ratio AS DECIMAL(12,2)) AS order_item_profit_ratio,
TRY_CAST(order_profit_per_order AS DECIMAL(12,2)) AS order_profit_per_order,
TRY_CAST(order_item_quantity AS INT) AS order_item_quantity,
TRY_CAST(order_item_total AS DECIMAL(12,2)) AS order_item_total,
order_status,
shipping_mode,
delivery_status,
TRY_CAST(days_for_shipping_real AS INT) AS days_for_shipping_real,
TRY_CAST(days_for_shipment_scheduled AS INT) AS days_for_shipment_scheduled,
TRY_CAST(late_delivery_risk AS INT) AS late_delivery_risk

INTO gold.fact_orders_cleaned_v2
FROM gold.fact_orders;

/***********************************************************
geography fix
***********************************************************/

/* 
================================
order_city cleaning
================================
*/


--distinct cities count
SELECT
COUNT(DISTINCT order_city) AS total_cities
FROM gold.fact_orders_cleaned_v2;


--inconsistent distinct cities count
SELECT
COUNT(DISTINCT order_city) AS corrupted_cities
FROM gold.fact_orders_cleaned_v2
WHERE order_city LIKE '%[^A-Za-z0-9 .''-]%';


--list of corrupted cities
SELECT 
DISTINCT order_city
FROM gold.fact_orders_cleaned_v2
WHERE order_city LIKE '%[^A-Za-z0-9 .''-]%'
ORDER BY order_city;

--how many occurances corrupted cities has
SELECT
order_city,
COUNT(*) AS occurrences
FROM gold.fact_orders_cleaned_v2
WHERE order_city LIKE '%[^A-Za-z0-9 .''-]%'
GROUP BY order_city
ORDER BY occurrences DESC;


--verify mapped corrected cities name
SELECT TOP 20 *
FROM gold.city_corrections;


--update the fact_orders_cleaned_v2
UPDATE f
SET f.order_city = c.corrected_city
FROM gold.fact_orders_cleaned_v2 f
JOIN gold.city_corrections c
ON f.order_city = c.bad_city;


--verify the update
SELECT DISTINCT order_city
FROM gold.fact_orders_cleaned_v2
WHERE order_city LIKE '%[^A-Za-z0-9 .''-]%'
ORDER BY order_city;

/* 
================================
order_state cleaning
================================
*/

--find corrupted state
SELECT DISTINCT order_state
FROM gold.fact_orders_cleaned_v2
WHERE order_state LIKE '%[^A-Za-z0-9 .''-]%'
ORDER BY order_state;


--count corrupted state
SELECT
COUNT(DISTINCT order_state) AS corrupted_states
FROM gold.fact_orders_cleaned_v2
WHERE order_state LIKE '%[^A-Za-z0-9 .''-]%';


--update the fact_orders_cleaned_v2
UPDATE f
SET f.order_state = c.corrected_state
FROM gold.fact_orders_cleaned_v2 f
JOIN gold.state_corrections c
ON f.order_state = c.bad_state;


--verify the update
SELECT DISTINCT order_state
FROM gold.fact_orders_cleaned_v2
WHERE order_state LIKE '%[^A-Za-z0-9 .''-]%'
ORDER BY order_state;

/* 
================================
order_country cleaning
================================
*/


--find corrupted country
SELECT DISTINCT order_country
FROM gold.fact_orders_cleaned_v2
WHERE order_country LIKE '%[^A-Za-z0-9 .''-]%'
ORDER BY order_country;


--update the fact_orders_cleaned_v2
UPDATE f
SET f.order_country = c.corrected_country
FROM gold.fact_orders_cleaned_v2 f
JOIN gold.country_corrections c
ON f.order_country = c.bad_country;


--verify the update
SELECT DISTINCT order_country
FROM gold.fact_orders_cleaned_v2
WHERE order_country LIKE '%[^A-Za-z0-9 .''-]%'
ORDER BY order_country;

/************************************************
date quality flag
************************************************/

/*
===============================
date logic
===============================
*/


--check date logic
SELECT
*
FROM gold.fact_orders_cleaned_v2
WHERE shipping_date < order_date


/*
as the date is not the convertion problem and it is source issue
flagging the date is better option rater to delete the 18.24% data
*/


ALTER TABLE gold.fact_orders_cleaned_v2
ADD date_quality_flag VARCHAR(20);


--update it as valid and invalid
UPDATE gold.fact_orders_cleaned_v2
SET date_quality_flag =
    CASE
        WHEN shipping_date < order_date THEN 'invalid'
        ELSE 'valid'
    END;