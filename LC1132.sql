create database `LC1132`;
use LC1132;

Create table If Not Exists Actions (user_id int, post_id int, action_date date, action ENUM('view', 'like', 'reaction', 'comment', 'report', 'share'), extra varchar(10));
create table if not exists Removals (post_id int, remove_date date);
Truncate table Actions;
insert into Actions (user_id, post_id, action_date, action, extra) values ('1', '1', '2019-07-01', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('1', '1', '2019-07-01', 'like', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('1', '1', '2019-07-01', 'share', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('2', '2', '2019-07-04', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('2', '2', '2019-07-04', 'report', 'spam');
insert into Actions (user_id, post_id, action_date, action, extra) values ('3', '4', '2019-07-04', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('3', '4', '2019-07-04', 'report', 'spam');
insert into Actions (user_id, post_id, action_date, action, extra) values ('4', '3', '2019-07-02', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('4', '3', '2019-07-02', 'report', 'spam');
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '2', '2019-07-03', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '2', '2019-07-03', 'report', 'racism');
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '5', '2019-07-03', 'view', 'None');
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '5', '2019-07-03', 'report', 'racism');
Truncate table Removals;
insert into Removals (post_id, remove_date) values ('2', '2019-07-20');
insert into Removals (post_id, remove_date) values ('3', '2019-07-18');


with duplicated_actions as (
	select distinct
		*
	from
		Actions
),
cte as (
	select 
		count(r.remove_date) as removed,
		count(a.action_date) as posted
	from
		duplicated_actions as a
		left outer join Removals as r
		using(post_id)
	where
		extra = 'spam'
	group by a.action_date
)
select
	round(avg(removed / posted) * 100, 2) as average_daily_percent
from
	cte;
	

select
	round(sum(percent) / count(action_date), 2) as average_daily_percent
from (
	select 
		a.action_date,
		count(distinct r.post_id) / count(distinct a.post_id) * 100 as percent
	from
		actions as a
		left outer join Removals as r
		using(post_id)
	where
		extra = 'spam'
	group by a.action_date
) te;