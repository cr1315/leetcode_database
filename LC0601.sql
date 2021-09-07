create database `LC0601`;
use LC0601;


Create table If Not Exists stadium (id int, visit_date DATE NULL, people int);
Truncate table stadium;
insert into stadium (id, visit_date, people) values ('1', '2017-01-01', '10');
insert into stadium (id, visit_date, people) values ('2', '2017-01-02', '109');
insert into stadium (id, visit_date, people) values ('3', '2017-01-03', '150');
insert into stadium (id, visit_date, people) values ('4', '2017-01-04', '99');
insert into stadium (id, visit_date, people) values ('5', '2017-01-05', '145');
insert into stadium (id, visit_date, people) values ('6', '2017-01-06', '1455');
insert into stadium (id, visit_date, people) values ('7', '2017-01-07', '199');
insert into stadium (id, visit_date, people) values ('8', '2017-01-09', '188');


with cte as (
	SELECT
		id, visit_date, people,
		id - ROW_NUMBER() over(order by id) as grp
	from
		stadium as s
	where people >= 100
)
SELECT
	id, visit_date, people
FROM
	cte
where grp in (
	select grp
	from cte
	group by grp
	having count(*) >= 3
);
