create database `LC0603`;
use LC0603;


Create table If Not Exists cinema (seat_id int primary key auto_increment, free bool);
Truncate table cinema;;
insert into cinema (seat_id, free) values ('1', '1');
insert into cinema (seat_id, free) values ('2', '0');
insert into cinema (seat_id, free) values ('3', '1');
insert into cinema (seat_id, free) values ('4', '1');
insert into cinema (seat_id, free) values ('5', '1');


SELECT
	seat_id
from (
	SELECT
		seat_id,
		LAG(`free`, 1) over(order by seat_id) as free_lag,
		`free`,
		LEAD(`free`, 1) over(order by seat_id) as free_lead
	from
		cinema
) as tfree
where
	`free` = 1 and free_lag = 1
	or `free` = 1 and free_lead = 1;