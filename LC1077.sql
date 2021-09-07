create database `LC1077`;
use LC1077;

Create table If Not Exists Project (project_id int, employee_id int);
Create table If Not Exists Employee (employee_id int, name varchar(10), experience_years int);
Truncate table Project;
insert into Project (project_id, employee_id) values ('1', '1');
insert into Project (project_id, employee_id) values ('1', '2');
insert into Project (project_id, employee_id) values ('1', '3');
insert into Project (project_id, employee_id) values ('2', '1');
insert into Project (project_id, employee_id) values ('2', '4');
Truncate table Employee;
insert into Employee (employee_id, name, experience_years) values ('1', 'Khaled', '3');
insert into Employee (employee_id, name, experience_years) values ('2', 'Ali', '2');
insert into Employee (employee_id, name, experience_years) values ('3', 'John', '3');
insert into Employee (employee_id, name, experience_years) values ('4', 'Doe', '2');


with cte as (
	select
		p.project_id,
		e.employee_id,
		e.experience_years
	from
		Project as p
		inner join Employee as e
		on p.employee_id = e.employee_id
)
select
	project_id,
	employee_id
from
	cte
where
	(project_id, experience_years) in (
		select
			project_id, max(experience_years)
		from cte
		group by project_id
	)