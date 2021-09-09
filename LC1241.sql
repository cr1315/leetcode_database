create database `LC1241`;
use LC1241;

Create table If Not Exists Submissions (sub_id int, parent_id int);
Truncate table Submissions;
insert into Submissions (sub_id, parent_id) values ('1', null);
insert into Submissions (sub_id, parent_id) values ('2', null);
insert into Submissions (sub_id, parent_id) values ('1', null);
insert into Submissions (sub_id, parent_id) values ('12', null);
insert into Submissions (sub_id, parent_id) values ('3', '1');
insert into Submissions (sub_id, parent_id) values ('5', '2');
insert into Submissions (sub_id, parent_id) values ('3', '1');
insert into Submissions (sub_id, parent_id) values ('4', '1');
insert into Submissions (sub_id, parent_id) values ('9', '1');
insert into Submissions (sub_id, parent_id) values ('10', '2');
insert into Submissions (sub_id, parent_id) values ('6', '7');

select
	sub_id as post_id,
	ifnull(number_of_comments, 0) as number_of_comments
from (
	select distinct
		sub_id
	from 
		Submissions
	where
		parent_id is null
) as posts
left outer join (
	select
		parent_id as post_id,
		count(distinct sub_id) as number_of_comments
	from
		Submissions
	group by parent_id
) as comments
	on posts.sub_id = comments.post_id