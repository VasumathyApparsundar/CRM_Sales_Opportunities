SELECT * FROM sales_pipeline;

# How many opportunities are currently in each deal stage, and what is the distribution of deal stages?
SELECT deal_stage, COUNT(*) AS num_opportunities
FROM sales_pipeline
GROUP BY deal_stage;

# What is the total value of all opportunities in the pipeline, and what is the average deal value?
SELECT SUM(close_value) AS total_pipeline_value, AVG(close_value) AS avg_deal_value
FROM sales_pipeline;

# Which sales agent has the highest number of won opportunities, and how many opportunities have they won?
SELECT sales_agent, COUNT(*) AS num_won_opportunities
FROM sales_pipeline
WHERE deal_stage = 'Won'
GROUP BY sales_agent
ORDER BY num_won_opportunities DESC
LIMIT 1;

# What is the win rate (percentage of won opportunities) for top 5 sales agent?
SELECT sales_agent, 
       (COUNT(CASE WHEN deal_stage = 'Won' THEN 1 END) / COUNT(*)) * 100 AS win_rate_percentage
FROM sales_pipeline
GROUP BY sales_agent
ORDER BY win_rate_percentage DESC
LIMIT 5;

# Which product has the highest total value of won opportunities, and what is the total value?
SELECT product, SUM(close_value) AS total_value_won
FROM sales_pipeline
WHERE deal_stage = 'Won'
GROUP BY product
ORDER BY total_value_won DESC
LIMIT 1;

# What is the average time taken to close an opportunity (from engage date to close date) for top 5 sales agent?
SELECT sales_agent, round(AVG(DATEDIFF(close_date, engage_date)), 0) AS avg_days_to_close
FROM sales_pipeline
WHERE deal_stage = 'Won'
GROUP BY sales_agent
ORDER BY avg_days_to_close DESC
LIMIT 5;

# How many opportunities have a deal value greater than $1000, and what is the average deal value for these opportunities?
SELECT COUNT(*) AS num_high_value_opportunities, AVG(close_value) AS avg_deal_value
FROM sales_pipeline
WHERE close_value > 1000;

# What is the distribution of deal stages for each product?
SELECT product, deal_stage, COUNT(*) AS num_opportunities
FROM sales_pipeline
GROUP BY product, deal_stage;

# What is the total pipeline value for each month, and how has it changed over time?
SELECT YEAR(engage_date) AS year, MONTH(engage_date) AS month, SUM(close_value) AS total_pipeline_value
FROM sales_pipeline
GROUP BY year, month
ORDER BY year, month;

# Which accounts have the highest total value of won opportunities, and what is the total value for top 5 account?
SELECT account, SUM(close_value) AS total_value_won
FROM sales_pipeline
WHERE deal_stage = 'Won'
GROUP BY account
ORDER BY total_value_won DESC
LIMIT 5;










