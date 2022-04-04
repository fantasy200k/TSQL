
use Sales 
go

drop table dept;
drop table emp;
go
	create table dept(  
  deptno     Bigint NOT NULL,  
  dname      varchar(14),  
  loc        varchar(13),  
  constraint pk_dept primary key (deptno)  
)	

create table emp(  
  empno    bigint,  
  ename    varchar(10),  
  job      varchar(9),  
  mgr      bigint,  
  hiredate date,  
  sal      Decimal(7,2),  
  comm     Decimal(7,2),  
  deptno   Bigint,  
  constraint pk_emp primary key (empno),  
  constraint fk_deptno foreign key (deptno) references dept (deptno) , 
    CONSTRAINT check_salary
    CHECK (sal > 0)
)

insert into dept
values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept
values(20, 'RESEARCH', 'DALLAS');
insert into dept
values(30, 'SALES', 'CHICAGO');
insert into dept
values(40, 'OPERATIONS', 'BOSTON');

truncate table emp;

insert into emp
values(
 7839, 'KING', 'PRESIDENT', null,
  '1981-11-17',
 5000, null, 10
);
insert into emp
values(
 7698, 'BLAKE', 'MANAGER', 7839,
 '1981-5-1',
 2850, null, 30
);



insert into emp
values(
 7782, 'CLARK', 'MANAGER', 7839,
 '9-6-1981',
 2450, null, 10
);
insert into emp
values(
 7566, 'JONES', 'MANAGER', 7839,
 '2-4-1981',
 2975, null, 20
);

insert into emp
values(
 7788, 'SCOTT', 'ANALYST', 7566,
 convert(date,'13-JUL-87'),
 3000, null, 20
);
insert into emp
values(
 7902, 'FORD', 'ANALYST', 7566,
 convert(date,'3-12-1981'),
 3000, null, 20
);
insert into emp
values(
 7369, 'SMITH', 'CLERK', 7902,
 convert(date,'12-17-1980'),
 800, null, 20
);
insert into emp
values(
 7499, 'ALLEN', 'SALESMAN', 7698,
 convert(date,'20-2-1981'),
 1600, 300, 30
);
insert into emp
values(
 7521, 'WARD', 'SALESMAN', 7698,
 convert(date,'22-2-1981'),
 1250, 500, 30
);
insert into emp
values(
 7654, 'MARTIN', 'SALESMAN', 7698,
 convert(date,'28-9-1981'),
 1250, 1400, 30
);
insert into emp
values(
 7844, 'TURNER', 'SALESMAN', 7698,
 convert(date,'8-9-1981'),
 1500, 0, 30
);
insert into emp
values(
 7876, 'ADAMS', 'CLERK', 7788,
 convert(date,'13-JUL-87'),
 1100, null, 20
);
insert into emp
values(
 7900, 'JAMES', 'CLERK', 7698,
 convert(date,'3-12-1981'),
 950, null, 30
);



SELECT * FROM emp 
go

SELECT * FROM dept
go

/*  demonstration of Inner Join */
SELECT e.ename, e.deptno,d.dname, e.sal 
FROM emp AS e
INNER JOIN dept AS d ON (e.deptno = d.deptno)
GO


/*  demonstration of Left Outer Join */
SELECT e.ename, e.deptno,d.dname, e.sal 
FROM emp AS e
LEFT OUTER JOIN dept AS d ON (e.deptno = d.deptno)
GO

/*  demonstration of Left Outer Join */
SELECT e.ename, d.deptno,d.dname, e.sal 
FROM dept AS d
LEFT OUTER JOIN emp AS e ON (e.deptno = d.deptno)
GO


/*  demonstration of right Outer Join */
SELECT e.ename, e.deptno,d.dname, e.sal 
FROM emp AS e
RIGHT OUTER JOIN dept AS d ON (e.deptno = d.deptno)
GO



/*  demonstration of Full Outer Join  - UNION */
SELECT e.ename, d.deptno,d.dname, e.sal 
FROM emp AS e
FULL  OUTER JOIN dept AS d ON (e.deptno = d.deptno)
GO

/*  demonstration of Full Outer Join  - UNION */
SELECT deptno
FROM emp 
UNION
SELECT deptno
FROM dept

SELECT deptno
FROM emp 
UNION ALL
SELECT deptno
FROM dept

SELECT deptno
FROM emp 
INTERSECT
SELECT deptno
FROM dept
go

/* MINUS is not available hence we can use NOT IN */ 
SELECT deptno
FROM dept 
WHERE deptno NOT IN(
SELECT deptno
FROM emp 
)

SELECT deptno
FROM dept 
EXCEPT
SELECT deptno
FROM emp 


SELECT deptno
FROM emp 
EXCEPT
SELECT deptno
FROM dept 

/* SELF JOIN 
Joining the  table to itself is called Self Join 
*/

SELECT e.ename, m.ename AS Manager
FROM emp as e
LEFT JOIN emp AS m ON e.empno = m.mgr
ORDER BY Manager


empno, mgr
1041  , 1032
1032, NULL 

SELECT * FROM emp;

SELECT TOP(3) * FROM emp;

SELECT * FROM emp WHERE empno = 7566


SELECT * FROM emp WHERE sal > 2000
ORDER BY sal DESC

/* Display the distinct or Unique  jobs from emp table */
SELECT DISTINCT(JOB) FROM emp


SELECT *  FROM EMP;

SELECT *  FROM EMP WHERE hiredate BETWEEN '1981-02-04' AND '1981-11-17'

SELECT DATEPART(Year, hiredate) FROM emp

SELECT * FROM emp WHERE DATEPART(Year, hiredate) = 1981


SELECT * FROM dept
/* 
Display the employeename, dname from emp, dept  where loc = 'DALLAS'
*/



SELECT  ename , dname 
FROM emp, dept 
WHERE emp.deptno = dept.deptno
AND loc = 'DALLAS'


SELECT  ename , dname 
FROM emp
INNER JOIN  dept 
ON (emp.deptno = dept.deptno)
AND loc = 'DALLAS'



/* Find out all teh employees who's salary is more than the average salary earned by all employees */
1) find the average salary 
2) filter the emp based on the above output

SELECT avg(sal) FROM emp

SELECT * FROM emp
WHERE sal > 2628

SELECT *   -- Outer Query / Main Query 
FROM emp
WHERE sal > (SELECT avg(sal) FROM emp)  -- Scalar Subquery / Inner Query



SELECT *   -- Outer Query / Main Query 
FROM emp AS e
WHERE sal > (SELECT avg(sal) FROM emp
 WHERE deptno = e.deptno)  

 SELECT ename FROM emp
 WHERE deptno = (SELECT deptno FROM dept WHERE loc = 'DALLAS')

 
 SELECT ename FROM emp AS e , dept AS d
 WHERE e.deptno = d.deptno AND d.loc = 'DALLAS'


/* 
Multiple row subqueries 
IN, ALL , ANY
*/

SELECT ename,job, sal   -- Outer Query / Main Query 
FROM emp
WHERE sal > ALL (SELECT sal 
			      FROM emp
				  WHERE job = 'MANAGER')  -- Multi row Subquery / Inner Query


SELECT sal 
			      FROM emp
				  WHERE job = 'MANAGER'  
select * from emp

SELECT * 
FROM emp
WHERE deptno != 30 and 
sal > any ( select distinct sal from emp where deptno = 30)


select distinct sal from emp where deptno = 30

SELECT sal 
FROM emp
WHERE deptno != 30 



