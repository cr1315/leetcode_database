create database `LC0196`;
use LC0196;

Create table If Not Exists Person (Id int, Email varchar(255));
Truncate table Person;
insert into Person (Id, Email) values ('1', 'john@example.com');
insert into Person (Id, Email) values ('2', 'bob@example.com');
insert into Person (Id, Email) values ('3', 'john@example.com');


delete from Person 
where Id not in (
	select t.id
	from (
		SELECT
			min(Id) as id
		from
			Person
		group by Email
	) t
);

with cte as (
	SELECT
		*,
		ROW_NUMBER() over(partition by Email order by id) dups
	from 
		Person
)
delete from Person
where id in (
	SELECT id
	from cte
	where dups > 1
);


