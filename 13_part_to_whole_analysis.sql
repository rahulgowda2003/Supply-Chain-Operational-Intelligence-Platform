--part to whole analysis/ market revenue share
SELECT
market,
SUM(sales) AS revenue,
ROUND(SUM(sales) * 100.0/
      SUM(SUM(sales)) OVER(),
      2
     ) AS revenue_share_pct
FROM gold.fact_orders_cleaned_v2
GROUP BY market
ORDER BY revenue DESC;


--category contribution
SELECT
p.category_name,
SUM(f.sales) AS revenue,
ROUND(SUM(f.sales) * 100.0/
      SUM(SUM(f.sales)) OVER(),
      2
     ) AS revenue_share_pct
FROM gold.fact_orders_cleaned_v2 f
JOIN gold.dim_products p
ON f.product_card_id = p.product_card_id
GROUP BY p.category_name
ORDER BY revenue DESC;