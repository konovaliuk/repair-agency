-- MySQL Script generated by MySQL Workbench
-- Sun Dec 24 21:24:09 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema repair_agency
-- -----------------------------------------------------
-- #3 Repair Agency System - by Anastasiia Hryhorieva

-- -----------------------------------------------------
-- Schema repair_agency
--
-- #3 Repair Agency System - by Anastasiia Hryhorieva
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `repair_agency` ;
USE `repair_agency` ;

-- -----------------------------------------------------
-- Table `repair_agency`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `repair_agency`.`users` ;

CREATE TABLE IF NOT EXISTS `repair_agency`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `user_login` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `user_password` VARCHAR(60) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `user_f_name` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `user_m_name` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL,
  `user_l_name` VARCHAR(75) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `user_email` VARCHAR(75) NOT NULL,
  `user_phone` VARCHAR(45) NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_login_UNIQUE` (`user_login` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `repair_agency`.`applications`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `repair_agency`.`applications` ;

CREATE TABLE IF NOT EXISTS `repair_agency`.`applications` (
  `application_id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(75) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `product_comment` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL,
  `date_added` TIMESTAMP NOT NULL,
  `application_status` VARCHAR(30) NOT NULL DEFAULT 'waiting',
  `application_comment` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL,
  `date_processed` TIMESTAMP NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`application_id`),
  INDEX `fk_applications_users_idx` (`user_id` ASC),
  CONSTRAINT `fk_applications_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `repair_agency`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `repair_agency`.`accepted_applications`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `repair_agency`.`accepted_applications` ;

CREATE TABLE IF NOT EXISTS `repair_agency`.`accepted_applications` (
  `aa_id` INT NOT NULL AUTO_INCREMENT,
  `aa_product_name` VARCHAR(75) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `aa_product_comment` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `aa_price` DECIMAL NOT NULL,
  `aa_status` VARCHAR(35) NOT NULL DEFAULT 'waiting',
  `date_completed` TIMESTAMP NULL,
  `application_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`aa_id`),
  INDEX `fk_accepted_applications_applications1_idx` (`application_id` ASC),
  INDEX `fk_accepted_applications_users1_idx` (`user_id` ASC),
  CONSTRAINT `fk_accepted_applications_applications1`
    FOREIGN KEY (`application_id`)
    REFERENCES `repair_agency`.`applications` (`application_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_accepted_applications_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `repair_agency`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `repair_agency`.`comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `repair_agency`.`comments` ;

CREATE TABLE IF NOT EXISTS `repair_agency`.`comments` (
  `comment_id` INT NOT NULL AUTO_INCREMENT,
  `comment_text` VARCHAR(500) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `date_created` TIMESTAMP NOT NULL,
  `date_edited` TIMESTAMP NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`comment_id`),
  INDEX `fk_comments_users1_idx` (`user_id` ASC),
  CONSTRAINT `fk_comments_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `repair_agency`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `repair_agency`.`user_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `repair_agency`.`user_types` ;

CREATE TABLE IF NOT EXISTS `repair_agency`.`user_types` (
  `utype_id` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`utype_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `repair_agency`.`users_and_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `repair_agency`.`users_and_types` ;

CREATE TABLE IF NOT EXISTS `repair_agency`.`users_and_types` (
  `utype_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`utype_id`, `user_id`),
  INDEX `fk_user_types_has_users_users1_idx` (`user_id` ASC),
  INDEX `fk_user_types_has_users_user_types1_idx` (`utype_id` ASC),
  CONSTRAINT `fk_user_types_has_users_user_types1`
    FOREIGN KEY (`utype_id`)
    REFERENCES `repair_agency`.`user_types` (`utype_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_types_has_users_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `repair_agency`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;