-- Each company in the accounts table wants to create an email address for each primary_poc. 
-- The email address should be the first name of the primary_poc . last name primary_poc @ company name .com.
SELECT 
	LOWER(
		split_part(a.primary_poc,' ',1) || '.' ||
		split_part(a.primary_poc,' ',2) || '@' ||
		a.name || '.com' 
	) as "email",
FROM accounts a;