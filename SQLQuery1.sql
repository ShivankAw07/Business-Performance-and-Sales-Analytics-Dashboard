--Kpi overview
SELECT 
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(discount),2) AS avg_discount,
    COUNT(DISTINCT customer_name) AS customers
FROM Super_Store_data_cleaned;

-- regional sales and profit

SELECT 
    region,
    ROUND(SUM(sales),2) AS sales,
    ROUND(SUM(profit),2) AS profit
FROM Super_Store_data_cleaned
GROUP BY region
ORDER BY profit DESC;

-- Category & Sub-Category Profitability


SELECT 
    category,
    sub_category,
    ROUND(SUM(sales),2) AS sales,
    ROUND(SUM(profit),2) AS profit
FROM Super_Store_data_cleaned
GROUP BY category, sub_category
ORDER BY profit;

--Discount vs Profit Impact

SELECT 
    discount,
    ROUND(AVG(profit),2) AS avg_profit
FROM Super_Store_data_cleaned
GROUP BY discount
ORDER BY discount;

--Top Customers

WITH customer_sales AS (
    SELECT
        customer_name,
        SUM(sales) AS total_spend
    FROM Super_Store_data_cleaned
    GROUP BY customer_name
)
SELECT TOP 10
    customer_name,
    ROUND(total_spend, 2) AS total_spend,
    RANK() OVER (ORDER BY total_spend DESC) AS customer_rank
FROM customer_sales
ORDER BY total_spend DESC;

--Monthly Sales

SELECT 
    FORMAT(order_date, 'yyyy-MM') AS month,
    ROUND(SUM(sales), 2) AS monthly_sales
FROM Super_Store_data_cleaned
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY month;