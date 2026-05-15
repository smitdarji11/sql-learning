-- Row-lavel Function 

-- String Function 

-- CONCAT 


SELECT CONCAT(FirstName,' ',LastName)
FROM sales.Customers  

-- LOWER & UPPER 

SELECT *
FROM Sales.Customers


SELECT 
UPPER(FirstName) AS First_name ,
UPPER (LastName) AS Last_name
FROM Sales.Customers

SELECT 
LOWER(FirstName) AS First_name ,
LOWER(LastName) AS Last_name
FROM Sales.Employees


-- TRIM  

USE MyDatabase

SELECT first_name,
		LEN(first_name) AS LEN_OF_FirstName,
		LEN(TRIM(first_name)) AS LEN_TRIM_FirstName
FROM Customers
WHERE LEN(first_name) != LEN(TRIM(first_name)) 
--WHERE first_name != TRIM(first_name) 

-- REPLACE 

SELECT 
'97-233-925-00',
REPLACE('97-233-925-00' , '-','/')

-- EXAMPLE 

-- Change file type txt to csv 

SELECT 
	'Report.txt' as Files ,
	REPLACE('Report.txt','.txt','.csv') as CSV_Files


-- Calculation Function 

-- LEN Function 

SELECT	
	first_name,
	 LEN(first_name ) len_name
FROM customers


-- String Extraction 

-- LEFT 

SELECT first_name, 
		LEFT(TRIM(first_name),2)  first_2_char
FROM customers

-- RIGHT

SELECT first_name, 
		RIGHT(TRIM(first_name),2)  Last_2_char
FROM customers

-- SUBSTRING 

SELECT first_name,
		SUBSTRING(TRIM(first_name),2,4)  AS new_name
FROM customers






--  Numeric Fuction 

-- Round 


SELECT 
	3.1456,
	ROUND(3.1456 , 2) round_2,
	ROUND(3.1456,1) round_1

-- Absulate (ABS)

SELECT 
	-3.1456,
	ABS(-3.1456) ABS_Num


-- DATE & TIME Function 

USE SalesDB

SELECT 
	OrderID,
	ShipDate,
	OrderDate,
	CreationTime
FROM sales.Orders
	
-- GETDATE()

SELECT 
	OrderID,
	CreationTime, 
	GETDATE() TODAY 
FROM sales.Orders

-- Part Extraction 

-- DAY | MONTH | YEAR

SELECT 
		orderID,
		CreationTime,
		YEAR(CreationTime) Year,
		MONTH(CreationTime) MONTH,
		DAY(CreationTime) DAY 
FROM sales.Orders

-- DATEPART()

SELECT 
		OrderID,
		CreationTime,
		DATEPART(YEAR,CreationTime) YEAR_DP,
		DATEPART(MONTH,CreationTime) MONTH_DP,
		DATEPART(DAY,CreationTime) DAY_DP,
		DATEPART(HOUR,CreationTime) HOUR_DP,
		DATEPART(QUARTER,CreationTime) QUARTER_DP,
		DATEPART(WEEK,CreationTime) WEEK
 FROM Sales.Orders

 -- DATENAME()

SELECT 
		OrderID,
		CreationTime,
		DATEPART(DAY,CreationTIme) AS DAY,
		DATENAME(MONTH,CreationTime) AS MONTH,
		DATEPART(YEAR,CreationTIme) AS YEAR
FROM Sales.Orders 
 

 -- DATETRUNC 

 SELECT 
		OrderID,
		CreationTime,
		DATETRUNC(year,CreationTime) AS YEAR_DT,
		DATETRUNC(minute,CreationTime) AS MINUTE_DT,
		DATETRUNC(day,CreationTime) AS DAY_DT
FROM Sales.Orders 

-- EXAMPLE

SELECT
	DATETRUNC(YEAR,CreationTime) AS Creation_by_year,
	COUNT(*) AS COUNT_ORDERS
FROM Sales.Orders
GROUP BY DATETRUNC(YEAR,CreationTime)


-- EOMONTH()

SELECT 
	OrderDate,
	CreationTime,
	EOMONTH(CreationTime) AS EndOfMonth,
	CAST(DATETRUNC(month,CreationTime) AS DATE)StartOfMonth
FROM Sales.Orders


-- EXAMPLE 
-- How many orders place in each year 

SELECT 
	YEAR(OrderDate),
	COUNT(*) as NrOfOrder
FROM Sales.Orders
GROUP BY YEAR

-- How many order placed in each month ??

SELECT 
	DATENAME(MONTH,CreationTime) AS Month ,
	Count(*)
FROM Sales.Orders
GROUP BY DATENAME(MONTH,CreationTime)


-- Show all order which is placed in month of february

SELECT *
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2


-- FORMAT & CASTING

-- FORMAT 

SELECT 
	OrderID,
	CreationTime,
	FORMAT(CreationTime,'MM-dd-yyyy') AS USA_Format,
	FORMAT(CreationTime,'dd-MM-yyyy') AS EROP_Format,
	FORMAT(CreationTime,'dd') AS dd,
	FORMAT(CreationTime,'ddd') AS ddd,
	FORMAT(CreationTime,'dddd') AS dddd,
	FORMAT(CreationTime,'MM') AS MM,
	FORMAT(CreationTime,'MMM') AS MMM,
	FORMAT(CreationTime,'MMMM') AS MMMM
FROM Sales.Orders


-- EXAMPLE

-- Show Creationtime using the following format : 
-- DAY Wed Jan Q1 2025 12:34:56 PM

SELECT 
	OrderID,
	CreationTime,
	'day' + ' ' + FORMAT(CreationTime,'ddd MMM  ') + 'Q'+ DATENAME(QUARTER,CreationTime) + ' '+
	Format(CreationTime,'yyyy  hh:mm:ss tt') AS CustomFormat
FROM Sales.Orders	

-- Data Aggregation 

SELECT 
	FORMAT(OrderDate,'MMM yy') AS Month_2025,
	COUNT(*) AS OrderByMonth
FROM Sales.Orders
GROUP BY FORMAT(OrderDate,'MMM yy') 


--CONVERT()

SELECT 
	CONVERT(INT,'123') AS [String to Integer],
	CONVERT(DATE,'08-12-2002') AS [String to Date ],
	CONVERT(DATE,CreationTime) AS [Datetime to date converter],
	CONVERT(VARCHAR,CreationTIme,32) AS [USA std. Style 32],
	CONVERT(VARCHAR,CreationTIme,34) AS [EROP std. Style 33]
FROM Sales.Orders


-- CAST() 


SELECT 
CAST('123' AS INT) AS [String to Int],
CAST(123 AS VARCHAR) AS [INT to Sring ],
CAST('2026-05-06' AS DATE) AS [STRING TO DATE],
CAST('2026-05-06' AS datetime2) AS [STRING TO DATETIME],
CreationTime,
CAST(creationTime AS DATE) AS [DATETIME TO DATE]
FROM sales.orders


-- DATEADD()
USE SalesDB

SELECT 
	OrderID,
	OrderDate,
	DATEADD(day,-10,OrderDate) AS TenDayBefore,
	DATEADD(month,3,OrderDate) AS ThreeMonthLater,
	DATEADD(YEAR,3,OrderDate) AS ThreeyearLater
FROM sales.orders


-- DATEDIFF()

SELECT 
	EmployeeID,
	BirthDate,
	DATEDIFF(year,BirthDate,GETDATE()) AS AGE 
FROM sales.Employees

-- Find The average shipping duration in days for each month 

SELECT 
	MONTH(orderDate) AS OrderDate,
	AVG(DATEDIFF(day,OrderDate,ShipDate)) AS DAY2SHIP
From Sales.Orders
GROUP BY MONTH(orderDate)

-- Find number of days betweem each order the previuos order 

SELECT 
	OrderID,
	OrderDate CurrentOrderDate,
	LAG(orderDate) OVER (ORDER BY orderDate) PreviousOrderdate ,
	DATEDIFF(day,LAG(orderDate) OVER (ORDER BY orderDate),OrderDate ) AS DIFF
FROM Sales.Orders


-- Null()

-- ISNULL()


USE SalesDB

-- Find the average score of the customers

SELECT 
	CustomerId,
	score,
	AVG(score) over() AS AVG_SCORE,
	AVG(COALESCE(Score,0)) OVER() AS AVG_SCORE2 
FROM Sales.Customers

-- Display the full name of customers in a single field
-- by merging their first and last names,
-- and add 10 bonus points to each customer's score.

SELECT 
	customerId,
	FirstName + ' ' + COALESCE(LastName,' ' ) AS [Full Name],
	Score,
	COALESCE(SCORE,0) + 10 As [ After add 10 point bonus ]
FROM Sales.Customers


--Sort the customers from lowest to highest scores,	with nulls appearing last
 
SELECT *
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END,score 


-- NULLIF ()

--Find the sales price for each order by
-- dividing the sales by the quantity.


SELECT
	OrderId,
	sales,
	Quantity,
	Sales / NULLIF(Quantity,0) as Price 
FROM sales.orders


-- Exsample 

-- Identify the customer who have no scores 

SELECT * 
FROM sales.Customers
WHERE score IS NOT NULL

-- List all the customers who have not placed order 

SELECT 
		c.*,
		o.OrderID
FROM Sales.Customers c
LEFT JOIN Sales.Orders O ON c.CustomerId=o.customerId
WHERE o.CustomerID IS NULL



SELECT * FROM Sales.Customers
SELECT * FROM sales.Orders



-- Generate a report showing the total sales for each category:
-- High: If the sales higher than 50
--Medium: If the sales between 20 and 50


SELECT 
	Category,
	SUM(sales) AS Total_Sales
FROM (
	SELECT 
		orderId,
		Sales,
	CASE 
		WHEN Sales>	50 THEN 'HIGH'
		WHEN Sales >	20 THEN 'MEDIUM'
		ELSE 'LOW'
	END Category
	FROM Sales.Orders
)t
GROUP BY Category
	

SELECT *
From Sales.Orders

SELECT *
From Sales.Products



-- Retrive employee details with gander displays  as full text 

SELECT 
	EmployeeID,
	FirstName,
	LastName,
	Gender,
	CASE 
		WHEN Gender= 'M' THEN 'MALE'
		WHEN Gender= 'F' THEN 'FEMALE'
		ELSE 'NOT Available'
		END AS GenderFullText
FROM Sales.Employees


-- -- Retrive customers details with abbreviated country code

SELECT 
	CustomerID,
	FirstName,
	LastName,
	Country,
	CASE 
		WHEN Country= 'Germany' THEN 'DE'
		WHEN Country= 'USA' THEN 'US'
	    ELSE 'N/A'
	END [Country CODE] ,

	
	CASE Country
		WHEN 'Germany' THEN 'DE'
		WHEN 'USA' THEN 'US'
	    ELSE 'N/A'
	END [Country CODE]
FROM Sales.Customers


SELECT DISTINCT Country
FROM Sales.Customers


--Find the average scores of customers and treat Nulls as O
--And additional provide details such CustomerID & LastName


SELECT 
	CustomerID,
	LastName,
	CASE 
		WHEN  SCORE IS NULL THEN 0
		ELSE SCORE 
	END [CLEANSCORE],
AVG(CASE 
		WHEN SCORE IS NULL THEN 0
		ELSE SCORE 
	END  
	)  OVER() AVG_SCORE  
FROM Sales.Customers

-- Count how many times each customer has made an order with sales greater than 30.

SELECT * FROM Sales.customers 
SELECT * FROM Sales.Orders
 
SELECT 
	CustomerID,
	SUM(CASE 
	WHEN Sales>=30 THEN 1
	ELSE 0
	END ) [>30_SALES_ORDERs],
	COUNT(*) AS TOTAL_ORDERS 
	FROM Sales.Orders
GROUP BY CustomerID