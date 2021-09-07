create database `LC1126`;
use LC1126;

Create table If Not Exists Events (business_id int, event_type varchar(10), occurences int);
Truncate table Events;
insert into Events (business_id, event_type, occurences) values ('1', 'reviews', '7');
insert into Events (business_id, event_type, occurences) values ('3', 'reviews', '3');
insert into Events (business_id, event_type, occurences) values ('1', 'ads', '11');
insert into Events (business_id, event_type, occurences) values ('2', 'ads', '7');
insert into Events (business_id, event_type, occurences) values ('3', 'ads', '6');
insert into Events (business_id, event_type, occurences) values ('1', 'page views', '3');
insert into Events (business_id, event_type, occurences) values ('2', 'page views', '12');


select
	business_id
from (
	select
		*,
		(occurences > avg(occurences) over(partition by event_type)) as avg_activity
	from
		Events
) avg_events
group by business_id
having sum(avg_activity) > 1;