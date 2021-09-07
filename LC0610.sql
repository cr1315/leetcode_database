create database `LC0610`;
use LC0610;


Create table If Not Exists triangle (x int, y int, z int);
Truncate table triangle;
insert into triangle (x, y, z) values ('13', '15', '30');
insert into triangle (x, y, z) values ('10', '20', '15');


SELECT
	x,
	y,
	z,
	CASE
		when x + y > z and x + z > y and y + z > x
			then 'Yes'
		ELSE
			'No'
	end as triangle
from
	triangle;