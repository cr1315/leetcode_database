SELECT (
	select
		DISTINCT 
		e.Salary AS SecondHighestSalary
	from
		Employee e
	order by
		e.Salary DESC
	limit 1 offset 1
) SecondHighestSalary;


with cte as (
	select 
		salary, 
		DENSE_RANK() over (order by salary desc) as grader
	from Employee
)
select max(salary) as SecondHighestSalary from cte
where grader = 2;


SELECT IFNULL(
	(SELECT DISTINCT Salary 
	from Employee
	order by Salary DESC
	limit 1 offset 1),
	null
) AS SecondHighestSalary;