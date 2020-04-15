-- Sa se calculeze o prima pentru angajatii care
-- - au lungimea numelui mai mica sau egal cu 5
-- - au venit in firma in acelasi an cu seful lor. 

-- Prima se calculeaza dupa urmatoarea formula salariu * c * |log2(n)/((n^2+1)*sin(n^2+1))| unde 
--  - n este vechimea in firma calculata in ani cu virgula
--  - c este o constanta data de la tastatura (100) 

-- Sa se afiseze:
--  - numele angajatului
--  - numele departamentul in care lucreaza angajatul
--  - data angajarii pentru angajat doar luna si anul
--  - prima
--  - numele sefului
--  - numele departamentul sefului
--  - data angajarii pentru sef doar luna si anul
-- Rotunjiti prima la 2 zecimale
-- Formatati numelui angajatilor si denumirea departamentele astfel incat sa apara prima litera mare si restul literelor mici.
-- Ordonati crescator dupa numele angajatului.

-- rezolvare
define c = 100
define n = "months_between(sysdate, ang.hiredate)"
define p = "power(&n, 2) + 1"
define prima = "round(ang.sal * &c * abs(log(2, &n)/(&p * sin(&p))), 2)"


SELECT
	INITCAP(ang.ename) nume_ang,
	INITCAP(dang.dname) dept_ang,
	extract(month from ang.hiredate) ||' '||extract(year from ang.hiredate) data_ang,
	&prima prima,
	INITCAP(sef.ename) nume_sef,
	INITCAP(dsef.dname) dept_sef,
	extract(month from sef.hiredate) ||' '||extract(year from sef.hiredate) data_ang
FROM
	emp ang natural join dept dang
	INNER JOIN
	emp sef natural join dept dsef
	ON ang.mgr = sef.empno 
	and extract(year from ang.hiredate) = 
	extract(year from sef.hiredate)
WHERE
	length(ang.ename) <= 5
ORDER BY
	ang.ename;


SELECT sum(e.sal) from emp e;

SELECT count(empno) from emp e;

SELECT count(distinct empno) from emp e;

SELECT count(job) from emp e;

SELECT count(distinct job) from emp e;

select comm from emp;

select count(distinct comm) from emp;

select avg(comm) from emp;

SELECT count(empno) from emp e;


SELECT job, extract(year from hiredate) year, empno
from emp
order by 1, 2;


SELECT job, count(empno)
from emp
group by job
order by 1, 2;

SELECT job, deptno, count(empno)
from emp
group by job
order by 1, 2;

SELECT job, extract(year from hiredate) year, count(empno)
from emp
GROUP BY job, extract(year from hiredate)
order by 1, 2;

SELECT job, comm, count(empno)
from emp
GROUP BY job, comm
order by 1, 2;


SELECT job, extract(year from hiredate) year, count(empno)
from emp
WHERE job in ('CLERK', 'SALESMAN', 'ANALYST')
GROUP BY job, extract(year from hiredate)
order by 1, 2;

SELECT job, extract(year from hiredate) year, count(empno)
FROM emp
WHERE job in ('CLERK', 'SALESMAN', 'ANALYST')
GROUP BY job, extract(year from hiredate)
HAVING count(empno) >=2 and sum(sal) >= 3500
ORDER BY 1, 2;

SELECT job, extract(year from hiredate) year, count(empno)
FROM emp
WHERE job in ('CLERK', 'SALESMAN', 'ANALYST')
GROUP BY job, extract(year from hiredate)
HAVING count(empno) >=2 and sum(sal) >= 3500
ORDER BY 1, 2;

select avg(comm) from emp;

select sum(comm)/count(*) from emp;

select sum(comm)/count(comm) from emp;


















