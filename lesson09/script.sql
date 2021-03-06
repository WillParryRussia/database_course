# Домашнее задание по 9 вебинару курса "Базы данных"
# 1. Транзакции, переменные, представления
-- 1.1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
START TRANSACTION;
	INSERT INTO `sample`.`users` (SELECT * FROM `shop`.`users` WHERE `id` = 1);
COMMIT;

-- 1.2. Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название 
-- каталога name из таблицы catalogs.
CREATE VIEW `Products and catalogs` AS
	SELECT
		`products`.`name` AS `Product name`,
		`catalogs`.`name` AS `Catalog name`
		FROM `products`
		JOIN `catalogs` ON `catalogs`.`id` = `products`.`catalog_id`;

-- 1.3. (по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные записи
-- за август 2018 года '2018-08-01', '2018-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный список дат 
-- за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.
USE `less09`;
DROP TABLE IF EXISTS `part1_task3`;
CREATE TABLE `part1_task3` (`id` SERIAL, `created_at` DATE NOT NULL, PRIMARY KEY(`id`));
INSERT INTO `part1_task3` (`created_at`) VALUES ('2018-08-01'),('2018-08-04'),('2018-08-16'),('2018-08-17');
-- Перелопатил кучу форумов и документацию, не вижу иного выхода кроме как использовать временную таблицу для этой задачи
DROP TABLE IF EXISTS `day_numbers`;
CREATE TEMPORARY TABLE `day_numbers` (`number` INT NOT NULL UNIQUE);
INSERT INTO `day_numbers`
	VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),
			(16),(17),(18),(19),(20),(21),(22),(23),(24),(25),(26),(27),(28),(29),(30);

SELECT
	(DATE('2018-08-01') + INTERVAL `day_numbers`.`number` DAY) AS `August calendar`,
	IF(`created_at` = (DATE('2018-08-01') + INTERVAL `day_numbers`.`number` DAY), 1, 0) AS `Is exists on target table`
	FROM `day_numbers`
	LEFT JOIN `part1_task3`
		ON `created_at` = (DATE('2018-08-01') + INTERVAL `day_numbers`.`number` DAY);

-- 1.4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из таблицы, 
-- оставляя только 5 самых свежих записей.
START TRANSACTION;
	CREATE VIEW `fresh_news` AS SELECT `created_at` FROM `dates` ORDER BY (`created_at`) DESC LIMIT 5;
	SET @target_date = (SELECT `created_at` FROM `fresh_news` ORDER BY (`created_at`) LIMIT 1);
	DELETE FROM `dates` WHERE `created_at` < @target_date;
COMMIT;

# 2. Администрирование MySQL
-- 2.1. Создайте двух пользователей которые имеют доступ к базе данных shop. 
-- Первому пользователю shop_read должны быть доступны 
-- только запросы на чтение данных, второму пользователю shop — любые операции в пределах базы данных shop.
DROP DATABASE IF EXISTS `shop`;
CREATE DATABASE `shop` DEFAULT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_bin';
USE `shop`;
CREATE TABLE `products` (`id` SERIAL, `product_name` VARCHAR(32) NOT NULL, PRIMARY KEY(`id`));

DROP USER IF EXISTS shop_read@localhost;
CREATE USER shop_read@localhost IDENTIFIED WITH sha256_password BY '12345';
GRANT SELECT ON shop.* TO 'shop_read'@'localhost';

DROP USER IF EXISTS shop@localhost;
CREATE USER shop@localhost IDENTIFIED WITH sha256_password BY '12345';
GRANT ALL ON shop.* TO 'shop'@'localhost';

-- 2.2. (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, 
-- содержащие первичный ключ, имя пользователя и его пароль. Создайте представление username таблицы accounts,
-- предоставляющий доступ к столбца id и name. Создайте пользователя user_read, который бы не имел доступа 
-- к таблице accounts, однако, мог бы извлекать записи из представления username.
DROP DATABASE IF EXISTS `part2_task2`;
CREATE DATABASE `part2_task2` DEFAULT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_bin';
USE `part2_task2`;
CREATE TABLE `accounts` (`id` SERIAL, `name` VARCHAR(32) NOT NULL, `password` VARCHAR(256) NOT NULL, PRIMARY KEY(`id`));
CREATE VIEW `username` AS SELECT `id`,`name` FROM `part2_task2`.`accounts`;
DROP USER IF EXISTS 'user_read'@'localhost';
CREATE USER 'user_read'@'localhost' IDENTIFIED WITH sha256_password BY '12345';
GRANT SELECT ON `part2_task2`.`username` TO 'user_read'@'localhost';

# 3. Хранимые процедуры и функции, триггеры
-- 3.1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
DELIMITER |
CREATE FUNCTION `hello` ()
RETURNS TEXT DETERMINISTIC
BEGIN
	DECLARE ch INT(2);
	SET ch = HOUR(CURRENT_TIME());
	RETURN IF(ch >= 0 AND ch < 6, 'Good nignt', IF(ch >= 6 AND ch < 12, 'Good morning', IF(ch >= 12 AND ch < 18, 'Good day', 'Good evening')));
END;
| DELIMITER ;
SELECT hello();

-- 3.2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.
DROP DATABASE IF EXISTS `less09`;
CREATE DATABASE `less09` DEFAULT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_bin';
DROP TABLE IF EXISTS `less09`.`products`;
CREATE TABLE `less09`.`products` (
	`id` SERIAL,
    `name` VARCHAR(32) DEFAULT NULL,
    `description` VARCHAR(256) DEFAULT NULL,
    PRIMARY KEY (`id`)
);
USE `less09`;
DROP TRIGGER IF EXISTS `part3_task2`;
DELIMITER |
CREATE TRIGGER `part3_task2` BEFORE INSERT ON `less09`.`products` FOR EACH ROW BEGIN
	IF (NEW.`name` IS NULL AND NEW.`description` IS NULL)
		THEN
			SIGNAL SQLSTATE '45000';
	END IF;
END |
DELIMITER ;

USE `less09`;
INSERT INTO `products` (`name`,`description`) VALUES ('TV LG 42OL','TV LG 42 inches with OLED display');
INSERT INTO `products` (`description`) VALUES ('TV LG 52 inches with QLED display');
INSERT INTO `products` (`name`) VALUES ('TV LG 60QL');
INSERT INTO `products` () VALUES ();
SELECT * FROM `products`;

-- 3.3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи называется последовательность 
-- в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.
DELIMITER |
DROP FUNCTION IF EXISTS `Fibonacci`|
CREATE FUNCTION `Fibonacci` (`number` INT UNSIGNED)
	RETURNS INT
	NO SQL
BEGIN
	DECLARE `counter`,`fi` INT DEFAULT 1;
	WHILE (`counter` <> `number`) DO
		SET `counter` = `counter` + 1;
		SET `fi` = `fi` + `counter`;
	END WHILE;
	RETURN `fi`;
END|
DELIMITER ;

SELECT `Fibonacci`(10);