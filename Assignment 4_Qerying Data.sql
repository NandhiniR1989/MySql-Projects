use employee;
Select * from employees;
select * from departments;
select * from locations;

-- DISTINCT VALUE --

SELECT DISTINCT salary from employees; -- Distinct salary
SELECT DISTINCT gender from employees;  -- Distinct gender

-- ALIAS --

SELECT *, employee_name AS Employee_Name from employees; -- Alias employee_name into Employee_Name
SELECT age Employee_Age, salary AS Employee_Salary from employees; -- Alias name for age and salary

-- WHERE CLAUSE --

SELECT * from employees WHERE hire_date > '2018-01-01'; -- select hire_date is "greater than" 01-Jan-2018
SELECT * from employees WHERE salary < 60000; -- select salary "less than" 60000
SELECT * from employees WHERE gender = 'F'; -- select gender "equal to" Female

-- OPERATORS (ARITHEMTIC, COMPARISON, LOGICAL) --

SELECT *,salary+(salary*0.10) AS net_salary from employees; -- +,* Arithmetic Operator is USED
SELECT * FROM employees WHERE salary > 50000 AND hire_date <'2016-01-01';  -- "<", ">" comparison and  "AND" Logical Operators are USED
SELECT * FROM employees WHERE gender = 'M' AND age >= 30; -- "=", ">=" comparison and "AND" Logical Operators are used
SELECT *FROM employees WHERE designation = 'Data Analyst' OR  designation = 'Data Scientist'; -- OR Logical Operator is used

-- OTHER OPERATORS --

UPDATE employees SET designation = 'Data Scientist' WHERE designation IS NULL; -- IS NULL used
SELECT * FROM employees WHERE department_id IN (1,3,4,9,12); -- IN used
SELECT * FROM employees WHERE age BETWEEN 25 AND 30; -- BETWEEN used
SELECT * FROM employees WHERE salary NOT BETWEEN 50000 AND 80000; -- NOT BETWEEN used
SELECT * FROM employees WHERE employee_name like ('A%') 
							OR employee_name like ('E%') 
                            OR employee_name like ('I%') 
                            OR employee_name like ('O%') 
							OR employee_name like ('U%'); -- Name starts with Vowel is displayed MODULAR and OR Operators are used
 SELECT * FROM employees WHERE designation like ('%st') ; -- Designation ended with st displayed
 SELECT * FROM employees WHERE designation like ('%Manager%'); -- Designation having Manager is displayed
 SELECT * FROM employees WHERE employee_name like ('_sh%'); -- Name with sh as 2nd and 3rd character is displayed