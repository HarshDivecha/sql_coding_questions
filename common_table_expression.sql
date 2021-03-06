-- Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.

WITH 
	total_sales_region AS (
		SELECT r.name "region", s.name "rep", SUM(o.total_amt_usd) "total_sales"
		FROM 
			accounts a
			JOIN sales_reps s ON a.sales_rep_id = s.id
			JOIN region r ON r.id = s.region_id
			JOIN orders o ON o.account_id = a.id
		GROUP BY 1,2),
		
	max_sales_region AS(	
		SELECT region, MAX(t.total_sales) "total_sales"
		FROM total_sales_region t
		GROUP BY region)
		
SELECT t1.region, t1.rep, t1.total_sales
FROM 
	total_sales_region t1
	JOIN max_sales_region t2 
	ON t2.region = t1.region AND t2.total_sales = t1.total_sales
	
-- For the region with the largest sales total_amt_usd, how many total orders were placed?


-- How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?


-- For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?


-- What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?


-- What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.
