-- Get the complete SQL schema from Roundcube's SQL directory
-- https://github.com/roundcube/roundcubemail/blob/master/SQL/mysql.initial.sql
CREATE DATABASE IF NOT EXISTS roundcube;
USE roundcube;

-- Tables structure for roundcube
CREATE TABLE `session` (
  `sess_id` varchar(128) NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `ip` varchar(40) NOT NULL,
  `vars` mediumtext NOT NULL,
  PRIMARY KEY(`sess_id`),
  INDEX `changed_index` (`changed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `users` (
  `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(128) NOT NULL,
  `mail_host` varchar(128) NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `last_login` datetime DEFAULT NULL,
  `failed_login` datetime DEFAULT NULL,
  `failed_login_counter` int(10) UNSIGNED DEFAULT NULL,
  `language` varchar(5),
  `preferences` text,
  PRIMARY KEY(`user_id`),
  UNIQUE INDEX `username` (`username`, `mail_host`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `cache` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `cache_key` varchar(128) NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `data` longtext NOT NULL,
  PRIMARY KEY (`user_id`, `cache_key`),
  CONSTRAINT `user_id_fk_cache` FOREIGN KEY (`user_id`)
    REFERENCES `users`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  INDEX `created_index` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `identities` (
  `identity_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `del` tinyint(1) NOT NULL DEFAULT '0',
  `standard` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL,
  `organization` varchar(128) DEFAULT '',
  `email` varchar(128) NOT NULL,
  `reply-to` varchar(128) NOT NULL DEFAULT '',
  `bcc` varchar(128) NOT NULL DEFAULT '',
  `signature` text,
  `html_signature` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`identity_id`),
  KEY `user_identities_index` (`user_id`, `del`),
  KEY `email_identities_index` (`email`, `del`),
  CONSTRAINT `user_id_fk_identities` FOREIGN KEY (`user_id`)
    REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Grant privileges
GRANT ALL PRIVILEGES ON roundcube.* TO 'roundcube'@'%';
FLUSH PRIVILEGES;