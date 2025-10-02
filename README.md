# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis   
**Database**: `p1_retail_db`(Kaggle)

## Objectives

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

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

### 2. Data Exploration & Cleaning

**Record Count**: Determine the total number of records in the dataset.
  ```
  SELECT COUNT(*) FROM retail_sales;
  ```
  
- **Customer Count**: Find out how many unique customers are in the dataset.
```
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
```

- **Category Count**: Identify all unique product categories in the dataset.
```
SELECT DISTINCT category FROM retail_sales;
```

- **Null Value Check**: Check for any null values in the dataset.

```sql

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL
OR
    sale_time IS NULL
OR
    customer_id IS NULL
OR 
    gender IS NULL
OR
    age IS NULL
OR
    category IS NULL
OR 
    quantity IS NULL
OR
    price_per_unit IS NULL
OR
    cogs IS NULL;
```

- **Delete the Null Values**:  Delete records with missing data.

```sql

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL
OR
    sale_time IS NULL
OR
    customer_id IS NULL
OR 
    gender IS NULL
OR
    age IS NULL
OR
    category IS NULL
OR 
    quantity IS NULL
OR
    price_per_unit IS NULL
OR
    cogs IS NULL;
```

- ***Now solving all the relevent questions from the dataset to know the market trends***

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022**:
```sql
SELECT * 
	  FROM retail_sales
      WHERE category = 'clothing' 
      AND total_sale > 10
      AND YEAR(sale_date) = 2022
	  AND MONTH(sale_date) = 11 
      ;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT 
     category,
     SUM(total_sale) as net_sale,
     COUNT(*) as total_orders
FROM retail_sales
GROUP BY category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT 
      category AS product_category,
      ROUND(avg(age),2) AS average_age
FROM retail_sales
WHERE category = "beauty" 
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * , 
	   total_sale
       FROM retail_sales
WHERE total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT 
     category,
     gender, 
     count(transactions_id) as total_count
FROM retail_sales
GROUP BY 
     category,
     gender ;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT 
      ROUND(AVG(total_sale),2) AS total_sale,
      YEAR(total_sale) as year,
      MONTH(sale_date) as month
FROM retail_sales
WHERE YEAR(total_sale) is NOT NULL
GROUP BY year , month
;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT 
      DISTINCT(customer_id) ,
      SUM(total_sale) as highest_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY highest_sale DESC
LIMIT 5 ;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
      category ,
      COUNT(DISTINCT(customer_id)) as unique_customer
FROM retail_sales
GROUP BY category 
;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening > 17)**:
```sql
WITH hourly_sale
AS
(
SELECT * ,
	  CASE
          WHEN 
          HOUR(sale_time) < 12 
          THEN 'Morning'
          WHEN 
          HOUR(sale_time) BETWEEN 12 and 17 
          THEN 'Afternoon'
      ELSE 'Evening'
END AS Shift
FROM retail_sales
)
SELECT shift ,
       COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift ;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.
