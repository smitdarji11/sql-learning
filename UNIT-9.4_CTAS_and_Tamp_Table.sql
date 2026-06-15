IF OBJECT_ID(sales.MonthlyOrders ,'U') IS NOT NULL
	DROP TABLE sales.MonthlyOrders
-- CTAS TABLE

GO
SELECT
	DATENAME(MONTH,OrderDate) As MonthoFOrder,
	COUNT(OrderID) AS TotalOrder
INTO sales.MonthlyOrders
FROM Sales.Orders
GROUP BY DATENAME(MONTH,OrderDate)

SELECT * 
FROM Sales.MonthlyOrders

DROP TABLE Sales.MonthlyOrders

-- TAMP TABLE 

 SELECT
	DATENAME(MONTH,OrderDate) As MonthoFOrder,
	COUNT(OrderID) AS TotalOrder
INTO #Orders
FROM Sales.Orders
GROUP BY DATENAME(MONTH,OrderDate)
