event_421B:
	loadRoom MAIN_HALL_1F, 0
	loadEntityData CHRIS_DATA, 256, -768, FACING_EAST, IDLE_ANIM, 0
	loadEntityData JILL_DATA, -192, -576, FACING_SOUTH_WEST, GUN_AIM_ANIM, 8
	loadEntityData WESKER_DATA, -128, -864, FACING_NORTH_WEST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	changeRoomCamera 6
	eventWait 60
	changeEntityAnimation NPC1_ANIM, GUN_AIM_ANIM, 16
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	eventWait 15
	showEntityMessage JILL_MESSAGE, text_pointer_418F
	eventWait 100
	changeRoomCamera 1
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	showEntityMessage CHRIS_MESSAGE, text_pointer_4192
	eventWait 25
	changeEntityFacing PLAYER_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	eventWait 50
	showEntityMessage WESKER_MESSAGE, text_pointer_4195
	eventWait 20
	changeRoomCamera 2
	eventWait 50
	showEntityMessage JILL_MESSAGE, text_pointer_4198
	eventWait 50
	changeRoomCamera 1
	playSfx FIREGUN_SFX
	showEntityMessage JILL_MESSAGE, text_pointer_419B
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	eventWait 30
	moveEntityForward PLAYER_RUN, 16
	eventWait 50
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	changeEntityFacing PLAYER_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	showEntityMessage CHRIS_MESSAGE, text_pointer_419E
	eventWait 50
	moveEntityForward NPC2_WALK, 24
	changeEntityAnimation NPC2_ANIM, IDLE_ANIM, 0
	showEntityMessage WESKER_MESSAGE, text_pointer_41A1
	eventWait 30
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	moveEntityForward PLAYER_WALK, 16
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, 2
	moveEntityForward PLAYER_WALK, 40
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	changeRoomCamera 5
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	showEntityMessage JILL_MESSAGE, text_pointer_41A4
	changeEntityFacing PLAYER_FACING, FACING_CCW_DIR, FACING_WEST
	eventWait 150
	changeRoomCamera 6
	showEntityMessage JILL_MESSAGE, text_pointer_41A7
	eventWait 100
	changeRoomCamera 5
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, FACING_WEST
	moveEntityForward PLAYER_WALK, 28
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, 2
	moveEntityForward PLAYER_WALK, 32
	showDoorAnimation DOUBLE_DOOR_A, DOOR_BROWN_PAL
	loadEntityData CHRIS_DATA, -912, 0, FACING_WEST, IDLE_ANIM, 0
	loadRoom DINNING_ROOM_1F, 0
	endEventScript


event_42CD:
	loadRoom MAIN_HALL_1F, 5
	loadEntityData CHRIS_DATA, 976, 88, FACING_SOUTH_EAST, IDLE_ANIM, 0
	loadEntityData JILL_DATA, -192, -576, FACING_SOUTH_WEST, IDLE_ANIM, 24
	loadEntityData WESKER_DATA, -128, -864, FACING_NORTH_WEST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	moveEntityForward PLAYER_WALK, 70
	changeRoomCamera 6
	eventWait 50
	moveEntityForward NPC2_WALK, 30
	eventWait 50
	showEntityMessage WESKER_MESSAGE, text_pointer_41AA
	eventWait 150
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, FACING_WEST
	moveEntityForward PLAYER_WALK, 70
	showDoorAnimation DOUBLE_DOOR_A, DOOR_BROWN_PAL
	loadEntityData CHRIS_DATA, -912, 0, FACING_WEST, IDLE_ANIM, 0
	loadRoom DINNING_ROOM_1F, 0
	endEventScript


event_431C:
	loadRoom MAIN_HALL_1F, 5
	loadEntityData CHRIS_DATA, 976, 88, FACING_SOUTH_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	moveEntityForward PLAYER_WALK, 40
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, 2
	changeRoomCamera 6
	moveEntityForward PLAYER_WALK, 80
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	eventWait 100
	moveEntityForward PLAYER_RUN, 16
	moveEntityForward PLAYER_RUN, 10
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, 6
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	eventWait 30
	showEntityMessage CHRIS_MESSAGE, text_pointer_41AD
	eventWait 120
	changeEntityFacing PLAYER_FACING, FACING_CCW_DIR, 6
	changeEntityFacing PLAYER_FACING, FACING_CCW_DIR, 2
	moveEntityForward PLAYER_RUN, 16
	changeRoomCamera 2
	moveEntityForward PLAYER_RUN, 3
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	eventWait 100
	changeEntityFacing PLAYER_FACING, FACING_CCW_DIR, FACING_WEST
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 24
	eventWait 60
	showEntityMessage CHRIS_MESSAGE, text_pointer_41B0
	eventWait 100
	screenPanningDown
	endEventScript


event_436D:
	loadRoom WEST_STOREROOM, 2
	loadEntityData CHRIS_DATA, -96, 384, FACING_SOUTH_WEST, IDLE_ANIM, 0
	loadEntityData REBECCA_DATA, 152, -8, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	showEntityMessage CHRIS_MESSAGE, text_pointer_41B3
	eventWait 100
	changeRoomCamera 0
	moveEntityForward NPC3_WALK, 24
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 0
	eventWait 40
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 24
	showEntityMessage REBECCA_MESSAGE, text_pointer_41B6
	eventWait 150
	showEntityMessage CHRIS_MESSAGE, text_pointer_41B9
	eventWait 150
	changeRoomCamera 1
	showEntityMessage REBECCA_MESSAGE, text_pointer_41BC
	eventWait 150
	showEntityMessage REBECCA_MESSAGE, text_pointer_41BF
	eventWait 150
	changeRoomCamera 2
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 24
	showEntityMessage CHRIS_MESSAGE, text_pointer_41C2
	eventWait 150
	showEntityMessage CHRIS_MESSAGE, text_pointer_41C5
	eventWait 150
	changeRoomCamera 1
	showEntityMessage REBECCA_MESSAGE, text_pointer_41C8
	eventWait 150
	changeRoomCamera 2
	showEntityMessage CHRIS_MESSAGE, text_pointer_41CB
	eventWait 150
	changeRoomCamera 1
	showEntityMessage REBECCA_MESSAGE, text_pointer_41CE
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 0
	eventWait 150
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 24
	showEntityMessage REBECCA_MESSAGE, text_pointer_41D1
	eventWait 150
	showEntityMessage REBECCA_MESSAGE, text_pointer_41D4
	eventWait 150
	changeRoomCamera 0
	eventWait 150
	endEventScript


event_43ED:
	loadRoom WEST_STOREROOM, 0
	loadEntityData CHRIS_DATA, 80, 232, FACING_WEST, IDLE_ANIM, 0
	loadEntityData REBECCA_DATA, 160, 232, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 0
	eventWait 30
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 24
	showEntityMessage REBECCA_MESSAGE, text_pointer_41D7
	eventWait 150
	endEventScript


event_441E:
	loadRoom WEST_STOREROOM, 2
	loadEntityData CHRIS_DATA, -112, 336, FACING_NORTH, IDLE_ANIM, 0
	loadEntityData REBECCA_DATA, 80, -80, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 100
	screenPanningUp
	eventWait 100
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, 6
	eventWait 30
	changeRoomCamera 1
	showEntityMessage REBECCA_MESSAGE, text_pointer_41DA
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 24
	eventWait 150
	showEntityMessage REBECCA_MESSAGE, text_pointer_41DD
	eventWait 130


event_4451:
	loadRoom WEST_STOREROOM, 0
	loadEntityData CHRIS_DATA, 80, 232, FACING_WEST, IDLE_ANIM, 0
	loadEntityData REBECCA_DATA, 160, 232, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 150
	showEntityMessage CHRIS_MESSAGE, text_pointer_41E0
	eventWait 150
	showEntityMessage REBECCA_MESSAGE, text_pointer_41E3
	eventWait 150
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 24
	showEntityMessage REBECCA_MESSAGE, text_pointer_41E6
	changeEntityFacing PLAYER_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	eventWait 150
	screenFadeOut
	screenPanningDown
	endEventScript


event_4488:
	loadRoom PIANO_ROOM, 1
	loadEntityData CHRIS_DATA, -120, 8, FACING_NORTH, IDLE_ANIM, 0
	loadEntityData REBECCA_DATA, 416, -584, FACING_NORTH, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	playSfx OPEN_DOOR_SFX
	eventWait 15
	playSfx CLOSE_DOOR_SFX
	changeRoomCamera 5
	eventWait 150
	showEntityMessage REBECCA_MESSAGE, text_pointer_41E9
	eventWait 150
	moveEntityForward NPC3_WALK, 40
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 0
	eventWait 150
	showEntityMessage CHRIS_MESSAGE, text_pointer_41EC
	eventWait 150
	changeRoomCamera 1
	moveEntityForward NPC3_WALK, 60
	changeEntityFacing NPC3_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC3_WALK, 60
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 0
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	eventWait 30
	showEntityMessage REBECCA_MESSAGE, text_pointer_41EF
	eventWait 150
	showEntityMessage CHRIS_MESSAGE, text_pointer_41F2
	eventWait 150
	changeRoomCamera 6
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, 2
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 24
	moveEntityBackward PLAYER_BACKWARD_WALK, 40
	moveEntityForward NPC3_WALK, 40
	changeEntityFacing NPC3_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC3_WALK, 10
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 0
	eventWait 100
	showEntityMessage CHRIS_MESSAGE, text_pointer_41F5
	eventWait 150
	showEntityMessage REBECCA_MESSAGE, text_pointer_41F8
	eventWait 150
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 24
	showEntityMessage REBECCA_MESSAGE, text_pointer_41FB
	eventWait 150
	showEntityMessage CHRIS_MESSAGE, text_pointer_41FE
	eventWait 150
	showEntityMessage REBECCA_MESSAGE, text_pointer_4201
	changeRoomCamera 1
	eventWait 150
	endEventScript


event_4512:
	loadRoom PIANO_ROOM, 0
	loadEntityData CHRIS_DATA, 464, -584, FACING_EAST, IDLE_ANIM, 0
	loadEntityData REBECCA_DATA, -168, 8, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	playSfx CLOSE_DOOR_SFX
	showEntityMessage REBECCA_MESSAGE, text_pointer_4204
	eventWait 60
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, 2
	moveEntityForward PLAYER_WALK, 40
	changeRoomCamera 1
	moveEntityForward PLAYER_WALK, 20
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, 2
	moveEntityForward PLAYER_WALK, 40
	changeEntityFacing PLAYER_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	eventWait 30
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 24
	eventWait 150
	showEntityMessage REBECCA_MESSAGE, text_pointer_4207
	eventWait 150
	changeRoomCamera 6
	eventWait 60
	eventWait 60
	showEntityMessage CHRIS_MESSAGE, text_pointer_420A
	eventWait 150
	changeRoomCamera 1
	eventWait 30
	moveEntityForward PLAYER_RUN, 40
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	eventWait 100
	eventWait 150
	showEntityMessage REBECCA_MESSAGE, text_pointer_420D
	eventWait 150
	endEventScript


event_4574:
	loadRoom ATTIC_ENTRY, 1
	loadEntityData CHRIS_DATA, 88, -336, FACING_NORTH, IDLE_ANIM, 0
	loadEntityData REBECCA_DATA, 144, 336, FACING_SOUTH, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	moveEntityForward PLAYER_WALK, 20
	moveEntityForward PLAYER_WALK, 10
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	eventWait 5
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 24
	eventWait 5
	changeEntityAnimation PLAYER_ANIM, PICK_ITEM_ANIM, 0
	showEntityMessage CHRIS_MESSAGE, text_pointer_4339
	eventWait 150
	playSfx CLOSE_DOOR_SFX
	moveEntityForward NPC3_WALK, 23
	eventWait 80
	endEventScript


event_45B1:
	loadRoom WEST_STOREROOM, 4
	loadEntityData CHRIS_DATA, 104, -88, FACING_NORTH, PICK_ITEM_ANIM, 0
	loadEntityData REBECCA_DATA, -144, 336, FACING_SOUTH, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 100
	screenPanningUp
	eventWait 100
	showEntityMessage REBECCA_MESSAGE, text_pointer_4204
	eventWait 150
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	showEntityMessage CHRIS_MESSAGE, text_pointer_4210
	eventWait 150
	changeRoomCamera 2
	showEntityMessage REBECCA_MESSAGE, text_pointer_4213
	eventWait 150
	changeRoomCamera 4
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	showEntityMessage CHRIS_MESSAGE, text_pointer_4216
	eventWait 150
	changeRoomCamera 2
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 24
	showEntityMessage REBECCA_MESSAGE, text_pointer_4219
	eventWait 150
	changeRoomCamera 4
	showEntityMessage CHRIS_MESSAGE, text_pointer_421C
	eventWait 150
	changeRoomCamera 2
	showEntityMessage REBECCA_MESSAGE, text_pointer_421F
	eventWait 150
	changeRoomCamera 4
	showEntityMessage CHRIS_MESSAGE, text_pointer_4222
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	eventWait 150
	endEventScript


event_4612:
	loadRoom DORMITORY_CORRIDOR, 3
	loadEntityData CHRIS_DATA, 712, 528, FACING_EAST, IDLE_ANIM, 0
	loadEntityData WESKER_DATA, 152, 808, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	screenPanningUp
	eventWait 100
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	playSfx FIREGUN_SFX
	eventWait 20
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	moveEntityForward PLAYER_RUN, 30
	changeRoomCamera 2
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	changeEntityFacing PLAYER_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	playSfx FIREGUN_SFX
	changeEntityAnimation NPC2_ANIM, GUN_AIM_ANIM, 0
	eventWait 50
	playSfx FIREGUN_SFX
	showEntityMessage CHRIS_MESSAGE, text_pointer_43D2
	changeEntityAnimation NPC2_ANIM, GUN_AIM_ANIM, 16
	changeEntityAnimation NPC2_ANIM, IDLE_ANIM, 0
	eventWait 120
	changeRoomCamera 7
	changeEntityFacing NPC2_FACING, FACING_CW_DIR, FACING_WEST
	showEntityMessage WESKER_MESSAGE, text_pointer_43D5
	eventWait 100
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 24
	showEntityMessage CHRIS_MESSAGE, text_pointer_43D8
	moveEntityForward PLAYER_WALK, 40
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	eventWait 100
	showEntityMessage CHRIS_MESSAGE, text_pointer_43DB
	eventWait 100
	showEntityMessage WESKER_MESSAGE, text_pointer_43DE
	eventWait 100
	changeEntityAnimation NPC2_ANIM, IDLE_ANIM, 24
	showEntityMessage CHRIS_MESSAGE, text_pointer_43E1
	eventWait 100
	changeRoomCamera 1
	moveEntityForward NPC2_WALK, 10
	changeRoomCamera 2
	moveEntityForward NPC2_WALK, 63
	changeEntityFacing NPC2_FACING, FACING_CW_DIR, FACING_WEST
	eventWait 10
	showEntityMessage WESKER_MESSAGE, text_pointer_43E4
	eventWait 80
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 24
	changeEntityFacing NPC2_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC2_WALK, 6
	loadEntityData WESKER_DATA, -720, 976, FACING_SOUTH, IDLE_ANIM, 0
	updateBgAndSprites
	endEventScript


event_46A3:
	loadRoom SHED_PASSAGE, 1
	loadEntityData CHRIS_DATA, -120, -80, FACING_NORTH, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	moveEntityForward PLAYER_WALK, 20
	showEntityMessage CHRIS_MESSAGE, text_pointer_4444
	changeEntityAnimation PLAYER_ANIM, PICK_ITEM_ANIM, 0
	showEntityMessage CHRIS_MESSAGE, text_pointer_4537
	eventWait 100
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	eventWait 100
	endEventScript


event_46CB:
	loadRoom BACK_ENTRANCE_CORRIDOR, 2
	loadEntityData CHRIS_DATA, 528, 48, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	showEntityMessage CHRIS_MESSAGE, text_pointer_455E
	eventWait 100
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, 2
	eventWait 5
	changeEntityFacing PLAYER_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	eventWait 5
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, 2
	showEntityMessage CHRIS_MESSAGE, text_pointer_453A
	eventWait 100
	endEventScript


event_46F8:
	loadRoom WEST_STAIRCASE_1F, 4
	loadEntityData CHRIS_DATA, -320, 768, FACING_WEST, IDLE_ANIM, 0
	loadEntityData ZOMBIE_DATA, 504, 504, FACING_NORTH, IDLE_ANIM, 0
	loadEntityData REBECCA_DATA, 504, 688, FACING_SOUTH, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	moveEntityBackward NPC3_BACKWARD_WALK, 5
	moveEntityForward NPC6_WALK, 5
	moveEntityBackward NPC3_BACKWARD_WALK, 5
	moveEntityForward NPC6_WALK, 5
	moveEntityBackward NPC3_BACKWARD_WALK, 5
	moveEntityForward NPC6_WALK, 5
	moveEntityBackward NPC3_BACKWARD_WALK, 5
	moveEntityForward NPC6_WALK, 5
	moveEntityBackward NPC3_BACKWARD_WALK, 5
	moveEntityForward NPC6_WALK, 5
	moveEntityBackward NPC3_BACKWARD_WALK, 5
	moveEntityForward NPC6_WALK, 5
	eventWait 100
	changeRoomCamera 5
	moveEntityBackward NPC3_BACKWARD_WALK, 2
	moveEntityForward NPC6_WALK, 5
	moveEntityBackward NPC3_BACKWARD_WALK, 2
	moveEntityForward NPC6_WALK, 5
	moveEntityBackward NPC3_BACKWARD_WALK, 2
	moveEntityForward NPC6_WALK, 5
	moveEntityBackward NPC3_BACKWARD_WALK, 2
	moveEntityForward NPC6_WALK, 5
	changeEntityAnimation NPC6_ANIM, GUN_AIM_ANIM, 0
	eventWait 40
	changeEntityAnimation PLAYER_ANIM, GUN_AIM_ANIM, 16
	changeEntityAnimation PLAYER_ANIM, GUN_AIM_ANIM, 8
	showEntityMessage CHRIS_MESSAGE, text_pointer_4420
	changeEntityFacing NPC6_FACING, FACING_CCW_DIR, 6
	eventWait 20
	moveEntityForward NPC6_WALK, 20
	changeRoomCamera 3
	changeEntityFacing NPC6_FACING, FACING_CW_DIR, 2
	moveEntityForward NPC6_WALK, 50
	eventWait 100


event_476B:
	loadRoom WEST_STAIRCASE_1F, 5
	loadEntityData CHRIS_DATA, 472, 704, FACING_NORTH, GUN_AIM_ANIM, 8
	loadEntityData REBECCA_DATA, 584, 912, FACING_SOUTH_EAST, GUN_AIM_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	changeEntityAnimation PLAYER_ANIM, GUN_AIM_ANIM, 16
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	showEntityMessage CHRIS_MESSAGE, text_pointer_453D
	eventWait 150
	showEntityMessage REBECCA_MESSAGE, text_pointer_4540
	eventWait 150
	showEntityMessage CHRIS_MESSAGE, text_pointer_4543
	eventWait 150
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 0
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 24
	showEntityMessage REBECCA_MESSAGE, text_pointer_4546
	eventWait 150
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 24
	showEntityMessage CHRIS_MESSAGE, text_pointer_4549
	eventWait 150
	showEntityMessage CHRIS_MESSAGE, text_pointer_454C
	eventWait 150
	showEntityMessage CHRIS_MESSAGE, text_pointer_4552
	eventWait 150
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 0
	showEntityMessage REBECCA_MESSAGE, text_pointer_454F
	eventWait 150
	showEntityMessage CHRIS_MESSAGE, text_pointer_4555
	eventWait 150
	showEntityMessage REBECCA_MESSAGE, text_pointer_4558
	eventWait 150
	showEntityMessage CHRIS_MESSAGE, text_pointer_455B
	eventWait 150
	changeEntityFacing PLAYER_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	changeRoomCamera 2
	eventWait 20
	screenFadeOut
	screenPanningDown
	endEventScript


event_47DD:
	loadRoom UNDERGROUND_SOUTH_PASSAGE, 3
	loadEntityData CHRIS_DATA, 544, 720, FACING_WEST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	moveEntityForward PLAYER_WALK, 5
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	moveEntityForward PLAYER_WALK, 10
	showEntityMessage CHRIS_MESSAGE, text_pointer_438A
	moveEntityForward PLAYER_WALK, 50
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, 2
	eventWait 150
	changeRoomCamera 5
	moveEntityForward PLAYER_WALK, 40
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	showEntityMessage ENRICO_MESSAGE, text_pointer_4345
	eventWait 150
	showEntityMessage CHRIS_MESSAGE, text_pointer_4348
	eventWait 150
	showEntityMessage ENRICO_MESSAGE, text_pointer_434B
	eventWait 150
	showEntityMessage CHRIS_MESSAGE, text_pointer_434E
	eventWait 150
	changeRoomCamera 7
	playSfx FIREGUN_SFX
	showEntityMessage ENRICO_MESSAGE, text_pointer_4354
	eventWait 150
	changeRoomCamera 4
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	showEntityMessage CHRIS_MESSAGE, text_pointer_4351
	playSfx STEPS_SFX
	eventWait 20
	playSfx STEPS_SFX
	eventWait 20
	playSfx STEPS_SFX
	eventWait 20
	playSfx STEPS_SFX
	eventWait 20
	playSfx STEPS_SFX
	eventWait 20
	eventWait 50
	changeRoomCamera 3
	playSfx STEPS_SFX
	eventWait 20
	playSfx STEPS_SFX
	eventWait 20
	playSfx STEPS_SFX
	eventWait 20
	playSfx STEPS_SFX
	eventWait 20
	playSfx STEPS_SFX
	eventWait 20
	playSfx STEPS_SFX
	eventWait 20
	eventWait 10
	changeRoomCamera 5
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 24
	showEntityMessage CHRIS_MESSAGE, text_pointer_4357
	eventWait 150
	endEventScript


event_4869:
	loadRoom DETENTION_ROOM_PASSAGE, 2
	loadEntityData CHRIS_DATA, 192, -248, FACING_SOUTH, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	showEntityMessage JILL_MESSAGE, text_pointer_43F0
	eventWait 50
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, FACING_WEST
	eventWait 100
	changeRoomCamera 3
	showEntityMessage CHRIS_MESSAGE, text_pointer_43F3
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_43F6
	eventWait 150
	showEntityMessage CHRIS_MESSAGE, text_pointer_43F9
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_43FC
	eventWait 150
	changeRoomCamera 2
	eventWait 150
	screenFadeOut
	endEventScript


event_48A3:
	loadRoom LAB_ELEVATOR_ENTRY, 3
	loadEntityData CHRIS_DATA, 912, 208, FACING_EAST, IDLE_ANIM, 0
	loadEntityData REBECCA_DATA, 0, -440, FACING_NORTH, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	eventWait 100
	changeRoomCamera 2
	showEntityMessage REBECCA_MESSAGE, text_pointer_4399
	moveEntityForward NPC3_RUN, 15
	changeEntityFacing NPC3_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC3_RUN, 70
	changeEntityFacing NPC3_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC3_RUN, 30
	changeEntityFacing NPC3_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	eventWait 60
	changeRoomCamera 3
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 0
	showEntityMessage CHRIS_MESSAGE, text_pointer_43EA
	eventWait 100
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 24
	showEntityMessage REBECCA_MESSAGE, text_pointer_43ED
	eventWait 100
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 24
	showEntityMessage CHRIS_MESSAGE, text_pointer_43FF
	eventWait 100
	showEntityMessage REBECCA_MESSAGE, text_pointer_453D
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 0
	showEntityMessage REBECCA_MESSAGE, text_pointer_454F
	changeEntityFacing PLAYER_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	changeEntityFacing NPC3_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC3_WALK, 10
	eventWait 100
	screenFadeOut
	screenPanningDown
	loadRoom HELIPORT_ELEVATOR, 0
	loadEntityData CHRIS_DATA, 0, -64, FACING_EAST, IDLE_ANIM, 0
	loadEntityData REBECCA_DATA, 0, 64, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	eventWait 150
	loadRoom MAIN_LAB_ENTRY, 0
	loadEntityData CHRIS_DATA, 720, -136, FACING_EAST, IDLE_ANIM, 0
	loadEntityData REBECCA_DATA, 720, -312, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	eventWait 50
	moveEntityForward PLAYER_WALK, 5
	moveEntityForward NPC3_WALK, 5
	moveEntityForward PLAYER_WALK, 5
	moveEntityForward NPC3_WALK, 5
	moveEntityForward PLAYER_WALK, 5
	moveEntityForward NPC3_WALK, 5
	moveEntityForward PLAYER_WALK, 5
	moveEntityForward NPC3_WALK, 5
	moveEntityForward PLAYER_WALK, 5
	moveEntityForward NPC3_WALK, 5
	moveEntityForward PLAYER_WALK, 5
	moveEntityForward NPC3_WALK, 5
	moveEntityForward PLAYER_WALK, 5
	moveEntityForward NPC3_WALK, 5
	moveEntityForward PLAYER_WALK, 5
	moveEntityForward NPC3_WALK, 5
	moveEntityForward PLAYER_WALK, 5
	moveEntityForward NPC3_WALK, 5
	moveEntityForward PLAYER_WALK, 5
	moveEntityForward NPC3_WALK, 5
	moveEntityForward PLAYER_WALK, 5
	moveEntityForward NPC3_WALK, 5
	moveEntityForward PLAYER_WALK, 5
	moveEntityForward NPC3_WALK, 5
	moveEntityForward PLAYER_WALK, 5
	moveEntityForward NPC3_WALK, 5
	moveEntityForward PLAYER_WALK, 5
	moveEntityForward NPC3_WALK, 5
	moveEntityForward PLAYER_WALK, 5
	moveEntityForward NPC3_WALK, 5
	moveEntityForward PLAYER_WALK, 5
	moveEntityForward NPC3_WALK, 5
	moveEntityForward PLAYER_WALK, 5
	moveEntityForward NPC3_WALK, 5
	moveEntityForward PLAYER_WALK, 5
	moveEntityForward NPC3_WALK, 5
	moveEntityForward PLAYER_WALK, 5
	moveEntityForward NPC3_WALK, 5
	moveEntityForward PLAYER_WALK, 5
	moveEntityForward NPC3_WALK, 5
	eventWait 90
	changeRoomCamera 1
	eventWait 100


event_4999:
	loadRoom MAIN_LAB_ENTRY, 3
	loadEntityData CHRIS_DATA, -312, 0, FACING_EAST, IDLE_ANIM, 0
	loadEntityData REBECCA_DATA, -312, -432, FACING_EAST, IDLE_ANIM, 0
	loadEntityData WESKER_DATA, -608, 464, FACING_SOUTH, IDLE_ANIM, 24
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	moveEntityForward PLAYER_WALK, 40
	changeEntityFacing NPC3_FACING, FACING_CW_DIR, 2
	moveEntityForward NPC3_WALK, 20
	changeEntityFacing NPC3_FACING, FACING_CW_DIR, 2
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	showEntityMessage WESKER_MESSAGE, text_pointer_4402
	changeEntityAnimation NPC2_ANIM, GUN_AIM_ANIM, 16
	changeEntityAnimation NPC2_ANIM, GUN_AIM_ANIM, 8
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 24
	eventWait 150
	changeRoomCamera 5
	showEntityMessage CHRIS_MESSAGE, text_pointer_4405
	eventWait 150
	changeRoomCamera 2
	showEntityMessage WESKER_MESSAGE, text_pointer_4408
	eventWait 150
	changeRoomCamera 5
	showEntityMessage CHRIS_MESSAGE, text_pointer_440B
	eventWait 150
	changeRoomCamera 3
	showEntityMessage WESKER_MESSAGE, text_pointer_440E
	eventWait 150
	changeRoomCamera 5
	showEntityMessage CHRIS_MESSAGE, text_pointer_4411
	eventWait 150
	changeRoomCamera 2
	showEntityMessage WESKER_MESSAGE, text_pointer_4414
	eventWait 150
	changeRoomCamera 5
	showEntityMessage CHRIS_MESSAGE, text_pointer_4417
	eventWait 150
	showEntityMessage REBECCA_MESSAGE, text_pointer_441A
	eventWait 150
	changeRoomCamera 3
	showEntityMessage WESKER_MESSAGE, text_pointer_441D
	playSfx FIREGUN_SFX
	eventWait 150
	changeRoomCamera 5
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 24
	changeEntityFacing NPC3_FACING, FACING_CW_DIR, 2
	moveEntityForward NPC3_WALK, 11
	changeEntityFacing NPC3_FACING, FACING_CW_DIR, 2
	changeEntityAnimation NPC3_ANIM, GUN_AIM_ANIM, 0
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	showEntityMessage CHRIS_MESSAGE, text_pointer_4420
	eventWait 150
	loadEntityData REBECCA_DATA, 720, -464, FACING_EAST, IDLE_ANIM, 0
	changeRoomCamera 3
	showEntityMessage WESKER_MESSAGE, text_pointer_4423
	eventWait 150
	showEntityMessage WESKER_MESSAGE, text_pointer_4426
	eventWait 150
	showEntityMessage WESKER_MESSAGE, text_pointer_4429
	screenFadeOut
	screenPanningDown
	loadRoom MAIN_LABORATORY, 2
	loadEntityData CHRIS_DATA, -216, 664, FACING_NORTH, IDLE_ANIM, 0
	loadEntityData WESKER_DATA, -440, 520, FACING_NORTH_WEST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	changeRoomCamera 5
	eventWait 150
	changeRoomCamera 6
	eventWait 150
	changeRoomCamera 3
	eventWait 150
	changeRoomCamera 5
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 24
	showEntityMessage CHRIS_MESSAGE, text_pointer_442C
	moveEntityForward NPC2_WALK, 10
	changeEntityFacing NPC2_FACING, FACING_CCW_DIR, 2
	moveEntityForward NPC2_WALK, 20
	changeEntityFacing NPC2_FACING, FACING_CW_DIR, 2
	moveEntityForward NPC2_WALK, 20
	changeEntityFacing NPC2_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	eventWait 150
	showEntityMessage WESKER_MESSAGE, text_pointer_442F
	changeEntityAnimation NPC2_ANIM, GUN_AIM_ANIM, 8
	eventWait 150
	showEntityMessage WESKER_MESSAGE, text_pointer_4432
	eventWait 150
	showEntityMessage WESKER_MESSAGE, text_pointer_4435
	eventWait 150
	showEntityMessage CHRIS_MESSAGE, text_pointer_4438
	eventWait 150
	showEntityMessage CHRIS_MESSAGE, text_pointer_443B
	eventWait 150
	showEntityMessage WESKER_MESSAGE, text_pointer_443E
	changeEntityAnimation NPC2_ANIM, IDLE_ANIM, 0
	changeEntityFacing NPC2_FACING, FACING_CW_DIR, FACING_WEST
	moveEntityForward NPC2_WALK, 15
	changeEntityFacing NPC2_FACING, FACING_CW_DIR, FACING_WEST
	eventWait 150
	changeRoomCamera 6
	eventWait 150
	changeRoomCamera 2
	moveEntityBackward PLAYER_BACKWARD_WALK, 30
	showEntityMessage WESKER_MESSAGE, text_pointer_4441
	moveEntityBackward NPC2_BACKWARD_WALK, 10
	eventWait 150
	showEntityMessage WESKER_MESSAGE, text_pointer_4444
	eventWait 150
	showEntityMessage WESKER_MESSAGE, text_pointer_4447
	changeEntityFacing NPC2_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	eventWait 150
	changeRoomCamera 7
	eventWait 50
	changeRoomCamera 5
	changeRoomCamera 2
	showEntityMessage CHRIS_MESSAGE, text_pointer_444A
	eventWait 150
	screenPanningDown
	endEventScript


event_4AE3:
	loadRoom MAIN_LAB_ENTRY, 2
	loadEntityData CHRIS_DATA, -592, 464, FACING_SOUTH, IDLE_ANIM, 0
	loadEntityData REBECCA_DATA, 96, -272, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	moveEntityForward PLAYER_WALK, 50
	changeEntityFacing PLAYER_FACING, FACING_CCW_DIR, 2
	moveEntityForward PLAYER_WALK, 40
	changeEntityFacing PLAYER_FACING, FACING_CCW_DIR, 2
	changeRoomCamera 1
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 0
	showEntityMessage CHRIS_MESSAGE, text_pointer_444D
	eventWait 150
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 24
	showEntityMessage REBECCA_MESSAGE, text_pointer_4450
	eventWait 150
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 24
	showEntityMessage CHRIS_MESSAGE, text_pointer_4453
	eventWait 150
	showEntityMessage REBECCA_MESSAGE, text_pointer_4456
	eventWait 150
	showEntityMessage CHRIS_MESSAGE, text_pointer_4459
	moveEntityForward PLAYER_RUN, 48
	changeRoomCamera 0
	changeEntityFacing NPC3_FACING, FACING_CW_DIR, FACING_WEST
	moveEntityForward PLAYER_RUN, 6
	moveEntityForward NPC3_RUN, 6
	moveEntityForward PLAYER_RUN, 6
	moveEntityForward NPC3_RUN, 6
	moveEntityForward PLAYER_RUN, 6
	moveEntityForward NPC3_RUN, 6
	moveEntityForward PLAYER_RUN, 6
	moveEntityForward NPC3_RUN, 6
	loadRoom HELIPORT_ELEVATOR, 0
	loadEntityData CHRIS_DATA, 0, -64, FACING_EAST, IDLE_ANIM, 0
	loadEntityData REBECCA_DATA, 0, 64, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	eventWait 150


event_4B65:
	loadRoom LAB_ELEVATOR_ENTRY, 3
	loadEntityData CHRIS_DATA, 824, 208, FACING_SOUTH, IDLE_ANIM, 0
	loadEntityData REBECCA_DATA, 960, 208, FACING_SOUTH, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	eventWait 50
	moveEntityForward PLAYER_RUN, 20
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 24
	showEntityMessage REBECCA_MESSAGE, text_pointer_445C
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, FACING_WEST
	eventWait 100
	showEntityMessage CHRIS_MESSAGE, text_pointer_445F
	eventWait 100
	showEntityMessage REBECCA_MESSAGE, text_pointer_4462
	eventWait 100
	showEntityMessage CHRIS_MESSAGE, text_pointer_4465
	eventWait 100
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 0
	showEntityMessage REBECCA_MESSAGE, text_pointer_4468
	eventWait 100
	showEntityMessage CHRIS_MESSAGE, text_pointer_446B
	changeEntityFacing NPC3_FACING, FACING_CW_DIR, 2
	moveEntityForward NPC3_RUN, 20
	changeEntityFacing PLAYER_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	changeRoomCamera 2
	changeEntityFacing NPC3_FACING, FACING_CW_DIR, 2
	moveEntityForward NPC3_RUN, 96
	playSfx CLOSE_DOOR_SFX
	screenPanningDown
	endEventScript


event_4BBD:
	loadRoom LAB_CENTRAL_CLOISTER, 4
	loadEntityData CHRIS_DATA, 800, 832, FACING_SOUTH_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	showEntityMessage LAB_ALERT_MESSAGE, text_pointer_446E
	eventWait 200
	screenPanningDown
	endEventScript


event_4BDC:
	loadRoom DETENTION_ROOM, 0
	loadEntityData CHRIS_DATA, 0, 256, FACING_SOUTH, IDLE_ANIM, 0
	loadEntityData JILL_DATA, 0, -480, FACING_NORTH, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	showEntityMessage CHRIS_MESSAGE, text_pointer_4471
	eventWait 100
	showEntityMessage JILL_MESSAGE, text_pointer_4474
	moveEntityForward NPC1_RUN, 36
	eventWait 100
	changeRoomCamera 2
	moveEntityForward NPC1_RUN, 12
	showEntityMessage JILL_MESSAGE, text_pointer_4477
	eventWait 100
	changeRoomCamera 0
	showEntityMessage CHRIS_MESSAGE, text_pointer_447A
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, FACING_WEST
	eventWait 100
	endEventScript


event_4C1B:
	loadRoom LAB_B3F_WEST_CORRIDOR, 3
	loadEntityData CHRIS_DATA, 720, -64, FACING_EAST, IDLE_ANIM, 0
	loadEntityData JILL_DATA, 720, 96, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	eventWait 50
	changeRoomCamera 2
	moveEntityForward NPC1_RUN, 60
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 24
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, 6
	showEntityMessage JILL_MESSAGE, text_pointer_43E7
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, 6
	moveEntityForward NPC1_RUN, 96
	changeRoomCamera 3
	endEventScript


event_4C50:
	loadRoom LAB_LADDER_ROOM, 1
	loadEntityData CHRIS_DATA, -16, -336, FACING_NORTH, IDLE_ANIM, 0
	loadEntityData JILL_DATA, -208, 32, FACING_WEST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, 2
	showEntityMessage JILL_MESSAGE, text_pointer_44A1
	moveEntityForward NPC1_RUN, 14
	endEventScript


event_4C78:
	loadRoom EMERGENCY_TUNNEL, 2
	loadEntityData CHRIS_DATA, 200, 592, FACING_SOUTH, IDLE_ANIM, 0
	loadEntityData JILL_DATA, 120, 784, FACING_SOUTH, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	showEntityMessage BRAD_MESSAGE, text_pointer_447D
	eventWait 100
	endEventScript


event_4C9E:
	loadRoom EMERGENCY_TUNNEL, 5
	loadEntityData CHRIS_DATA, -840, -976, FACING_EAST, IDLE_ANIM, 0
	loadEntityData REBECCA_DATA, -648, -40, FACING_SOUTH, IDLE_ANIM, 0
	loadEntityData JILL_DATA, -616, -976, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	moveEntityForward PLAYER_WALK, 20
	changeRoomCamera 4
	moveEntityForward NPC3_RUN, 55
	changeRoomCamera 5
	changeEntityAnimation NPC3_ANIM, IDLE_ANIM, 0
	showEntityMessage REBECCA_MESSAGE, text_pointer_4480
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	moveEntityForward PLAYER_WALK, 20
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	eventWait 100
	changeRoomCamera 6
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 24
	showEntityMessage CHRIS_MESSAGE, text_pointer_4483
	eventWait 100
	changeRoomCamera 5
	changeEntityFacing NPC3_FACING, FACING_CW_DIR, 6
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	eventWait 10
	changeEntityFacing NPC3_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	eventWait 100
	showEntityMessage REBECCA_MESSAGE, text_pointer_4486
	changeEntityFacing NPC3_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	eventWait 100
	showEntityMessage JILL_MESSAGE, text_pointer_4489
	changeEntityAnimation NPC1_ANIM, GUN_AIM_ANIM, 16
	changeEntityAnimation NPC1_ANIM, GUN_AIM_ANIM, 8
	eventWait 100
	changeRoomCamera 6
	showEntityMessage CHRIS_MESSAGE, text_pointer_4492
	eventWait 100
	changeRoomCamera 5
	showEntityMessage JILL_MESSAGE, text_pointer_448C
	eventWait 100
	changeRoomCamera 6
	showEntityMessage CHRIS_MESSAGE, text_pointer_448F
	changeEntityFacing PLAYER_FACING, FACING_CCW_DIR, 6
	eventWait 100
	endEventScript


event_4D1F:
	loadRoom HELIPORT, 1
	loadEntityData CHRIS_DATA, 240, 32, FACING_EAST, PICK_ITEM_ANIM, 0
	loadEntityData ENEMY_9E_DATA, 2040, 2040, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	eventWait 30
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, FACING_WEST
	eventWait 10
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, 2
	eventWait 5
	changeEntityFacing PLAYER_FACING, FACING_CCW_DIR, 2
	eventWait 20
	changeRoomCamera 1
	changeRoomCamera 2
	eventWait 100
	changeRoomCamera 3
	eventWait 100
	changeRoomCamera 1
	eventWait 100
	changeRoomCamera 4
	eventWait 100
	changeRoomCamera 0
	endEventScript


