create database `LC0185`;
use LC0185;

Create table If Not Exists Employee (Id int, Name varchar(255), Salary int, DepartmentId int);
Create table If Not Exists Department (Id int, Name varchar(255));
Truncate table Employee;
insert into Employee (Id, Name, Salary, DepartmentId) values ('1', 'Joe', '85000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('2', 'Henry', '80000', '2');
insert into Employee (Id, Name, Salary, DepartmentId) values ('3', 'Sam', '60000', '2');
insert into Employee (Id, Name, Salary, DepartmentId) values ('4', 'Max', '90000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('5', 'Janet', '69000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('6', 'Randy', '85000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('7', 'Will', '70000', '1');
Truncate table Department;
insert into Department (Id, Name) values ('1', 'IT');
insert into Department (Id, Name) values ('2', 'Sales');

SELECT
	Department,
	Employee,
	Salary
from (
	select
		d.Name as Department,
		e.Name as Employee,
		e.Salary,
		DENSE_RANK() over(partition by d.id order by e.Salary desc) as `rank`
	FROM
		Employee as e
		inner join Department as d
		on e.DepartmentId = d.Id
) rank_tbl
where `rank` < 4;


with cte as (
	SELECT
		Name as Employee,
		Salary as Salary,
		DepartmentId,
		DENSE_RANK() over(partition by DepartmentId order by Salary desc) as `rank`
	FROM
		Employee
)
select
	cte.Employee,
	cte.Salary,
	d.Name As Department
FROM
	cte
	inner join Department as d
	on cte.DepartmentId = d.Id
where
	cte.rank <= 3;