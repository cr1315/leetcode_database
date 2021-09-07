create database `LC1097`;
use LC1097;

Create table If Not Exists Activity (player_id int, device_id int, event_date date, games_played int);
Truncate table Activity;
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-03-01', '5');
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-03-02', '6');
insert into Activity (player_id, device_id, event_date, games_played) values ('2', '3', '2017-06-25', '1');
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '1', '2016-03-01', '0');
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '4', '2018-07-03', '5');


with first_activity as (
	select
		player_id,
		min(event_date) as first_login,
		date_add(min(event_date), interval 1 day) as second_login
	from 
	 	Activity as a
	group by player_id
),
second_activity as (
	select
		player_id,
		first_login,
		(
			select count(*) 
			from Activity 
			where 
				player_id = fa.player_id
				and event_date = fa.second_login
		) as second_logged_in 
	from
		first_activity as fa
)		
select
	first_login as install_dt,
	count(*) as installs,
	round(sum(second_logged_in) / count(*), 2) as Day1_retention
from second_activity
group by first_login;