CREATE database `LC0180`;
use LC0180;

Create table If Not Exists Logs (Id int, Num int);
Truncate table Logs;
insert into Logs (Id, Num) values ('1', '1');
insert into Logs (Id, Num) values ('2', '1');
insert into Logs (Id, Num) values ('3', '1');
insert into Logs (Id, Num) values ('4', '2');
insert into Logs (Id, Num) values ('5', '1');
insert into Logs (Id, Num) values ('6', '2');
insert into Logs (Id, Num) values ('7', '2');

SELECT
	DISTINCT T.Num As ConsecutiveNums
from (
	select
		*,
		ROW_NUMBER() over (order by id) rw,
		ROW_NUMBER() over(PARTITION BY num order by id) as rn
	from
		logs
	order by id
) T
group by rw-rn, Num
having count(*) >= 3;

select DISTINCT
	num as ConsecutiveNums
from (
	select 
	id, num,
	lag(num) over(order by id) as `before`,
	lead(num) over(order by id) as `after`
	from logs
) next_prev
where 
	num = `before`
	and num = `after`;
	


