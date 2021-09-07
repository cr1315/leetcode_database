create database `LC1083`;
use LC1083;

Create table If Not Exists Product (product_id int, product_name varchar(10), unit_price int);
Create table If Not Exists Sales (seller_id int, product_id int, buyer_id int, sale_date date, quantity int, price int);
Truncate table Product;
insert into Product (product_id, product_name, unit_price) values ('1', 'S8', '1000');
insert into Product (product_id, product_name, unit_price) values ('2', 'G4', '800');
insert into Product (product_id, product_name, unit_price) values ('3', 'iPhone', '1400');
Truncate table Sales;
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('1', '1', '1', '2019-01-21', '2', '2000');
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('1', '2', '2', '2019-02-17', '1', '800');
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('2', '1', '3', '2019-06-02', '1', '800');
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('3', '3', '3', '2019-05-13', '2', '2800');

with cte as(
	select
		buyer_id,
		product_name
	from
		Sales as s
		inner join Product as p
		on s.product_id = p.product_id
)
select distinct
	buyer_id
from cte
where
	buyer_id in (
		select buyer_id
		from cte
		where product_name = 'S8'
	)
	and buyer_id not in (
		select buyer_id
		from cte
		where product_name = 'iPhone'
	);
	

select
	buyer_id
from
	Sales as s
	inner join Product as p
	using(product_id)
group by buyer_id
having 
	sum(product_name = 'S8') > 0
	and sum(product_name = 'iPhone') = 0;