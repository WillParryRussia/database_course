# Lesson 03 Homework: Data Definition Language
USE `vk`;

# Всё-таки я переделаю таблицу media, как домашнее задание

# MEDIAFILES_TYPES
DROP TABLE IF EXISTS `mediafiles_types`;
CREATE TABLE `mediafiles_types` (
	`id` SERIAL,
    `name` VARCHAR(255) NOT NULL,
    
    PRIMARY KEY (`id`)
);
# MEDIAFILES
DROP TABLE IF EXISTS `mediafiles`;
CREATE TABLE `mediafiles`(
	`id` SERIAL,
    `mediafile_type_id` BIGINT UNSIGNED NOT NULL,
    `filename` VARCHAR(255) NOT NULL,
    `size` INT NOT NULL,
    `metadata` JSON NOT NULL,
    
    PRIMARY KEY (`id`),
    FOREIGN KEY (`mediafile_type_id`) REFERENCES `mediafiles_types`(`id`)
);

# ALBUMS_TYPES
DROP TABLE IF EXISTS `albums_types`;
CREATE TABLE `albums_types` (
	`id` SERIAL,
    `name` VARCHAR(255) NOT NULL,
    
    PRIMARY KEY (`id`)
);
# MEDIA_ALBUMS
DROP TABLE IF EXISTS `media_albums`;
CREATE TABLE `media_albums` (
	`id` SERIAL,
    `name` VARCHAR(255),
    `user_id` BIGINT UNSIGNED NOT NULL,
    `album_type_id` BIGINT UNSIGNED NOT NULL,
    
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`album_type_id`) REFERENCES `albums_types`(`id`)
);
# MEDIAFILE_HOLDER
DROP TABLE IF EXISTS `mediafile_holder`;
CREATE TABLE `mediafile_holder` (
	`mediafile_id` BIGINT UNSIGNED NOT NULL,
    `holder_id` BIGINT UNSIGNED NOT NULL,
	`album_id` BIGINT UNSIGNED NULL,
    
    PRIMARY KEY(`mediafile_id`, `holder_id`),
    FOREIGN KEY (`mediafile_id`) REFERENCES `mediafiles`(`id`),
    FOREIGN KEY (`holder_id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`album_id`) REFERENCES `media_albums`(`id`)
);
# MEDIAFILE_LIKER
DROP TABLE IF EXISTS `mediafile_liker`;
CREATE TABLE `mediafile_liker` (
	`mediafile_id` BIGINT UNSIGNED NOT NULL,
    `liker_id` BIGINT UNSIGNED NOT NULL,
    
    PRIMARY KEY (`mediafile_id`, `liker_id`),
    FOREIGN KEY (`mediafile_id`) REFERENCES `mediafiles`(`id`),
    FOREIGN KEY (`liker_id`) REFERENCES `users`(`id`)
);