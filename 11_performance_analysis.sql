--shipping performance
SELECT
shipping_mode,
COUNT(*) AS orders,
ROUND(AVG(DATEDIFF(DAY, order_date, shipping_date)),
      2
     ) AS avg_shipping_days,
SUM(sales) AS revenue
FROM gold.fact_orders_cleaned_v2
WHERE date_quality_flag = 'valid'
GROUP BY shipping_mode
ORDER BY revenue DESC;


--delivery status analysis
SELECT
delivery_status,
COUNT(*) AS orders,
SUM(sales) AS revenue
FROM gold.fact_orders_cleaned_v2
GROUP BY delivery_status
ORDER BY revenue DESC;


--late delivery rate by shipping
SELECT
shipping_mode,
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
          END) * 100.0 / COUNT(*),
      2
     ) AS late_delivery_pct
FROM gold.fact_orders_cleaned_v2
GROUP BY shipping_mode
ORDER BY late_delivery_pct DESC;


--category profitability
SELECT
p.category_name,
SUM(f.sales) AS revenue,
SUM(f.order_profit_per_order) AS profit,
ROUND(SUM(f.order_profit_per_order) * 100.0 /
      NULLIF(SUM(f.sales),0),
      2
     ) AS profit_margin_pct
FROM gold.fact_orders_cleaned_v2 f
JOIN gold.dim_products p
ON f.product_card_id = p.product_card_id
GROUP BY p.category_name
ORDER BY profit_margin_pct DESC;