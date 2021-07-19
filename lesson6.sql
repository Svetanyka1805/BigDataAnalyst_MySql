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

-- 2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..
select count(u.id) as count_users 
     , count(l.user_id) as count_likes
from users u 
inner join profiles p 
on p.user_id =u.id 
inner join likes l
on l.user_id = u.id
where timestampdiff(year ,p.birthday,now())<=10;


-- 3. Определить кто больше поставил лайков (всего): мужчины или женщины.
with sm as
(
	select p.user_id 
	      ,(select count(l.user_id) from likes l where l.user_id = p.user_id and p.gender='m') as man_count_likes
	      ,(select count(l.user_id) from likes l where l.user_id = p.user_id and p.gender='w') as woman_count_likes
	from profiles p
)
select sum(man_count_likes) as man_count_likes, sum(woman_count_likes) as woman_count_likes 
from sm;
