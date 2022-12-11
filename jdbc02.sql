CREATE TABLE companies
(
  company_id SMALLINT,
  company VARCHAR(20),
  number_of_employees SMALLINT
);

INSERT INTO companies VALUES(100, 'IBM', 12000);
INSERT INTO companies VALUES(101, 'GOOGLE', 18000);
INSERT INTO companies VALUES(102, 'MICROSOFT', 10000);
INSERT INTO companies VALUES(103, 'APPLE', 21000);

SELECT * FROM companies;


--1. Örnek: companies tablosundan en yüksek ikinci number_of_employees değeri olan
--company ve number_of_employees değerlerini çağırın.
select company, number_of_employees from companies
order by number_of_employees desc 
offset 1 row
fetch next 1 row only;

--2. yol: subquery ile:
select company, number_of_employees from companies
where number_of_employees=
(select max(number_of_employees) from companies
where number_of_employees<(select max(number_of_employees) from companies));

--1. Örnek: number_of_employees değeri ortalama çalışan sayısından az olan
--number_of_employees değerlerini 16000 olarak UPDATE edin.
update companies 
set number_of_employees=16000
where number_of_employees<
(select avg (number_of_employees) from companies);

--intelijdeki degisimleri gormek istedigim icin ortalamaya bakiyorum.
select avg (number_of_employees) from companies;

