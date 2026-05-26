--monthly revenue trend
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
MONTH(order_date)
ORDER BY order_year, order_month;


--revenue by year
SELECT
YEAR(order_date) AS order_year,
SUM(sales) AS revenue,
SUM(order_profit_per_order) AS profit,
COUNT(DISTINCT order_id) AS orders
FROM gold.fact_orders_cleaned_v2
WHERE date_quality_flag = 'valid'
GROUP BY YEAR(order_date)
ORDER BY order_year;


--year on year/ change over time
SELECT
YEAR(order_date) AS order_year,
SUM(sales) AS revenue,
LAG(SUM(sales)) OVER(ORDER BY YEAR(order_date)) AS previous_year_revenue,
ROUND((
        SUM(sales) - 
        LAG(SUM(sales)) OVER(ORDER BY YEAR(order_date))) * 100.0 /
        NULLIF(LAG(SUM(sales)) OVER(ORDER BY YEAR(order_date)), 0),
        2
    ) AS revenue_growth_pct
FROM gold.fact_orders_cleaned_v2
WHERE date_quality_flag = 'VALID'
GROUP BY YEAR(order_date)
ORDER BY order_year;