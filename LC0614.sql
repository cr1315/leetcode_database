create database `LC0614`;
use LC0614;

Create table If Not Exists follow (followee varchar(255), follower varchar(255));
Truncate table follow;
insert into follow (followee, follower) values ('A', 'B');
insert into follow (followee, follower) values ('B', 'C');
insert into follow (followee, follower) values ('B', 'D');
insert into follow (followee, follower) values ('D', 'E');


SELECT
	followee as follower,
	count(*) as num
from (
	SELECT distinct
		followee,
		follower
	from
		follow
	where
		followee in (
			SELECT distinct
				follower
			FROM
				follow
		)
) as follow_duplicates_removed
group by followee
order by followee;