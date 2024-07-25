-- CONSTRAINTS --

-- DROP IF EXISTS -- 
DROP DATABASE IF EXISTS employee;

-- RECREATE DATABASE --
CREATE DATABASE IF NOT EXISTS employee;

USE employee;

-- CREATE TABLES --
-- COMPOSITE KEY Constraint is used -- 

CREATE TABLE departments
(
	department_id Int,
    department_name varchar(100),
    PRIMARY KEY(department_id,department_name) 
);

-- AUTO INCREMENT, UNIQUE, NOT NULL AND PRIMARY KEY CONSTRAINTS ARE USED --

CREATE TABLE locations
(
	location_id int AUTO_INCREMENT,
    location varchar(30) UNIQUE NOT NULL,
    PRIMARY KEY(location_id)
);

-- NOT NULL, CHECK, DEFAULT, PRIMARY KEY AND FOREIGN KEY Constraints are used --

CREATE TABLE employees
(
	employee_id int,
    employee_name varchar(50) NOT NULL,
    gender enum('M','F') not null,
    age int CHECK (age>=18),
    hire_date date DEFAULT (current_date),
    designation varchar(100),
    department_id int,
    location_id int,
    salary decimal(10,2) NOT NULL,
    PRIMARY KEY (employee_id),
    FOREIGN KEY(department_id) REFERENCES departments(department_id),
    FOREIGN KEY(location_id) REFERENCES locations(location_id)
);



SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
	WHERE TABLE_SCHEMA = 'employee' and TABLE_NAME = 'employees';


SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM locations;