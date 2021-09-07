create database `LC1098`;
use LC1098;


Create table If Not Exists Books (book_id int, name varchar(50), available_from date);
Create table If Not Exists Orders (order_id int, book_id int, quantity int, dispatch_date date);
Truncate table Books;
insert into Books (book_id, name, available_from) values ('1', 'Kalila And Demna', '2010-01-01');
insert into Books (book_id, name, available_from) values ('2', '28 Letters', '2012-05-12');
insert into Books (book_id, name, available_from) values ('3', 'The Hobbit', '2019-06-10');
insert into Books (book_id, name, available_from) values ('4', '13 Reasons Why', '2019-06-01');
insert into Books (book_id, name, available_from) values ('5', 'The Hunger Games', '2008-09-21');
Truncate table Orders;
insert into Orders (order_id, book_id, quantity, dispatch_date) values ('1', '1', '2', '2018-07-26');
insert into Orders (order_id, book_id, quantity, dispatch_date) values ('2', '1', '1', '2018-11-05');
insert into Orders (order_id, book_id, quantity, dispatch_date) values ('3', '3', '8', '2019-06-11');
insert into Orders (order_id, book_id, quantity, dispatch_date) values ('4', '4', '6', '2019-06-05');
insert into Orders (order_id, book_id, quantity, dispatch_date) values ('5', '4', '5', '2019-06-20');
insert into Orders (order_id, book_id, quantity, dispatch_date) values ('6', '5', '9', '2009-02-02');
insert into Orders (order_id, book_id, quantity, dispatch_date) values ('7', '5', '8', '2010-04-13');


with last_year_sales as (
	select
		*
	from
		Orders
	where
		dispatch_date between '2018-06-23' and '2019-06-23'
)
select
	book_id,
	min(name) as name
from
	Books as b
	left outer join last_year_sales as lys
	using(book_id)
where
	available_from < '2019-05-23'
group by book_id
having sum(ifnull(quantity, 0)) < 10;


select
	*
from
	Books as b
where
	available_from < '2019-05-23'
	and (
		select sum(quantity) from Orders
		where
			book_id = b.book_id
			and dispatch_date between '2018-06-23' and '2019-06-23'
	) < 10;
	
select a.book_id,a.name,sum(b.quantity) as total_quantity from
(
    select * from books where available_from < date_sub('2019-06-23', interval 1 month)
) as a
left join
(
    select * from orders where dispatch_date between date_sub('2019-06-23',interval 1 year) and '2019-06-23'
) as b
on a.book_id=b.book_id
group by 1,2
having total_quantity < 10 or total_quantity is null;