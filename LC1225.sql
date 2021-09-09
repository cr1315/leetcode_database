create database `LC1225`;
use LC1225;

Create table If Not Exists Failed (fail_date date);
Create table If Not Exists Succeeded (success_date date);
Truncate table Failed;
insert into Failed (fail_date) values ('2018-12-28');
insert into Failed (fail_date) values ('2018-12-29');
insert into Failed (fail_date) values ('2019-01-04');
insert into Failed (fail_date) values ('2019-01-05');
Truncate table Succeeded;
insert into Succeeded (success_date) values ('2018-12-30');
insert into Succeeded (success_date) values ('2018-12-31');
insert into Succeeded (success_date) values ('2019-01-01');
insert into Succeeded (success_date) values ('2019-01-02');
insert into Succeeded (success_date) values ('2019-01-03');
insert into Succeeded (success_date) values ('2019-01-06');


select
	status as period_state,
	min(dt) as start_date,
	max(dt) as end_date
from (
	select
		*,
		(rank() over(order by dt) - rk) as rk_all
	from (
		select
			fail_date as dt,
			'failed' as status,
			rank() over(order by fail_date) as rk
		from
			Failed
		where
			fail_date between '2019-01-01' and '2019-12-31'
		union all
		select
			success_date dt,
			'succeeded' as status,
			rank() over(order by success_date) as rk
		from
			Succeeded
		where
			success_date between '2019-01-01' and '2019-12-31'
	) as t1
) as t2
group by rk_all, status
order by start_date;