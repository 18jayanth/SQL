//Subquery

select * from emp;

 EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
------ ---------- --------- ---------- --------- ---------- ---------- ----------
  7499 ALLEN      SALESMAN        7698 20-FEB-81       1600        300         30
  7521 WARD       SALESMAN        7698 22-FEB-81       1250        500         30
  7566 JONES      MANAGER         7839 02-APR-81       2975                    20
  7654 MARTIN     SALESMAN        7698 28-SEP-81       1250       1400         30
  7698 BLAKE      MANAGER         7839 01-MAY-81       2850                    30
  7782 CLARK      MANAGER         7839 09-JUN-81       2450                    10
  7788 SCOTT      ANALYST         7566 19-APR-87       3000                    20
  7839 KING       PRESIDENT            17-NOV-81       5000                    10
  7844 TURNER     SALESMAN        7698 08-SEP-81       1500          0         30
  7876 ADAMS      CLERK           7788 23-MAY-87       1100                    20
  7900 JAMES      CLERK           7698 03-DEC-81        950                    30
  7902 FORD       ANALYST         7566 03-DEC-81       3000                    20
  7934 MILLER     CLERK           7782 23-JAN-82       1300                    10

/*Q1) Write a Query To display all the employee details who get maximum salary */
select * from emp where sal=(select max(sal) from emp);

EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---- ---------- --------- ---------- --------- ---------- ---------- ----------
7839 KING       PRESIDENT            17-NOV-81       5000                    10

/* Q2) Write a Query To display all the employee details who get minimum salary */
select * from emp where sal=(select min(sal) from emp);

EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---- ---------- --------- ---------- --------- ---------- ---------- ----------
7900 JAMES      CLERK           7698 03-DEC-81        950                    30

/* Q3)Write a Query To display all the employee details who  joined first for a company */
select * from emp where hiredate=(select min(hiredate) from emp);

 EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
------ ---------- --------- ---------- --------- ---------- ---------- ----------
  7499 ALLEN      SALESMAN        7698 20-FEB-81       1600        300         30
  
/* Q4)Write a Query To display all the employee details who are working in sales department */
 select * from emp where deptno=(select deptno from dept where dname='SALES');

 EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
------ ---------- --------- ---------- --------- ---------- ---------- ----------
  7499 ALLEN      SALESMAN        7698 20-FEB-81       1600        300         30
  7521 WARD       SALESMAN        7698 22-FEB-81       1250        500         30
  7654 MARTIN     SALESMAN        7698 28-SEP-81       1250       1400         30
  7698 BLAKE      MANAGER         7839 01-MAY-81       2850                    30
  7844 TURNER     SALESMAN        7698 08-SEP-81       1500          0         30
  7900 JAMES      CLERK           7698 03-DEC-81        950                    30
  
 /* Q5)Write a Query To display deptname and location of all the salesman and manager */
  select dname,loc from dept where deptno in (select deptno from emp where job in ('SALESMAN','MANAGER'));
  DNAME          LOC
-------------- ------------
ACCOUNTING     NEW YORK
RESEARCH       DALLAS
SALES          CHICAGO
//We should be careful when to use "=" and when to use "IN"

/* Q6)Write a Query To display deptname of allen smith */
SELECT DNAME FROM DEPT WHERE DEPTNO IN (SELECT DEPTNO FROM EMP WHERE ENAME IN ('ALLEN','SMITH'));
DNAME
--------------
SALES

/* Q7)Write a Query To display  all the details of employee whose location consists of atleast one 'O' in it */

 select * from emp where deptno in (select deptno from dept where loc like '%O%');

 EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
------ ---------- --------- ---------- --------- ---------- ---------- ----------
  7499 ALLEN      SALESMAN        7698 20-FEB-81       1600        300         30
  7521 WARD       SALESMAN        7698 22-FEB-81       1250        500         30
  7654 MARTIN     SALESMAN        7698 28-SEP-81       1250       1400         30
  7698 BLAKE      MANAGER         7839 01-MAY-81       2850                    30
  7782 CLARK      MANAGER         7839 09-JUN-81       2450                    10
  7839 KING       PRESIDENT            17-NOV-81       5000                    10
  7844 TURNER     SALESMAN        7698 08-SEP-81       1500          0         30
  7900 JAMES      CLERK           7698 03-DEC-81        950                    30
  7934 MILLER     CLERK           7782 23-JAN-82       1300                    10
  
 /*Q8)Write a Query To display  second highest salary */
  select max(sal) from emp where sal<>(select max(sal) from emp);

MAX(SAL)
------
  3000
  
/*Q9)Write a Query To display  all the details of employee who get second highest salary */
select ename from emp where sal in (
select max(sal) from emp where sal<>(
select max(sal) from emp));
ENAME
-------
SCOTT
FORD

/* Q10)Write a Query To display  all the details of ALLEN's MANAGER */
select * from emp where empno=(
select mgr from emp where ename=('ALLEN'));

EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---- ---------- --------- ---------- --------- ---------- ---------- ----------
7698 BLAKE      MANAGER         7839 01-MAY-81       2850                    30

/* Q11)Write a Query To display  all the details of EMPLOYEE WHO HAS ALLEN'S MANAGER AS THEIR MANAGER */
SELECT * FROM EMP WHERE EMPNO IN (
SELECT EMPNO FROM EMP WHERE MGR=(
SELECT MGR FROM EMP WHERE ENAME =('ALLEN')));

EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---- ---------- --------- ---------- --------- ---------- ---------- ----------
7499 ALLEN      SALESMAN        7698 20-FEB-81       1600        300         30
7521 WARD       SALESMAN        7698 22-FEB-81       1250        500         30
7654 MARTIN     SALESMAN        7698 28-SEP-81       1250       1400         30
7844 TURNER     SALESMAN        7698 08-SEP-81       1500          0         30
7900 JAMES      CLERK           7698 03-DEC-81        950                    30

/* Q12)Write a Query To display  all the details of ALLEN's MANAGER'S MANAGER */
 SELECT * FROM EMP WHERE EMPNO=(
SELECT MGR FROM EMP WHERE EMPNO=(
SELECT MGR FROM EMP WHERE ENAME='ALLEN'));

EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
----- ---------- --------- ---------- --------- ---------- ---------- ----------
 7839 KING       PRESIDENT            17-NOV-81       5000                    10
 
/* Q13)Write a Query To display  all the details of Employee whose salary is more than scott */
select * from emp where sal>(select sal from emp where ename='SCOTT');

EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
----- ---------- --------- ---------- --------- ---------- ---------- ----------
 7839 KING       PRESIDENT            17-NOV-81       5000                    10

/* Q14)write a Query To display of the employee whose salary is greater than average salary of department 30 (output only from department 30) */
select * from emp where deptno=30 and sal>(select avg(sal) from emp where deptno=30);

MPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---- ---------- --------- ---------- --------- ---------- ---------- ----------
7499 ALLEN      SALESMAN        7698 20-FEB-81       1600        300         30
7698 BLAKE      MANAGER         7839 01-MAY-81       2850                    30

/* Q15)Write a Query To display employee name,job of all the salesman who is earning more than maximum salary of clerk */
 select ename,job from emp where job='SALESMAN' and sal>(
 select max(sal) from emp where job='CLERK');
ENAME      JOB
---------- ---------
ALLEN      SALESMAN
TURNER     SALESMAN



