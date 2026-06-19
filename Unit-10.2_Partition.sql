--#1.Creating Partition 

CREATE PARTITION  FUNCTION PartitionByYear (DATE) 
AS RANGE LEFT FOR VALUES ('2023-12-31','2024-12-31','2025-12-31')

--Query for list of partition  

SELECT 
	Name,
	function_id,
	type,
	type_desc,
	boundary_value_on_right
FROM sys.partition_functions

-- #2Create file group 

ALTER DATABASE SALESDB ADD FILEGROUP FG2023;
ALTER DATABASE SALESDB ADD FILEGROUP FG2024;
ALTER DATABASE SALESDB ADD FILEGROUP FG2025;
ALTER DATABASE SALESDB ADD FILEGROUP FG2026;

ALTER DATABASE SALESDB REMOVE FILEGROUP FG2023;

-- Query lists all filegroup 

SELECT *
FROM sys.filegroups
WHERE type='FG'

SELECT DB_NAME()

-- #3 ADD .ndf Files to each Filegroup 

ALTER DATABASE salesDB ADD FILE
(
	name=P_2023, -- Logical name
	filename=
	'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2023.ndf'
) TO FILEGROUP FG2023;


ALTER DATABASE salesDB ADD FILE
(
	name=P_2024, -- Logical name
	filename=
	'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2024.ndf'
) TO FILEGROUP FG2024;

ALTER DATABASE salesDB ADD FILE
(
	name=P_2025, -- Logical name
	filename=
	'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2025.ndf'
) TO FILEGROUP FG2025;


ALTER DATABASE salesDB ADD FILE
(
	name=P_2026, -- Logical name
	filename=
	'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2026.ndf'
) TO FILEGROUP FG2026;

-- Query to show all created .ndf all 

SELECT
	fg.name As FileGroupName,
	mf.name As LogicalFileName ,
	mf.physical_name AS Physical_name,
	mf.size /128 AS SizeInMB
FROM sys.filegroups fg
JOIN sys.master_files mf ON mf.data_space_id=fg.data_space_id
WHERE 
	mf.database_id=DB_ID('SalesDB');

-- #4 Create partition Scheme

CREATE PARTITION SCHEME SchemePartitionByYear 
AS PARTITION PartitionByYear 
TO(FG2023,FG2024,FG2025,FG2026);

-- Query lists all Partition Scheme
SELECT
ps. name AS PartitionSchemeName,
pf.name AS PartitionFunctionName,
ds.destination_id AS PartitionNumber,
fg. name AS FilegroupName
FROM sys. partition_schemes ps
JOIN sys.partition_functions pf ON ps. function_id = pf. function_id
JOIN sys. destination_data_spaces ds ON ps. data_space_id = ds. partition_scheme_id
JOIN sys. filegroups fg ON ds. data_space_id = fg.data_space_id


-- #5 Create the Partitioned Table

CREATE TABLE Sales.Orders_Patitioned (
		OrderID INT,
		OrderDate Date,
		Sales INT 
) ON SchemePartitionByYear (OrderDate);

--# 6. Insert the value in Partitioned Table

INSERT INTO Sales.Orders_Patitioned 
VALUES 
	(1,'2023-04-28',1000),
	(2,'2024-12-11',1400),
	(3,'2025-03-21',900),
	(4,'2026-11-11',1200)
;

SELECT * FROM Sales.Orders_Patitioned

-- Query for list count of values in each partitions

SELECT 
	p.Partition_Number AS PartitionNumber,
	f.name AS PartitionFileGroup,
	p.Rows As NumberOfRows 
FROM sys.partitions p
JOIN sys.destination_data_spaces d On d.destination_id=p.partition_number
JOIN sys.filegroups f ON f.data_space_id=d.data_space_id
WHERE OBJECT_NAME(p.object_id)='Orders_patitioned';

