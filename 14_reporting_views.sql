--view 1: executive summary dataset
CREATE VIEW gold.vw_executive_summary AS

SELECT
COUNT(DISTINCT order_id) AS total_orders,
COUNT(DISTINCT customer_id) AS total_customers,
COUNT(DISTINCT product_card_id) AS total_products,
SUM(sales) AS total_revenue,
SUM(order_profit_per_order) AS total_profit,
ROUND(SUM(order_profit_per_order) * 100.0 /
      NULLIF(SUM(sales),0),
      2
     ) AS profit_margin_pct,
ROUND(AVG(sales),2) AS avg_order_value
FROM gold.fact_orders_cleaned_v2;


--view 2: sales trend
CREATE VIEW gold.vw_sales_trend AS

SELECT
YEAR(order_date) AS order_year,
MONTH(order_date) AS order_month,
SUM(sales) AS revenue,
SUM(order_profit_per_order) AS profit,
COUNT(DISTINCT order_id) AS orders
FROM gold.fact_orders_cleaned_v2
WHERE date_quality_flag = 'valid'
GROUP BY
YEAR(order_date),
MONTH(order_date);


--view 3: customer analytics
CREATE VIEW gold.vw_customer_analytics AS

SELECT
c.customer_segment,
c.customer_country,
COUNT(DISTINCT f.customer_id) AS customers,
SUM(f.sales) AS revenue,
SUM(f.order_profit_per_order) AS profit
FROM gold.fact_orders_cleaned_v2 f
JOIN gold.dim_customers c
ON f.customer_id = c.customer_id
GROUP BY
c.customer_segment,
c.customer_country;


--view 4: product analysis
CREATE VIEW gold.vw_product_analytics AS

SELECT
p.product_name,
p.category_name,
p.department_name,
SUM(f.sales) AS revenue,
SUM(f.order_profit_per_order) AS profit,
SUM(CAST(f.order_item_quantity AS BIGINT)) AS quantity_sold
FROM gold.fact_orders_cleaned_v2 f
JOIN gold.dim_products p
ON f.product_card_id = p.product_card_id
GROUP BY
p.product_name,
p.category_name,
p.department_name;


--view 5: shipping analysis
CREATE VIEW gold.vw_shipping_analytics AS

SELECT
shipping_mode,
delivery_status,
market,
COUNT(*) AS orders,
SUM(sales) AS revenue,
AVG(DATEDIFF(DAY, order_date, shipping_date)) AS avg_shipping_days
FROM gold.fact_orders_cleaned_v2
WHERE date_quality_flag = 'valid'
GROUP BY
shipping_mode,
delivery_status,
market;