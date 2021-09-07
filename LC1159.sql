create database `LC1159`;
use LC1159;

Create table If Not Exists Users (user_id int, join_date date, favorite_brand varchar(10));
create table if not exists Orders (order_id int, order_date date, item_id int, buyer_id int, seller_id int);
create table if not exists Items (item_id int, item_brand varchar(10));
Truncate table Users;
insert into Users (user_id, join_date, favorite_brand) values ('1', '2019-01-01', 'Lenovo');
insert into Users (user_id, join_date, favorite_brand) values ('2', '2019-02-09', 'Samsung');
insert into Users (user_id, join_date, favorite_brand) values ('3', '2019-01-19', 'LG');
insert into Users (user_id, join_date, favorite_brand) values ('4', '2019-05-21', 'HP');
Truncate table Orders;
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('1', '2019-08-01', '4', '1', '2');
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('2', '2019-08-02', '2', '1', '3');
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('3', '2019-08-03', '3', '2', '3');
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('4', '2019-08-04', '1', '4', '2');
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('5', '2019-08-04', '1', '3', '4');
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('6', '2019-08-05', '4', '3', '4');
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('7', '2019-08-06', '2', '2', '4');
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('8', '2019-08-04', '2', '3', '1');
Truncate table Items;
insert into Items (item_id, item_brand) values ('1', 'Samsung');
insert into Items (item_id, item_brand) values ('2', 'Lenovo');
insert into Items (item_id, item_brand) values ('3', 'LG');
insert into Items (item_id, item_brand) values ('4', 'HP');


select
	user_id as seller_id,
	if(o_item_id = i_item_id, 'yes', 'no') as 2nd_item_fav_brand
from (
	select
		u.user_id,
		o.item_id as o_item_id,
		i.item_id as i_item_id,
		dense_rank() over(partition by u.user_id order by o.order_date) as drank
	from
		Users as u
		left outer join Orders as o
		on u.user_id = o.seller_id
		left outer join Items as i
		on u.favorite_brand = i.item_brand
) as t1
where 
	drank = 2
	or o_item_id is null;


select
	user_id as seller_id,
	if(i.item_id = t2.item_id, 'yes', 'no') as 2nd_item_fav_brand
from
	Users as u
	left outer join Items as i
	on u.favorite_brand = i.item_brand
	left outer join (
		select
			*
		from (
			select
				seller_id,
				item_id,
				order_date,
				rank() over(partition by seller_id order by order_date) as drank
			from Orders
		) as t1
		where
			drank = 2
	) as t2
	on u.user_id = t2.seller_id;