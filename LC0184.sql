create database `LC0184`;
use LC0184;

Create table If Not Exists Employee (Id int, Name varchar(255), Salary int, DepartmentId int);
Create table If Not Exists Department (Id int, Name varchar(255));
Truncate table Employee;
insert into Employee (Id, Name, Salary, DepartmentId) values ('1', 'Joe', '70000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('2', 'Jim', '90000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('3', 'Henry', '80000', '2');
insert into Employee (Id, Name, Salary, DepartmentId) values ('4', 'Sam', '60000', '2');
insert into Employee (Id, Name, Salary, DepartmentId) values ('5', 'Max', '90000', '1');
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
		e.Salary as Salary,
		RANK() over(partition by e.DepartmentId order by e.Salary desc) as `rank`
	FROM
		Employee as e
		inner join Department as d
		on e.DepartmentId = d.Id
) rank_tbl
where `rank` = 1;