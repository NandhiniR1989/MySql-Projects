use employee;

-- ORDER BY --

-- Retrieve employee names and salaries from the Employees table, ordered by salary in descending order.
SELECT employee_name,salary FROM employees
	ORDER BY salary DESC;
    
-- List employees hired after January 1, 2019, ordered by hire date.
SELECT hire_date FROM employees 
	WHERE hire_date >'2019-01-01' 
    ORDER BY hire_date;

-- Display employee names and designations, sorted alphabetically by name.
SELECT employee_name, designation FROM employees
	ORDER BY employee_name;
    
-- Find employees sorted by department ID in ascending order and salary in descending order.
SELECT * FROM employees
	ORDER BY department_ID, salary DESC;
    
-- List employees sorted by gender and location ID in ascending order
SELECT * FROM employees
	ORDER BY gender, location_ID;

-- LIMIT -- 
-- Retrieve the top 10 highest paid employees from the Employees table
SELECT * FROM employees
	ORDER BY salary DESC
    LIMIT 10;
    
-- Display the first 5 employees hired in the year 2018.
SELECT * FROM employees
	WHERE hire_date > '2017-12-31'
    ORDER BY hire_date LIMIT 5;

-- List the name and designation of the 3 most recently hired employees.
SELECT employee_name, designation FROM employees
	ORDER BY hire_date DESC LIMIT 3;
    
-- Retrieve the oldest employee in the database.
SELECT * FROM employees
	ORDER BY hire_date LIMIT 1;

SELECT * FROM employees
	ORDER BY employee_id LIMIT 1;

-- Display the first 10 female employees hired.
SELECT * FROM employees
	WHERE NOT gender = 'M'
    ORDER BY hire_date LIMIT 10;
    
-- AGGREGATE FUNCTION --

 -- Calculate the average salary of all employees.
SELECT AVG(salary) FROM employees;

-- Find the maximum salary among all employees.
SELECT MAX(salary) FROM employees;

-- Determine the total number of employees.
SELECT COUNT(*) FROM employees;

 -- Calculate the sum of all salaries in the Finance department.
 SELECT SUM(salary) FROM employees WHERE department_id = 7;
 
 -- Find the minimum age among all employees.
 SELECT MIN(age) AS min_age FROM employees;
 
 -- GROUP BY --
 
 -- Display the total count of employees in each department.
 SELECT department_id, COUNT(employee_id) AS No_of_employee
	FROM employees
    GROUP BY department_id;
 
-- Calculate the average salary for each location.
  SELECT location_id, AVG(salary) AS Avg_Salary
	FROM employees
    GROUP BY location_id;

-- Display the total count of male and female employees.
SELECT gender, COUNT(gender) FROM employees
	GROUP BY gender;
    
-- List the average salary for each designation containing the word 'Analyst'.
SELECT designation, AVG(salary) AS Avg_Salary 
	FROM employees
	WHERE designation LIKE ('%Analyst%')
    GROUP BY designation;
   
-- Calculate the total salary expense for employees hired in each year.
SELECT hire_date, SUM(salary) As Total_Salary
	FROM employees
    WHERE YEAR(hire_date)
    GROUP BY hire_date;
    
    -- HAVING --
    
-- Find departments with less than 3 employees.
SELECT department_id FROM employees
GROUP BY department_id
HAVING COUNT(department_id) < 3;

-- Calculate the average salary for departments having at least 3 employees.
SELECT department_id, AVG(salary) FROM employees
	GROUP BY department_id
	HAVING COUNT(department_id) >= 3;

-- Display the locations with average salary 75000 or more.
SELECT location_id, AVG(salary) as Avg_Salary FROM employees
	GROUP BY location_id
	HAVING Avg_Salary >= 75000 ;

-- List the departments in Chennai with average salary 60000 or less.	
SELECT department_id, location_id, AVG(salary) AS Avg_Sal FROM employees
	WHERE location_id = 1
	GROUP BY department_id
	HAVING Avg_Sal <= 60000;

-- Find locations with female employees whose average age is below 30.
SELECT location_id, gender, AVG(age) As Avg_Age FROM employees
	WHERE gender = 'F'
    GROUP BY location_id
    HAVING Avg_Age <30;

--  Display departments with at least 2 male employees and an average salary exceeding 60000.
SELECT department_id, gender, count(gender) as Gender_Count, AVG(salary) Avg_Sal FROM employees
	WHERE gender = 'M'
    GROUP BY department_id
    HAVING Gender_Count >=2 and Avg_Sal >60000;
    