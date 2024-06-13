SET @PATH := 300000; -- to upper circle from leymor
DELETE FROM waypoint_path WHERE PathId=@PATH;
INSERT INTO waypoint_path (PathId, MoveType, Flags, Velocity, Comment) values
(@PATH, 0, 2, 45.65, '');

DELETE FROM `waypoint_path_node` WHERE `PathId`= @PATH;
INSERT INTO `waypoint_path_node` (`PathId`, `NodeId`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `Delay`) VALUES
(@PATH, 0, -5303.675, 1191.017, 515.0979, NULL, 0),
(@PATH, 1, -5311.243, 1167.688, 522.0624, NULL, 0),
(@PATH, 2, -5312.632, 1139.788, 519.5894, NULL, 0),
(@PATH, 3, -5312.578, 1119.781, 509.1239, NULL, 0);

SET @PATH := 300001; -- to leymor from upper circle
DELETE FROM waypoint_path WHERE PathId=@PATH;
INSERT INTO waypoint_path (PathId, MoveType, Flags, Velocity, Comment) values
(@PATH, 0, 2, 45.65, '');

DELETE FROM `waypoint_path_node` WHERE `PathId`= @PATH;
INSERT INTO `waypoint_path_node` (`PathId`, `NodeId`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `Delay`) VALUES
(@PATH, 0, -5322.533, 1119.882, 512.3572, NULL, 0),
(@PATH, 1, -5326.781, 1141.517, 519.5305, NULL, 0),
(@PATH, 2, -5315.809, 1183.736, 523.4305, NULL, 0),
(@PATH, 3, -5301.603, 1198.823, 511.4492, NULL, 0);

SET @PATH := 300002; -- to middle circle from upper circle
DELETE FROM waypoint_path WHERE PathId=@PATH;
INSERT INTO waypoint_path (PathId, MoveType, Flags, Velocity, Comment) values
(@PATH, 0, 2, 45.65, '');

DELETE FROM `waypoint_path_node` WHERE `PathId`= @PATH;
INSERT INTO `waypoint_path_node` (`PathId`, `NodeId`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `Delay`) VALUES
(@PATH, 0, -5337.512, 1067.356, 508.031, NULL, 0),
(@PATH, 1, -5337.417, 1087.458, 488.2892, NULL, 0),
(@PATH, 2, -5319.34, 1089.396, 467.1379, NULL, 0),
(@PATH, 3, -5300.668, 1069.139, 448.1908, NULL, 0),
(@PATH, 4, -5310.837, 1042.021, 441.6145, NULL, 0),
(@PATH, 5, -5351.056, 1030.379, 437.0534, NULL, 0),
(@PATH, 6, -5377.075, 1059.234, 435.6519, NULL, 0),
(@PATH, 7, -5363.795, 1107.017, 428.5247, NULL, 0),
(@PATH, 8, -5345.809, 1120.313, 425.1651, NULL, 0);

SET @PATH := 300003; -- to azureblade from middle circle
DELETE FROM waypoint_path WHERE PathId=@PATH;
INSERT INTO waypoint_path (PathId, MoveType, Flags, Velocity, Comment) values
(@PATH, 0, 2, 45.65, '');

DELETE FROM `waypoint_path_node` WHERE `PathId`= @PATH;
INSERT INTO `waypoint_path_node` (`PathId`, `NodeId`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `Delay`) VALUES
(@PATH, 0, -5337.212, 1009.464, 430.3666, NULL, 0),
(@PATH, 1, -5344.24, 985.0729, 437.1968, NULL, 0),
(@PATH, 2, -5344.92, 964.0278, 435.7497, NULL, 0),
(@PATH, 3, -5337.542, 947.1614, 427, NULL, 0);

SET @PATH := 300004; -- to middle circle from azurblade
DELETE FROM waypoint_path WHERE PathId=@PATH;
INSERT INTO waypoint_path (PathId, MoveType, Flags, Velocity, Comment) values
(@PATH, 0, 2, 45.65, '');

DELETE FROM `waypoint_path_node` WHERE `PathId`= @PATH;
INSERT INTO `waypoint_path_node` (`PathId`, `NodeId`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `Delay`) VALUES
(@PATH, 0, -5413.002, 991.007, 346.4323, NULL, 0),
(@PATH, 1, -5405.328, 1008.552, 351.4433, NULL, 0),
(@PATH, 2, -5383.427, 1032.146, 348.3228, NULL, 0),
(@PATH, 3, -5366.299, 1040.793, 339.7, NULL, 0);

SET @PATH := 300005; -- to lower circle from azurblade
DELETE FROM waypoint_path WHERE PathId=@PATH;
INSERT INTO waypoint_path (PathId, MoveType, Flags, Velocity, Comment) values
(@PATH, 0, 2, 45.65, '');

DELETE FROM `waypoint_path_node` WHERE `PathId`= @PATH;
INSERT INTO `waypoint_path_node` (`PathId`, `NodeId`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `Delay`) VALUES
(@PATH, 0, -5336.993, 948.4566, 429.1376, NULL, 0),
(@PATH, 1, -5330.257, 961.0573, 431.4612, NULL, 0),
(@PATH, 2, -5326.406, 994.9254, 431.4612, NULL, 0),
(@PATH, 3, -5330.425, 1010.849, 426.6026, NULL, 0);

SET @PATH := 300006; -- to lower circle from azurblade
DELETE FROM waypoint_path WHERE PathId=@PATH;
INSERT INTO waypoint_path (PathId, MoveType, Flags, Velocity, Comment) values
(@PATH, 0, 2, 45.65, '');

DELETE FROM `waypoint_path_node` WHERE `PathId`= @PATH;
INSERT INTO `waypoint_path_node` (`PathId`, `NodeId`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `Delay`) VALUES
(@PATH, 0, -5335.83, 1119.37, 428.2389, NULL, 0),
(@PATH, 1, -5315.545, 1109.233, 439.7271, NULL, 0),
(@PATH, 2, -5303.221, 1085.297, 453.3006, NULL, 0),
(@PATH, 3, -5309.249, 1056.689, 474.4757, NULL, 0),
(@PATH, 4, -5321.346, 1044.543, 494.4757, NULL, 0),
(@PATH, 5, -5336.191, 1041.585, 508.64, NULL, 0),
(@PATH, 6, -5363.764, 1037.634, 521.8915, NULL, 0),
(@PATH, 7, -5385.522, 1047.24, 526.9432, NULL, 0),
(@PATH, 8, -5391.059, 1070.184, 523.4286, NULL, 0),
(@PATH, 9, -5383.469, 1093.771, 516.7332, NULL, 0),
(@PATH, 10, -5363.802, 1116.083, 513.6876, NULL, 0),
(@PATH, 11, -5347.018, 1125.174, 513.6876, NULL, 0),
(@PATH, 12, -5333.781, 1124.347, 509.3958, NULL, 0);

SET @PATH := 300007; -- to umbrelskul from lower circle
DELETE FROM waypoint_path WHERE PathId=@PATH;
INSERT INTO waypoint_path (PathId, MoveType, Flags, Velocity, Comment) values
(@PATH, 0, 2, 24.0, '');

DELETE FROM `waypoint_path_node` WHERE `PathId`= @PATH;
INSERT INTO `waypoint_path_node` (`PathId`, `NodeId`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `Delay`) VALUES
(@PATH, 0, -5336.8, 1068.035, 346.8186, NULL, 0),
(@PATH, 1, -5345.075, 1077.622, 322.0354, NULL, 0),
(@PATH, 2, -5345.397, 1047.828, 263.0053, NULL, 0),
(@PATH, 3, -5327.186, 1048.087, 223.0048, NULL, 0),
(@PATH, 4, -5314.431, 1063.55, 188.2871, NULL, 0),
(@PATH, 5, -5314.915, 1086.517, 176.6236, NULL, 0),
(@PATH, 6, -5327.868, 1112.752, 175.9556, NULL, 0),
(@PATH, 7, -5357.95, 1122.142, 175.9556, NULL, 0),
(@PATH, 8, -5388.054, 1098.184, 175.9556, NULL, 0),
(@PATH, 9, -5393.361, 1043.45, 175.9556, NULL, 0),
(@PATH, 10, -5355.752, 1009.523, 175.9556, NULL, 0),
(@PATH, 11, -5321.333, 1022.658, 162.8439, NULL, 0),
(@PATH, 12, -5329.542, 1044.618, 158, NULL, 0);

SET @PATH := 300008; -- from lower circle to azurblade
DELETE FROM waypoint_path WHERE PathId=@PATH;
INSERT INTO waypoint_path (PathId, MoveType, Flags, Velocity, Comment) values
(@PATH, 0, 2, 48.0, '');

DELETE FROM `waypoint_path_node` WHERE `PathId`= @PATH;
INSERT INTO `waypoint_path_node` (`PathId`, `NodeId`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `Delay`) VALUES
(@PATH, 0, -5376.95, 1030.951, 343.9366, NULL, 0),
(@PATH, 1, -5383.118, 1013.035, 352.6955, NULL, 0),
(@PATH, 2, -5396.878, 996.3368, 355.9787, NULL, 0),
(@PATH, 3, -5414.17, 988.8489, 347.2199, NULL, 0);





