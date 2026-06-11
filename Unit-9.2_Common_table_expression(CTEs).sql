-- Step1: Find the total Sales Per Customer

WITH CTE_TOTAL_SALES AS 
(
SELECT 
	customerId,
	SUM(Sales) AS Total_sales 
FROM Sales.Orders
GROUP BY CustomerID
)
--MAIN QUERY 
 
SELECT 
c.CustomerID,
c.FirstName,
c.LastName,
cte.Total_sales
FROM Sales.Customers c
LEFT JOIN CTE_TOTAL_SALES cte
ON cte.CustomerId=c.CustomerID

--#1 STEP: Find the total sales per customer.#
--2 STEP: Find the last order date per customer.

-- Total sales CTEs 
WITH CTE_TOTAL_SALES AS 
(
SELECT 
	customerId,
	SUM(Sales) AS Total_sales 
FROM Sales.Orders
GROUP BY CustomerID
)
--Last Order Date of CTE
,CTE_LastDate AS
(
SELECT 
	CustomerId,
	Max(OrderDate) As Lastdate
FROM Sales.Orders
GROUP BY CustomerID
)
--MAIN QUERY 
 
SELECT 
	cte1.CustomerID,
	cte1.Total_sales,
	cte2.Lastdate
FROM CTE_TOTAL_SALES cte1
LEFT JOIN CTE_LastDate cte2
ON cte1.CustomerId=cte2.CustomerID

--#1 STEP: Find the total sales per customer.
--#2 STEP: Find the last order date per customer.
--#3 STEP: Rank Customers based on Total Sales Per Customer (Nested CTE)
--#4 STEP : segment Customer based on total sales

-- Total sales CTEs 
WITH CTE_TOTAL_SALES AS 
(
SELECT 
	customerId,
	SUM(Sales) AS Total_sales 
FROM Sales.Orders
GROUP BY CustomerID
)
--Last Order Date of CTE
,CTE_LastDate AS
(
SELECT 
	CustomerId,
	Max(OrderDate) As Lastdate
FROM Sales.Orders
GROUP BY CustomerID
)

-- Nested CTE
,CTE_RANK_Customer AS 
(
SELECT 
	CustomerID,
	Total_sales,
	RANK() OVER(ORDER BY Total_sales DESC) AS RANK_CUSTOMER
FROM CTE_TOTAL_SALES
),

-- SEGMENT

CTE_SEGMENT AS 
(
SELECT 
	CustomerID,
	CASE 
	WHEN Total_sales>100 THEN 'HIGH'
	WHEN Total_sales>80 THEN 'MEDIUM'
	ELSE 'LOW'	
	END AS SEGMENTATION
FROM CTE_TOTAL_SALES 
)

-- 
--MAIN QUERY 
  
SELECT 
	cte1.CustomerID,
	cte1.Total_sales,
	cte2.Lastdate,
	cte3.rank_Customer,
	cte4.SEGMENTATION
FROM CTE_TOTAL_SALES cte1
LEFT JOIN CTE_LastDate cte2
ON cte1.CustomerId=cte2.CustomerID
LEFT JOIN CTE_RANK_Customer cte3
ON cte3.CustomerId=cte1.CustomerID
LEFT JOIN CTE_SEGMENT cte4
ON cte4.CustomerId=cte1.CustomerID


-- Recursion CTE
-- -- Task: Show the employee hierarchy by displaying each employee's level within the organization

WITH CTE_hierarchy  AS 
(
	SELECT 
		EmployeeID,
		FirstName,
		LastName,
		ManagerID,
		1 AS LEVEL
	FROM Sales.Employees
	WHERE ManagerID IS NULL 
	UNION ALL 
	SELECT
		c1.EmployeeID,
		c1.FirstName,
		c1.LastName,
		C1.ManagerID,
		LEVEL + 1 
	FROM Sales.Employees AS c1
	INNER JOIN CTE_hierarchy AS c2
	ON c1.managerID=c2.EmployeeID
)

SELECT * 
FROM CTE_hierarchy
