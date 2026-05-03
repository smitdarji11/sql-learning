-- THIS IS ONE LINE COMMENT IN SQL 
/*  THIS 
IS  MULTI LINE COMMENT 
*/

-- Retrives all from column 
SELECT *
FROM  customers;

-- Retrives some useful column in database 

SELECT first_name,
       country,
	   score
FROM customers;

-- Retrives result by filtering using where causes 

SELECT first_name,country,score 
FROM customers
WHERE score>500;

-- Second example 

SELECT *
FROM customers
WHERE score != 0;

-- Third Example 

SELECT 
	first_name,
	country
FROM customers  
where country = 'Germany' 


-- Sort the Data using ORDER BY 

SELECT * 
FROM customers
ORDER BY score ASC

-- Sort the data using NESTED ORDER BY   

SELECT *
FROM customers
ORDER BY 
	country ASC,
	score DESC;  

-- Group the data using group by 

SELECT 
country,
SUM(score) as Total_Score 		
FROM customers 
GROUP BY country

-- Find the total score and total customers of each country 

SELECT 
	country,
	COUNT(id) AS Total_Customers,
	SUM(score) AS Total_Score   
FROM customers 
GROUP By country 

-- Use of having 

SELECT 
	country ,
	sum (score)
from customers 
where score>400 
group by country 
having sum(score) >800 

-- Example 

SELECT 
	country,
	AVG(score) as avg_score
FROM customers
where score != 0
GROUP BY country 
HAVING AVG(score) > 430


-- Use of Distinct

SELECT DISTINCT country 
FROM customers 

-- Use of TOP 

SELECT TOP(3) *
FROM customers

--Example 

SELECT TOP(3) * 
FROM customers 
ORDER BY SCORE DESC


SELECT TOP(2) * 
FROM customers 
ORDER BY SCORE 


-- Get the two most recent orders


USE SalesDB
SELECT *
FROM sales.Orders

SELECT TOP(2) *
FROM sales.Orders
ORDER BY OrderDate


-- Multiple Queries 

SELECT *
FROM customers ;

SELECT *
FROM orders ;

-- Static Fixed values 

SELECT 123 as static_value
SELECT 'Heloo' as static_string

--Example 

SELECT 
	id,
	first_name,
	'New_customers' AS Customers_type
FROM customers ;
