# Домашнее задание по седьмому уроку курса "Базы данных" от 06.05.2020
-- Task #1 : Составьте список пользователей users, 
-- которые осуществили хотя бы один заказ orders в интернет магазине.
-- Дамп базы данных для этого таска в файле lesson07/dump_less7_task1.sql
# Вложенный запрос с ключевым словом GROUP BY
SELECT
	(SELECT `id` FROM `users` WHERE `users`.`id` = `client_id`) AS `client_id`
	FROM `orders`
    GROUP BY (`client_id`);
# Вложенный запрос с ключевым словом DISTINCT
SELECT DISTINCT
	(SELECT `id` FROM `users` WHERE `users`.`id` = `client_id`) AS `client_id`
	FROM `orders`;
# Вложенный запрос с ключевым словом EXISTS
SELECT * FROM `users`
	WHERE EXISTS (SELECT * FROM `orders` WHERE `client_id` = `users`.`id`);
################################################################################
-- Task #2 : Выведите список товаров products и разделов catalogs, 
-- который соответствует товару.
-- Дамп базы данных для этого таска в файле lesson07/dump_less7_task2.sql
# Запрос с вложенным SELECT 
SELECT `name`,
	(SELECT `name` FROM `catalogs` WHERE `catalogs`.`id` = `catalog_id`) AS `Catalog`
    FROM `products`;
# Запрос через объединение таблиц JOIN
SELECT `products`.`name`, `catalogs`.`name` AS `Catalog`
	FROM `products`
    RIGHT JOIN `catalogs`
    ON `catalogs`.`id` = `catalog_id`;
################################################################################
-- Task #3 : (по желанию) Пусть имеется таблица рейсов flights (id, from, to) 
-- и таблица городов cities (label, name). Поля from, to и label содержат 
-- английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.
-- Дамп базы данных для этого таска в файле lesson07/dump_less7_task3.sql
SELECT `id` AS `Номер рейса`,
	(SELECT `name` FROM `cities` WHERE `flights`.`from` = `label`) AS `Откуда`,
    (SELECT `name` FROM `cities` WHERE `flights`.`to` = `label`) AS `Куда`
	FROM `flights`;