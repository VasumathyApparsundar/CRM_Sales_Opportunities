# What is the total number of products in each series, and how does the distribution of products vary across series?
SELECT series, COUNT(*) AS num_products
FROM products
GROUP BY series;

# What is the average sales price for each series, and how does it compare across different series?
SELECT series, AVG(sales_price) AS avg_sales_price
FROM products
GROUP BY series;

# Which product has the highest and lowest sales price, and what are their respective series?
SELECT product, series, sales_price
FROM products
WHERE sales_price = (SELECT MAX(sales_price) FROM products)
UNION
SELECT product, series, sales_price
FROM products
WHERE sales_price = (SELECT MIN(sales_price) FROM products);


