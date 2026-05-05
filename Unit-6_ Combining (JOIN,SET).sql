
-- Joins 

-- No Join  

SELECT * 
FROM customers;

SELECT *
FROM orders;

-- Inner Join 

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers as c
INNER JOIN orders as o 
ON c.id=o.customer_id


-- LEFT Join 

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers as c 
LEFT JOIN orders as o 
ON c.id=o.customer_id


-- RIGHT Join

SELECT *
FROM customers as c 
RIGHT JOIN orders as o 
ON o.customer_id=c.id 

-- Practice question 


SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM orders as o 
LEFT JOIN  customers as c 
ON o.customer_id=c.id

-- FULL Join


SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM orders as o 
FULL JOIN  customers as c 
ON o.customer_id=c.id

-- Left anti Join

SELECT *
FROM customers as c
LEFT JOIN orders as o
ON c.id=o.customer_id
WHERE o.customer_id is NULL

-- RIGHT ANTI Join

SELECT *
FROM  customers as c 
RIGHT JOIN orders as o 
ON c.id=o.customer_id
WHERE c.id IS NULL

-- Practice Question 


SELECT *
FROM orders as o
LEFT JOIN customers as c 
ON c.id=o.customer_id
WHERE c.id IS NULL


-- FULL ANTI JOIN 

SELECT *
FROM customers as c
LEFT JOIN orders as o
on c.id=o.customer_id
WHERE o.customer_id IS NOT NULL  


-- CROSS JOIN 

SELECT *
FROM customers as c
CROSS JOIN orders as o


-- Multiple join 

USE SalesDB

SELECT 
o.OrderID,
c.firstname ,
c.lastname,
p.Product as Product_Name,
o.Sales,
p.Price,
e.Firstname as EmployeeName                                
FROM sales.Orders as o 
LEFT JOIN sales.Customers as c
ON c.CustomerID=o.CustomerID
LEFT JOIN sales.Products as p 
ON o.ProductID=p.ProductID
LEFT JOIN sales.Employees as e
ON o.SalesPersonID=e.EmployeeID

-- SET Operator

-- UNION 

SELECT 
	customerID,
	firstName ,
	LastName
FROM Sales.Customers

UNION 

SELECT 
	EmployeeID,
	FirstName,
	LastName
FROM Sales.Employees


-- UNION ALL 


SELECT 
CustomerID,FirstName,LastName
FROM Sales.Customers
UNION ALL
SELECT
EmployeeID,FirstName,LastName
FROM Sales.Employees


-- EXCEPT

-- Order of colunm is very important in EXCEPT.
SELECT 
FirstName,LastName
FROM Sales.Employees

EXCEPT

SELECT
FirstName,LastName
FROM Sales.Customers	


-- INTERSECT


SELECT 
FirstName,LastName
FROM Sales.Employees

INTERSECT

SELECT
FirstName,LastName
FROM Sales.Customers


-- EXAMPLE 
 
SELECT 
	  'Order' AS SOURCE_DATA
	  ,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM  Sales.Orders

UNION

SELECT 
	  'Order Archived' AS SOURCE_DATA
	  ,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.OrdersArchive
ORDER BY OrderID


