# Домашнее задание по шестому уроку курса "Базы данных" от 6 мая 2020г.

-- Task #1
-- Пусть задан некоторый пользователь. Из всех друзей этого пользователя 
-- найдите человека, который больше всех общался с нашим пользователем.
-- Возьмём пользователя с ID = 1.
SELECT * FROM `vk`.`friend_requests`
	WHERE `status` = 'approved' AND `initiator_user_id` = 1;
-- Как видно из запроса выше, у него два друга, ID = 3 и ID = 10
INSERT INTO `vk`.`messages` (`from_user_id`, `to_user_id`, `body`, `created_at`) VALUES
	(10,1,'Text 1', NOW() - INTERVAL 3 DAY),
    (10,1,'Text 2', NOW() - INTERVAL 2 DAY),
    (10,1,'Text 3', NOW() - INTERVAL 1 DAY);
SELECT * FROM `vk`.`messages`
	WHERE `to_user_id` = 1 AND (`from_user_id` = 3 OR `from_user_id` = 10);
-- Из этого запроса выше мы видим, что больше всех из его друзей ему писал друг с ID = 10
-- Нужен запрос, который выведет пользователя с ID = 10
SELECT `from_user_id` AS `От кого (ID):`, COUNT(*) AS `Количество сообщений`
	FROM `vk`.`messages`
	WHERE 
		`to_user_id` = 1 AND 
        (SELECT `target_user_id` 
			FROM `vk`.`friend_requests` 
            WHERE `status` = 'approved' AND `initiator_user_id` = 1 
			HAVING `target_user_id` = `messages`.`from_user_id`)
    GROUP BY (`from_user_id`)
    ORDER BY `Количество сообщений` DESC
    LIMIT 1;

-- Task #2
-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..
INSERT INTO `vk`.`likes` (`user_id`, `media_id`, `created_at`) VALUES
	(23, 45, NOW()),
    (14, 78, NOW()),
    (64, 84, NOW());

SELECT
	COUNT(*) AS `Суммарное количество лайков`,
	ANY_VALUE((SELECT `user_id`
		FROM `media`
        WHERE `likes`.`media_id` = `media`.`id`)) AS `Owner`,
	(SELECT `birthday` > NOW() - INTERVAL 10 YEAR
		FROM `profiles`
        WHERE `user_id` = `Owner`) `less than 10`
	FROM `vk`.`likes`
    GROUP BY (`less than 10`)
    HAVING `less than 10` = 1;

-- Task #3
-- Определить кто больше поставил лайков (всего): мужчины или женщины.
SELECT COUNT(*) AS `Count of likes`,
	(SELECT `gender` 
		FROM `profiles`
        WHERE `profiles`.`user_id` = `likes`.`user_id`) AS `Gender of the liker`
	FROM `likes`
    GROUP BY `Gender of the liker`
    ORDER BY (`Count of likes`) DESC
    LIMIT 1;
    
-- Третье задание оказалось самое простейшее из всех, хотя казалось бы ...