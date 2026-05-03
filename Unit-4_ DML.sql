-- Use of INSERT

USE MyDatabase

INSERT INTO customers ( id,first_name,country,score)
VALUES ( 6,'Smit','India',890),
	   (7,'Pranita','India',900)

SELECT *
FROM customers

-- INSERT using SELECT

SELECT *
FROM customers

INSERT INTO persons(id,person_name,birthdate,phone,email)
SELECT 
	id,
	first_name,
	'unknown',
	'Unknown',
	NULL
FROM customers		

FROM customers

--UPDATE query

INSERT INTO customers ( id,first_name,country,score)
VALUES ( 8,'UK','Martin',890)

UPDATE customers
SET first_name='Martin',
	country='India'
WHERE id=8

SELECT * FROM customers

-- example 

UPDATE customers
SET score=350
WHERE id=5

UPDATE customers
SET score=0
WHERE score is NULL

SELECT * FROM customers

-- Delete the rows 

DELETE FROM customers
WHERE id > 5


DELETE FROM persons

-- Truncate
 TRUNCATE table persons