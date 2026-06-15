-- Find running total of sales for each month 
CREATE VIEW Sales.V_Monthly_Summary AS
(
	SELECT 
		DATETRUNC(MONTH,OrderDate) OrderMonth,
		SUM(sales) TotalSales,
		COUNT( OrderId) As TotalOrders,
		SUM(Quantity) AS TotalQuantity
	From sales.orders
	GROUP BY DATETRUNC(MONTH,OrderDate) 
)

DROP View V_Monthly_Summary

-- Find running total of sales for each month using created view 

SELECT 
	OrderMonth,
	TotalSales,
	SUM(TotalSales) OVER(ORDER BY OrderMonth) AS Running_total
FROM  V_Monthly_Summary


-- Task : Create view which have contain all sales details 
CREATE VIEW Sales.V_sales_details AS
(
SELECT 
	o.orderId,
	o.OrderDate,
	p.Product,
	p.price,
	COALESCE(c.firstName,' ') + ' ' + COALESCE(c.LastName,' ') AS CustomerName,
	c.Country,
	COALESCE(e.firstName,' ') + ' ' + COALESCE(e.LastName,' ') AS SalesName,
	e.Department,
	o.Quantity,
	o.Sales
FROM Sales.Orders o
LEFT JOIN Sales.Customers c
ON c.CustomerID=o.CustomerID
LEFT JOIN Sales.Employees e
ON e.EmployeeID= o.SalesPersonID
LEFT JOIN Sales.Products p
ON p.ProductID=o.ProductID
)
-- Provide a view for EU Sales Team
--that combines details from All tables
--And excludes Data related to the USA

CREATE VIEW Sales.V_sales_details_EU AS
(
	SELECT 
		o.orderId,
		o.OrderDate,
		p.Product,
		p.price,
		COALESCE(c.firstName,' ') + ' ' + COALESCE(c.LastName,' ') AS CustomerName,
		c.Country,
		COALESCE(e.firstName,' ') + ' ' + COALESCE(e.LastName,' ') AS SalesName,
		e.Department,
		o.Quantity,
		o.Sales
	FROM Sales.Orders o
	LEFT JOIN Sales.Customers c
	ON c.CustomerID=o.CustomerID
	LEFT JOIN Sales.Employees e
	ON e.EmployeeID= o.SalesPersonID
	LEFT JOIN Sales.Products p
	ON p.ProductID=o.ProductID
	WHERE c.Country !='USA'
)

SELECT * 
FROM Sales.V_sales_details_EU