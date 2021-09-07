create database `LC1949`;
use LC1949;

Create table If Not Exists Friendship (user1_id int, user2_id int);
Truncate table Friendship;
insert into Friendship (user1_id, user2_id) values ('1', '2');
insert into Friendship (user1_id, user2_id) values ('1', '3');
insert into Friendship (user1_id, user2_id) values ('2', '3');
insert into Friendship (user1_id, user2_id) values ('1', '4');
insert into Friendship (user1_id, user2_id) values ('2', '4');
insert into Friendship (user1_id, user2_id) values ('1', '5');
insert into Friendship (user1_id, user2_id) values ('2', '5');
insert into Friendship (user1_id, user2_id) values ('1', '7');
insert into Friendship (user1_id, user2_id) values ('3', '7');
insert into Friendship (user1_id, user2_id) values ('1', '6');
insert into Friendship (user1_id, user2_id) values ('3', '6');
insert into Friendship (user1_id, user2_id) values ('2', '6');

with cte(me, friend) as (
	SELECT distinct
		user1_id, user2_id
	from
		Friendship
	union
	select distinct
		user2_id, user1_id
	from
		Friendship
)
select
	*
from (
	SELECT
		user1_id,
		user2_id,
		(
			select count(*) from (
				select
					friend
				from
					cte as fi
				where me in (f.user1_id, f.user2_id) 
				group by friend
				having count(*) = 2
			) as cm_user2_id
		) as common_friend
	from
		Friendship as f
) as f_with_cnt
where
	f_with_cnt.common_friend > 2;