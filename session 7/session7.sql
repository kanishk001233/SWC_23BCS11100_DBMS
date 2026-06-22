--ques 1
WITH LatestStatus AS (
    SELECT 
        page_id, 
        status,
        RANK() OVER (PARTITION BY page_id ORDER BY last_login DESC) as rnk
    FROM page_status_log
)
SELECT COUNT(*) 
FROM LatestStatus
WHERE rnk = 1 AND status = 'on';

--ques 2

WITH ChannelYearlyData AS (
    SELECT 
        advertising_channel, 
        MAX(money_spent) AS max_yearly_spend
    FROM uber_advertising
    GROUP BY advertising_channel
    HAVING MIN(customers_acquired) > 1500
)
SELECT 
    advertising_channel
FROM ChannelYearlyData
ORDER BY max_yearly_spend ASC
LIMIT 1;
