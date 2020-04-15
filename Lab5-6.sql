--- Lab 05

UNION [ALL]

EXPLAIN PLAN FOR
select ename, job from emp where deptno=10
union
select ename, job from emp where deptno=30
order by job;

SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());

EXPLAIN PLAN FOR
select ename, job from emp where deptno=10 or deptno = 30;

select ename, job from emp where deptno in (10, 30);

INTERSECT

select job from emp where deptno=10
intersect
select job from emp where deptno=30
order by job;

select ename, job from emp where deptno=10
intersect
select ename, job from emp where deptno=30
order by job;

select ename, job from emp where deptno = 10 and deptno=30;


MINUS (diferenta)

select job from emp where deptno=10
minus
select job from emp where deptno=30
order by job;

select job from emp where deptno=30
minus
select job from emp where deptno=10
order by job;


PRODUSUL Catezian

select e.ename, d.dname from emp e, dept d
order by e.ename, d.dname;

select e.ename, d.dname 
from emp e CROSS JOIN dept d
order by e.ename, d.dname;

INNER JOIN


select e.ename, d.dname 
from emp e, dept d
where e.deptno = d.deptno
order by e.ename, d.dname;

select e.ename, d.dname 
from emp e CROSS JOIN dept d
where e.deptno = d.deptno
order by e.ename, d.dname;

select e.ename, d.dname 
from emp e INNER JOIN dept d
on e.deptno = d.deptno
order by e.ename, d.dname;

select e.ename, d.dname 
from emp e INNER JOIN dept d
on e.deptno = d.deptno 
where e.sal > 2000
order by e.ename, d.dname;

EQUI-JOIN

select e.ename, d.dname 
from emp e, dept d
where e.deptno = d.deptno
order by e.ename, d.dname;

select e.ename, d.dname 
from emp e INNER JOIN dept d
on e.deptno = d.deptno 
order by e.ename, d.dname;

NATURAL JOIN

TBL1 (A, B, C)
TBL2 (A, C, D)

Equi JOIN
TBL1.A = TBL2.A
TBL1.A, TBL1.B, TBL1.C, TBL2.A, TBL2.B, TBL.C

Natural JOIN 
TBL1.A = TBL2.A and TBL1.C=TBL2.C
TBL1 |><| TBL2 = (A, B, C, D)


select  e.ename, 
	e.deptno COL_EMP, 
	d.deptno COL_DEPT, 
	d.dname 
from emp e INNER JOIN dept d
on e.deptno = d.deptno 
order by e.ename, d.dname;

select  e.ename, 
	deptno, 
	d.dname 
from emp e NATURAL JOIN dept d
order by e.ename, d.dname;

Theta-JOIN
Theta = {<, <=, <>, =, >=, > }

select g.grade, e.ename
from emp e inner join salgrade g
on e.sal between g.losal and g.hisal;

select g.grade, e.ename
from emp e inner join salgrade g
on e.sal >= g.losal and e.sal <= g.hisal;


Self JOIN

select ang.ename, sef.ename
from emp ang inner join emp sef
on ang.mgr = sef.empno;


select ang.ename, dang.dname, sef.ename, dsef.dname
from 
emp ang natural join dept dang
inner join emp sef 
	inner join dept dsef 
		on sef.deptno  = dsef.deptno
on ang.mgr = sef.empno;


select ang.ename, dang.dname, sef.ename, dsef.dname
from 
emp ang natural join dept dang,
emp sef natural join dept dsef
where ang.mgr = sef.empno;


select ang.ename, dang.dname, sef.ename, dsef.dname
from 
emp ang natural join dept dang
inner join emp sef natural join dept dsef 
on ang.mgr = sef.empno;

OUTER JOIN


INSERT INTO EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM)
VALUES(7999, 'TRUICA', 'ANALYST', 7566, '12-MAY-1981', 3100, 800);


LEFT OUTER JOIN

select e.ename, d.dname
from emp e left outer join dept d
on e.deptno = d.deptno;

select e.ename, d.dname
from emp e inner join dept d
on e.deptno = d.deptno
union
(
	select ename, null
	from emp
	minus
	select e.ename, null
	from emp e inner join dept d
	on e.deptno = d.deptno
);



RIGHT OUTER JOIN

select e.ename, d.dname
from emp e right outer join dept d
on e.deptno = d.deptno;

select e.ename, d.dname
from emp e inner join dept d
on e.deptno = d.deptno
union
(
	select null, dname
	from dept
	minus
	select null, d.dname
	from emp e inner join dept d
	on e.deptno = d.deptno
);

---------------
select e.ename, d.dname
from emp e left outer join dept d
on e.deptno = d.deptno;
-- ~=
select e.ename, d.dname
from dept d right outer join emp e
on e.deptno = d.deptno;

FULL OUTER JOIN

select e.ename, d.dname
from dept d full outer join emp e
on e.deptno = d.deptno;


---- Lab 06

select sin(sal) from emp;

select hiredate,
	sysdate,
	sysdate + 5,
	sysdate - 5,
	sysdate - hiredate vechime_zile
from emp;







