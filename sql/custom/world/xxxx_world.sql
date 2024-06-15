update `creature_template` set `ScriptName` = 'boss_azureblade' where `entry` = 186739;
update `creature_template` set `ScriptName` = 'boss_umbrelskul' where `entry` = 186738;
update `creature_template` set `ScriptName` = 'npc_draconic_image' where `entry` = 190187;
update `creature_template` set `ScriptName` = 'npc_draconic_illusion' where `entry` = 192955;
update `creature_template` set `ScriptName` = 'npc_azure_vault_sindragosa' where `entry` = 187482;
update `creature_template` set `ScriptName` = 'npc_crackling_vortex' where `entry` = 194806;
update `creature_template` set `ScriptName` = 'npc_detonating_crystal' where `entry` = 195138;
update `creature_template` set `ScriptName` = 'npc_detonating_crystal' where `entry` = 199368;
update `creature_template` set `ScriptName` = 'npc_volatile_sapling' where `entry` = 191313;
UPDATE `creature_template` set `ScriptName` = 'npc_book_of_translocation' where `entry` = 194602;
UPDATE `creature_template` set `ScriptName` = 'npc_book_of_translocation' where `entry` = 194618;
UPDATE `creature_template` set `ScriptName` = 'npc_book_of_translocation' where `entry` = 194712;
UPDATE `creature_template` set `ScriptName` = 'npc_book_of_translocation' where `entry` = 194713;
UPDATE `creature_template` set `ScriptName` = 'npc_book_of_translocation' where `entry` = 194714;
UPDATE `creature_template` set `ScriptName` = 'npc_book_of_translocation' where `entry` = 195432;
UPDATE `creature_template` set `ScriptName` = 'npc_book_of_translocation' where `entry` = 195434;
UPDATE `creature_template` set `ScriptName` = 'npc_book_of_translocation' where `entry` = 194715;
UPDATE `creature_template` set `ScriptName` = 'npc_book_of_translocation' where `entry` = 199545;

update `creature_template` set `faction` = 16 where `entry` = 196116;
update `creature_template` set `faction` = 16 where `entry` = 196116;
update `creature_template` set `AIName` = 'PassiveAI' where `entry` = 194826;
update `creature_template` set `AIName` = 'PassiveAI' where `entry` = 194978;
update `creature_template` set `AIName` = 'PassiveAI' where `entry` = 171322;
update `creature_template_addon` set `Auras` = '394104' where `entry` = 186738;


DELETE FROM `scenarios` WHERE (`map`=2515 AND `difficulty` IN (1,2,8,23));
INSERT INTO scenarios (`map`, difficulty, scenario_A, scenario_H) values
(2515, 1, 2089, 2089),
(2515, 2, 2090, 2090),
(2515, 8, 2133, 2133),
(2515, 23, 2091, 2091);

SET @NPCTEXTID = 590113;
DELETE FROM `npc_text` WHERE `ID` BETWEEN @NPCTEXTID+0 AND @NPCTEXTID+1;
INSERT INTO `npc_text` (`ID`, `Probability0`, `Probability1`, `Probability2`, `Probability3`, `Probability4`, `Probability5`, `Probability6`, `Probability7`, `BroadcastTextId0`, `BroadcastTextId1`, `BroadcastTextId2`, `BroadcastTextId3`, `BroadcastTextId4`, `BroadcastTextId5`, `BroadcastTextId6`, `BroadcastTextId7`, `VerifiedBuild`) VALUES
(@NPCTEXTID+1, 1, 0, 0, 0, 0, 0, 0, 0, 233256, 0, 0, 0, 0, 0, 0, 0, 54988), -- 195464
(@NPCTEXTID+0, 1, 0, 0, 0, 0, 0, 0, 0, 226734, 0, 0, 0, 0, 0, 0, 0, 54988); -- 194618

DELETE FROM `creature_template_gossip` where (`CreatureID`=199545 AND `MenuID`=30271) OR (`CreatureID`=195432 AND `MenuID`=29236) OR (`CreatureID`=197081 AND `MenuID`=29759) OR (`CreatureID`=188046 AND `MenuID`=27896) OR (`CreatureID`=194715 AND `MenuID`=29013) OR (`CreatureID`=194714 AND `MenuID`=29012) OR (`CreatureID`=194713 AND `MenuID`=29011) OR (`CreatureID`=194712 AND `MenuID`=29009) OR (`CreatureID`=195434 AND `MenuID`=29237) OR (`CreatureID`=194602 AND `MenuID`=28961) OR (`CreatureID`=194618 AND `MenuID`=28963);
INSERT INTO `creature_template_gossip` (`CreatureID`, `MenuID`, `VerifiedBuild`) VALUES
(199545, 30271, 54988), -- 199545
(195432, 29236, 54988), -- 195432
(197081, 29759, 54988), -- 197081
(188046, 27896, 54988), -- 188046
(194715, 29013, 54988), -- 194715
(194714, 29012, 54988), -- 194714
(194713, 29011, 54988), -- 194713
(194712, 29009, 54988), -- 194712
(195434, 29237, 54988), -- 195434
(194602, 28961, 54988), -- 194602
(194618, 28963, 54988); -- 194618

DELETE FROM `gossip_menu` WHERE (`MenuID`=28963 AND `TextID`=@NPCTEXTID+0) or (`MenuID`=30271 AND `TextID`=@NPCTEXTID+1);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(30271, @NPCTEXTID+1, 54988), -- 195464
(28963, @NPCTEXTID+0, 54988); -- 194618

DELETE FROM `gossip_menu` WHERE (`MenuID`=29236 AND `TextID`=590027) OR (`MenuID`=29759 AND `TextID`=590032) OR (`MenuID`=27896 AND `TextID`=590031) OR (`MenuID`=29237 AND `TextID`=590026);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(29236, 590027, 54988), -- 195432
(29759, 590032, 54988), -- 197081
(27896, 590031, 54988), -- 188046
(29237, 590026, 54988); -- 195434

DELETE FROM `gossip_menu_option` WHERE (`OptionID`=0 AND `MenuID` IN (27896,28963,29237,29236,29011,29009,28961,29759,29013,29012,30271)) OR (`OptionID`=2 AND `MenuID`=29759) OR (`OptionID`=1 AND `MenuID`=29759);
INSERT INTO `gossip_menu_option` (`MenuID`, `GossipOptionID`, `OptionID`, `OptionNpc`, `OptionText`, `OptionBroadcastTextID`, `Language`, `Flags`, `ActionMenuID`, `ActionPoiID`, `GossipNpcOptionID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `SpellID`, `OverrideIconID`, `VerifiedBuild`) VALUES
(29759, 107451, 0, 0, 'Take me to the Arcane Conservatory.', 0, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, NULL, NULL, 54988),
(29759, 107092, 1, 0, 'Take me to the Mausoleum of Legends.', 0, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, NULL, NULL, 54988),
(29759, 107093, 2, 0, 'Take me to the Crystal Chambers.', 0, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, NULL, NULL, 54988),
(27896, 54920, 0, 0, 'I\'m ready.', 0, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, NULL, NULL, 54988),
(28963, 56057, 0, 0, 'Return back.', 0, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, NULL, NULL, 54988),
(29237, 56379, 0, 0, 'Return back.', 0, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, NULL, NULL, 54988),
(29236, 56378, 0, 0, 'Return back.', 0, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, NULL, NULL, 54988),
(29011, 56248, 0, 0, 'Proceed onward.', 0, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, NULL, NULL, 54988),
(29009, 56247, 0, 0, 'Proceed onward.', 0, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, NULL, NULL, 54988),
(28961, 56056, 0, 0, 'Proceed onward.', 0, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, NULL, NULL, 54988),
(29013, 56251, 0, 0, 'Proceed onward.', 0, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, NULL, NULL, 54988),
(29012, 56250, 0, 0, 'Proceed onward.', 0, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, NULL, NULL, 54988),
(30271, 107756, 0, 0, 'Return back.', 0, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, NULL, NULL, 54988);

delete from creature where creature.guid = 9001904;

DELETE FROM jump_charge_params WHERE id=733;
INSERT INTO jump_charge_params (id, speed, treatSpeedAsMoveTimeSeconds, jumpGravity, spellVisualId, progressCurveId, parabolicCurveId) values
(733, 1.001, 1, 55.88, NULL, NULL, NULL);

DELETE FROM `spell_script_names` WHERE (`spell_id` IN (395444, 384106, 384120, 384120, 384347, 384348, 384349, 385983, 390299, 385990, 386526, 384350, 396910, 
387784, 371357, 397726, 375652, 375407, 386746, 385077, 385075, 385037, 384699, 384696, 394082, 379757, 390384, 389792, 389248));
INSERT INTO `spell_script_names` values
(395444, 'spell_azure_vault_viscous_toads'),
(384106, 'spell_azure_vault_translocate'),
(384120, 'spell_azure_vault_translocate'),
(384347, 'spell_azure_vault_translocate'),
(384348, 'spell_azure_vault_translocate'),
(384349, 'spell_azure_vault_translocate'),
(385983, 'spell_azure_vault_translocate'),
(385990, 'spell_azure_vault_translocate'),
(384350, 'spell_azure_vault_translocate'),
(396910, 'spell_azure_vault_translocate'),
(390299, 'spell_azure_vault_wild_magic'),
(386526, 'spell_azure_vault_null_stomp'),
(387784, 'spell_azure_vault_unstable_power'),
(371357, 'spell_azure_vault_forbidden_knowledge'),
(397726, 'spell_azure_vault_shriek'),
(375652, 'spell_azure_vault_wild_eruption'),
(375407, 'spell_azure_vault_ready_defense'),
(386746, 'spell_umbrelskul_brittle'),
(385075, 'spell_umbrelskul_arcane_eruption'),
(385037, 'spell_umbrelskul_arcane_eruption_dummy'),
(385077, 'spell_umbrelskul_arcane_eruption_summon'),
(384699, 'spell_umbrelskul_crystalline_roar'),
(384696, 'spell_umbrelskul_crystalline_roar_dummy'),
(394082, 'spell_umbrelskul_energize'),
(379757, 'spell_azureblade_summon_illusion_ritual'),
(390384, 'spell_azureblade_ancient_orb_fragment'),
(389792, 'spell_azureblade_unstable_magic'),
(389248, 'spell_azureblade_arcane_mana');


DELETE FROM `creature_template_addon` WHERE (`entry` IN (186739, 194602,194618,194712,194713,194714,194715,195432,195434,199545,197081, 195638, 191739, 188100, 187159, 196102, 199368, 195138, 194978, 194806));
INSERT INTO `creature_template_addon` (entry, PathId, mount, MountCreatureID, StandState, AnimTier, VisFlags, SheathState, PvPFlags, emote, aiAnimKit, movementAnimKit, meleeAnimKit, visibilityDistanceType, auras) values
(194602, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '384094'),
(194618, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '384094'),
(194712, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '384094'),
(194713, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '384094'),
(194714, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '384094'),
(194715, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '384094'),
(195432, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '384094'),
(195434, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '384094'),
(199545, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '384094'),
(186739, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '389340 377039'),
(197081, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '389786'),
(191739, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '377980 18950'),
(199368, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '396384 396361'),
(195138, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '386783 431526'),
(196102, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '177645'),
(187159, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '370756'),
(188100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '370756 371042'),
(194978, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '385079'),
(194806, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '385153');


-- Serverside spells
DELETE FROM `serverside_spell` WHERE `Id` IN (399505) AND `DifficultyID`=0;
INSERT INTO `serverside_spell` (`Id`, `DifficultyID`, `CategoryId`, `Dispel`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesEx2`, `AttributesEx3`, `AttributesEx4`, `AttributesEx5`, `AttributesEx6`, `AttributesEx7`, `AttributesEx8`, `AttributesEx9`, `AttributesEx10`, `AttributesEx11`, `AttributesEx12`, `AttributesEx13`, `AttributesEx14`, `Stances`, `StancesNot`, `Targets`, `TargetCreatureType`, `RequiresSpellFocus`, `FacingCasterFlags`, `CasterAuraState`, `TargetAuraState`, `ExcludeCasterAuraState`, `ExcludeTargetAuraState`, `CasterAuraSpell`, `TargetAuraSpell`, `ExcludeCasterAuraSpell`, `ExcludeTargetAuraSpell`, `CasterAuraType`, `TargetAuraType`, `ExcludeCasterAuraType`, `ExcludeTargetAuraType`, `CastingTimeIndex`, `RecoveryTime`, `CategoryRecoveryTime`, `StartRecoveryCategory`, `StartRecoveryTime`, `InterruptFlags`, `AuraInterruptFlags1`, `AuraInterruptFlags2`, `ChannelInterruptFlags1`, `ChannelInterruptFlags2`, `ProcFlags`, `ProcFlags2`, `ProcChance`, `ProcCharges`, `ProcCooldown`, `ProcBasePPM`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `Speed`, `LaunchDelay`, `StackAmount`, `EquippedItemClass`, `EquippedItemSubClassMask`, `EquippedItemInventoryTypeMask`, `ContentTuningId`, `SpellName`, `ConeAngle`, `ConeWidth`, `MaxTargetLevel`, `MaxAffectedTargets`, `SpellFamilyName`, `SpellFamilyFlags1`, `SpellFamilyFlags2`, `SpellFamilyFlags3`, `SpellFamilyFlags4`, `DmgClass`, `PreventionType`, `AreaGroupId`, `SchoolMask`, `ChargeCategoryId`) VALUES
(399505, 0, 0, 0, 0, 0x100, 0x40000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, -1, 0, 0, 0, 'Death Plane Teleport Azure Vault', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);

DELETE FROM `serverside_spell_effect` WHERE `SpellID` IN (399505) AND `EffectIndex`=0 AND `DifficultyID`=0;
INSERT INTO `serverside_spell_effect` (`SpellID`, `EffectIndex`, `DifficultyID`, `Effect`, `EffectAura`, `EffectAmplitude`, `EffectAttributes`, `EffectAuraPeriod`, `EffectBonusCoefficient`, `EffectChainAmplitude`, `EffectChainTargets`, `EffectItemType`, `EffectMechanic`, `EffectPointsPerResource`, `EffectPosFacing`, `EffectRealPointsPerLevel`, `EffectTriggerSpell`, `BonusCoefficientFromAP`, `PvpMultiplier`, `Coefficient`, `Variance`, `ResourceCoefficient`, `GroupSizeBasePointsCoefficient`, `EffectBasePoints`, `EffectMiscValue1`, `EffectMiscValue2`, `EffectRadiusIndex1`, `EffectRadiusIndex2`, `EffectSpellClassMask1`, `EffectSpellClassMask2`, `EffectSpellClassMask3`, `EffectSpellClassMask4`, `ImplicitTarget1`, `ImplicitTarget2`) VALUES
(399505, 0, 0, 252, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 17);

DELETE FROM `spell_target_position` WHERE (`ID` IN (399505, 399506, 385961, 389770, 389773, 393902));
INSERT INTO `spell_target_position` (ID, EffectIndex, MapID, PositionX, PositionY, PositionZ, Orientation, VerifiedBuild) values
(399505, 0, 2515, -5356.37, 1132.26, 425.165, 5.113, 0),
(393902, 0, 2515, -5122.32, 1244.85, 555.54, 5.495169, 0),
(389770, 0, 2515, -5336.83, 793.26, 428, 4.717624, 0),
(389773, 0, 2515, -5358.25, 1030.1, 339.55, 1.05156, 0),
(385961, 0, 2515, -5048.31, 1022.61, 594.22, 2.31430, 0);


DELETE FROM `areatrigger_template` WHERE (`Id` IN (31341, 31342, 31343, 30630, 30543, 30558, 28931, 30145, 30567, 30907, 6197, 28911));
INSERT INTO `areatrigger_template` (`Id`, `IsCustom`, `Flags`, `VerifiedBuild`) values
(31341, 0, 0, 54988),
(31342, 0, 0, 54988),
(31343, 0, 0, 54988),
(30630, 0, 0, 54988),
(30543, 0, 0, 54988),
(30558, 0, 0, 54988),
(28931, 0, 0, 54988),
(30145, 0, 0, 54988),
(30567, 0, 0, 54988),
(30907, 0, 0, 54988),
(6197, 0, 0, 54988),
(28911, 0, 0, 54988);

DELETE FROM `areatrigger_create_properties` WHERE (`Id` in (27266, 27267, 27268, 26445, 25515, 26323, 26343, 25806, 26351, 26773, 26394, 24948, 24966));
INSERT INTO `areatrigger_create_properties` (`Id`, `IsCustom`, `AreaTriggerId`, `IsAreatriggerCustom`, `Flags`, `MoveCurveId`, `ScaleCurveId`, `MorphCurveId`, `FacingCurveId`, `AnimId`, `AnimKitId`, `DecalPropertiesId`, `TimeToTarget`, `TimeToTargetScale`, `Shape`, `ShapeData0`, `ShapeData1`, `ShapeData2`, `ShapeData3`, `ShapeData4`, `ShapeData5`, `ShapeData6`, `ShapeData7`, `ScriptName`, `VerifiedBuild`) VALUES
(27266, 0, 31341, 0, 4, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 10, 10, 0, 0, 0, 0, 0, 0, '', 54988),
(27267, 0, 31342, 0, 4, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 10, 10, 0, 0, 0, 0, 0, 0, '', 54988),
(27268, 0, 31343, 0, 4, 0, 0,     0, 0, -1, 0, 0,   0,    0,     0,  10,  10,  0,  0,  0, 0, 0, 0, '', 54988),
(26445, 0, 30630, 0, 4, 0, 0,     0, 0, -1, 0, 0,   0,    0,     0,  2,   2,   0,  0,  0, 0, 0, 0, 'at_azure_vault_polymorphic_encyclopedia', 54988),
(26323, 0, 30543, 0, 4, 0, 0,     0, 0, -1, 0, 352, 0,    0,     0,  4,   4,   0,  0,  0, 0, 0, 0, '', 54988),
(26343, 0, 30558, 0, 0, 0, 0,     0, 0, -1, 0, 0,   0,    1000,  0,  100, 100, 0,  0,  0, 0, 0, 0, 'at_umbrelskul_unleashed_destruction', 54988),
(25806, 0, 30145, 0, 4, 0, 0,     0, 0, -1, 0, 0,   0,    0,     0,  15,  15,  0,  0,  0, 0, 0, 0, '', 54988),
(25515, 0, 29888, 0, 0, 0, 34322, 0, 0, -1, 0, 85,  0,    15000, 0,  4,   4,   0,  0,  0, 0, 0, 0, '', 54988),
(26351, 0, 30567, 0, 0, 0, 0,     0, 0, -1, 0, 0,   4600, 30000, 4,  2,   2,   10, 10, 3, 3, 0, 0, 'at_azureblade_ancient_orb', 54988),
(26773, 0, 30907, 0, 0, 0, 0,     0, 0, -1, 0, 0,   8000, 8000,  4,  2,   2,   10, 10, 3, 3, 0, 0, 'at_azureblade_ancient_orb', 54988),
(26394, 0, 6197,  0, 2, 0, 41542, 0, 0, -1, 0, 0,   0,    3000,  0,  5,   5,   0,  0,  0, 0, 0, 0, '', 54988),
(24966, 0, 28931, 0, 2, 0, 33391, 0, 0, -1, 0, 0,   0,    0,     0,  8,   8,   0,  0,  0, 0, 0, 0, 'at_azure_vault_revealing_gaze', 54988),
(24948, 0, 28911, 0, 4, 0, 0,     0, 0, -1, 0, 0,   0,    0,     0,  10,  10 , 0,  0,  0, 0, 0, 0, 'at_azure_vault_revealing_gaze', 54988);

DELETE FROM `areatrigger_template_actions` WHERE (`AreaTriggerId` IN (31341, 31342, 31343, 28911, 30543, 30145, 30567, 30907, 6197));
INSERT INTO `areatrigger_template_actions` (`AreaTriggerId`, `IsCustom`, `ActionType`, `ActionParam`, `TargetType`) values
(31341, 0, 0, 395495, 1),
(31342, 0, 0, 395498, 2),
(31343, 0, 0, 395535, 2),
(30543, 0, 0, 385267, 2),
(30145, 0, 0, 378065, 1),
(30567, 0, 0, 385579, 2),
(30907, 0, 0, 390462, 2),
(6197, 0, 0, 385579, 2);

SET @ATID := 68;
SEt @ATCP := 56;
SET @ATIDSPAWN := 70;
-- Areatrigger
DELETE FROM `areatrigger_template` WHERE (`Id` BETWEEN @ATID+0 AND @ATID+8 AND `IsCustom` = 1);
INSERT INTO `areatrigger_template` (`Id`, `IsCustom`, `Flags`, `VerifiedBuild`) VALUES 
(@ATID+8, 1, 1, 0),
(@ATID+7, 1, 1, 0),
(@ATID+6, 1, 1, 0),
(@ATID+5, 1, 1, 0),
(@ATID+4, 1, 1, 0),
(@ATID+3, 1, 1, 0),
(@ATID+2, 1, 1, 0),
(@ATID+1, 1, 1, 0),
(@ATID+0, 1, 1, 0);

DELETE FROM `areatrigger_create_properties` WHERE (`Id`BETWEEN @ATCP+0 AND @ATCP+8 AND `IsCustom`=1);
INSERT INTO `areatrigger_create_properties` (`Id`, `IsCustom`, `AreaTriggerId`, `IsAreatriggerCustom`, `Flags`, `MoveCurveId`, `ScaleCurveId`, `MorphCurveId`, `FacingCurveId`, `AnimId`, `AnimKitId`, `DecalPropertiesId`, `TimeToTarget`, `TimeToTargetScale`, `Shape`, `ShapeData0`, `ShapeData1`, `ShapeData2`, `ShapeData3`, `ShapeData4`, `ShapeData5`, `ShapeData6`, `ShapeData7`, `ScriptName`, `VerifiedBuild`) VALUES 
(@ATCP+8, 1, @ATID+8, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 5, 0, 0, 150, 150, 5, 5, 0, 0, '', 0),
(@ATCP+7, 1, @ATID+7, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 5, 0, 0, 150, 150, 5, 5, 0, 0, '', 0),
(@ATCP+6, 1, @ATID+6, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 10, 10, 0, 0, 0, 10, 0, 0, '', 0),
(@ATCP+5, 1, @ATID+5, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 10, 10, 0, 0, 0, 10, 0, 0, '', 0),
(@ATCP+4, 1, @ATID+4, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 15, 15, 0, 0, 0, 10, 0, 0, '', 0),
(@ATCP+3, 1, @ATID+3, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 15, 15, 0, 0, 0, 10, 0, 0, '', 0),
(@ATCP+2, 1, @ATID+2, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 60, 60, 0, 0, 0, 10, 0, 0, '', 0),
(@ATCP+1, 1, @ATID+1, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 10, 0, 0, '', 0),
(@ATCP+0, 1, @ATID+0, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 10, 0, 0, '', 0);

DELETE FROM `areatrigger` WHERE `SpawnId` BETWEEN @ATIDSPAWN+0 AND @ATIDSPAWN+8;
INSERT INTO `areatrigger` (`SpawnId`, `AreaTriggerCreatePropertiesId`, `IsCustom`, `MapId`, `SpawnDifficulties`, `PosX`, `PosY`, `PosZ`, `Orientation`, `PhaseUseFlags`, `PhaseId`, `PhaseGroup`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES 
(@ATIDSPAWN+8, @ATCP+8, 1, 2515, '1,2,8,23', -5336.3798, 1066.560, 334.308, 4.691, 0, 0, 0, 'at_azure_vault_death_plane_telash', 'Azure Vault - Death Plane', 0),
(@ATIDSPAWN+7, @ATCP+7, 1, 2515, '1,2,8,23', -5337.9199, 1067.6099, 416.638, 4.691, 0, 0, 0, 'at_azure_vault_death_plane_azureblade', 'Azure Vault - Death Plane', 0),
(@ATIDSPAWN+6, @ATCP+6, 1, 2515, '1,2,8,23', -5336.758, 869.201, 427.655, 4.691, 0, 0, 0, 'at_azureblade_before_conversation', 'Azure Vault - Trigger intro Conversation for Sindragosa', 0),
(@ATIDSPAWN+5, @ATCP+5, 1, 2515, '1,2,8,23', -5271.771, 815.047, 388.590, 4.706, 0, 0, 0, 'at_azure_vault_sindragosa_before_telash', 'Azure Vault - Trigger intro Conversation for Sindragosa', 0),
(@ATIDSPAWN+4, @ATCP+4, 1, 2515, '1,2,8,23', -5299.166, 1208.351, 510.4609, 1.282, 0, 0, 0, 'at_azure_vault_sindragosa_books', 'Azure Vault - Trigger intro Conversation for Sindragosa', 0),
(@ATIDSPAWN+3, @ATCP+3, 1, 2515, '1,2,8,23', -5133.652, 1152.7125, 541.6124, 3.037, 0, 0, 0, 'at_azure_vault_sindragosa_wild_magic', 'Azure Vault - Trigger intro Conversation for Sindragosa', 0),
(@ATIDSPAWN+2, @ATCP+2, 1, 2515, '1,2,8,23', -5129.399, 1253.3000, 555.5880, 0.7162, 0, 0, 0, 'at_azure_vault_sindragosa_before_leymor', 'Azure Vault - Trigger intro Conversation for Sindragosa', 0),
(@ATIDSPAWN+1, @ATCP+1, 1, 2515, '1,2,8,23', -5092.632, 1147.622, 594.452, 1.5456, 0, 0, 0, 'at_azure_vault_sindragosa_sundered_flame', 'Azure Vault - Trigger intro Conversation for Sindragosa', 0),
(@ATIDSPAWN+0, @ATCP+0, 1, 2515, '1,2,8,23', -5062.668, 1037.2716, 594.4545, 2.3074, 0, 0, 0, 'at_azure_vault_sindragosa_intro', 'Azure Vault - Trigger intro Conversation for Sindragosa', 0);

-- Conversation
DELETE FROM `conversation_template` WHERE `Id` in (19968, 19964, 19965, 19884, 19885, 19886, 19887, 19888, 19889, 19890, 19963, 19966, 19960, 19961, 18117, 20393, 20394, 19962, 19969);
INSERT INTO `conversation_template` (`Id`, `FirstLineID`, `TextureKitId`, `ScriptName`, `VerifiedBuild`) values
(19964, 51135, 0, 'conversation_azure_vault_sindragosa', 54988),
(19965, 51136, 0, 'conversation_sindragosa_umbrelskul_outro', 54988),
(19968, 51145, 0, '', 54988),
(19884, 50913, 0, '', 54988),
(19885, 50914, 0, '', 54988),
(19886, 50915, 0, '', 54988),
(19887, 50916, 0, '', 54988),
(19888, 50917, 0, '', 54988),
(19889, 50918, 0, '', 54988),
(19890, 50919, 0, '', 54988),
(19963, 51133, 0, 'conversation_azure_vault_sindragosa', 54988),
(19966, 51141, 0, 'conversation_azure_vault_sindragosa_moving', 54988),
(19960, 51127, 0, 'conversation_azure_vault_sindragosa', 54988),
(19961, 51129, 0, 'conversation_azure_vault_sindragosa', 54988),
(18117, 46138, 0, 'conversation_sindragosa_intro', 54988),
(20393, 52628, 0, 'conversation_azure_vault_sindragosa', 54988),
(20394, 52630, 0, 'conversation_azure_vault_sindragosa_and_telash', 54988),
(19962, 51131, 0, 'conversation_azure_vault_sindragosa', 54988),
(19969, 51146, 0, '', 54988);

DELETE FROM `conversation_actors` WHERE `ConversationId` in (19968, 19964, 19965, 19884, 19885, 19886, 19887, 19888, 19889, 19890, 19963, 19966, 19960, 19961, 18117, 20393, 20394, 19962, 19969);
INSERT INTO `conversation_actors` (`ConversationId`, `ConversationActorId`, `ConversationActorGuid`, `Idx`, `CreatureId`, `CreatureDisplayInfoId`, `NoActorObject`, `ActivePlayerObject`, `VerifiedBuild`) VALUES
(19965, 84710, 0, 0, 188046, 0, 0, 0, 54988), -- Full: 0x203CE13A60B65C80001672000064A0CC Creature/0 R3896/S5746 Map: 2515 Entry: 186738 Low: 6594764
(19884, 87746, 9002017, 0, 186738, 0, 0, 0, 54988), -- Full: 0x203CE13A60B65C80001672000064A0CC Creature/0 R3896/S5746 Map: 2515 Entry: 186738 Low: 6594764
(19885, 87746, 9002017, 0, 186738, 0, 0, 0, 54988), -- Full: 0x203CE13A60B65C80001672000064A0CC Creature/0 R3896/S5746 Map: 2515 Entry: 186738 Low: 6594764
(19886, 87746, 9002017, 0, 186738, 0, 0, 0, 54988), -- Full: 0x203CE13A60B65C80001672000064A0CC Creature/0 R3896/S5746 Map: 2515 Entry: 186738 Low: 6594764
(19887, 87746, 9002017, 0, 186738, 0, 0, 0, 54988), -- Full: 0x203CE13A60B65C80001672000064A0CC Creature/0 R3896/S5746 Map: 2515 Entry: 186738 Low: 6594764
(19888, 87746, 9002017, 0, 186738, 0, 0, 0, 54988), -- Full: 0x203CE13A60B65C80001672000064A0CC Creature/0 R3896/S5746 Map: 2515 Entry: 186738 Low: 6594764
(19889, 87746, 9002017, 0, 186738, 0, 0, 0, 54988), -- Full: 0x203CE13A60B65C80001672000064A0CC Creature/0 R3896/S5746 Map: 2515 Entry: 186738 Low: 6594764
(19890, 87746, 9002017, 0, 186738, 0, 0, 0, 54988), -- Full: 0x203CE13A60B65C80001672000064A0CC Creature/0 R3896/S5746 Map: 2515 Entry: 186738 Low: 6594764
(19968, 87746, 9002017, 0, 186738, 0, 0, 0, 54988), -- Full: 0x203CE13A60B65C80001672000064A0CC Creature/0 R3896/S5746 Map: 2515 Entry: 186738 Low: 6594764
(19963, 84710, 0, 0, 187482, 0, 0, 0, 54988), -- Full: 0x0
(19964, 84710, 0, 0, 187482, 0, 0, 0, 54988), -- Full: 0x0
(19966, 84710, 0, 0, 187482, 0, 0, 0, 54988), -- Full: 0x0
(19960, 84710, 0, 0, 187482, 0, 0, 0, 54988), -- Full: 0x0
(19961, 84710, 0, 0, 187482, 0, 0, 0, 54988), -- Full: 0x0
(18117, 84710, 0, 0, 187482, 0, 0, 0, 54988), -- Full: 0x0
(20393, 84710, 0, 0, 187482, 0, 0, 0, 54988), -- Full: 0x0
(20394, 84710, 0, 1, 187482, 0, 0, 0, 54988), -- Full: 0x0
(20394, 89259, 9001930, 0, 199614, 0, 0, 0, 54988), -- Full: 0x0
(19962, 84710, 0, 0, 187482, 0, 0, 0, 54988), -- Full: 0x0
(19969, 87538, 9001975, 0, 186739, 0, 0, 0, 54988); -- Full: 0x203CE13A60B65CC00016720000649C1E Creature/0 R3896/S5746 Map: 2515 Entry: 186739 Low: 6593566

DELETE FROM `conversation_line_template` WHERE `Id` in (51145, 51135, 51136, 51137, 51138, 51139, 51140, 50913, 50914, 50915, 50916, 50917, 50918, 50919, 51133, 51134, 51141, 51142, 51143, 51129, 51127, 51128, 46138, 46139, 52628, 52629, 51126, 52632, 52631, 52630, 51146, 51131, 51132);
INSERT INTO `conversation_line_template` (`Id`, `UiCameraID`, `ActorIdx`, `Flags`, `ChatType`, `VerifiedBuild`) values
(51145, 0, 0, 1, 1, 54988),
(51135, 0, 0, 1, 0, 54988),
(51136, 0, 0, 1, 0, 54988),
(51137, 0, 0, 1, 0, 54988),
(51138, 0, 0, 1, 0, 54988),
(51139, 0, 0, 1, 0, 54988),
(51140, 0, 0, 1, 0, 54988),
(50913, 0, 0, 0, 1, 54988),
(50914, 0, 0, 0, 1, 54988),
(50915, 0, 0, 0, 1, 54988),
(50916, 0, 0, 0, 1, 54988),
(50917, 0, 0, 0, 1, 54988),
(50918, 0, 0, 0, 1, 54988),
(50919, 0, 0, 0, 1, 54988),
(51133, 0, 0, 1, 0, 54988),
(51134, 0, 0, 1, 0, 54988),
(51141, 0, 0, 1, 0, 54988),
(51142, 0, 0, 1, 0, 54988),
(51143, 0, 0, 1, 0, 54988),
(51129, 0, 0, 1, 0, 54988),
(51127, 0, 0, 1, 0, 54988),
(51128, 0, 0, 1, 0, 54988),
(46138, 0, 0, 1, 0, 54988),
(51126, 0, 0, 1, 0, 54988),
(46139, 0, 0, 1, 0, 54988),
(52628, 0, 0, 1, 0, 54988),
(52629, 0, 0, 1, 0, 54988),
(52632, 0, 1, 1, 0, 54988),
(52631, 0, 0, 0, 1, 54988),
(52630, 0, 0, 1, 1, 54988),
(51146, 0, 0, 1, 0, 54988),
(51131, 0, 0, 0, 0, 54988),
(51132, 0, 0, 1, 0, 54988);

DELETE FROM `creature_text` WHERE (`CreatureID` IN (186739));
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(186739, 0, 0, 'No no no! Mine, it is all mine!', 14, 0, 100, 0, 0, 206980, 229360, 0, 'Azureblade'),
(186739, 1, 0, 'Shred you!', 14, 0, 100, 0, 0, 206964, 229366, 0, 'Azureblade'),
(186739, 1, 1, 'Slash you!', 14, 0, 100, 0, 0, 206963, 229365, 0, 'Azureblade'),
(186739, 2, 0, 'My treasures!', 14, 0, 100, 0, 0, 206962, 229368, 0, 'Azureblade'),
(186739, 2, 1, 'My magic!', 14, 0, 100, 0, 0, 206961, 229367, 0, 'Azureblade'),
(186739, 3, 0, 'Me! Take care of them!', 14, 0, 100, 0, 0, 206965, 229369, 0, 'Azureblade'),
(186739, 4, 0, 'All the power... mine, mine, mine!', 14, 0, 100, 0, 0, 206966, 229372, 0, 'Azureblade'),
(186739, 5, 0, 'Azureblade begins casting |cFFFF0000|Hspell:384132|h[Overwhelming Energy]|h|r!', 41, 0, 100, 0, 0, 206966, 0, 0, 'Azureblade'),
(186739, 6, 0, 'But... my... treasures...', 14, 0, 100, 0, 0, 206967, 229364, 0, 'Azureblade to Player');


DELETE FROM `creature_text` WHERE (`CreatureID` IN (186738));
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(186738, 0, 0, 'Mother!', 14, 0, 100, 0, 0, 208111, 229447, 0, 'Umbrelskul to Player'),
(186738, 1, 0, 'My agony is yours!', 14, 0, 100, 0, 0, 208109, 229448, 0, 'Umbrelskul'),
(186738, 2, 0, 'I cannot be contained!', 14, 0, 100, 0, 0, 208108, 229450, 0, 'Umbrelskul'),
(186738, 3, 0, 'Mother... I am... sorry...', 14, 0, 100, 0, 0, 208107, 229451, 0, 'Umbrelskul to Player');

 -- Crystal Fury smart ai
SET @ENTRY := 187160;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, '', 0, 0, 100, 0, 5000, 10000, 15000, 20000, 11, 370764, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Every 15 - 20 seconds (5 - 10s initially) (IC) - Self: Cast spell  370764 on Victim'),
(@ENTRY, 0, 1, 0, '', 0, 0, 100, 0, 15000, 20000, 20000, 30000, 11, 389686, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 20 - 30 seconds (15 - 20s initially) - Self: Cast spell  389686 on Self');

 -- Crystal Fury smart ai
SET @ENTRY := 196116;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, '', 0, 0, 100, 0, 5000, 10000, 15000, 20000, 11, 370764, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Every 15 - 20 seconds (5 - 10s initially) (IC) - Self: Cast spell  370764 on Victim'),
(@ENTRY, 0, 1, 0, '', 0, 0, 100, 0, 15000, 20000, 20000, 30000, 11, 389686, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 20 - 30 seconds (15 - 20s initially) (IC) - Self: Cast spell  389686 on Self');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 196116 AND `SourceId` = 0;

 -- Conjured Lasher smart ai
SET @ENTRY := 196102;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, '', 0, 0, 100, 0, 5000, 10000, 20000, 24000, 11, 387564, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 20 - 24 seconds (5 - 10s initially) (IC) - Self: Cast spell  387564 on Self');


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 196102 AND `SourceId` = 0;

 -- Arcane Tender smart ai
SET @ENTRY := 196115;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, '', 0, 0, 100, 0, 6000, 10000, 18000, 22000, 11, 375596, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 18 - 22 seconds (6 - 10s initially) (IC) - Self: Cast spell  375596 on Self'),
(@ENTRY, 0, 1, 0, '', 0, 0, 100, 0, 10000, 12000, 18000, 22000, 11, 375652, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 18 - 22 seconds (10 - 12s initially) (IC) - Self: Cast spell  375652 on Self');


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 196115 AND `SourceId` = 0;

 -- Shrieking Whelp smart ai
SET @ENTRY := 187159;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 1, '', 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On reset - Self: Set react state to Passive'),
(@ENTRY, 0, 1, 0, '', 61, 0, 100, 0, 0, 0, 0, 0, 11, 370223, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On reset - Self: Cast spell  370223 on Self'),
(@ENTRY, 0, 2, 0, '', 83, 0, 100, 0, 397726, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On spell 397726 cast - Self: Set react state to Aggressive');


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 187159 AND `SourceId` = 0;

 -- Shrieking Whelp smart ai
SET @ENTRY := 188100;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 1, '', 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On reset - Self: Set react state to Passive'),
(@ENTRY, 0, 1, 0, '', 83, 0, 100, 0, 397726, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On spell 397726 cast - Self: Set react state to Aggressive'),
(@ENTRY, 0, 2, 0, '', 1, 0, 100, 0, 0, 0, 20500, 20500, 11, 397215, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 20 seconds (0s initially) (OOC) - Self: Cast spell  397215 on Self');


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 188100 AND `SourceId` = 0;

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceEntry` IN (397726));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `Comment`) VALUES 
(13, 1, 397726, 0, 0, 31, 0, 3, 187160, 0, '', 0, 'Potential target of the spell is creature, entry is Crystal Fury (187160)'),
(13, 1, 397726, 0, 1, 31, 0, 3, 187139, 0, '', 0, 'Potential target of the spell is creature, entry is Crystal Thrasher (187139)');

 -- Crystal Thrasher smart ai
SET @ENTRY := 187139;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, '', 0, 0, 100, 0, 8000, 15000, 30000, 30000, 11, 370766, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 30 - 30 seconds (8 - 15s initially) (IC) - Self: Cast spell  370766 on Self');


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 187139 AND `SourceId` = 0;

 -- Crystal Thrasher smart ai
SET @ENTRY := 196117;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, '', 0, 0, 100, 0, 8000, 15000, 30000, 30000, 11, 370766, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 30 - 30 seconds (8 - 15s initially) (IC) - Self: Cast spell  370766 on Self');


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 187139 AND `SourceId` = 0;

 -- Arcane Elemental smart ai
SET @ENTRY := 186741;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, '', 0, 0, 100, 0, 5000, 10000, 8000, 12000, 11, 386546, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Every 8 - 12 seconds (5 - 10s initially) (IC) - Self: Cast spell  386546 on Random hostile'),
(@ENTRY, 0, 1, 0, '', 0, 0, 100, 0, 5000, 10000, 7500, 12500, 11, 371306, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Every 7.5 - 12.5 seconds (5 - 10s initially) (IC) - Self: Cast spell  371306 on Victim');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 186741 AND `SourceId` = 0;

 -- Unstable Curator smart ai
SET @ENTRY := 187154;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, '', 0, 0, 100, 0, 5000, 10000, 7500, 12500, 11, 389804, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Every 7.5 - 12.5 seconds (5 - 10s initially) (IC) - Self: Cast spell  389804 on Random hostile'),
(@ENTRY, 0, 1, 0, '', 0, 0, 100, 0, 10000, 12000, 25000, 35000, 11, 371358, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 25 - 35 seconds (10 - 12s initially) (IC) - Self: Cast spell  371358 on Self');


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 187154 AND `SourceId` = 0;

 -- Rune Seal Keeper smart ai
SET @ENTRY := 187155;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, '', 0, 0, 100, 0, 5000, 5000, 5000, 10000, 11, 377503, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Every 5 - 10 seconds (5 - 5s initially) (IC) - Self: Cast spell  377503 on Victim'),
(@ENTRY, 0, 1, 0, '', 0, 0, 100, 0, 15000, 20000, 30000, 45000, 11, 377488, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 30 - 45 seconds (15 - 20s initially) (IC) - Self: Cast spell  377488 on Self');


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 187155 AND `SourceId` = 0;

 -- Arcane Construct smart ai
SET @ENTRY := 186740;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, '', 0, 0, 100, 0, 5000, 5000, 7500, 12500, 11, 387067, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Every 7.5 - 12.5 seconds (5 - 5s initially) (IC) - Self: Cast spell  387067 on Victim'),
(@ENTRY, 0, 1, 0, '', 0, 0, 100, 0, 15000, 20000, 25000, 30000, 11, 387122, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 25 - 30 seconds (15 - 20s initially) (IC) - Self: Cast spell  387122 on Self');


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 186740 AND `SourceId` = 0;

 -- Vault Guard smart ai
SET @ENTRY := 190510;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, '', 0, 0, 100, 0, 5000, 5000, 10000, 15000, 11, 374778, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 10 - 15 seconds (0 - 0s initially) (IC) - Self: Cast spell  374778 on Self'),
(@ENTRY, 0, 1, 0, '', 0, 0, 100, 0, 5000, 10000, 10000, 15000, 11, 377105, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Every 10 - 15 seconds (5 - 10s initially) (IC) - Self: Cast spell  377105 on Victim');


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 190510 AND `SourceId` = 0;

 -- Astral Attendant smart ai
SET @ENTRY := 189555;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, '', 0, 0, 100, 0, 5000, 10000, 7500, 12500, 11, 374885, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 7.5 - 12.5 seconds (5 - 10s initially) (IC) - Self: Cast spell  374885 on Self');


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 189555 AND `SourceId` = 0;

 -- Scalebane Lieutenant smart ai
SET @ENTRY := 191739;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, '', 63, 0, 100, 0, 0, 0, 0, 0, 11, 377980, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On just created - Self: Cast spell  377980 on Self'),
(@ENTRY, 0, 1, 0, '', 0, 0, 100, 0, 5000, 5000, 10000, 15000, 11, 374778, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 10 - 15 seconds (5 - 5s initially) (IC) - Self: Cast spell  374778 on Self'),
(@ENTRY, 0, 2, 0, '', 0, 0, 100, 0, 5000, 5000, 5000, 10000, 11, 377105, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Every 5 - 10 seconds (5 - 5s initially) (IC) - Self: Cast spell  377105 on Victim'),
(@ENTRY, 0, 3, 0, '', 0, 0, 100, 0, 5000, 10000, 10000, 15000, 11, 391118, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Every 10 - 15 seconds (5 - 10s initially) (IC) - Self: Cast spell  391118 on Victim');


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 191739 AND `SourceId` = 0;

 -- Drakonid Breaker smart ai
SET @ENTRY := 187240;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, '', 0, 0, 100, 0, 7500, 12500, 10000, 15000, 11, 396991, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 10 - 15 seconds (7.5 - 12.5s initially) (IC) - Self: Cast spell  396991 on Self'),
(@ENTRY, 0, 1, 0, '', 0, 0, 100, 0, 5000, 10000, 10000, 15000, 11, 391136, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Every 10 - 15 seconds (5 - 10s initially) (IC) - Self: Cast spell  391136 on Random hostile');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 187240 AND `SourceId` = 0;

 -- Tarasek Looter smart ai
SET @ENTRY := 187242;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, '', 0, 0, 100, 0, 5000, 10000, 10000, 15000, 11, 386640, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Every 10 - 15 seconds (5 - 10s initially) (IC) - Self: Cast spell  386640 on Victim');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 187242 AND `SourceId` = 0;
 -- Polymorphic Rune smart ai
SET @ENTRY := 195638;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, '', 83, 0, 100, 0, 386368, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On spell 386368 cast - Self: Despawn instantly'),
(@ENTRY, 0, 1, 0, '', 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On reset - Self: Set react state to Passive');


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 195638 AND `SourceId` = 0;

 -- Nullmagic Hornswog smart ai
SET @ENTRY := 187246;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, '', 0, 0, 100, 0, 2500, 5000, 7500, 10000, 11, 386526, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Every 7.5 - 10 seconds (2.5 - 5s initially) (IC) - Self: Cast spell  386526 on Random hostile');


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 187246 AND `SourceId` = 0;

 -- Sindragosa smart ai
SET @ENTRY := 197081;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, '', 62, 0, 100, 0, 29759, 0, 0, 0, 134, 393902, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On gossip action 0 from menu 29759 selected - Gossip player: Cast spell 393902 on Self'),
(@ENTRY, 0, 1, 0, '', 62, 0, 100, 0, 29759, 1, 0, 0, 134, 389770, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On gossip action 1 from menu 29759 selected - Gossip player: Cast spell 389770 on Self'),
(@ENTRY, 0, 2, 0, '', 62, 0, 100, 0, 29759, 2, 0, 0, 134, 389773, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On gossip action 2 from menu 29759 selected - Gossip player: Cast spell 389773 on Self');

DELETE FROM `gossip_menu_option` WHERE `MenuID` = 29759;
INSERT INTO `gossip_menu_option` (`MenuID`, `GossipOptionID`, `OptionID`, `OptionNpc`, `OptionText`, `OptionBroadcastTextID`, `Language`, `Flags`, `ActionMenuID`, `ActionPoiID`, `GossipNpcOptionID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `SpellID`, `OverrideIconID`, `VerifiedBuild`) VALUES
(29759, 107451, 0, 0, 'Take me to the Arcane Conservatory.', 0, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, NULL, NULL, 47213),
(29759, 107092, 1, 0, 'Take me to the Mausoleum of Legends.', 0, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, NULL, NULL, 47213),
(29759, 107093, 2, 0, 'Take me to the Crystal Chambers.', 0, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, NULL, NULL, 47213);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` IN (29759));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `Comment`) VALUES 
(15, 29759, 0, 0, 0, 13, 0, 0, 3, 2, '', 0, 'boss 0 is done'),
(15, 29759, 1, 0, 0, 13, 0, 1, 3, 2, '', 0, 'boss 1 is done'),
(15, 29759, 2, 0, 0, 13, 0, 2, 3, 2, '', 0, 'boss 2 is done');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 197081 AND `SourceId` = 0;

 -- Sindragosa smart ai
SET @ENTRY := 188046;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, '', 62, 0, 100, 0, 27896, 0, 0, 0, 134, 385961, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On gossip action 0 from menu 27896 selected - Gossip player: Cast spell 385961 on Gossip player');


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 188046 AND `SourceId` = 0;


