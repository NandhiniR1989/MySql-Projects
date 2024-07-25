use employee;


-- BUILT-IN NUMERIC FUNCTION
 -- Find the average age of employees, rounded off to the nearest integer.
SELECT Avg(age) as Avg_Sal, ROUND(AVG(age)) as Round_Avg_Age FROM employees;

-- Determine the average salary of employees and round it down to the nearest smaller integer.
SELECT Avg(salary) as Avg_Sal, FLOOR(Avg(salary)) as Floor_AvgSal FROM employees;

-- Filter employees whose ID is an even number.
SELECT * FROM employees WHERE MOD(employee_id,2) = 0;

-- Retrieve all employee records including a bonus column, calculated as the square root of their salary rounded up to the nearest larger integer.
SELECT *,ROUND(SQRT(salary)) as BONUS FROM employees;

/*  .
⦿  Find the length of department names.
⦿  Concatenate employee names with their designations separated by a hyphen.*/
-- BUILT-IN STRING FUNCTIONS
-- Convert all employee names to uppercase.
SELECT employee_name,UPPER(employee_name) AS CapsEmployee_Name FROM employees;

-- Extract the first three characters from the location names
SELECT SUBSTRING(location,1,3) FROM locations;