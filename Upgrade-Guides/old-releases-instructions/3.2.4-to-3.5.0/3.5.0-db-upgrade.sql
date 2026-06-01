-- MySQL
-- 3.5.0 - Upgrade
-- Model: WhatsJet

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

ALTER TABLE `users` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) NOT NULL ,
CHANGE COLUMN `username` `username` VARCHAR(45) NOT NULL ,
CHANGE COLUMN `email` `email` VARCHAR(255) NULL DEFAULT NULL ,
CHANGE COLUMN `password` `password` VARCHAR(255) NULL DEFAULT NULL ,
CHANGE COLUMN `remember_token` `remember_token` VARCHAR(255) NULL DEFAULT NULL ,
CHANGE COLUMN `last_name` `last_name` VARCHAR(45) NULL DEFAULT NULL ,
CHANGE COLUMN `mobile_number` `mobile_number` VARCHAR(15) NULL DEFAULT NULL COMMENT 'Make unique with country phone code' ,
CHANGE COLUMN `timezone` `timezone` VARCHAR(45) NULL DEFAULT NULL ,
CHANGE COLUMN `registered_via` `registered_via` VARCHAR(15) NULL DEFAULT NULL COMMENT 'Social account' ,
CHANGE COLUMN `ban_reason` `ban_reason` VARCHAR(255) NULL DEFAULT NULL ,
CHANGE COLUMN `two_factor_secret` `two_factor_secret` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `two_factor_recovery_codes` `two_factor_recovery_codes` TEXT NULL DEFAULT NULL ;

ALTER TABLE `configurations` 
CHANGE COLUMN `name` `name` VARCHAR(45) NOT NULL ,
CHANGE COLUMN `value` `value` TEXT NULL DEFAULT NULL ;

ALTER TABLE `countries` 
CHANGE COLUMN `iso_code` `iso_code` CHAR(2) NULL DEFAULT NULL ,
CHANGE COLUMN `name_capitalized` `name_capitalized` VARCHAR(100) NULL DEFAULT NULL ,
CHANGE COLUMN `name` `name` VARCHAR(100) NULL DEFAULT NULL ,
CHANGE COLUMN `iso3_code` `iso3_code` CHAR(3) NULL DEFAULT NULL ;

ALTER TABLE `user_roles` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `title` `title` VARCHAR(255) NULL DEFAULT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `pages` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `title` `title` VARCHAR(255) NOT NULL ,
CHANGE COLUMN `content` `content` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `slug` `slug` VARCHAR(255) NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `vendors` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `ban_reason` `ban_reason` VARCHAR(255) NULL DEFAULT NULL ,
CHANGE COLUMN `pm_type` `pm_type` VARCHAR(255) NULL DEFAULT NULL ,
CHANGE COLUMN `pm_last_four` `pm_last_four` VARCHAR(4) NULL DEFAULT NULL ,
CHANGE COLUMN `title` `title` VARCHAR(255) NULL DEFAULT NULL ,
CHANGE COLUMN `logo_image` `logo_image` VARCHAR(255) NULL DEFAULT NULL ,
CHANGE COLUMN `slug` `slug` VARCHAR(255) NULL DEFAULT NULL ,
CHANGE COLUMN `domain` `domain` VARCHAR(255) NULL DEFAULT NULL ,
CHANGE COLUMN `favicon` `favicon` VARCHAR(255) NULL DEFAULT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `vendor_settings` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `name` `name` VARCHAR(45) NOT NULL ,
CHANGE COLUMN `value` `value` TEXT NULL DEFAULT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `contacts` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `first_name` `first_name` VARCHAR(150) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NULL DEFAULT NULL ,
CHANGE COLUMN `last_name` `last_name` VARCHAR(150) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NULL DEFAULT NULL ,
CHANGE COLUMN `email` `email` VARCHAR(255) NULL DEFAULT NULL ,
CHANGE COLUMN `wa_id` `wa_id` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Its phone number with country code without + or 0 prefix' ,
CHANGE COLUMN `language_code` `language_code` VARCHAR(45) NULL DEFAULT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `contact_groups` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `title` `title` VARCHAR(255) NOT NULL ,
CHANGE COLUMN `description` `description` VARCHAR(500) NULL DEFAULT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `group_contacts` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `whatsapp_templates` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `status` `status` VARCHAR(15) NULL DEFAULT NULL ,
CHANGE COLUMN `template_name` `template_name` VARCHAR(512) NULL DEFAULT NULL ,
CHANGE COLUMN `template_id` `template_id` VARCHAR(45) NULL DEFAULT NULL ,
CHANGE COLUMN `category` `category` VARCHAR(45) NULL DEFAULT NULL ,
CHANGE COLUMN `language` `language` VARCHAR(45) NULL DEFAULT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `campaigns` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `title` `title` VARCHAR(255) NOT NULL ,
CHANGE COLUMN `template_name` `template_name` VARCHAR(255) NULL DEFAULT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
CHANGE COLUMN `template_language` `template_language` VARCHAR(45) NULL DEFAULT NULL ,
CHANGE COLUMN `timezone` `timezone` VARCHAR(45) NULL DEFAULT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `whatsapp_message_logs` 
ADD COLUMN `messaged_by_users__id` INT(10) UNSIGNED NULL DEFAULT NULL AFTER `replied_to_whatsapp_message_logs__uid`,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `status` `status` VARCHAR(10) NULL DEFAULT NULL ,
CHANGE COLUMN `message` `message` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NULL DEFAULT NULL ,
CHANGE COLUMN `contact_wa_id` `contact_wa_id` VARCHAR(45) NULL DEFAULT NULL ,
CHANGE COLUMN `wamid` `wamid` VARCHAR(255) NULL DEFAULT NULL ,
CHANGE COLUMN `wab_phone_number_id` `wab_phone_number_id` VARCHAR(45) NULL DEFAULT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
CHANGE COLUMN `replied_to_whatsapp_message_logs__uid` `replied_to_whatsapp_message_logs__uid` CHAR(36) NULL DEFAULT NULL ,
ADD INDEX `fk_whatsapp_message_logs_users1_idx` (`messaged_by_users__id` ASC),
DROP INDEX `_uid` ;
;

ALTER TABLE `whatsapp_message_queue` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
CHANGE COLUMN `phone_with_country_code` `phone_with_country_code` VARCHAR(45) NOT NULL ,
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
CHANGE COLUMN `field_value` `field_value` VARCHAR(255) NULL DEFAULT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `bot_replies` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `name` `name` VARCHAR(45) NOT NULL ,
CHANGE COLUMN `trigger_type` `trigger_type` VARCHAR(45) NULL DEFAULT NULL COMMENT 'contains,is' ,
CHANGE COLUMN `reply_trigger` `reply_trigger` VARCHAR(255) NULL DEFAULT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `contact_users` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
DROP INDEX `_uid` ;
;

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

CREATE TABLE IF NOT EXISTS `labels` (
  `_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `_uid` CHAR(36) UNIQUE NOT NULL,
  `status` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL,
  `title` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NOT NULL,
  `text_color` VARCHAR(10) NULL DEFAULT NULL,
  `bg_color` VARCHAR(10) NULL DEFAULT NULL,
  `vendors__id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE INDEX `_uid_UNIQUE` (`_uid` ASC),
  INDEX `fk_labels_vendors1_idx` (`vendors__id` ASC),
  CONSTRAINT `fk_labels_vendors1`
    FOREIGN KEY (`vendors__id`)
    REFERENCES `vendors` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `contact_labels` (
  `_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `_uid` CHAR(36) UNIQUE NOT NULL,
  `status` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL,
  `labels__id` INT(10) UNSIGNED NOT NULL,
  `contacts__id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE INDEX `_uid_UNIQUE` (`_uid` ASC),
  INDEX `fk_contact_labels_labels1_idx` (`labels__id` ASC),
  INDEX `fk_contact_labels_contacts1_idx` (`contacts__id` ASC),
  CONSTRAINT `fk_contact_labels_labels1`
    FOREIGN KEY (`labels__id`)
    REFERENCES `labels` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contact_labels_contacts1`
    FOREIGN KEY (`contacts__id`)
    REFERENCES `contacts` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `message_labels` (
  `_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `_uid` CHAR(36) UNIQUE NOT NULL,
  `status` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL,
  `labels__id` INT(10) UNSIGNED NOT NULL,
  `whatsapp_message_logs__id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE INDEX `_uid_UNIQUE` (`_uid` ASC),
  INDEX `fk_message_labels_labels1_idx` (`labels__id` ASC),
  INDEX `fk_message_labels_whatsapp_message_logs1_idx` (`whatsapp_message_logs__id` ASC),
  CONSTRAINT `fk_message_labels_labels1`
    FOREIGN KEY (`labels__id`)
    REFERENCES `labels` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_labels_whatsapp_message_logs1`
    FOREIGN KEY (`whatsapp_message_logs__id`)
    REFERENCES `whatsapp_message_logs` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `tickets` (
  `_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `_uid` CHAR(36) UNIQUE NOT NULL,
  `status` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL,
  `contacts__id` INT(10) UNSIGNED NOT NULL,
  `vendors__id` INT(10) UNSIGNED NOT NULL,
  `subject` VARCHAR(150) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NULL DEFAULT NULL,
  `description` VARCHAR(500) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NULL DEFAULT NULL,
  `priority` VARCHAR(10) NULL DEFAULT NULL,
  `vendor_users__id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `__data` JSON NULL,
  `assigned_users__id` INT(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE INDEX `_uid_UNIQUE` (`_uid` ASC),
  INDEX `fk_tickets_contacts1_idx` (`contacts__id` ASC),
  INDEX `fk_tickets_vendors1_idx` (`vendors__id` ASC),
  INDEX `fk_tickets_vendor_users1_idx` (`vendor_users__id` ASC),
  INDEX `fk_tickets_users1_idx` (`assigned_users__id` ASC),
  CONSTRAINT `fk_tickets_contacts1`
    FOREIGN KEY (`contacts__id`)
    REFERENCES `contacts` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tickets_vendors1`
    FOREIGN KEY (`vendors__id`)
    REFERENCES `vendors` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tickets_vendor_users1`
    FOREIGN KEY (`vendor_users__id`)
    REFERENCES `vendor_users` (`_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tickets_users1`
    FOREIGN KEY (`assigned_users__id`)
    REFERENCES `users` (`_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE `whatsapp_message_logs` 
ADD CONSTRAINT `fk_whatsapp_message_logs_users1`
  FOREIGN KEY (`messaged_by_users__id`)
  REFERENCES `users` (`_id`)
  ON DELETE SET NULL
  ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
