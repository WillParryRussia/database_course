# Lesson 03 Classwork: Data Definition Language
# ----------------------------------------------------
DROP DATABASE IF EXISTS `vk`;
CREATE DATABASE `vk` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `vk`;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`(
	# 'id' BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
	`id` SERIAL PRIMARY KEY,
	`firstname` VARCHAR(32) NOT NULL COMMENT 'User\'s first name',
	`lastname` VARCHAR(64) NOT NULL COMMENT 'User\'s last name',
	`email` VARCHAR(64) NOT NULL UNIQUE COMMENT 'User\'s email',
    `password_hash` VARCHAR(128),
    `phone` BIGINT UNSIGNED UNIQUE,
    
    INDEX users_lname_fname_idx (`lastname`, `firstname`)
);
# Relation as 1 to 1
DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles`(
	`user_id` SERIAL PRIMARY KEY,
    `gender` CHAR(1),
    `birthday` DATE,
    `photo_id` BIGINT UNSIGNED NULL,
    `hometown` VARCHAR(128),
    `created_at` DATETIME DEFAULT NOW(),
    
    -- Добавить ограничение типа "Внешний ключ", который ссылается на поле id таблицы users
    CONSTRAINT `fk_user_id` 
		FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
			ON UPDATE CASCADE
            ON DELETE RESTRICT
);
# Relation as 1 to M
DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages`(
	`id` SERIAL PRIMARY KEY,
    `from_user_id` BIGINT UNSIGNED NOT NULL,
    `to_user_id` BIGINT UNSIGNED NOT NULL,
    `body` TEXT NOT NULL,
    `created_at` DATETIME DEFAULT NOW(),
    
    CONSTRAINT `fk_from_user_id`
		FOREIGN KEY (`from_user_id`) REFERENCES `users`(`id`)
			ON UPDATE NO ACTION
            ON DELETE NO ACTION,
    CONSTRAINT `fk_to_user_id`
		FOREIGN KEY (`to_user_id`) REFERENCES `users`(`id`)
			ON UPDATE NO ACTION
            ON DELETE NO ACTION
);

-- 54:29
