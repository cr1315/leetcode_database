create database LC1112;
use LC1112;

Create table If Not Exists Enrollments (student_id int, course_id int, grade int);
Truncate table Enrollments;
insert into Enrollments (student_id, course_id, grade) values ('2', '2', '95');
insert into Enrollments (student_id, course_id, grade) values ('2', '3', '95');
insert into Enrollments (student_id, course_id, grade) values ('1', '1', '90');
insert into Enrollments (student_id, course_id, grade) values ('1', '2', '99');
insert into Enrollments (student_id, course_id, grade) values ('3', '1', '80');
insert into Enrollments (student_id, course_id, grade) values ('3', '2', '75');
insert into Enrollments (student_id, course_id, grade) values ('3', '3', '82');

with max_grade as (
	select
		student_id,
		max(grade) as max_grade
	from
		Enrollments as e
	group by
		student_id
)
select
	student_id,
	(
		select
			min(course_id)
		from
			Enrollments
		where
			(student_id, grade) = (m.student_id, m.max_grade)
	) as course_id,
	max_grade as grade
from max_grade as m
order by student_id;


select
	student_id,
	course_id,
	grade
from (
	select
		*,
		dense_rank() over(partition by student_id order by grade desc, course_id asc) as dr
	from
		Enrollments
) as edr
where dr = 1;