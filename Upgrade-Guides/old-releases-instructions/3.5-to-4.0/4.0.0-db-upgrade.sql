-- MySQL
-- 3.5.0 to 4.0.0 - Upgrade
-- Model: WhatsJet

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

ALTER TABLE `user_roles` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `pages` 
ADD COLUMN `image_name` VARCHAR(255) NULL DEFAULT NULL AFTER `slug`,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `vendors` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `vendor_settings` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `contacts` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `first_name` `first_name` VARCHAR(150) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NULL DEFAULT NULL ,
CHANGE COLUMN `last_name` `last_name` VARCHAR(150) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NULL DEFAULT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `contact_groups` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `group_contacts` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `whatsapp_templates` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `campaigns` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `whatsapp_message_logs` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `message` `message` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NULL DEFAULT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `whatsapp_message_queue` 
ADD COLUMN `retries` TINYINT(4) NULL DEFAULT NULL AFTER `contacts__id`,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `campaign_groups` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `contact_custom_fields` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `contact_custom_field_values` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `bot_replies` 
ADD COLUMN `bot_flows__id` INT(10) UNSIGNED NULL DEFAULT NULL AFTER `__data`,
ADD COLUMN `bot_replies__id` INT(10) UNSIGNED NULL DEFAULT NULL AFTER `bot_flows__id`,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `name` `name` VARCHAR(255) NOT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
ADD INDEX `fk_bot_replies_bot_flows1_idx` (`bot_flows__id` ASC),
ADD INDEX `fk_bot_replies_bot_replies1_idx` (`bot_replies__id` ASC),
DROP INDEX `_uid` ;
;

ALTER TABLE `contact_users` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;

ALTER TABLE `vendor_users` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `transactions` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `manual_subscriptions` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `labels` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `title` `title` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `contact_labels` 
CHARACTER SET = utf8mb4 , COLLATE = utf8mb4_unicode_ci ,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `message_labels` 
CHARACTER SET = utf8mb4 , COLLATE = utf8mb4_unicode_ci ,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `tickets` 
CHARACTER SET = utf8mb4 , COLLATE = utf8mb4_unicode_ci ,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `subject` `subject` VARCHAR(150) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NULL DEFAULT NULL ,
CHANGE COLUMN `description` `description` VARCHAR(500) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NULL DEFAULT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
DROP INDEX `_uid` ;
;

CREATE TABLE IF NOT EXISTS `bot_flows` (
  `_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `_uid` CHAR(36) UNIQUE NOT NULL,
  `status` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL,
  `title` VARCHAR(150) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `vendors__id` INT(10) UNSIGNED NOT NULL,
  `__data` JSON NULL,
  `start_trigger` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE INDEX `_uid_UNIQUE` (`_uid` ASC),
  INDEX `fk_bot_flows_vendors1_idx` (`vendors__id` ASC),
  CONSTRAINT `fk_bot_flows_vendors1`
    FOREIGN KEY (`vendors__id`)
    REFERENCES `vendors` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

ALTER TABLE `bot_replies` 
ADD CONSTRAINT `fk_bot_replies_bot_flows1`
  FOREIGN KEY (`bot_flows__id`)
  REFERENCES `bot_flows` (`_id`)
  ON DELETE CASCADE
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_bot_replies_bot_replies1`
  FOREIGN KEY (`bot_replies__id`)
  REFERENCES `bot_replies` (`_id`)
  ON DELETE SET NULL
  ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
