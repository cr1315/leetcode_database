create database `LC0579`;
use LC0579;


Create table If Not Exists Employee (Id int, Month int, Salary int);
Truncate table Employee;
insert into Employee (Id, Month, Salary) values ('1', '1', '20');
insert into Employee (Id, Month, Salary) values ('2', '1', '20');
insert into Employee (Id, Month, Salary) values ('1', '2', '30');
insert into Employee (Id, Month, Salary) values ('2', '2', '30');
insert into Employee (Id, Month, Salary) values ('3', '2', '40');
insert into Employee (Id, Month, Salary) values ('1', '3', '40');
insert into Employee (Id, Month, Salary) values ('3', '3', '60');
insert into Employee (Id, Month, Salary) values ('1', '4', '60');
insert into Employee (Id, Month, Salary) values ('3', '4', '70');
insert into Employee (Id, Month, Salary) values ('1', '7', '90');
insert into Employee (Id, Month, Salary) values ('1', '8', '90');


SELECT
	Id,
	`Month`,
	sum(Salary) over(partition by Id order by month rows between 2 PRECEDING and current row) as Salary
from
	Employee as e
where
	`Month` != (select max(`Month`) from Employee where Id = e.Id)
order by Id, `Month` desc;


/*
select *
from
	Employee as a
	inner join Employee as b
	on a.Id = b.Id 
	and b.month between a.month-2 and a.month
order by a.Id, a.Month, b.Month desc;
*/
SELECT
	a.Id as id,
	max(b.Month) as `month`,
	sum(b.Salary) as Salary
from
	Employee as a
	inner join Employee as b
	on a.Id = b.Id 
	and b.month between a.month-2 and a.month
where a.month != (select max(`Month`) from Employee where Id = a.Id) 
group by a.Id, a.Month
order by a.Id, a.Month desc;

