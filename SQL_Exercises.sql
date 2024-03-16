CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    birth_date DATE,
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
    FOREIGN KEY (mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY (super_id) REFERENCES employee(emp_id) ON DELETE SET NULL;

CREATE TABLE client (
   client_id INT PRIMARY KEY,
   client_name VARCHAR(40),
   branch_id INT,
   FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
   );


CREATE TABLE works_with (
    emp_id INT,
    client_id INT,
    total_sales INT,
    PRIMARY KEY (emp_id, client_id),
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
    FOREIGN KEY (client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
    branch_id INT,
    supplier_name VARCHAR(40),
    supply_type VARCHAR(40),
    PRIMARY KEY (branch_id, supplier_name),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

-- Corperate
INSERT INTO employee VALUES (100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);
INSERT INTO branch VALUES (1, 'Corperate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES (101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

SELECT * 
FROM employee;

SELECT * 
FROM branch;

-- DELETE FROM employee
-- WHERE emp_id = 101 OR 100; 

-- DELETE FROM branch
-- WHERE branch_id = 1; 

-- Scranton
INSERT INTO employee VALUES (102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);
INSERT INTO branch VALUES (2, 'Scranton', 102, '1992-04-26');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES (103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES (104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES (105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Stamford
INSERT INTO employee VALUES (106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);
INSERT INTO branch VALUES (3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES (107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES (108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);


-- Client
INSERT INTO client VALUES (400, 'Dummore Highschool', 2);
INSERT INTO client VALUES (401, 'Lackawana Country', 2);
INSERT INTO client VALUES (402, 'FedEx', 3);
INSERT INTO client VALUES (403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES (404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES (405, 'Times Newspaper', 3);
INSERT INTO client VALUES (406, 'FedEx', 2);

SELECT * 
FROM client; 

-- Works_with

INSERT INTO works_with VALUES (105, 400, 55000);
INSERT INTO works_with VALUES (102, 401, 267000);
INSERT INTO works_with VALUES (108, 402, 22500);
INSERT INTO works_with VALUES (107, 403, 5000);
INSERT INTO works_with VALUES (108, 403, 12000);
INSERT INTO works_with VALUES (105, 404, 33000);
INSERT INTO works_with VALUES (107, 405, 26000);
INSERT INTO works_with VALUES (102, 406, 15000);
INSERT INTO works_with VALUES (105, 406, 130000);
 
SELECT *
FROM works_with
ORDER BY client_id;

-- Branch Supplier
INSERT INTO branch_supplier VALUES (2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES (2, 'Uni-ball', 'White Utensils');
INSERT INTO branch_supplier VALUES (3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES (2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES (3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES (3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES (3, 'Stamford Labels', 'Custom Forms');

SELECT * 
FROM branch_supplier;


SELECT *
FROM branch;

ALTER TABLE branch
ADD COLUMN revenue INT;

UPDATE branch 
SET revenue =
    CASE
        WHEN branch_id = 1 THEN  680000
        WHEN branch_id = 2 THEN  950000
        WHEN branch_id = 3 THEN  1250000
        ELSE revenue
    END; 

SELECT * 
FROM employee;

SELECT *
FROM branch_supplier;

ALTER TABLE branch_supplier
ADD COLUMN capacity INT;

UPDATE branch_supplier
SET capacity =
    CASE
        WHEN branch_id = 2 AND supplier_name = 'Hammer Mill' THEN  3200
        WHEN branch_id = 2 AND supplier_name = 'J.T. Forms & Labels' THEN  5000
        WHEN branch_id = 2 AND supplier_name = 'Uni-ball' THEN 7900
        WHEN branch_id = 3 AND supplier_name = 'Hammer Mill' THEN  1500
        WHEN branch_id = 3 AND supplier_name = 'Patriot Paper' THEN  3400
        WHEN branch_id = 3 AND supplier_name = 'Stamford Labels' THEN  5400
        WHEN branch_id = 3 AND supplier_name = 'Uni-ball' THEN 6000
        ELSE capacity
    END; 



SELECT DISTINCT supplier_name
FROM branch_supplier;

SELECT supplier_name, COUNT(*) as supplier_count
FROM branch_supplier
GROUP BY supplier_name;

SELECT sex, CEIL(AVG(salary))  as AvgSalary
FROM employee
GROUP BY sex;

SELECT  COUNT(DISTINCT supplier_name) AS supplier_count
FROM branch_supplier;

SELECT *
FROM employee
ORDER BY first_name DESC, last_name ASC;

SELECT *
FROM employee
ORDER BY first_name DESC, last_name DESC;

SELECT first_name AS employee_name, salary
FROM employee

WHERE salary BETWEEN 50000 AND 70000;

SELECT  COUNT(salary)
FROM employee
WHERE salary BETWEEN 50000 AND 70000;

SELECT  COUNT(salary)
FROM employee
WHERE salary NOT BETWEEN 50000 AND 70000;

SELECT *
FROM employee
LIMIT 3;



SELECT works_with.emp_id, employee.first_name, SUM(works_with.total_sales) AS emp_total_sales
FROM works_with
LEFT JOIN employee
ON works_with.emp_id = employee.emp_id
GROUP BY works_with.emp_id;

-- clients
CREATE TABLE clients (
    id INT PRIMARY KEY,
    mac_address VARCHAR(255)
);

DROP TABLE clients;

-- streams
CREATE TABLE streams (
    user_id INT,
    title VARCHAR(255),
    quality ENUM('240p', '360p', '480p'),
    traffic INT,
    PRIMARY KEY (user_id, title),
    FOREIGN KEY (user_id) REFERENCES clients(id) ON DELETE CASCADE
);

INSERT INTO clients VALUES(1, 'London');
INSERT INTO clients VALUES(2, 'Mexico');
INSERT INTO clients VALUES(3, 'Bangkok');
INSERT INTO clients VALUES(4, 'Beijing');
INSERT INTO clients VALUES(5, 'Singapore');
INSERT INTO clients VALUES(6, 'London');

SELECT *
FROM clients;

INSERT INTO streams VALUES(1,'Mike','240p', 550);
INSERT INTO streams VALUES(1,'Som','360p', 390);
INSERT INTO streams VALUES(2,'John','360p', 200);
INSERT INTO streams VALUES(3,'Nick','480p', 220);
INSERT INTO streams VALUES(4,'Pam','480p', 500);
INSERT INTO streams VALUES(4,'Pop','240p', 400);
INSERT INTO streams VALUES(2,'Lui','360p', 30);
INSERT INTO streams VALUES(5,'Jack','480p', 80);
INSERT INTO streams VALUES(6,'Mike','240p', 240);
INSERT INTO streams VALUES(5,'Earn','240p', 300);


SELECT * 
FROM streams;

SELECT quality, SUM(traffic) AS total_streams
FROM streams
GROUP BY streams.quality;

SELECT clients.mac_address, streams.quality, SUM(streams.traffic) AS total_streams
FROM streams
LEFT JOIN clients
ON streams.user_id = clients.id
GROUP BY streams.user_id, clients.mac_address, streams.quality;

SELECT clients.mac_address, streams.quality
FROM streams
LEFT JOIN clients
ON streams.user_id = clients.id;

SELECT *
FROM employee;

SELECT *
FROM client;

SELECT first_name, sex, salary,
    CASE
        WHEN salary > 70000 THEN 'Senior'
        WHEN salary > 100000 THEN 'Manager'
        ELSE 'Junior'
    END AS Employee_Class
    , client_name
FROM employee
INNER JOIN client
ON employee.branch_id = client.branch_id;



SELECT first_name, sex, salary, Employee_class,
    CASE
        WHEN Employee_class = 'Junior' THEN salary * 1.5
        WHEN Employee_class = 'Senior' THEN salary * 1.2
        ELSE salary * 1.1
    END AS newsalary
    FROM (
         SELECT first_name, sex, salary,
        CASE
            WHEN salary > 70000 THEN 'Senior'
            WHEN salary > 100000 THEN 'Manager'
            ELSE 'Junior'
        END AS Employee_Class
    FROM employee
    ) AS employee1;

-- Practince in ChatGPT
-- 1. Retrieve the names and salaries 
-- of employees who work at the 'Scranton' branch

SELECT * FROM employee;
SELECT * FROM branch;

SELECT employee.first_name, employee.last_name,
employee.salary, branch.branch_name
FROM employee
INNER JOIN branch
ON employee.branch_id = branch.branch_id
WHERE branch.branch_name = 'Scranton';

-- 2. List the names of clients who have total sales greater 
-- than $30,000. Include the total sales for each client.
SELECT * FROM client;
SELECT * FROM works_with;

SELECT client.client_name, works_with.total_sales,
SUM(works_with.total_sales) OVER (PARTITION BY client.client_name) AS total_sales_each
FROM client
LEFT JOIN works_with
ON client.client_id = works_with.client_id
WHERE works_with.total_sales > 30000;


SELECT 
    client.client_name, 
    COALESCE(SUM(works_with.total_sales), 0) AS total_sales
FROM 
    client
LEFT JOIN 
    works_with ON client.client_id = works_with.client_id
GROUP BY 
    client.client_name
HAVING 
    COALESCE(SUM(works_with.total_sales), 0) > 30000;


-- 3.Find the names of employees who work with the client 
-- 'FedEx' and have total sales exceeding $20,000.
SELECT employee.first_name, employee.last_name, Fed.total_sales
FROM (
    SELECT works_with.emp_id, client.client_name, works_with.total_sales
    FROM works_with
    LEFT JOIN client
    ON works_with.client_id = client.client_id
    WHERE client.client_name = 'FedEx' AND works_with.total_sales > 20000
) as Fed
INNER JOIN employee
ON employee.emp_id = Fed.emp_id;

-- dummy
SELECT works_with.emp_id, client.client_name, works_with.total_sales
FROM works_with
LEFT JOIN client
ON works_with.client_id = client.client_id
WHERE client.client_name = 'FedEx' AND works_with.total_sales > 20000;

-- 4. Display the names of employees who are managers and the names of the branches 
-- they manage, along with the branch's start date.
 
SELECT * FROM employee;
SELECT * FROM branch;

SELECT employee.first_name, employee.last_name, branch.branch_name, branch.mgr_start_date
FROM employee
LEFT JOIN branch
ON employee.emp_id = branch.mgr_id;

-- 5. Show the names of clients along with the total sales for each client. 
-- If a client has no sales, display 0 as the total sales.
SELECT * FROM client;
SELECT * FROM works_with;

SELECT client.client_name, COALESCE(works_with.total_sales, 0) AS totalsales
FROM client
RIGHT JOIN works_with
ON client.client_id = works_with.client_id;

--6 Retrieve the names and birth dates of employees who have a manager. Include the names of their managers.
SELECT * FROM employee;

SELECT employee.first_name AS Employee_name, employee.birth_date, EMP_name.first_name AS Manager_name
FROM employee
LEFT JOIN (
    SELECT emp_id, first_name
    FROM employee
) AS EMP_name
ON employee.super_id = EMP_name.emp_id
WHERE employee.super_id IS NOT NULL;


-- 7. List the names and salaries of employees who have no manager.
SELECT * FROM employee;

SELECT first_name, salary
FROM employee
WHERE super_id IS NULL;


-- 8. Find the client who have the highest total sales. Display their name and the corresponding total sales.
SELECT * FROM client;
SELECT * FROM works_with;

SELECT client.client_name, max_total_sales.total_sales
FROM client
RIGHT JOIN (
    SELECT client_id, total_sales
    FROM works_with
    ORDER BY total_sales DESC
    LIMIT 1
) AS max_total_sales
ON client.client_id = max_total_sales.client_id;





-- 9. Show the names of clients who have not made any purchases (i.e., clients with no entries in the works_with table).
SELECT * FROM client;
SELECT * FROM works_with;


SELECT client.client_name
FROM client
WHERE client_id NOT IN (
    SELECT DISTINCT client_id
    FROM works_with
);

-- 10. Display the names of employees and the names of the branches they work in. If an employee 
-- does not belong to any branch, still include their name with a null branch.

SELECT * FROM employee;
SELECT * FROM branch;

SELECT 
    employee.first_name, 
    branch.branch_name
FROM employee
LEFT JOIN branch 
ON employee.branch_id = branch.branch_id;


-- 11. Find the employees who have sales exceeding the average sales across all employees:
SELECT * FROM employee;

SELECT first_name, salary
FROM employee
WHERE salary > (
    SELECT ROUND(AVG(salary))
    FROM employee
);


-- 12. Retrieve the names of employees who work in branches with a manager who has a salary greater than $90,000:
SELECT * FROM branch;
SELECT * FROM employee;

SELECT department.first_name AS emp_name, employee.first_name AS mgr_name, employee.salary AS mgr_salary
FROM employee
RIGHT JOIN (
    SELECT first_name, super_id
    FROM employee
) AS department
ON employee.emp_id = department.super_id
WHERE employee.salary > 90000;

SELECT first_name, super_id
FROM employee;


-- 13. List the names of clients who have made purchases with employees from the 'Stamford' branch:
SELECT * FROM client;
SELECT * FROM works_with;
SELECT * FROM branch;
SELECT * FROM employee;

SELECT client.client_name
FROM client
WHERE client_id IN (
    SELECT client_id
    FROM works_with
    WHERE emp_id IN (
        SELECT emp_id
        FROM employee
        WHERE branch_id = (
            SELECT branch_id 
            FROM branch 
            WHERE branch_name = 'Stamford'
)));



-- 14. Show the names of clients who have made purchases with at least two different employees:
SELECT client_id, COUNT(client_id) AS purchase_times
FROM works_with
GROUP BY client_id;

SELECT DISTINCT client_id
FROM (
    SELECT emp_id, client_id,
    COUNT(client_id) OVER (PARTITION BY client_id) AS purchase_times
    FROM works_with
) AS repeat_client
WHERE purchase_times > 1;


-- 15. Retrieve the names of employees who have a salary greater than the average salary of employees in
-- their respective branches:
SELECT * FROM employee;

SELECT first_name, last_name, salary
FROM employee
WHERE salary > (
    SELECT ROUND(AVG(salary)) AS avg_salary
    FROM employee AS branch_avg_salary
    WHERE employee.branch_id = branch_avg_salary.branch_id
);

SELECT branch_id, ROUND(AVG(salary)) AS avg_salary
FROM employee
GROUP BY branch_id;


SELECT * FROM people_db;
DESCRIBE people_db;

SELECT * 
FROM people_db
WHERE Location = 'Guildford';

CREATE TABLE projectids (
Project_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Project_Name VARCHAR(255));


INSERT INTO projectids (Project_Name)
SELECT DISTINCT Project
FROM people_db;

SELECT * FROM projectids;

CREATE TABLE Bridge_table AS
SELECT people_db.StaffID, projectids.Project_ID
FROM people_db
LEFT JOIN projectids
ON people_db.Project = projectids.Project_Name;

SELECT * FROM Bridge_table;
 
CREATE TABLE Location (
    Location_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Location_Name VARCHAR(255),
    Location_TelNo VARCHAR(255)
);

INSERT INTO Location (Location_Name, Location_TelNo)
SELECT DISTINCT Location, TelNo
FROM people_db;

SELECT * FROM Location;

CREATE TABLE people_db2 AS
SELECT people_db.StaffID, people_db.WorkerName, Location.Location_ID, people_db.Position, people_db.Extension
FROM people_db
LEFT JOIN Location
ON people_db.Location = Location.Location_Name;


SELECT * FROM people_db2;

CREATE TABLE Staff_table (
    StaffID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    WorkerName VARCHAR(255),
    Position VARCHAR(255),
    LocationID VARCHAR(255),
    Extension VARCHAR(255)
);


INSERT INTO Staff_table (
    WorkerName, Position, LocationID, Extension
    )
SELECT DISTINCT  WorkerName, Position, Location_ID, Extension
FROM people_db2;

SELECT * FROM Staff_table;

----------------------------------- Exercies ----------------------------------
-- Authors Table
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(100) NOT NULL
);

-- Genres Table
CREATE TABLE Genres (
    GenreID INT PRIMARY KEY,
    GenreName VARCHAR(50) NOT NULL
);

-- Books Table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    AuthorID INT,
    GenreID INT,
    PublicationYear INT,
    ISBN VARCHAR(20) UNIQUE,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);

-- Users Table
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    UserName VARCHAR(100) NOT NULL
);

-- Loans Table
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    BookID INT,
    UserID INT,
    LoanDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Insert data into Authors Table
INSERT INTO Authors (AuthorID, AuthorName) VALUES
(1, 'Jane Austen'),
(2, 'George Orwell'),
(3, 'J.K. Rowling'),
(4, 'Agatha Christie'),
(5, 'F. Scott Fitzgerald'),
(6, 'Harper Lee'),
(7, 'Mark Twain'),
(8, 'Emily Brontë'),
(9, 'Ernest Hemingway'),
(10, 'Arthur Conan Doyle');

-- Insert data into Genres Table
INSERT INTO Genres (GenreID, GenreName) VALUES
(1, 'Romance'),
(2, 'Dystopian'),
(3, 'Fantasy'),
(4, 'Mystery'),
(5, 'Classics'),
(6, 'Southern Gothic'),
(7, 'Adventure'),
(8, 'Gothic'),
(9, 'Adventure'),
(10, 'Detective');

-- Insert data into Books Table
INSERT INTO Books (BookID, Title, AuthorID, GenreID, PublicationYear, ISBN) VALUES
(1, 'Pride and Prejudice', 1, 1, 1813, '9780141439518'),
(2, '1984', 2, 2, 1949, '9780451524935'),
(3, 'Harry Potter and the Sorcerer''s Stone', 3, 3, 1997, '9780590353427'),
(4, 'Murder on the Orient Express', 4, 4, 1934, '9780062073495'),
(5, 'The Great Gatsby', 5, 5, 1925, '9780743273565'),
(6, 'To Kill a Mockingbird', 6, 6, 1960, '9780061120084'),
(7, 'The Adventures of Tom Sawyer', 7, 5, 1876, '9780486415956'),
(8, 'Wuthering Heights', 8, 1, 1847, '9780141439556'),
(9, 'The Old Man and the Sea', 9, 6, 1952, '9780684801223'),
(10, 'The Hound of the Baskervilles', 10, 4, 4, '9780140437867');

-- Insert data into Users Table
INSERT INTO Users (UserID, UserName) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David'),
(5, 'Eva'),
(6, 'Frank'),
(7, 'Grace'),
(8, 'Henry'),
(9, 'Ivy'),
(10, 'Jack');

-- Insert data into Loans Table
INSERT INTO Loans (LoanID, BookID, UserID, LoanDate, ReturnDate) VALUES
(1, 1, 2, '2023-01-15', '2023-02-10'),
(2, 3, 5, '2023-02-05', '2023-03-01'),
(3, 5, 1, '2023-03-10', '2023-04-05'),
(4, 7, 3, '2023-04-20', '2023-05-15'),
(5, 8, 6, '2023-05-01', '2023-06-01'),
(6, 10, 4, '2023-06-10', '2023-07-05'),
(7, 2, 8, '2023-07-15', '2023-08-10'),
(8, 4, 10, '2023-08-20', '2023-09-15'),
(9, 6, 7, '2023-09-01', '2023-10-01'),
(10, 9, 9, '2023-10-10', '2023-11-05');

INSERT INTO Loans (LoanID, BookID, UserID, LoanDate, ReturnDate) 
VALUES (11, 5, 2, '2023-01-15', '2023-07-10');

DELETE FROM loans 
WHERE BookID = 10;

UPDATE Books
SET PublicationYear = 1955
WHERE BookID = 10;

SELECT * FROM Authors;
SELECT * FROM Genres;
SELECT * FROM Books;
SELECT * FROM Users;
SELECT * FROM Loans;

-- Basic Queries
-- 1. Retrieve all information from the "Authors" table.
SELECT * FROM Authors;
-- 2. Display the titles and publication years of all books in the "Books" table.
SELECT Title, PublicationYear 
FROM Books;
-- 3. List the names of all genres from the "Genres" table.
SELECT DISTINCT GenreName 
FROM Genres;
-- 4. Get the usernames from the "Users" table.
SELECT UserName 
FROM Users;
-- 5. Show the loan dates and return dates from the "Loans" table.
SELECT LoanDate, ReturnDate 
FROM Loans;

-- Intermediate Queries
-- 6. Find the total number of books published in each genre.
SELECT GenreName, COUNT(GenreName) AS Book_count
FROM Genres 
GROUP BY GenreName;

-- 7. Retrieve the names of authors who have books published after the year 1950.
SELECT * FROM Authors;
SELECT * FROM Books;

SELECT Authors.AuthorName, Books.PublicationYear
FROM Books
LEFT JOIN Authors
ON Books.AuthorID = Authors.AuthorID
WHERE PublicationYear > 1950;

-- 8. List the books borrowed by the user with the username 'Alice'.
SELECT * FROM Users;
SELECT * FROM Books;
SELECT * FROM Loans;

SELECT Books.Title
FROM Books
INNER JOIN Loans 
ON Books.BookID = Loans.BookID 
WHERE Loans.UserID IN (
    SELECT Users.UserID
    FROM Users
    WHERE UserName = 'Alice'
);


SELECT Books.Title, UserName 
FROM Books 
RIGHT JOIN (
    SELECT Loans.BookID, Users.UserName
    FROM Users
    LEFT JOIN Loans
    ON Users.UserID = Loans.UserID
    WHERE UserName = 'Alice') AS Alice_Book
ON Books.BookID = Alice_Book.BookID ;

-- 9. Display the number of loans for each user.
SELECT * FROM Loans;
SELECT * FROM Users;

SELECT Users.UserID, Loans.LoanID 
FROM Users
LEFT JOIN Loans 
ON Users.UserID = Loans.UserID;

-- 10. Find the authors and titles of books borrowed in the day 10.
SELECT * FROM Authors;
SELECT * FROM Loans;
SELECT * FROM Books;

SELECT Authors.AuthorName, Book_Borrowed_D10.Title, Book_Borrowed_D10.LoanDate
FROM Authors
RIGHT JOIN (
    SELECT Books.AuthorID, Books.Title, Loans.LoanDate
    FROM Loans 
    LEFT JOIN Books
    ON Loans.BookID = Books.BookID
    WHERE Loans.LoanDate LIKE '%10'
) AS Book_Borrowed_D10
ON Authors.AuthorID = Book_Borrowed_D10.AuthorID;

-- 11. Identify the genres with more than 2 books in the "Books" table.
SELECT * FROM Genres;
SELECT * FROM Books;

SELECT Genres.GenreName, Rep_Genre.Genre_Count 
FROM Genres 
RIGHT JOIN (
    SELECT GenreID, Count(GenreID) AS Genre_Count
    FROM Books
    GROUP BY GenreID
) AS Rep_Genre
ON Genres.GenreID = Rep_Genre.GenreID
WHERE Rep_Genre.Genre_Count > 1;

-- 12. Get the number of books published in each decade.
SELECT * FROM Books;

SELECT MIN(PublicationYear)
FROM Books;

SELECT MAX(PublicationYear)
FROM Books;

SELECT  RoundedPublicationYear, COUNT(RoundedPublicationYear) AS Count_Decadebook
FROM (
    SELECT BookID, PublicationYear,
    CONCAT(SUBSTRING(PublicationYear, 1, 3), '0') AS RoundedPublicationYear
    FROM Books) AS Books2
GROUP BY RoundedPublicationYear;

-- 13. Find the average publication year of books in each genre.
SELECT * FROM Books;
SELECT * FROM Genres;


SELECT Genres.GenreName, ROUND(AVG(Books.PublicationYear)) AS AVG_PublicationYear
FROM Books
LEFT JOIN Genres
ON Books.GenreID = Genres.GenreID
GROUP BY Genres.GenreName;

-- 14. List the users who have not borrowed any books.
SELECT * FROM Users;
SELECT * FROM Loans;

SELECT UserID 
FROM Users 
WHERE UserID NOT IN (
    SELECT DISTINCT UserID 
    FROM Loans
);

-- 15. Display the titles of books with 'Harry' in their title or 'Lee' as the author.
SELECT * FROM Books;
SELECT * FROM Authors;

SELECT Books_with_Authors.Title, Books_with_Authors.AuthorName
FROM (
    SELECT Books.Title, Authors.AuthorName  
    FROM Books
    LEFT JOIN Authors 
    ON Books.AuthorID = Authors.AuthorID
) AS Books_with_Authors 
WHERE Books_with_Authors.Title LIKE '%Harry%' OR Books_with_Authors.AuthorName LIKE '%Lee%';


-- 16. Retrieve the authors who have books in both the 'Romance' and 'Mystery' genres.
SELECT * FROM Authors;
SELECT * FROM Genres;
SELECT * FROM Books;

SELECT Authors.AuthorName, RM_Genre2.GenreName AS Book_Genre
FROM Authors
RIGHT JOIN (
    SELECT Books.AuthorID, RM_Genre.GenreName 
    FROM Books 
    RIGHT JOIN (
        SELECT GenreID, GenreName 
        FROM Genres 
        WHERE GenreName = 'Romance' OR GenreName = 'Mystery'
    ) AS RM_Genre 
    ON Books.GenreID = RM_Genre.GenreID
) AS RM_Genre2 
ON Authors.AuthorID  = RM_Genre2.AuthorID;

-- 17. Find the user who borrowed the most books in a single loan.
SELECT * FROM Loans;
SELECT * FROM Users;

SELECT Users.UserName, loanedbook.singleloan_book
FROM Users 
RIGHT JOIN (
    SELECT UserID, COUNT(LoanDate) AS singleloan_book
    FROM Loans 
    GROUP BY UserID 
    ORDER BY singleloan_book DESC 
    LIMIT 1
) AS loanedbook
ON Users.UserID = loanedbook.UserID;


-- 18. Identify the books that have not been borrowed.
SELECT * FROM Loans;
SELECT * FROM Books;

SELECT BookID, Title  
FROM Books 
WHERE BookID NOT IN (
    SELECT DISTINCT BookID
    FROM Loans
);


-- 19. List the users who borrowed books published before the year 2000.
SELECT * FROM Books;
SELECT * FROM Loans;
SELECT * FROM Users;

SELECT Users.UserName, Borrowed_books_b4_2000.BookID
FROM Users
RIGHT JOIN (
    SELECT Loans.UserID, Loans.BookID 
    FROM Loans 
    LEFT JOIN (
        SELECT BookID, PublicationYear 
        FROM Books 
        WHERE PublicationYear < 2000
    ) AS Books_b4_2000 
    ON Loans.BookID = Books_b4_2000.BookID
) AS Borrowed_books_b4_2000
ON Users.UserID = Borrowed_books_b4_2000.UserID
ORDER BY UserName;

-- 20. Calculate the total number of days each book was borrowed.
SELECT * FROM Loans;

SELECT Books.Title, Days.Borrowed_days
FROM Books 
RIGHT JOIN (
    SELECT BookID, DATEDIFF(ReturnDate, LoanDate) AS Borrowed_days
    FROM Loans
) AS Days
ON Books.BookID = Days.BookID; 

-- 21. Display the top 5 genres with the highest average publication year.
SELECT Genres.GenreName, TopYear.avg_PublicationYear
FROM Genres
RIGHT JOIN (
    SELECT GenreID, Round(AVG(PublicationYear)) AS avg_PublicationYear
    FROM Books
    GROUP BY GenreID
    ORDER BY avg_PublicationYear DESC
    LIMIT 5
) AS TopYear
ON Genres.GenreID = TopYear.GenreID;

-- 22. List the books that have been borrowed more than once.
SELECT * FROM Loans;
SELECT Books.Title, Borrows.borrow_num 
FROM Books 
RIGHT JOIN (
    SELECT BookID, Count(BookID) AS borrow_num 
    FROM Loans 
    GROUP BY BookID
) AS Borrows 
ON Books.BookID = Borrows.BookID;


-- 23. Calculate the average number of days each user keeps a book on loan.

SELECT Users.UserName, BD.avg_borrowed_days
FROM Users
RIGHT JOIN (
    SELECT UserID, ROUND(AVG(DATEDIFF(ReturnDate, LoanDate))) AS avg_borrowed_days
    FROM Loans
    GROUP BY UserID
) AS BD 
ON Users.UserID = BD.UserID;

-- 24. Retrieve the authors who have books in the 'Romance' genre but not in the 'Fantasy' genre.
SELECT * FROM Loans;
SELECT * FROM Genres;
SELECT * FROM Books;

SELECT RM_Books.AuthorName, Genres.GenreName 
FROM (
    SELECT Authors.AuthorName, Books.GenreID
    FROM Books 
    LEFT JOIN Authors 
    ON Books.AuthorID = Authors.AuthorID
    WHERE Books.GenreID IN (
        SELECT GenreID 
        FROM Genres 
        WHERE GenreName = 'Romance'
    )
) AS RM_Books 
LEFT JOIN Genres 
ON RM_Books.GenreID = Genres.GenreId;


