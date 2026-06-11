-- SUBQUERY

--RESULT TYPE 

--SCALER SUBQUERY

SELECT 
	SUM(SALES) AS SUM 
FROM Sales.Orders;

--ROW SUBQUERY 

SELECT 
	Sales 
FROM Sales.Orders;


-- TABLE SUBQUERY

SELECT * 
FROM Sales.Orders;


--Find the products that have a price higher than the average price of all products.

SELECT * 
FROM ( 
	SELECT 
		ProductId,
		Price,
		AVG(PRICE) OVER() AS AVG_Price
	FROM Sales.Products)t
WHERE Price>AVG_Price;

---- Rank Customers based on their total amount of sales

SELECT *,
	RANK() OVER( Order BY SUM_sales) AS RANKKING 
FROM 
(SELECT 
	CustomerID,
	SUM(sales) AS SUM_Sales
FROM sales.Orders
GROUP BY CustomerID)t;


-- SELECT CLAUS

-- Show the product IDs, names, price and total number of orders.

 SELECT 
	ProductID,
	Product,
	Price,
	(SELECT COUNT(*) FROM Sales.Orders) AS COUNT_ORDERS
FROM sales.Products

-- Show all customer details and find the total orders of each customer

SELECT 
	c.*,
	COUNT_Customer
FROM sales.Customers c
LEFT JOIN (
	SELECT 
		CustomerID,
		COUNT(*) AS COUNT_Customer 
	FROM sales.Orders
	GROUP BY CustomerID ) o 
ON o.customerId=c.customerId;

-- Find the products that have a price higher than the average price of all products

SELECT 
	ProductID,
	Price
FROM Sales.Products
WHERE Price > (SELECT AVG(Price) FROM Sales.Products) 

SELECT * 
FROM Sales.Products

-- Show the details of orders made by customers in Germany

SELECT 
	*
FROM Sales.Orders	
WHERE CustomerID IN (SELECT CustomerID FROM Sales.Customers WHERE Country='Germany')

-- Show the details of orders made by customers in Germany

SELECT 
	*
FROM Sales.Orders	
WHERE CustomerID IN (SELECT CustomerID FROM Sales.Customers WHERE Country !='Germany')

-- Find female employees whose salaries are greater
-- than the salaries of any male employees

SELECT * 
FROM Sales.Employees
WHERE Gender='F' AND Salary > ANY(
						SELECT Salary FROM Sales.Employees WHERE Gender='M')

-- Show all customer details and find the total orders of each customer

SELECT  * ,
	(SELECT COUNT(*) FROM Sales.Orders o WHERE o.CustomerID=c.customerId) AS CountOfOrder
FROM Sales.Customers c


-- Show the details of orders made by customers in Germany

SELECT *
FROM Sales.Orders o
WHERE  EXISTS ( SELECT 1 FROM Sales.Customers c 
				WHERE Country='Germany' 
				 AND  c.customerId=o.customerId
				);

