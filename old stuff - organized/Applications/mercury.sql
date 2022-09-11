# Host: oracle.2question.com/rss
# Database: flash
# Table: 'q_logins'
# 
CREATE TABLE `q_logins` (
  `id_pk` int(11) NOT NULL auto_increment,
  `remote_addr` varchar(100) default '',
  `script_name` text,
  `insert_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `movie` varchar(100) NOT NULL default '',
  `page` varchar(100) NOT NULL default '',
  `remote_host` varchar(100) NOT NULL default '',
  `last_visit` datetime NOT NULL default '0000-00-00 00:00:00',
  `times_visited` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id_pk`)
) TYPE=MyISAM; 

# Host: oracle.2question.com/rss
# Database: flash
# Table: 'rss_channels'
# 
CREATE TABLE `rss_channels` (
  `id_pk` int(11) NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `link` varchar(255) NOT NULL default 'http://',
  `description` text NOT NULL,
  `language` varchar(32) NOT NULL default '',
  `webmaster` varchar(100) NOT NULL default '',
  `lastBuildDate` varchar(100) NOT NULL default '',
  `pubDate` varchar(100) NOT NULL default '',
  `generatorAgent` varchar(100) default '',
  `license` varchar(255) default '',
  `feed_url` varchar(100) NOT NULL default '',
  `image_url` varchar(255) NOT NULL default '',
  `is_default` char(3) NOT NULL default 'N',
  `is_active` varchar(12) NOT NULL default 'Y',
  `creation_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_by` varchar(100) NOT NULL default '',
  `modification_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `modified_by` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`id_pk`)
) TYPE=MyISAM; 

# Host: oracle.2question.com/rss
# Database: flash
# Table: 'rss_news'
# 
CREATE TABLE `rss_news` (
  `id_pk` int(11) NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `description` text NOT NULL,
  `link` varchar(255) NOT NULL default '',
  `creator` varchar(255) NOT NULL default '',
  `publishing_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `copyright` varchar(100) default '',
  `subject` varchar(250) default '',
  PRIMARY KEY  (`id_pk`)
) TYPE=MyISAM; 

# Host: oracle.2question.com/rss
# Database: flash
# Table: 'rss_users'
# 
CREATE TABLE `rss_users` (
  `id_pk` int(11) NOT NULL auto_increment,
  `name` varchar(64) NOT NULL default '',
  `phone` varchar(64) default NULL,
  `email` varchar(64) NOT NULL default '',
  `description` varchar(255) NOT NULL default '',
  `password` varchar(16) NOT NULL default '',
  `status` varchar(32) default NULL,
  `created_by` int(11) NOT NULL default '0',
  `creation_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated_by` int(11) NOT NULL default '0',
  `update_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `is_super_user` char(3) NOT NULL default 'No',
  `language` int(11) NOT NULL default '1',
  `checksum` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`id_pk`)
) TYPE=MyISAM; 

# Host: oracle.2question.com/rss
# Database: flash
# Table: 'rss_users_and_channels'
# 
CREATE TABLE `rss_users_and_channels` (
  `id_pk` int(11) NOT NULL auto_increment,
  `user_fk` int(11) NOT NULL default '0',
  `channel_fk` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id_pk`),
  KEY `user_idx` (`user_fk`),
  KEY `channel_idx` (`channel_fk`)
) TYPE=MyISAM; 

# Host: oracle.2question.com/rss
# Database: flash
# Table: 'rss_weather_locations'
# 
CREATE TABLE `rss_weather_locations` (
  `id_pk` int(11) NOT NULL auto_increment,
  `city` varchar(100) NOT NULL default '',
  `country` varchar(100) NOT NULL default '',
  `url` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`id_pk`)
) TYPE=MyISAM; 

# Host: oracle.2question.com/rss
# Database: flash
# Table: 'rss_weather_reports'
# 
CREATE TABLE `rss_weather_reports` (
  `id_pk` int(11) NOT NULL auto_increment,
  `location_fk` int(11) NOT NULL default '0',
  `impression_1` varchar(100) NOT NULL default '',
  `max_temp_1` varchar(100) NOT NULL default '',
  `min_temp_1` varchar(100) NOT NULL default '',
  `wind_direction_1` varchar(100) NOT NULL default '',
  `wind_speed_1` varchar(100) NOT NULL default '',
  `sunrise_1` varchar(100) NOT NULL default '',
  `sunset_1` varchar(100) NOT NULL default '',
  `pressure_1` varchar(100) NOT NULL default '',
  `visibility_1` varchar(100) NOT NULL default '',
  `humidity_1` varchar(100) NOT NULL default '',
  `impression_2` varchar(100) NOT NULL default '',
  `max_temp_2` varchar(100) NOT NULL default '',
  `min_temp_2` varchar(100) NOT NULL default '',
  `wind_direction_2` varchar(100) NOT NULL default '',
  `wind_speed_2` varchar(100) NOT NULL default '',
  `sunrise_2` varchar(100) NOT NULL default '',
  `sunset_2` varchar(100) NOT NULL default '',
  `pressure_2` varchar(100) NOT NULL default '',
  `visibility_2` varchar(100) NOT NULL default '',
  `humidity_2` varchar(100) NOT NULL default '',
  `impression_3` varchar(100) NOT NULL default '',
  `max_temp_3` varchar(100) NOT NULL default '',
  `min_temp_3` varchar(100) NOT NULL default '',
  `wind_direction_3` varchar(100) NOT NULL default '',
  `wind_speed_3` varchar(100) NOT NULL default '',
  `sunrise_3` varchar(100) NOT NULL default '',
  `sunset_3` varchar(100) NOT NULL default '',
  `pressure_3` varchar(100) NOT NULL default '',
  `visibility_3` varchar(100) NOT NULL default '',
  `humidity_3` varchar(100) NOT NULL default '',
  `impression_4` varchar(100) NOT NULL default '',
  `max_temp_4` varchar(100) NOT NULL default '',
  `min_temp_4` varchar(100) NOT NULL default '',
  `wind_direction_4` varchar(100) NOT NULL default '',
  `wind_speed_4` varchar(100) NOT NULL default '',
  `sunrise_4` varchar(100) NOT NULL default '',
  `sunset_4` varchar(100) NOT NULL default '',
  `pressure_4` varchar(100) NOT NULL default '',
  `visibility_4` varchar(100) NOT NULL default '',
  `humidity_4` varchar(100) NOT NULL default '',
  `impression_5` varchar(100) NOT NULL default '',
  `max_temp_5` varchar(100) NOT NULL default '',
  `min_temp_5` varchar(100) NOT NULL default '',
  `wind_direction_5` varchar(100) NOT NULL default '',
  `wind_speed_5` varchar(100) NOT NULL default '',
  `sunrise_5` varchar(100) NOT NULL default '',
  `sunset_5` varchar(100) NOT NULL default '',
  `pressure_5` varchar(100) NOT NULL default '',
  `visibility_5` varchar(100) NOT NULL default '',
  `humidity_5` varchar(100) NOT NULL default '',
  `creation_date` datetime default NULL,
  PRIMARY KEY  (`id_pk`)
) TYPE=MyISAM; 
