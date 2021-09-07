create database `LC0571`;
use LC0571;

Create table If Not Exists Numbers (Number int, Frequency int);
Truncate table Numbers;
insert into Numbers (Number, Frequency) values ('0', '7');
insert into Numbers (Number, Frequency) values ('1', '1');
insert into Numbers (Number, Frequency) values ('2', '3');
insert into Numbers (Number, Frequency) values ('3', '1');


SELECT
	avg(n.Number) as median
FROM
	Numbers as n
WHERE
	n.Frequency >= abs(
		(select sum(Frequency) from Numbers where Number <= n.Number) -
		(select sum(Frequency) from Numbers where Number >= n.Number)
	);