SELECT a.name "account_name",
       a.primary_poc "poc_name",
       s.name "sales_rep_name"
  FROM accounts a
  LEFT JOIN sales_reps s
    ON a.sales_rep_id = s.id
   AND a.primary_poc < s.name;
   
-- SELF JOINS
SELECT we1.id AS we_id,
       we1.account_id AS we1_account_id,
       we1.occurred_at AS we1_occurred_at,
       we1.channel AS we1_channel,
       we2.id AS we2_id,
       we2.account_id AS we2_account_id,
       we2.occurred_at AS we2_occurred_at,
       we2.channel AS we2_channel
  FROM web_events we1 
 LEFT JOIN web_events we2
   ON we1.account_id = we2.account_id
  AND we1.occurred_at > we2.occurred_at
  AND we1.occurred_at <= we2.occurred_at + INTERVAL '1 day'
ORDER BY we1.account_id, we2.occurred_at;

-- union all
WITH double_accounts AS (
    SELECT *
      FROM accounts

    UNION ALL

    SELECT *
      FROM accounts
)

SELECT name,
       COUNT(*) "name_count"
 FROM double_accounts 
GROUP BY 1
ORDER BY 2 DESC;