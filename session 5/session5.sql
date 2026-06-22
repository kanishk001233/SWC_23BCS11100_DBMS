--ques1
SELECT 
  7 AS month, 
  COUNT(DISTINCT user_id) AS monthly_active_users
FROM user_actions
WHERE EXTRACT(MONTH FROM event_date) = 7
  AND EXTRACT(YEAR FROM event_date) = 2022
  AND user_id IN (
    SELECT user_id 
    FROM user_actions
    WHERE EXTRACT(MONTH FROM event_date) = 6
      AND EXTRACT(YEAR FROM event_date) = 2022
  );

--ques2 
WITH partitioned_transactions AS (
  SELECT 
    transaction_id,
    merchant_id,
    credit_card_id,
    amount,
    transaction_timestamp,
    LAG(transaction_timestamp) OVER(
      PARTITION BY merchant_id, credit_card_id, amount 
      ORDER BY transaction_timestamp
    ) AS prev_transaction_timestamp
  FROM transactions
)

SELECT 
  COUNT(*) AS payment_count
FROM partitioned_transactions
WHERE transaction_timestamp - prev_transaction_timestamp <= INTERVAL '10 minutes';
