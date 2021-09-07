create database `LA0619`;
use LA0619;

Create table If Not Exists my_numbers (num int);
Truncate table my_numbers;
insert into my_numbers (num) values ('8');
insert into my_numbers (num) values ('8');
insert into my_numbers (num) values ('3');
insert into my_numbers (num) values ('3');
insert into my_numbers (num) values ('1');
insert into my_numbers (num) values ('4');
insert into my_numbers (num) values ('5');
insert into my_numbers (num) values ('6');


select 
	max(num) as num
from (
	SELECT
		num
	from
		my_numbers
	group by num
	having count(*) = 1
) as t;
