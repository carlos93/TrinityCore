update `creature_template` set `ScriptName` = 'boss_azureblade' where `entry` = 186739;
update `creature_template` set `ScriptName` = 'npc_draconic_image' where `entry` = 190187;
update `creature_template` set `ScriptName` = 'npc_draconic_illusion' where `entry` = 192955;
update `creature_template` set `ScriptName` = 'npc_azure_vault_sindragosa' where `entry` = 187482;
update `creature_template` set `ScriptName` = 'npc_crackling_vortex' where `entry` = 194806;
update `creature_template` set `AIName` = 'PassiveAI' where `entry` = 194826;
update `creature_template` set `AIName` = 'PassiveAI' where `entry` = 194978;
update `creature_template` set `ScriptName` = 'boss_umbrelskul' where `entry` = 186738;
update `creature_template_addon` set `Auras` = '394104' where `entry` = 186738;

DELETE FROM `spell_script_names` WHERE (`spell_id` IN (385077, 385075, 385037, 384699, 384696, 394082, 379757, 390384, 389792, 389248));
INSERT INTO `spell_script_names` values
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

DELETE FROM `creature_template_addon` WHERE (`entry` IN (194978, 194806));
INSERT INTO creature_template_addon (entry, PathId, mount, MountCreatureID, StandState, AnimTier, VisFlags, SheathState, PvPFlags, emote, aiAnimKit, movementAnimKit, meleeAnimKit, visibilityDistanceType, auras) values
(194978, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '385079'),
(194806, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '385153');


DELETE FROM `areatrigger_template` WHERE (`Id` IN (30543, 30558, 28931, 30145, 30567, 30907, 6197, 28911));
INSERT INTO `areatrigger_template` (`Id`, `IsCustom`, `Flags`, `VerifiedBuild`) values
(30543, 0, 0, 54988),
(30558, 0, 0, 54988),
(28931, 0, 0, 54988),
(30145, 0, 0, 54988),
(30567, 0, 0, 54988),
(30907, 0, 0, 54988),
(6197, 0, 0, 54988),
(28911, 0, 0, 54988);

DELETE FROM `areatrigger_create_properties` WHERE (`Id` in (26323, 26343, 25806, 26351, 26773, 26394, 24948, 24966));
INSERT INTO `areatrigger_create_properties` (`Id`, `IsCustom`, `AreaTriggerId`, `IsAreatriggerCustom`, `Flags`, `MoveCurveId`, `ScaleCurveId`, `MorphCurveId`, `FacingCurveId`, `AnimId`, `AnimKitId`, `DecalPropertiesId`, `TimeToTarget`, `TimeToTargetScale`, `Shape`, `ShapeData0`, `ShapeData1`, `ShapeData2`, `ShapeData3`, `ShapeData4`, `ShapeData5`, `ShapeData6`, `ShapeData7`, `ScriptName`, `VerifiedBuild`) VALUES
(26323, 0, 30543, 0, 4, 0, 0, 0, 0, -1, 0, 352, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, '', 54988),
(26343, 0, 30558, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 1000, 0, 100, 100, 0, 0, 0, 0, 0, 0, 'at_umbrelskul_unleashed_destruction', 54988),
(25806, 0, 30145, 0, 4, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 15, 15, 0, 0, 0, 0, 0, 0, '', 54988),
(26351, 0, 30567, 0, 0, 0, 0, 0, 0, -1, 0, 0, 4600, 30000, 4, 2, 2, 10, 10, 3, 3, 0, 0, 'at_azureblade_ancient_orb', 54988),
(26773, 0, 30907, 0, 0, 0, 0, 0, 0, -1, 0, 0, 8000, 8000, 4, 2, 2, 10, 10, 3, 3, 0, 0, 'at_azureblade_ancient_orb', 54988),
(26394, 0, 6197, 0, 2, 0, 41542, 0, 0, -1, 0, 0, 0, 3000, 0, 5, 5, 0, 0, 0, 0, 0, 0, '', 54988),
(24966, 0, 28931, 0, 2, 0, 33391, 0, 0, -1, 0, 0, 0, 0, 0, 8, 8, 0, 0, 0, 0, 0, 0, '', 54988),
(24948, 0, 28911, 0, 4, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 10, 10, 0, 0, 0, 0, 0, 0, '', 54988);

DELETE FROM `areatrigger_template_actions` WHERE (`AreaTriggerId` IN (30543, 30145, 30567, 30907, 6197));
INSERT INTO areatrigger_template_actions (AreaTriggerId, IsCustom, ActionType, ActionParam, TargetType) values
(30543, 0, 0, 385267, 2),
(30145, 0, 0, 378065, 1),
(30567, 0, 0, 385579, 2),
(30907, 0, 0, 390462, 2),
(6197, 0, 0, 385579, 2);

SET @ATID := 68;
SEt @ATCP := 56;
SET @ATIDSPAWN := 70;
-- Areatrigger
DELETE FROM `areatrigger_template` WHERE (`Id` BETWEEN @ATID+0 AND @ATID+6 AND `IsCustom` = 1);
INSERT INTO `areatrigger_template` (`Id`, `IsCustom`, `Flags`, `VerifiedBuild`) VALUES 
(@ATID+6, 1, 1, 0),
(@ATID+5, 1, 1, 0),
(@ATID+4, 1, 1, 0),
(@ATID+3, 1, 1, 0),
(@ATID+2, 1, 1, 0),
(@ATID+1, 1, 1, 0),
(@ATID+0, 1, 1, 0);

DELETE FROM `areatrigger_create_properties` WHERE (`Id`BETWEEN @ATCP+0 AND @ATCP+6 AND `IsCustom`=1);
INSERT INTO `areatrigger_create_properties` (`Id`, `IsCustom`, `AreaTriggerId`, `IsAreatriggerCustom`, `Flags`, `MoveCurveId`, `ScaleCurveId`, `MorphCurveId`, `FacingCurveId`, `AnimId`, `AnimKitId`, `DecalPropertiesId`, `TimeToTarget`, `TimeToTargetScale`, `Shape`, `ShapeData0`, `ShapeData1`, `ShapeData2`, `ShapeData3`, `ShapeData4`, `ShapeData5`, `ShapeData6`, `ShapeData7`, `ScriptName`, `VerifiedBuild`) VALUES 
(@ATCP+6, 1, @ATID+6, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 10, 10, 0, 0, 0, 10, 0, 0, '', 0),
(@ATCP+5, 1, @ATID+5, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 10, 10, 0, 0, 0, 10, 0, 0, '', 0),
(@ATCP+4, 1, @ATID+4, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 15, 15, 0, 0, 0, 10, 0, 0, '', 0),
(@ATCP+3, 1, @ATID+3, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 15, 15, 0, 0, 0, 10, 0, 0, '', 0),
(@ATCP+2, 1, @ATID+2, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 60, 60, 0, 0, 0, 10, 0, 0, '', 0),
(@ATCP+1, 1, @ATID+1, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 10, 0, 0, '', 0),
(@ATCP+0, 1, @ATID+0, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 10, 0, 0, '', 0);

DELETE FROM `areatrigger` WHERE `SpawnId` BETWEEN @ATIDSPAWN+0 AND @ATIDSPAWN+6;
INSERT INTO `areatrigger` (`SpawnId`, `AreaTriggerCreatePropertiesId`, `IsCustom`, `MapId`, `SpawnDifficulties`, `PosX`, `PosY`, `PosZ`, `Orientation`, `PhaseUseFlags`, `PhaseId`, `PhaseGroup`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES 
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
(19965, 51136, 0, 'conversation_azure_vault_sindragosa', 54988),
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
