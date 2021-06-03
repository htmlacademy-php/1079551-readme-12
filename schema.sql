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
  `registration_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `email` VARCHAR(255) NOT NULL,
  `username` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `avatar_url` VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1079551-readme-12`.`posts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1079551-readme-12`.`posts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `public_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `heading` VARCHAR(255) NOT NULL DEFAULT '',
  `content` MEDIUMTEXT NOT NULL DEFAULT '',
  `picture` VARCHAR(2000) NOT NULL DEFAULT '',
  `video` VARCHAR(2000) NOT NULL DEFAULT '',
  `link` VARCHAR(2000) NOT NULL DEFAULT '',
  `number_of_views` INT NULL DEFAULT 0,
  `user_id` INT NOT NULL,
  `content_type_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_posts_users_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_posts_content_type1_idx` (`content_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_posts_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `1079551-readme-12`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_posts_content_type1`
    FOREIGN KEY (`content_type_id`)
    REFERENCES `1079551-readme-12`.`content_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1079551-readme-12`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1079551-readme-12`.`comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `public_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` MEDIUMTEXT NOT NULL,
  `user_id` INT NOT NULL,
  `post_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comments_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_comments_posts1_idx` (`post_id` ASC) VISIBLE,
  CONSTRAINT `fk_comments_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `1079551-readme-12`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_posts1`
    FOREIGN KEY (`post_id`)
    REFERENCES `1079551-readme-12`.`posts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1079551-readme-12`.`post_likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1079551-readme-12`.`post_likes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `post_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_posts_like_posts1_idx` (`post_id` ASC) VISIBLE,
  INDEX `fk_posts_like_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_posts_like_posts1`
    FOREIGN KEY (`post_id`)
    REFERENCES `1079551-readme-12`.`posts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_posts_like_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `1079551-readme-12`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1079551-readme-12`.`subscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1079551-readme-12`.`subscriptions` (
  `id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `subscription_user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_subscriptions_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_subscriptions_users2_idx` (`subscription_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_subscriptions_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `1079551-readme-12`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscriptions_users2`
    FOREIGN KEY (`subscription_user_id`)
    REFERENCES `1079551-readme-12`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1079551-readme-12`.`messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1079551-readme-12`.`messages` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `public_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` MEDIUMTEXT NOT NULL,
  `sender_user_id` INT NOT NULL,
  `recipient_user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_message_users1_idx` (`sender_user_id` ASC) VISIBLE,
  INDEX `fk_message_users2_idx` (`recipient_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_message_users1`
    FOREIGN KEY (`sender_user_id`)
    REFERENCES `1079551-readme-12`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_users2`
    FOREIGN KEY (`recipient_user_id`)
    REFERENCES `1079551-readme-12`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1079551-readme-12`.`hashtags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1079551-readme-12`.`hashtags` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1079551-readme-12`.`content_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1079551-readme-12`.`content_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `icon_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `1079551-readme-12`.`posts_hashtags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `1079551-readme-12`.`posts_hashtags` (
  `post_id` INT NOT NULL,
  `hashtag_id` INT NOT NULL,
  PRIMARY KEY (`post_id`, `hashtag_id`),
  INDEX `fk_posts_has_hashtag_hashtag1_idx` (`hashtag_id` ASC) VISIBLE,
  INDEX `fk_posts_has_hashtag_posts1_idx` (`post_id` ASC) VISIBLE,
  CONSTRAINT `fk_posts_has_hashtag_posts1`
    FOREIGN KEY (`post_id`)
    REFERENCES `1079551-readme-12`.`posts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_posts_has_hashtag_hashtag1`
    FOREIGN KEY (`hashtag_id`)
    REFERENCES `1079551-readme-12`.`hashtags` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;