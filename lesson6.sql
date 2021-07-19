-- 1. Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).
with sm as
(
select from_user_id, count(body) as count_mes
from messages m
where to_user_id =1
group by from_user_id
)
select concat(u.firstname,' ', u.lastname) as from_user, count_mes
from sm
inner join users u 
on u.id = sm.from_user_id
where count_mes = (select max(count_mes) from sm);

