
CREATE TABLE `mythic_plus_season_tracked_affix` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `KeystoneAffixID` int NOT NULL DEFAULT '0',
  `Unk0` int NOT NULL DEFAULT '0',
  `Unk1` int NOT NULL DEFAULT '0',
  `DisplaySeasonID` int unsigned NOT NULL DEFAULT '0',
  `VerifiedBuild` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`,`VerifiedBuild`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `mythic_plus_season_tracked_map` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `MapChallengeModeID` int NOT NULL DEFAULT '0',
  `DisplaySeasonID` int unsigned NOT NULL DEFAULT '0',
  `VerifiedBuild` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`,`VerifiedBuild`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `display_season` (
  `Name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ID` int unsigned NOT NULL DEFAULT '0',
  `Season` int NOT NULL DEFAULT '0',
  `ExpansionSeason` int NOT NULL DEFAULT '0',
  `Expansion` int NOT NULL DEFAULT '0',
  `Unk` int NOT NULL DEFAULT '0',
  `VerifiedBuild` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`,`VerifiedBuild`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `display_season_locale` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `locale` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Name_lang` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `VerifiedBuild` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`,`locale`,`VerifiedBuild`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci

