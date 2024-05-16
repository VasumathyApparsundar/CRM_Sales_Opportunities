# Which product series has contributed the most to the total revenue, and what is the total revenue for each series?
SELECT pr.series, SUM(sp.close_value) AS total_revenue
FROM products pr
JOIN sales_pipeline sp ON pr.product = sp.product
GROUP BY pr.series;

# What is the win rate (percentage of won opportunities) for each sales agent, and how does it vary across different agents (top 5)?
SELECT st.sales_agent, 
       (COUNT(CASE WHEN sp.deal_stage = 'Won' THEN 1 END) / COUNT(*)) * 100 AS win_rate_percentage
FROM sales_teams st
LEFT JOIN sales_pipeline sp ON st.sales_agent = sp.sales_agent
GROUP BY st.sales_agent
ORDER BY win_rate_percentage DESC
LIMIT 5;

# What is the average deal value for each product, and how does it vary across different products?
SELECT product, round(AVG(close_value), 2) AS avg_deal_value
FROM sales_pipeline
GROUP BY product
ORDER BY avg_deal_value DESC;

# How many opportunities are in each deal stage for a specific sales agent, and what is their distribution?
SELECT sales_agent, deal_stage, COUNT(*) AS num_opportunities
FROM sales_pipeline
GROUP BY sales_agent, deal_stage
ORDER BY num_opportunities DESC
LIMIT 5;

# What is the average win rate for each manager, and how does it compare across different managers?
SELECT st.manager, 
       (COUNT(CASE WHEN sp.deal_stage = 'Won' THEN 1 END) / COUNT(*)) * 100 AS avg_win_rate
FROM sales_teams st
JOIN sales_pipeline sp ON st.sales_agent = sp.sales_agent
GROUP BY st.manager;

# What is the distribution of deal stages for each product series?
SELECT p.series, sp.deal_stage, COUNT(*) AS num_opportunities
FROM sales_pipeline sp
JOIN products p ON sp.product = p.product
GROUP BY p.series, sp.deal_stage;

# How many opportunities are in each deal stage for a specific regional office, and what is their distribution?
SELECT st.regional_office, sp.deal_stage, COUNT(*) AS num_opportunities
FROM sales_pipeline sp
JOIN sales_teams st ON sp.sales_agent = st.sales_agent
GROUP BY st.regional_office, sp.deal_stage;

# Which sales agent has generated the highest revenue for the company, and which account did they primarily engage with?
SELECT st.sales_agent, a.account, SUM(sp.close_value) AS total_revenue
FROM sales_pipeline sp
INNER JOIN sales_teams st ON sp.sales_agent = st.sales_agent
INNER JOIN accounts a ON sp.account = a.account
GROUP BY st.sales_agent, a.account
ORDER BY total_revenue DESC
LIMIT 1;

# What is the average deal value for each product series, and which series has the highest average deal value?
SELECT p.series, AVG(sp.close_value) AS avg_deal_value
FROM sales_pipeline sp
INNER JOIN products p ON sp.product = p.product
GROUP BY p.series
ORDER BY avg_deal_value DESC
LIMIT 1;

# How does the win rate vary across different regional offices, and which office has the highest win rate?
SELECT st.regional_office, 
       (COUNT(CASE WHEN sp.deal_stage = 'Won' THEN 1 END) / COUNT(*)) * 100 AS win_rate_percentage
FROM sales_pipeline sp
INNER JOIN sales_teams st ON sp.sales_agent = st.sales_agent
GROUP BY st.regional_office
ORDER BY win_rate_percentage DESC
LIMIT 1;












