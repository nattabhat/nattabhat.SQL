CREATE TABLE student(
    student_id INT,
    name VARCHAR(20) NOT NULL, # name cannot be null
    major VARCHAR(20),
    PRIMARY KEY(student_id) #PRIMARY KEY itselft is both NOT NULL and UNIQUE
);

INSERT INTO student VALUES (1, 'Jack', 'Biology');
INSERT INTO student VALUES (2, 'Kate', 'Soiology');
INSERT INTO student VALUES (3, 'Claire', 'Biology');
INSERT INTO student VALUES(4, 'John', NULL);
INSERT INTO student VALUES (5, 'Jack', 'Computer Science');

#UPDATE and DELETE
SELECT * FROM student;
DROP TABLE student;

UPDATE student
SET major = 'Bio'
WHERE major = 'Biology';


UPDATE student
SET major = 'Com Sci'
WHERE student_id = 5;

UPDATE student
SET major = 'Bio Com Sci', name = 'Tom'
WHERE major = 'Bio' OR major = 'Com Sci';


UPDATE student
SET major = 'undecided';


DELETE FROM student 
WHERE student_id = 5;

DELETE FROM student
WHERE name = 'Tom' AND major = 'undecided';


##########################################################################
-- Getting information from a database

SELECT student.name
FROM student; 

SELECT student.name, student.major
FROM student; 

SELECT student.name, student.major
FROM student
ORDER BY name DESC; --if no DESC, it will sort in ASC as default

SELECT *
FROM student
ORDER BY major, student_id DESC;

SELECT *
FROM student
ORDER BY student_id DESC
LIMIT 2;

SELECT *
FROM student
WHERE student_id = 3;

SELECT *
FROM student
WHERE student_id <3 AND name <> 'Jack';
-- can use all of these <, >, <=, >=, <> (not equal), =, AND, OR
-- BETWEEN ... AND ...



SELECT *
FROM student
WHERE name IN ('Calire', 'Kate', 'Mike');


CREATE DATABASE Data_Analyst_practice1