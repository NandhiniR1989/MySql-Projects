use employee;

-- BEFORE INSERT TRIGGER
/*Create a before insert trigger that automatically sets the salary of an employee
 to the average of all salaries if it's not provided during insertion. 
Test the trigger by attempting to insert a new employee without providing a salary.*/

DELIMITER **

CREATE TRIGGER before_insert_set_employee_salary
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
	DECLARE avg_salary DECIMAL(10,2);
	SELECT avg(salary) INTO avg_salary FROM employees;
    IF NEW.salary IS NULL THEN
		SET NEW.salary = avg_salary;
	END IF;
END **

DELIMITER ;


-- TEST BEFORE INSERT TRIGGER
SELECT * FROM employees;
INSERT INTO employees (employee_id, employee_name, gender, age, hire_date, designation, department_id, location_id)
VALUES (5031, 'Atharvaa Eshwar', 'M', 36, CURDATE(), 'Quality Assurance Analyst', 12, 1);

SELECT *FROM employees;

-- BEFORE UPDATE TRIGGER
/*Implement a before update trigger that retains the current salary of an employee if the new salary is less than the current salary. 
Test the trigger by attempting to update an existing employee's salary with a value lower than their current salary.*/

DELIMITER //

CREATE TRIGGER before_update_retain_current_salary
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
	IF NEW.salary < OLD.salary THEN
		SET NEW.salary = OLD.salary;
END IF;
END //
DELIMITER ;

-- TEST BEFORE UPDATE TRIGGER
SELECT * FROM employees;
UPDATE employees SET salary = 50000 WHERE employee_id = 5001;
SELECT * FROM employees;

-- BEFORE DELETE TRIGGER
/*Create a before delete trigger to prevent the deletion of employees who joined in the latest year. 
Test the trigger by attempting to delete an employee who joined in the most recent year*/

DELIMITER **

CREATE TRIGGER before_delete_prevent_latest_year
BEFORE DELETE ON employees
FOR EACH ROW
BEGIN
	SET @latest_hire_date = (SELECT MAX(hire_date) FROM employees);
	IF YEAR(OLD.hire_date) = YEAR(@latest_hire_date) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = ' Cannot delete employee detail from the most recent year';
	END IF;

END **

DELIMITER ;

SELECT * FROM employees;

-- Test Before Delete Trigger: Attempt to delete an employee detail with latest year
DELETE FROM employees WHERE employee_id = 5031;

-- Test Before Delete Trigger: Attempt to delete an employee detail which is not the latest year
DELETE FROM employees WHERE employee_id = 5030;

SELECT * FROM employees;

