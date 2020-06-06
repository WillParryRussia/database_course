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


-- 1.4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из таблицы, 
-- оставляя только 5 самых свежих записей.
START TRANSACTION;
	CREATE VIEW `fresh_news` AS SELECT `created_at` FROM `dates` ORDER BY (`created_at`) DESC LIMIT 5;
	SET @target_date = (SELECT `created_at` FROM `fresh_news` ORDER BY (`created_at`) LIMIT 1);
	DELETE FROM `dates` WHERE `created_at` < @target_date;
COMMIT;

# 2. Администрирование MySQL
-- 2.1. Создайте двух пользователей которые имеют доступ к базе данных shop. Первому пользователю shop_read должны быть доступны 
-- только запросы на чтение данных, второму пользователю shop — любые операции в пределах базы данных shop.


-- 2.2. (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие первичный ключ, 
-- имя пользователя и его пароль. Создайте представление username таблицы accounts, предоставляющий доступ к столбца id и name. 
-- Создайте пользователя user_read, который бы не имел доступа к таблице accounts, однако, мог бы извлекать записи из представления username.


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
USE `test`;
DELIMITER |
CREATE TRIGGER `insert2products`
	BEFORE INSERT ON `products`
	FOR EACH ROW
	BEGIN
		IF NEW.`name` IS NOT NULL AND NEW.`description` IS NOT NULL
		THEN
			INSERT INTO `products` (`name`,`description`) VALUES (NEW.`name`, NEW.`description`);
		END IF;
	END;
| DELIMITER ;


SELECT HOUR(CURTIME());
CREATE DATABASE `test`;
USE `test`;
CREATE TABLE `products` (`id` SERIAL PRIMARY KEY, `name` VARCHAR(32), `description` VARCHAR(32));
USE `test`;
INSERT INTO `products` (`name`,`description`) VALUES ('Item 1', 'Desc of I1');
INSERT INTO `products` (`name`) VALUES ('Item 2');
INSERT INTO `products` (`description`) VALUES ('Desc of I3');
INSERT INTO `products` () VALUES ();
SELECT * FROM `products`;


-- 3.3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи называется последовательность 
-- в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.