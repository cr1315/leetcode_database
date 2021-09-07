create database `LC1069`;
use LC1069;

Create table Sales (sale_id int, product_id int, year int, quantity int, price int);
Create table Product (product_id int, product_name varchar(10));
Truncate table Sales;
insert into Sales (sale_id, product_id, year, quantity, price) values ('1', '100', '2008', '10', '5000');
insert into Sales (sale_id, product_id, year, quantity, price) values ('2', '100', '2009', '12', '5000');
insert into Sales (sale_id, product_id, year, quantity, price) values ('7', '200', '2011', '15', '9000');
Truncate table Product;
insert into Product (product_id, product_name) values ('100', 'Nokia');
insert into Product (product_id, product_name) values ('200', 'Apple');
insert into Product (product_id, product_name) values ('300', 'Samsung');


select
	s.product_id as product_id,
	sum(quantity) as total_quantity
from
	Sales as s
	inner join Product as p
	on s.product_id = p.product_id
group by s.product_id;


select
	product_id,
	sum(quantity) as total_quantity
from
	Sales as s
group by product_id;