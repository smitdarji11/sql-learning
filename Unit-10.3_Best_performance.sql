--=====================================
--Tip-1 Select only what you need
--====================================

-- Bad Practice 
SELECT * FROM Sales.Customers

--Good Practice 
SELECT 
	CustomerID,
	FirstName,
	LastName
FROM Sales.Customers;

--============================================
--Tip-2 Avoid Unnecessary DISTINCT & ORDER BY 
--============================================

--Bad Practice
SELECT DISTINCT
	FirstName
FROM Sales.Customers
ORDER BY FirstName;

--Good Practice
SELECT 
	FirstName
FROM Sales.Customers;

--=====================================
--Tip-3 For Exploration Perpose , LIMIT Rows!
--====================================
--Bad Practice
SELECT 
	OrderID,
	Sales
FROM Sales.Orders;

--Good Practice
SELECT TOP 10 
	OrderID,
	Sales
FROM Sales.Orders;

--=========================================================================
--Tip-5 Create nonclustered Index on frequently used Columns in WHERE clause
--============================================================================
-- BAD Practice 
SELECT * FROM Sales.Orders WHERE OrderStatus='Devivered';

-- Good Practice 
CREATE NONCLUSTERED INDEX inx_Orders_os ON Sales.Orders(OrderStatus)


--======================================================
--Tip-6 Avoid applying fuctions to column in where clauses
--=======================================================

--BAD Practice
SELECT * FROM Sales.Orders
WHERE LOWER(OrderStatus) = 'delivered';

-- Good practice 
SELECT * FROM Sales.Orders
WHERE OrderStatus = 'Delivered';

--BAD Practice
SELECT * FROM Sales.Customers
WHERE SUBSTRING(FirstName,1,1) = 'A';

--GOOD Practice
SELECT * FROM Sales.Customers
WHERE FirstName like 'A%';

--BAD Practice
SELECT * 
FROM Sales.Orders
WHERE YEAR(OrderDate)='2025';

--GOOD Practice
SELECT * 
FROM Sales.Orders
WHERE OrderDate BETWEEN '2025-01-01' AND '2025-12-31';

--======================================================
--Tip-7 Avoid leading wildcards as they prevent index usage
--=======================================================

--BAD Practice
SELECT *
FROM Sales.Customers
WHERE LastName LIke '%GOLD%';

-- Good practice 
SELECT *
FROM Sales.Customers
WHERE LastName LIke 'GOLD%';

--======================================================
--Tip-7 Use IN Insted Of Myltiple OR
--=======================================================

--BAD Practice
SELECT * 
FROM Sales.Orders
WHERE CustomerID=1 OR CustomerID=2 OR CustomerID=3;
 
-- Good practice 
SELECT * 
FROM Sales.Orders
WHERE CustomerID IN (1,2,3);
 

 --======================================================
--Tip-8 Understand The Speed of Joins & Use INNER JOIN when possible
--=======================================================

--BEST Performance 
SELECT c.firstName,o.orderId FROM Sales.Customers c INNER JOIN Sales.Orders o ON c.CustomerID=o.CustomerID 

-- Slighty Slow In Perfomace 
SELECT c.firstName,o.orderId FROM Sales.Customers c RIGHT JOIN Sales.Orders o ON c.CustomerID=o.CustomerID 
SELECT c.firstName,o.orderId FROM Sales.Customers c LEFT JOIN Sales.Orders o ON c.CustomerID=o.CustomerID 

-- WORST Performace
SELECT c.firstName,o.orderId FROM Sales.Customers c OUTER JOIN Sales.Orders o ON c.CustomerID=o.CustomerID 

--===========================================================================
--Tip-9 Use Explicit Join (ANSI Join) Instead of Implicit Join (non-ANSI Join)
--============================================================================

--BAD Practice
SELECT * 
FROM Sales.Customers c,Sales.Orders o
WHERE c.CustomerID=o.CustomerID;

-- Good practice 
SELECT o.OrderID,c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID=o.CustomerID;

--======================================================
--Tip-10 Make sure to Index the columns used in the ON clause
--=======================================================

SELECT o.OrderID,c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID=o.CustomerID;

-- USE INdex FRO customerID
CREATE NONCLUSTERED INDEX inx_Order_OID 
ON sales.Orders(CustomerID)

--==============================================
--Tip 11: Filter Before Joining (Big Tables)
--=============================================
-- Filter After Join (WHERE)

SELECT c. FirstName, o. OrderID
FROM Sales. Customers c
INNER JOIN Sales. Orders o
ON c. CustomerID = o. CustomerID
WHERE o. OrderStatus = 'Delivered'

-- Filter During Join (ON)
SELECT c. FirstName, o. OrderID
FROM Sales. Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
AND o. OrderStatus = 'Delivered'

-- Filter Before Join (SUBQUERY)
SELECT c. FirstName, o. OrderID
FROM Sales. Customers c
INNER JOIN (SELECT OrderID, CustomerID FROM Sales. Orders WHERE OrderStatus = 'Delivered') o
ON c. CustomerID = o. CustomerID

--==============================================
-- Tip 12: Aggregate Before Joining (Big Tables)
--===============================================
-- For Small-Medium Table
-- Grouping and Joining
SELECT c.CustomerID, c. FirstName, COUNT(o.orderId) AS [TOtal Order]
FROM Sales. Customers c
INNER JOIN Sales.Orders o
ON c. CustomerID = o. CustomerID
GROUP BY c. CustomerID, c. FirstName

--For Large And Big Table
-- Pre-aggregated Subquery
SELECT c. CustomerID, c. FirstName, o.OrderCount
FROM Sales. Customers c
INNER JOIN (
		SELECT CustomerID, COUNT(OrderID) AS OrderCount
		FROM Sales.Orders
		GROUP BY CustomerID) o
ON c. CustomerID = o. CustomerID

-- WORST Performace
-- Correlated Subquery
SELECT
	c. CustomerID,
	c.FirstName,
	(SELECT COUNT(o.OrderID)
	FROM Sales.Orders o
	WHERE o. CustomerID = c.CustomerID) AS OrderCount
FROM Sales.Customers c
