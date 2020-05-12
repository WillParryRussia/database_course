# Lesson 03 Homework: Data Definition Language
# Microblog, 

USE `vk`;

# Это та часть, которая раньще называлась Стена в ВК (а сейчас микроблог), куда пользователь может добавлять записи
DROP TABLES IF EXISTS `microblog`;
CREATE TABLE `microblog` (
	`id` SERIAL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `header` TEXT NULL,
    `attach1` BIGINT UNSIGNED NOT NULL,
    
    PRIMARY KEY (`id`),
    
	FOREIGN KEY (``) REFERENCES ``(``)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION
);

DROP TABLES IF EXISTS ``;
CREATE TABLE `` (
	`` SERIAL,
    
    PRIMARY KEY (``),
    
    INDEX `` (``),
    
	FOREIGN KEY (``) REFERENCES ``(``)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION
);

DROP TABLES IF EXISTS ``;
CREATE TABLE `` (
	`` SERIAL,
    
    PRIMARY KEY (``),
    
    INDEX `` (``),
    
	FOREIGN KEY (``) REFERENCES ``(``)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION
);