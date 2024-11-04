
# Retail sales Analysis SQL Project

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.


## Objectives
1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.
## Project Structure
### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sql_p1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE sql_p1;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```
- **Import data**: Import the retail sales data from the excel to the posgre SQL by the Tables> retail_sales>Import/Export option. If you get any error please check the header toggle should be ON because the excel file has the header.
### 2. Data Exploration & Cleaning
- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.
``` sql
SELECT*FROM retail_sales

SELECT COUNT(DISTINCT(customer_id)) FROM retail_sales

SELECT DISTINCT(category) FROM reatil_sales

SELECT *FROM retail_sales 
WHERE
transactions_id is NULL or sale_date is NULL
or sale_time is NULL or customer_id is NULL
or gender is NULL or age is NULL
or category is NULL
or quantiy is NULL 
or price_per_unit is NULL
or cogs is NULL
or total_sale is NULL


DELETE FROM retail_sales 
WHERE
transactions_id is NULL
or sale_date is NULL
or sale_time is NULL
or customer_id is NULL
or gender is NULL
or age is NULL
or category is NULL
or quantiy is NULL
or price_per_unit is NULL
or cogs is NULL
or total_sale is NULL
```
### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:
1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05'**
``` sql
SELECT*FROM retail_sales
WHERE sale_date='2022-11-05'
```
2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022**
``` sql
SELECT *
FROM retail_sales
WHERE category='Clothing'
AND TO_CHAR(sale_date,'YYYY-MM')='2022-11'
AND quantiy>=4
```
3. **Write a SQL query to calculate the total sales (total_sale) for each category.**
``` sql
SELECT category,SUM(total_sale), count(*) as total_sales
FROM retail_sales
GROUP BY category
```
4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**
``` sql
SELECT ROUND(AVG(age),2)
FROM retail_sales
WHERE category='Beauty'
```
5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**
``` sql
SELECT*FROM retail_sales
WHERE total_sale>1000
```
6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**
``` sql
SELECT category,gender,COUNT(*)
FROM retail_sales
GROUP BY category, gender
ORDER BY 1
```
7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**
``` sql
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
 ```
8. **Write a SQL query to find the top 5 customers based on the highest total sales**
``` sql
SELECT customer_id, SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
```
9. **Write a SQL query to find the number of unique customers who purchased items from each category.**
``` sql
SELECT 
category, COUNT(DISTINCT(customer_id)) as cust_id
FROM retail_sales
GROUP BY category
```
10. **Unique customers who had purchased from all categories**
``` sql
SELECT customer_id
FROM retail_sales
WHERE category IN ('Clothing','Beauty','Electronics')
GROUP BY customer_id
HAVING count(DISTINCT category) = 3\
```
11. **top 5 customers who are puchasing from Clothing and making more sales in clothing category**
``` sql
SELECT DISTINCT(customer_id), SUM(total_sale) as s_t
FROM retail_sales
WHERE category='Clothing'
GROUP BY DISTINCT(customer_id)
ORDER BY s_t DESC
LIMIT 5
```
12. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**
``` sql
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
```
## Findings
- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **Highest sales**: From each category we find the the top customers using customer_id and the highest sales using the total_sale for each category
- **Periodic Transactions**: In which Year and in which month the most sales happend and which timeframe the sales happend is retrieved using the Extract functions and case functions.

## Reports
- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## Author - Mohit Yavarna

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/mohit-yavarna-967897264/)

Thank you for your support, and I look forward to connecting with you!