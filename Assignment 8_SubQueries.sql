use employee;

-- SINGLE-ROW SUB QUERIES
-- Retrieve the details of employees with salaries greater than the average salary of all employees
SELECT * FROM employees WHERE salary > (SELECT AVG(salary) FROM employees);

-- Find the employee(s) with the earliest hire date.
SELECT * FROM employees WHERE hire_date = (SELECT MIN(hire_date) FROM employees);

-- List the employee(s) with the highest salary.
SELECT * FROM employees WHERE salary = (SELECT MAX(salary) FROM employees);

-- Find the department name where the employee with the ID 5026 works
SELECT department_name,department_id FROM departments 
	WHERE department_id = 
	(SELECT department_id FROM employees WHERE employee_id = 5026);

-- Retrieve the details of employees who are working in the same department as the employee Arjun Kumar.

SELECT * FROM employees 
WHERE department_id = 
(SELECT department_id FROM employees WHERE employee_name = 'Arjun Kumar');

-- MULTI-ROW SUB QUERIES (Choose any two):
-- Retrieve the details of employees whose salaries are higher than the average salary of their respective departments.
SELECT * FROM employees e
WHERE salary > (
	(SELECT AVG(salary) FROM employees
			WHERE department_id =e.department_id)
);

-- Find the employees who work in departments with 'Development' in their name.
SELECT * 
FROM employees e JOIN departments d ON e.department_id = d.department_id
WHERE e.department_id IN 
	(SELECT department_id FROM departments 
	 WHERE department_name LIKE '%Development%');
     
-- List the department names where the average salary is greater than the average salary of the company
SELECT department_name FROM departments d 
WHERE (
		SELECT AVG(salary) FROM employees
		WHERE department_id = d.department_id
	  ) > (
		SELECT AVG(salary) FROM employees
		  );

-- Find departments where the average age of employees is less than 30.
SELECT department_name FROM departments d
WHERE (
		SELECT AVG(age) FROM employees
		WHERE department_id = d.department_id
	  ) < 30;