use employee;

-- INNER JOIN --

-- Retrieve employee names and their corresponding department names from the Employees and Departments tables using an inner join.
SELECT E.employee_name, D.department_name FROM employees AS E
	INNER JOIN departments AS D
    ON E.department_id =  D.department_id;
    
-- List employee names, their designations, and department names where employees are assigned to a department.
SELECT E.employee_name, E.designation, D.department_name FROM employees AS E
	JOIN departments AS D
    ON E.department_id =  D.department_id;
    
-- Display employee names and their respective location names from the Employees and Location tables using an inner join.

SELECT E.employee_name, L.location FROM employees E
INNER JOIN locations L
ON E.location_id = L.location_id;

-- LEFT JOIN --
-- Retrieve all employees and their corresponding department names. 
-- If an employee is not assigned to any department, display NULL for department name.
SELECT E.*, D.Department_name FROM employees AS E
LEFT JOIN departments AS D
ON E.department_id = D.department_id;

-- List all departments along with the total number of employees in each department, including departments with no employees.
SELECT D.department_name , count(E.employee_id) as EmpCount FROM departments D
LEFT JOIN employees E
ON D.department_id = E.department_id
GROUP BY D.department_name;

-- Display all employees and their respective location names. 
-- If an employee's location is not specified, display NULL for location name.
SELECT E.employee_name, L.location FROM employees E
LEFT JOIN locations AS L
ON E.location_id = L.location_id;

-- RIGHT JOIN --
-- Retrieve all departments and their corresponding employee names. 
-- If a department has no employees, display NULL for employee name.
SELECT D.department_name,E.employee_name FROM Departments D
RIGHT JOIN employees E
ON E.department_id = D.department_id;

-- List all employees along with their department names. If an employee is not assigned to any department, display NULL for department name.
SELECT E.employee_name,D.department_name FROM employees As E
RIGHT JOIN departments As D
ON D.department_id = E.department_id;

-- Display all locations along with the names of employees assigned to each location.
--  If no employees are assigned to a location, display NULL for employee name.

SELECT L.location, E.employee_name FROM locations AS L
RIGHT JOIN employees AS E
ON L.location_id = E.location_id;

-- UNION AND UNION ALL --
-- Retrieve the details of the top three highest-paid employees and the bottom three lowest-paid employees. 
-- Combine the results using UNION and compare the merged data to understand the salary distribution within the company.
(SELECT *, 'Low' As Sal_Category FROM employees  ORDER BY salary LIMIT 3)
	UNION
(SELECT *, 'High' As Sal_Category FROM employees ORDER BY salary desc LIMIT 3);

-- Combine the names of employees who have a salary above 75,000 in the IT department with that of 
-- those located in Bangalore with a salary above 60,000. Compare the result sets obtained using UNION 
-- and UNION ALL to identify any differences in the merged data.

(SELECT E.employee_name,E.department_id FROM employees as E 
JOIN departments D ON E.department_id = D.department_id
	WHERE D.department_name = 'IT' AND E.salary > 75000)
UNION
(SELECT E.employee_name, E.location_id FROM Employees as E
JOIN locations L ON E.location_id = L.location_id
	WHERE L.location = 'Bangalore' AND Salary > 60000);

-- Using UNION ALL to combine the results
(SELECT E.employee_name,E.department_id FROM employees as E 
JOIN departments D ON E.department_id = D.department_id
	WHERE D.department_name = 'IT' AND E.salary > 75000)
UNION ALL
(SELECT E.employee_name, E.location_id FROM Employees as E
JOIN locations L ON E.location_id = L.location_id
	WHERE L.location = 'Bangalore' AND Salary > 60000);
