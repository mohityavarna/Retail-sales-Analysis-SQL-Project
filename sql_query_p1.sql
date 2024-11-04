--SQL Retail Sales Analysis
CREATE DATABASE sql_p1;

--create Table
CREATE TABLE retail_sales
                        (
							transactions_id int Primary key,
							sale_date  Date,
							sale_time Time,
							customer_id Int,
							gender Varchar(10),
							age Int,
							category varchar(15),
							quantiy int,
							price_per_unit Float,
							cogs Float,
							total_sale Float
                         );
SELECT*FROM retail_sales
LIMIT 10;

SELECT COUNT(DISTINCT(customer_id)) FROM retail_sales

SELECT *FROM retail_sales 
WHERE
transactions_id is NULL
or
sale_date is NULL
or
sale_time is NULL
or
customer_id is NULL
or 
gender is NULL
or 
age is NULL
or
category is NULL
or
quantiy is NULL
or
price_per_unit is NULL
or
cogs is NULL
or
total_sale is NULL


DELETE FROM retail_sales 
WHERE
transactions_id is NULL
or
sale_date is NULL
or
sale_time is NULL
or
customer_id is NULL
or 
gender is NULL
or 
age is NULL
or
category is NULL
or
quantiy is NULL
or
price_per_unit is NULL
or
cogs is NULL
or
total_sale is NULL

--Data Exploration
-- how many sales have happend?
SELECT COUNT(*) FROM retail_sales

-- How many Unique customers we have?
SELECT COUNT(DISTINCT retail_sales.customer_id) from retail_sales

--How many distinct categories we have?
SELECT DISTINCT retail_sales.category from retail_sales;

--Data Analysis 
--1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT*FROM retail_sales
WHERE sale_date='2022-11-05'
--2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
SELECT *
FROM retail_sales
WHERE category='Clothing'
AND TO_CHAR(sale_date,'YYYY-MM')='2022-11'
AND quantiy>=4
--3.Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category,SUM(total_sale), count(*) as total_sales
FROM retail_sales
GROUP BY category
--4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(age),2)
FROM retail_sales
WHERE category='Beauty'
--5.Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT*FROM retail_sales
WHERE total_sale>1000
--6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category,gender,COUNT(*)
FROM retail_sales
GROUP BY category, gender
ORDER BY 1
--7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
year,
month,
total_sales
FROM
(
SELECT 
EXTRACT(year FROM sale_date) as year,
EXTRACT(month FROM sale_date) as month,
AVG(total_sale) as total_sales,
RANK() OVER(PARTITION BY EXTRACT(year FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
 WHERE rank=1
--8.Write a SQL query to find the top 5 customers based on the highest total sales
SELECT customer_id, SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
--9.Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
category, COUNT(DISTINCT(customer_id)) as cust_id
FROM retail_sales
GROUP BY category
--10.Unique customers who had purchased from all categories
SELECT customer_id
FROM retail_sales
WHERE category IN ('Clothing','Beauty','Electronics')
GROUP BY customer_id
HAVING count(DISTINCT category) = 3
--11.top 5 customers who are puchasing from Clothing and making more sales in clothing category
SELECT DISTINCT(customer_id), SUM(total_sale) as s_t
FROM retail_sales
WHERE category='Clothing'
GROUP BY DISTINCT(customer_id)
ORDER BY s_t DESC
LIMIT 5
--12.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT *,
	CASE 
		WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 and 17 THEN 'Afternoon'
		ELSE 'Evening'
	END as shift
FROM retail_sales
)
SELECT
	shift,
	COUNT(*) as total_sales
FROM hourly_sale
GROUP By shift
