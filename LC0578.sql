create database `LC0578`;
use LC0578;


Create table If Not Exists survey_log (id int, action varchar(255), question_id int, answer_id int, q_num int, timestamp int);
Truncate table survey_log;
insert into survey_log (id, action, question_id, answer_id, q_num, timestamp) values ('5', 'show', '285', null, '1', '123');
insert into survey_log (id, action, question_id, answer_id, q_num, timestamp) values ('5', 'answer', '285', '124124', '1', '124');
insert into survey_log (id, action, question_id, answer_id, q_num, timestamp) values ('5', 'show', '369', null, '2', '125');
insert into survey_log (id, action, question_id, answer_id, q_num, timestamp) values ('5', 'skip', '369', null, '2', '126');


SELECT
	question_id as survey_log
from
	survey_log
group by question_id
order by sum(action = 'answer') / sum(action = 'show') desc
limit 1