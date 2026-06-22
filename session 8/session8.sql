--ques1
WITH EmployeeScores AS (
    SELECT 
        employee_id, 
        employee_name, 
        AVG(customer_satisfaction) AS avg_score
    FROM amazon_support_tickets
    GROUP BY employee_id, employee_name
),
RankedEmployees AS (
    SELECT 
        employee_id, 
        employee_name, 
        avg_score,
        DENSE_RANK() OVER (ORDER BY avg_score DESC) as employee_rank
    FROM EmployeeScores
)
SELECT 
    employee_id, 
    employee_name, 
    avg_score, 
    employee_rank
FROM RankedEmployees
WHERE employee_rank <= 3
ORDER BY employee_rank;

--ques2

WITH SalaryRanking AS (
    SELECT 
        department, 
        salary,
        DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) as salary_rank
    FROM (SELECT DISTINCT department, salary FROM twitter_employee) as distinct_salaries
)
SELECT 
    department, 
    salary
FROM SalaryRanking
WHERE salary_rank <= 3
ORDER BY department ASC, salary DESC;
