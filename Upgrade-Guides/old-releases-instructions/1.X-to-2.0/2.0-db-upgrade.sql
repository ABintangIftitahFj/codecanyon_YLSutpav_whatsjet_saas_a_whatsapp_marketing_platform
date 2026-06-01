-- MySQL
-- 2.0 - Upgrade
-- Model: WhatsJet

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

ALTER TABLE `contacts`
ADD COLUMN `disable_ai_bot` TINYINT(3) UNSIGNED NULL DEFAULT NULL AFTER `language_code`,
ADD COLUMN `__data` JSON NULL AFTER `disable_ai_bot`,
ADD COLUMN `assigned_users__id` INT(10) UNSIGNED NULL DEFAULT NULL AFTER `__data`,
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `first_name` `first_name` VARCHAR(150) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NULL DEFAULT NULL ,
CHANGE COLUMN `last_name` `last_name` VARCHAR(150) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NULL DEFAULT NULL ,
ADD INDEX `fk_contacts_users1_idx` (`assigned_users__id` ASC),
DROP INDEX `_uid` ;
;

ALTER TABLE `whatsapp_message_logs`
CHANGE COLUMN `_uid` `_uid` CHAR(36) UNIQUE NOT NULL ,
CHANGE COLUMN `message` `message` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NULL DEFAULT NULL ,
CHANGE COLUMN `__data` `__data` JSON NULL ,
DROP INDEX `_uid` ;
;

CREATE TABLE IF NOT EXISTS `vendor_users` (
  `_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `_uid` CHAR(36) UNIQUE NOT NULL,
  `status` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL,
  `vendors__id` INT(10) UNSIGNED NOT NULL,
  `users__id` INT(10) UNSIGNED NOT NULL,
  `__data` JSON NULL,
  PRIMARY KEY (`_id`),
  UNIQUE INDEX `_uid_UNIQUE` (`_uid` ASC),
  INDEX `fk_vendor_users_vendors1_idx` (`vendors__id` ASC),
  INDEX `fk_vendor_users_users1_idx` (`users__id` ASC),
  CONSTRAINT `fk_vendor_users_vendors1`
    FOREIGN KEY (`vendors__id`)
    REFERENCES `vendors` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendor_users_users1`
    FOREIGN KEY (`users__id`)
    REFERENCES `users` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE `contacts` 
ADD CONSTRAINT `fk_contacts_users1`
  FOREIGN KEY (`assigned_users__id`)
  REFERENCES `users` (`_id`)
  ON DELETE SET NULL
  ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
