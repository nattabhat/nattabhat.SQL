CREATE TABLE student(
    student_id INT,
    name VARCHAR(20),
    major VARCHAR(20),
    PRIMARY KEY(student_id)
);

DESCRIBE student;
DROP TABLE student;

ALTER TABLE student ADD gpa DECIMAL(3,2);
DESCRIBE student;


ALTER TABLE student DROP COLUMN gpa;
DESCRIBE student;
################################################
SELECT * FROM student;

INSERT INTO student (student_id, name) VALUES(4, 'Claire');
INSERT INTO student VALUES (4, 'Jack', 'Biology');

DELETE FROM student
WHERE student_id = 4;

################################################
DROP TABLE student;


CREATE TABLE student(
    student_id INT,
    name VARCHAR(20) NOT NULL, # name cannot be null
    major VARCHAR(20) UNIQUE, # each major row must be different
    PRIMARY KEY(student_id) #PRIMARY KEY itselft is both NOT NULL and UNIQUE
);

INSERT INTO student VALUES (1, 'Jack', 'Biology');
INSERT INTO student VALUES (2, 'Kate', 'Soiology');
INSERT INTO student VALUES (3, 'Claire', 'Chemistry');
INSERT INTO student VALUES(4, 'John', NULL);
INSERT INTO student VALUES (5, 'Jack', 'Computer Science');


SELECT * FROM student;


DROP TABLE student;

CREATE TABLE student(
    student_id INT AUTO_INCREMENT,
    name VARCHAR(20),
    major VARCHAR(20) DEFAULT 'undecided', -- create default major for whoever don't have
    PRIMARY KEY(student_id) # PRIMARY KEY itselft is both NOT NULL and UNIQUE
);




INSERT INTO student (name) VALUES ('Jack');
INSERT INTO student (name, major) VALUES ( 'Kate', 'Soiology');
INSERT INTO student (name, major) VALUES ( 'Claire', 'Biology');
INSERT INTO student (name, major) VALUES ('John', NULL);
INSERT INTO student (name, major) VALUES ('Jack', 'Computer Science');
--AUTO_INCREMENT and DEFAULT make certain lines link together 

SELECT * FROM student;

SELECT * FROM student
WHERE major IS NULL;

SELECT * FROM student
WHERE major IS NOT NULL;

INSERT INTO student (name, major) VALUES ('Earth', 'Business Analytics')