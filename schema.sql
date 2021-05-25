-- -----------------------------------------------------
-- Schema 1079551-readme-12
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `1079551-readme-12` DEFAULT CHARACTER SET utf8 ;
USE `1079551-readme-12` ;

-- -----------------------------------------------------
-- Table `1079551-readme-12`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1079551-readme-12`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dt_create` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `email` VARCHAR(100) NOT NULL,
  `username` VARCHAR(30) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `avatar_url` VARCHAR(50) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1079551-readme-12`.`posts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1079551-readme-12`.`posts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dt_create` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `heading` VARCHAR(45) NULL,
  `content` VARCHAR(255) NULL,
  `picture` VARCHAR(45) NULL,
  `video` VARCHAR(45) NULL,
  `link` VARCHAR(45) NULL,
  `number_of_views` INT NULL DEFAULT 0,
  `author` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_posts_users_idx` (`author` ASC) VISIBLE,
  CONSTRAINT `fk_posts_users`
    FOREIGN KEY (`author`)
    REFERENCES `1079551-readme-12`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1079551-readme-12`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1079551-readme-12`.`comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dt_create` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` VARCHAR(255) NOT NULL,
  `users_id` INT NOT NULL,
  `posts_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comments_users1_idx` (`users_id` ASC) VISIBLE,
  INDEX `fk_comments_posts1_idx` (`posts_id` ASC) VISIBLE,
  CONSTRAINT `fk_comments_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `1079551-readme-12`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_posts1`
    FOREIGN KEY (`posts_id`)
    REFERENCES `1079551-readme-12`.`posts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1079551-readme-12`.`posts_like`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1079551-readme-12`.`posts_like` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `posts_id` INT NOT NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_posts_like_posts1_idx` (`posts_id` ASC) VISIBLE,
  INDEX `fk_posts_like_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_posts_like_posts1`
    FOREIGN KEY (`posts_id`)
    REFERENCES `1079551-readme-12`.`posts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_posts_like_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `1079551-readme-12`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1079551-readme-12`.`subscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1079551-readme-12`.`subscriptions` (
  `id` INT NOT NULL,
  `author` INT NOT NULL,
  `subscription` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_subscriptions_users1_idx` (`author` ASC) VISIBLE,
  INDEX `fk_subscriptions_users2_idx` (`subscription` ASC) VISIBLE,
  CONSTRAINT `fk_subscriptions_users1`
    FOREIGN KEY (`author`)
    REFERENCES `1079551-readme-12`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscriptions_users2`
    FOREIGN KEY (`subscription`)
    REFERENCES `1079551-readme-12`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1079551-readme-12`.`message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1079551-readme-12`.`message` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dt_create` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` VARCHAR(255) NULL,
  `sender` INT NOT NULL,
  `recipient` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_message_users1_idx` (`sender` ASC) VISIBLE,
  INDEX `fk_message_users2_idx` (`recipient` ASC) VISIBLE,
  CONSTRAINT `fk_message_users1`
    FOREIGN KEY (`sender`)
    REFERENCES `1079551-readme-12`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_users2`
    FOREIGN KEY (`recipient`)
    REFERENCES `1079551-readme-12`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1079551-readme-12`.`hashtag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1079551-readme-12`.`hashtag` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1079551-readme-12`.`content_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1079551-readme-12`.`content_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(10) NOT NULL,
  `icon_name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1079551-readme-12`.`posts_has_hashtag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1079551-readme-12`.`posts_has_hashtag` (
  `posts_id` INT NOT NULL,
  `hashtag_id` INT NOT NULL,
  PRIMARY KEY (`posts_id`, `hashtag_id`),
  INDEX `fk_posts_has_hashtag_hashtag1_idx` (`hashtag_id` ASC) VISIBLE,
  INDEX `fk_posts_has_hashtag_posts1_idx` (`posts_id` ASC) VISIBLE,
  CONSTRAINT `fk_posts_has_hashtag_posts1`
    FOREIGN KEY (`posts_id`)
    REFERENCES `1079551-readme-12`.`posts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_posts_has_hashtag_hashtag1`
    FOREIGN KEY (`hashtag_id`)
    REFERENCES `1079551-readme-12`.`hashtag` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;