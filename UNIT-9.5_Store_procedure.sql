-- Step 1: Write a Query
-- For US Customers Find the Total Number of Customers and the Average Score

SELECT 
	COUNT(customerID) AS CountCustomer,
	COALESCE(AVG(SCORE),0) AS AVG_SCORE
FROM Sales.Customers
WHERE Country='USA';
 

-- Step 2: Turning the Query Into a Stored Procedure
CREATE PROCEDURE GetCustomerSummary2  @country nvarchar(50) = 'USA' AS
BEGIN
SELECT 
	COUNT(customerID) AS CountCustomer,
	COALESCE(AVG(SCORE),0) AS AVG_SCORE
FROM Sales.Customers
WHERE Country= @country;
   

SELECT 
	COUNT(*) TotalOrders,
	SUM(Sales) TotalSales
FROM Sales.Orders o
JOIN Sales.Customers c
ON c.CustomerID=o.CustomerID
WHERE Country=@country;

END

--Step 3: Execute the Stored Procedure

EXEC GetCustomerSummary2 @country='USA'


--Find the total Nr. of Orders and Total Sales

SELECT 
	COUNT(*) TotalOrders,
	SUM(Sales) TotalSales
FROM Sales.Orders o
JOIN Sales.Customers c
ON c.CustomerID=o.CustomerID
WHERE Country=@country;

DROP PROCEDURE GetCustomerSummaryGermany;

-- Total Customers from Germany: 2
-- Average Score from Germany: 425

-- Step 2: Turning the Query Into a Stored Procedure
ALTER PROCEDURE GetCustomerSummary2  @country nvarchar(50) = 'USA' 
AS
BEGIN

	DECLARE @CountCustomer INT, @AVG_SCORE FLOAT;

	BEGIN TRY
		--=========================================
		-- Step 2 : Handling Null and missing value
		--=========================================
		IF EXISTS (SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country=@country)
		BEGIN
			PRINT('Upadating null values to 0');
			UPDATE Sales.Customers
			SET SCORE = 0
			WHERE Country=@country
		END

		ELSE
		BEGIN
			Print('Not Null Value')
		END;
	
		--===============================
		-- Step 2 : Generating Reporting 
		--===============================
		--Findtotal number of customer and avg score
		SELECT 
			@CountCustomer= COUNT(customerID) ,
			@AVG_SCORE = AVG(SCORE)
		FROM Sales.Customers
		WHERE Country= @country;
   
		PRINT 'Total Customers From ' + @Country + ':' + CAST(@CountCustomer AS NVARCHAR(20));
		PRINT 'Average sales From ' + @Country + ':' + CAST(@AVG_SCORE AS NVARCHAR(20));

		--Find total orders and total sales 
		SELECT 
			COUNT(*) TotalOrders,
			SUM(Sales) TotalSales
		FROM Sales.Orders o
		JOIN Sales.Customers c
		ON c.CustomerID=o.CustomerID
		WHERE Country=@country;
	END TRY
	BEGIN CATCH
		PRINT('Error Occuerd');
		PRINT('Error message : ' + ERROR_MESSAGE());
		PRINT('Error Numbar : ' + CAST(ERROR_NUMBER() AS NVARCHAR));
		PRINT('Error Line : ' + CAST(ERROR_LINE() AS NVARCHAR));
		PRINT('Error Procedure :' + ERROR_PROCEDURE());
	END CATCH
END
GO


EXEC GetCustomerSummary2 @country='Germany'
EXEC GetCustomerSummary2
