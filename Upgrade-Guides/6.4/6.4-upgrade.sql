-- DB UPDATE - WhatsJet 6.4
-- RUN this SQL script if you are upgrading from version 6.x to 6.4
-- It does not need to be run for new installations

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

ALTER TABLE `users`
ADD COLUMN `two_factor_confirmed_at` DATETIME NULL DEFAULT NULL AFTER `two_factor_recovery_codes`;


ALTER TABLE `contact_bot_flow_sessions`
ADD COLUMN `__data` JSON NULL AFTER `last_whatsapp_message_logs__id`
;

ALTER TABLE `credit_transactions`
ADD COLUMN `whatsapp_calls__id` INT(10) UNSIGNED NULL DEFAULT NULL AFTER `whatsapp_message_logs__id`,
ADD INDEX `fk_credit_transactions_whatsapp_calls1_idx` (`whatsapp_calls__id` ASC)
;

CREATE TABLE IF NOT EXISTS `whatsapp_calls` (
  `_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `_uid` CHAR(36) UNIQUE NOT NULL,
  `status` VARCHAR(15) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `contacts__id` INT(10) UNSIGNED NOT NULL,
  `wacid` VARCHAR(255) NULL DEFAULT NULL,
  `call_direction` VARCHAR(25) NULL DEFAULT NULL,
  `started_at` DATETIME NULL DEFAULT NULL,
  `ended_at` DATETIME NULL DEFAULT NULL,
  `wa_call_duration` INT(10) UNSIGNED NULL DEFAULT NULL,
  `by_users__id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `user_action` VARCHAR(25) NULL DEFAULT NULL,
  `wab_phone_number_id` VARCHAR(45) NULL DEFAULT NULL,
  `contact_wa_id` VARCHAR(45) NULL DEFAULT NULL,
  `__data` JSON NULL,
  `user_session_id` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`_id`),
  INDEX `fk_whatsapp_calls_users1_idx` (`by_users__id` ASC),
  INDEX `fk_whatsapp_calls_contacts1_idx` (`contacts__id` ASC),
  CONSTRAINT `fk_whatsapp_calls_users1`
    FOREIGN KEY (`by_users__id`)
    REFERENCES `users` (`_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_whatsapp_calls_contacts1`
    FOREIGN KEY (`contacts__id`)
    REFERENCES `contacts` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE `credit_transactions`
ADD CONSTRAINT `fk_credit_transactions_whatsapp_calls1`
  FOREIGN KEY (`whatsapp_calls__id`)
  REFERENCES `whatsapp_calls` (`_id`)
  ON DELETE SET NULL
  ON UPDATE NO ACTION;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
