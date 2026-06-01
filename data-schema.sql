-- WhatsJet 7.0 +

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `_id` int UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL,
  `user_id` int UNSIGNED DEFAULT NULL,
  `user_role_id` tinyint UNSIGNED DEFAULT NULL,
  `vendor_id` int DEFAULT NULL,
  `activity` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `background_tasks`
--

CREATE TABLE `background_tasks` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) NOT NULL,
  `status` varchar(15) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `headers` json DEFAULT NULL,
  `payload` json DEFAULT NULL,
  `attempted_at` datetime DEFAULT NULL,
  `attempts` tinyint UNSIGNED DEFAULT NULL,
  `__data` json DEFAULT NULL,
  `scheduled_at` datetime DEFAULT NULL,
  `vendors__id` int UNSIGNED DEFAULT NULL,
  `response` varchar(1000) DEFAULT NULL,
  `subject` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `bot_flows`
--

CREATE TABLE `bot_flows` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `title` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `vendors__id` int UNSIGNED NOT NULL,
  `__data` json DEFAULT NULL,
  `start_trigger` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_strict_flow` tinyint UNSIGNED DEFAULT NULL,
  `session_timeout_minutes` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bot_replies`
--

CREATE TABLE `bot_replies` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `vendors__id` int UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reply_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `trigger_type` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'contains,is',
  `reply_trigger` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `priority_index` tinyint UNSIGNED DEFAULT NULL,
  `__data` json DEFAULT NULL,
  `bot_flows__id` int UNSIGNED DEFAULT NULL,
  `bot_replies__id` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `campaigns`
--

CREATE TABLE `campaigns` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `whatsapp_templates__id` int UNSIGNED DEFAULT NULL,
  `scheduled_at` datetime DEFAULT NULL,
  `users__id` int UNSIGNED DEFAULT NULL,
  `vendors__id` int UNSIGNED NOT NULL,
  `template_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `__data` json DEFAULT NULL,
  `template_language` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timezone` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `campaign_groups`
--

CREATE TABLE `campaign_groups` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `campaigns__id` int UNSIGNED NOT NULL,
  `contact_groups__id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `configurations`
--

CREATE TABLE `configurations` (
  `_id` int UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `data_type` tinyint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `countries__id` smallint UNSIGNED DEFAULT NULL,
  `whatsapp_opt_out` tinyint UNSIGNED DEFAULT NULL,
  `phone_verified_at` datetime DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` datetime DEFAULT NULL,
  `vendors__id` int UNSIGNED NOT NULL,
  `wa_id` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Its phone number with country code without + or 0 prefix',
  `language_code` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disable_ai_bot` tinyint UNSIGNED DEFAULT NULL,
  `__data` json DEFAULT NULL,
  `assigned_users__id` int UNSIGNED DEFAULT NULL,
  `disable_reply_bot` tinyint UNSIGNED DEFAULT NULL,
  `wa_blocked_at` datetime DEFAULT NULL,
  `username` varchar(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bsuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contact_bot_flow_sessions`
--

CREATE TABLE `contact_bot_flow_sessions` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `bot_flows__id` int UNSIGNED NOT NULL,
  `contacts__id` int UNSIGNED NOT NULL,
  `bot_replies__id` int UNSIGNED DEFAULT NULL,
  `timeout_at` datetime DEFAULT NULL,
  `last_whatsapp_message_logs__id` int UNSIGNED DEFAULT NULL,
  `__data` json DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `contact_custom_fields`
--

CREATE TABLE `contact_custom_fields` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) NOT NULL,
  `status` tinyint UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `input_name` varchar(255) NOT NULL,
  `input_type` varchar(15) DEFAULT NULL COMMENT 'Text,number,email etc',
  `vendors__id` int UNSIGNED NOT NULL,
  `__data` json DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `contact_custom_field_values`
--

CREATE TABLE `contact_custom_field_values` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `contacts__id` int UNSIGNED NOT NULL,
  `contact_custom_fields__id` int UNSIGNED NOT NULL,
  `field_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contact_groups`
--

CREATE TABLE `contact_groups` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vendors__id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contact_labels`
--

CREATE TABLE `contact_labels` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `labels__id` int UNSIGNED NOT NULL,
  `contacts__id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `_id` smallint UNSIGNED NOT NULL,
  `iso_code` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name_capitalized` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `iso3_code` char(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `iso_num_code` smallint DEFAULT NULL,
  `phone_code` smallint UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `credit_transactions`
--

CREATE TABLE `credit_transactions` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `credits` bigint DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `vendors__id` int UNSIGNED NOT NULL,
  `whatsapp_message_logs__id` int UNSIGNED DEFAULT NULL,
  `whatsapp_calls__id` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `group_contacts`
--

CREATE TABLE `group_contacts` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `contact_groups__id` int UNSIGNED NOT NULL,
  `contacts__id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `info_materials`
--

CREATE TABLE `info_materials` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) NOT NULL,
  `status` varchar(15) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `title` varchar(500) NOT NULL,
  `description` text NOT NULL,
  `type` varchar(45) NOT NULL,
  `vendors__id` int UNSIGNED DEFAULT NULL,
  `__data` json DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `labels`
--

CREATE TABLE `labels` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) NOT NULL,
  `status` tinyint UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `title` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `text_color` varchar(10) DEFAULT NULL,
  `bg_color` varchar(10) DEFAULT NULL,
  `vendors__id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

CREATE TABLE `login_attempts` (
  `_id` int UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `attempts` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `login_logs`
--

CREATE TABLE `login_logs` (
  `_id` int UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `role` tinyint NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `ip_address` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `manual_subscriptions`
--

CREATE TABLE `manual_subscriptions` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) NOT NULL,
  `status` varchar(10) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `plan_id` varchar(100) DEFAULT NULL,
  `ends_at` datetime DEFAULT NULL,
  `remarks` varchar(500) DEFAULT NULL,
  `vendors__id` int UNSIGNED NOT NULL,
  `charges` decimal(13,4) DEFAULT NULL,
  `__data` json DEFAULT NULL,
  `charges_frequency` varchar(45) DEFAULT NULL,
  `is_auto_recurring` tinyint UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `gateway` varchar(45) DEFAULT NULL,
  `gateway_price_id` varchar(150) DEFAULT NULL,
  `trial_ends_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `message_labels`
--

CREATE TABLE `message_labels` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `labels__id` int UNSIGNED NOT NULL,
  `whatsapp_message_logs__id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `status` tinyint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `show_in_menu` tinyint UNSIGNED DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `type` tinyint UNSIGNED NOT NULL,
  `vendors__id` int UNSIGNED DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `_id` int UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL,
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `response_webhook_actions`
--

CREATE TABLE `response_webhook_actions` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) NOT NULL,
  `status` tinyint UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `condition_key` varchar(255) NOT NULL,
  `condition_value` varchar(255) NOT NULL,
  `vendors__id` int UNSIGNED NOT NULL,
  `whatsapp_templates__id` int UNSIGNED DEFAULT NULL,
  `__data` json DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `response_webhook_action_logs`
--

CREATE TABLE `response_webhook_action_logs` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `response_webhook_actions__id` int UNSIGNED DEFAULT NULL,
  `response_webhook_logs__id` int UNSIGNED NOT NULL,
  `whatsapp_message_logs__id` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `response_webhook_logs`
--

CREATE TABLE `response_webhook_logs` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `processed_at` datetime DEFAULT NULL,
  `payload` json NOT NULL,
  `referral_data` json DEFAULT NULL,
  `vendors__id` int UNSIGNED NOT NULL,
  `contacts__id` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` bigint UNSIGNED NOT NULL,
  `vendor_model__id` bigint UNSIGNED NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_price` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscription_items`
--

CREATE TABLE `subscription_items` (
  `id` bigint UNSIGNED NOT NULL,
  `stripe_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_product` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_price` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `subscription_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `contacts__id` int UNSIGNED NOT NULL,
  `vendors__id` int UNSIGNED NOT NULL,
  `subject` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `priority` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vendor_users__id` int UNSIGNED DEFAULT NULL,
  `__data` json DEFAULT NULL,
  `assigned_users__id` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) NOT NULL,
  `status` tinyint UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `amount` decimal(13,4) DEFAULT NULL,
  `reference_id` varchar(45) NOT NULL,
  `notes` varchar(500) DEFAULT NULL,
  `__data` json DEFAULT NULL,
  `vendors__id` int UNSIGNED DEFAULT NULL,
  `subscriptions_id` bigint UNSIGNED DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `manual_subscriptions__id` int UNSIGNED DEFAULT NULL,
  `credit_transactions__id` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `username` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint UNSIGNED NOT NULL,
  `remember_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile_number` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Make unique with country phone code',
  `timezone` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `registered_via` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Social account',
  `ban_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `countries__id` smallint UNSIGNED DEFAULT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci,
  `two_factor_confirmed_at` datetime DEFAULT NULL,
  `email_verified_at` datetime DEFAULT NULL,
  `user_roles__id` tinyint UNSIGNED NOT NULL,
  `vendors__id` int UNSIGNED DEFAULT NULL,
  `__data` json DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_devices`
--

CREATE TABLE `user_devices` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `device_token` varchar(255) DEFAULT NULL,
  `device_id` varchar(100) DEFAULT NULL,
  `device_type` varchar(20) DEFAULT NULL,
  `fcm_token` varchar(255) DEFAULT NULL,
  `users__id` int UNSIGNED NOT NULL,
  `vendors__id` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `_id` tinyint UNSIGNED NOT NULL,
  `_uid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_settings`
--

CREATE TABLE `user_settings` (
  `_id` int UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `key_name` varchar(100) NOT NULL,
  `value` text,
  `data_type` tinyint DEFAULT NULL,
  `users__id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `ban_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` tinyint UNSIGNED DEFAULT NULL COMMENT 'Restaurent',
  `stripe_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `pm_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pm_last_four` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `domain` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `favicon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `__data` json DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vendor_notifications`
--

CREATE TABLE `vendor_notifications` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `type` varchar(45) NOT NULL,
  `read_at` datetime DEFAULT NULL,
  `__data` json DEFAULT NULL,
  `vendors__id` int UNSIGNED NOT NULL,
  `users__id` int UNSIGNED DEFAULT NULL,
  `scheduled_at` datetime DEFAULT NULL,
  `expiry_at` datetime DEFAULT NULL,
  `via` varchar(45) DEFAULT NULL,
  `message` varchar(1000) DEFAULT NULL,
  `action` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `vendor_settings`
--

CREATE TABLE `vendor_settings` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `vendors__id` int UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `data_type` tinyint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vendor_users`
--

CREATE TABLE `vendor_users` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `vendors__id` int UNSIGNED NOT NULL,
  `users__id` int UNSIGNED NOT NULL,
  `__data` json DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `whatsapp_calls`
--

CREATE TABLE `whatsapp_calls` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) NOT NULL,
  `status` varchar(15) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `contacts__id` int UNSIGNED NOT NULL,
  `wacid` varchar(255) DEFAULT NULL,
  `call_direction` varchar(25) DEFAULT NULL,
  `started_at` datetime DEFAULT NULL,
  `ended_at` datetime DEFAULT NULL,
  `wa_call_duration` int UNSIGNED DEFAULT NULL,
  `by_users__id` int UNSIGNED DEFAULT NULL,
  `user_action` varchar(25) DEFAULT NULL,
  `wab_phone_number_id` varchar(45) DEFAULT NULL,
  `contact_wa_id` varchar(45) DEFAULT NULL,
  `__data` json DEFAULT NULL,
  `user_session_id` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `whatsapp_message_logs`
--

CREATE TABLE `whatsapp_message_logs` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `contacts__id` int UNSIGNED DEFAULT NULL,
  `campaigns__id` int UNSIGNED DEFAULT NULL,
  `vendors__id` int UNSIGNED NOT NULL,
  `contact_wa_id` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wamid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wab_phone_number_id` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_incoming_message` tinyint UNSIGNED DEFAULT NULL COMMENT 'Incoming,outgoing',
  `__data` json DEFAULT NULL,
  `messaged_at` datetime DEFAULT NULL,
  `is_forwarded` tinyint(1) DEFAULT NULL,
  `replied_to_whatsapp_message_logs__uid` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `messaged_by_users__id` int UNSIGNED DEFAULT NULL,
  `is_system_message` tinyint DEFAULT NULL,
  `full_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `whatsapp_message_queue`
--

CREATE TABLE `whatsapp_message_queue` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `vendors__id` int UNSIGNED NOT NULL,
  `scheduled_at` datetime DEFAULT NULL,
  `__data` json DEFAULT NULL,
  `phone_with_country_code` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `campaigns__id` int UNSIGNED NOT NULL,
  `contacts__id` int UNSIGNED DEFAULT NULL,
  `retries` tinyint DEFAULT NULL,
  `full_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message_type` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `whatsapp_templates`
--

CREATE TABLE `whatsapp_templates` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `template_name` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `template_id` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `language` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `__data` json DEFAULT NULL,
  `vendors__id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `whatsapp_webhook_queue`
--

CREATE TABLE `whatsapp_webhook_queue` (
  `_id` int UNSIGNED NOT NULL,
  `_uid` char(36) NOT NULL,
  `headers` json DEFAULT NULL,
  `payload` json DEFAULT NULL,
  `status` varchar(15) DEFAULT 'pending',
  `attempted_at` timestamp NULL DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `vendors__id` int UNSIGNED NOT NULL,
  `attempts` tinyint UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`_id`);

--
-- Indexes for table `background_tasks`
--
ALTER TABLE `background_tasks`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_background_tasks_vendors1_idx` (`vendors__id`),
  ADD KEY `idx_background_task_status_attempted_created` (`status`,`attempted_at`,`created_at`);

--
-- Indexes for table `bot_flows`
--
ALTER TABLE `bot_flows`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_bot_flows_vendors1_idx` (`vendors__id`);

--
-- Indexes for table `bot_replies`
--
ALTER TABLE `bot_replies`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_bot_replies_vendors1_idx` (`vendors__id`),
  ADD KEY `fk_bot_replies_bot_flows1_idx` (`bot_flows__id`),
  ADD KEY `fk_bot_replies_bot_replies1_idx` (`bot_replies__id`),
  ADD KEY `idx_reply_trigger` (`reply_trigger`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_reply_trigger_type` (`trigger_type`),
  ADD KEY `idx_priority_index` (`priority_index`),
  ADD KEY `idx_vendor_flow_null` (`vendors__id`,`bot_flows__id`);

--
-- Indexes for table `campaigns`
--
ALTER TABLE `campaigns`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_campaigns_whatsapp_templates1_idx` (`whatsapp_templates__id`),
  ADD KEY `fk_campaigns_users1_idx` (`users__id`),
  ADD KEY `fk_campaigns_vendors1_idx` (`vendors__id`),
  ADD KEY `idx_vendor_campaign_status` (`vendors__id`,`status`),
  ADD KEY `idx_vendor_campaign_status_created` (`vendors__id`,`status`,`created_at`),
  ADD KEY `idx_vendor_campaign_status_scheduled` (`vendors__id`,`status`,`scheduled_at`),
  ADD KEY `idx_vendor_campaign_status_title` (`vendors__id`,`status`,`title`);

--
-- Indexes for table `campaign_groups`
--
ALTER TABLE `campaign_groups`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_campaign_groups_campaigns1_idx` (`campaigns__id`),
  ADD KEY `fk_campaign_groups_contact_groups1_idx` (`contact_groups__id`);

--
-- Indexes for table `configurations`
--
ALTER TABLE `configurations`
  ADD PRIMARY KEY (`_id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_contacts_countries1_idx` (`countries__id`),
  ADD KEY `fk_contacts_vendors1_idx` (`vendors__id`),
  ADD KEY `fk_contacts_users1_idx` (`assigned_users__id`),
  ADD KEY `idx_wa_id` (`wa_id`),
  ADD KEY `idx_wa_id_on_contacts` (`wa_id`),
  ADD KEY `idx_contacts_uid` (`_uid`),
  ADD KEY `idx_contacts_id` (`_id`),
  ADD KEY `idx_vendor_contact_status_created` (`vendors__id`,`status`,`created_at`),
  ADD KEY `idx_vendor_contact_status_wa_id` (`vendors__id`,`status`,`wa_id`),
  ADD KEY `idx_vendor_contact_status` (`vendors__id`,`status`),
  ADD KEY `idx_vendor_contact_wa_id` (`vendors__id`,`wa_id`),
  ADD KEY `idx_vendor_uid` (`vendors__id`,`_uid`),
  ADD KEY `idx_assigned_user` (`assigned_users__id`),
  ADD KEY `idx_username` (`username`),
  ADD KEY `idx_bsuid` (`bsuid`);

--
-- Indexes for table `contact_bot_flow_sessions`
--
ALTER TABLE `contact_bot_flow_sessions`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_contact_bot_flow_sessions_bot_flows1_idx` (`bot_flows__id`),
  ADD KEY `fk_contact_bot_flow_sessions_contacts1_idx` (`contacts__id`),
  ADD KEY `fk_contact_bot_flow_sessions_bot_replies1_idx` (`bot_replies__id`),
  ADD KEY `fk_contact_bot_flow_sessions_whatsapp_message_logs1_idx` (`last_whatsapp_message_logs__id`);

--
-- Indexes for table `contact_custom_fields`
--
ALTER TABLE `contact_custom_fields`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_contact_custom_fields_vendors1_idx` (`vendors__id`);

--
-- Indexes for table `contact_custom_field_values`
--
ALTER TABLE `contact_custom_field_values`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD KEY `fk_contact_custom_field_values_contacts1_idx` (`contacts__id`),
  ADD KEY `fk_contact_custom_field_values_contact_custom_fields1_idx` (`contact_custom_fields__id`);

--
-- Indexes for table `contact_groups`
--
ALTER TABLE `contact_groups`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_groups_vendors1_idx` (`vendors__id`);

--
-- Indexes for table `contact_labels`
--
ALTER TABLE `contact_labels`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_contact_labels_labels1_idx` (`labels__id`),
  ADD KEY `fk_contact_labels_contacts1_idx` (`contacts__id`),
  ADD KEY `idx_contact_labels_map` (`contacts__id`,`labels__id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`_id`);

--
-- Indexes for table `credit_transactions`
--
ALTER TABLE `credit_transactions`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_credit_transactions_vendors1_idx` (`vendors__id`),
  ADD KEY `fk_credit_transactions_whatsapp_message_logs1_idx` (`whatsapp_message_logs__id`),
  ADD KEY `fk_credit_transactions_whatsapp_calls1_idx` (`whatsapp_calls__id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `group_contacts`
--
ALTER TABLE `group_contacts`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_group_contacts_contact_groups1_idx` (`contact_groups__id`),
  ADD KEY `fk_group_contacts_contacts1_idx` (`contacts__id`);

--
-- Indexes for table `info_materials`
--
ALTER TABLE `info_materials`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_info_materials_vendors1_idx` (`vendors__id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `labels`
--
ALTER TABLE `labels`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_labels_vendors1_idx` (`vendors__id`);

--
-- Indexes for table `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`_id`);

--
-- Indexes for table `login_logs`
--
ALTER TABLE `login_logs`
  ADD PRIMARY KEY (`_id`);

--
-- Indexes for table `manual_subscriptions`
--
ALTER TABLE `manual_subscriptions`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD KEY `fk_manual_subscriptions_vendors1_idx` (`vendors__id`),
  ADD KEY `idx_vendor_status_created` (`vendors__id`,`status`,`created_at`);

--
-- Indexes for table `message_labels`
--
ALTER TABLE `message_labels`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_message_labels_labels1_idx` (`labels__id`),
  ADD KEY `fk_message_labels_whatsapp_message_logs1_idx` (`whatsapp_message_logs__id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD UNIQUE KEY `title_UNIQUE` (`title`),
  ADD KEY `fk_pages_vendors1_idx` (`vendors__id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`_id`);

--
-- Indexes for table `response_webhook_actions`
--
ALTER TABLE `response_webhook_actions`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_response_webhook_actions_vendors1_idx` (`vendors__id`),
  ADD KEY `fk_response_webhook_actions_whatsapp_templates1_idx` (`whatsapp_templates__id`);

--
-- Indexes for table `response_webhook_action_logs`
--
ALTER TABLE `response_webhook_action_logs`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_response_webhook_action_logs_response_webhook_actions1_idx` (`response_webhook_actions__id`),
  ADD KEY `fk_response_webhook_action_logs_response_webhook_logs1_idx` (`response_webhook_logs__id`),
  ADD KEY `fk_response_webhook_action_logs_whatsapp_message_logs1_idx` (`whatsapp_message_logs__id`);

--
-- Indexes for table `response_webhook_logs`
--
ALTER TABLE `response_webhook_logs`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD KEY `fk_response_webhook_logs_vendors1_idx` (`vendors__id`),
  ADD KEY `fk_response_webhook_logs_contacts1_idx` (`contacts__id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subscriptions_user_id_stripe_status_index` (`vendor_model__id`,`stripe_status`),
  ADD KEY `stripe_status` (`stripe_status`),
  ADD KEY `vendor_model__id` (`vendor_model__id`);

--
-- Indexes for table `subscription_items`
--
ALTER TABLE `subscription_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `stripe_plan_UNIQUE` (`stripe_price`,`subscription_id`),
  ADD KEY `subscription_items_stripe_id_index` (`stripe_id`),
  ADD KEY `fk_subscription_items_subscriptions1_idx` (`subscription_id`),
  ADD KEY `stripe_id` (`stripe_id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_tickets_contacts1_idx` (`contacts__id`),
  ADD KEY `fk_tickets_vendors1_idx` (`vendors__id`),
  ADD KEY `fk_tickets_vendor_users1_idx` (`vendor_users__id`),
  ADD KEY `fk_tickets_users1_idx` (`assigned_users__id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD UNIQUE KEY `reference_id_UNIQUE` (`reference_id`),
  ADD KEY `fk_transactions_vendors1_idx` (`vendors__id`),
  ADD KEY `fk_transactions_subscriptions1_idx` (`subscriptions_id`),
  ADD KEY `fk_transactions_manual_subscriptions1_idx` (`manual_subscriptions__id`),
  ADD KEY `fk_transactions_credit_transactions1_idx` (`credit_transactions__id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`),
  ADD KEY `fk_users_countries1_idx` (`countries__id`),
  ADD KEY `fk_users_user_roles1_idx` (`user_roles__id`),
  ADD KEY `fk_users_vendors1_idx` (`vendors__id`);

--
-- Indexes for table `user_devices`
--
ALTER TABLE `user_devices`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_user_devices_users1_idx` (`users__id`),
  ADD KEY `fk_user_devices_vendors1_idx` (`vendors__id`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`);

--
-- Indexes for table `user_settings`
--
ALTER TABLE `user_settings`
  ADD PRIMARY KEY (`_id`),
  ADD KEY `name` (`key_name`),
  ADD KEY `fk_user_settings_users1_idx` (`users__id`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `stripe_id` (`stripe_id`);

--
-- Indexes for table `vendor_notifications`
--
ALTER TABLE `vendor_notifications`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_vendor_notifications_vendors1_idx` (`vendors__id`),
  ADD KEY `fk_vendor_notifications_users1_idx` (`users__id`);

--
-- Indexes for table `vendor_settings`
--
ALTER TABLE `vendor_settings`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_vendor_settings_vendors1_idx` (`vendors__id`),
  ADD KEY `idx_vendor_settings_name` (`vendors__id`,`name`);

--
-- Indexes for table `vendor_users`
--
ALTER TABLE `vendor_users`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_vendor_users_vendors1_idx` (`vendors__id`),
  ADD KEY `fk_vendor_users_users1_idx` (`users__id`);

--
-- Indexes for table `whatsapp_calls`
--
ALTER TABLE `whatsapp_calls`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD KEY `fk_whatsapp_calls_users1_idx` (`by_users__id`),
  ADD KEY `fk_whatsapp_calls_contacts1_idx` (`contacts__id`);

--
-- Indexes for table `whatsapp_message_logs`
--
ALTER TABLE `whatsapp_message_logs`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD KEY `fk_whatsapp_message_status_logs_contacts1_idx` (`contacts__id`),
  ADD KEY `fk_whatsapp_message_status_logs_campaigns1_idx` (`campaigns__id`),
  ADD KEY `fk_whatsapp_message_status_logs_vendors1_idx` (`vendors__id`),
  ADD KEY `fk_whatsapp_message_logs_users1_idx` (`messaged_by_users__id`),
  ADD KEY `idx_wamid` (`wamid`),
  ADD KEY `idx_contact_wa_id` (`contact_wa_id`),
  ADD KEY `idx_wab_phone_number_id` (`wab_phone_number_id`),
  ADD KEY `idx_vendor_incoming_contact_status` (`vendors__id`,`is_incoming_message`,`contacts__id`,`status`),
  ADD KEY `idx_messages_contact_incoming` (`contacts__id`,`is_incoming_message`),
  ADD KEY `idx_vendor_system_null` (`vendors__id`,`is_system_message`),
  ADD KEY `idx_logs_contact_msgtime` (`contacts__id`,`messaged_at`),
  ADD KEY `idx_logs_contact_incoming` (`contacts__id`,`is_incoming_message`,`messaged_at`),
  ADD KEY `idx_unread_vendor` (`vendors__id`,`is_incoming_message`,`status`),
  ADD KEY `idx_contact_incoming` (`contacts__id`,`is_incoming_message`,`messaged_at`),
  ADD KEY `idx_vendor_incoming_msgtime` (`vendors__id`,`is_incoming_message`,`messaged_at`),
  ADD KEY `idx_contact_incoming_msgtime` (`contacts__id`,`is_incoming_message`,`messaged_at`),
  ADD KEY `idx_vendor_msgtime` (`vendors__id`,`messaged_at`),
  ADD KEY `idx_whatsapp_message_queue_status` (`campaigns__id`,`status`),
  ADD KEY `idx_vendor_message_log_campaign_status` (`vendors__id`,`campaigns__id`,`status`),
  ADD KEY `idx_vendor_message_log_campaign` (`vendors__id`,`campaigns__id`),
  ADD KEY `idx_vendor_message_log_campaign_msgtime` (`vendors__id`,`campaigns__id`,`messaged_at`),
  ADD KEY `idx_whatsapp_message_log_vendor_status_name` (`vendors__id`,`campaigns__id`,`status`,`full_name`);

--
-- Indexes for table `whatsapp_message_queue`
--
ALTER TABLE `whatsapp_message_queue`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD KEY `fk_whatsapp_message_queue_vendors1_idx` (`vendors__id`),
  ADD KEY `fk_whatsapp_message_queue_campaigns1_idx` (`campaigns__id`),
  ADD KEY `fk_whatsapp_message_queue_contacts1_idx` (`contacts__id`),
  ADD KEY `idx_scheduled_at` (`scheduled_at`),
  ADD KEY `idx_phone_with_country_code` (`phone_with_country_code`),
  ADD KEY `idx_whatsapp_message_queue_status` (`campaigns__id`,`status`),
  ADD KEY `idx_whatsapp_message_queue_status_name` (`campaigns__id`,`status`,`full_name`),
  ADD KEY `idx_whatsapp_message_queue_vendor_status_name` (`vendors__id`,`campaigns__id`,`status`);

--
-- Indexes for table `whatsapp_templates`
--
ALTER TABLE `whatsapp_templates`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid` (`_uid`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_whatsapp_templates_vendors1_idx` (`vendors__id`),
  ADD KEY `idx_template_id` (`template_id`),
  ADD KEY `idx_template_name` (`template_name`),
  ADD KEY `idx_whatsapp_templates_vendor_status` (`vendors__id`,`status`);

--
-- Indexes for table `whatsapp_webhook_queue`
--
ALTER TABLE `whatsapp_webhook_queue`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `_uid_UNIQUE` (`_uid`),
  ADD KEY `fk_whatsapp_webhook_queue_vendors1_idx` (`vendors__id`),
  ADD KEY `idx_webhooks_status_attempted_created` (`status`,`attempted_at`,`created_at`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `background_tasks`
--
ALTER TABLE `background_tasks`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bot_flows`
--
ALTER TABLE `bot_flows`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bot_replies`
--
ALTER TABLE `bot_replies`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `campaigns`
--
ALTER TABLE `campaigns`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `campaign_groups`
--
ALTER TABLE `campaign_groups`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `configurations`
--
ALTER TABLE `configurations`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contact_bot_flow_sessions`
--
ALTER TABLE `contact_bot_flow_sessions`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contact_custom_fields`
--
ALTER TABLE `contact_custom_fields`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contact_custom_field_values`
--
ALTER TABLE `contact_custom_field_values`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contact_groups`
--
ALTER TABLE `contact_groups`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contact_labels`
--
ALTER TABLE `contact_labels`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `credit_transactions`
--
ALTER TABLE `credit_transactions`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `group_contacts`
--
ALTER TABLE `group_contacts`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `info_materials`
--
ALTER TABLE `info_materials`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `labels`
--
ALTER TABLE `labels`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `login_logs`
--
ALTER TABLE `login_logs`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `manual_subscriptions`
--
ALTER TABLE `manual_subscriptions`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `message_labels`
--
ALTER TABLE `message_labels`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `response_webhook_actions`
--
ALTER TABLE `response_webhook_actions`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `response_webhook_action_logs`
--
ALTER TABLE `response_webhook_action_logs`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `response_webhook_logs`
--
ALTER TABLE `response_webhook_logs`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscription_items`
--
ALTER TABLE `subscription_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_devices`
--
ALTER TABLE `user_devices`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `_id` tinyint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_settings`
--
ALTER TABLE `user_settings`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vendor_notifications`
--
ALTER TABLE `vendor_notifications`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vendor_settings`
--
ALTER TABLE `vendor_settings`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vendor_users`
--
ALTER TABLE `vendor_users`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `whatsapp_calls`
--
ALTER TABLE `whatsapp_calls`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `whatsapp_message_logs`
--
ALTER TABLE `whatsapp_message_logs`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `whatsapp_message_queue`
--
ALTER TABLE `whatsapp_message_queue`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `whatsapp_templates`
--
ALTER TABLE `whatsapp_templates`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `whatsapp_webhook_queue`
--
ALTER TABLE `whatsapp_webhook_queue`
  MODIFY `_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `background_tasks`
--
ALTER TABLE `background_tasks`
  ADD CONSTRAINT `fk_background_tasks_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `bot_flows`
--
ALTER TABLE `bot_flows`
  ADD CONSTRAINT `fk_bot_flows_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `bot_replies`
--
ALTER TABLE `bot_replies`
  ADD CONSTRAINT `fk_bot_replies_bot_flows1` FOREIGN KEY (`bot_flows__id`) REFERENCES `bot_flows` (`_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_bot_replies_bot_replies1` FOREIGN KEY (`bot_replies__id`) REFERENCES `bot_replies` (`_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_bot_replies_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `campaigns`
--
ALTER TABLE `campaigns`
  ADD CONSTRAINT `fk_campaigns_users1` FOREIGN KEY (`users__id`) REFERENCES `users` (`_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_campaigns_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_campaigns_whatsapp_templates1` FOREIGN KEY (`whatsapp_templates__id`) REFERENCES `whatsapp_templates` (`_id`) ON DELETE SET NULL;

--
-- Constraints for table `campaign_groups`
--
ALTER TABLE `campaign_groups`
  ADD CONSTRAINT `fk_campaign_groups_campaigns1` FOREIGN KEY (`campaigns__id`) REFERENCES `campaigns` (`_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_campaign_groups_contact_groups1` FOREIGN KEY (`contact_groups__id`) REFERENCES `contact_groups` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `contacts`
--
ALTER TABLE `contacts`
  ADD CONSTRAINT `fk_contacts_countries1` FOREIGN KEY (`countries__id`) REFERENCES `countries` (`_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_contacts_users1` FOREIGN KEY (`assigned_users__id`) REFERENCES `users` (`_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_contacts_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `contact_bot_flow_sessions`
--
ALTER TABLE `contact_bot_flow_sessions`
  ADD CONSTRAINT `fk_contact_bot_flow_sessions_bot_flows1` FOREIGN KEY (`bot_flows__id`) REFERENCES `bot_flows` (`_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_contact_bot_flow_sessions_bot_replies1` FOREIGN KEY (`bot_replies__id`) REFERENCES `bot_replies` (`_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_contact_bot_flow_sessions_contacts1` FOREIGN KEY (`contacts__id`) REFERENCES `contacts` (`_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_contact_bot_flow_sessions_whatsapp_message_logs1` FOREIGN KEY (`last_whatsapp_message_logs__id`) REFERENCES `whatsapp_message_logs` (`_id`) ON DELETE SET NULL;

--
-- Constraints for table `contact_custom_fields`
--
ALTER TABLE `contact_custom_fields`
  ADD CONSTRAINT `fk_contact_custom_fields_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `contact_custom_field_values`
--
ALTER TABLE `contact_custom_field_values`
  ADD CONSTRAINT `fk_contact_custom_field_values_contact_custom_fields1` FOREIGN KEY (`contact_custom_fields__id`) REFERENCES `contact_custom_fields` (`_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_contact_custom_field_values_contacts1` FOREIGN KEY (`contacts__id`) REFERENCES `contacts` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `contact_groups`
--
ALTER TABLE `contact_groups`
  ADD CONSTRAINT `fk_groups_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `contact_labels`
--
ALTER TABLE `contact_labels`
  ADD CONSTRAINT `fk_contact_labels_contacts1` FOREIGN KEY (`contacts__id`) REFERENCES `contacts` (`_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_contact_labels_labels1` FOREIGN KEY (`labels__id`) REFERENCES `labels` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `credit_transactions`
--
ALTER TABLE `credit_transactions`
  ADD CONSTRAINT `fk_credit_transactions_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_credit_transactions_whatsapp_calls1` FOREIGN KEY (`whatsapp_calls__id`) REFERENCES `whatsapp_calls` (`_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_credit_transactions_whatsapp_message_logs1` FOREIGN KEY (`whatsapp_message_logs__id`) REFERENCES `whatsapp_message_logs` (`_id`) ON DELETE SET NULL;

--
-- Constraints for table `group_contacts`
--
ALTER TABLE `group_contacts`
  ADD CONSTRAINT `fk_group_contacts_contact_groups1` FOREIGN KEY (`contact_groups__id`) REFERENCES `contact_groups` (`_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_group_contacts_contacts1` FOREIGN KEY (`contacts__id`) REFERENCES `contacts` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `info_materials`
--
ALTER TABLE `info_materials`
  ADD CONSTRAINT `fk_info_materials_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `labels`
--
ALTER TABLE `labels`
  ADD CONSTRAINT `fk_labels_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `manual_subscriptions`
--
ALTER TABLE `manual_subscriptions`
  ADD CONSTRAINT `fk_manual_subscriptions_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `message_labels`
--
ALTER TABLE `message_labels`
  ADD CONSTRAINT `fk_message_labels_labels1` FOREIGN KEY (`labels__id`) REFERENCES `labels` (`_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_message_labels_whatsapp_message_logs1` FOREIGN KEY (`whatsapp_message_logs__id`) REFERENCES `whatsapp_message_logs` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `pages`
--
ALTER TABLE `pages`
  ADD CONSTRAINT `fk_pages_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `response_webhook_actions`
--
ALTER TABLE `response_webhook_actions`
  ADD CONSTRAINT `fk_response_webhook_actions_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_response_webhook_actions_whatsapp_templates1` FOREIGN KEY (`whatsapp_templates__id`) REFERENCES `whatsapp_templates` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `response_webhook_action_logs`
--
ALTER TABLE `response_webhook_action_logs`
  ADD CONSTRAINT `fk_response_webhook_action_logs_response_webhook_actions1` FOREIGN KEY (`response_webhook_actions__id`) REFERENCES `response_webhook_actions` (`_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_response_webhook_action_logs_response_webhook_logs1` FOREIGN KEY (`response_webhook_logs__id`) REFERENCES `response_webhook_logs` (`_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_response_webhook_action_logs_whatsapp_message_logs1` FOREIGN KEY (`whatsapp_message_logs__id`) REFERENCES `whatsapp_message_logs` (`_id`) ON DELETE SET NULL;

--
-- Constraints for table `response_webhook_logs`
--
ALTER TABLE `response_webhook_logs`
  ADD CONSTRAINT `fk_response_webhook_logs_contacts1` FOREIGN KEY (`contacts__id`) REFERENCES `contacts` (`_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_response_webhook_logs_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `subscription_items`
--
ALTER TABLE `subscription_items`
  ADD CONSTRAINT `fk_subscription_items_subscriptions1` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `fk_tickets_contacts1` FOREIGN KEY (`contacts__id`) REFERENCES `contacts` (`_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_tickets_users1` FOREIGN KEY (`assigned_users__id`) REFERENCES `users` (`_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_tickets_vendor_users1` FOREIGN KEY (`vendor_users__id`) REFERENCES `vendor_users` (`_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_tickets_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `fk_transactions_credit_transactions1` FOREIGN KEY (`credit_transactions__id`) REFERENCES `credit_transactions` (`_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_transactions_manual_subscriptions1` FOREIGN KEY (`manual_subscriptions__id`) REFERENCES `manual_subscriptions` (`_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_transactions_subscriptions1` FOREIGN KEY (`subscriptions_id`) REFERENCES `subscriptions` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_transactions_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE SET NULL;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_countries1` FOREIGN KEY (`countries__id`) REFERENCES `countries` (`_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_users_user_roles1` FOREIGN KEY (`user_roles__id`) REFERENCES `user_roles` (`_id`),
  ADD CONSTRAINT `fk_users_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_devices`
--
ALTER TABLE `user_devices`
  ADD CONSTRAINT `fk_user_devices_users1` FOREIGN KEY (`users__id`) REFERENCES `users` (`_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_user_devices_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_settings`
--
ALTER TABLE `user_settings`
  ADD CONSTRAINT `fk_user_settings_users1` FOREIGN KEY (`users__id`) REFERENCES `users` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `vendor_notifications`
--
ALTER TABLE `vendor_notifications`
  ADD CONSTRAINT `fk_vendor_notifications_users1` FOREIGN KEY (`users__id`) REFERENCES `users` (`_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_vendor_notifications_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `vendor_settings`
--
ALTER TABLE `vendor_settings`
  ADD CONSTRAINT `fk_vendor_settings_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `vendor_users`
--
ALTER TABLE `vendor_users`
  ADD CONSTRAINT `fk_vendor_users_users1` FOREIGN KEY (`users__id`) REFERENCES `users` (`_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_vendor_users_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `whatsapp_calls`
--
ALTER TABLE `whatsapp_calls`
  ADD CONSTRAINT `fk_whatsapp_calls_contacts1` FOREIGN KEY (`contacts__id`) REFERENCES `contacts` (`_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_whatsapp_calls_users1` FOREIGN KEY (`by_users__id`) REFERENCES `users` (`_id`) ON DELETE SET NULL;

--
-- Constraints for table `whatsapp_message_logs`
--
ALTER TABLE `whatsapp_message_logs`
  ADD CONSTRAINT `fk_whatsapp_message_logs_users1` FOREIGN KEY (`messaged_by_users__id`) REFERENCES `users` (`_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_whatsapp_message_status_logs_campaigns1` FOREIGN KEY (`campaigns__id`) REFERENCES `campaigns` (`_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_whatsapp_message_status_logs_contacts1` FOREIGN KEY (`contacts__id`) REFERENCES `contacts` (`_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_whatsapp_message_status_logs_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `whatsapp_message_queue`
--
ALTER TABLE `whatsapp_message_queue`
  ADD CONSTRAINT `fk_whatsapp_message_queue_campaigns1` FOREIGN KEY (`campaigns__id`) REFERENCES `campaigns` (`_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_whatsapp_message_queue_contacts1` FOREIGN KEY (`contacts__id`) REFERENCES `contacts` (`_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_whatsapp_message_queue_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `whatsapp_templates`
--
ALTER TABLE `whatsapp_templates`
  ADD CONSTRAINT `fk_whatsapp_templates_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `whatsapp_webhook_queue`
--
ALTER TABLE `whatsapp_webhook_queue`
  ADD CONSTRAINT `fk_whatsapp_webhook_queue_vendors1` FOREIGN KEY (`vendors__id`) REFERENCES `vendors` (`_id`) ON DELETE CASCADE;
COMMIT;

-- ---------------------------

-- Initial SQL
--
-- Dumping data for table `countries`
-- https://gist.github.com/paulochf/9616f85f3f3904f1c36f

INSERT INTO `countries` (`_id`, `iso_code`, `name_capitalized`, `name`, `iso3_code`, `iso_num_code`, `phone_code`) VALUES
(1, 'AF', 'AFGHANISTAN', 'Afghanistan', 'AFG', 4, 93),
(2, 'AL', 'ALBANIA', 'Albania', 'ALB', 8, 355),
(3, 'DZ', 'ALGERIA', 'Algeria', 'DZA', 12, 213),
(4, 'AS', 'AMERICAN SAMOA', 'American Samoa', 'ASM', 16, 1684),
(5, 'AD', 'ANDORRA', 'Andorra', 'AND', 20, 376),
(6, 'AO', 'ANGOLA', 'Angola', 'AGO', 24, 244),
(7, 'AI', 'ANGUILLA', 'Anguilla', 'AIA', 660, 1264),
(8, 'AQ', 'ANTARCTICA', 'Antarctica', NULL, NULL, 0),
(9, 'AG', 'ANTIGUA AND BARBUDA', 'Antigua and Barbuda', 'ATG', 28, 1268),
(10, 'AR', 'ARGENTINA', 'Argentina', 'ARG', 32, 54),
(11, 'AM', 'ARMENIA', 'Armenia', 'ARM', 51, 374),
(12, 'AW', 'ARUBA', 'Aruba', 'ABW', 533, 297),
(13, 'AU', 'AUSTRALIA', 'Australia', 'AUS', 36, 61),
(14, 'AT', 'AUSTRIA', 'Austria', 'AUT', 40, 43),
(15, 'AZ', 'AZERBAIJAN', 'Azerbaijan', 'AZE', 31, 994),
(16, 'BS', 'BAHAMAS', 'Bahamas', 'BHS', 44, 1242),
(17, 'BH', 'BAHRAIN', 'Bahrain', 'BHR', 48, 973),
(18, 'BD', 'BANGLADESH', 'Bangladesh', 'BGD', 50, 880),
(19, 'BB', 'BARBADOS', 'Barbados', 'BRB', 52, 1246),
(20, 'BY', 'BELARUS', 'Belarus', 'BLR', 112, 375),
(21, 'BE', 'BELGIUM', 'Belgium', 'BEL', 56, 32),
(22, 'BZ', 'BELIZE', 'Belize', 'BLZ', 84, 501),
(23, 'BJ', 'BENIN', 'Benin', 'BEN', 204, 229),
(24, 'BM', 'BERMUDA', 'Bermuda', 'BMU', 60, 1441),
(25, 'BT', 'BHUTAN', 'Bhutan', 'BTN', 64, 975),
(26, 'BO', 'BOLIVIA', 'Bolivia', 'BOL', 68, 591),
(27, 'BA', 'BOSNIA AND HERZEGOVINA', 'Bosnia and Herzegovina', 'BIH', 70, 387),
(28, 'BW', 'BOTSWANA', 'Botswana', 'BWA', 72, 267),
(29, 'BV', 'BOUVET ISLAND', 'Bouvet Island', NULL, NULL, 0),
(30, 'BR', 'BRAZIL', 'Brazil', 'BRA', 76, 55),
(31, 'IO', 'BRITISH INDIAN OCEAN TERRITORY', 'British Indian Ocean Territory', NULL, NULL, 246),
(32, 'BN', 'BRUNEI DARUSSALAM', 'Brunei Darussalam', 'BRN', 96, 673),
(33, 'BG', 'BULGARIA', 'Bulgaria', 'BGR', 100, 359),
(34, 'BF', 'BURKINA FASO', 'Burkina Faso', 'BFA', 854, 226),
(35, 'BI', 'BURUNDI', 'Burundi', 'BDI', 108, 257),
(36, 'KH', 'CAMBODIA', 'Cambodia', 'KHM', 116, 855),
(37, 'CM', 'CAMEROON', 'Cameroon', 'CMR', 120, 237),
(38, 'CA', 'CANADA', 'Canada', 'CAN', 124, 1),
(39, 'CV', 'CAPE VERDE', 'Cape Verde', 'CPV', 132, 238),
(40, 'KY', 'CAYMAN ISLANDS', 'Cayman Islands', 'CYM', 136, 1345),
(41, 'CF', 'CENTRAL AFRICAN REPUBLIC', 'Central African Republic', 'CAF', 140, 236),
(42, 'TD', 'CHAD', 'Chad', 'TCD', 148, 235),
(43, 'CL', 'CHILE', 'Chile', 'CHL', 152, 56),
(44, 'CN', 'CHINA', 'China', 'CHN', 156, 86),
(45, 'CX', 'CHRISTMAS ISLAND', 'Christmas Island', NULL, NULL, 61),
(46, 'CC', 'COCOS (KEELING) ISLANDS', 'Cocos (Keeling) Islands', NULL, NULL, 672),
(47, 'CO', 'COLOMBIA', 'Colombia', 'COL', 170, 57),
(48, 'KM', 'COMOROS', 'Comoros', 'COM', 174, 269),
(49, 'CG', 'CONGO', 'Congo', 'COG', 178, 242),
(50, 'CD', 'CONGO, THE DEMOCRATIC REPUBLIC OF THE', 'Congo, the Democratic Republic of the', 'COD', 180, 243),
(51, 'CK', 'COOK ISLANDS', 'Cook Islands', 'COK', 184, 682),
(52, 'CR', 'COSTA RICA', 'Costa Rica', 'CRI', 188, 506),
(53, 'CI', 'COTE D''IVOIRE', 'Cote D''Ivoire', 'CIV', 384, 225),
(54, 'HR', 'CROATIA', 'Croatia', 'HRV', 191, 385),
(55, 'CU', 'CUBA', 'Cuba', 'CUB', 192, 53),
(56, 'CY', 'CYPRUS', 'Cyprus', 'CYP', 196, 357),
(57, 'CZ', 'CZECH REPUBLIC', 'Czech Republic', 'CZE', 203, 420),
(58, 'DK', 'DENMARK', 'Denmark', 'DNK', 208, 45),
(59, 'DJ', 'DJIBOUTI', 'Djibouti', 'DJI', 262, 253),
(60, 'DM', 'DOMINICA', 'Dominica', 'DMA', 212, 1767),
(61, 'DO', 'DOMINICAN REPUBLIC', 'Dominican Republic', 'DOM', 214, 1809),
(62, 'EC', 'ECUADOR', 'Ecuador', 'ECU', 218, 593),
(63, 'EG', 'EGYPT', 'Egypt', 'EGY', 818, 20),
(64, 'SV', 'EL SALVADOR', 'El Salvador', 'SLV', 222, 503),
(65, 'GQ', 'EQUATORIAL GUINEA', 'Equatorial Guinea', 'GNQ', 226, 240),
(66, 'ER', 'ERITREA', 'Eritrea', 'ERI', 232, 291),
(67, 'EE', 'ESTONIA', 'Estonia', 'EST', 233, 372),
(68, 'ET', 'ETHIOPIA', 'Ethiopia', 'ETH', 231, 251),
(69, 'FK', 'FALKLAND ISLANDS (MALVINAS)', 'Falkland Islands (Malvinas)', 'FLK', 238, 500),
(70, 'FO', 'FAROE ISLANDS', 'Faroe Islands', 'FRO', 234, 298),
(71, 'FJ', 'FIJI', 'Fiji', 'FJI', 242, 679),
(72, 'FI', 'FINLAND', 'Finland', 'FIN', 246, 358),
(73, 'FR', 'FRANCE', 'France', 'FRA', 250, 33),
(74, 'GF', 'FRENCH GUIANA', 'French Guiana', 'GUF', 254, 594),
(75, 'PF', 'FRENCH POLYNESIA', 'French Polynesia', 'PYF', 258, 689),
(76, 'TF', 'FRENCH SOUTHERN TERRITORIES', 'French Southern Territories', NULL, NULL, 0),
(77, 'GA', 'GABON', 'Gabon', 'GAB', 266, 241),
(78, 'GM', 'GAMBIA', 'Gambia', 'GMB', 270, 220),
(79, 'GE', 'GEORGIA', 'Georgia', 'GEO', 268, 995),
(80, 'DE', 'GERMANY', 'Germany', 'DEU', 276, 49),
(81, 'GH', 'GHANA', 'Ghana', 'GHA', 288, 233),
(82, 'GI', 'GIBRALTAR', 'Gibraltar', 'GIB', 292, 350),
(83, 'GR', 'GREECE', 'Greece', 'GRC', 300, 30),
(84, 'GL', 'GREENLAND', 'Greenland', 'GRL', 304, 299),
(85, 'GD', 'GRENADA', 'Grenada', 'GRD', 308, 1473),
(86, 'GP', 'GUADELOUPE', 'Guadeloupe', 'GLP', 312, 590),
(87, 'GU', 'GUAM', 'Guam', 'GUM', 316, 1671),
(88, 'GT', 'GUATEMALA', 'Guatemala', 'GTM', 320, 502),
(89, 'GN', 'GUINEA', 'Guinea', 'GIN', 324, 224),
(90, 'GW', 'GUINEA-BISSAU', 'Guinea-Bissau', 'GNB', 624, 245),
(91, 'GY', 'GUYANA', 'Guyana', 'GUY', 328, 592),
(92, 'HT', 'HAITI', 'Haiti', 'HTI', 332, 509),
(93, 'HM', 'HEARD ISLAND AND MCDONALD ISLANDS', 'Heard Island and Mcdonald Islands', NULL, NULL, 0),
(94, 'VA', 'HOLY SEE (VATICAN CITY STATE)', 'Holy See (Vatican City State)', 'VAT', 336, 39),
(95, 'HN', 'HONDURAS', 'Honduras', 'HND', 340, 504),
(96, 'HK', 'HONG KONG', 'Hong Kong', 'HKG', 344, 852),
(97, 'HU', 'HUNGARY', 'Hungary', 'HUN', 348, 36),
(98, 'IS', 'ICELAND', 'Iceland', 'ISL', 352, 354),
(99, 'IN', 'INDIA', 'India', 'IND', 356, 91),
(100, 'ID', 'INDONESIA', 'Indonesia', 'IDN', 360, 62),
(101, 'IR', 'IRAN, ISLAMIC REPUBLIC OF', 'Iran, Islamic Republic of', 'IRN', 364, 98),
(102, 'IQ', 'IRAQ', 'Iraq', 'IRQ', 368, 964),
(103, 'IE', 'IRELAND', 'Ireland', 'IRL', 372, 353),
(104, 'IL', 'ISRAEL', 'Israel', 'ISR', 376, 972),
(105, 'IT', 'ITALY', 'Italy', 'ITA', 380, 39),
(106, 'JM', 'JAMAICA', 'Jamaica', 'JAM', 388, 1876),
(107, 'JP', 'JAPAN', 'Japan', 'JPN', 392, 81),
(108, 'JO', 'JORDAN', 'Jordan', 'JOR', 400, 962),
(109, 'KZ', 'KAZAKHSTAN', 'Kazakhstan', 'KAZ', 398, 7),
(110, 'KE', 'KENYA', 'Kenya', 'KEN', 404, 254),
(111, 'KI', 'KIRIBATI', 'Kiribati', 'KIR', 296, 686),
(112, 'KP', 'KOREA, DEMOCRATIC PEOPLE''S REPUBLIC OF', 'Korea, Democratic People''s Republic of', 'PRK', 408, 850),
(113, 'KR', 'KOREA, REPUBLIC OF', 'Korea, Republic of', 'KOR', 410, 82),
(114, 'KW', 'KUWAIT', 'Kuwait', 'KWT', 414, 965),
(115, 'KG', 'KYRGYZSTAN', 'Kyrgyzstan', 'KGZ', 417, 996),
(116, 'LA', 'LAO PEOPLE''S DEMOCRATIC REPUBLIC', 'Lao People''s Democratic Republic', 'LAO', 418, 856),
(117, 'LV', 'LATVIA', 'Latvia', 'LVA', 428, 371),
(118, 'LB', 'LEBANON', 'Lebanon', 'LBN', 422, 961),
(119, 'LS', 'LESOTHO', 'Lesotho', 'LSO', 426, 266),
(120, 'LR', 'LIBERIA', 'Liberia', 'LBR', 430, 231),
(121, 'LY', 'LIBYAN ARAB JAMAHIRIYA', 'Libyan Arab Jamahiriya', 'LBY', 434, 218),
(122, 'LI', 'LIECHTENSTEIN', 'Liechtenstein', 'LIE', 438, 423),
(123, 'LT', 'LITHUANIA', 'Lithuania', 'LTU', 440, 370),
(124, 'LU', 'LUXEMBOURG', 'Luxembourg', 'LUX', 442, 352),
(125, 'MO', 'MACAO', 'Macao', 'MAC', 446, 853),
(126, 'MK', 'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF', 'Macedonia, the Former Yugoslav Republic of', 'MKD', 807, 389),
(127, 'MG', 'MADAGASCAR', 'Madagascar', 'MDG', 450, 261),
(128, 'MW', 'MALAWI', 'Malawi', 'MWI', 454, 265),
(129, 'MY', 'MALAYSIA', 'Malaysia', 'MYS', 458, 60),
(130, 'MV', 'MALDIVES', 'Maldives', 'MDV', 462, 960),
(131, 'ML', 'MALI', 'Mali', 'MLI', 466, 223),
(132, 'MT', 'MALTA', 'Malta', 'MLT', 470, 356),
(133, 'MH', 'MARSHALL ISLANDS', 'Marshall Islands', 'MHL', 584, 692),
(134, 'MQ', 'MARTINIQUE', 'Martinique', 'MTQ', 474, 596),
(135, 'MR', 'MAURITANIA', 'Mauritania', 'MRT', 478, 222),
(136, 'MU', 'MAURITIUS', 'Mauritius', 'MUS', 480, 230),
(137, 'YT', 'MAYOTTE', 'Mayotte', NULL, NULL, 269),
(138, 'MX', 'MEXICO', 'Mexico', 'MEX', 484, 52),
(139, 'FM', 'MICRONESIA, FEDERATED STATES OF', 'Micronesia, Federated States of', 'FSM', 583, 691),
(140, 'MD', 'MOLDOVA, REPUBLIC OF', 'Moldova, Republic of', 'MDA', 498, 373),
(141, 'MC', 'MONACO', 'Monaco', 'MCO', 492, 377),
(142, 'MN', 'MONGOLIA', 'Mongolia', 'MNG', 496, 976),
(143, 'MS', 'MONTSERRAT', 'Montserrat', 'MSR', 500, 1664),
(144, 'MA', 'MOROCCO', 'Morocco', 'MAR', 504, 212),
(145, 'MZ', 'MOZAMBIQUE', 'Mozambique', 'MOZ', 508, 258),
(146, 'MM', 'MYANMAR', 'Myanmar', 'MMR', 104, 95),
(147, 'NA', 'NAMIBIA', 'Namibia', 'NAM', 516, 264),
(148, 'NR', 'NAURU', 'Nauru', 'NRU', 520, 674),
(149, 'NP', 'NEPAL', 'Nepal', 'NPL', 524, 977),
(150, 'NL', 'NETHERLANDS', 'Netherlands', 'NLD', 528, 31),
(151, 'AN', 'NETHERLANDS ANTILLES', 'Netherlands Antilles', 'ANT', 530, 599),
(152, 'NC', 'NEW CALEDONIA', 'New Caledonia', 'NCL', 540, 687),
(153, 'NZ', 'NEW ZEALAND', 'New Zealand', 'NZL', 554, 64),
(154, 'NI', 'NICARAGUA', 'Nicaragua', 'NIC', 558, 505),
(155, 'NE', 'NIGER', 'Niger', 'NER', 562, 227),
(156, 'NG', 'NIGERIA', 'Nigeria', 'NGA', 566, 234),
(157, 'NU', 'NIUE', 'Niue', 'NIU', 570, 683),
(158, 'NF', 'NORFOLK ISLAND', 'Norfolk Island', 'NFK', 574, 672),
(159, 'MP', 'NORTHERN MARIANA ISLANDS', 'Northern Mariana Islands', 'MNP', 580, 1670),
(160, 'NO', 'NORWAY', 'Norway', 'NOR', 578, 47),
(161, 'OM', 'OMAN', 'Oman', 'OMN', 512, 968),
(162, 'PK', 'PAKISTAN', 'Pakistan', 'PAK', 586, 92),
(163, 'PW', 'PALAU', 'Palau', 'PLW', 585, 680),
(164, 'PS', 'PALESTINIAN TERRITORY, OCCUPIED', 'Palestinian Territory, Occupied', NULL, NULL, 970),
(165, 'PA', 'PANAMA', 'Panama', 'PAN', 591, 507),
(166, 'PG', 'PAPUA NEW GUINEA', 'Papua New Guinea', 'PNG', 598, 675),
(167, 'PY', 'PARAGUAY', 'Paraguay', 'PRY', 600, 595),
(168, 'PE', 'PERU', 'Peru', 'PER', 604, 51),
(169, 'PH', 'PHILIPPINES', 'Philippines', 'PHL', 608, 63),
(170, 'PN', 'PITCAIRN', 'Pitcairn', 'PCN', 612, 0),
(171, 'PL', 'POLAND', 'Poland', 'POL', 616, 48),
(172, 'PT', 'PORTUGAL', 'Portugal', 'PRT', 620, 351),
(173, 'PR', 'PUERTO RICO', 'Puerto Rico', 'PRI', 630, 1787),
(174, 'QA', 'QATAR', 'Qatar', 'QAT', 634, 974),
(175, 'RE', 'REUNION', 'Reunion', 'REU', 638, 262),
(176, 'RO', 'ROMANIA', 'Romania', 'ROM', 642, 40),
(177, 'RU', 'RUSSIAN FEDERATION', 'Russian Federation', 'RUS', 643, 7),
(178, 'RW', 'RWANDA', 'Rwanda', 'RWA', 646, 250),
(179, 'SH', 'SAINT HELENA', 'Saint Helena', 'SHN', 654, 290),
(180, 'KN', 'SAINT KITTS AND NEVIS', 'Saint Kitts and Nevis', 'KNA', 659, 1869),
(181, 'LC', 'SAINT LUCIA', 'Saint Lucia', 'LCA', 662, 1758),
(182, 'PM', 'SAINT PIERRE AND MIQUELON', 'Saint Pierre and Miquelon', 'SPM', 666, 508),
(183, 'VC', 'SAINT VINCENT AND THE GRENADINES', 'Saint Vincent and the Grenadines', 'VCT', 670, 1784),
(184, 'WS', 'SAMOA', 'Samoa', 'WSM', 882, 684),
(185, 'SM', 'SAN MARINO', 'San Marino', 'SMR', 674, 378),
(186, 'ST', 'SAO TOME AND PRINCIPE', 'Sao Tome and Principe', 'STP', 678, 239),
(187, 'SA', 'SAUDI ARABIA', 'Saudi Arabia', 'SAU', 682, 966),
(188, 'SN', 'SENEGAL', 'Senegal', 'SEN', 686, 221),
-- (189, 'CS', 'SERBIA AND MONTENEGRO', 'Serbia and Montenegro', NULL, NULL, 381), -- see https://gist.github.com/adhipg/1600028#comment-945655
(190, 'SC', 'SEYCHELLES', 'Seychelles', 'SYC', 690, 248),
(191, 'SL', 'SIERRA LEONE', 'Sierra Leone', 'SLE', 694, 232),
(192, 'SG', 'SINGAPORE', 'Singapore', 'SGP', 702, 65),
(193, 'SK', 'SLOVAKIA', 'Slovakia', 'SVK', 703, 421),
(194, 'SI', 'SLOVENIA', 'Slovenia', 'SVN', 705, 386),
(195, 'SB', 'SOLOMON ISLANDS', 'Solomon Islands', 'SLB', 90, 677),
(196, 'SO', 'SOMALIA', 'Somalia', 'SOM', 706, 252),
(197, 'ZA', 'SOUTH AFRICA', 'South Africa', 'ZAF', 710, 27),
(198, 'GS', 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS', 'South Georgia and the South Sandwich Islands', NULL, NULL, 0),
(199, 'ES', 'SPAIN', 'Spain', 'ESP', 724, 34),
(200, 'LK', 'SRI LANKA', 'Sri Lanka', 'LKA', 144, 94),
(201, 'SD', 'SUDAN', 'Sudan', 'SDN', 736, 249),
(202, 'SR', 'SURINAME', 'Suriname', 'SUR', 740, 597),
(203, 'SJ', 'SVALBARD AND JAN MAYEN', 'Svalbard and Jan Mayen', 'SJM', 744, 47),
(204, 'SZ', 'SWAZILAND', 'Swaziland', 'SWZ', 748, 268),
(205, 'SE', 'SWEDEN', 'Sweden', 'SWE', 752, 46),
(206, 'CH', 'SWITZERLAND', 'Switzerland', 'CHE', 756, 41),
(207, 'SY', 'SYRIAN ARAB REPUBLIC', 'Syrian Arab Republic', 'SYR', 760, 963),
(208, 'TW', 'TAIWAN, PROVINCE OF CHINA', 'Taiwan, Province of China', 'TWN', 158, 886),
(209, 'TJ', 'TAJIKISTAN', 'Tajikistan', 'TJK', 762, 992),
(210, 'TZ', 'TANZANIA, UNITED REPUBLIC OF', 'Tanzania, United Republic of', 'TZA', 834, 255),
(211, 'TH', 'THAILAND', 'Thailand', 'THA', 764, 66),
(212, 'TL', 'TIMOR-LESTE', 'Timor-Leste', NULL, NULL, 670),
(213, 'TG', 'TOGO', 'Togo', 'TGO', 768, 228),
(214, 'TK', 'TOKELAU', 'Tokelau', 'TKL', 772, 690),
(215, 'TO', 'TONGA', 'Tonga', 'TON', 776, 676),
(216, 'TT', 'TRINIDAD AND TOBAGO', 'Trinidad and Tobago', 'TTO', 780, 1868),
(217, 'TN', 'TUNISIA', 'Tunisia', 'TUN', 788, 216),
(218, 'TR', 'TURKEY', 'Turkey', 'TUR', 792, 90),
(219, 'TM', 'TURKMENISTAN', 'Turkmenistan', 'TKM', 795, 7370),
(220, 'TC', 'TURKS AND CAICOS ISLANDS', 'Turks and Caicos Islands', 'TCA', 796, 1649),
(221, 'TV', 'TUVALU', 'Tuvalu', 'TUV', 798, 688),
(222, 'UG', 'UGANDA', 'Uganda', 'UGA', 800, 256),
(223, 'UA', 'UKRAINE', 'Ukraine', 'UKR', 804, 380),
(224, 'AE', 'UNITED ARAB EMIRATES', 'United Arab Emirates', 'ARE', 784, 971),
(225, 'GB', 'UNITED KINGDOM', 'United Kingdom', 'GBR', 826, 44),
(226, 'US', 'UNITED STATES', 'United States', 'USA', 840, 1),
(227, 'UM', 'UNITED STATES MINOR OUTLYING ISLANDS', 'United States Minor Outlying Islands', NULL, NULL, 1),
(228, 'UY', 'URUGUAY', 'Uruguay', 'URY', 858, 598),
(229, 'UZ', 'UZBEKISTAN', 'Uzbekistan', 'UZB', 860, 998),
(230, 'VU', 'VANUATU', 'Vanuatu', 'VUT', 548, 678),
(231, 'VE', 'VENEZUELA', 'Venezuela', 'VEN', 862, 58),
(232, 'VN', 'VIET NAM', 'Viet Nam', 'VNM', 704, 84),
(233, 'VG', 'VIRGIN ISLANDS, BRITISH', 'Virgin Islands, British', 'VGB', 92, 1284),
(234, 'VI', 'VIRGIN ISLANDS, U.S.', 'Virgin Islands, U.s.', 'VIR', 850, 1340),
(235, 'WF', 'WALLIS AND FUTUNA', 'Wallis and Futuna', 'WLF', 876, 681),
(236, 'EH', 'WESTERN SAHARA', 'Western Sahara', 'ESH', 732, 212),
(237, 'YE', 'YEMEN', 'Yemen', 'YEM', 887, 967),
(238, 'ZM', 'ZAMBIA', 'Zambia', 'ZMB', 894, 260),
(239, 'ZW', 'ZIMBABWE', 'Zimbabwe', 'ZWE', 716, 263),
(240, 'RS', 'SERBIA', 'Serbia', 'SRB', 688, 381),
(241, 'AP', 'ASIA PACIFIC REGION', 'Asia / Pacific Region', '0', 0, 0),
(242, 'ME', 'MONTENEGRO', 'Montenegro', 'MNE', 499, 382),
(243, 'AX', 'ALAND ISLANDS', 'Aland Islands', 'ALA', 248, 358),
(244, 'BQ', 'BONAIRE, SINT EUSTATIUS AND SABA', 'Bonaire, Sint Eustatius and Saba', 'BES', 535, 599),
(245, 'CW', 'CURACAO', 'Curacao', 'CUW', 531, 599),
(246, 'GG', 'GUERNSEY', 'Guernsey', 'GGY', 831, 44),
(247, 'IM', 'ISLE OF MAN', 'Isle of Man', 'IMN', 833, 44),
(248, 'JE', 'JERSEY', 'Jersey', 'JEY', 832, 44),
(249, 'XK', 'KOSOVO', 'Kosovo', '---', 0, 381),
(250, 'BL', 'SAINT BARTHELEMY', 'Saint Barthelemy', 'BLM', 652, 590),
(251, 'MF', 'SAINT MARTIN', 'Saint Martin', 'MAF', 663, 590),
(252, 'SX', 'SINT MAARTEN', 'Sint Maarten', 'SXM', 534, 1),
(253, 'SS', 'SOUTH SUDAN', 'South Sudan', 'SSD', 728, 211);

INSERT INTO `user_roles` (`_id`, `_uid`, `status`, `created_at`, `updated_at`, `title`) VALUES
(1, '15f21c9f-88bb-4fec-bad4-03eb9d9065f8', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Super Admin'),
(2, '287133c4-2afc-4f65-ab3c-28b0df8a099a', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Vendor Admin'),
(3, '30ee1967-4nfc-4f65-87bb-g2ea0722b178', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Vendor User');
-- superadmin@yourdomain.com / pass-> firstadmin123
INSERT INTO `users` (`_id`, `_uid`, `created_at`, `updated_at`, `username`, `email`, `password`, `status`, `remember_token`, `first_name`, `last_name`, `mobile_number`,`user_roles__id`) VALUES
(1, '50ee1967-7341-4c3a-b071-f2ea0722b179', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'superadmin', 'superadmin@yourdomain.com', '$2y$10$G17OyUEA26E4lKN4dFBn7eChwGRBdW8ik0f3b7cSayCMVFVgKiG.2', 1, 'O4G7hgyto34OhcWQUYM9ULx3kSEMNTrFIsflasaiq0AgfeBWVBxGeK9Kwp', 'Super', 'Administrator', '9999999999',1);