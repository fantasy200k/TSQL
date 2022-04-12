

USE sales
go 



DECLARE @sal1 DECIMAL(10,3) = 800, @job1 varchar(8) = 'MANAGER' ;

/* LOP 
leave_taken = 10
*/ 

IF @sal1 > 800
    
   	SELECT * FROM EMP  
ELSE 
   	SELECT * FROM EMP
		WHERE sal >  @sal1 and job = @job1 -- PARAMeterization 
											-- condition1 and condition2   --> TRUE and TRUE 
		go

/* Logical data tyes TRUE, FALSE   --  AND ,OR , NOT */

	

	/* Looping */


DECLARE @empno1 AS INT = 7369 ;

WHILE @empno1 <= 7370
BEGIN
   	SELECT * FROM EMP
		WHERE empno = @empno1;-- PARAMeterization 
        SET @empno1 = @empno1 + 1
END ;

DECLARE @wel AS nvarchar(10) = 'Hello' , @ctr AS INT = 1;
print @wel 

WHILE @ctr <= 9
BEGIN
	print @wel
	SET @ctr += 1
END


/* Transaction - A transaction is a unit of  program 
ACID properties 
A - Atomicity
C - Consistency
I - Isolation
D - Durability


Shwetha (A)- 400
Aruna (B) - 700 

Shwetha (A) transferring 100 rupees to Aruna (B) 
1) 100 rupees to be deducted from Shwetha (A) a/c 
2) this money has to be added or credited into Aruna 


Shwetha (A)- 400    --> 100 rs to B andd 100 rs to C
Aruna (B) - 700 
MAdhavi (C) - 100 


*/

/* Transaction Control 

BEGIN TRANSACTION
END TRANSACTION
ROLLBACK
SAVEPOINT
RELEASE SAVEPOINT
SET TRANSACTION 
*/


BEGIN TRANSACTION

UPDATE emp SET sal = 1800 WHERE empno = 7369;
SELECT * FROM EMP
ROLLBACK TRANSACTION 
SELECT * FROM EMP


BEGIN TRANSACTION
UPDATE emp SET sal = 1800 WHERE empno = 7369;
SELECT * FROM EMP
COMMIT TRANSACTION  -- TO MAKE changes permanently use commit transactino 


BEGIN TRANSACTION
SELECT * FROM EMP
ROLLBACK TRANSACTION 

BEGIN try
	BEGIN TRANSACTION
	UPDATE emp SET sal = 2800 WHERE empno = 7369;
	UPDATE emp SET sal = 1800/0 WHERE empno = 7370;
	COMMIT TRANSACTION 
	PRINT ' Transaction Committed'
END try
BEGIN catch
	ROLLBACK TRANSACTION
	PRINT 'Transaction Rolled bak'
END catch

SELECT * from emp
SELECT * FROM EMP
COMMIT TRANSACTION  -- TO MAKE changes permanently use commit transactino 



use AdventureWorksLT2019


/* sTORED PROCEDURE  */

CREATE PROCEDURE SalesLT.getproductsbyCategory(@CategoryID INT = NULL)



use Sales
go
SELECT deptno,sum(sal) FROM emp group by deptno

SELECT deptno,sum(sal) FROM emp group by deptno
ORDER BY deptno

/* some how the index got droopped
we killed the long running stored proedure with the hel of dba
recreated the index and cross verified the execution plan
now the cost got drasticallly reduced and then we re ran our sp
*/ 
create index deptidx1 on emp(deptno)

/* reusability */

CREATE PROCEDURE deptSal
AS
BEGIN
SELECT deptno,sum(sal) 
FROM emp
group by deptno

END;

USE Sales
go

EXECUTE deptSal

DROP PROCEDURE deptSal
/* 
Store procedure can have 0 or more INPUT and OUTPUT parameters

A stored procedure can have a maximum of 2100 parameters specified

You can specify a default value for the parameters 

The stored procedre parameter names must start with @

*/
CREATE PROCEDURE deptSal
 (
	@deptno1 INT , 
	@jb1 VARCHAR(20) = 'MANAGER'
	)
AS
BEGIN
SELECT deptno,sum(sal)
FROM emp
WHERE deptno = @deptno1 and job = @jb1
group by deptno

END;


EXECUTE deptSal @deptno1=20, @jb1='ANALYST'

CREATE PROCEDURE deptSal
 (
	@deptno1 INT , 
	@jb1 VARCHAR(20) = 'MANAGER'
	)
AS
BEGIN
SELECT deptno,sum(sal)
FROM emp
WHERE deptno = @deptno1 and job = @jb1
group by deptno

END;
/*
*/

CREATE PROCEDURE upddeptSal
 (
	@sal INT , 
	@empno INT
	)
AS
BEGIN
UPDATE emp
SET sal = @sal WHERE empno = @empno


END;

EXECUTE upddeptSal  @sal=5000 , @empno=7369

EXECUTE upddeptSal  @empno=7369, @sal=5000 

EXECUTE upddeptSal 5000 , 7369

/* INPUT and OUTPUT parameter */

CREATE PROCEDURE ViewdeptSal
 (
    @empno INT ,
	@job varchar(15) OUTPUT 
	
	)
AS
BEGIN

SELECT @job=job
FROM emp
WHERE empno = @empno

END;

DECLARE @job varchar(15)
EXECUTE ViewdeptSal @empno = 7369, @job OUTPUT
PRINT @job


/* How to create a FUNCTION ?  What is a function ?? 
CREATE FUNCTION function_name (input parameters)
RETURNS return_type
AS
	SQL Statements
    RETURN return_value
GO
There are 2 types of function 
(a) Scalar Function
(b) Table function
*/

CREATE FUNCTION getEmpInfo()
RETURNS TABLE
AS
	    RETURN (SELECT * FROM emp)
GO


SELECT * FROM getEmpInfo()

CREATE FUNCTION FindMax()
RETURNS int
AS
BEGIN
DECLARE @a int = 10,
	    @b int = 5,
		@c int = 20
IF (@a > @c)
	SET @a = @b
ELSE 
	 SET @a = @c
RETURN @a
END

SELECT dbo.FindMax() as MaxValue

/* Difference between Stored Procedure and Function ?
A function must return always a value whereas a procedure may or may not return value

Functon works only with input parameters whereas in a procedure we can use input as well as output
parameter

We can call functios within a SQL Statement , we cannt use procedres within a SQL Statement

*/






/* Hadoop software java */


exec sp_who2 'active'

		select * from emp order by empno
		insert into emp values (7370,'ROBERT','Analyst',NULL, NULL, 5000,1000, 30)
		


		select * from emp