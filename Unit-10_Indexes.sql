-- INDEX  
--Type: Stuctured
-- Clustered Index  And Nonclustered Index  

--Create table for practice 

SELECT *
INTO Sales.DBCustomers
FROM Sales.Customers


--New DBCustomers created 

SELECT *
FROM Sales.DBCustomers

-- Create Indexes

CREATE CLUSTERED INDEX INX_DBCustomers_CustomerID 
ON sales.DBCUstomers(CustomerID)

--Clustered Index created for customerID 

--Create Noncluster Index fot firstName and lastName

CREATE INDEX INX_DBCustomers_FirstName
ON sales.DBCustomers(FirstName)


CREATE INDEX INX_DBCustomers_LastName
ON sales.DBCustomers(LastName)

-- Noncluster Index Created  

--==================================

-- MultiColumn Index 

CREATE INDEX inx_DBCustomers_CountryScore
ON sales.DBCustomers (Country,Score)

-- It's Created 

SELECT *
FROM Sales.DBCustomers
WHERE Country='USA' AND Score>=500 


-- SHOW INDEXES INFO

EXEC sp_MSforeachtable 'Exec sp_helpindex''?'''

-- Type : Storage 
-- Rowstore and Columnstore

--ROWSTORE 

CREATE INDEX INX_DBCustomer_ROWSTORE 
ON Sales.DBCustomers (CustomerID)

CREATE CLUSTERED INDEX INX_DBCustomer_ROWSTORE 
ON Sales.DBCustomers (CustomerID)


--COLUMNSTORE 
-- Columnstore index does not accept any column 
--MUltiple columnstore indexes are not supported 

CREATE CLUSTERED COLUMNSTORE INDEX INX_DBCustomer_COLUMNSTORE
ON Sales.DBCustomers 

DROP INDEX INX_DBCustomer_COLUMNSTORE
ON Sales.DBCustomers 


CREATE NONCLUSTERED COLUMNSTORE INDEX INX_DBCustomer_CustomerID
ON Sales.DBCustomers (CustomerID)


--=======================================
--              PROJECT
--===================================
USE AdventureWorksDW2022
-- HEAP STRUCTURE

SELECT *
INTO FactInternetSales_HP
FROM FactInternetSales

-- ROWSTORE 

SELECT *
INTO FactInternetSales_RS
FROM FactInternetSales

CREATE CLUSTERED INDEX INX_FactInternetSales_RS
ON FactInternetSales_RS (SalesOrderNumber,SalesOrderLineNumber)

-- ColumnStore

SELECT *
INTO FactInternetSales_CS
FROM FactInternetSales

CREATE CLUSTERED COLUMNSTORE INDEX INX_FactInternetSales_CS
ON FactInternetSales_CS 


-- Unique Index 
-- Can't insert duplicate value with unique index 
USE SalesDB
SELECT * 
FROM Sales.Products


CREATE UNIQUE NONCLUSTERED INDEX INX_Products_Product
ON Sales.Products (Product)

-- CHECK Duplicate values will Insert or not 
INSERT INTO Sales.Products (ProductID,Product) Values(106,'Caps')

--Filter Index 
--You cannot create a filtered index on a clustered index.
--You cannot create a filtered index on a columnstore index.

SELECT * FROM Sales.Customers 
WHERE Country='USA'

CREATE INDEX inx_Customers_Country
ON sales.Customers (Country)
WHERE Country='USA'

--Monitor Index uses

SELECT
	tbl. name AS TableName,
	idx.name AS IndexName,
	idx. type_desc AS IndexType,
	idx.is_primary_key AS IsPrimaryKey,
	idx.is_unique AS IsUnique,
	idx.is_disabled AS IsDisabled,
	s.user_seeks AS UserSeeks,
	s. user_scans AS UserScans,
	s.user_lookups AS UserLookups,
	s.user_updates AS UserUpdates,
	COALESCE(s.last_user_seek, s.last_user_scan) LastUpdate
FROM sys.indexes idx
JOIN sys.tables tbl
ON idx.object_id = tbl.object_id
LEFT JOIN sys.dm_db_index_usage_stats s
ON s.object_id=idx.object_id AND
	s.index_id=idx.index_id
Order BY tbl.name,idx.name