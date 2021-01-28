
-- Via what channel did the most recent (latest) web_event occur, which account was associated with 
-- this web_event?

SELECT w.occurred_at "date", w.channel, a.name "account_name"
FROM accounts a
JOIN web_events w ON a.id = w.account_id
ORDER BY w.occurred_at DESC LIMIT 1;


-- Find the number of sales reps in each region. Your final table should have two columns - 
-- the region and the number of sales_reps. Order from fewest reps to most reps.

SELECT r.name, COUNT(s.id) "sales_reps"
FROM sales_reps as s
JOIN region r ON r.id = s.region_id
GROUP BY r.name
ORDER BY "sales_reps";


-- What was the smallest order placed by each account in terms of total usd. 
-- Provide only two columns - the account name and the total usd. Order from smallest dollar 
-- amounts to largest.

SELECT a.name, MIN(o.total_amt_usd) "smallest_order"
FROM accounts a
JOIN orders o ON a.id = o.account_id
GROUP BY a.name
ORDER BY "smallest_order";


-- test if there are any accounts associated with more than one region.

SELECT a.name, COUNT(r.id) as "regions"
FROM accounts a
JOIN sales_reps s ON a.sales_rep_id = s.id
JOIN region r ON r.id = s.region_id
GROUP BY a.name
HAVING COUNT(r.id) > 1