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

-- BUILT-IN STRING FUNCTIONS
-- Convert all employee names to uppercase.
SELECT employee_name,UPPER(employee_name) AS CapsEmployee_Name FROM employees;

-- Extract the first three characters from the location names
SELECT SUBSTRING(location,1,3) FROM locations;

-- Find the length of department names.
SELECT department_name, LENGTH(department_name) Length FROM departments;

-- Concatenate employee names with their designations separated by a hyphen
SELECT employee_name, designation, CONCAT(employee_name, '-', designation) as Emp_detail FROM employees;
-- POINT TO BE NOTED : If either of the Column has NULL value, then concat result is NULL

-- BUILT IN DATE AND TIME FUNCTION
-- Extract the year from the hire date of all employees.
SELECT hire_date, YEAR(hire_date) as YearHired FROM employees;

-- Calculate the number of days between the hire date and the current date for each employee.
SELECT hire_date, DATEDIFF(CURDATE(),hire_date) as date_diff FROM employees;

-- Format the hire date of employees to display in 'DD-MM-YYYY' format.
SELECT hire_date, DATE_FORMAT(hire_date,'%d-%m-%Y') as Dateformat FROM employees;

-- Find the 'employment_confirmation' date of each employee which is 3 months from their hire_date.
SELECT hire_date, DATE_ADD(hire_date,INTERVAL 3 MONTH) as emp_confirmation_date FROM employees;

-- USER - DEFINED FUNCTION
-- Define a function to retrieve the employee count by location name. Find the employee count for the cities Bangalore and Hyderabad.

DELIMITER **
CREATE FUNCTION get_employee_count_by_location(loc_name VARCHAR(30))
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE emp_count INT;
    SELECT COUNT(*) INTO emp_count FROM employees e
    INNER JOIN locations l
    ON e.location_id = l.location_id
    WHERE l.location = loc_name;
    RETURN emp_count;
END **
DELIMITER ;

-- FUNCTION CALL 
SELECT get_employee_count_by_location('Bangalore') as Bnglr_emp_count;
SELECT get_employee_count_by_location('Hyderabad') as Hyd_emp_count;

-- Create a function to retrieve employee information by ID, returning the employee's name along with their designation and department name, 
-- separated by a comma. Retrieve the employee information for the IDs 5002, 5016, and 5030.

DELIMITER $$
CREATE FUNCTION emp_Info_detail(emp_id INT)
RETURNS VARCHAR(100)
READS SQL DATA
BEGIN
		DECLARE emp_details VARCHAR(100);
		SELECT CONCAT(e.employee_name,', ',e.designation,', ',d.department_name) INTO emp_details FROM employees e
        LEFT JOIN departments d
        ON e.department_id = d.department_id
        WHERE e.employee_id = emp_id;
        RETURN emp_details;
END $$
DELIMITER ;

-- FUNCTION CALL
SELECT emp_Info_detail(5002) AS EmpID_5002;
SELECT emp_Info_detail(5016) AS EmpID_5016;
SELECT emp_Info_detail(5030) AS EmpID_5030;