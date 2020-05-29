# Домашнее задание по шестому уроку курса "Базы данных" от 6 мая 2020г.

-- Task #1
-- Пусть задан некоторый пользователь (id = 22). Из всех друзей этого пользователя 
-- найдите человека, который больше всех общался с нашим пользователем.
SELECT `from_user_id`, `to_user_id`,
	COUNT(*) AS `Count of messages`,
	(SELECT`status` 
		FROM `vk`.`friend_requests` 
		WHERE `initiator_user_id` = `messages`.`to_user_id` AND `target_user_id` = `messages`.`from_user_id`) AS `friendship_status`
	FROM `vk`.`messages`
    WHERE `to_user_id` = 22
    GROUP BY `from_user_id`
    HAVING `friendship_status` = 'approved'
    LIMIT 1; 

-- Task #2
-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..
# script

-- Task #3
-- Определить кто больше поставил лайков (всего): мужчины или женщины.
