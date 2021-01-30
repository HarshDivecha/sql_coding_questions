-- In which month of which year did Walmart spend the most on gloss paper in terms of dollars?
SELECT  
	DATE_PART('year',o.occurred_at) "Year", 
	DATE_PART('month',o.occurred_at) "Month", 
	SUM(o.gloss_amt_usd) "total_gloss_sales"
FROM orders o
JOIN accounts a ON a.id = o.account_id
WHERE a.name='Walmart'
GROUP BY 1,2
ORDER BY 3 DESC;

-- Which month did Parch & Posey have the greatest sales in terms of total number of orders? 
-- Are all months evenly represented by the dataset?
SELECT  DATE_PART('month',o.occurred_at), COUNT(o.id) "total_orders_month"
FROM orders o
GROUP BY 1
ORDER BY 2;

-- Find the sales in terms of total dollars for all orders in each year, 
-- ordered from greatest to least. Do you notice any trends in the yearly sales totals?
SELECT  DATE_PART('year',o.occurred_at), SUM(o.total_amt_usd)
FROM orders o
GROUP BY 1;

-- Which year did Parch & Posey have the greatest sales in terms of total number of orders? 
-- Are all years evenly represented by the dataset?
SELECT  DATE_PART('year',o.occurred_at), COUNT(o.id) "total_orders_year"
FROM orders o
GROUP BY 1
ORDER BY 2;

-- Which month did Parch & Posey have the greatest sales in terms of total dollars? 
-- Are all months evenly represented by the dataset?
SELECT  DATE_PART('month',o.occurred_at), SUM(o.total_amt_usd) "total_sale_month"
FROM orders o
GROUP BY 1
ORDER BY 2;





