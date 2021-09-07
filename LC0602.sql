create database `LC0602`;
use LC0602;


Create table If Not Exists request_accepted ( requester_id INT NOT NULL, accepter_id INT NULL, accept_date DATE NULL);
Truncate table request_accepted;
insert into request_accepted (requester_id, accepter_id, accept_date) values ('1', '2', '2016/06/03');
insert into request_accepted (requester_id, accepter_id, accept_date) values ('1', '3', '2016/06/08');
insert into request_accepted (requester_id, accepter_id, accept_date) values ('2', '3', '2016/06/08');
insert into request_accepted (requester_id, accepter_id, accept_date) values ('3', '4', '2016/06/09');


SELECT
	id, count(*) as num
from (
	SELECT
		requester_id as id
	from
		request_accepted
	union all
	select
		accepter_id as id
	from
		request_accepted
) as tid
group by id
order by count(*) desc
limit 1;