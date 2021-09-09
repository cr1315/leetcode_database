create database `LC1212`;
use LC1212;

Create table If Not Exists Teams (team_id int, team_name varchar(30));
Create table If Not Exists Matches (match_id int, host_team int, guest_team int, host_goals int, guest_goals int);
Truncate table Teams;
insert into Teams (team_id, team_name) values ('10', 'Leetcode FC');
insert into Teams (team_id, team_name) values ('20', 'NewYork FC');
insert into Teams (team_id, team_name) values ('30', 'Atlanta FC');
insert into Teams (team_id, team_name) values ('40', 'Chicago FC');
insert into Teams (team_id, team_name) values ('50', 'Toronto FC');
Truncate table Matches;
insert into Matches (match_id, host_team, guest_team, host_goals, guest_goals) values ('1', '10', '20', '3', '0');
insert into Matches (match_id, host_team, guest_team, host_goals, guest_goals) values ('2', '30', '10', '2', '2');
insert into Matches (match_id, host_team, guest_team, host_goals, guest_goals) values ('3', '10', '50', '5', '1');
insert into Matches (match_id, host_team, guest_team, host_goals, guest_goals) values ('4', '20', '30', '1', '0');
insert into Matches (match_id, host_team, guest_team, host_goals, guest_goals) values ('5', '50', '30', '1', '0');


select
	team_id,
	team_name,
	sum(if(team_id = host_team and host_goals > guest_goals, 3, 0)) + 
	sum(if(team_id = guest_team and host_goals < guest_goals, 3, 0)) + 
	sum(if(team_id = host_team and host_goals = guest_goals, 1, 0)) + 
	sum(if(team_id = guest_team and host_goals = guest_goals, 1, 0)) as num_points 
from
	Teams as t
left outer join	Matches as m
	on t.team_id = m.host_team
	or t.team_id = m.guest_team
group by team_id, team_name
order by num_points desc, team_id asc