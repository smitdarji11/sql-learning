-- Window FUnction 
--Basic of window function 

-- Find the total sales across all orders 

USE SalesDB

SELECT 
	sum(sales) as Total_sales 
FROM Sales.Orders;

-- Find the total sales for each product 

SELECT 
	ProductID,
	SUM(sales) Total_sales 
FROM Sales.Orders
GROUP BY ProductID;

-- Find the total sales for each product additionally provide details such order id, order date

SELECT 
	OrderID,
	OrderDate,
	ProductID,
	SUM(sales) OVER(PARTITION BY ProductId) AS Sales_Of_product  
FROM Sales.Orders;


--Find the total sales across all orders additionally provide details such order id & order date.

SELECT 
	OrderDate,
	OrderId,
	SUM(sales) OVER() AS Total_sales  
FROM Sales.Orders;

--Find the total sales for each Product additionally provide details such order id & order date.

SELECT 
	OrderDate,
	OrderId,
	ProductId,
	SUM(sales) OVER(PARTITION BY ProductId) AS Total_sales  
FROM Sales.Orders;

--Find the total sales for each Product additionally provide details such order id & order date.
----Find the total sales across all orders

SELECT 
	OrderDate,
	ProductId,
	Sales,
	SUM(sales) OVER() AS Total_sales ,
	SUM(sales) OVER (PARTITION BY ProductId) AS Total_Sales_By_Orders
FROM Sales.Orders;


--Find the total sales for each Product additionally provide details such order id & order date.
--Find the total sales across all orders
-- FInd the total sales for each combination of productid and product Status 

SELECT 
	OrderDate,
	ProductId,
	Sales,
	SUM(sales) OVER() AS Total_sales ,
	SUM(sales) OVER (PARTITION BY ProductId) AS Total_Sales_By_Orders,
	SUM(sales) OVER(PARTITION BY ProductId,OrderStatus) AS SalesByProductOrderstatus
FROM Sales.Orders;

--Rank each order based on their sales from highest to lowest, additionally provide details such order id & order date

SELECT 
	OrderId,
	Orderdate,
	Sales,
	RANK() OVER(ORDER BY Sales DESC) As Ranksales
FROM Sales.Orders;

--  Rank Customers based on their total sales

SELECT 
	CustomerID,
	SUM(Sales) As Totalsales,
	RANK() OVER(ORDER BY SUM(Sales) DESC) As RANK_
FROM Sales.Orders
GROUP BY CustomerID

-- aggergate Function 
-- Count(),Sum(),Avg(),MIN(),MAX()

-- Find total number of order  With order Id and order date partition of each customer

SELECT 
	CustomerID,
	OrderID,
	OrderDate,
	COUNT(*) OVER(PARTITION BY CustomerId)
FROM Sales.Orders

--Find the total number of customers
--additionally provide all customer's details

SELECT 
	*,
	COUNT(customerID) OVER() AS COUNT_TOTAL
FROM sales.Customers;

-- Find the total number of Score 

SELECT * ,
	COUNT(Score) OVER() AS TOTAL_Score
FROM Sales.Customers;

--CHECK DUPLICATE 

SELECT * 
FROM (
		SELECT 
			OrderID,
			COUNT(1) OVER(PARTITION BY orderID) AS CHECK_DUPLICATE
		FROM Sales.OrdersArchive
)t WHERE CHECK_DUPLICATE>1


-- SUM() 
-- Find the total sales across all orders and the total sales for each product.Additionally,
--provide details such as order ID and order date.


use SalesDB

SELECT 
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	SUM(sales) Over( ) AS TotalSalesByOrders,
	SUM(sales) OVER(PARTITION BY ProductID) As SalesByProduct
FROM sales.Orders;

--Find the percentage contribution of
--each product's sales to the total sales

SELECT 
	OrderId,
	productId,
	sales,
	SUM(sales) OVER() AS Total_sales ,
	ROUND(CAST(sales As float)/SUM(sales) OVER()*100,2)  AS Percentage_of_sales
FROM Sales.orders;

--AVG()

--Find the average sales across all orders
--and the average sales for each product.
--Additionally, provide details such as order ID and order dat

SELECT
	OrderDate,
	OrderDate,
	Sales,
	ProductID,
	AVG(Sales) OVER() AS AVG_Sales,
	AVG(sales) Over(PARTITION  BY ProductId) AS AVG_SALES_BY_PRODUCT
FROM Sales.Orders;

--Find the average scores of customers.
--Additionally, provide details such as Customer ID and Last Name

SELECT 
	CustomerID,
	LastName,
	Score,
	COALESCE(SCORE,0) AS CustomerScore,
	AVG(COALESCE(SCORE,0)) OVER() AS AVG_SCORE
FROM Sales.Customers;

-- Find all orders where sales are higher than the average sales across all orders

SELECT *
FROM (
	SELECT 
		orderID,
		sales,
		AVG(Sales) OVER() AS AVG_SALES
	FROM Sales.orders
)t WHERE sales>AVG_SALES

-- Find the highest and lowest sales of all orders
--Find the highest and lowest sales for each product
-- Additionally provide details such order Id, order date


SELECT 
	orderID,
	OrderDate,
	MAX(sales) OVER() AS MaxSales,
	MIN(sales) OVER() AS MinSales,
	MAX(sales) OVER(PARTITION BY productID) AS MaxSalesByProduct,
	MIN(sales) OVER(PARTITION BY productID) AS MinSalesByProduct
FROM Sales.Orders

-- Show the employees who have a highest salaries

SELECT *
FROM ( 
		SELECT 
			*,
			MAX(Salary) OVER() AS HighestSalary 
		FROM sales.Employees
)t Where salary=HighestSalary;

--Calculate the moving average of sales for each product over time

SELECT 
	OrderDate,
	OrderDate,
	ProductID,
	Sales,
	AVG(Sales) OVER(PARTITION BY productID) AS AvgByProduct,
	AVG(Sales) OVER(PARTITION BY productId ORDER BY OrderDate) As Moving_Avarage,
	AVG(Sales) OVER(PARTITION BY productId ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING ) As ROLLING_Avarage
FROM Sales.Orders;

-- WINDOW RANK FUNCTION

--RANK() , ROW_NUMBER() ,DENSE_RANK()

--Rank the orders based on their sales from highest to lowest

SELECT 
	OrderID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) AS SaleRow_number,
	RANK() OVER(ORDER BY Sales DESC) AS SalesRank_number,
	DENSE_RANK() OVER(ORDER BY Sales DESC) AS SalesDense_Rank
FROM Sales.Orders;

-- Find the top highest sales for each product

SELECT * 
FROM (
SELECT 
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(PARTITION BY ProductId ORDER BY SALES) AS SalesByProduct 
FROM Sales.Orders
)t WHERE SalesByProduct = 1;

-- Find the lowest 2 customers based on their total sales

SELECT *
FROM ( 
SELECT 
	CustomerID,
	SUM(Sales) As Total_sales ,
	ROW_NUMBER() OVER(ORDER BY SUM(Sales)) As Row_Rank
FROM Sales.Orders
GROUP BY CustomerID 
)t WHERE Row_Rank<3


-- ASSing unique IDs to the rows of the 'OrderArchive'  table

SELECT 
ROW_NUMBER() OVER(ORDER BY OrderId) As Sr_No,
*
FROM Sales.OrdersArchive;
	 
--Identify duplicate rows in the table 'Orders Archive' and return a clean result without any duplicates

SELECT * FROM(
SELECT 
	ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime) As rn,
	*
FROM Sales.OrdersArchive)t
WHERE rn>2

-- NTILE 

SELECT 
	Orderid,
	Sales,
	NTILE(4) OVER(ORDER BY Sales) As FourBucket,
	NTILE(3) OVER(ORDER BY Sales) As ThreeBucket,
	NTILE(2) OVER(ORDER BY Sales) As TwoBucket,
	NTILE(1) OVER(ORDER BY Sales) As OneBucket
FROM Sales.Orders;

-- Segment all orders into 3 categories: high , medium and low sales.

SELECT 
	*,
	CASE WHEN Buckets= 1 THEN 'HIGH'
		WHEN Buckets= 2 THEN 'Medium '
		WHEN Buckets= 3 THEN 'Low'
END AS SaleSegmentation
FROM (
SELECT
	OrderId,
	sales,
	NTILE(3) OVER(ORDER BY Sales DESC) AS Buckets 
FROM Sales.Orders)t

--Cume_dist

-- Find the products that fall within the highest 40% of the prices.

SELECT *,
	CONCAT(CUME_DIST*100,'%') AS IN_Percentage
FROM (
	
SELECT 
	Product,
	Price,
	CUME_DIST() OVER(ORDER BY Price DESC) AS CUME_DIST
FROM Sales.Products
)t WHERE CUME_DIST<=0.4

SELECT *
FROM Sales.Products

-- WINDOW VALUE FUNCTION 

--LEAD() LAG()

--Analyze the month-over-month (MoM) performance by finding the percentage change in sales
--between the current and previous month

use SalesDB

SELECT *,
	CurrentMonthSales-PreviosMonthSales AS MON_Change,
	ROUND(CAST((CurrentMonthSales-PreviosMonthSales) AS FLOAT) / PreviosMonthSales *100,1) AS MON_Change
FROM (	
SELECT 
	MONTH(OrderDate) AS ORDER_MONTH,
	SUM(sales) AS CurrentMonthSales ,
	LAG(SUM(sales)) OVER(ORDER BY MONTH(OrderDate)) AS PreviosMonthSales
FROM Sales.Orders
GROUP BY 
	MONTH(OrderDate)
)t 

-- In order to analyze customer loyalty,
-- rank customers based on the average days between their orders

SELECT 
	CustomerID,
	AVG(DaysBetweenOrder) AS AVGDAYS,
	RANK() OVER(ORDER BY COALESCE(AVG(DaysBetweenOrder),9999)) AS RANK_CUSTOMER
FROM( 
SELECT 
	OrderID,
	CustomerID,
	OrderDate AS CurrentOrderDate,
	LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS PreviousOrderDate,
	DATEDIFF(DAY,OrderDate,LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate)) As DaysBetweenOrder
FROM Sales.Orders
)t
GROUP BY CustomerID

---- Find the lowest and highest sales for each product

SELECT 
	OrderID,
	ProductID,
	Sales,
	FIRST_VALUE(Sales) OVER( PARTITION BY ProductID ORDER BY Sales) AS Lowest_sales,
	LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales
	ROWS BETWEEN CURRENT ROW AN	D UNBOUNDED FOLLOWING  )  AS Highest_sales
FROM Sales.Orders











