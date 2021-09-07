create database `LC0197`;
use LC0197;


Create table If Not Exists Weather (Id int, RecordDate date, Temperature int);
Truncate table Weather;
insert into Weather (Id, RecordDate, Temperature) values ('1', '2015-01-01', '10');
insert into Weather (Id, RecordDate, Temperature) values ('2', '2015-01-02', '25');
insert into Weather (Id, RecordDate, Temperature) values ('3', '2015-01-03', '20');
insert into Weather (Id, RecordDate, Temperature) values ('4', '2015-01-04', '30');

SELECT
	td.id as Id
from
	weather as yd
	inner join weather as td
	on yd.Temperature < td.Temperature
	and DATEDIFF(td.recordDate, yd.recordDate) = 1