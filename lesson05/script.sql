# Практические задания по теме “Операторы, фильтрация, сортировка и ограничение”
-- TASK #1.1 
#	Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
#	Заполните их текущими датой и временем.
UPDATE `users` SET 
	`created_at` = CURRENT_TIMESTAMP(), 
    `updated_at` = CURRENT_TIMESTAMP();

-- TASK #1.2
#	Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы 
#	типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". 
#	Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
UPDATE `users` 
	SET `created_at` = DATE_FORMAT(STR_TO_DATE(`created_at`, '%d.%m.%Y %H:%i'), '%Y-%m-%d %H:%i');
UPDATE `users`
    SET `updated_at` = DATE_FORMAT(STR_TO_DATE(`updated_at`, '%d.%m.%Y %H:%i'), '%Y-%m-%d %H:%i');

ALTER TABLE `users`
	MODIFY COLUMN `created_at` DATETIME NOT NULL, 
    MODIFY COLUMN `updated_at` DATETIME NOT NULL;

-- TASK #1.3
#	В таблице складских запасов storehouses_products в поле value могут встречаться самые разные 
#	цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать
#	записи таким образом, чтобы они выводились в порядке увеличения значения value. 
#	Однако, нулевые запасы должны выводиться в конце, после всех записей.
SELECT * FROM `storehouses_products` ORDER BY `value` = 0, `value` ASC; 

-- TASK #1.4 (по желанию)
#	Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
#	Месяцы заданы в виде списка английских названий ('may', 'august')
SELECT 
	user_id,
	MONTHNAME(`birthday`) AS `month`
    FROM `users`
    WHERE
		MONTHNAME(`birthday`) = 'August' OR
        MONTHNAME(`birthday`) = 'May';

-- TASK #1.5 (по желанию)
#	Из таблицы catalogs извлекаются записи при помощи запроса SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
#	Отсортируйте записи в порядке, заданном в списке IN.
SELECT * FROM `catalogs` WHERE id IN (5, 1, 2) ORDER BY `id` = 5 DESC, `id`;

# Практические задания теме “Агрегация данных”
-- TASK #2.1 (по желанию)
#	Подсчитайте средний возраст пользователей в таблице users
SELECT 
	ROUND(SUM(FLOOR((TO_DAYS(NOW()) - TO_DAYS(`birthday`)) / 365.25)) / COUNT(*), 2) AS `AverageAge` 
    FROM `users`;
-- Или с использованием функции AVG
SELECT
	ROUND(AVG(FLOOR((TO_DAYS(NOW()) - TO_DAYS(`birthday`)) / 365.25)), 2) AS `AverageAge` 
    FROM `users`;

-- TASK #2.2
#	Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
#	Следует учесть, что необходимы дни недели текущего года, а не года рождения.
SELECT 
	COUNT(DAYNAME(DATE_FORMAT(`birthday`, '2020-%m-%d'))) AS `Count`, 
    DAYNAME(DATE_FORMAT(`birthday`, '2020-%m-%d')) AS `Weekday` 
	FROM `users` GROUP BY `Weekday`;
-- Или если проще
SELECT
	COUNT(*) AS `Count`,
    DAYNAME(DATE_FORMAT(`birthday`, '2020-%m-%d')) AS `Weekday`
    FROM `users` GROUP BY `Weekday`;

-- TASK #2.3 (по желанию)
#	Подсчитайте произведение чисел в столбце таблицы
-- Логарифм произведения двух числе равен сумме логарифмов этих чисел
-- То-есть LN(x * y) = LN(x) + LN(Y);
-- Следовательно мне нужно вычислить сумму логарифмов таблицы и добавить экспоненту 
-- (пришлось смотреть математические справочники)
SELECT ROUND(EXP(SUM(LN(`value`)))) FROM `number_series`;