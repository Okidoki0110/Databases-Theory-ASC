-- cerere care intoarce o valoare (1 linie si 1 coloana)
select avg(sal) from emp;


-- cerere care intoarce o linie (1 linie si mai multe coloane)
select job, sal from emp where empno=7521;

-- cerere care intoarce o coloana(mai multe linii si o coloana)
select min(sal) from emp where job != 'PRESIDENT' group by job;

-- cerere care intoarce un tabel (mai multe linii si mai multe coloane)
select deptno, min(sal) from emp group by deptno;


-- Subcereri in clauza WHERE necorelate

-- subcerere care intoarce o valoare
-- se pot folosii toti operatorii de comparatie
-- se poate folosi IN
-- se poate folosi NOT pentru negare
select ename, sal
from emp 
where sal >= (select avg(sal) from emp);

-- subcerere care intoarce o linie
-- se pot folosii operatorii de egalitate si diferit
-- se poate folosi IN
-- se poate folosi NOT pentru negare
select ename, job, sal
from emp 
where (job, sal) = (select job, sal from emp where empno=7521);

-- subcerere care intoarce o coloana
-- se poate folosi IN
-- se poate folosi NOT pentru negare
select ename, sal
from emp
where sal in (select min(sal) from emp where job != 'PRESIDENT' group by job);

select ename, sal
from emp
where not sal in (select min(sal) from emp where job != 'PRESIDENT' group by job);

-- exemplu care nu merge din cauza operatorului de comparatie >=
select ename, sal
from emp
where sal >= (select min(sal) from emp where job != 'PRESIDENT' group by job);

-- subcerere care intoarce o tabela
-- se poate folosi IN
-- se poate folosi NOT pentru negare

select deptno, ename, sal
from emp
where (deptno, sal) in (select deptno, min(sal) from emp group by deptno);

-- subcerere corelate 
-- subcererea este corelata cu valorile din cererea principala prin conditia where din subcerere
select e1.deptno, e1.ename, e1.sal
from emp e1
where e1.sal >= (select avg(e2.sal) from emp e2 
			where e1.deptno=e2.deptno);

-- nu mai e nevoie de group by pt departamente fiindca se face un singur grup din cauza valorii 10
select avg(e2.sal) from emp e2 
where e2.deptno=10
group by deptno;

select avg(e2.sal) from emp e2 
where e2.deptno=10;


-- Subcereri in clauza FROM

-- produs cartezian
select e.ename, a.medie
from emp e, (select avg(sal) medie from emp) a;

-- corelarea se face in afara cererii fie in clauza WHERE a cererii principale, fie in clauza ON (daca folositi JOIN) a cererii principale
select e.ename, a.medie
from emp e, (select deptno, avg(sal) medie from emp group by deptno) a
where a.deptno=e.deptno;


select e.ename, a.medie
from emp e 
	INNER JOIN (select deptno, avg(sal) medie from emp group by deptno) a
	on a.deptno=e.deptno;

-- in cazul in care sunt multe subcereri in clauza FROM se poate folosi WITH
WITH
	a as (select deptno, avg(sal) medie from emp group by deptno)
select e.ename, a.medie
from emp e 
INNER JOIN  a
on a.deptno=e.deptno;

-- nu returneaza primii 3 angajatii cu cele mai mici salarii
SELECT ename, sal
FROM emp
WHERE ROWNUM <= 3
ORDER BY sal;

-- primii 3 angajatii cu cele mai mici salarii
select * 
from 
(
	SELECT ename, sal
	FROM emp
	ORDER BY sal
)
WHERE rownum <=3;

-- primii 3 angajatii cu cele mai mici salarii
SELECT ename, sal
FROM emp
ORDER BY sal
FETCH NEXT 3 ROWS ONLY;


-- nu merge -- ORDER BY nu e permis in subcereri in clauza WHERE si HAVING
select ename, sal
from emp
where sal >= (select min(sal) 
		from emp 
		where job != 'PRESIDENT' 
		group by job 
		order by job);


-- puteti sa definiti subcereri si parti din cererea sql cu variabile de substitutie pe o SINGURA LINIE

define tbl = "SELECT ename, sal FROM emp ORDER BY sal"

select * 
from 
(&tbl)
WHERE sal > 2500;

select ename, 
case when sal <2500 then 1 else 2 end test
from emp;

define c="case when sal<2500 then 1 else 2 end test"

select ename, 
&c 
from emp;









