create database `LC1951`;
use LC1951;

Create table If Not Exists Relations (user_id int, follower_id int);
Truncate table Relations;
insert into Relations (user_id, follower_id) values ('1', '3');
insert into Relations (user_id, follower_id) values ('2', '3');
insert into Relations (user_id, follower_id) values ('7', '3');
insert into Relations (user_id, follower_id) values ('1', '4');
insert into Relations (user_id, follower_id) values ('2', '4');
insert into Relations (user_id, follower_id) values ('7', '4');
insert into Relations (user_id, follower_id) values ('1', '5');
insert into Relations (user_id, follower_id) values ('2', '6');
insert into Relations (user_id, follower_id) values ('7', '5');

with cte as (
	SELECT
		r1.user_id as user1_id,
		r2.user_id as user2_id,
		count(*) as cnt
	FROM
		Relations as r1 
		inner join Relations as r2
		on r1.follower_id = r2.follower_id
		and r1.user_id < r2.user_id
	group by 1, 2
)
select
	user1_id, user2_id
from 
	cte
where 
	cnt = (select max(cnt) from cte);