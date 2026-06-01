-- DB UPDATE - WhatsJet 6.5
-- RUN this SQL script if you are upgrading from version 6.4 to 6.5
-- It does not need to be run for new installations

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

ALTER TABLE `configurations` 
CHANGE COLUMN `name` `name` VARCHAR(100) NOT NULL ;

ALTER TABLE `user_settings` 
CHANGE COLUMN `key_name` `key_name` VARCHAR(100) NOT NULL ;


ALTER TABLE `vendor_settings` 
CHANGE COLUMN `name` `name` VARCHAR(100) NOT NULL ;

CREATE TABLE IF NOT EXISTS `response_webhook_actions` (
  `_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `_uid` CHAR(36) UNIQUE NOT NULL,
  `status` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `title` VARCHAR(255) NOT NULL,
  `condition_key` VARCHAR(255) NOT NULL,
  `condition_value` VARCHAR(255) NOT NULL,
  `vendors__id` INT(10) UNSIGNED NOT NULL,
  `whatsapp_templates__id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `__data` JSON NULL,
  PRIMARY KEY (`_id`),
  UNIQUE INDEX `_uid_UNIQUE` (`_uid` ASC),
  INDEX `fk_response_webhook_actions_vendors1_idx` (`vendors__id` ASC),
  INDEX `fk_response_webhook_actions_whatsapp_templates1_idx` (`whatsapp_templates__id` ASC),
  CONSTRAINT `fk_response_webhook_actions_vendors1`
    FOREIGN KEY (`vendors__id`)
    REFERENCES `vendors` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_response_webhook_actions_whatsapp_templates1`
    FOREIGN KEY (`whatsapp_templates__id`)
    REFERENCES `whatsapp_templates` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `response_webhook_logs` (
  `_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `_uid` CHAR(36) UNIQUE NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `processed_at` DATETIME NULL DEFAULT NULL,
  `payload` JSON NOT NULL,
  `referral_data` JSON NULL,
  `vendors__id` INT(10) UNSIGNED NOT NULL,
  `contacts__id` INT(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`_id`),
  INDEX `fk_response_webhook_logs_vendors1_idx` (`vendors__id` ASC),
  INDEX `fk_response_webhook_logs_contacts1_idx` (`contacts__id` ASC),
  CONSTRAINT `fk_response_webhook_logs_vendors1`
    FOREIGN KEY (`vendors__id`)
    REFERENCES `vendors` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_response_webhook_logs_contacts1`
    FOREIGN KEY (`contacts__id`)
    REFERENCES `contacts` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `response_webhook_action_logs` (
  `_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `_uid` CHAR(36) UNIQUE NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `response_webhook_actions__id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `response_webhook_logs__id` INT(10) UNSIGNED NOT NULL,
  `whatsapp_message_logs__id` INT(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE INDEX `_uid_UNIQUE` (`_uid` ASC),
  INDEX `fk_response_webhook_action_logs_response_webhook_actions1_idx` (`response_webhook_actions__id` ASC),
  INDEX `fk_response_webhook_action_logs_response_webhook_logs1_idx` (`response_webhook_logs__id` ASC),
  INDEX `fk_response_webhook_action_logs_whatsapp_message_logs1_idx` (`whatsapp_message_logs__id` ASC),
  CONSTRAINT `fk_response_webhook_action_logs_response_webhook_actions1`
    FOREIGN KEY (`response_webhook_actions__id`)
    REFERENCES `response_webhook_actions` (`_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_response_webhook_action_logs_response_webhook_logs1`
    FOREIGN KEY (`response_webhook_logs__id`)
    REFERENCES `response_webhook_logs` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_response_webhook_action_logs_whatsapp_message_logs1`
    FOREIGN KEY (`whatsapp_message_logs__id`)
    REFERENCES `whatsapp_message_logs` (`_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
