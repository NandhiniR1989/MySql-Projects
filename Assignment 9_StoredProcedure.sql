use employee;

-- Basic Stored Procedure
 /*Create a stored procedure named HireYearWiseEmployeeCount to retrieve the count of employees hired in each year. 
 Call the procedure to list the number of employees hired in different years.*/
 
 DELIMITER --
 CREATE PROCEDURE HireYearWiseEmployeeCount()
 BEGIN
	SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS employee_count
    FROM employees
    GROUP BY hire_year
    ORDER BY hire_year;
END --
DELIMITER ;
 
 CALL HireYearWiseEmployeeCount();
 CALL employee.HireYearWiseEmployeeCount;
 
 --  Store Procedure with IN Parameters
 /* Define a stored procedure named GetEmployeesByDepartmentName that takes 
 a department name as input and retrieves employees belonging to that department. 
 Retrieve employee details of the departments 'IT' and 'Human Resources'.*/
 
DELIMITER **
CREATE PROCEDURE GetEmployeesByDepartmentName(IN dept_name VARCHAR(100))
BEGIN
	SELECT * FROM employees e JOIN departments d ON e.department_id = d.department_id
    WHERE dept_name = d.department_name;
END **
DELIMITER ;

CALL GetEmployeesByDepartmentName('IT');
CALL GetEmployeesByDepartmentName('Human Resources');

-- Store Procedure With OUT Parameters

/*Create a stored procedure named FindEmployeeBirthYearByID that takes
 an employee ID as input and returns the employee's birth year. 
Retrieve the birth year of employees with the IDs 5004, 5018 and 5029.*/

select * from employees;

DELIMITER //
CREATE PROCEDURE FindEmployeeBirthYearByID(IN emp_id INT, OUT birth_year YEAR)
BEGIN
	DECLARE emp_age INT;
	SELECT age INTO emp_age FROM employees WHERE employee_id = emp_id;
    SET birth_year = YEAR(CURRENT_DATE()) - emp_age;
    SELECT birth_year;
END //
DELIMITER ;

CALL FindEmployeeBirthYearByID(5004,@Year);
CALL FindEmployeeBirthYearByID(5018,@Year);
CALL FindEmployeeBirthYearByID(5029,@Year);

-- Store Procedure With INOUT Parameter
/* Define a stored procedure named ListHikeByDesignation that takes a designation name and hike percentage as input, 
increments employee salaries by the specified hike percentage for employees with the given designation, and returns the hiked salaries. 
Call the procedure with the designations 'Operations Manager' and 'Business Analyst', 
providing a hike percentage of 15% and 10% respectively to observe the effect on employee salaries. */

DELIMITER //
CREATE PROCEDURE ListHikeByDesignation(IN designation_name VARCHAR(100), INOUT hike_percent decimal(10,2) )
BEGIN
	SET SQL_SAFE_UPDATES = 0;
	UPDATE employees
    SET salary = salary + (salary * hike_percent / 100)
    WHERE designation = designation_name;
    SELECT employee_id, employee_name, salary
    FROM employees
    WHERE designation = designation_name;
END //
DELIMITER ;


SET @hike_percent = 15;
CALL ListHikeByDesignation('Operations Manager', @hike_percent);
SELECT 'Operations Manager' AS 'Designation_Name', @hike_percent AS 'hike_percent';

SET @hike_percent = 10;
CALL ListHikeByDesignation('Business Analyst', @hike_percent);
SELECT 'Business Analyst' AS 'Designation_Name', @hike_percent AS 'hike_percent';
select * from employees where designation = 'Business Analyst';





