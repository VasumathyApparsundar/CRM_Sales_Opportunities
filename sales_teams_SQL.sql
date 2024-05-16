# How many sales agents are there in each regional office, and what is the distribution of sales agents across offices?
SELECT regional_office, COUNT(*) AS num_sales_agents
FROM sales_teams
GROUP BY regional_office;

# Who are the managers overseeing the sales agents, and how many sales agents does each manager supervise?
SELECT manager, COUNT(*) AS num_sales_agents
FROM sales_teams
GROUP BY manager;

# Which regional office has the highest number of sales agents, and how does it compare to other offices?
SELECT regional_office, COUNT(*) AS num_sales_agents
FROM sales_teams
GROUP BY regional_office;


