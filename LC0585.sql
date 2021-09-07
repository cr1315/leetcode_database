create database `LC0585`;
use LC0585;

CREATE TABLE IF NOT EXISTS insurance (PID INTEGER(11), TIV_2015 NUMERIC(15,2), TIV_2016 NUMERIC(15,2), LAT NUMERIC(5,2), LON NUMERIC(5,2) );
Truncate table insurance;
insert into insurance (PID, TIV_2015, TIV_2016, LAT, LON) values ('1', '10', '5', '10', '10');
insert into insurance (PID, TIV_2015, TIV_2016, LAT, LON) values ('2', '20', '20', '20', '20');
insert into insurance (PID, TIV_2015, TIV_2016, LAT, LON) values ('3', '10', '30', '20', '20');
insert into insurance (PID, TIV_2015, TIV_2016, LAT, LON) values ('4', '10', '40', '40', '40');


SELECT
	SUM(i.TIV_2016) as TIV_2016
from
	insurance as i
where
	i.TIV_2015 in (
		SELECT
			TIV_2015
		from
			insurance
		group by TIV_2015
		having count(*) > 1
	)
	and concat(i.LAT, i.LON) in (
		SELECT
			concat(LAT, LON)
		from
			insurance
		group by LAT, LON
		having count(*) = 1
	)
;
