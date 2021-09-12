create database `LC1270`;
use LC1270;

Create table If Not Exists Employees (employee_id int, employee_name varchar(30), manager_id int);
Truncate table Employees;
insert into Employees (employee_id, employee_name, manager_id) values ('1', 'Boss', '1');
insert into Employees (employee_id, employee_name, manager_id) values ('3', 'Alice', '3');
insert into Employees (employee_id, employee_name, manager_id) values ('2', 'Bob', '1');
insert into Employees (employee_id, employee_name, manager_id) values ('4', 'Daniel', '2');
insert into Employees (employee_id, employee_name, manager_id) values ('7', 'Luis', '4');
insert into Employees (employee_id, employee_name, manager_id) values ('8', 'John', '3');
insert into Employees (employee_id, employee_name, manager_id) values ('9', 'Angela', '8');
insert into Employees (employee_id, employee_name, manager_id) values ('77', 'Robert', '1');


with recursive cte as (
	select
		employee_id
	from
		Employees
	where
		manager_id = 1
		and employee_id != 1
	union all
	select
		e.employee_id
	from
		cte
	inner join Employees as e
		on cte.employee_id = e.manager_id
)
select
	employee_id
from
	cte
