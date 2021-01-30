-- Write a query to display the number of orders in each of three categories, based on the total number of 
-- items in each order. The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'


SELECT CASE
	WHEN o.total > 2000 THEN 'At Least 2000'
	WHEN o.total BETWEEN 1000 AND 2000 THEN 'Between 1000 and 2000'
	ELSE 'Less than 1000' 
	END AS "number_of_orders",
	COUNT (*)
FROM orders o
GROUP BY 1
ORDER BY 2 DESC;


-- We would like to understand 3 different levels of customers based on the amount associated with their purchases. 
-- The top level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. 
-- The second level is between 200,000 and 100,000 usd. The lowest level is anyone under 100,000 usd. 
-- Provide a table that includes the level associated with each account. 
-- You should provide the account name, the total sales of all orders for the customer, and the level. 
-- Order with the top spending customers listed first.

SELECT 
	a.name, 
	SUM(o.total_amt_usd) "purchase_amount",
	CASE
		WHEN SUM(o.total_amt_usd) > 200000 THEN 'top'
		WHEN SUM(o.total_amt_usd) < 100000 THEN 'low'
		ELSE 'middle'
		END AS "category"
FROM orders o
JOIN accounts a
	ON a.id =o.account_id
GROUP BY 1
ORDER BY 3 DESC;


-- We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders.
-- Create a table with the sales rep name, the total number of orders, and a column with top or not depending on 
-- if they have more than 200 orders. Place the top sales people first in your final table.
SELECT 
	s.name,
	COUNT(o.id) "sales",
	CASE WHEN COUNT(o.id) > 200 THEN 'top' ELSE 'not' END AS "performer"
FROM sales_reps s
JOIN accounts a ON s.id = a.sales_rep_id
JOIN orders o ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC;


-- The previous didn't account for the middle, nor the dollar amount associated with the sales. 
-- Management decides they want to see these characteristics represented as well. 
-- We would like to identify top performing sales reps, which are sales reps associated with 
-- more than 200 orders or more than 750000 in total sales. The middle group has any rep with 
-- more than 150 orders or 500000 in sales. Create a table with the sales rep name, the total number of orders, 
-- total sales across all orders, and a column with top, middle, or low depending on this criteria. 
-- Place the top sales people based on dollar amount of sales first in your final table. 
-- You might see a few upset sales people by this criteria!
SELECT 
	s.name,
	COUNT(o.id) "orders",
	SUM(o.total_amt_usd) "sales",
	CASE 
		WHEN COUNT(o.id) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top'
		WHEN COUNT(o.id) > 150 OR SUM(o.total_amt_usd) > 500000 THEN 'middle'
		ELSE 'not' END AS "performer"
FROM sales_reps s
JOIN accounts a ON s.id = a.sales_rep_id
JOIN orders o ON a.id = o.account_id
GROUP BY 1
ORDER BY 3 DESC;

