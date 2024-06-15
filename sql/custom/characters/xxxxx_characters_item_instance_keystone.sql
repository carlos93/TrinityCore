CREATE TABLE `item_instance_keystone` (
  `itemGuid` bigint unsigned NOT NULL,
  `level` int unsigned DEFAULT '0',
  `mapId` int unsigned DEFAULT '0',
  `affix1` int unsigned DEFAULT '0',
  `affix2` int unsigned DEFAULT '0',
  `affix3` int unsigned DEFAULT '0',
  `affix4` int unsigned DEFAULT '0',
  PRIMARY KEY (`itemGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
