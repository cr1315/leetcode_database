create database `LC1264`;
use LC1264;

Create table If Not Exists Friendship (user1_id int, user2_id int);
Create table If Not Exists Likes (user_id int, page_id int);
Truncate table Friendship;
insert into Friendship (user1_id, user2_id) values ('1', '2');
insert into Friendship (user1_id, user2_id) values ('1', '3');
insert into Friendship (user1_id, user2_id) values ('1', '4');
insert into Friendship (user1_id, user2_id) values ('2', '3');
insert into Friendship (user1_id, user2_id) values ('2', '4');
insert into Friendship (user1_id, user2_id) values ('2', '5');
insert into Friendship (user1_id, user2_id) values ('6', '1');
Truncate table Likes;
insert into Likes (user_id, page_id) values ('1', '88');
insert into Likes (user_id, page_id) values ('2', '23');
insert into Likes (user_id, page_id) values ('3', '24');
insert into Likes (user_id, page_id) values ('4', '56');
insert into Likes (user_id, page_id) values ('5', '11');
insert into Likes (user_id, page_id) values ('6', '33');
insert into Likes (user_id, page_id) values ('2', '77');
insert into Likes (user_id, page_id) values ('3', '77');
insert into Likes (user_id, page_id) values ('6', '88');



select distinct
	page_id as recommended_page
from
	Likes
where
	user_id in (
		select
			user2_id
		from
			Friendship
		where 
			user1_id = 1
		union all
		select
			user1_id
		from
			Friendship
		where
			user2_id = 1
	)
	and page_id not in (
		select
			page_id
		from
			Likes
		where 
			user_id = 1
	)