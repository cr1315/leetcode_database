create database `LC1205`;
use LC1205;

create table if not exists Transactions (id int, country varchar(4), state enum('approved', 'declined'), amount int, trans_date date);
create table if not exists Chargebacks (trans_id int, trans_date date);
Truncate table Transactions;
insert into Transactions (id, country, state, amount, trans_date) values ('101', 'US', 'approved', '1000', '2019-05-18');
insert into Transactions (id, country, state, amount, trans_date) values ('102', 'US', 'declined', '2000', '2019-05-19');
insert into Transactions (id, country, state, amount, trans_date) values ('103', 'US', 'approved', '3000', '2019-06-10');
insert into Transactions (id, country, state, amount, trans_date) values ('104', 'US', 'declined', '4000', '2019-06-13');
insert into Transactions (id, country, state, amount, trans_date) values ('105', 'US', 'approved', '5000', '2019-06-15');
Truncate table Chargebacks;
insert into Chargebacks (trans_id, trans_date) values ('102', '2019-05-29');
insert into Chargebacks (trans_id, trans_date) values ('101', '2019-06-30');
insert into Chargebacks (trans_id, trans_date) values ('105', '2019-09-18');



select
	date_format(trans_date, '%Y-%m') as "month",
	country,
	sum(amount) as amount
from
	Transactions
where
	state = 'approved'
group by 1, 2;

select
	date_format(c.trans_date, '%Y-%m') as "month",
	t.country,
	sum(t.amount) as amount
from
	Chargebacks as c
inner join Transactions as t
	on c.trans_id = t.id
group by 1, 2;

select
	date_format(trans_date, '%Y-%m') as "month",
	country,
	sum(state = 'approved') as approved_count,
	sum(if(state = 'approved', amount, 0)) as approved_amount,
	sum(state = 'chargeback') as chargeback_count,
	sum(if(state = 'chargeback', amount, 0)) as chargeback_amount
from (
	select
		trans_date,
		country,
		state,
		amount
	from
		Transactions
	where
		state = 'approved'
	union all
	select
		c.trans_date,
		t.country,
		'chargeback' as state,
		amount
	from
		Chargebacks as c
	inner join Transactions as t
		on c.trans_id = t.id
) as t1
group by 1, 2
having approved_count + approved_amount + chargeback_count + chargeback_amount <> 0;