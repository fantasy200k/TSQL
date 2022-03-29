/*
Commonly used statements are grouped into the following categories:

(I) Data Query Language (DQL)

SELECT - Used to retrieve certain records from one or more tables.


(II) Data Definition Language (DDL)

CREATE - Used to create a new table, a view of a table, or other object in database.
(A) Create database/table/index/view
(B) Alter database/table/index/view/drop 

ALTER - Used to modify an existing database object, such as a table.
DROP - Used to delete an entire table, a view of a table or other object in the database.

(III)  Data Manipulation Language (DML)

INSERT - Used to create a record.
UPDATE - Used to change certain records.
DELETE - Used to delete certain records.


(IV) Data Control Language (DCL)

GRANT - Used to give a privilege to someone.
REVOKE - Used to take back privileges granted to someone

*/


/*  ---------------------------------------------------------------------------
(II) Data Definition Language (DDL)
-- How to create a database		
 --------------------------------------------------------------------------- */

CREATE DATABASE Finance
-- Rename a database 
ALTER DATABASE Finance modify name = FinanceMart
-- Drop a database but dont every use this command
DROP DATABASE Finance

USE Sales
DROP TABLE student
CREATE TABLE student (student_id bigint, StudentName varchar(25), dob1 date);
ALTER TABLE student ALTER  COLUMN dob1 DATETIME
--  how to rename a column 
EXECUTE sp_rename 'student.dob1','student.dob','COLUMN'

/* ---------------------------------------------------------------------------
(III) DML - Data Manipulation Language
  ---------------------------------------------------------------------------
(A) INSERT , UPDATE, & DELETE

-- CREATE TABLE student (student_id bigint, StudentName varchar(25), dob1 date);
select * from student

Understanding Data Insertion#
INSERT is used to insert (add) rows to a database table. Insert can be used in several ways:

(A) Inserting a single complete row
(B) Inserting a single partial row
(C) Inserting the results of a query

--------------------------------------------------------------------------- */

/*
(A) Inserting Complete Rows
*/

insert into student values(1,'Srinivas', '2002-05-02')
insert into student values(3,'Radha', '2002-03-12')
insert into student values(4,'Deepak', NULL)

/* 
Inserting Partial Rows
*/
insert into student values(5,'Venaktesh')


insert into student(student_id, StudentName) values(5,'Venaktesh')

/*
Inserting Retrieved Data
*/

INSERT INTO student(student_id, StudentName)
SELECT student_id, StudentName FROM student

-- ---------------------------------------------------------------------------


use [Sales ]
select  [student.dob] from student

select * from student where [student.dob]  is null;
select * from student where [student.dob]  is not null

-- ----------------------------------------------------
/*
Copying from One Table to Another
*/
--  ctas - dupplicate the table 
select * into testtable from student

select * from testtable
-- ----------------------------------------------------

UPDATE student	SET student_id = 2 WHERE student_id = 1

UPDATE student	SET student_id = 4 , StudentName = 'Radha Ravi' WHERE student_id = 3

select * from student
-- UPDATE <table name> SET <column Name1> = <value1> , <column Name2> = <value2>  WHERE <column Name> = <value>

UPDATE student	SET student_id = 5 , StudentName = 'Radha Ravi' WHERE student_id = 1
select * from student WHERE student_id = 2

# SELECT column1, column2,..  FROM <table Name > 
  WHERE <condition> --> AGE > 18

select * from student
DELETE student WHERE student_id = 1
DELETE student WHERE student_id = 4


  truncate table student
  truncate table course

  insert into student values(1,'Srinivas', '2002-05-02')
insert into student values(2,'Radha', '2002-03-12')
insert into student values(3,'Deepak', '2001-06-03')

select * from student

insert into Course values(1,'English')
insert into Course values (2,'Math')



truncate table student_course
insert into Student_Course values(1,1)
insert into Student_Course values(1,2)
insert into Student_Course values(3,2)
insert into Student_Course values(2,1)


select * from Student_Course


create view Stud_View 
AS 
select studentName  
from student
go

drop view Stud_View

SELECT * from Stud_View

CREATE VIEW MyView AS   
  SELECT ProductID,  
         CatalogDescription.value('(/ProductDescription/@ProductName)[1]', 'varchar(40)') AS PName  
  FROM T  
GO 