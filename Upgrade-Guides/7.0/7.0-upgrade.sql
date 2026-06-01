-- DB UPDATE - WhatsJet 7.0
-- RUN this SQL script if you are upgrading from version 6.5(or above) to 7.0
-- It does not need to be run for new installations

-- add columns to whatsapp_message_logs
ALTER TABLE whatsapp_message_logs
ADD COLUMN full_name VARCHAR(255);
-- add columns to whatsapp_message_queue
ALTER TABLE whatsapp_message_queue
ADD COLUMN full_name VARCHAR(255),
ADD COLUMN message_type VARCHAR(25);

-- prefill full_name in whatsapp_message_logs table for campaign messages
UPDATE whatsapp_message_logs
SET
full_name  = CONCAT(
    JSON_UNQUOTE(JSON_EXTRACT(__data, '$.contact_data.first_name')), ' ',
    JSON_UNQUOTE(JSON_EXTRACT(__data, '$.contact_data.last_name'))
);

UPDATE whatsapp_message_queue
SET
full_name  = CONCAT(
    JSON_UNQUOTE(JSON_EXTRACT(__data, '$.contact_data.first_name')), ' ',
    JSON_UNQUOTE(JSON_EXTRACT(__data, '$.contact_data.last_name'))
);

ALTER TABLE `users`
ADD COLUMN `__data` JSON NULL;

ALTER TABLE `vendors`
ADD COLUMN `__data` JSON NULL;

ALTER TABLE `whatsapp_webhook_queue`
ADD COLUMN `attempts` TINYINT(3) UNSIGNED NULL DEFAULT NULL;

ALTER TABLE `vendor_notifications`
ADD COLUMN `message` VARCHAR(1000) NULL DEFAULT NULL,
ADD COLUMN `action` VARCHAR(1000) NULL DEFAULT NULL;

ALTER TABLE `contacts`
ADD COLUMN `username` VARCHAR(36) NULL DEFAULT NULL,
ADD COLUMN `bsuid` VARCHAR(255) NULL DEFAULT NULL,
ADD INDEX `idx_username` (`username` ASC),
ADD INDEX `idx_bsuid` (`bsuid` ASC);
;

CREATE TABLE IF NOT EXISTS `info_materials` (
  `_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `_uid` CHAR(36) UNIQUE NOT NULL,
  `status` VARCHAR(15) NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `title` VARCHAR(500) NOT NULL,
  `description` TEXT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `vendors__id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `__data` JSON NULL,
  PRIMARY KEY (`_id`),
  UNIQUE INDEX `_uid_UNIQUE` (`_uid` ASC),
  INDEX `fk_info_materials_vendors1_idx` (`vendors__id` ASC),
  CONSTRAINT `fk_info_materials_vendors1`
    FOREIGN KEY (`vendors__id`)
    REFERENCES `vendors` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `background_tasks` (
  `_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `_uid` CHAR(36) UNIQUE NOT NULL,
  `status` VARCHAR(15) NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `headers` JSON NULL,
  `payload` JSON NULL,
  `attempted_at` DATETIME NULL DEFAULT NULL,
  `attempts` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
  `__data` JSON NULL,
  `scheduled_at` DATETIME NULL DEFAULT NULL,
  `vendors__id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `response` VARCHAR(1000) NULL DEFAULT NULL,
  `subject` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE INDEX `_uid_UNIQUE` (`_uid` ASC),
  INDEX `fk_background_tasks_vendors1_idx` (`vendors__id` ASC),
  CONSTRAINT `fk_background_tasks_vendors1`
    FOREIGN KEY (`vendors__id`)
    REFERENCES `vendors` (`_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- suggested optimizations
-- 13 DEC 2025
CREATE INDEX idx_vendor_incoming_contact_status ON whatsapp_message_logs (vendors__id, is_incoming_message, contacts__id, status);
CREATE INDEX idx_wa_id_on_contacts ON contacts(wa_id);
-- bot_replies
CREATE INDEX idx_status ON bot_replies(status);
CREATE INDEX idx_trigger_type ON bot_replies(trigger_type);
CREATE INDEX idx_priority_index ON bot_replies(priority_index);
CREATE INDEX idx_vendor_flow_null ON bot_replies (vendors__id, bot_flows__id);
-- others
CREATE INDEX idx_vendor_status_created ON manual_subscriptions (vendors__id, status, created_at);

-- contacts
CREATE INDEX idx_contacts_id ON contacts (_id);
CREATE INDEX idx_contacts_uid ON contacts (_uid);
CREATE INDEX idx_vendor_contact_status_created ON contacts (vendors__id, status, created_at);
CREATE INDEX idx_vendor_contact_status_wa_id ON contacts (vendors__id, status, wa_id);
CREATE INDEX idx_vendor_contact_status ON contacts (vendors__id, status);
CREATE INDEX idx_vendor_contact_wa_id ON contacts (vendors__id, wa_id);

CREATE INDEX idx_vendor_uid ON contacts (vendors__id, _uid);
CREATE INDEX idx_assigned_user ON contacts (assigned_users__id);

-- contact labels
CREATE INDEX idx_contact_labels_map ON contact_labels (contacts__id, labels__id);
-- message logs
CREATE INDEX idx_vendor_msgtime ON whatsapp_message_logs (vendors__id, messaged_at);
CREATE INDEX idx_unread_vendor ON whatsapp_message_logs (vendors__id, is_incoming_message, status);
CREATE INDEX idx_contact_incoming ON whatsapp_message_logs (contacts__id, is_incoming_message, messaged_at);
CREATE INDEX idx_vendor_incoming_msgtime ON whatsapp_message_logs (vendors__id, is_incoming_message, messaged_at);
CREATE INDEX idx_vendor_message_log_campaign_status ON whatsapp_message_logs (vendors__id, campaigns__id, status);
CREATE INDEX idx_vendor_message_log_campaign ON whatsapp_message_logs (vendors__id, campaigns__id);
CREATE INDEX idx_vendor_message_log_campaign_msgtime ON whatsapp_message_logs (vendors__id, campaigns__id, messaged_at);
CREATE INDEX idx_campaign_status_name ON whatsapp_message_logs (campaigns__id, status, full_name);
CREATE INDEX idx_campaign_status ON whatsapp_message_logs (campaigns__id, status);

CREATE INDEX idx_contact_incoming_msgtime ON whatsapp_message_logs (contacts__id, is_incoming_message, messaged_at);
CREATE INDEX idx_messages_contact_incoming ON whatsapp_message_logs (contacts__id, is_incoming_message);
-- may have issue
CREATE INDEX idx_vendor_system_null ON whatsapp_message_logs (vendors__id, is_system_message);
CREATE INDEX idx_logs_contact_msgtime ON whatsapp_message_logs (contacts__id, messaged_at);
CREATE INDEX idx_logs_contact_incoming ON whatsapp_message_logs (contacts__id, is_incoming_message, status);

CREATE INDEX idx_whatsapp_message_log_vendor_status_name ON whatsapp_message_logs (vendors__id, campaigns__id, status, full_name);

-- 23 DEC 2025 - campaigns
CREATE INDEX idx_vendor_campaign_status ON campaigns (vendors__id, status);
CREATE INDEX idx_vendor_campaign_status_created ON campaigns (vendors__id, status, created_at);
CREATE INDEX idx_vendor_campaign_status_scheduled ON campaigns (vendors__id, status, scheduled_at);
CREATE INDEX idx_vendor_campaign_status_title ON campaigns (vendors__id, status, title);
-- message queue
CREATE INDEX idx_whatsapp_message_queue_status ON whatsapp_message_queue (campaigns__id, status);
CREATE INDEX idx_whatsapp_message_queue_status_name ON whatsapp_message_queue (campaigns__id, status, full_name);
CREATE INDEX idx_whatsapp_message_queue_vendor_status_name ON whatsapp_message_queue (vendors__id, campaigns__id, status, full_name);
-- whatsapp templates
CREATE INDEX idx_whatsapp_templates_vendor_status ON campaigns (vendors__id, status);
-- whatsapp webhooks
CREATE INDEX idx_webhooks_status_attempted_created ON whatsapp_webhook_queue (status, attempted_at, created_at);
CREATE INDEX idx_background_task_status_attempted_created ON background_tasks (status, attempted_at, created_at);
-- vendor settings
CREATE INDEX idx_vendor_settings_name ON vendor_settings (vendors__id, name);