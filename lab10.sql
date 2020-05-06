/*
create table exemplu
(
	data_implicita date default sysdate,
	numar_implicit number(7,2) default 7.24,
	string_implicit varchar2(5) default 'test',
	operator varchar2(10) default user
);

select table_name, column_name, data_default
from user_tab_columns
where table_name = 'EXEMPLU';

CREATE TABLE studenti
(
	facultate char(30) default 'Automatica si Calculatoare',
	catedra char(20),
	cnp number(13),
	nume VARCHAR2(30),
	data_nasterii date,
	an_univ number(4) DEFAULT 2019,
	medie_admitere number(4,2),
	descip_oblig VARCHAR2(20) DEFAULT 'Matematica',
	descip_opt varchar(20) DEFAULT 'Fizica',
	operator VARCHAR(20) DEFAULT user,
	data_opt TIMESTAMP DEFAULT sysdate
);
*\

/* Tabela cu veniturile angajatiilor din departamentul 20*/
/*
CREATE TABLE dept_20
AS 
SELECT id_dep, nume, data_ang, salariu + nvl(comision,0) venit
FROM angajati
WHERE id_dep = 20;
*/

/* Tabela cu o prima de 15% din venitul lunar pentru angajatii din dep 30 */
/*
CREATE TABLE dept_30 
(
	id DEFAULT 30,
	nume NOT NULL,
	data_ang, 
	prima
)
AS 
SELECT id_dep, nume, data_ang,
	round(0.15 * (salariu + nvl(comision,0)) , 0)
FROM angajati
WHERE id_dep = 30;
*/
/*
CREATE TABLE exemplu2
(
	col1 number(2) constraint nn_col1 not NULL,
	col2 VARCHAR2(20) NOT NULL
);

CREATE TABLE exemplu3
(
	col1 number(2) constraint uq_col1 unique,
	col2 varchar2(20) unique
);

CREATE TABLE exemplu4
(
	col1 number(2),
	col2 varchar2(20),
	constraint uq_col1_a unique(col1),
	unique(col2)
);

CREATE TABLE exemplu5
(
	col1 number(2),
	col2 varchar2(20),
	constraint uq_col2 unique(col1, col2)
);
*/

/*
CREATE TABLE functii
(
	cod number(2) constraint pk_cod primaky key,
	functie varchar2(20),
	data_vigoare DATE DEFAULT sysdate
);
*/
/*
CREATE TABLE persoane
(
	nume varchar2(20),
	prenume varchar2(20),
	serie_ci varchar2(2),
	cod_ci number(6),
	cnp number(13),
	constraint pk_persoane primary key(serie_ci, cod_ci, cnp)
);
*/
/*
CREATE TABLE angajati2
(
	id_ang number(4)
		constraint pk_id_ang2 primaky key,
	id_sef number(4),
	id_dep number(2)
		constraint fk_id_dep2 references departamente(id_dep),
	nume varchar2(20),
	functie varchar2(9),
	data_ang date,
	salariu number(7,2),
	comision number(7,2),
	constraint fk_id_sef2 foreign key(id_sef) references angajati2(id_ang)
);
*/

/*
	Tabela angajati care verifica daca salariul este mai mare ca 0, 
	iar comisionul nu depaseste salariul
	nume este scris doar cu litere mari.
*/
/*
CREATE TABLE angajati3
(
	id_ang number(4) constraint pk_id_ang3 primaky key,

	nume varchar(10) constraint ck_nume check(nume=upper(nume)),

	functie varchar2(10),
	id_sef number(4) constraint fk_id_sef3 references angajati3(id_ang),

	data_ang date default sysdate,
	salariu number(7,2) constraint nn_salariu not null,

	comision numer(7,2),
	id_dep number(2) constraint nn_id_dep3 not null,

	constraint fk_id_dep3 foreign key(id_dep) 
		references departamente(id_dep),
	constraint ck_comision check(comision <= salariu)
);
*/
/*
CREATE TABLE PRIME
    (
	Nume_sef,
	DATA_ANG_SEF,
	SAL_SEF,
	NUM_SUBALT,
	DATA_ANG_SUBALT,
	JOB_SUBALT,
	PRIMA
	)
AS
SELECT 
	S.ENAME,
	S.HIREDATE,
	S.SAL,
	E.ENAME,
	E.HIREDATE,
	E.JOB,
	(S.SAL / 2)
FROM
	EMP E,
	EMP S
WHERE
	E.DEPTNO = S.DEPTNO AND
	E.MGR = S.EMPNO AND
	EXTRACT(YEAR FROM E.HIREDATE) = EXTRACT(YEAR FROM S.HIREDATE);

*/

SELECT MIN(EXTRACT(YEAR FROM hiredate)) FROM emp WHERE  emp.empno IN (SELECT mgr from emp);