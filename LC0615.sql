create database `LC0615`;
use LC0615;


Create table If Not Exists salary (id int, employee_id int, amount int, pay_date date);
Create table If Not Exists employee (employee_id int, department_id int);
Truncate table salary;
insert into salary (id, employee_id, amount, pay_date) values ('1', '1', '9000', '2017/03/31');
insert into salary (id, employee_id, amount, pay_date) values ('2', '2', '6000', '2017/03/31');
insert into salary (id, employee_id, amount, pay_date) values ('3', '3', '10000', '2017/03/31');
insert into salary (id, employee_id, amount, pay_date) values ('4', '1', '7000', '2017/02/28');
insert into salary (id, employee_id, amount, pay_date) values ('5', '2', '6000', '2017/02/28');
insert into salary (id, employee_id, amount, pay_date) values ('6', '3', '8000', '2017/02/28');
Truncate table employee;
insert into employee (employee_id, department_id) values ('1', '1');
insert into employee (employee_id, department_id) values ('2', '2');
insert into employee (employee_id, department_id) values ('3', '2');


SELECT
	department_salary.pay_month,
	department_id,
	case
		when department_avg > company_avg
			then 'higher'
		when department_avg < company_avg
			then 'lower'
		ELSE
			'same'
	end as comparison
from (
	SELECT
		avg(amount) as company_avg,
		DATE_FORMAT(pay_date, '%Y-%m') as pay_month
	from
		salary
	group by DATE_FORMAT(pay_date, '%Y-%m')
) as department_salary
inner JOIN (
	SELECT
		department_id,
		avg(amount) as department_avg,
		DATE_FORMAT(pay_date, '%Y-%m') as pay_month
	from
		salary
		inner join employee
		on salary.employee_id = employee.employee_id
	group by department_id, pay_month
) as company_salary
on department_salary.pay_month = company_salary.pay_month;

with cte as (
	SELECT distinct
		date_format(pay_date, '%Y-%m') as pay_month,
		department_id,
		avg(amount) over(partition by date_format(pay_date, '%Y-%m'), department_id) as department_avg,
		avg(amount) over(partition by date_format(pay_date, '%Y-%m')) as company_avg
	from
		salary
		inner join employee
		on salary.employee_id = employee.employee_id
)
SELECT
	pay_month, department_id,
	CASE
		when department_avg > company_avg
			then 'higher'
		when department_avg < company_avg
			then 'lower'
		ELSE
			'same'
	end as comparison
from cte
order by pay_month desc, department_id