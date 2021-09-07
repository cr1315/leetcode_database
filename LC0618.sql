create database `LC0618`;
use LC0618;

Create table If Not Exists student (name varchar(50), continent varchar(7));
Truncate table student;
insert into student (name, continent) values ('Jane', 'America');
insert into student (name, continent) values ('Pascal', 'Europe');
insert into student (name, continent) values ('Xi', 'Asia');
insert into student (name, continent) values ('Jack', 'America');


SELECT
	min(America) as America,
	min(Asia) as Asia,
	min(Europe) as Europe
from (
	SELECT
		t1.num,
		case 
			when continent = 'America'
				then name
			else
				null
		end as America,
		case
			when continent = 'Asia'
				then name
			else
				null
		end as Asia,
		case
			when continent = 'Europe'
				then name
			else
				null
		end as Europe
	from (
		SELECT
			*,
			ROW_NUMBER() over(partition by continent order by name) as num
		from
			student
	) as t1
) as t2
group by num;