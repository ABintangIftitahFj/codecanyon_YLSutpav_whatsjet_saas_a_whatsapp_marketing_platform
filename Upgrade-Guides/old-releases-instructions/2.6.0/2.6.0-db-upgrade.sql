-- MySQL
-- 2.6.0 - Upgrade
-- Model: WhatsJet

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

ALTER TABLE `users` 
CHARACTER SET = utf8mb4 , COLLATE = utf8mb4_unicode_ci ,
CHANGE COLUMN `first_name` `first_name` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL ;

ALTER TABLE `configurations` 
CHARACTER SET = utf8mb4 , COLLATE = utf8mb4_unicode_ci ;

ALTER TABLE `countries` 
CHARACTER SET = utf8mb4 , COLLATE = utf8mb4_unicode_ci ;

ALTER TABLE `user_roles` 
CHARACTER SET = utf8mb4 , COLLATE = utf8mb4_unicode_ci ,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `pages` 
CHARACTER SET = utf8mb4 , COLLATE = utf8mb4_unicode_ci ,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `vendors` 
CHARACTER SET = utf8mb4 , COLLATE = utf8mb4_unicode_ci ,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `vendor_settings` 
CHARACTER SET = utf8mb4 , COLLATE = utf8mb4_unicode_ci ,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `contacts` 
CHARACTER SET = utf8mb4 , COLLATE = utf8mb4_unicode_ci ,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `first_name` `first_name` VARCHAR(150) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NULL DEFAULT NULL ,
CHANGE COLUMN `last_name` `last_name` VARCHAR(150) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NULL DEFAULT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `contact_groups` 
CHARACTER SET = utf8mb4 , COLLATE = utf8mb4_unicode_ci ,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `group_contacts` 
CHARACTER SET = utf8mb4 , COLLATE = utf8mb4_unicode_ci ,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `whatsapp_templates` 
CHARACTER SET = utf8mb4 , COLLATE = utf8mb4_unicode_ci ,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `campaigns` 
CHARACTER SET = utf8mb4 , COLLATE = utf8mb4_unicode_ci ,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `whatsapp_message_logs` 
CHARACTER SET = utf8mb4 , COLLATE = utf8mb4_unicode_ci ,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `message` `message` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NULL DEFAULT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `whatsapp_message_queue` 
CHARACTER SET = utf8mb4 , COLLATE = utf8mb4_unicode_ci ,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `campaign_groups` 
CHARACTER SET = utf8mb4 , COLLATE = utf8mb4_unicode_ci ,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `contact_custom_fields` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `contact_custom_field_values` 
CHARACTER SET = utf8mb4 , COLLATE = utf8mb4_unicode_ci ,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `bot_replies` 
CHARACTER SET = utf8mb4 , COLLATE = utf8mb4_unicode_ci ,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `reply_text` `reply_text` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `contact_users` 
CHARACTER SET = utf8mb4 , COLLATE = utf8mb4_unicode_ci ,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `vendor_users` 
CHARACTER SET = utf8mb4 , COLLATE = utf8mb4_unicode_ci ,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
DROP INDEX `_uid` ;
;

CREATE TABLE IF NOT EXISTS `manual_subscriptions` (
  `_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `_uid` CHAR(36) UNIQUE NOT NULL,
  `status` VARCHAR(10) NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL,
  `plan_id` VARCHAR(100) NULL DEFAULT NULL,
  `ends_at` DATETIME NULL DEFAULT NULL,
  `remarks` VARCHAR(500) NULL DEFAULT NULL,
  `vendors__id` INT(10) UNSIGNED NOT NULL,
  `charges` DECIMAL(13,4) NULL DEFAULT NULL,
  `__data` JSON NULL,
  `charges_frequency` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`_id`),
  INDEX `fk_manual_subscriptions_vendors1_idx` (`vendors__id` ASC),
  CONSTRAINT `fk_manual_subscriptions_vendors1`
    FOREIGN KEY (`vendors__id`)
    REFERENCES `vendors` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `transactions` (
  `_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `_uid` CHAR(36) UNIQUE NOT NULL,
  `status` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL,
  `amount` DECIMAL(13,4) NULL DEFAULT NULL,
  `reference_id` VARCHAR(45) NOT NULL,
  `notes` VARCHAR(500) NULL DEFAULT NULL,
  `__data` JSON NULL,
  `vendors__id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `subscriptions_id` BIGINT(19) UNSIGNED NULL DEFAULT NULL,
  `type` VARCHAR(45) NULL DEFAULT NULL,
  `manual_subscriptions__id` INT(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE INDEX `_uid_UNIQUE` (`_uid` ASC),
  UNIQUE INDEX `reference_id_UNIQUE` (`reference_id` ASC),
  INDEX `fk_transactions_vendors1_idx` (`vendors__id` ASC),
  INDEX `fk_transactions_subscriptions1_idx` (`subscriptions_id` ASC),
  INDEX `fk_transactions_manual_subscriptions1_idx` (`manual_subscriptions__id` ASC),
  CONSTRAINT `fk_transactions_vendors1`
    FOREIGN KEY (`vendors__id`)
    REFERENCES `vendors` (`_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transactions_subscriptions1`
    FOREIGN KEY (`subscriptions_id`)
    REFERENCES `subscriptions` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transactions_manual_subscriptions1`
    FOREIGN KEY (`manual_subscriptions__id`)
    REFERENCES `manual_subscriptions` (`_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
