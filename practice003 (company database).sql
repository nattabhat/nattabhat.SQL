DROP TABLE student;
DROP TABLE employee;
DROP TABLE branch;
DROP TABLE client;
DROP TABLE works_with;
DROP TABLE branch_supplier;

-- When we want to create a table that have foriegn key, we cannot instantly make it forign key yet
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    birth_day DATE,
    sex VARCHAR(1),
    salary INT,
    super_id INT,
    branch_id INT
);

CREATE TABLE branch (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(40),
    mgr_id INT,
    mgr_start_date DATE,
    FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);
-- To make a column as FOREIGN KEY, we must have a existed table to reference

-- Here we set both branch_id and super_id as FOREIGN KEY
ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(40),
    branch_id INT,
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

-- For works_with table, it has composite key and they foreign in the other table, so we must refer them too
CREATE TABLE works_with(
    emp_id INT,
    client_id INT,
    total_sales INT,
    PRIMARY KEY(emp_id, client_id),
    FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
    FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier(
    branch_id INT,
    supplier_name VARCHAR(40),
    supplier_type VARCHAR(40),
    PRIMARY KEY(branch_id, supplier_name),
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

--Coperate
INSERT INTO employee VALUES(100, 'David', 'Willance', '1967-11-17','M', 250000, NULL, NULL); -- David's branch is NULL because the corperate brach hasn't been create yet

INSERT INTO branch VALUES(1, 'Corperate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100; -- update NULL

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

--Scranton
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102; -- update NULL

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

--Stamford

INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106; -- update NULL

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);


--Branch Supplier
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensil');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Form & Labels', 'Customer Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensil');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom forms');

--Client
INSERT INTO client VALUES(400, 'Dummore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC',3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaer', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);


--Work With
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

SELECT * 
FROM employee;

SELECT * 
FROM branch;

SELECT * 
FROM works_with;

SELECT * 
FROM client;

SELECT * 
FROM branch_supplier;

-----------------------------------------------------------------------------
--Find All Employee
SELECT *
FROM employee;

--Find All Client
SELECT *
FROM client;  

--Find All Employee odered by Salary
SELECT *
FROM employee
ORDER BY salary DESC;

SELECT *
FROM employee
ORDER BY sex, first_name, last_name
LIMIT 5;

SELECT first_name AS forename, last_name AS surname
FROM employee
ORDER BY salary DESC;

--Find out all the different gender
SELECT DISTINCT sex
FROM employee;

--Find the number of employees
SELECT COUNT (emp_id)
FROM employee;

SELECT COUNT (super_id)
FROM employee; --it does not count NULL

--Find the number of female employees born after 1970
SELECT COUNT (emp_id)
FROM employee
WHERE sex = 'F' AND birth_day > '1971-01-01';

--Find the average of all employee's salary
SELECT AVG(salary)
FROM employee
WHERE sex = 'M'; -- can also use SUM

--Find out how many males and females there are 
SELECT COUNT(sex), sex --it return the count of sex
FROM employee
GROUP BY sex; -- it will group by column

--Find the total sales of each sales man (AGGREGATION)
SELECT SUM(total_sales), emp_id
FROM works_with
GROUP BY emp_id;

SELECT MIN(salary)
FROM employee;

SELECT COUNT(*)
FROM employee
WHERE salary > 5000;

------------ wild card ------------
-- grapping data that mataches specific type of pattern

--Find any clients who are in LLC
SELECT * 
FROM client
WHERE client_name LIKE '%LLC'; --matching client name with a specific pattern
-- '%' mean any character
-- Can use NOT LIKE

--Find any branch supplier wo are in the label business

SELECT * 
FROM branch_supplier
WHERE supplier_name LIKE '% Labels%'; -- this will select suppliers that have the word label in their names


--Find any employee born in October
SELECT * 
FROM employee
WHERE birth_day LIKE '____-10%'; -- one'_' represents one character


-- Find any clients who are schools
SELECT * 
FROM client
WHERE client_name LIKE '%school%';

-- Find any clients whose first name start with 'D', 'H', 'T'
SELECT client_id
FROM client
WHERE client_name LIKE '[ADG]';

SELECT *
FROM client
WHERE client_name LIKE '[!ADG]';


SELECT *
FROM client
WHERE client_name LIKE 'D%' OR client_name LIKE 'F%' OR client_name LIKE 'T%';


SELECT *
FROM client;

SELECT *
FROM employee;

----------------------Union---------------------
--Find a list of employee and branch name
SELECT first_name AS Company_Name
FROM employee
UNION 
SELECT branch_name
FROM branch
UNION
SELECT client_name
FROM client; --link two queries together, however they both top and bottom must have the same number of columns and must be in same data type


SELECT client_name, client.branch_id 
FROM client
UNION 
SELECT supplier_name, branch_supplier.branch_id
FROM branch_supplier;

--Find a list of all money spent or earned by the company
SELECT emp_id, salary
FROM employee
UNION
SELECT client_id, total_sales
FROM works_with;

----------------------Joins--------------------------
INSERT INTO branch VALUES(4,'Buffalo', NULL, NULL);

SELECT *
FROM branch;

-- Find all branches and the names of their managers
SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch
ON employee.emp_id = branch.mgr_id;

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
INNER JOIN branch
ON employee.emp_id = branch.mgr_id;

--this is called 'INNER JOIN', only manager_id that match emp_id will be selected

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
LEFT JOIN branch
ON employee.emp_id = branch.mgr_id;
-- for LEFT JOIN, all rows from the left table (employee) will be included

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
RIGHT JOIN branch
ON employee.emp_id = branch.mgr_id;
-- for RIGHT JOIN, all rows from the right table (branch) will be included

-----------------Nested Queries----------------
--Find names of all employees who have
--sold over 30,000 to a single client
SELECT  employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
    SELECT works_with.emp_id
    FROM works_with
    WHERE works_with.total_sales > 30000
);

--Find all clients who are handled by the branch
-- that Michael Scott manages
--Assume uou know Michael's ID
SELECT client.client_id, client_name
FROM client
WHERE client.branch_id = (
    SELECT branch.branch_id
    FROM branch
    WHERE branch.mgr_id = 102 
    LIMIT 1
); --when run the query, it will run the one insde the bracket first

--------------------On Delete------------------------------
-- in the case that we delete one row from a table that have a meaningful
-- value in the other tables

---- ON DELETE SET NULL-------
-- if a row is deleted, its value in the other table will be NULL
CREATE TABLE branch (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(40),
    mgr_id INT,
    mgr_start_date DATE,
    FOREIGN KEY (mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

DELETE FROM employee
WHERE emp_id = 102;

SELECT * FROM branch;

---- ON DELETE CASCASE------
-- if a row is deleted, the rows that link to that value will be deleted
-- if the value of deleted rows are PRIMARY KEY of the other table, then
-- that table must use ON DELETE CASCASE because PRIMARY KEY cannot be NULL
-- in this case branch_supplier


------------------------Triggers-----------------------------
CREATE TABLE trigger_test (
    message VARCHAR(100)
);


-- Do these below lines in the MySQL command client
use database practice001

DELIMITER $$
CREATE
    TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_test VALUES('added new employee');
    END$$
DELIMITER ;
--Because DELIMITER cannot be changed in PopSQL, can only be done in command client
-----------------------------------------------------------------------------

INSERT INTO employee
VALUES(109, 'Oscar', 'Martinez', '1968-02-19', 'M', 69000, 106, 3);

SELECT * FROM trigger_test;

-- Do these below lines in the MySQL command client
DELIMITER $$
CREATE
    TRIGGER my_trigger2 BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        IF NEW.sex = 'M' THEN
            INSERT INTO trigger_test VALUES('added male employee');
        ELSEIF NEW.sex = 'F' THEN
            INSERT INTO trigger_test VALUES('added female');
        ELSE
            INSERT INTO trigger_test VALUES('added other employee');
        END IF;
    END$$
DELIMITER ;-- can also use TRIGGER to UPDATE and DELETE

INSERT INTO employee
VALUES(110, 'Kevin', 'Malone', '1978-02-19', 'M', 69000, 106, 3);
INSERT INTO employee
VALUES(111, 'Pam', 'Bessly', '1988-02-19', 'F', 69000, 106, 3);

SELECT * FROM trigger_test;

--To drop TRIGGER
DROP TRIGGER my_trigger;

------------------- ER Diagram ---------------------------------------


