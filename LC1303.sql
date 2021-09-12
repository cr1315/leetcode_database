create database `LC1303`;
use LC1303;

Create table If Not Exists Employee (employee_id int, team_id int);
Truncate table Employee;
insert into Employee (employee_id, team_id) values ('1', '8');
insert into Employee (employee_id, team_id) values ('2', '8');
insert into Employee (employee_id, team_id) values ('3', '8');
insert into Employee (employee_id, team_id) values ('4', '7');
insert into Employee (employee_id, team_id) values ('5', '9');
insert into Employee (employee_id, team_id) values ('6', '9');


select
	employee_id,
	team_size
from
	Employee as e
inner join (
	select
		team_id,
		count(*) as team_size
	from
		Employee
	group by team_id
) as ts
	using(team_id)