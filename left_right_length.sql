-- In the accounts table, there is a column holding the website for each company. 
-- The last three digits specify what type of web address they are using. A list of extensions 
-- (and pricing) is provided here. Pull these extensions and provide how many of each website type exist 
-- in the accounts table.

SELECT RIGHT(a.website,3) "domain", COUNT(*)
FROM accounts a
GROUP BY 1
ORDER BY 1;

-- There is much debate about how much the name (or even the first letter of a company name) matters. 
-- Use the accounts table to pull the first letter of each company name to see the distribution of company 
-- names that begin with each letter (or number).
SELECT LEFT(a.name,1), COUNT(*) 
FROM accounts a
GROUP BY 1
ORDER BY 2 DESC;

-- Use the accounts table and a CASE statement to create two groups: one group of company names that start with
-- a number and a second group of those company names that start with a letter. What proportion of company names 
-- start with a letter?
SELECT 
	CASE WHEN LEFT(a.name,1) IN ('1','2','3','4','5','6','7','8','9','0') THEN 'number'ELSE 'letter' END AS "category",
	COUNT(*)
FROM accounts a
GROUP BY 1