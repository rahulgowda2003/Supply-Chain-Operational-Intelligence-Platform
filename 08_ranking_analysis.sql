--top 20 products
SELECT TOP 20
p.product_name,
SUM(CAST(f.sales AS DECIMAL(18,2))) AS revenue,
SUM(CAST(f.order_profit_per_order AS DECIMAL(18,2))) AS profit,
SUM(CAST(f.order_item_quantity AS BIGINT)) AS quantity_sold
FROM gold.fact_orders_cleaned_v2 f
JOIN gold.dim_products p
ON f.product_card_id = p.product_card_id
GROUP BY p.product_name
ORDER BY revenue DESC;


--bottom 20 products
SELECT TOP 20
p.product_name,
SUM(f.sales) AS revenue,
SUM(f.order_profit_per_order) AS profit
FROM gold.fact_orders_cleaned_v2 f
JOIN gold.dim_products p
ON f.product_card_id = p.product_card_id
GROUP BY p.product_name
ORDER BY revenue ASC;


--loss making products
SELECT
p.product_name,
SUM(f.sales) AS revenue,
SUM(CAST(f.order_item_quantity AS BIGINT)) AS quantity_sold,
SUM(f.order_profit_per_order) AS profit,
ROUND(SUM(f.order_profit_per_order) * 100.0 /
      NULLIF(SUM(f.sales),0),
      2
     ) AS profit_margin_pct
FROM gold.fact_orders_cleaned_v2 f
JOIN gold.dim_products p
ON f.product_card_id = p.product_card_id
GROUP BY p.product_name
HAVING SUM(f.order_profit_per_order) < 0
ORDER BY profit;


--top 20 customers
SELECT TOP 20
c.customer_id,
SUM(f.sales) AS revenue,
SUM(f.order_profit_per_order) AS profit,
COUNT(DISTINCT f.order_id) AS orders
FROM gold.fact_orders_cleaned_v2 f
JOIN gold.dim_customers c
ON f.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY revenue DESC;