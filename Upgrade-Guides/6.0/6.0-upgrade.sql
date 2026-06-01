-- DB UPDATE - WhatsJet 6.0.0

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

ALTER TABLE `configurations` 
CHANGE COLUMN `value` `value` LONGTEXT NULL DEFAULT NULL ;

ALTER TABLE `pages` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `content` `content` LONGTEXT NULL DEFAULT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `vendors` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `stripe_id` `stripe_id` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `contacts` 
ADD COLUMN `disable_reply_bot` TINYINT(3) UNSIGNED NULL DEFAULT NULL AFTER `assigned_users__id`,
ADD COLUMN `wa_blocked_at` DATETIME NULL DEFAULT NULL AFTER `disable_reply_bot`,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `first_name` `first_name` VARCHAR(150) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NULL DEFAULT NULL ,
CHANGE COLUMN `last_name` `last_name` VARCHAR(150) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NULL DEFAULT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
ADD INDEX `idx_wa_id` (`wa_id` ASC),
DROP INDEX `_uid` ;
;

ALTER TABLE `whatsapp_templates` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
ADD INDEX `idx_template_id` (`template_id` ASC),
ADD INDEX `idx_template_name` (`template_name` ASC),
DROP INDEX `_uid` ;
;

ALTER TABLE `whatsapp_message_logs` 
ADD COLUMN `is_system_message` TINYINT(4) NULL DEFAULT NULL AFTER `messaged_by_users__id`,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `message` `message` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NULL DEFAULT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
ADD INDEX `idx_wamid` (`wamid` ASC),
ADD INDEX `idx_contact_wa_id` (`contact_wa_id` ASC),
ADD INDEX `idx_wab_phone_number_id` (`wab_phone_number_id` ASC),
DROP INDEX `_uid` ;
;

ALTER TABLE `whatsapp_message_queue` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
ADD INDEX `idx_scheduled_at` (`scheduled_at` ASC),
ADD INDEX `idx_phone_with_country_code` (`phone_with_country_code` ASC),
DROP INDEX `_uid` ;
;

ALTER TABLE `bot_replies` 
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
ADD INDEX `idx_reply_trigger` (`reply_trigger` ASC),
DROP INDEX `_uid` ;
;

ALTER TABLE `transactions` 
COLLATE = utf8mb4_general_ci ,
ADD COLUMN `credit_transactions__id` INT(10) UNSIGNED NULL DEFAULT NULL AFTER `manual_subscriptions__id`,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
ADD INDEX `fk_transactions_credit_transactions1_idx` (`credit_transactions__id` ASC),
DROP INDEX `_uid` ;
;

ALTER TABLE `manual_subscriptions` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ,
ADD COLUMN `is_auto_recurring` TINYINT(3) UNSIGNED NULL DEFAULT NULL AFTER `charges_frequency`,
ADD COLUMN `deleted_at` DATETIME NULL DEFAULT NULL AFTER `is_auto_recurring`,
ADD COLUMN `gateway` VARCHAR(45) NULL DEFAULT NULL AFTER `deleted_at`,
ADD COLUMN `gateway_price_id` VARCHAR(150) NULL DEFAULT NULL AFTER `gateway`,
ADD COLUMN `trial_ends_at` DATETIME NULL DEFAULT NULL AFTER `gateway_price_id`,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
DROP INDEX `_uid` ;
;


ALTER TABLE `bot_flows` 
ADD COLUMN `is_strict_flow` TINYINT(3) UNSIGNED NULL DEFAULT NULL AFTER `start_trigger`,
ADD COLUMN `session_timeout_minutes` INT(10) UNSIGNED NULL DEFAULT NULL AFTER `is_strict_flow`,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
DROP INDEX `_uid` ;
;

ALTER TABLE `jobs` 
CHANGE COLUMN `id` `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT ;

ALTER TABLE `failed_jobs` 
CHANGE COLUMN `id` `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT ;

CREATE TABLE IF NOT EXISTS `whatsapp_webhook_queue` (
  `_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `_uid` CHAR(36) NOT NULL,
  `headers` JSON NULL,
  `payload` JSON NULL,
  `status` VARCHAR(15) NULL DEFAULT 'pending',
  `attempted_at` TIMESTAMP NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `vendors__id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE INDEX `_uid_UNIQUE` (`_uid` ASC),
  INDEX `fk_whatsapp_webhook_queue_vendors1_idx` (`vendors__id` ASC),
  CONSTRAINT `fk_whatsapp_webhook_queue_vendors1`
    FOREIGN KEY (`vendors__id`)
    REFERENCES `vendors` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `contact_bot_flow_sessions` (
  `_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `_uid` CHAR(36) UNIQUE NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `bot_flows__id` INT(10) UNSIGNED NOT NULL,
  `contacts__id` INT(10) UNSIGNED NOT NULL,
  `bot_replies__id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `timeout_at` DATETIME NULL DEFAULT NULL,
  `last_whatsapp_message_logs__id` INT(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE INDEX `_uid_UNIQUE` (`_uid` ASC),
  INDEX `fk_contact_bot_flow_sessions_bot_flows1_idx` (`bot_flows__id` ASC),
  INDEX `fk_contact_bot_flow_sessions_contacts1_idx` (`contacts__id` ASC),
  INDEX `fk_contact_bot_flow_sessions_bot_replies1_idx` (`bot_replies__id` ASC),
  INDEX `fk_contact_bot_flow_sessions_whatsapp_message_logs1_idx` (`last_whatsapp_message_logs__id` ASC),
  CONSTRAINT `fk_contact_bot_flow_sessions_bot_flows1`
    FOREIGN KEY (`bot_flows__id`)
    REFERENCES `bot_flows` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contact_bot_flow_sessions_contacts1`
    FOREIGN KEY (`contacts__id`)
    REFERENCES `contacts` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contact_bot_flow_sessions_bot_replies1`
    FOREIGN KEY (`bot_replies__id`)
    REFERENCES `bot_replies` (`_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contact_bot_flow_sessions_whatsapp_message_logs1`
    FOREIGN KEY (`last_whatsapp_message_logs__id`)
    REFERENCES `whatsapp_message_logs` (`_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `credit_transactions` (
  `_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `_uid` CHAR(36) UNIQUE NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `credits` BIGINT(20) NULL DEFAULT NULL,
  `type` VARCHAR(45) NULL DEFAULT NULL,
  `notes` VARCHAR(255) NULL DEFAULT NULL,
  `vendors__id` INT(10) UNSIGNED NOT NULL,
  `whatsapp_message_logs__id` INT(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE INDEX `_uid_UNIQUE` (`_uid` ASC),
  INDEX `fk_credit_transactions_vendors1_idx` (`vendors__id` ASC),
  INDEX `fk_credit_transactions_whatsapp_message_logs1_idx` (`whatsapp_message_logs__id` ASC),
  CONSTRAINT `fk_credit_transactions_vendors1`
    FOREIGN KEY (`vendors__id`)
    REFERENCES `vendors` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_credit_transactions_whatsapp_message_logs1`
    FOREIGN KEY (`whatsapp_message_logs__id`)
    REFERENCES `whatsapp_message_logs` (`_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `user_devices` (
  `_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `_uid` CHAR(36) UNIQUE NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `device_token` VARCHAR(255) NULL DEFAULT NULL,
  `device_id` VARCHAR(100) NULL DEFAULT NULL,
  `device_type` VARCHAR(20) NULL DEFAULT NULL,
  `fcm_token` VARCHAR(255) NULL DEFAULT NULL,
  `users__id` INT(10) UNSIGNED NOT NULL,
  `vendors__id` INT(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE INDEX `_uid_UNIQUE` (`_uid` ASC),
  INDEX `fk_user_devices_users1_idx` (`users__id` ASC),
  INDEX `fk_user_devices_vendors1_idx` (`vendors__id` ASC),
  CONSTRAINT `fk_user_devices_users1`
    FOREIGN KEY (`users__id`)
    REFERENCES `users` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_devices_vendors1`
    FOREIGN KEY (`vendors__id`)
    REFERENCES `vendors` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `vendor_notifications` (
  `_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `_uid` CHAR(36) UNIQUE NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `type` VARCHAR(45) NOT NULL,
  `read_at` DATETIME NULL DEFAULT NULL,
  `__data` JSON NULL,
  `vendors__id` INT(10) UNSIGNED NOT NULL,
  `users__id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `scheduled_at` DATETIME NULL DEFAULT NULL,
  `expiry_at` DATETIME NULL DEFAULT NULL,
  `via` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE INDEX `_uid_UNIQUE` (`_uid` ASC),
  INDEX `fk_vendor_notifications_vendors1_idx` (`vendors__id` ASC),
  INDEX `fk_vendor_notifications_users1_idx` (`users__id` ASC),
  CONSTRAINT `fk_vendor_notifications_vendors1`
    FOREIGN KEY (`vendors__id`)
    REFERENCES `vendors` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendor_notifications_users1`
    FOREIGN KEY (`users__id`)
    REFERENCES `users` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE `transactions` 
DROP FOREIGN KEY `fk_transactions_vendors1`,
DROP FOREIGN KEY `fk_transactions_subscriptions1`;

ALTER TABLE `transactions` ADD CONSTRAINT `fk_transactions_vendors1`
  FOREIGN KEY (`vendors__id`)
  REFERENCES `vendors` (`_id`)
  ON DELETE SET NULL
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_transactions_subscriptions1`
  FOREIGN KEY (`subscriptions_id`)
  REFERENCES `subscriptions` (`id`)
  ON DELETE SET NULL
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_transactions_credit_transactions1`
  FOREIGN KEY (`credit_transactions__id`)
  REFERENCES `credit_transactions` (`_id`)
  ON DELETE SET NULL
  ON UPDATE NO ACTION;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
