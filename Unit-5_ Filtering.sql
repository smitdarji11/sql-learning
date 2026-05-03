-- Comparision Operator 

--  = Operator 
SELECT * 
FROM customers 
WHERE country='Germany';

-- != Operator 

SELECT *
FROM customers 
WHERE country!='Germany';

-- > Operator 

SELECT *
FROM customers 
WHERE score >500;

-- >= Operator 

SELECT *
FROM customers 
WHERE score >=500;

-- < Operator 

SELECT *
FROM customers 
WHERE score < 500;

-- <= Operator

SELECT *
FROM customers 
WHERE score <= 500;


-- LOGICAL Operator

-- AND Operator 

SELECT * 
FROM customers 
WHERE country='USA' AND score>500

-- OR Operator 

SELECT * 
FROM customers 
WHERE country='USA' OR score>500

-- NOT Operator 

SELECT * 
FROM customers 
WHERE NOT score >= 500 

-- RANGE Operator 

-- BETWEEN Operator 

SELECT * 
FROM customers 
WHERE score BETWEEN 100 AND 500


-- MEMBERSHIP Operator 

SELECT * 
FROM customers
WHERE Country IN ('Germany','USA')

-- SEARCH Operator 

-- LIKE Operator 

SELECT * 
FROM customers 
WHERE first_name LIKE 'M%'


SELECT * 
FROM customers 
WHERE first_name LIKE '%N'

SELECT * 
FROM customers 
WHERE first_name LIKE '%R%'


SELECT * 
FROM customers 
WHERE first_name LIKE 'R%'


SELECT * 
FROM customers 
WHERE first_name LIKE '__r%'
