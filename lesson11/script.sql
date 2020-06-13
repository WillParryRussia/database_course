-- Домашнее задание по уроку 11 курса "Базы данных"
DROP DATABASE IF EXISTS `less11`;
CREATE DATABASE `less11` DEFAULT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_bin';
-- 1. “Оптимизация запросов”
-- 1.1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах 
-- users, catalogs и products в таблицу logs помещается время и дата создания записи, 
-- название таблицы, идентификатор первичного ключа и содержимое поля name.
USE `less11`;
DROP TABLE IF EXISTS `users`,`catalogs`,`products`,`logs`;
CREATE TABLE `users` (`id` SERIAL PRIMARY KEY,`name`VARCHAR(16));
CREATE TABLE `catalogs` (`id` SERIAL PRIMARY KEY,`name`VARCHAR(16));
CREATE TABLE `products` (`id` SERIAL PRIMARY KEY,`name`VARCHAR(16));
CREATE TABLE `logs`
	(
	`table_name` VARCHAR(16) NOT NULL,
	`data_id` VARCHAR(16) NOT NULL,
    `data_value` VARCHAR(16) NOT NULL,
	`created_at` DATETIME DEFAULT CURRENT_TIMESTAMP()
	)
ENGINE=ARCHIVE;
DELIMITER ||
CREATE TRIGGER `part_1_task_1_users` AFTER INSERT ON `users` FOR EACH ROW
BEGIN
	INSERT INTO `logs` (`table_name`,`data_id`,`data_value`) VALUES ('users', NEW.`id`, NEW.`name`);
END||
CREATE TRIGGER `part_1_task_1_catalogs` AFTER INSERT ON `catalogs` FOR EACH ROW
BEGIN
	INSERT INTO `logs` (`table_name`,`data_id`,`data_value`) VALUES ('catalogs', NEW.`id`, NEW.`name`);
END||
CREATE TRIGGER `part_1_task_1_products` AFTER INSERT ON `products` FOR EACH ROW
BEGIN
	INSERT INTO `logs` (`table_name`,`data_id`,`data_value`) VALUES ('products', NEW.`id`, NEW.`name`);
END||
DELIMITER ;

INSERT INTO `users` (`name`) VALUES ('John'),('Mike'),('Ben');
INSERT INTO `catalogs` (`name`) VALUES ('Fruits'),('Plates'),('Cups');
INSERT INTO `products` (`name`) VALUES ('Orange'),('12 inch plate'),('0.5 liter cup');
SELECT * FROM `logs`;

-- 1.2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.
USE `less11`;
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (`id` SERIAL PRIMARY KEY);
DELIMITER ||
DROP PROCEDURE IF EXISTS `sp_1kk`;
CREATE PROCEDURE `sp_1kk`()
BEGIN
	DECLARE counter BIGINT DEFAULT 1;
	WHILE counter < 1000000 DO
		INSERT INTO `users` VALUES (NULL);
        SET counter = counter + 1;
	END WHILE;
END||

DELIMITER ;
CALL `sp_1kk`;
SELECT COUNT(*) FROM `users`;

-- 2. “NoSQL”
-- 2.1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.


-- 2.2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу 
-- и наоборот, поиск электронного адреса пользователя по его имени.
-- 2.3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.
