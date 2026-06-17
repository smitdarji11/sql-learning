-- Triggers

-- Crate table 

CREATE TABLE sales.EmpployeeLogs(
		LogId INT Identity(1,1) PRIMARY KEY,
		EmployeeID INT,
		LogMessage VARCHAR(255),
		LogDate DATE
)


--- Create trigger

CREATE TRIGGER Trg_InsertAfterEmployee ON sales.Employees
AFTER INSERT 
AS 
BEGIN 
	INSERT INTO Sales.EmpployeeLogs(EmployeeID,LogMessage,LogDate)
	SELECT EmployeeID,
		 'New EMP Added : ' + CAST(EmployeeID AS nvarchar(50)),
		 GETDATE()
	FROM inserted
END

-- ADD Data in Employee table So trigger will trigger in employeeLogs

INSERT INTO Sales.Employees
VALUES (7,'Smit','Darji','IT','2002-11-12','M',50000,3)


-- Chack employeeLogs table 

SELECT * 
FROM Sales.EmpployeeLogs 