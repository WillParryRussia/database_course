CREATE SCHEMA `example` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `example`;
CREATE TABLE `users` (
	`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`name` VARCHAR(45) NOT NULL
);
INSERT INTO `users` (`name`) VALUES ('Leo'),('Mike'),('Donni'),('Raf'),('April O\'Neil');