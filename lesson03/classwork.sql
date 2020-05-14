# Lesson 03 Classwork: Data Definition Language

DROP DATABASE IF EXISTS `vk`;
CREATE DATABASE `vk` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `vk`;

# TABLE `USERS`
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`(
	# 'id' BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
	`id` SERIAL,
	`firstname` VARCHAR(32) NOT NULL COMMENT 'User\'s first name',
	`lastname` VARCHAR(64) NOT NULL COMMENT 'User\'s last name',
	`email` VARCHAR(64) NOT NULL UNIQUE COMMENT 'User\'s email',
    `password_hash` VARCHAR(128),
    `phone` BIGINT UNSIGNED UNIQUE,
    
    PRIMARY KEY (`id`),
    # Индексы добавляем вручную в тех таблицах, где поиск нужен чаще чем чтение и запись!
    INDEX users_lname_fname_idx (`lastname`, `firstname`)
);
# Relation as 1 to 1
# TABLE `PROFILES`
DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles`(
	`user_id` SERIAL,
    `gender` CHAR(1),
    `birthday` DATE,
    `photo_id` BIGINT UNSIGNED NULL,
    `hometown` VARCHAR(128),
    `created_at` DATETIME DEFAULT NOW(),
    
    PRIMARY KEY (`user_id`),
	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) 
		ON UPDATE NO ACTION 
        ON DELETE RESTRICT
);
# Relation as 1 to M
# TABLE `MESSAGES`
DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages`(
	`id` SERIAL,
    `from_user_id` BIGINT UNSIGNED NOT NULL,
    `to_user_id` BIGINT UNSIGNED NOT NULL,
    `body` TEXT NOT NULL,
    `created_at` DATETIME DEFAULT NOW(),

	PRIMARY KEY (`id`),
	FOREIGN KEY (`from_user_id`) REFERENCES `users`(`id`) 
		ON UPDATE NO ACTION 
        ON DELETE NO ACTION,
	FOREIGN KEY (`to_user_id`) REFERENCES `users`(`id`) 
		ON UPDATE NO ACTION 
        ON DELETE NO ACTION
);
# TABLE `FRIENDS_REQUESTS`
DROP TABLE IF EXISTS `friends_requests`;
CREATE TABLE `friends_requests` (
	`initiator_user_id` BIGINT UNSIGNED NOT NULL,
    `target_user_id` BIGINT UNSIGNED NOT NULL,
    `status` ENUM('requested', 'approved', 'declained', 'infriended'),
    `requested_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME ON UPDATE CURRENT_TIMESTAMP,
    
    PRIMARY KEY (`initiator_user_id`,`target_user_id`),
    
	FOREIGN KEY (`initiator_user_id`) REFERENCES `users`(`id`)
		ON UPDATE NO ACTION
           ON DELETE NO ACTION,
	FOREIGN KEY (`target_user_id`) REFERENCES `users`(`id`)
		ON UPDATE NO ACTION
           ON DELETE NO ACTION
);
# TABLE `COMMUNITIES`
DROP TABLE IF EXISTS `communities`;
CREATE TABLE `communities` (
	`id` SERIAL,
    `community_name` VARCHAR(200) UNIQUE NOT NULL,
    `admin_user_id` BIGINT UNSIGNED NOT NULL,
    
    PRIMARY KEY (`id`),
    INDEX (`community_name`),
	FOREIGN KEY (`admin_user_id`) REFERENCES `users`(`id`)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION
);
# Relation M to M
# TABLE `USERS_COMMUNITIES`
DROP TABLE IF EXISTS `users_communities`;
CREATE TABLE `users_communities` (
	`user_id` BIGINT UNSIGNED NOT NULL,
    `community_id` BIGINT UNSIGNED NOT NULL,
    
    PRIMARY KEY (`user_id`, `community_id`),
    
	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION,
            
	FOREIGN KEY (`community_id`) REFERENCES `communities`(`id`)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION
);