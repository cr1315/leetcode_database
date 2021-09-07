create database `LC0612`;
use LC0612;

CREATE TABLE If Not Exists point_2d (x INT NOT NULL, y INT NOT NULL);
Truncate table point_2d;
insert into point_2d (x, y) values ('-1', '-1');
insert into point_2d (x, y) values ('0', '0');
insert into point_2d (x, y) values ('-1', '-2');

SELECT
	round(sqrt(min(pow(t1.x - t2.x, 2) + pow(t1.y - t2.y, 2))), 2) as distance
from
	point_2d as t1
	join point_2d as t2
	on (t1.x <= t2.x and t1.y < t2.y)
	or (t1.x <= t2.x and t1.y > t2.y)
	or (t1.x < t2.x and t1.y = t2.y);
	

