create database `LC1285`;
use LC1285;

Create table If Not Exists Logs (log_id int);
Truncate table Logs;
insert into Logs (log_id) values ('1');
insert into Logs (log_id) values ('2');
insert into Logs (log_id) values ('3');
insert into Logs (log_id) values ('7');
insert into Logs (log_id) values ('8');
insert into Logs (log_id) values ('10');



select
	min(log_id) as start_id,
	max(log_id) as end_id
from (
	select
		log_id,
		log_id - row_number() over(order by log_id) as rn
	from
		Logs
) as t1
group by rn