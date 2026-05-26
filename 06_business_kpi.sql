/*
====================================
executive kpi's
====================================
*/

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
ROUND(AVG(sales),
        2
    ) AS avg_order_value,
ROUND(AVG(DATEDIFF(DAY, order_date,shipping_date)),
        2
    ) AS avg_shipping_days
FROM gold.fact_orders_cleaned_v2
WHERE date_quality_flag = 'valid';


--late delivery kpi
SELECT
COUNT(*) AS total_orders,
SUM(CASE
        WHEN late_delivery_risk = 1
        THEN 1
        ELSE 0
    END
   ) AS late_orders,
ROUND(SUM(CASE
              WHEN late_delivery_risk = 1
              THEN 1
              ELSE 0
           END
        ) * 100.0 /
        COUNT(*),
        2
    ) AS late_delivery_rate_pct
FROM gold.fact_orders_cleaned_v2;


--most profitable products
SELECT TOP 20
p.product_name,
SUM(f.order_profit_per_order) AS profit,
SUM(f.sales) AS revenue
FROM gold.fact_orders_cleaned_v2 f
JOIN gold.dim_products p
ON f.product_card_id = p.product_card_id
GROUP BY p.product_name
ORDER BY profit DESC;