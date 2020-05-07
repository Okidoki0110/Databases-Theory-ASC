/* Exercitul 1
*Sa se scrie o cerere SQL*Plus care face o lista cu:
*- Id angajat concatenat cu nume angajatului scris cu litere mici folosind simbolul _ (ex: 7839_ion)
*- Numele sefului direct al angajatului, scris cu initiala mare si restul literelor mici (ex: King)
*- Venitul anual al angajatului (se ia in considerare comisionul) formatat astfel incat sa apara semnul $ in fata, virgula la mii, 2 zecimale afisate (ex: $11,400.00)
*- Departamentul  in care lucreaza codificat astfel:
*	10 contabilitate
*	20 cercetare
*	30 vanzari
*	40 operatiuni
*- Luna angajarii angajatului
*- Numarul de luni dintre data angajarii angajatului si cea a angajarii sefului direct, fara zecimale
*- Salariul mediu pentru functia angajatului
*
*Afisati informatiile doar pentru angajatii cu cel mai mare venit lunar din depatamentul in care lucreaza.
*Ordonati dupa numele sefului descendent. 
*Folositi alias pentru fiecare coloana.
*/
​
/* comenzi utile*/
set lines 250
select table_name from user_tables;
desc emp;
​
​
select e.empno||'_'||lower(e.ename) nume,
	initcap (s.ename) sef,
	to_char(12*(e.sal+nvl(e.comm,0)), '$99,999.99') venit,
	decode (e.deptno, 10, 'contabilitate',
		20, 'cercetare',
		30, 'vanzari',
		'operatiuni') dep,
	extract (month from e.hiredate) luna,
	round(abs(months_between(e.hiredate, s.hiredate))) vechime,
	job_avg.sal sal
from emp e
	join emp s on e.mgr = s.empno
	join (select job, avg(sal) sal
		from emp
		group by job) job_avg on e.job = job_avg.job
where (e.sal + nvl(e.comm, 0)) >= all (select sal + nvl(comm,0)  
	from emp 
	where deptno = e.deptno)
order by 2 desc;

/* Exercitul 2
*Sa creeze o tabela colocviu care are coloane cu urmatoarele denumiri si constrangeri:
*- idAngajat => unique
*- numeAngajat => not null
*- departament (denumirea departamentului in care lucreaza angajatul alipita de id-ul departamentului) => not null
*- job > default ANALYST
*- salariuAngajat 
*- salariuMediuJob (salariul mediu pentru job-ul angajatului)
*
*Sa se insereze in tabela colocviu datele pentru angajatii:
*- care lucreaza in departamentul ‘research’
*- care au salariul mai mare sau egal cu salariul mediu job-ul angajatului
*
*Adaugati in tabelul colocviu o intrare pentru numele vostru.
*/
​
drop table colocviu;
​
create table colocviu 
(
	idAngajat unique,
	numeAngajat not null,
	departament not null,
	job default 'ANALYST',
	salariuAngajat,
	salariuMediuJob
)
as
select a.empno, a.ename, deptno||'-'||d.dname, a.job, a.sal, avgJob.avgSal
from emp a natural join dept d
	join (select job, avg(sal) avgSal
			from emp
			group by job) avgJob on a.job = avgJob.job
where d.dname = 'RESEARCH'
	and a.sal >= avgJob.avgSal;
​
insert into colocviu (idAngajat, numeAngajat, departament) values (1000, 'Maria', '10-A');

/* Exercitul 3
* Afisati
*	- gradul salarial
*	- numele departamentului
*	- numele angajatului
*	- salariul angajatului
*	- functia salariatului
* 	- salariul mediu al departamentului in care lucreaza angajatul
*	- data angajatii - in formatul DD-MM-YYYY
*
* Pentru angajatii
*	- care nu sunt sefi 
*		si 
* 	- care au salariul mai mic sau egal cu salariul mediu din departamentul in care lucreaza 
*		si
*	- care lucreaza in departamentele
*		- cu cei mai multi angajati care au o vechime in companie mai mare sau egala cu 38 de ani si salariul mediu al acestora este mai mare sau egal cu salariul mediu din firma
* ordonati dupa numele angajatului
*/


DEFINE tbl = "(select deptno, count(empno) cnt from emp where months_between(sysdate, hiredate)/12 >= 38 group by deptno having avg(sal) >= (select avg(sal) from emp))"

SELECT
	g.grade,
	d.dname,
	e.ename,
	e.sal,
	e.job,
	(select round(avg(sal),2) from emp where deptno=e.deptno) sal_avg,
	to_char(e.hiredate, 'DD-MM-YYYY') data_ang
FROM 
	emp e
	inner join dept d on d.deptno = e.deptno
	inner join salgrade g on e.sal between g.losal and g.hisal
where
	not exists(select empno from emp where mgr = e.empno)
	and
	sal <= (select round(avg(sal),2) from emp where deptno=e.deptno)
	and
	e.deptno in (select t.deptno from &tbl t where t.cnt = (select max(cnt) from &tbl))
order by e.ename;

-- Tabel temporar in clauza WITH
-- va merge doar daca nu este corelat cu datele din alte tabele
WITH
	tbl as (select deptno, count(empno) cnt from emp where months_between(sysdate, hiredate)/12 >= 38 group by deptno having avg(sal) >= (select avg(sal) from emp))
SELECT
	g.grade,
	d.dname,
	e.ename,
	e.sal,
	e.job,
	(select round(avg(sal),2) from emp where deptno=e.deptno) sal_avg,
	to_char(e.hiredate, 'DD-MM-YYYY') data_ang
FROM 
	emp e
	inner join dept d on d.deptno = e.deptno
	inner join salgrade g on e.sal between g.losal and g.hisal
where
	not exists(select empno from emp where mgr = e.empno)
	and
	sal <= (select round(avg(sal),2) from emp where deptno=e.deptno)
	and
	e.deptno in (select t.deptno from tbl t where t.cnt = (select max(cnt) from tbl))
order by e.ename;
