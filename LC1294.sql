create database `LC1294`;
use LC1294;

Create table If Not Exists Countries (country_id int, country_name varchar(20));
Create table If Not Exists Weather (country_id int, weather_state int, day date);
Truncate table Countries;
insert into Countries (country_id, country_name) values ('2', 'USA');
insert into Countries (country_id, country_name) values ('3', 'Australia');
insert into Countries (country_id, country_name) values ('7', 'Peru');
insert into Countries (country_id, country_name) values ('5', 'China');
insert into Countries (country_id, country_name) values ('8', 'Morocco');
insert into Countries (country_id, country_name) values ('9', 'Spain');
Truncate table Weather;
insert into Weather (country_id, weather_state, day) values ('2', '15', '2019-11-01');
insert into Weather (country_id, weather_state, day) values ('2', '12', '2019-10-28');
insert into Weather (country_id, weather_state, day) values ('2', '12', '2019-10-27');
insert into Weather (country_id, weather_state, day) values ('3', '-2', '2019-11-10');
insert into Weather (country_id, weather_state, day) values ('3', '0', '2019-11-11');
insert into Weather (country_id, weather_state, day) values ('3', '3', '2019-11-12');
insert into Weather (country_id, weather_state, day) values ('5', '16', '2019-11-07');
insert into Weather (country_id, weather_state, day) values ('5', '18', '2019-11-09');
insert into Weather (country_id, weather_state, day) values ('5', '21', '2019-11-23');
insert into Weather (country_id, weather_state, day) values ('7', '25', '2019-11-28');
insert into Weather (country_id, weather_state, day) values ('7', '22', '2019-12-01');
insert into Weather (country_id, weather_state, day) values ('7', '20', '2019-12-02');
insert into Weather (country_id, weather_state, day) values ('8', '25', '2019-11-05');
insert into Weather (country_id, weather_state, day) values ('8', '27', '2019-11-15');
insert into Weather (country_id, weather_state, day) values ('8', '31', '2019-11-25');
insert into Weather (country_id, weather_state, day) values ('9', '7', '2019-10-23');
insert into Weather (country_id, weather_state, day) values ('9', '3', '2019-12-23');


select
	country_name,
	case 
		when avg(weather_state) <= 15
			then 'Cold'
		when avg(weather_state) >= 25
			then 'Hot'
		else
			'Warm'
	end as weather_type
from
	Weather as w
left outer join Countries as c
	using(country_id)
where
	date_format(w.day, '%Y-%m') = '2019-11'
group by country_name
order by country_name desc
