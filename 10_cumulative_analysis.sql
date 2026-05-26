--cumulative analysis/ running revenue
SELECT
YEAR(order_date) AS order_year,
MONTH(order_date) AS order_month,
SUM(order_profit_per_order) AS monthly_profit,
SUM(sales) AS monthly_revenue,
SUM(SUM(sales)) OVER(ORDER BY
                            YEAR(order_date),
                            MONTH(order_date)
                    ) AS cumulative_revenue,
SUM(SUM(order_profit_per_order)) OVER(ORDER BY
                            YEAR(order_date),
                            MONTH(order_date)
                    ) AS cumulative_profit
FROM gold.fact_orders_cleaned_v2
WHERE date_quality_flag = 'valid'
GROUP BY
YEAR(order_date),
MONTH(order_date)
ORDER BY order_year, order_month;