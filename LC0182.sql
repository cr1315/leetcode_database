create database `LC0182`;
use LC0182;

Create table If Not Exists Person (Id int, Email varchar(255));
Truncate table Person;
insert into Person (Id, Email) values ('1', 'a@b.com');
insert into Person (Id, Email) values ('2', 'c@d.com');
insert into Person (Id, Email) values ('3', 'a@b.com');


select DISTINCT
	Email
from
	Person
group by Email
having count(*) > 1;