-- Create table 

CREATE TABLE persons (
	id INT NOT NULL,
	person_name VARCHAR(50) NOT NULL,
	birthdate DATE NOT NULL,
	Phone VARCHAR(15) NULL,
	CONSTRAINT pk_persons PRIMARY KEY (id)
)

SELECT *
FROM persons

-- ALTER the table 

ALTER TABLE persons 
ADD email VARCHAR(50) NOT NULL 


ALTER TABLE persons 
DROP COLUMN phone  

SELECT *
FROM persons

-- DROP the whole table 

DROP TABLE persons

SELECT * 
FROM persons
