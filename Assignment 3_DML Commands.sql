-- INSERT VALUES INTO TABLE --

INSERT INTO departments VALUE
	(1,'Software Development'),
	(2, 'Marketing'),
	(3, 'Data Science'),
	(4, 'Human Resources'),
	(5,'Product Management'),
	(6,'Content Creation'),
	(7,'Finance'),
	(8,'Design'),
	(9,'Research and Development'),
	(10,'Customer Support'),
	(11,'Business Development'),
	(12,'IT'),
	(13,'Operations');
    
INSERT INTO locations (location) 
	VALUES
	('Chennai') , ('Bangalore') , ('Hyderabad') , ('Pune');

INSERT INTO employees VALUE
	(5001, 'Vihaan Singh','M',27,'2015-01-20','Data Analyst','3','4',60000);
INSERT INTO employees VALUE
	(5002,'Reyansh Singh','M',31,'2015-03-10','Network Engineer',12,1,80000);
INSERT INTO employees VALUE
    (5003,'Aaradhya Iyer','F',26,'2015-05-20','Customer Support Executive',10,2,45000);
INSERT INTO employees VALUE
	(5004,'Kiara Malhotra','F',29,'2015-07-05',NULL,8,3,70000), -- DESINATION IS NOT GIVEN, SO ENTERED AS NULL -- 
	(5005,'Anvi Chaudhary','F',25,'2015-09-11','Business Development Executive',11,1,55000),
	(5006,'Dhruv Shetty','M',28,'2015-11-20','UI Developer',8,2,65000),
	(5007,'Anushka Singh','F',32,'2016-01-15','Marketing Manager',2,3,90000),
	(5008,'Diya Jha','F',27,'2016-03-05','Graphic Designer',8,4,70000),
	(5009,'Kiaan Desai','M',30,'2016-05-20','Sales Executive',11,3,55000),
	(5010,'Atharv Yadav','M',29,'2016-07-10','Systems Administrator',12,4,80000);
    
INSERT INTO employees VALUE
	(5011,'Saanvi Patel','F',28,'2016-09-20','Marketing Analyst',2,1,60000),
	(5012,'Myra Verma','F',26,'2016-11-05','Operations Manager',13,2,95000),
	(5013,'Arnav Rao','M',33,'2017-01-20','Customer Success Manager',10,3,75000),
	(5014,'Vihaan Mohan','M',30,'2017-03-10','Supply Chain Analyst',10,2,60000),
	(5015,'Ishaan Kumar','M',27,'2017-05-20','Financial Analyst',7,1,85000),
	(5016,'Zoya Khan','F',31,'2017-07-05','Legal Counsel',4,4,100000),
	(5017,'Kabir Nair','M',28,'2017-09-11','IT Support Specialist',12,2,80000),
	(5018,'Ishan Mishra','M',25,'2017-11-20','Research Scientist',9,3,75000),
	(5019,'Ishika Patel','F',29,'2018-01-15','Talent Acquisition Specialist',4,4,55000),
	(5020,'Aarav Nair','M',32,'2018-03-05','Software Engineer',1,1,90000),
	(5021,'Advik Kapoor','M',26,'2018-05-20','Finance Analyst',7,3,85000),
	(5022,'Aadhya Iyengar','F',28,'2018-07-10','HR Specialist',4,4,60000),
	(5023,'Anika Paul','F',30,'2018-09-20','Public Relations Specialist',2,2,70000),
	(5024,'Aryan Shetty','M',27,'2018-11-05','Product Manager',5,1,95000),
	(5025,'Avni Iyengar','F',31,'2019-01-20','Data Scientist',3,4,100000),
	(5026,'Vivaan Singh','M',29,'2019-03-10','Business Analyst',3,2,75000),
	(5027,'Ananya Paul','F',32,'2019-05-20','Content Writer',6,3,60000),
	(5028,'Anaya Kapoor','F',26,'2019-07-05','Event Coordinator',6,1,60000),
	(5029,'Arjun Kumar','M',33,'2019-09-11','Quality Assurance Analyst',12,2,80000),
	(5030,'Sara Iyer','F',28,'2019-11-20','Project Manager',5,1,90000);
    
    
-- SELECT TO VIEW TABLE VALUES USING FROM CLAUSE-- 

SELECT * FROM departments;
SELECT * FROM employees;

SELECT location FROM locations;

SELECT employee_name,designation FROM employees;

-- UPDATE TABLE VALUES USING CLAUSE SET & WHERE --

UPDATE employees SET designation='Senior Data Analyst' WHERE employee_id = 5001;

UPDATE employees SET salary = salary * 1.10 WHERE designation = 'Finance Analyst';
UPDATE employees SET salary = salary * 1.10 WHERE designation = 'Financial Analyst';

-- DELETE TABLE VALUE USING CLAUSE FROM & WHERE -- 

DELETE FROM employees WHERE hire_date = '2017-01-01'; -- no data deleted, as no such hire_date is available --

DELETE FROM employees WHERE employee_id = 5025;

