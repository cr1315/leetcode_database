create database `LC1127`;
use LC1127;

Create table If Not Exists Spending (user_id int, spend_date date, platform ENUM('desktop', 'mobile'), amount int);
Truncate table Spending;
insert into Spending (user_id, spend_date, platform, amount) values ('1', '2019-07-01', 'mobile', '100');
insert into Spending (user_id, spend_date, platform, amount) values ('1', '2019-07-01', 'desktop', '100');
insert into Spending (user_id, spend_date, platform, amount) values ('2', '2019-07-01', 'mobile', '100');
insert into Spending (user_id, spend_date, platform, amount) values ('2', '2019-07-02', 'mobile', '100');
insert into Spending (user_id, spend_date, platform, amount) values ('3', '2019-07-01', 'desktop', '100');
insert into Spending (user_id, spend_date, platform, amount) values ('3', '2019-07-02', 'desktop', '100');


select
	*,
	sum(amount) over(partition by spend_date, user_id) as samount,
	dense_rank() over(partition by spend_date, user_id order by platform asc) as drank
from
	Spending as s;


select
	spend_date,
	if (count(*) > 1, 'both', min(platform)) as 'platform',
	sum(amount) as total_amount
from
	Spending as s
group by spend_date, user_id
order by spend_date;

with spred_date_with_platform as (
	select distinct
		spend_date,
		derived_platform.platform
	from
		Spending
	cross join (
		select
			'desktop' as platform
		union
		select
			'mobile'
		union
		select
			'both'
	) derived_platform
), final_amount as (
	select
		spend_date,
		if (count(*) > 1, 'both', min(platform)) as 'platform',
		sum(amount) as total_amount
	from
		Spending as s
	group by spend_date, user_id
	order by spend_date
)
select
	spend_date,
	platform,
	sum(ifnull(total_amount, 0)) as total_amount,
	count(total_amount) as total_users
from
	spred_date_with_platform as sdwp
	left outer join final_amount as fa
	using(spend_date, platform)
group by spend_date, platform