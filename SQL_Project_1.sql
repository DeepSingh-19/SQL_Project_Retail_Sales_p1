-- SQL Retail Sales Analysis - P1

CREATE DATABASE sql_project_P2;

-- Use newely created table

USE sql_project_P2;

-- CREATE TABLE 
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
        (
		 transactions_id INT PRIMARY KEY,
         sale_date DATE,
         sale_time TIME,
         customer_id INT,
         gender VARCHAR(20),
         age INT,
         category VARCHAR(50),
         quantiy INT,
         price_per_unit FLOAT,
         cogs FLOAT,
         total_sale FLOAT
         );

-- Selecting Table
         
SELECT 
    *
FROM
    retail_sales
    ;         

-- Counting total number of columns

SELECT COUNT(*) FROM retail_sales;

-- Looking for the NULL values

SELECT 
    *
FROM
    retail_sales
WHERE
    transactions_id IS NULL
    OR
    sale_date is NULL
    OR
    sale_time is NULL
    OR
    customer_id is NULL
    OR
    gender is NULL 
    OR
    age is NULL 
    OR
    category is NULL 
    OR
    quantiy is NULL 
    OR
    price_per_unit is NULL 
    OR 
    cogs is NULL 
	OR
    total_sale is NULL
    ;

-- Deleting the NULL values from table (DATA CLENING)

DELETE from retail_sales
    WHERE transactions_id IS NULL
    OR
    sale_date is NULL
    OR
    sale_time is NULL
    OR
    customer_id is NULL
    OR
    gender is NULL 
    OR
    age is NULL 
    OR
    category is NULL 
    OR
    quantiy is NULL 
    OR
    price_per_unit is NULL 
    OR 
    cogs is NULL 
	OR
    total_sale is NULL
    ;
    
-- Data Exploration

-- How many sales we have ?

SELECT COUNT(*) FROM retail_sales;

-- How many unique customers we have?

SELECT COUNT(DISTINCT customer_id) as total_sale 
      FROM retail_sales;
      
-- How many total unique category ?

SELECT DISTINCT category FROM retail_sales ; 

-- Data Analysis and Business Problems & Answers

-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT * FROM retail_sales
    WHERE sale_date = '2022-11-05' ;

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

SELECT * 
	  FROM retail_sales
      WHERE category = 'clothing' 
      AND total_sale > 10
      AND YEAR(sale_date) = 2022
	  AND MONTH(sale_date) = 11 
      ;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
     category,
     SUM(total_sale) as net_sale,
     COUNT(*) as total_orders
FROM retail_sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT 
      category AS product_category,
      ROUND(avg(age),2) AS average_age
FROM retail_sales
WHERE category = "beauty" 
      ;

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * , 
	   total_sale
       FROM retail_sales
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
     category,
     gender, 
     count(transactions_id) as total_count
FROM retail_sales
GROUP BY 
     category,
     gender ;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
      ROUND(AVG(total_sale),2) AS total_sale,
      YEAR(total_sale) as year,
      MONTH(sale_date) as month
FROM retail_sales
WHERE YEAR(total_sale) is NOT NULL
GROUP BY year , month
;
      
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
      DISTINCT(customer_id) ,
      SUM(total_sale) as highest_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY highest_sale DESC
LIMIT 5 ;
      
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
      category ,
      COUNT(DISTINCT(customer_id)) as unique_customer
FROM retail_sales
GROUP BY category 
;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT * , 
	  CASE
          WHEN HOUR(sale_time) < 12 
          THEN 'Morning'
          WHEN HOUR(sale_time) BETWEEN 12 and 17 THEN 'Afternoon'
	  ELSE 'Evening'
      END AS Shift
FROM retail_sales ;