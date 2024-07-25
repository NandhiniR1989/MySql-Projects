use employee;

/*Add a new column named 'total_employees' to the 'departments' table.*/
 ALTER TABLE departments ADD COLUMN total_employees INT DEFAULT 0;
 
 /*Then, update the 'total_employees' column for existing records in the 'departments'
 table to reflect the number of employees in each department.*/
 
SET SQL_SAFE_UPDATES = 0;

UPDATE departments d SET total_employees = 
(
    SELECT COUNT(*)
    FROM employees AS e
    WHERE e.department_id = d.department_id
);
SET SQL_SAFE_UPDATES = 1;

-- Check the updated departments table
SELECT * from departments;

-- AFTER TRIGGER INSERT
/*Implement an after insert trigger to automatically update the 'total_employees' column in the 
'departments' table after each new employee insertion.*/
DELIMITER //

CREATE TRIGGER after_insert_update_total_employees
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    -- Increment the total_employees for newly inserted employee's department_id
    UPDATE departments
    SET total_employees = total_employees + 1
    WHERE department_id = NEW.department_id;
END;
//

DELIMITER ;

SELECT * FROM departments;

/*Test the trigger by inserting a new employee and verifying the updated 'total_employees' for the respective department.*/
INSERT INTO employees VALUES
(5032,'rakeshwar', 'M', 36, CURDATE(), 'Software Engineer', 1, 4, 70000);

-- Verify the changes
SELECT * FROM departments;

-- AFTER UPDATE TRIGGER
/*Develop an after update trigger to update the 'total_employees' column in the 'departments' table after any changes in the 
'department_id' column of the 'employees' table. */

DELIMITER //

CREATE TRIGGER after_update_update_total_employees
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN

    IF OLD.department_id != NEW.department_id THEN
        UPDATE departments
        SET total_employees = total_employees - 1
        WHERE department_id = OLD.department_id;

        UPDATE departments
        SET total_employees = total_employees + 1
        WHERE department_id = NEW.department_id;
    END IF;
    
END;
//

DELIMITER ;

/*Test the trigger by updating an employee's department and verifying the updated 'total_employees' for the respective departments.*/
UPDATE employees SET department_id = 3 WHERE employee_id = 5027;

-- Verify the changes
SELECT * FROM departments;

-- AFTER DELETE TRIGGER
/*Construct an after delete trigger to automatically adjust the 'total_employees' 
column in the 'departments' table following any employee deletion.*/

DELIMITER //

CREATE TRIGGER after_delete_adjust_total_employees
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
		UPDATE departments
        SET total_employees = total_employees - 1
        WHERE department_id = OLD.department_id;
END;
//
DELIMITER ;

/* Test the trigger by deleting an employee and confirming the updated 'total_employees' for the respective department.*/
DELETE FROM employees WHERE employee_id = 5026;

-- Verify the changes
SELECT * FROM departments;