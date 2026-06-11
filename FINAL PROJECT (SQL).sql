
-- 1. Total Customers

SELECT COUNT(*) AS Total_Customers FROM customers;


-- 2. Customer Count by Gender

SELECT gender, COUNT(*) AS Customer_Count FROM customers GROUP BY gender;


-- 3. Loan Portfolio by Gender

SELECT c.gender, SUM(l.principal_amount) AS Total_Loan FROM customers c 
JOIN loans l ON c.customer_id=l.customer_id GROUP BY c.gender;


-- 4. Total Account Balance

SELECT SUM(account_balance) AS Total_Account_Balance FROM customers;


-- 5. Customer Count by State
SELECT TOP 10 state,COUNT(*) AS Customer_Count FROM customers GROUP BY state ORDER BY Customer_Count Desc;


-- 6. Total Loan Amount by State

SELECT Top 10 c.state, SUM(l.principal_amount) AS Total_Loan_Amount FROM customers c JOIN loans l ON c.customer_id = l.customer_id 
GROUP BY c.state ORDER BY Total_Loan_Amount DESC;


-- 7. Average Annual Income

SELECT AVG(annual_income) AS Avg_Annual_Income FROM customers;


-- 8. Top Cities by Customer Count

SELECT TOP 10 city, COUNT(*) AS Customer_Count FROM customers GROUP BY city ORDER BY Customer_Count DESC;


-- 9. Average Credit Score by Loan Type

SELECT l.loan_type, AVG(c.credit_score) AS Avg_Credit_Score FROM customers c 
JOIN loans l ON c.customer_id=l.customer_id GROUP BY l.loan_type;


-- 10. Average Credit Score

SELECT AVG(credit_score) AS Avg_Credit_Score FROM customers;


-- 11. Credit Card Holder Percentage 

SELECT COUNT(CASE WHEN credit_card_holder=1 THEN 1 END)*100.0/COUNT(*) AS Credit_Card_Holder_Percentage FROM customers;


-- 12. Top Customer by Loan Amount

SELECT TOP 1 c.full_name, SUM(l.principal_amount) AS Total_Loan FROM customers c JOIN loans l ON c.customer_id=l.customer_id 
GROUP BY c.full_name ORDER BY Total_Loan DESC;


-- 13. High Credit Score Customers

SELECT COUNT(*) AS High_Credit_Customers FROM customers WHERE credit_score>750;


-- 14. KYC Verification Percentage

SELECT COUNT(CASE WHEN kyc_status='Verified' THEN 1 END)*100.0/COUNT(*) AS KYC_Verification_Percentage FROM customers;


-- 15. High-Risk Customer Count

SELECT COUNT(DISTINCT c.customer_id) AS High_Risk_Customers FROM customers c JOIN loans l ON c.customer_id=l.customer_id WHERE c.credit_score<600 AND l.npa_flag=1;


-- 16. Total Loan Amount Disbursed

SELECT SUM(principal_amount) AS Total_Loan_Amount FROM loans;


-- 17. Average Balance by Account Type

SELECT account_type, AVG(account_balance) AS Avg_Balance FROM customers GROUP BY account_type;


-- 18. Loan-to-Income Ratio

SELECT c.customer_id,c.full_name,SUM(l.principal_amount)/c.annual_income AS Loan_Income_Ratio FROM customers c JOIN loans l ON c.customer_id=l.customer_id 
GROUP BY c.customer_id,c.full_name,c.annual_income;


-- 19. Average Loan Amount

SELECT AVG(principal_amount) AS Avg_Loan_Amount FROM loans;


-- 20. Average Income by Occupation

SELECT occupation, AVG(annual_income) AS Avg_Income FROM customers GROUP BY occupation;


-- 21. Total Outstanding Balance

SELECT SUM(outstanding_balance) AS Total_Outstanding_Balance FROM loans;


-- 22. Customer Age Group Distribution

SELECT CASE WHEN age<30 THEN 'Young' WHEN age BETWEEN 30 AND 50 THEN 'Middle Age' ELSE 'Senior' END AS Age_Group, COUNT(*) AS Customer_Count FROM customers 
GROUP BY CASE WHEN age<30 THEN 'Young' WHEN age BETWEEN 30 AND 50 THEN 'Middle Age' ELSE 'Senior' END;


-- 23. Loan Count by Loan Type

SELECT loan_type, COUNT(*) AS Loan_Count FROM loans GROUP BY loan_type;


-- 24. Customer Count by Bank

SELECT bank_name, COUNT(*) AS Customer_Count FROM customers GROUP BY bank_name;


-- 25. Average Interest Rate by Loan Type

SELECT loan_type, AVG(interest_rate_pct) AS Avg_Interest_Rate FROM loans GROUP BY loan_type;


-- 26. NPA Percentagen (The percentage of total loans that borrowers are not repaying on time.)

SELECT COUNT(CASE WHEN npa_flag=1 THEN 1 END)*100.0/COUNT(*) AS NPA_Percentage FROM loans;

-- 27. Total EMI Amount

SELECT SUM(emi_amount) AS Total_EMI FROM loans;


-- 28. Loan Status Distribution   (defaulted means- Customer failed to repay.Loan is considered a bad debt.)


SELECT loan_status, COUNT(*) AS Loan_Count FROM loans GROUP BY loan_status;


-- 29. Average Late Payment Count

SELECT AVG(late_payment_count) AS Avg_Late_Payment_Count FROM loans;


-- 30.-- Top Borrower in Every Bank

WITH CTE AS (SELECT c.bank_name,c.full_name,SUM(l.principal_amount) Total_Loan,ROW_NUMBER() OVER(PARTITION BY c.bank_name ORDER BY SUM(l.principal_amount) DESC) rn 
FROM customers c JOIN loans l ON c.customer_id=l.customer_id GROUP BY c.bank_name,c.full_name) SELECT bank_name,full_name,Total_Loan FROM CTE WHERE rn=1;

-- 31. Premium Customer Count

SELECT COUNT(*) AS Premium_Customers FROM customers WHERE annual_income > 1500000 AND credit_score > 750;


-- 32. High Exposure Customers (Exposure = Amount the bank could lose if the customer doesn't pay.)

SELECT COUNT(DISTINCT customer_id) AS High_Exposure_Customers FROM loans WHERE principal_amount > 2000000;


-- 33. Top Bank by Customer Base

SELECT TOP 1 bank_name,COUNT(*) AS Customer_Count FROM customers GROUP BY bank_name ORDER BY Customer_Count DESC;


-- 34. Bank Wise Premium Customers

SELECT bank_name,COUNT(*) AS Premium_Customers FROM customers WHERE annual_income>1500000 AND credit_score>750
GROUP BY bank_name ORDER BY Premium_Customers DESC;

-- 35. Bank Type Performance by Customers

SELECT bank_type,COUNT(*) AS Customer_Count FROM customers GROUP BY bank_type;


-- 36. Top Occupation by Loan Amount

SELECT TOP 1 c.occupation,SUM(l.principal_amount) AS Total_Loan FROM customers c JOIN loans l ON c.customer_id=l.customer_id 
GROUP BY c.occupation ORDER BY Total_Loan DESC;


-- 37. Average Credit Score of NPA Customers

SELECT AVG(c.credit_score) AS Avg_Credit_Score_NPA FROM customers c JOIN loans l ON c.customer_id=l.customer_id WHERE l.npa_flag=1;


-- 38. 
SELECT rbi_classification,COUNT(*) AS Loan_Count,CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(5,2)) AS Percentage FROM loans GROUP BY rbi_classification
ORDER BY  CASE rbi_classification WHEN 'Standard' THEN 1 WHEN 'Sub-standard' THEN 2 WHEN 'Doubtful' THEN 3 WHEN 'Loss'THEN 4 END;

-- 39. Customers with Multiple Loans

SELECT COUNT(*) AS Customers_With_Multiple_Loans FROM (SELECT customer_id FROM loans GROUP BY customer_id HAVING COUNT(*)>1)x;


-- 40. Average Loan Amount by State

SELECT c.state,AVG(l.principal_amount) AS Avg_Loan FROM customers c JOIN loans l ON c.customer_id=l.customer_id GROUP BY c.state;


-- 41. Customers without Loan

SELECT COUNT(*) AS Customers_Without_Loan FROM customers c LEFT JOIN loans l ON c.customer_id=l.customer_id WHERE l.customer_id IS NULL;


-- 42. High Net Worth Customers

SELECT COUNT(*) AS HNW_Customers FROM customers WHERE annual_income>2500000 AND account_balance>1000000;


-- 43. Highest Loan Customer in Every State

WITH CTE AS (SELECT c.state,c.full_name,SUM(l.principal_amount) AS Total_Loan,ROW_NUMBER() OVER(PARTITION BY c.state 
ORDER BY SUM(l.principal_amount) DESC) rn FROM customers c JOIN loans l ON c.customer_id=l.customer_id GROUP BY c.state,c.full_name)
SELECT state,full_name,Total_Loan FROM CTE WHERE rn=1;

-- 44. High Risk Customers

SELECT COUNT(DISTINCT c.customer_id) AS High_Risk_Customers FROM customers c JOIN loans l ON c.customer_id=l.customer_id 
WHERE c.credit_score<600 AND l.npa_flag=1;


-- 45.  Top Loan Type in Every State

WITH CTE AS (SELECT c.state,l.loan_type,COUNT(*) Loan_Count,ROW_NUMBER() OVER(PARTITION BY c.state 
ORDER BY COUNT(*) DESC) rn FROM customers c JOIN loans l ON c.customer_id=l.customer_id GROUP BY c.state,l.loan_type)
SELECT state,loan_type,Loan_Count FROM CTE WHERE rn=1;

