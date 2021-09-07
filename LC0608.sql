create database `LC0608`;
use LC0608;

Create table If Not Exists tree (id int, p_id int);
Truncate table tree;
insert into tree (id, p_id) values ('1', null);
insert into tree (id, p_id) values ('2', '1');
insert into tree (id, p_id) values ('3', '1');
insert into tree (id, p_id) values ('4', '2');
insert into tree (id, p_id) values ('5', '2');


with pids as (
	SELECT DISTINCT
		p_id as pid
	from
		tree
)
select
	id,
	case
		when p_id is null
			then 'Root'
		when id in (select pid from pids)
			then 'Inner'
		else
			'Leaf'
	end as Type
from
	tree
order by id;
	
