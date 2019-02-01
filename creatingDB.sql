
DROP DATABASE IF EXISTS University;
CREATE DATABASE University
CHARACTER SET utf8
COLLATE utf8_general_ci;

USE University;

CREATE TABLE student( 
	ID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    son_of VARCHAR(50) NOT NULL,
    photo VARCHAR(100) DEFAULT 'no photo',
    year_of_admission YEAR,
    ID_group INT,
    birthdate DATE NOT NULL,
	home_address VARCHAR(100) DEFAULT 'no home');
    
CREATE TABLE students_group( 
	ID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    specialization VARCHAR(75) NOT NULL);
    
ALTER TABLE student
	ADD CONSTRAINT FK_student_students_group
		FOREIGN KEY (ID_group)
		REFERENCES students_group (ID)
	ON DELETE CASCADE	ON UPDATE CASCADE;
    
CREATE TABLE subject(
	ID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL);
    
CREATE TABLE lecturer(
	ID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL);
    
CREATE TABLE data_about_results(
	ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_student INT,
    CONSTRAINT FK_data_about_results_student
		FOREIGN KEY (ID_student)
        REFERENCES student (ID)
        ON DELETE CASCADE	ON UPDATE CASCADE,
	ID_subject INT,
	CONSTRAINT FK_data_about_results_subject
		FOREIGN KEY (ID_subject)
        REFERENCES subject (ID)
        ON DELETE CASCADE	ON UPDATE CASCADE,
	mark_modulN1 TINYINT,
    mark_modulN2 TINYINT,
	mark_in_100_sys TINYINT AS (mark_modulN1 + mark_modulN2),
    maek_in_5_sys TINYINT AS (ROUND(mark_in_100_sys / 20)),
    number_of_semester TINYINT NOT NULL);

    
CREATE TABLE data_about_group(
	ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_group INT,
	CONSTRAINT FK_data_about_group_students_group
		FOREIGN KEY (ID_group)
		REFERENCES students_group(ID)
		ON DELETE CASCADE	ON UPDATE CASCADE,
	ID_lecturer INT,
	CONSTRAINT FK_data_about_group_lecture
		FOREIGN KEY (ID_lecturer)
		REFERENCES lecturer (ID)
		ON DELETE CASCADE	ON UPDATE CASCADE,
	ID_subject INT, 
	CONSTRAINT FK_data_about_group_subject
		FOREIGN KEY (ID_subject)
		REFERENCES subject (ID)
		ON DELETE CASCADE	ON UPDATE SET NULL,
	form_of_passing ENUM ('exam', 'credit'),
    number_of_semester TINYINT NOT NULL);
        
CREATE TABLE data_about_studet(
	ID_student INT primary key,
	CONSTRAINT FK_data_about_studet_student
		FOREIGN KEY (ID_student)
        REFERENCES student (ID)
        ON DELETE CASCADE	ON UPDATE CASCADE,
	biography VARCHAR(1000) DEFAULT 'no one',
    scholarship DECIMAL);
    
    
INSERT INTO students_group (name, specialization) VALUES ('pmp41', 'computational mathematics'),
 ('pmp42', 'applied mathematics');
 
 INSERt INTO student(name, surname, son_of, year_of_admission, birthdate, ID_group) VALUES 
 ('Andriy', 'Babiy','Volodimyr', 2014, '1998-08-06', 2), 
 ('Rulsan', 'Partsey', 'Vol', 2014, '1997-02-12', 2),
 ('Nazar', 'Kypr', 'Hz', 2014,'1996-01-01',1), 
 ('Marta', 'Kondor', 'Adam', 2014, '1999-08-08',1);
 
 INSeRT INTO subject(name) VALUES 
 ('drawing'), ('LIE'), ('Numberic Methods Of Linear Algebra');
 
 iNseRt INTO lecturer(name, surname) VALUES
 ('matlab', 'matlabovich'), ('baba', 'Katya'), ('Roman','Hapko'),('Mikaylo Hz HACTTPABDI','Bartish');

INSERT INTO data_about_results(ID_student, ID_subject, mark_modulN1, mark_modulN2,number_of_semester)
 VALUES 
 (1,1,50,50,4),(1,2,43,50,4),(1,3,50,38,4),
 (2,1,45,43,4),(2,2,50,50,4),(2,3,10,50,4),
 (3,1,49,49,4), (3,2,0,14,4),(3,3,34,22,4),
 (4,1,29,49,4), (4,2,12,14,4),(4,3,34,42,4);
 
INSERT INTO data_about_group(ID_group, ID_lecturer, ID_subject, form_of_passing, number_of_semester) 
VALUES (2,3,2,'exam', 4),
(2,1,1,'credit', 4),
(2,2,3,'exam', 4),
(1,3,2,'exam', 4),
(1,1,1,'credit', 4),
(1,2,3,'exam', 4);
 
 INSERT INTO data_about_studet(ID_student, scholarship) VALUES 
 (1,1488), (2,1000),(3, NULL),(4, 1000);
 
 
   