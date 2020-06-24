; rooms actions and entities data
;

room00_actions:
door40E8:
	doorType DOUBLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget MAIN_HALL_1F, door4136
	playerPosition 976, 64, FACING_EAST

door40F3:
	doorType DOUBLE_DOOR_B, DOOR_BLUE_PAL
	doorTarget MAIN_HALL_1F, door4257
	playerPosition -976, -320, FACING_WEST

door40FE:
	doorType SINGLE_DOOR_C, DOOR_LIGHT_BROWN_PAL
	doorTarget MAIN_HALL_1F, door45D3
	playerPosition -976, 192, FACING_WEST

door4109:
	doorType STAIRS_1_UPWARD
	doorTarget MAIN_HALL_1F, door4895
	playerPosition 0, -64, FACING_SOUTH

	checkAction
	pickItem ROOM00_INK_RIBBON, INK_RIBBON
	playerPosition 264, -64, FACING_SOUTH

	checkOnFloorAction
	pickItem ROOM00_BERRETTA, BERRETTA
	playerPosition -432, -384, FACING_SOUTH

	typewriterAction
	playerPosition 264, -64, FACING_SOUTH

	endRoomActions

room01_actions:
door4136:
	doorType DOUBLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget DINNING_ROOM_1F, door40E8
	playerPosition -912, 0, FACING_WEST

door4141:
	doorType SINGLE_DOOR_A, DOOR_LIGHT_BROWN_PAL
	doorTarget DINNING_ROOM_1F, door42E7
	playerPosition 704, 336, FACING_SOUTH

	roomEntity DINNING_ROOM_CLOCK, DINNING_ROOM_CLOCK_POS1_VARID
	roomEntityPos 80, 336, 128

	roomEntity DINNING_ROOM_CLOCK, DINNING_ROOM_CLOCK_POS2_VARID
	roomEntityPos 216, 336, 128

	checkAction
	pickItem ROOM01_WOODEN_EMBLEM, WOODEN_EMBLEM
	playerPosition 912, 0, FACING_EAST

	checkAction
	pickItem ROOM01_SHIELD_KEY, SHIELD_KEY
	playerPosition 80, 360, FACING_SOUTH

	checkOnFloorAction
	pickItem ROOM01_BLUE_JEWEL, BLUE_JEWEL
	playerPosition 296, -200, FACING_NORTH

	checkAction
	roomInteraction 0
	playerPosition 72, 280, FACING_SOUTH

	checkAction
	roomInteraction 1
	playerPosition 280, -280, FACING_NORTH

	checkAction
	roomInteraction 2
	playerPosition 592, -336, FACING_NORTH

	checkAction
	roomInteraction 3
	playerPosition -160, -336, FACING_NORTH

	checkAction
	roomInteraction 4
	playerPosition -80, 336, FACING_SOUTH

	endRoomActions

room02_actions:
door41BB:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget WEST_STOREROOM, door43C6
	playerPosition -160, 336, FACING_SOUTH

	checkAction
	pickItem ROOM02_SERUM, SERUM
	playerPosition 152, 56, FACING_EAST

	checkAction
	pickItem ROOM02_SWORD_KEY, SWORD_KEY
	playerPosition 32, -88, FACING_NORTH

	typewriterAction
	playerPosition -184, -120, FACING_NORTH

	itemboxAction
	playerPosition 192, 248, FACING_SOUTH

	checkAction
	roomInteraction 0
	playerPosition 152, -64, FACING_EAST

	endRoomActions

room03_actions:
door41FE:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget F_SHAPED_CORRIDOR, door42F2
	playerPosition -832, 960, FACING_SOUTH

door4209:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget F_SHAPED_CORRIDOR, door4563
	playerPosition -880, 304, FACING_WEST

door4214:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget F_SHAPED_CORRIDOR, door46B3
	playerPosition -440, 56, FACING_NORTH

door421F:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget F_SHAPED_CORRIDOR, door43BB
	playerPosition -880, -920, FACING_WEST

door422A:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget F_SHAPED_CORRIDOR, door4340
	playerPosition 792, -392, FACING_WEST

	roomEntity ZOMBIE, 0
	roomEntityPos 216, -776, FACING_NORTH

	roomEntity ZOMBIE, 1
	roomEntityPos -520, -960, FACING_NORTH

	roomEntity ZOMBIE, 2
	roomEntityPos -616, 112, FACING_NORTH

	endRoomActions

room04_actions:
door4257:
	doorType DOUBLE_DOOR_B, DOOR_BLUE_PAL
	doorTarget EXHIBITION_ROOM, door40F3
	playerPosition 0, -528, FACING_NORTH

door4262:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget EXHIBITION_ROOM, door44C7
	playerPosition -224, 552, FACING_SOUTH

	checkAction
	pickItem ROOM04_MAP_1, MAP_1
	playerPosition -24, 120, FACING_NORTH

	checkAction
	pickItem ROOM04_INK_RIBBON, INK_RIBBON
	playerPosition 632, 584, FACING_NORTH

	roomEntity MAP_STEP_LADDER, MAP_STEP_LADDER_VARID
	roomEntityPos 16, 256, FACING_NORTH

	roomEntity ZOMBIE, 3
	roomEntityPos 576, 888, FACING_NORTH

	checkAction
	roomInteraction 0
	playerPosition 8, 552, FACING_SOUTH

	checkAction
	roomInteraction 1
	playerPosition -336, 264, FACING_WEST

	checkAction
	roomInteraction 2
	playerPosition -336, -72, FACING_WEST

	checkAction
	roomInteraction 3
	playerPosition -336, -280, FACING_WEST

	checkAction
	roomInteraction 4
	playerPosition 328, -232, FACING_WEST

	checkAction
	roomInteraction 5
	playerPosition 328, 208, FACING_EAST

	checkAction
	roomInteraction 6
	playerPosition 520, 800, FACING_WEST

	endRoomActions

room05_actions:
door42E7:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget REST_STOP_CORRIDOR, door4141
	playerPosition 512, -48, FACING_NORTH

door42F2:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget REST_STOP_CORRIDOR, door41FE
	playerPosition 32, 56, FACING_SOUTH

door42FD:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget REST_STOP_CORRIDOR, door4399
	playerPosition -920, 56, FACING_SOUTH

door4308:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget REST_STOP_CORRIDOR, door45B1
	playerPosition -976, -24, FACING_WEST

	checkOnFloorAction
	pickItem ROOM05_CLIP1, CLIP
	playerPosition 1024, 232, FACING_SOUTH

	checkOnFloorAction
	pickItem ROOM05_CLIP2, CLIP
	playerPosition 1024, 232, FACING_SOUTH

	roomEntity ZOMBIE, 4
	roomEntityPos 984, 344, FACING_NORTH

	checkAction
	roomInteraction 0
	playerPosition 1104, 344, FACING_EAST

	endRoomActions

room06_actions:
door4340:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget GREENHOUSE, door422A
	playerPosition -520, 272, FACING_WEST

	checkOnFloorAction
	pickItem ROOM06_RED_HERB1, RED_HERB
	playerPosition 168, -152, FACING_EAST

	checkOnFloorAction
	pickItem ROOM06_RED_HERB2, RED_HERB
	playerPosition 168, -152, FACING_EAST

	checkOnFloorAction
	pickItem ROOM06_GREEN_HERB1, GREEN_HERB
	playerPosition -40, -152, FACING_EAST

	checkOnFloorAction
	pickItem ROOM06_GREEN_HERB2, GREEN_HERB
	playerPosition -40, -152, FACING_EAST

	checkOnFloorAction
	pickItem ROOM06_GREEN_HERB3, GREEN_HERB
	playerPosition -40, -152, FACING_EAST

	checkOnFloorAction
	pickItem ROOM06_GREEN_HERB4, GREEN_HERB
	playerPosition -40, -152, FACING_EAST

	checkAction
	pickItem ROOM06_ARMOR_KEY, ARMOR_KEY
	playerPosition 200, 48, FACING_EAST

	endRoomActions

room07_actions:
door4399:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget PIANO_ROOM, door42FD
	playerPosition 464, -520, FACING_EAST

	checkAction
	pickItem ROOM07_SHEET_MUSIC, SHEET_MUSIC
	playerPosition -408, -752, FACING_WEST

	checkAction
	pickItem ROOM07_GOLD_EMBLEM, GOLD_EMBLEM
	playerPosition -1024, 8, FACING_WEST

	endRoomActions

room08_actions:
door43BB:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget WEST_STAIRCASE_1F, door421F
	playerPosition 976, -672, FACING_EAST

door43C6:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget WEST_STAIRCASE_1F, door41BB
	playerPosition 80, 504, FACING_NORTH

door43D1:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget WEST_STAIRCASE_1F, door4409
	playerPosition 792, -504, FACING_SOUTH

door43DC:
	doorType STAIRS_3_UPWARD
	doorTarget WEST_STAIRCASE_1F, door4E38
	playerPosition -264, 880, FACING_EAST

	roomEntity ZOMBIE, 5
	roomEntityPos 552, -592, FACING_NORTH

	roomEntity ZOMBIE, 6
	roomEntityPos -16, -224, FACING_NORTH

	roomEntity ZOMBIE, 7
	roomEntityPos 536, 536, FACING_NORTH

	endRoomActions

room09_actions:
door4409:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget FIREARMS_ROOM, door43D1
	playerPosition 56, 208, FACING_SOUTH

	checkAction
	pickItem ROOM09_BROKEN_SHOTGUN, BROKEN_SHOTGUN
	playerPosition -104, 152, FACING_SOUTH

	checkAction
	pickItem ROOM09_CLIP, CLIP
	playerPosition -208, 152, FACING_SOUTH

	checkAction
	roomInteraction 8
	playerPosition 144, -184, FACING_NORTH

	endRoomActions

room0A_actions:
door4436:
	doorType SINGLE_DOOR_C, DOOR_LIGHT_BROWN_PAL
	doorTarget NORTH_EAST_CORRIDOR_1F, door44D2
	playerPosition -624, 1216, FACING_WEST

door4441:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget NORTH_EAST_CORRIDOR_1F, door4622
	playerPosition -56, 1264, FACING_SOUTH

door444C:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget NORTH_EAST_CORRIDOR_1F, door4600
	playerPosition -24, 736, FACING_EAST

door4457:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget NORTH_EAST_CORRIDOR_1F, door47AA
	playerPosition 48, -280, FACING_SOUTH

door4462:
	doorType DOUBLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget NORTH_EAST_CORRIDOR_1F, door449A
	playerPosition -32, -688, FACING_NORTH

	checkOnFloorAction
	pickItem ROOM0A_GREEN_HERB, GREEN_HERB
	playerPosition -552, 984, FACING_EAST

	endRoomActions

room0B_actions:
door4479:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget BACK_ENTRANCE_CORRIDOR, door5A17
	playerPosition 440, -80, FACING_NORTH

door4484:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget BACK_ENTRANCE_CORRIDOR, door5AEA
	playerPosition 80, 88, FACING_SOUTH

door448F:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget BACK_ENTRANCE_CORRIDOR, door4520
	playerPosition -128, 88, FACING_SOUTH

door449A:
	doorType DOUBLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget BACK_ENTRANCE_CORRIDOR, door4462
	playerPosition -528, 24, FACING_WEST

door44A5:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget BACK_ENTRANCE_CORRIDOR, door4691
	playerPosition 528, 384, FACING_EAST

	roomEntity ZOMBIE, 8
	roomEntityPos -16, -32, FACING_NORTH

	roomEntity ZOMBIE, 9
	roomEntityPos 272, 8, FACING_NORTH

	endRoomActions

room0C_actions:
door44C7:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget L_SHAPED_CORRIDOR, door4262
	playerPosition -592, 488, FACING_WEST

door44D2:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget L_SHAPED_CORRIDOR, door4436
	playerPosition 592, -752, FACING_NORTH

	checkOnFloorAction
	pickItem ROOM0C_CLIP1, CLIP
	playerPosition 376, -48, FACING_SOUTH

	checkOnFloorAction
	pickItem ROOM0C_CLIP2, CLIP
	playerPosition 72, 376, FACING_SOUTH

	roomEntity WOODEN_RACK, WOODEN_RACK_VARID
	roomEntityPos 384, -96, FACING_SOUTH

	checkOnFloorAction
	roomInteraction 0
	playerPosition -376, 456, FACING_NORTH

	checkOnFloorAction
	roomInteraction 1
	playerPosition -112, 456, FACING_NORTH

	checkOnFloorAction
	roomInteraction 2
	playerPosition 272, 456, FACING_NORTH

	endRoomActions

room0D_actions:
door4520:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget EAST_STAIRS_CORRIDOR_1F, door448F
	playerPosition 976, 248, FACING_EAST

door452B:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget EAST_STAIRS_CORRIDOR_1F, door5A86
	playerPosition 200, -288, FACING_EAST

door4536:
	doorType STAIRS_3_UPWARD
	doorTarget EAST_STAIRS_CORRIDOR_1F, door4AAC
	playerPosition -176, 296, FACING_NORTH

	checkOnFloorAction
	pickItem ROOM0D_GREEN_HERB, GREEN_HERB
	playerPosition 16, -136, FACING_EAST

	roomEntity ZOMBIE, 10
	roomEntityPos 480, 280, FACING_NORTH

	checkAction
	roomInteraction 0
	playerPosition 600, 184, FACING_NORTH

	endRoomActions

room0E_actions:
door4563:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget KEEPERS_ROOM, door4209
	playerPosition -240, -208, FACING_NORTH

	checkAction
	pickItem ROOM0E_CLIP, CLIP
	playerPosition -80, 152, FACING_NORTH_EAST

	checkAction
	pickItem ROOM0E_NOTHING_ITEM_1, NOTHING_ITEM_1
	playerPosition 368, -136, FACING_NORTH

	checkOnFloorAction
	pickItem ROOM0E_SHELLS, SHELLS
	playerPosition 320, 208, FACING_SOUTH

	roomEntity ZOMBIE, 11
	roomEntityPos 328, 208, FACING_NORTH

	checkAction
	roomInteraction 0
	playerPosition -216, 152, FACING_SOUTH

	checkAction
	roomInteraction 1
	playerPosition -376, -24, FACING_WEST

	endRoomActions

room0F_actions:
door45B1:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget ELEVATOR_STAIRWAY, door4308
	playerPosition 400, 208, FACING_SOUTH

door45BC:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget ELEVATOR_STAIRWAY, door5B39
	playerPosition -392, 512, FACING_SOUTH

	endRoomActions

room10_actions:
door45C8:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LARGE_ART_ROOM, door4745
	playerPosition -464, -720, FACING_NORTH

door45D3:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LARGE_ART_ROOM, door40FE
	playerPosition 56, 784, FACING_SOUTH

	checkAction
	pickItem ROOM10_CLIP, CLIP
	playerPosition 0, 264, FACING_NORTH

	checkOnFloorAction
	pickItem ROOM10_SHELLS, SHELLS
	playerPosition -464, 72, FACING_SOUTH

	roomEntity ZOMBIE, 12
	roomEntityPos -464, 72, FACING_NORTH

	endRoomActions

room11_actions:
door4600:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget MANSION_BATHROOM, door444C
	playerPosition -288, 336, FACING_SOUTH

	checkAction
	pickItem ROOM11_SMALL_KEY_1, SMALL_KEY_1
	playerPosition -120, 8, FACING_NORTH

	checkOnFloorAction
	roomInteraction 0
	playerPosition 320, 184, FACING_EAST

	endRoomActions

room12_actions:
door4622:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget OUTDOOR_AREA, door4441
	playerPosition -120, -400, FACING_EAST

	checkOnFloorAction
	pickItem ROOM12_GREEN_HERB1, GREEN_HERB
	playerPosition 552, 432, FACING_EAST

	checkOnFloorAction
	pickItem ROOM12_GREEN_HERB2, GREEN_HERB
	playerPosition 552, 432, FACING_EAST

	checkOnFloorAction
	pickItem ROOM12_GREEN_HERB3, GREEN_HERB
	playerPosition 552, 432, FACING_EAST

	checkOnFloorAction
	pickItem ROOM12_RED_HERB1, RED_HERB
	playerPosition 80, 432, FACING_EAST

	checkOnFloorAction
	pickItem ROOM12_RED_HERB2, RED_HERB
	playerPosition 80, 432, FACING_EAST

	checkOnFloorAction
	pickItem ROOM12_RED_HERB3, RED_HERB
	playerPosition 80, 432, FACING_EAST

	roomEntity ZOMBIE, 13
	roomEntityPos -256, 40, FACING_NORTH

	roomEntity ZOMBIE, 14
	roomEntityPos 80, 496, FACING_NORTH

	roomEntity ZOMBIE, 15
	roomEntityPos 304, 560, FACING_NORTH

	endRoomActions

room13_actions:
door4691:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget SHED_PASSAGE, door44A5
	playerPosition -120, 608, FACING_EAST

door469C:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget SHED_PASSAGE, door46EC
	playerPosition 144, -896, FACING_EAST

	checkAction
	roomInteraction 8
	playerPosition 56, -976, FACING_NORTH

	endRoomActions

room14_actions:
door46B3:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget TIGER_STATUE_ROOM, door4214
	playerPosition 112, -48, FACING_EAST

	checkAction
	pickItem ROOM14_WIND_CREST, WIND_CREST
	playerPosition -80, 80, FACING_SOUTH

	checkAction
	pickItem ROOM14_COLT_PYTHON, COLT_PYTHON
	playerPosition 80, 80, FACING_SOUTH

	checkAction
	roomInteraction 8
	playerPosition 0, 80, FACING_SOUTH

	endRoomActions

room15_actions:
door46E0:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget CLOSET_ROOM, door4750
	playerPosition 192, 80, FACING_SOUTH

	endRoomActions

room16_actions:
door46EC:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget SHED_ROOM, door469C
	playerPosition 0, 208, FACING_SOUTH

door46F7:
	doorType DOUBLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget SHED_ROOM, door4E7B
	playerPosition 0, -208, FACING_NORTH

	roomEntity SHED_STEP_LADDER, SHED_STEP_LADDER_VARID
	roomEntityPos 144, 0, FACING_EAST

	checkAction
	pickItem ROOM16_SQUARE_CRANK, SQUARE_CRANK
	playerPosition 208, 64, FACING_EAST

	checkAction
	pickItem ROOM16_SMALL_KEY_2, SMALL_KEY_2
	playerPosition -200, -168, FACING_EAST

	checkAction
	roomInteraction 0
	playerPosition -168, -168, FACING_NORTH_WEST

	checkAction
	roomInteraction 1
	playerPosition 136, -168, FACING_NORTH_EAST

	checkAction
	roomInteraction 2
	playerPosition -168, 208, FACING_WEST

	endRoomActions

room17_actions:
door4745:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget MIRROR_ROOM, door45C8
	playerPosition 336, 272, FACING_EAST

door4750:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget MIRROR_ROOM, door46E0
	playerPosition 304, -336, FACING_NORTH

	checkOnFloorAction
	pickItem ROOM17_GREEN_HERB1, GREEN_HERB
	playerPosition -304, -336, FACING_NORTH

	checkOnFloorAction
	pickItem ROOM17_GREEN_HERB2, GREEN_HERB
	playerPosition -304, -336, FACING_NORTH

	checkAction
	pickItem ROOM17_INK_RIBBON, INK_RIBBON
	playerPosition 200, -176, FACING_EAST

	endRoomActions

room18_actions:
door477D:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LIVING_ROOM, door47B5
	playerPosition 272, -120, FACING_EAST

	checkAction
	pickItem ROOM18_SHOTGUN, SHOTGUN
	playerPosition -8, 272, FACING_SOUTH

	checkAction
	roomInteraction 0
	playerPosition -32, -216, FACING_NORTH

	checkAction
	roomInteraction 1
	playerPosition -272, 168, FACING_SOUTH_WEST

	endRoomActions

room19_actions:
door47AA:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget FALLING_CIELING_ROOM, door4457
	playerPosition 0, 208, FACING_SOUTH

door47B5:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget FALLING_CIELING_ROOM, door477D
	playerPosition 208, -96, FACING_EAST

	endRoomActions

room1A_actions:
door47C1:
	doorType LADDER_1_UPWARD
	doorTarget UNDERGROUND_PASSAGE_1, door4C49
	playerPosition 464, 280, FACING_EAST

door47CC:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget UNDERGROUND_PASSAGE_1, door47F9
	playerPosition -912, 296, FACING_WEST

	checkOnFloorAction
	pickItem ROOM1A_SHELLS, SHELLS
	playerPosition 464, -336, FACING_SOUTH

	roomEntity ZOMBIE, 40
	roomEntityPos -232, 312, FACING_NORTH

	roomEntity ZOMBIE, 41
	roomEntityPos 144, -336, FACING_NORTH

	endRoomActions

room1B_actions:
door47F9:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget UNDERGROUND_PASSAGE_2, door47CC
	playerPosition 808, -336, FACING_EAST

door4804:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget UNDERGROUND_PASSAGE_2, door5B44
	playerPosition -968, 216, FACING_NORTH

	roomEntity ZOMBIE, 42
	roomEntityPos -232, 312, FACING_NORTH

	roomEntity ZOMBIE, 43
	roomEntityPos 144, -336, FACING_NORTH

	checkOnFloorAction
	pickItem ROOM1B_GREEN_HERB1, GREEN_HERB
	playerPosition 960, 240, FACING_SOUTH

	checkOnFloorAction
	pickItem ROOM1B_GREEN_HERB2, GREEN_HERB
	playerPosition 960, 328, FACING_SOUTH

	endRoomActions

room1C_actions:
door483C:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget DINNING_ROOM_2F, door4874
	playerPosition -976, -24, FACING_WEST

door4847:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget DINNING_ROOM_2F, door4E43
	playerPosition 864, 336, FACING_SOUTH

	roomEntity ZOMBIE, 44
	roomEntityPos 240, -336, FACING_NORTH

	roomEntity ZOMBIE, 45
	roomEntityPos -736, 336, FACING_NORTH

	roomEntity JEWEL_STATUE, JEWEL_STATUE_VARID
	roomEntityPos 0, -264, FACING_SOUTH

	endRoomActions

room1D_actions:
door4874:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget MAIN_HALL_2F, door483C
	playerPosition 976, 192, FACING_EAST

door487F:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget MAIN_HALL_2F, door4954
	playerPosition -976, -528, FACING_WEST

door488A:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget MAIN_HALL_2F, door4B80
	playerPosition -976, 400, FACING_WEST

door4895:
	doorType STAIRS_1_DOWNWARD
	doorTarget MAIN_HALL_2F, door4109
	playerPosition 0, 744, FACING_NORTH

	endRoomActions

room1E_actions:
door48A1:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget PILLAR_CORRIDOR, door4B75
	playerPosition -464, 416, FACING_WEST

door48AC:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget PILLAR_CORRIDOR, door4CA4
	playerPosition 432, -464, FACING_NORTH

	checkOnFloorAction
	pickItem ROOM1E_GREEN_HERB1, GREEN_HERB
	playerPosition 120, 104, FACING_SOUTH

	checkOnFloorAction
	pickItem ROOM1E_GREEN_HERB2, GREEN_HERB
	playerPosition 376, -104, FACING_SOUTH

	endRoomActions

room1F_actions:
door48CE:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LOUNGE_ROOM, door4A96
	playerPosition -160, 208, FACING_SOUTH

door48D9:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LOUNGE_ROOM, door4C60
	playerPosition 208, 128, FACING_EAST

	checkAction
	pickItem ROOM1F_MAP_2, MAP_2
	playerPosition 16, -120, FACING_NORTH

	checkOnFloorAction
	pickItem ROOM1F_GREEN_HERB, GREEN_HERB
	playerPosition -184, -144, FACING_SOUTH

	endRoomActions

room20_actions:
door48FB:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget ELEVATOR_ROOM_2F, door4D58
	playerPosition 440, -896, FACING_WEST

door4906:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget ELEVATOR_ROOM_2F, door4DD3
	playerPosition -136, 224, FACING_WEST

door4911:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget ELEVATOR_ROOM_2F, door4AD9
	playerPosition -720, -72, FACING_WEST

door491C:
	doorType MANSION_ELEVATOR_3
	doorTarget ELEVATOR_ROOM_2F, door5B4F
	playerPosition 456, -256, FACING_WEST

	roomEntity ZOMBIE, 46
	roomEntityPos -256, -104, FACING_NORTH

	roomEntity ZOMBIE, 47
	roomEntityPos 528, 88, FACING_NORTH

	roomEntity ZOMBIE, 48
	roomEntityPos 528, -1112, FACING_NORTH

	checkOnFloorAction
	pickItem ROOM20_GREEN_HERB, GREEN_HERB
	playerPosition 304, -152, FACING_WEST

	endRoomActions

room21_actions:
door4954:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget HALLWAY_TO_EAST_TERRACE, door487F
	playerPosition -320, -48, FACING_NORTH

door495F:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget HALLWAY_TO_EAST_TERRACE, door4CFE
	playerPosition 464, 48, FACING_SOUTH

	checkAction
	pickItem ROOM21_SMALL_KEY_3, SMALL_KEY_3
	playerPosition -336, 0, FACING_WEST

	checkOnFloorAction
	roomInteraction 0
	playerPosition 264, 0, FACING_SOUTH

	endRoomActions

room22_actions:
door4981:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget SMALL_DINNING_ROOM, door4CBA
	playerPosition -288, -272, FACING_NORTH

	checkAction
	pickItem ROOM22_SHELLS, SHELLS
	playerPosition -248, 424, FACING_WEST

	checkAction
	pickItem ROOM22_CLIP, CLIP
	playerPosition 336, -200, FACING_NORTH

	checkAction
	roomInteraction 8
	playerPosition -56, -160, FACING_SOUTH

	endRoomActions

room23_actions:
door49AE:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget ARMORS_ROOM, door4B6A
	playerPosition 464, -16, FACING_EAST

	checkAction
	pickItem ROOM23_SUN_CREST, SUN_CREST
	playerPosition -392, -16, FACING_WEST

	checkOnFloorAction
	roomInteraction 14
	playerPosition 0, 0, FACING_WEST

	roomEntity ARMORS_ROOM_STATUE_1, ARMORS_ROOM_STATUE_1_VARID
	roomEntityPos -128, 0, FACING_WEST

	roomEntity ARMORS_ROOM_STATUE_2, ARMORS_ROOM_STATUE_2_VARID
	roomEntityPos 280, -64, FACING_SOUTH

	checkAction
	roomInteraction 0
	playerPosition 448, 144, FACING_SOUTH

	checkAction
	roomInteraction 1
	playerPosition 288, 144, FACING_SOUTH

	checkAction
	roomInteraction 2
	playerPosition 160, 144, FACING_SOUTH

	checkAction
	roomInteraction 3
	playerPosition 88, 144, FACING_SOUTH

	checkAction
	roomInteraction 4
	playerPosition -64, 144, FACING_SOUTH

	checkAction
	roomInteraction 5
	playerPosition -256, 144, FACING_SOUTH

	checkAction
	roomInteraction 6
	playerPosition -384, 144, FACING_SOUTH

	checkAction
	roomInteraction 7
	playerPosition 448, -392, FACING_NORTH

	checkAction
	roomInteraction 8
	playerPosition 288, -392, FACING_NORTH

	checkAction
	roomInteraction 9
	playerPosition 160, -392, FACING_NORTH

	checkAction
	roomInteraction 10
	playerPosition 88, -392, FACING_NORTH

	checkAction
	roomInteraction 11
	playerPosition -64, -392, FACING_NORTH

	checkAction
	roomInteraction 12
	playerPosition -256, -392, FACING_NORTH

	checkAction
	roomInteraction 13
	playerPosition -384, -392, FACING_NORTH

	endRoomActions

room24_actions:
door4A80:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget EAST_STAIRCASE_2F, door4B5F
	playerPosition 144, 784, FACING_EAST

door4A8B:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget EAST_STAIRCASE_2F, door4CDC
	playerPosition -376, 64, FACING_EAST

door4A96:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget EAST_STAIRCASE_2F, door48CE
	playerPosition 144, -960, FACING_EAST

door4AA1:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget EAST_STAIRCASE_2F, door4BAD
	playerPosition -456, 848, FACING_SOUTH

door4AAC:
	doorType STAIRS_3_DOWNWARD
	doorTarget EAST_STAIRCASE_2F, door4536
	playerPosition -1120, 264, FACING_SOUTH

	roomEntity ZOMBIE, 49
	roomEntityPos -296, 824, FACING_NORTH

	roomEntity ZOMBIE, 50
	roomEntityPos -448, 8, FACING_NORTH

	roomEntity ZOMBIE, 51
	roomEntityPos -176, -936, FACING_NORTH

	endRoomActions

room25_actions:
door4AD9:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget WESTERN_CORRIDOR_2F, door4911
	playerPosition 528, 640, FACING_EAST

door4AE4:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget WESTERN_CORRIDOR_2F, door4E22
	playerPosition -312, -376, FACING_SOUTH

	checkOnFloorAction
	pickItem ROOM25_BLUE_HERB, BLUE_HERB
	playerPosition 368, 960, FACING_WEST

	checkOnFloorAction
	pickItem ROOM25_GREEN_HERB1, GREEN_HERB
	playerPosition 256, 960, FACING_WEST

	checkOnFloorAction
	pickItem ROOM25_GREEN_HERB2, GREEN_HERB
	playerPosition 128, 960, FACING_WEST

	roomEntity ZOMBIE, 52
	roomEntityPos -72, -416, FACING_NORTH

	roomEntity ZOMBIE, 53
	roomEntityPos 336, 712, FACING_NORTH

	endRoomActions

room26_actions:
door4B27:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget MANSION_BEDROOM, door4CE7
	playerPosition -272, 176, FACING_WEST

	checkAction
	pickItem ROOM26_LIGHTER, LIGHTER
	playerPosition 160, 200, FACING_SOUTH

	checkAction
	pickItem ROOM26_SHELLS, SHELLS
	playerPosition 272, 200, FACING_SOUTH

	checkOnFloorAction
	pickItem ROOM26_RED_HERB, RED_HERB
	playerPosition -272, -208, FACING_WEST

	endRoomActions

room27_actions:
door4B54:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget U_SHAPED_CORRIDOR, door4BA2
	playerPosition -672, -720, FACING_NORTH

door4B5F:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget U_SHAPED_CORRIDOR, door4A80
	playerPosition 112, -720, FACING_NORTH

door4B6A:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget U_SHAPED_CORRIDOR, door49AE
	playerPosition 568, -32, FACING_WEST

door4B75:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget U_SHAPED_CORRIDOR, door48A1
	playerPosition 200, 720, FACING_SOUTH

door4B80:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget U_SHAPED_CORRIDOR, door488A
	playerPosition -720, 640, FACING_WEST

	roomEntity ZOMBIE, 54
	roomEntityPos 288, 640, FACING_NORTH

	roomEntity ZOMBIE, 55
	roomEntityPos -288, -672, FACING_NORTH

	endRoomActions

room28_actions:
door4BA2:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget SMALL_LIBRARY, door4B54
	playerPosition -256, 464, FACING_SOUTH

door4BAD:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget SMALL_LIBRARY, door4AA1
	playerPosition 400, -376, FACING_EAST

	checkAction
	pickItem ROOM28_BOTANY_BOOK, BOTANY_BOOK
	playerPosition 8, -304, FACING_NORTH

	checkAction
	roomInteraction 0
	playerPosition -248, -272, FACING_WEST

	checkAction
	roomInteraction 1
	playerPosition 184, 360, FACING_SOUTH

	checkAction
	roomInteraction 2
	playerPosition 184, 216, FACING_NORTH

	checkAction
	roomInteraction 3
	playerPosition 216, 8, FACING_SOUTH

	endRoomActions

room29_actions:
door4BF0:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget RESEARCHERS_PRIVATE_ROOM, door4CD1
	playerPosition -64, 240, FACING_SOUTH

	checkAction
	pickItem ROOM29_SHELLS, SHELLS
	playerPosition -240, -8, FACING_WEST

	checkAction
	pickItem ROOM29_NOTHING_ITEM_5, NOTHING_ITEM_5
	playerPosition 200, -56, FACING_NORTH_WEST

	checkAction
	pickItem ROOM29_INK_RIBBON, INK_RIBBON
	playerPosition -240, 240, FACING_NORTH_WEST

	checkAction
	roomInteraction 8
	playerPosition 240, 120, FACING_EAST

	roomEntity RESEARCHER_ROOM_SHELF, RESEARCHER_ROOM_SHELF_P1_VARID
	roomEntityPos -224, 0, FACING_SOUTH

	roomEntity RESEARCHER_ROOM_SHELF, RESEARCHER_ROOM_SHELF_P2_VARID
	roomEntityPos -224, -160, FACING_SOUTH

	checkAction
	roomInteraction 0
	playerPosition 136, -184, FACING_EAST

	endRoomActions

room2A_actions:
door4C49:
	doorType LADDER_1_DOWNWARD
	doorTarget TREVORS_TOMB, door47C1
	playerPosition -16, 8, FACING_NORTH

door4C54:
	doorType ROPE_UPWARD
	doorTarget TREVORS_TOMB, door4C6B
	playerPosition -16, 336, FACING_SOUTH

	endRoomActions

room2B_actions:
door4C60:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LESSONS_ROOM, door48D9
	playerPosition -272, 576, FACING_WEST

door4C6B:
	doorType ROPE_DOWNWARD
	doorTarget LESSONS_ROOM, door4C54
	playerPosition 208, -360, FACING_NORTH

	endRoomActions

room2C_actions:
door4C77:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget ATTIC, door4CAF
	playerPosition -200, 400, FACING_WEST

	roomEntity YAWN, 63
	roomEntityPos 24, -104, FACING_NORTH

	checkOnFloorAction
	pickItem ROOM2C_MOON_CREST, MOON_CREST
	playerPosition -200, -848, FACING_WEST

	checkOnFloorAction
	pickItem ROOM2C_SHELLS, SHELLS
	playerPosition -352, -136, FACING_NORTH

	endRoomActions

room2D_actions:
door4CA4:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget ATTIC_ENTRY, door48AC
	playerPosition 88, 336, FACING_SOUTH

door4CAF:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget ATTIC_ENTRY, door4C77
	playerPosition 88, -336, FACING_NORTH

door4CBA:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget ATTIC_ENTRY, door4981
	playerPosition -512, -48, FACING_SOUTH

	roomEntity ZOMBIE, 56
	roomEntityPos -120, -80, FACING_NORTH

	endRoomActions

room2E_actions:
door4CD1:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget DEER_ROOM, door4BF0
	playerPosition 16, 272, FACING_SOUTH

door4CDC:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget DEER_ROOM, door4A8B
	playerPosition 144, 0, FACING_EAST

door4CE7:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget DEER_ROOM, door4B27
	playerPosition -16, -400, FACING_NORTH

	roomEntity ZOMBIE, 57
	roomEntityPos -96, 120, FACING_NORTH

	endRoomActions

room2F_actions:
door4CFE:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget EAST_TERRACE, door495F
	playerPosition -312, 208, FACING_SOUTH

	checkOnFloorAction
	pickItem ROOM2F_BAZOOKA, CLIP
	playerPosition 344, -152, FACING_NORTH_WEST

	endRoomActions

room30_actions:
door4D15:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget TAXIDERMY_ROOM, door4E2D
	playerPosition 240, 224, FACING_EAST

	checkAction
	pickItem ROOM30_RED_JEWEL, RED_JEWEL
	playerPosition -24, -248, FACING_NORTH

	checkAction
	pickItem ROOM30_NOTHING_ITEM_6, NOTHING_ITEM_6
	playerPosition 48, -128, FACING_WEST

	checkAction
	pickItem ROOM30_MAGNUM_ROUNDS, MAGNUM_ROUNDS
	playerPosition -184, -32, FACING_WEST

	checkAction
	pickItem ROOM30_SHELLS, SHELLS
	playerPosition -184, -88, FACING_WEST

	checkAction
	roomInteraction 8
	playerPosition 240, 56, FACING_EAST

	endRoomActions

room31_actions:
door4D58:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LIBRARY, door48FB
	playerPosition -208, 0, FACING_WEST

door4D63:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LIBRARY, door4DA6
	playerPosition 752, -560, FACING_EAST

door4D6E:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LIBRARY, door4E00
	playerPosition 512, 336, FACING_SOUTH

	checkAction
	pickItem ROOM31_MAGNUM_ROUNDS, MAGNUM_ROUNDS
	playerPosition -208, 248, FACING_SOUTH

	checkOnFloorAction
	pickItem ROOM31_NOTHING_ITEM_7, NOTHING_ITEM_7
	playerPosition 584, -88, FACING_EAST

	roomEntity ZOMBIE, 58
	roomEntityPos 664, -264, FACING_NORTH

	roomEntity ZOMBIE, 59
	roomEntityPos 152, -120, FACING_NORTH

	endRoomActions

room32_actions:
door4DA6:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget HIDDEN_LIBRARY, door4D63
	playerPosition 464, 128, FACING_EAST

	checkAction
	pickItem ROOM32_MO_DISK_1, MO_DISK_1
	playerPosition 360, -512, FACING_EAST

	checkAction
	roomInteraction 8
	playerPosition -80, -136, FACING_WEST

	roomEntity HIDDEN_LIBRARY_STATUE, HIDDEN_LIBRARY_STATUE_VARID
	roomEntityPos -80, -384, FACING_NORTH

	endRoomActions

room33_actions:
door4DD3:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget MATERIALS_ROOM, door4906
	playerPosition -48, 208, FACING_SOUTH

	checkAction
	pickItem ROOM33_SHELLS1, SHELLS
	playerPosition 80, -120, FACING_NORTH

	checkAction
	pickItem ROOM33_SHELLS2, SHELLS
	playerPosition 80, -120, FACING_NORTH

	checkAction
	pickItem ROOM33_COURTYARD_BATTERY, COURTYARD_BATTERY
	playerPosition -80, -120, FACING_NORTH

	endRoomActions

room34_actions:
door4E00:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget HELIPAD_LOOKOUT_ROOM, door4D6E
	playerPosition -48, 272, FACING_SOUTH

	checkOnFloorAction
	pickItem ROOM34_INK_RIBBON, INK_RIBBON
	playerPosition 64, 104, FACING_NORTH

	checkAction
	pickItem ROOM34_CLIP, CLIP
	playerPosition 216, 184, FACING_SOUTH

	endRoomActions

room35_actions:
door4E22:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget WEST_STAIRCASE_2F, door4AE4
	playerPosition -104, 720, FACING_SOUTH

door4E2D:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget WEST_STAIRCASE_2F, door4D15
	playerPosition -56, 64, FACING_EAST

door4E38:
	doorType STAIRS_3_DOWNWARD
	doorTarget WEST_STAIRCASE_2F, door43DC
	playerPosition -56, -328, FACING_EAST

door4E43:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget WEST_STAIRCASE_2F, door4847
	playerPosition -296, -976, FACING_NORTH

	roomEntity ZOMBIE, 60
	roomEntityPos -88, 248, FACING_NORTH

	roomEntity ZOMBIE, 61
	roomEntityPos 720, -256, FACING_NORTH

	roomEntity ZOMBIE, 62
	roomEntityPos -104, -720, FACING_NORTH

	endRoomActions

room36_actions:
door4E70:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget COURTYARD_GARDEN, door4F00
	playerPosition 424, -1104, FACING_NORTH

door4E7B:
	doorType DOUBLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget COURTYARD_GARDEN, door46F7
	playerPosition 696, 1152, FACING_WEST

door4E86:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget COURTYARD_GARDEN, door4F22
	playerPosition -976, 496, FACING_WEST

	checkOnFloorAction
	pickItem ROOM36_BLUE_HERB1, BLUE_HERB
	playerPosition 568, 584, FACING_SOUTH_WEST

	checkOnFloorAction
	pickItem ROOM36_BLUE_HERB2, BLUE_HERB
	playerPosition 568, 584, FACING_SOUTH_WEST

	checkOnFloorAction
	pickItem ROOM36_GREEN_HERB1, GREEN_HERB
	playerPosition 976, 1232, FACING_SOUTH_WEST

	checkOnFloorAction
	pickItem ROOM36_GREEN_HERB2, GREEN_HERB
	playerPosition 976, 1232, FACING_SOUTH_WEST

	checkOnFloorAction
	pickItem ROOM36_GREEN_HERB3, GREEN_HERB
	playerPosition 976, 1232, FACING_SOUTH_WEST

	checkOnFloorAction
	pickItem ROOM36_RED_HERB1, RED_HERB
	playerPosition 848, 1232, FACING_SOUTH_WEST

	checkOnFloorAction
	pickItem ROOM36_RED_HERB2, RED_HERB
	playerPosition 848, 1232, FACING_SOUTH_WEST

	checkOnFloorAction
	pickItem ROOM36_MAP_2, MAP_2
	playerPosition -856, 376, FACING_SOUTH_WEST

	checkAction
	roomInteraction 8
	playerPosition -976, 512, FACING_EAST

	endRoomActions

room37_actions:
door4EF5:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget COURTYARD_FLOODGATE, door4F2D
	playerPosition -672, 136, FACING_SOUTH

door4F00:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget COURTYARD_FLOODGATE, door4E70
	playerPosition 936, 976, FACING_SOUTH

	checkAction
	roomInteraction 8
	playerPosition 200, -200, FACING_NORTH

	checkAction
	roomInteraction 9
	playerPosition 936, 312, FACING_NORTH

	endRoomActions

room38_actions:
door4F22:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget WATERFALL_GARDEN, door4E86
	playerPosition 328, 624, FACING_EAST

door4F2D:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget WATERFALL_GARDEN, door4EF5
	playerPosition 600, -720, FACING_NORTH

door4F38:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget WATERFALL_GARDEN, door4F7C
	playerPosition -720, -448, FACING_WEST

door4F43:
	doorType LADDER_1_DOWNWARD
	doorTarget WATERFALL_GARDEN, door5073
	playerPosition 0, -720, FACING_NORTH

	checkAction
	roomInteraction 8
	playerPosition 32, -552, FACING_NORTH

	checkAction
	roomInteraction 9
	playerPosition 192, 720, FACING_SOUTH

	endRoomActions

room39_actions:
door4F65:
	doorType HELIPORT_ELEVATOR_2
	doorTarget HELIPORT, door560D
	playerPosition -568, 768, FACING_WEST

	checkOnFloorAction
	pickItem ROOM39_FLARE, FLARE
	playerPosition -528, 976, FACING_SOUTH_WEST

	endRoomActions

room3A_actions:
door4F7C:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget WAY_TO_GUARDHOUSE, door4F38
	playerPosition 1024, 1088, FACING_EAST

door4F87:
	doorType DOUBLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget WAY_TO_GUARDHOUSE, door51FC
	playerPosition -800, -976, FACING_NORTH

	checkOnFloorAction
	pickItem ROOM3A_RED_HERB1, RED_HERB
	playerPosition 1024, 952, FACING_SOUTH_WEST

	checkOnFloorAction
	pickItem ROOM3A_RED_HERB2, RED_HERB
	playerPosition 1024, 952, FACING_SOUTH_WEST

	checkOnFloorAction
	pickItem ROOM3A_GREEN_HERB1, GREEN_HERB
	playerPosition 1024, 1168, FACING_SOUTH_WEST

	checkOnFloorAction
	pickItem ROOM3A_GREEN_HERB2, GREEN_HERB
	playerPosition 1024, 1168, FACING_SOUTH_WEST

	endRoomActions

room3B_actions:
door4FBF:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget UNDERGROUND_STATUE_ROOM, door5046
	playerPosition 16, -208, FACING_NORTH

	checkAction
	pickItem ROOM3B_DOOM_BOOK_1, DOOM_BOOK_1
	playerPosition 184, -208, FACING_NORTH

	checkAction
	roomInteraction 8
	playerPosition -208, 56, FACING_WEST

	roomEntity UNDERGROUND_STATUE, UNDERGROUND_STATUE_VARID
	roomEntityPos -208, 0, FACING_EAST

	endRoomActions

room3C_actions:
door4FEC:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget UNDERGROUND_SOUTH_PASSAGE, door5175
	playerPosition -336, -720, FACING_NORTH

	checkOnFloorAction
	pickItem ROOM3C_HEX_CRANK, HEX_CRANK
	playerPosition -360, 40, FACING_SOUTH_WEST

	checkOnFloorAction
	pickItem ROOM3C_CLIP, CLIP
	playerPosition 320, -200, FACING_SOUTH_WEST

	endRoomActions

room3D_actions:
door500E:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget BOULDER_1_ROOM, door5089
	playerPosition 248, -464, FACING_NORTH

door5019:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget BOULDER_1_ROOM, door51A2
	playerPosition 592, 464, FACING_SOUTH

	checkAction
	pickItem ROOM3D_FLAMETHROWER, FLAMETHROWER
	playerPosition 120, -464, FACING_WEST

	checkAction
	pickItem ROOM3D_MAGNUM_ROUNDS, MAGNUM_ROUNDS
	playerPosition -976, 8, FACING_SOUTH

	endRoomActions

room3E_actions:
door503B:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget BOULDER_2_ROOM, door50EE
	playerPosition 520, 976, FACING_SOUTH

door5046:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget BOULDER_2_ROOM, door4FBF
	playerPosition -200, -24, FACING_WEST

door5051:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget BOULDER_2_ROOM, door51DA
	playerPosition 808, 104, FACING_EAST

	checkAction
	pickItem ROOM3E_MO_DISK_2, MO_DISK_2
	playerPosition -976, -480, FACING_SOUTH

	checkAction
	pickItem ROOM3E_MAP_3, MAP_3
	playerPosition -976, -704, FACING_WEST

	endRoomActions

room3F_actions:
door5073:
	doorType LADDER_1_UPWARD
	doorTarget UNDERGROUND_ENTRY, door4F43
	playerPosition 312, 848, FACING_SOUTH

door507E:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget UNDERGROUND_ENTRY, door513D
	playerPosition 528, 688, FACING_EAST

door5089:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget UNDERGROUND_ENTRY, door500E
	playerPosition -432, 848, FACING_SOUTH

	typewriterAction
	playerPosition 40, -496, FACING_SOUTH

	endRoomActions

room40_actions:
door50A0:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget UNDERGROUND_BREAK_ROOM, door51C4
	playerPosition -64, 208, FACING_SOUTH

	checkAction
	pickItem ROOM40_INK_RIBBON, INK_RIBBON
	playerPosition -112, -8, FACING_EAST

	checkAction
	pickItem ROOM40_F_AID_SPRAY, F_AID_SPRAY
	playerPosition 120, -72, FACING_WEST

	checkOnFloorAction
	pickItem ROOM40_BLUE_HERB, BLUE_HERB
	playerPosition 208, -208, FACING_WEST

	typewriterAction
	playerPosition -112, 72, FACING_EAST

	itemboxAction
	playerPosition -176, -168, FACING_NORTH

	endRoomActions

room41_actions:
door50E3:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget FOUNTAIN, door5645
	playerPosition 496, 760, FACING_NORTH

door50EE:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget FOUNTAIN, door503B
	playerPosition -464, -248, FACING_SOUTH

	checkOnFloorAction
	pickItem ROOM41_GREEN_HERB1, GREEN_HERB
	playerPosition -544, -584, FACING_EAST

	checkOnFloorAction
	pickItem ROOM41_GREEN_HERB2, GREEN_HERB
	playerPosition -544, -584, FACING_EAST

	checkOnFloorAction
	pickItem ROOM41_BLUE_HERB1, BLUE_HERB
	playerPosition -88, -656, FACING_EAST

	checkOnFloorAction
	pickItem ROOM41_BLUE_HERB2, BLUE_HERB
	playerPosition -88, -656, FACING_EAST

	checkAction
	roomInteraction 8
	playerPosition 8, 360, FACING_EAST

	checkAction
	roomInteraction 9
	playerPosition 1016, 248, FACING_WEST

	endRoomActions

room42_actions:
	endRoomActions

room43_actions:
door513D:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget UNDERGROUND_BRANCHED_PASSAGE, door507E
	playerPosition -272, 24, FACING_WEST

door5148:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget UNDERGROUND_BRANCHED_PASSAGE, door5180
	playerPosition 264, 896, FACING_EAST

door5153:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget UNDERGROUND_BRANCHED_PASSAGE, door516A
	playerPosition 336, -880, FACING_EAST

	checkOnFloorAction
	pickItem ROOM43_FLAMETHROWER, FLAMETHROWER
	playerPosition -120, -104, FACING_NORTH

	endRoomActions

room44_actions:
door516A:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget UNDERGROUND_GENERATOR_ROOM, door5153
	playerPosition -712, -856, FACING_WEST

door5175:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget UNDERGROUND_GENERATOR_ROOM, door4FEC
	playerPosition 72, 656, FACING_SOUTH

door5180:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget UNDERGROUND_GENERATOR_ROOM, door5148
	playerPosition -912, 512, FACING_WEST

	checkAction
	pickItem ROOM44_F_AID_SPRAY, F_AID_SPRAY
	playerPosition 712, -488, FACING_EAST

	checkAction
	pickItem ROOM44_SHELLS, SHELLS
	playerPosition 712, -320, FACING_EAST

	endRoomActions

room45_actions:
door51A2:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget UNDERGROUND_WAREHOUSE, door5019
	playerPosition -336, 32, FACING_WEST

door51AD:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget UNDERGROUND_WAREHOUSE, door51CF
	playerPosition 336, 0, FACING_EAST

	checkOnFloorAction
	pickItem ROOM45_COMBAT_KNIFE, COMBAT_KNIFE
	playerPosition -264, 464, FACING_EAST

	endRoomActions

room46_actions:
door51C4:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget WAY_TO_BREAK_ROOM, door50A0
	playerPosition -928, 112, FACING_SOUTH

door51CF:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget WAY_TO_BREAK_ROOM, door51AD
	playerPosition 0, 112, FACING_SOUTH

door51DA:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget WAY_TO_BREAK_ROOM, door5051
	playerPosition 976, 0, FACING_EAST

	endRoomActions

room47_actions:
door51E6:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget GUARDHOUSE_ENTRANCE, door53A6
	playerPosition 104, 144, FACING_SOUTH

door51F1:
	doorType DOUBLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget GUARDHOUSE_ENTRANCE, door5384
	playerPosition 592, -568, FACING_EAST

door51FC:
	doorType DOUBLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget GUARDHOUSE_ENTRANCE, door4F87
	playerPosition -880, -376, FACING_SOUTH

door5207:
	doorType DOUBLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget GUARDHOUSE_ENTRANCE, door524A
	playerPosition -120, -648, FACING_NORTH

door5212:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget GUARDHOUSE_ENTRANCE, door52BA
	playerPosition -232, -504, FACING_SOUTH

	checkOnFloorAction
	pickItem ROOM47_BLUE_HERB1, BLUE_HERB
	playerPosition -904, -960, FACING_SOUTH_WEST

	checkOnFloorAction
	pickItem ROOM47_BLUE_HERB2, BLUE_HERB
	playerPosition -904, -960, FACING_SOUTH_WEST

	checkOnFloorAction
	pickItem ROOM47_BLUE_HERB3, BLUE_HERB
	playerPosition -904, -960, FACING_SOUTH_WEST

	roomEntity GUARDHOUSE_STATUE, GUARDHOUSE_STATUE_VARID
	roomEntityPos 128, -584, FACING_SOUTH

	endRoomActions

room48_actions:
door524A:
	doorType DOUBLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget GUARDHOUSE_DORM_001, door5207
	playerPosition 384, 592, FACING_SOUTH

door5255:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget GUARDHOUSE_DORM_001, door5298
	playerPosition 312, 560, FACING_WEST

	roomEntity ZOMBIE, 120
	roomEntityPos -192, -216, FACING_NORTH

	roomEntity ZOMBIE, 121
	roomEntityPos 240, -112, FACING_NORTH

	checkAction
	pickItem ROOM48_SMALL_KEY_4, SMALL_KEY_4
	playerPosition -200, -400, FACING_WEST

	checkAction
	pickItem ROOM48_SHELLS, SHELLS
	playerPosition 312, -120, FACING_EAST

	checkAction
	pickItem ROOM48_RED_BOOK, RED_BOOK
	playerPosition 264, -216, FACING_NORTH

	endRoomActions

room49_actions:
door5298:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget DORM_001_BATHROOM, door5255
	playerPosition -176, 208, FACING_SOUTH

	checkAction
	pickItem ROOM49_C_ROOM_KEY, C_ROOM_KEY
	playerPosition -136, -56, FACING_NORTH

	checkAction
	roomInteraction 0
	playerPosition 104, 208, FACING_EAST

	endRoomActions

room4A_actions:
door52BA:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget GUARDHOUSE_BREAK_ROOM, door5212
	playerPosition -336, -296, FACING_WEST

	checkAction
	pickItem ROOM4A_CLIP, CLIP
	playerPosition -88, 248, FACING_SOUTH

	checkAction
	pickItem ROOM4A_F_AID_SPRAY, F_AID_SPRAY
	playerPosition -160, 248, FACING_SOUTH

	typewriterAction
	playerPosition 216, 184, FACING_EAST

	itemboxAction
	playerPosition -56, -200, FACING_NORTH

	endRoomActions

room4B_actions:
door52F2:
	doorType DOUBLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget AQUA_TANK_ROOM, door532A
	playerPosition 976, 64, FACING_EAST

door52FD:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget AQUA_TANK_ROOM, door55EB
	playerPosition 976, -928, FACING_EAST

door5308:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget AQUA_TANK_ROOM, door5592
	playerPosition -976, -720, FACING_WEST

door5313:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget AQUA_TANK_ROOM, door5357
	playerPosition -976, -464, FACING_WEST

	endRoomActions

room4C_actions:
door531F:
	doorType LADDER_1_UPWARD
	doorTarget AQUA_TANK_ENTRANCE, door53F4
	playerPosition -880, -1040, FACING_NORTH

door532A:
	doorType DOUBLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget AQUA_TANK_ENTRANCE, door52F2
	playerPosition 72, 1136, FACING_WEST

	checkOnFloorAction
	pickItem ROOM4C_GREEN_HERB1, GREEN_HERB
	playerPosition 784, 1232, FACING_SOUTH

	checkOnFloorAction
	pickItem ROOM4C_GREEN_HERB2, GREEN_HERB
	playerPosition 784, 1232, FACING_SOUTH

	roomEntity WOODEN_BOX, WOODEN_BOX_VARID
	roomEntityPos 960, 0, FACING_SOUTH

	endRoomActions

room4D_actions:
door5357:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget AQUA_TANK_CONTROL_ROOM, door5313
	playerPosition -208, 288, FACING_WEST

	checkAction
	roomInteraction 8
	playerPosition -184, -120, FACING_WEST

	checkAction
	roomInteraction 9
	playerPosition -88, 336, FACING_SOUTH

	checkAction
	roomInteraction 0
	playerPosition 152, 264, FACING_EAST

	endRoomActions

room4E_actions:
door5384:
	doorType DOUBLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget GUARDHOUSE_BAR, door51F1
	playerPosition -392, 232, FACING_WEST

	checkAction
	pickItem ROOM4E_CLIP, CLIP
	playerPosition -776, 440, FACING_NORTH

	checkOnFloorAction
	pickItem ROOM4E_INK_RIBBON, INK_RIBBON
	playerPosition -640, 832, FACING_SOUTH

	endRoomActions

room4F_actions:
door53A6:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget DORMITORY_CORRIDOR, door51E6
	playerPosition -624, 808, FACING_NORTH

door53B1:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget DORMITORY_CORRIDOR, door5490
	playerPosition 712, 480, FACING_EAST

door53BC:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget DORMITORY_CORRIDOR, door53DE
	playerPosition 880, -616, FACING_EAST

	checkOnFloorAction
	pickItem ROOM4F_GREEN_HERB1, GREEN_HERB
	playerPosition 808, -1232, FACING_SOUTH

	checkOnFloorAction
	pickItem ROOM4F_GREEN_HERB2, GREEN_HERB
	playerPosition 808, -1232, FACING_SOUTH

	endRoomActions

room50_actions:
door53DE:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget GUARDHOUSE_DORM_002, door53BC
	playerPosition 368, 592, FACING_SOUTH

door53E9:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget GUARDHOUSE_DORM_002, door5437
	playerPosition 312, 448, FACING_WEST

door53F4:
	doorType LADDER_1_DOWNWARD
	doorTarget GUARDHOUSE_DORM_002, door531F
	playerPosition -152, -200, FACING_WEST

	checkAction
	pickItem ROOM50_MAP_4, MAP_4
	playerPosition 152, -48, FACING_SOUTH

	checkAction
	pickItem ROOM50_SHELLS, SHELLS
	playerPosition 312, -88, FACING_EAST

	checkAction
	pickItem ROOM50_NOTHING_ITEM_8, NOTHING_ITEM_8
	playerPosition 192, -216, FACING_NORTH

	roomEntity DORM_002_CLOSET, DORM_002_CLOSET_VARID
	roomEntityPos -128, -160, FACING_SOUTH

	checkAction
	roomInteraction 0
	playerPosition 48, -400, FACING_NORTH

	endRoomActions

room51_actions:
door5437:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget DORM_002_BATHROOM, door53E9
	playerPosition -168, 208, FACING_SOUTH

	checkAction
	pickItem ROOM51_CLIP, CLIP
	playerPosition 208, 88, FACING_EAST

	roomEntity ZOMBIE, 122
	roomEntityPos 48, -8, FACING_NORTH

	checkAction
	roomInteraction 0
	playerPosition 120, 208, FACING_EAST

	checkAction
	roomInteraction 1
	playerPosition -136, -56, FACING_NORTH

	endRoomActions

room52_actions:
door546F:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget BEEHIVE_PASSAGE, door550B
	playerPosition 136, 656, FACING_EAST

door547A:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget BEEHIVE_PASSAGE, door557B
	playerPosition 928, 864, FACING_EAST

door5485:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget BEEHIVE_PASSAGE, door54A7
	playerPosition -584, 496, FACING_WEST

door5490:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget BEEHIVE_PASSAGE, door53B1
	playerPosition -976, 928, FACING_WEST

	checkAction
	pickItem ROOM52_DORMITORY_2_KEY, DORMITORY_2_KEY
	playerPosition -8, -512, FACING_NORTH

	endRoomActions

room53_actions:
door54A7:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget CHEMISTRY_ROOM, door5485
	playerPosition -272, -96, FACING_WEST

	checkAction
	pickItem ROOM53_EMPTY_BOTTLE1, EMPTY_BOTTLE
	playerPosition -200, 88, FACING_SOUTH

	checkAction
	pickItem ROOM53_EMPTY_BOTTLE2, EMPTY_BOTTLE
	playerPosition 152, 144, FACING_EAST

	checkAction
	pickItem ROOM53_EMPTY_BOTTLE3, EMPTY_BOTTLE
	playerPosition 152, -120, FACING_EAST

	checkAction
	pickItem ROOM53_EMPTY_BOTTLE4, EMPTY_BOTTLE
	playerPosition 0, -56, FACING_NORTH

	checkAction
	roomInteraction 8
	playerPosition -200, 88, FACING_SOUTH

	checkAction
	roomInteraction 9
	playerPosition 152, 144, FACING_EAST

	checkAction
	roomInteraction 10
	playerPosition -80, -56, FACING_NORTH

	checkAction
	roomInteraction 11
	playerPosition -272, 32, FACING_WEST

	endRoomActions

room54_actions:
door550B:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget GUARDHOUSE_DORM_003, door546F
	playerPosition 376, 592, FACING_SOUTH

door5516:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget GUARDHOUSE_DORM_003, door5559
	playerPosition 312, 512, FACING_WEST

door5521:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget GUARDHOUSE_DORM_003, door5570
	playerPosition 168, -400, FACING_NORTH

	checkAction
	pickItem ROOM54_INK_RIBBON, INK_RIBBON
	playerPosition 384, -200, FACING_SOUTH

	checkAction
	roomInteraction 8
	playerPosition -184, -224, FACING_WEST

	roomEntity DORM_003_CLOSET_F1, DORM_003_CLOSET_F1_VARID
	roomEntityPos 192, -368, FACING_EAST

	roomEntity DORM_003_CLOSET_F2, DORM_003_CLOSET_F2_VARID
	roomEntityPos 336, -368, FACING_EAST

	endRoomActions

room55_actions:
door5559:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget DORM_003_BATHROOM, door5516
	playerPosition -160, 208, FACING_SOUTH

	checkOnFloorAction
	pickItem ROOM55_CLIP, CLIP
	playerPosition 120, 0, FACING_SOUTH

	endRoomActions

room56_actions:
door5570:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget PLANT_42_ROOM, door5521
	playerPosition 720, 304, FACING_EAST

door557B:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget PLANT_42_ROOM, door547A
	playerPosition 720, 0, FACING_EAST

	checkAction
	pickItem ROOM56_HELMET_KEY, HELMET_KEY
	playerPosition 144, 584, FACING_SOUTH

	endRoomActions

room57_actions:
door5592:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget AQUA_TANK_STOREROOM, door5308
	playerPosition 272, 96, FACING_EAST

	checkAction
	pickItem ROOM57_CLIP1, CLIP
	playerPosition 112, -56, FACING_NORTH

	checkAction
	pickItem ROOM57_CLIP2, CLIP
	playerPosition 112, -56, FACING_NORTH

	checkAction
	pickItem ROOM57_SHELLS1, SHELLS
	playerPosition -224, -56, FACING_WEST

	checkAction
	pickItem ROOM57_SHELLS2, SHELLS
	playerPosition -224, -56, FACING_WEST

	checkAction
	pickItem ROOM57_DORMITORY_3_KEY, DORMITORY_3_KEY
	playerPosition -112, -56, FACING_NORTH

	checkAction
	roomInteraction 0
	playerPosition -64, 40, FACING_SOUTH

	checkAction
	roomInteraction 1
	playerPosition 72, 144, FACING_WEST

	endRoomActions

room58_actions:
door55EB:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget PLANT_42_ROOTS_ROOM, door52FD
	playerPosition -392, 272, FACING_SOUTH

	checkAction
	pickItem ROOM58_SMALL_KEY_5, SMALL_KEY_5
	playerPosition 392, -272, FACING_NORTH_EAST

	endRoomActions

room59_actions:
door5602:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget EMERGENCY_TUNNEL, door562F
	playerPosition 976, 880, FACING_EAST

door560D:
	doorType HELIPORT_ELEVATOR_1
	doorTarget EMERGENCY_TUNNEL, door4F65
	playerPosition -976, -848, FACING_WEST

	checkOnFloorAction
	pickItem ROOM59_LAB_BATTERY, LAB_BATTERY
	playerPosition -552, -920, FACING_SOUTH_WEST

	checkAction
	roomInteraction 8
	playerPosition -920, -976, FACING_NORTH

	endRoomActions

room5A_actions:
door562F:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LAB_ENTRANCE, door5602
	playerPosition -464, 32, FACING_WEST

door563A:
	doorType LADDER_1_DOWNWARD
	doorTarget LAB_ENTRANCE, door565C
	playerPosition -336, 264, FACING_SOUTH

door5645:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LAB_ENTRANCE, door50E3
	playerPosition 248, 592, FACING_WEST

	endRoomActions

room5B_actions:
door5651:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LAB_LADDER_ROOM, door5673
	playerPosition 0, -336, FACING_NORTH

door565C:
	doorType LADDER_1_UPWARD
	doorTarget LAB_LADDER_ROOM, door563A
	playerPosition 0, 336, FACING_SOUTH

	itemboxAction
	playerPosition 104, 0, FACING_EAST

	endRoomActions

room5C_actions:
door5673:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LAB_B2F_STAIR_HALL, door5651
	playerPosition 672, 200, FACING_NORTH

door567E:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LAB_B2F_STAIR_HALL, door570F
	playerPosition 120, -408, FACING_SOUTH

door5689:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LAB_B2F_STAIR_HALL, door56CC
	playerPosition -640, -440, FACING_SOUTH

	checkOnFloorAction
	pickItem ROOM5C_GREEN_HERB1, GREEN_HERB
	playerPosition -64, -128, FACING_SOUTH_WEST

	checkOnFloorAction
	pickItem ROOM5C_GREEN_HERB2, GREEN_HERB
	playerPosition -64, -128, FACING_SOUTH_WEST

	checkAction
	pickItem ROOM5C_MO_DISK_3, MO_DISK_3
	playerPosition -960, -528, FACING_WEST

	roomEntity ZOMBIE, 160
	roomEntityPos 88, 384, FACING_NORTH

	roomEntity ZOMBIE, 161
	roomEntityPos -120, -288, FACING_NORTH

	endRoomActions

room5D_actions:
door56CC:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget VISUAL_DATA_ROOM, door5689
	playerPosition -8, 464, FACING_SOUTH

	checkAction
	pickItem ROOM5D_LAB_KEY, LAB_KEY
	playerPosition 336, -64, FACING_EAST

	checkAction
	roomInteraction 8
	playerPosition -336, -360, FACING_WEST

	checkAction
	roomInteraction 9
	playerPosition 8, -336, FACING_SOUTH

	checkAction
	roomInteraction 10
	playerPosition -8, -464, FACING_NORTH

	endRoomActions

room5E_actions:
door5704:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LAB_CENTRAL_CLOISTER, door5768
	playerPosition 872, -976, FACING_NORTH

door570F:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LAB_CENTRAL_CLOISTER, door567E
	playerPosition -808, -976, FACING_NORTH

door571A:
	doorType DOUBLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LAB_CENTRAL_CLOISTER, door57E3
	playerPosition -976, -656, FACING_WEST

door5725:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LAB_CENTRAL_CLOISTER, door57A0
	playerPosition 288, 760, FACING_NORTH

door5730:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LAB_CENTRAL_CLOISTER, door58D9
	playerPosition 976, 824, FACING_EAST

	roomEntity ZOMBIE, 162
	roomEntityPos -808, -400, FACING_NORTH

	roomEntity ZOMBIE, 163
	roomEntityPos -104, 880, FACING_NORTH

	roomEntity ZOMBIE, 164
	roomEntityPos -280, 560, FACING_NORTH

	roomEntity ZOMBIE, 165
	roomEntityPos 0, -632, FACING_NORTH

	endRoomActions

room5F_actions:
door5768:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget SMALL_LAB, door5704
	playerPosition 464, 208, FACING_SOUTH

	checkAction
	pickItem ROOM5F_SLIDES_2, SLIDES_2
	playerPosition -8, -168, FACING_NORTH

	checkAction
	roomInteraction 8
	playerPosition 464, -160, FACING_EAST

	endRoomActions

room60_actions:
door578A:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget OPERATING_MORGE_ROOM, door58EF
	playerPosition 384, 208, FACING_SOUTH

door5795:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget OPERATING_MORGE_ROOM, door57AB
	playerPosition 120, -224, FACING_WEST

door57A0:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget OPERATING_MORGE_ROOM, door5725
	playerPosition -200, 208, FACING_SOUTH

door57AB:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget OPERATING_MORGE_ROOM, door5795
	playerPosition -56, -96, FACING_EAST

	checkAction
	pickItem ROOM60_RED_HERB, RED_HERB
	playerPosition 656, 208, FACING_SOUTH

	checkAction
	pickItem ROOM60_MAGNUM_ROUNDS, MAGNUM_ROUNDS
	playerPosition -48, -456, FACING_EAST

	roomEntity OPERATING_ROOM_LADDER, OPERATING_ROOM_LADDER_VARID
	roomEntityPos 288, -176, FACING_WEST

	roomEntity OPERATING_ROOM_BOX, OPERATING_ROOM_BOX_VARID
	roomEntityPos 560, -544, FACING_WEST

	endRoomActions

room61_actions:
door57E3:
	doorType DOUBLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LAB_B3F_WEST_CORRIDOR, door571A
	playerPosition -720, -16, FACING_WEST

door57EE:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LAB_B3F_WEST_CORRIDOR, door5853
	playerPosition -576, -96, FACING_NORTH

door57F9:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LAB_B3F_WEST_CORRIDOR, door581B
	playerPosition 128, 96, FACING_SOUTH

door5804:
	doorType DOUBLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LAB_B3F_WEST_CORRIDOR, door58B7
	playerPosition 720, 0, FACING_EAST

	checkAction
	roomInteraction 8
	playerPosition 672, 96, FACING_SOUTH

	endRoomActions

room62_actions:
door581B:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LAB_RESEARCHER_ROOM, door57F9
	playerPosition -288, 208, FACING_SOUTH

	roomEntity ZOMBIE, 166
	roomEntityPos -176, -32, FACING_NORTH

	roomEntity ZOMBIE, 167
	roomEntityPos -80, -280, FACING_NORTH

	roomEntity ZOMBIE, 168
	roomEntityPos 56, 128, FACING_NORTH

	checkAction
	pickItem ROOM62_NOTHING_ITEM_2, NOTHING_ITEM_2
	playerPosition -400, -208, FACING_WEST

	endRoomActions

room63_actions:
door5853:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget XRAY_ROOM, door57EE
	playerPosition 304, 288, FACING_EAST

	checkOnFloorAction
	pickItem ROOM63_GREEN_HERB, GREEN_HERB
	playerPosition -272, -352, FACING_WEST

	checkAction
	pickItem ROOM63_CLIP, CLIP
	playerPosition 224, -136, FACING_EAST

	checkAction
	pickItem ROOM63_NOTHING_ITEM_3, NOTHING_ITEM_3
	playerPosition -112, 296, FACING_SOUTH

	roomEntity XRAY_ROOM_SHELF, XRAY_ROOM_SHELF_VARID
	roomEntityPos -280, 128, FACING_SOUTH

	checkAction
	roomInteraction 8
	playerPosition -304, 128, FACING_WEST

	checkAction
	roomInteraction 9
	playerPosition 304, 104, FACING_EAST

	checkAction
	roomInteraction 10
	playerPosition 0, -400, FACING_NORTH

	endRoomActions

room64_actions:
door58AC:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget DETENTION_ROOM_PASSAGE, door59DE
	playerPosition 144, -248, FACING_SOUTH

door58B7:
	doorType DOUBLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget DETENTION_ROOM_PASSAGE, door5804
	playerPosition -248, 816, FACING_EAST

	endRoomActions

room65_actions:
door58C3:
	doorType MANSION_ELEVATOR_1
	doorTarget LAB_ELEVATOR_ENTRY, door59C7
	playerPosition 888, 208, FACING_SOUTH

door58CE:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LAB_ELEVATOR_ENTRY, door596B
	playerPosition -1232, -96, FACING_WEST

door58D9:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LAB_ELEVATOR_ENTRY, door5730
	playerPosition 0, -976, FACING_NORTH

door58E4:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LAB_ELEVATOR_ENTRY, door591D
	playerPosition 0, 8, FACING_SOUTH

door58EF:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LAB_ELEVATOR_ENTRY, door578A
	playerPosition 72, -656, FACING_EAST

	roomEntity ZOMBIE, 169
	roomEntityPos 512, -56, FACING_NORTH

	roomEntity ZOMBIE, 170
	roomEntityPos -504, -56, FACING_NORTH

	checkAction
	roomInteraction 8
	playerPosition 776, 120, FACING_WEST

	endRoomActions

room66_actions:
	endRoomActions

room67_actions:
door591D:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LAB_B3F_LOUNGE, door58E4
	playerPosition 256, -208, FACING_EAST

	checkOnFloorAction
	pickItem ROOM67_GREEN_HERB, GREEN_HERB
	playerPosition -184, 192, FACING_WEST

	checkOnFloorAction
	pickItem ROOM67_BLUE_HERB, BLUE_HERB
	playerPosition 80, 192, FACING_EAST

	checkAction
	pickItem ROOM67_NOTHING_ITEM_10, NOTHING_ITEM_10
	playerPosition 168, 264, FACING_SOUTH

	checkAction
	pickItem ROOM67_MAGNUM_ROUNDS, MAGNUM_ROUNDS
	playerPosition -152, -24, FACING_WEST

	typewriterAction
	playerPosition 256, 264, FACING_SOUTH

	itemboxAction
	playerPosition -104, -320, FACING_WEST

	endRoomActions

room68_actions:
door596B:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget POWER_ROOM_PASSAGE_1, door58CE
	playerPosition 56, -720, FACING_NORTH

door5976:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget POWER_ROOM_PASSAGE_1, door598D
	playerPosition 792, 488, FACING_SOUTH

	checkAction
	roomInteraction 8
	playerPosition -760, 760, FACING_WEST

	endRoomActions

room69_actions:
door598D:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget POWER_ROOM_PASSAGE_2, door5976
	playerPosition 880, -592, FACING_NORTH

door5998:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget POWER_ROOM_PASSAGE_2, door59A4
	playerPosition 200, 584, FACING_SOUTH

	endRoomActions

room6A_actions:
door59A4:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LAB_POWER_ROOM, door5998
	playerPosition 48, -464, FACING_NORTH

	checkAction
	roomInteraction 8
	playerPosition -544, 328, FACING_NORTH

	checkAction
	roomInteraction 9
	playerPosition 680, 152, FACING_WEST

	endRoomActions

room6B_actions:
	endRoomActions

room6C_actions:
door59C7:
	doorType MANSION_ELEVATOR_2
	doorTarget MAIN_LAB_ENTRY, door58C3
	playerPosition 720, -256, FACING_EAST

door59D2:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget MAIN_LAB_ENTRY, door59EA
	playerPosition -608, 464, FACING_SOUTH

	endRoomActions

room6D_actions:
door59DE:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget DETENTION_ROOM, door58AC
	playerPosition -40, 256, FACING_SOUTH

	endRoomActions

room6E_actions:
door59EA:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget MAIN_LABORATORY, door59D2
	playerPosition -624, -712, FACING_NORTH

	checkAction
	roomInteraction 8
	playerPosition -352, 848, FACING_SOUTH

	checkAction
	roomInteraction 8
	playerPosition -320, 848, FACING_SOUTH

	checkAction
	roomInteraction 8
	playerPosition -288, 848, FACING_SOUTH

	endRoomActions

room6F_actions:
door5A17:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget LARGE_GALLERY, door4479
	playerPosition -864, -336, FACING_NORTH

	checkAction
	pickItem ROOM6F_STAR_CREST, STAR_CREST
	playerPosition -976, 208, FACING_WEST

	checkAction
	roomInteraction 8
	playerPosition -312, -48, FACING_SOUTH

	checkAction
	roomInteraction 9
	playerPosition -120, -48, FACING_SOUTH

	checkAction
	roomInteraction 10
	playerPosition 80, -48, FACING_SOUTH

	checkAction
	roomInteraction 11
	playerPosition 232, 56, FACING_NORTH

	checkAction
	roomInteraction 12
	playerPosition 112, 56, FACING_NORTH

	checkAction
	roomInteraction 13
	playerPosition -144, 56, FACING_NORTH

	checkAction
	roomInteraction 14
	playerPosition -464, 56, FACING_NORTH

	checkAction
	roomInteraction 7
	playerPosition -976, 208, FACING_WEST

	endRoomActions

room70_actions:
door5A86:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget EAST_STOREROOM, door452B
	playerPosition -120, 240, FACING_SOUTH

	checkOnFloorAction
	pickItem ROOM70_CHEMICAL, CHEMICAL
	playerPosition 144, -200, FACING_NORTH

	checkOnFloorAction
	pickItem ROOM70_F_AID_SPRAY, F_AID_SPRAY
	playerPosition -8, -128, FACING_NORTH

	checkOnFloorAction
	pickItem ROOM70_SHELLS, SHELLS
	playerPosition 240, -80, FACING_NORTH

	checkOnFloorAction
	pickItem ROOM70_CLIP, CLIP
	playerPosition 208, 40, FACING_NORTH

	typewriterAction
	playerPosition 240, 240, FACING_SOUTH

	itemboxAction
	playerPosition -136, -240, FACING_NORTH

	checkAction
	roomInteraction 0
	playerPosition 104, -240, FACING_NORTH

	checkAction
	roomInteraction 1
	playerPosition 208, -240, FACING_NORTH

	endRoomActions

room71_actions:
door5AEA:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget COURTYARD_STUDY, door4484
	playerPosition 80, 208, FACING_SOUTH

	checkAction
	pickItem ROOM71_MAGNUM_ROUNDS, MAGNUM_ROUNDS
	playerPosition -8, -144, FACING_NORTH

	checkAction
	pickItem ROOM71_DOOM_BOOK_2, DOOM_BOOK_2
	playerPosition -128, -8, FACING_WEST

	checkAction
	roomInteraction 8
	playerPosition -40, -144, FACING_NORTH

	endRoomActions

room72_actions:
door5B17:
	doorType SINGLE_DOOR_A, DOOR_BLUE_PAL
	doorTarget MAIN_HALL_1F, 0
	playerPosition 0, 0, FACING_NORTH

	checkAction
	pickItem ROOM72_SMALL_KEY_6, SMALL_KEY_6
	playerPosition -80, -184, FACING_NORTH

	roomEntity ZOMBIE, 200
	roomEntityPos 920, 120, FACING_NORTH

	endRoomActions

room73_actions:
door5B39:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget MANSION_KITCHEN, door45BC
	playerPosition -568, -384, FACING_EAST

door5B44:
	doorType SINGLE_DOOR_A, DOOR_BROWN_PAL
	doorTarget MANSION_KITCHEN, door4804
	playerPosition -280, 272, FACING_SOUTH

door5B4F:
	doorType MANSION_ELEVATOR_4
	doorTarget MANSION_KITCHEN, door491C
	playerPosition 920, -88, FACING_WEST

	endRoomActions

