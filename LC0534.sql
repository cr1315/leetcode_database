create database `LC0534`;
use LC0534;


Create table If Not Exists Activity (player_id int, device_id int, event_date date, games_played int);
Truncate table Activity;
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-03-01', '5');
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-05-02', '6');
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '3', '2017-06-25', '1');
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '1', '2016-03-02', '0');
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '4', '2018-07-03', '5');


select
	player_id,
	event_date,
	sum(games_played) over(partition by player_id order by event_date rows unbounded preceding) as games_played_so_far
from
	Activity as a;
	

select
	player_id,
	event_date,
	sum(games_played) over(partition by player_id order by event_date) as games_played_so_far
from
	Activity as a;