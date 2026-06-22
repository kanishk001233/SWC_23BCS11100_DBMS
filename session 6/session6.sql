--ques 1
SELECT 
    cc.customer_id
FROM 
    customer_contracts AS cc
JOIN 
    products AS p 
    ON cc.product_id = p.product_id
GROUP BY 
    cc.customer_id
HAVING 
    COUNT(DISTINCT p.product_category) = (SELECT COUNT(DISTINCT product_category) FROM products);

--ques 2

WITH ranked_transactions AS (
  SELECT 
    user_id,
    spend,
    transaction_date,
    ROW_NUMBER() OVER (
      PARTITION BY user_id 
      ORDER BY transaction_date
    ) AS row_num
  FROM transactions
)

SELECT 
  user_id,
  spend,
  transaction_date
FROM ranked_transactions
WHERE row_num = 3;
