create database `LC0626`;
use LC0626;

Create table If Not Exists seat(id int, student varchar(255));
Truncate table seat;
insert into seat (id, student) values ('1', 'Abbot');
insert into seat (id, student) values ('2', 'Doris');
insert into seat (id, student) values ('3', 'Emerson');
insert into seat (id, student) values ('4', 'Green');
insert into seat (id, student) values ('5', 'Jeames');


SELECT
	case 
		when id % 2 = 0
			then id - 1
		when id % 2 = 1 and id < (select count(*) from seat)
			then id + 1
		else
			id
	end as id,
	student
from
	seat as s
order by id;
