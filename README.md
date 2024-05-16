# CRM_Sales_Opportunities
#### B2B sales pipeline data from a fictitious company that sells computer hardware.

### Accounts Table 
**Data Description:**

	1. Account: The name of the company.
 
	2. Sector: The industry sector in which the company operates (e.g., technology, medical, retail, etc.).
 
	3. Year Established: The year in which the company was founded.
 
	4. Revenue: The revenue generated by the company.
 
	5. Employees: The number of employees working for the company.
 
	6. Office Location: The location of the company's main office.
 
	7. Subsidiary Of: Indicates if the company is a subsidiary of another company.

 **Questions:**
 
1. What are the distinct sectors present in the table, and how many companies belong to each sector?
   
  SELECT sector, COUNT(*) AS num_companies
  FROM accounts
  GROUP BY sector;
  
![image](https://github.com/VasumathyApparsundar/CRM_Sales_Opportunities/assets/167323908/eee98499-a827-4f82-8a04-5aea95ba0d5e)

2. Which company has the highest revenue, and what is its revenue?
   
SELECT account, revenue
FROM accounts
ORDER BY revenue DESC
LIMIT 1;

![image](https://github.com/VasumathyApparsundar/CRM_Sales_Opportunities/assets/167323908/2cd20963-e77c-4178-a498-a6c2f508dd66)

3. How many companies were established each year?
   
SELECT year_established, COUNT(*) AS num_companies
FROM accounts
GROUP BY year_established
ORDER BY year_established;

4. What is the average revenue and number of employees for each sector?
   
SELECT sector, round(AVG(revenue), 2)AS avg_revenue, round(AVG(employees), 2) AS avg_employees
FROM accounts
GROUP BY sector;

![image](https://github.com/VasumathyApparsundar/CRM_Sales_Opportunities/assets/167323908/06861b71-709e-4263-b16d-f1de629c005c)

5. How many subsidiaries does each parent company have?
   
SELECT subsidiary_of, COUNT(*) AS num_subsidiaries
FROM accounts
WHERE subsidiary_of IS NOT NULL
GROUP BY subsidiary_of;

![image](https://github.com/VasumathyApparsundar/CRM_Sales_Opportunities/assets/167323908/434296b3-c818-4216-a8b2-7da2dd1a2014)

6. Which country has the highest number of companies, and how many companies are based there?
   
SELECT office_location, COUNT(*) AS num_companies
FROM accounts
GROUP BY office_location
ORDER BY num_companies DESC
LIMIT 1;

![image](https://github.com/VasumathyApparsundar/CRM_Sales_Opportunities/assets/167323908/3c27ff4c-8a4d-4010-ba75-7ab341d33489)

7. What is the total revenue generated by companies established before the year 2000?
   
SELECT SUM(revenue) AS total_revenue
FROM accounts
WHERE year_established < 2000;

![image](https://github.com/VasumathyApparsundar/CRM_Sales_Opportunities/assets/167323908/4ce21545-1753-4114-ad4d-1726ac47707b)

8. What are the top 5 companies with the highest number of employees?
   
SELECT account, employees
FROM accounts
ORDER BY employees DESC
LIMIT 5;

![image](https://github.com/VasumathyApparsundar/CRM_Sales_Opportunities/assets/167323908/e3293b8e-9db7-44c3-be98-46644891a4d8)

## Sales_Pipeline Table :

**Data Description:**

1. opportunity_id: This column represents a unique identifier for each sales opportunity.
   
2. sales_agent: This column contains the name of the sales agent handling the opportunity.
   
3. product: This column specifies the product associated with the opportunity.

4. account: This column indicates the account or company associated with the opportunity.
   
5. deal_stage: This column represents the current stage of the deal.
 
6. engage_date: This column records the date when the engagement with the opportunity began.

7. close_date: This column records the date when the opportunity was closed.

8. close_value: This column denotes the value of the deal when it was closed.

**Questions:**

1. How many opportunities are currently in each deal stage, and what is the distribution of deal stages?
   
SELECT deal_stage, COUNT(*) AS num_opportunities
FROM sales_pipeline
GROUP BY deal_stage;

![image](https://github.com/VasumathyApparsundar/CRM_Sales_Opportunities/assets/167323908/91cb43e2-f137-4a2a-9deb-ce2bc663175a)

2. What is the total value of all opportunities in the pipeline, and what is the average deal value?

SELECT SUM(close_value) AS total_pipeline_value, AVG(close_value) AS avg_deal_value
FROM sales_pipeline;

![image](https://github.com/VasumathyApparsundar/CRM_Sales_Opportunities/assets/167323908/e7d434f1-6266-4476-a071-3667fd8b9162)

3. Which sales agent has the highest number of won opportunities, and how many opportunities have they won?
   
SELECT sales_agent, COUNT(*) AS num_won_opportunities
FROM sales_pipeline
WHERE deal_stage = 'Won'
GROUP BY sales_agent
ORDER BY num_won_opportunities DESC
LIMIT 1;

![image](https://github.com/VasumathyApparsundar/CRM_Sales_Opportunities/assets/167323908/ea6bb612-a8b9-4aed-828d-47abebcd184b)

4.  What is the win rate (percentage of won opportunities) for top 5 sales agent?

SELECT sales_agent, 
       (COUNT(CASE WHEN deal_stage = 'Won' THEN 1 END) / COUNT(*)) * 100 AS win_rate_percentage
FROM sales_pipeline
GROUP BY sales_agent
ORDER BY win_rate_percentage DESC
LIMIT 5;

![image](https://github.com/VasumathyApparsundar/CRM_Sales_Opportunities/assets/167323908/81ff205b-9f87-4bb1-bc93-e96e279bf85a)

5. Which product has the highest total value of won opportunities, and what is the total value?

SELECT product, SUM(close_value) AS total_value_won
FROM sales_pipeline
WHERE deal_stage = 'Won'
GROUP BY product
ORDER BY total_value_won DESC
LIMIT 1;

![image](https://github.com/VasumathyApparsundar/CRM_Sales_Opportunities/assets/167323908/935e7b94-b615-4868-b213-ff85af9e9431)

6. What is the average time taken to close an opportunity (from engage date to close date) for top 5 sales agent?
   
SELECT sales_agent, round(AVG(DATEDIFF(close_date, engage_date)), 0) AS avg_days_to_close
FROM sales_pipeline
WHERE deal_stage = 'Won'
GROUP BY sales_agent
ORDER BY avg_days_to_close DESC
LIMIT 5;

![image](https://github.com/VasumathyApparsundar/CRM_Sales_Opportunities/assets/167323908/24d0ecaf-1027-4680-9ad6-9d0951e6f002)

7. How many opportunities have a deal value greater than $1000, and what is the average deal value for these opportunities?
   
SELECT COUNT(*) AS num_high_value_opportunities, AVG(close_value) AS avg_deal_value
FROM sales_pipeline
WHERE close_value > 1000;

![image](https://github.com/VasumathyApparsundar/CRM_Sales_Opportunities/assets/167323908/299d465f-81db-4ba2-b3c3-91cb2fd433e6)

8. What is the distribution of deal stages for each product?
   
SELECT product, deal_stage, COUNT(*) AS num_opportunities
FROM sales_pipeline
GROUP BY product, deal_stage;

![image](https://github.com/VasumathyApparsundar/CRM_Sales_Opportunities/assets/167323908/d14e5220-688c-46ee-a64c-148a13a6210b)

9.  What is the total pipeline value for each month, and how has it changed over time?
    
SELECT YEAR(engage_date) AS year, MONTH(engage_date) AS month, SUM(close_value) AS total_pipeline_value
FROM sales_pipeline
GROUP BY year, month
ORDER BY year, month;

![image](https://github.com/VasumathyApparsundar/CRM_Sales_Opportunities/assets/167323908/67ec29cc-a217-4c0d-980a-0a46042a2a43)

10. Which accounts have the highest total value of won opportunities, and what is the total value for top 5 account?
    
SELECT account, SUM(close_value) AS total_value_won
FROM sales_pipeline
WHERE deal_stage = 'Won'
GROUP BY account
ORDER BY total_value_won DESC
LIMIT 5;

![image](https://github.com/VasumathyApparsundar/CRM_Sales_Opportunities/assets/167323908/05bf5059-0d9c-4e16-b81e-9c66845cdfac)























	


