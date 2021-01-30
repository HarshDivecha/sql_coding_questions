-- Each company in the accounts table wants to create an email address for each primary_poc. 
-- The email address should be the first name of the primary_poc . last name primary_poc @ company name .com.
SELECT 
	LOWER(
		split_part(a.primary_poc,' ',1) || '.' ||
		split_part(a.primary_poc,' ',2) || '@' ||
		a.name || '.com' 
	) as "email"
FROM accounts a;

-- We would also like to create an initial password, which they will change after their first log in. 
-- The first password will be the 
-- first letter of the primary_poc's first name (lowercase), 
-- last letter of their first name (lowercase), 
-- the first letter of their last name (lowercase), 
-- the last letter of their last name (lowercase), 
-- the number of letters in their first name, 
-- the number of letters in their last name, and then 
-- the name of the company they are working with, all capitalized with no spaces.

WITH 
	t1 as 
	(SELECT 
	 	id,
		LOWER(split_part(a.primary_poc,' ',1)) "fname", 
		LOWER(split_part(a.primary_poc,' ',2)) "lname",
		UPPER(REPLACE(a.name,' ',''))  "company"
	FROM accounts a),
	
	t2 as
	(SELECT
	 id,fname,lname,
	 	RIGHT(t1.fname,1) || LEFT(t1.fname,1) ||
	 	RIGHT(t1.lname,1) || LEFT(t1.lname,1) ||
	 	LENGTH(t1.fname) ||
	 	LENGTH(t1.lname) ||
	 	t1.company "password"
	FROM t1)
	

SELECT * 
FROM accounts a
JOIN t2 ON a.id = t2.id;

-- ALTERNATE

WITH t1 AS 
	(SELECT 
		 LEFT(primary_poc, STRPOS(primary_poc, ' ') -1 ) first_name,  
		 RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, 
	 	 name 
	 FROM accounts)

SELECT 
	first_name, 
	last_name, 
	CONCAT(first_name, '.', last_name, '@', name, '.com'), 
	LEFT(LOWER(first_name), 1) || RIGHT(LOWER(first_name), 1) || LEFT(LOWER(last_name), 1) || RIGHT(LOWER(last_name), 1) || LENGTH(first_name) || LENGTH(last_name) || REPLACE(UPPER(name), ' ', '')
FROM t1;
	