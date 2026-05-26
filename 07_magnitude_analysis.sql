--revenue by market
SELECT
market,
SUM(sales) AS revenue,
SUM(order_profit_per_order) AS profit,
COUNT(DISTINCT order_id) AS orders
FROM gold.fact_orders_cleaned_v2
GROUP BY market
ORDER BY revenue DESC;


--revenue by country
SELECT
order_country,
SUM(sales) AS revenue,
SUM(order_profit_per_order) AS profit,
COUNT(DISTINCT order_id) AS orders
FROM gold.fact_orders_cleaned_v2
GROUP BY order_country
ORDER BY revenue DESC;


--revenue by customer segment
SELECT
c.customer_segment,
SUM(f.sales) AS revenue,
SUM(f.order_profit_per_order) AS profit,
COUNT(DISTINCT f.customer_id) AS customers
FROM gold.fact_orders_cleaned_v2 f
JOIN gold.dim_customers c
ON f.customer_id = c.customer_id
GROUP BY c.customer_segment
ORDER BY revenue DESC;


--revenue by category
SELECT
p.category_name,
SUM(f.sales) AS revenue,
SUM(f.order_profit_per_order) AS profit,
COUNT(DISTINCT f.order_id) AS orders
FROM gold.fact_orders_cleaned_v2 f
JOIN gold.dim_products p
ON f.product_card_id = p.product_card_id
GROUP BY p.category_name
ORDER BY revenue DESC;


--revenue by department
SELECT
p.department_name,
SUM(f.sales) AS revenue,
SUM(f.order_profit_per_order) AS profit
FROM gold.fact_orders_cleaned_v2 f
JOIN gold.dim_products p
ON f.product_card_id = p.product_card_id
GROUP BY p.department_name
ORDER BY revenue DESC;