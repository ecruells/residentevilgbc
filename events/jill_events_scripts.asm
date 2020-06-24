event_4D65:
	resetAllEntitiesData
	loadRoom MAIN_HALL_1F, 0
	loadEntityData BARRY_DATA, 128, -1080, FACING_NORTH, GUN_AIM_ANIM, 8
	loadEntityData JILL_DATA, -128, -1080, FACING_NORTH, GUN_AIM_ANIM, 8
	loadEntityData WESKER_DATA, 0, -1080, FACING_NORTH, GUN_AIM_ANIM, 8
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	changeEntityAnimation NPC2_ANIM, GUN_AIM_ANIM, 16
	changeEntityAnimation NPC2_ANIM, IDLE_ANIM, 0
	changeEntityAnimation NPC4_ANIM, GUN_AIM_ANIM, 16
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 0
	changeEntityAnimation NPC1_ANIM, GUN_AIM_ANIM, 16
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 24
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, 2
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, 2
	moveEntityForward NPC1_WALK, 20
	moveEntityForward NPC4_WALK, 20
	eventWait 10
	changeRoomCamera 1
	moveEntityForward NPC2_WALK, 15
	changeEntityAnimation NPC2_ANIM, IDLE_ANIM, 0
	moveEntityForward NPC1_WALK, 55
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	moveEntityForward NPC4_WALK, 15
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 0
	showEntityMessage BARRY_MESSAGE, text_pointer_4225
	eventWait 150
	moveEntityForward NPC4_WALK, 4
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, 2
	moveEntityForward NPC1_WALK, 4
	showEntityMessage WESKER_MESSAGE, text_pointer_4228
	eventWait 150
	moveEntityForward NPC1_WALK, 3
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, 6
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 0
	changeRoomCamera 2
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, FACING_WEST
	moveEntityForward NPC1_RUN, 3
	changeRoomCamera 6
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	showEntityMessage JILL_MESSAGE, text_pointer_422B
	eventWait 150
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC1_RUN, 2
	showEntityMessage WESKER_MESSAGE, text_pointer_422E
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_4231
	eventWait 150
	playSfx FIREGUN_SFX
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	showEntityMessage BARRY_MESSAGE, text_pointer_4234
	eventWait 150
	showEntityMessage WESKER_MESSAGE, text_pointer_4237
	eventWait 150
	showEntityMessage WESKER_MESSAGE, text_pointer_423A
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_423D
	eventWait 150
	showEntityMessage WESKER_MESSAGE, text_pointer_4240
	eventWait 150
	moveEntityForward NPC1_WALK, 50
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, 2
	changeRoomCamera 1
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	showEntityMessage WESKER_MESSAGE, text_pointer_4243
	eventWait 150
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC4_RUN, 5
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, 2
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC1_RUN, 5
	moveEntityForward NPC1_RUN, 5
	moveEntityForward NPC1_RUN, 5
	moveEntityForward NPC1_RUN, 5
	moveEntityForward NPC1_RUN, 5
	moveEntityForward NPC1_RUN, 5
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, 2
	moveEntityForward NPC1_RUN, 5
	moveEntityForward NPC1_RUN, 5
	changeRoomCamera 5
	moveEntityForward NPC1_RUN, 5
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, 2
	moveEntityForward NPC1_RUN, 5
	moveEntityForward NPC1_RUN, 5
	moveEntityForward NPC1_RUN, 5
	moveEntityForward NPC1_RUN, 5
	moveEntityForward NPC1_RUN, 5
	moveEntityForward NPC1_RUN, 5
	moveEntityForward NPC1_RUN, 5
	eventWait 150
	showDoorAnimation DOUBLE_DOOR_A, DOOR_BROWN_PAL
	loadEntityData JILL_DATA, -912, 0, FACING_WEST, IDLE_ANIM, 0
	loadRoom DINNING_ROOM_1F, 255
	copyNpc1DataToPlayer
	endEventScript


event_4E79:
	resetAllEntitiesData
	loadRoom DINNING_ROOM_1F, 0
	loadEntityData JILL_DATA, -912, -104, FACING_WEST, IDLE_ANIM, 0
	loadEntityData BARRY_DATA, -912, 96, FACING_WEST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	moveEntityForward NPC4_WALK, 20
	showEntityMessage BARRY_MESSAGE, text_pointer_4246
	eventWait 150
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, 2
	moveEntityForward NPC4_WALK, 30
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, 2
	moveEntityForward NPC4_WALK, 60
	changeRoomCamera 1
	moveEntityForward NPC4_WALK, 60
	copyNpc1DataToPlayer
	endEventScript


event_4EAF:
	resetAllEntitiesData
	loadRoom DINNING_ROOM_1F, 2
	loadEntityData JILL_DATA, 504, 256, FACING_SOUTH_WEST, IDLE_ANIM, 24
	loadEntityData BARRY_DATA, 912, -24, FACING_SOUTH_WEST, KNIFE_AIM_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	moveEntityForward NPC1_WALK, 10
	showEntityMessage BARRY_MESSAGE, text_pointer_4249
	eventWait 150
	moveEntityForward NPC1_WALK, 20
	changeRoomCamera 3
	moveEntityForward NPC1_WALK, 12
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 24
	showEntityMessage JILL_MESSAGE, text_pointer_424C
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_424F
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_4252
	eventWait 150
	copyNpc1DataToPlayer
	endEventScript


event_4EF1:
	resetAllEntitiesData
	loadRoom DINNING_ROOM_1F, 2
	loadEntityData JILL_DATA, 704, 336, FACING_SOUTH, IDLE_ANIM, 24
	loadEntityData BARRY_DATA, 912, -160, FACING_SOUTH_WEST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	moveEntityForward NPC1_RUN, 22
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, 2
	moveEntityForward NPC1_RUN, 4
	changeRoomCamera 3
	loadEntityData ZOMBIE_DATA, 784, 336, FACING_SOUTH_WEST, IDLE_ANIM, 0
	updateBgAndSprites
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, 2
	moveEntityForward NPC1_WALK, 20
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, 6
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 24
	showEntityMessage JILL_MESSAGE, text_pointer_4255
	playSfx OPEN_DOOR_SFX
	eventWait 50
	playSfx CLOSE_DOOR_SFX
	moveEntityForward NPC6_WALK, 10
	changeEntityFacing NPC6_FACING, FACING_CW_DIR, 2
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, FACING_WEST
	changeRoomCamera 2
	showEntityMessage BARRY_MESSAGE, text_pointer_4258
	moveEntityForward NPC6_WALK, 15
	showEntityMessage JILL_MESSAGE, text_pointer_425B
	moveEntityForward NPC6_WALK, 20
	moveEntityBackward NPC1_BACKWARD_WALK, 20
	eventWait 70
	showEntityMessage BARRY_MESSAGE, text_pointer_425E
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, 2
	changeEntityAnimation NPC4_ANIM, GUN_AIM_ANIM, 16
	changeEntityAnimation NPC4_ANIM, GUN_AIM_ANIM, 8
	playSfx FIREGUN_SFX
	eventWait 30
	playSfx FIREGUN_SFX
	eventWait 30
	playSfx FIREGUN_SFX
	eventWait 30
	changeEntityAnimation NPC6_ANIM, RUN_ANIM, 0
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, 2
	changeEntityAnimation NPC4_ANIM, GUN_AIM_ANIM, 16
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 0
	moveEntityForward NPC4_WALK, 10
	moveEntityForward NPC1_WALK, 10
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, 6
	showEntityMessage BARRY_MESSAGE, text_pointer_4261
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_4264
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_4267
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC4_RUN, 40
	changeRoomCamera 1
	moveEntityForward NPC4_RUN, 50
	screenFadeOut
	playSfx OPEN_DOOR_SFX
	eventWait 30
	playSfx CLOSE_DOOR_SFX
	copyNpc1DataToPlayer
	endEventScript


event_4F92:
	resetAllEntitiesData
	loadRoom MAIN_HALL_1F, 6
	loadEntityData JILL_DATA, 976, 144, FACING_SOUTH_EAST, IDLE_ANIM, 0
	loadEntityData BARRY_DATA, 976, 64, FACING_SOUTH_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	moveEntityForward NPC1_WALK, 20
	moveEntityForward NPC4_WALK, 20
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, 2
	moveEntityForward NPC1_WALK, 10
	moveEntityForward NPC4_WALK, 10
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, 2
	moveEntityForward NPC1_WALK, 15
	moveEntityForward NPC4_WALK, 15
	changeRoomCamera 5
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, 2
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, 2
	moveEntityForward NPC1_WALK, 40
	moveEntityForward NPC4_WALK, 40
	showEntityMessage JILL_MESSAGE, text_pointer_426A
	eventWait 150
	moveEntityForward NPC1_WALK, 20
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, 6
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 24
	showEntityMessage BARRY_MESSAGE, text_pointer_426D
	eventWait 100
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC4_RUN, 10
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	moveEntityForward NPC4_RUN, 50
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, 2
	moveEntityForward NPC1_WALK, 10
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC1_WALK, 120
	changeRoomCamera 4
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC1_WALK, 50
	loadEntityData BARRY_DATA, -600, -496, FACING_NORTH_WEST, IDLE_ANIM, 24
	updateBgAndSprites
	changeRoomCamera 3
	moveEntityForward NPC1_WALK, 50
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 24
	moveEntityForward NPC1_WALK, 10
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	changeRoomCamera 2
	moveEntityForward NPC1_WALK, 150
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, 2
	moveEntityForward NPC1_WALK, 10
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 24
	eventWait 50
	showEntityMessage BARRY_MESSAGE, text_pointer_4270
	eventWait 150
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	showEntityMessage JILL_MESSAGE, text_pointer_4273
	eventWait 150
	changeRoomCamera 1
	showEntityMessage JILL_MESSAGE, text_pointer_4276
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_4279
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_427C
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_427F
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_4282
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_4285
	eventWait 150
	changeRoomCamera 2
	showEntityMessage BARRY_MESSAGE, text_pointer_4288
	eventWait 150
	moveEntityForward NPC1_WALK, 9
	showEntityMessage JILL_MESSAGE, text_pointer_428B
	moveEntityBackward NPC1_BACKWARD_WALK, 10
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	eventWait 70
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, 2
	changeRoomCamera 6
	moveEntityForward NPC4_RUN, 60
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, 2
	moveEntityForward NPC4_RUN, 10
	changeRoomCamera 5
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, 6
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 0
	showEntityMessage BARRY_MESSAGE, text_pointer_4291
	eventWait 150
	changeRoomCamera 6
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 24
	showEntityMessage BARRY_MESSAGE, text_pointer_4294
	eventWait 150
	changeRoomCamera 5
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, 6
	moveEntityForward NPC4_WALK, 40
	screenFadeOut
	playSfx OPEN_DOOR_SFX
	eventWait 50
	playSfx CLOSE_DOOR_SFX
	copyNpc1DataToPlayer
	endEventScript


event_508A:
	resetAllEntitiesData
	loadRoom MAIN_HALL_1F, 2
	loadEntityData BARRY_DATA, -600, -496, FACING_NORTH_WEST, IDLE_ANIM, 24
	loadEntityData JILL_DATA, -360, -256, FACING_SOUTH, IDLE_ANIM, 24
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	showEntityMessage BARRY_MESSAGE, text_pointer_4270
	eventWait 150
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	showEntityMessage JILL_MESSAGE, text_pointer_4273
	eventWait 150
	changeRoomCamera 1
	showEntityMessage JILL_MESSAGE, text_pointer_4276
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_4279
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_427C
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_427F
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_4282
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_4285
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_4288
	eventWait 150
	moveEntityForward NPC1_WALK, 30
	showEntityMessage JILL_MESSAGE, text_pointer_428B
	moveEntityBackward NPC1_BACKWARD_WALK, 30
	eventWait 70
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, 2
	changeRoomCamera 6
	moveEntityForward NPC4_RUN, 60
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, 2
	moveEntityForward NPC4_RUN, 10
	changeRoomCamera 5
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, 6
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 0
	showEntityMessage BARRY_MESSAGE, text_pointer_4291
	eventWait 150
	changeRoomCamera 6
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 24
	showEntityMessage BARRY_MESSAGE, text_pointer_4294
	eventWait 150
	changeRoomCamera 5
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, 6
	moveEntityForward NPC4_WALK, 40
	changeRoomCamera 2
	eventWait 80
	playSfx OPEN_DOOR_SFX
	eventWait 50
	playSfx CLOSE_DOOR_SFX
	copyNpc1DataToPlayer
	endEventScript


event_5118:
	resetAllEntitiesData
	loadRoom FALLING_CIELING_ROOM, 1
	loadEntityData JILL_DATA, -144, -208, FACING_SOUTH, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	showEntityMessage JILL_MESSAGE, text_pointer_4297
	eventWait 150
	resetAllEntitiesData
	loadRoom NORTH_EAST_CORRIDOR_1F, 6
	loadEntityData BARRY_DATA, 24, -280, FACING_NORTH_WEST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	showEntityMessage BARRY_MESSAGE, text_pointer_429A
	eventWait 150
	resetAllEntitiesData
	loadRoom FALLING_CIELING_ROOM, 1
	loadEntityData JILL_DATA, -144, -208, FACING_SOUTH, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, FACING_WEST
	showEntityMessage JILL_MESSAGE, text_pointer_429D
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_42A0
	eventWait 150
	playSfx OPEN_DOOR_SFX
	showDoorAnimation DOUBLE_DOOR_A, DOOR_BROWN_PAL
	loadRoom FALLING_CIELING_ROOM, 1
	loadEntityData JILL_DATA, -144, 0, FACING_NORTH, IDLE_ANIM, 0
	loadEntityData BARRY_DATA, 0, 208, FACING_NORTH_WEST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	showEntityMessage BARRY_MESSAGE, text_pointer_42A3
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, 6
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, 2
	moveEntityForward NPC4_RUN, 2
	moveEntityForward NPC1_RUN, 2
	moveEntityForward NPC4_RUN, 2
	moveEntityForward NPC1_RUN, 4
	eventWait 80
	showDoorAnimation DOUBLE_DOOR_A, DOOR_BROWN_PAL
	loadRoom NORTH_EAST_CORRIDOR_1F, 6
	loadEntityData JILL_DATA, 48, -280, FACING_SOUTH, IDLE_ANIM, 24
	copyNpc1DataToPlayer
	endEventScript


event_51AD:
	resetAllEntitiesData
	loadRoom EAST_TERRACE, 0
	loadEntityData BARRY_DATA, -88, 40, FACING_SOUTH_WEST, IDLE_ANIM, 0
	loadEntityData JILL_DATA, -296, 208, FACING_SOUTH_WEST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, FACING_WEST
	changeEntityAnimation NPC4_ANIM, GUN_AIM_ANIM, 16
	changeEntityAnimation NPC4_ANIM, GUN_AIM_ANIM, 8
	showEntityMessage BARRY_MESSAGE, text_pointer_42E2
	eventWait 10
	changeEntityAnimation NPC4_ANIM, GUN_AIM_ANIM, 16
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 24
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_42E5
	eventWait 150
	moveEntityForward NPC1_WALK, 1
	showEntityMessage JILL_MESSAGE, text_pointer_42E8
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_42EB
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, 6
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, 2
	moveEntityForward NPC4_WALK, 20
	changeRoomCamera 1
	moveEntityForward NPC4_WALK, 10
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC4_WALK, 30
	moveEntityForward NPC1_WALK, 35
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC1_WALK, 25
	changeRoomCamera 3
	showEntityMessage BARRY_MESSAGE, text_pointer_42EE
	eventWait 150
	changeRoomCamera 2
	showEntityMessage JILL_MESSAGE, text_pointer_42F1
	eventWait 150
	changeEntityAnimation NPC4_ANIM, KNIFE_AIM_ANIM, 0
	showEntityMessage BARRY_MESSAGE, text_pointer_42F4
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_42F7
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, FACING_WEST
	moveEntityForward NPC1_WALK, 1
	showEntityMessage BARRY_MESSAGE, text_pointer_42FA
	eventWait 150
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 0
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, FACING_WEST
	screenPanningDown
	copyNpc1DataToPlayer
	receiveItem BAZOOKA, ROOM2F_BAZOOKA


event_5232:
	resetAllEntitiesData
	loadRoom NORTH_EAST_CORRIDOR_1F, 6
	loadEntityData BARRY_DATA, -8, -472, FACING_NORTH_WEST, IDLE_ANIM, 24
	loadEntityData JILL_DATA, -8, -280, FACING_SOUTH_WEST, IDLE_ANIM, 24
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	showEntityMessage JILL_MESSAGE, text_pointer_42A6
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_42A9
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_42AC
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_42AF
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_42B2
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_42B5
	eventWait 150
	moveEntityForward NPC4_WALK, 20
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, 2
	moveEntityForward NPC4_WALK, 25
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 24
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	changeRoomCamera 6
	showEntityMessage JILL_MESSAGE, text_pointer_42B8
	eventWait 150
	changeRoomCamera 5
	showEntityMessage BARRY_MESSAGE, text_pointer_42BB
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC4_WALK, 20
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC4_WALK, 40
	loadRoom DINNING_ROOM_1F, 0
	copyNpc1DataToPlayer
	endEventScript


event_5295:
	resetAllEntitiesData
	loadRoom MAIN_HALL_1F, 1
	loadEntityData BARRY_DATA, 16, -72, FACING_WEST, IDLE_ANIM, 24
	loadEntityData JILL_DATA, -976, -304, FACING_WEST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	moveEntityForward NPC1_WALK, 30
	showEntityMessage JILL_MESSAGE, text_pointer_42BE
	eventWait 150
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, FACING_WEST
	moveEntityForward NPC1_WALK, 40
	moveEntityForward NPC4_WALK, 50
	changeRoomCamera 2
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, 2
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 24
	showEntityMessage BARRY_MESSAGE, text_pointer_42C1
	eventWait 150
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, 2
	showEntityMessage JILL_MESSAGE, text_pointer_42C4
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_42C7
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_42CA
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_42CD
	eventWait 150
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, 6
	showEntityMessage BARRY_MESSAGE, text_pointer_42D0
	eventWait 150
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	showEntityMessage JILL_MESSAGE, text_pointer_42D3
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, 6
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_42D6
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_42D9
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_42DC
	eventWait 150
	changeEntityAnimation NPC4_ANIM, GUN_AIM_ANIM, 16
	changeEntityAnimation NPC4_ANIM, GUN_AIM_ANIM, 8
	eventWait 40
	changeEntityAnimation NPC4_ANIM, GUN_AIM_ANIM, 16
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 24
	showEntityMessage JILL_MESSAGE, text_pointer_42DF
	eventWait 150
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, 2
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 15
	moveEntityBackward NPC1_BACKWARD_WALK, 20
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC4_RUN, 40
	changeRoomCamera 1
	moveEntityForward NPC4_RUN, 20
	eventWait 60
	changeRoomCamera 2
	eventWait 80
	playSfx OPEN_DOOR_SFX
	playSfx CLOSE_DOOR_SFX
	copyNpc1DataToPlayer
	endEventScript


event_5334:
	resetAllEntitiesData
	loadRoom RESEARCHERS_PRIVATE_ROOM, 0
	loadEntityData BARRY_DATA, 144, -56, FACING_SOUTH_WEST, IDLE_ANIM, 24
	loadEntityData JILL_DATA, -32, 240, FACING_SOUTH, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 100
	changeRoomCamera 1
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, FACING_WEST
	showEntityMessage BARRY_MESSAGE, text_pointer_42FD
	eventWait 150
	changeRoomCamera 0
	moveEntityForward NPC1_WALK, 10
	changeRoomCamera 1
	moveEntityForward NPC1_WALK, 5
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, 2
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	showEntityMessage JILL_MESSAGE, text_pointer_4300
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_4303
	moveEntityForward NPC1_WALK, 20
	changeEntityAnimation NPC1_ANIM, GUN_AIM_ANIM, 16
	eventWait 10
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	moveEntityBackward NPC1_BACKWARD_WALK, 10
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 24
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_4306
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_4309
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_430C
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_430F
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_4312
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, 2
	moveEntityForward NPC4_WALK, 40
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC4_WALK, 40
	changeRoomCamera 0
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, FACING_WEST
	moveEntityBackward NPC1_BACKWARD_WALK, 10
	moveEntityForward NPC4_WALK, 20
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, 6
	eventWait 20
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, 6
	eventWait 70
	showDoorAnimation DOUBLE_DOOR_A, DOOR_BROWN_PAL
	copyNpc1DataToPlayer
	endEventScript


event_53B7:
	resetAllEntitiesData
	loadRoom PILLAR_CORRIDOR, 1
	loadEntityData JILL_DATA, 16, 432, FACING_WEST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	moveEntityForward NPC1_WALK, 64
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	changeRoomCamera 2
	moveEntityForward NPC1_RUN, 20
	changeRoomCamera 3
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	showEntityMessage JILL_MESSAGE, text_pointer_4315
	moveEntityForward NPC1_RUN, 20
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	changeEntityAnimation NPC1_ANIM, PICK_ITEM_ANIM, 0
	eventWait 150
	changeRoomCamera 4
	showEntityMessage RICHARD_MESSAGE, text_pointer_4318
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_431B
	eventWait 150
	showEntityMessage RICHARD_MESSAGE, text_pointer_431E
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_4321
	eventWait 150
	showEntityMessage RICHARD_MESSAGE, text_pointer_4324
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_4327
	eventWait 150
	showEntityMessage RICHARD_MESSAGE, text_pointer_432A
	eventWait 150
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	changeRoomCamera 3
	moveEntityForward NPC1_RUN, 20
	changeRoomCamera 2
	moveEntityForward NPC1_RUN, 10
	changeRoomCamera 1
	moveEntityForward NPC1_RUN, 10
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC1_RUN, 40
	changeRoomCamera 0
	moveEntityForward NPC1_RUN, 10
	showDoorAnimation DOUBLE_DOOR_A, DOOR_BROWN_PAL
	loadRoom U_SHAPED_CORRIDOR, 0
	loadEntityData JILL_DATA, 200, 720, FACING_SOUTH, IDLE_ANIM, 0
	copyNpc1DataToPlayer
	endEventScript


event_5436:
	resetAllEntitiesData
	loadRoom PILLAR_CORRIDOR, 4
	loadEntityData JILL_DATA, 464, 64, FACING_SOUTH, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	moveEntityForward NPC1_RUN, 20
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	changeEntityAnimation NPC1_ANIM, PICK_ITEM_ANIM, 0
	showEntityMessage JILL_MESSAGE, text_pointer_432D
	eventWait 150
	showEntityMessage RICHARD_MESSAGE, text_pointer_4330
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_4333
	eventWait 150
	showEntityMessage RICHARD_MESSAGE, text_pointer_4336
	eventWait 150
	changeRoomCamera 3
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	eventWait 150
	copyNpc1DataToPlayer
	endEventScript


event_5470:
	loadRoom ATTIC_ENTRY, 1
	loadEntityData JILL_DATA, 88, -336, FACING_NORTH, IDLE_ANIM, 0
	loadEntityData BARRY_DATA, 144, 336, FACING_SOUTH, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	moveEntityForward NPC1_WALK, 20
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	eventWait 5
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 24
	eventWait 5
	changeEntityAnimation NPC1_ANIM, PICK_ITEM_ANIM, 0
	showEntityMessage JILL_MESSAGE, text_pointer_4339
	eventWait 150
	playSfx CLOSE_DOOR_SFX
	moveEntityForward NPC4_WALK, 23
	eventWait 80
	screenFadeOut
	copyNpc1DataToPlayer
	endEventScript


event_54AD:
	resetAllEntitiesData
	loadRoom COURTYARD_GARDEN, 1
	loadEntityData JILL_DATA, 544, 384, FACING_NORTH_WEST, IDLE_ANIM, 24
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	showEntityMessage BRAD_MESSAGE, text_pointer_433C
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_4390
	eventWait 150
	showEntityMessage BRAD_MESSAGE, text_pointer_433F
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_4393
	eventWait 150
	copyNpc1DataToPlayer
	endEventScript


event_54D9:
	resetAllEntitiesData
	loadRoom DORMITORY_CORRIDOR, 5
	loadEntityData JILL_DATA, 880, -648, FACING_SOUTH_WEST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	moveEntityBackward NPC1_BACKWARD_WALK, 10
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	eventWait 80
	showEntityMessage BARRY_MESSAGE, text_pointer_439C
	eventWait 150
	showEntityMessage MISTERY_MESSAGE, text_pointer_439F
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_43A2
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 24
	eventWait 150
	showEntityMessage MISTERY_MESSAGE, text_pointer_43A5
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_43A8
	eventWait 150
	showEntityMessage MISTERY_MESSAGE, text_pointer_43AB
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_43AE
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	eventWait 150
	copyNpc1DataToPlayer
	endEventScript


event_5522:
	resetAllEntitiesData
	loadRoom GUARDHOUSE_DORM_002, 1
	loadEntityData BARRY_DATA, 128, -216, FACING_NORTH_WEST, GUN_AIM_ANIM, 8
	loadEntityData JILL_DATA, 360, 592, FACING_SOUTH, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	moveEntityForward NPC1_WALK, 40
	changeRoomCamera 2
	moveEntityForward NPC1_WALK, 30
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 24
	moveEntityForward NPC4_WALK, 20
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 0
	showEntityMessage BARRY_MESSAGE, text_pointer_43B1
	eventWait 150
	changeRoomCamera 4
	showEntityMessage JILL_MESSAGE, text_pointer_43B4
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_43B7
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_43BA
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_43BD
	eventWait 150
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	moveEntityForward NPC4_WALK, 5
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, 2
	moveEntityForward NPC4_WALK, 10
	changeRoomCamera 2
	moveEntityForward NPC4_WALK, 20
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, 2
	moveEntityForward NPC4_WALK, 10
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, 2
	moveEntityForward NPC4_WALK, 10
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	eventWait 20
	changeRoomCamera 1
	moveEntityForward NPC4_WALK, 20
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 0
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, FACING_WEST
	showEntityMessage BARRY_MESSAGE, text_pointer_43C0
	eventWait 150
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, FACING_WEST
	loadEntityData BARRY_DATA, -152, -216, FACING_NORTH_WEST, GUN_AIM_ANIM, 8
	changeRoomCamera 4
	updateBgAndSprites
	playSfx OPEN_DOOR_SFX
	eventWait 100
	playSfx CLOSE_DOOR_SFX
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, FACING_WEST
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 24
	eventWait 50
	copyNpc1DataToPlayer
	endEventScript


event_55B4:
	resetAllEntitiesData
	loadRoom DORMITORY_CORRIDOR, 3
	loadEntityData JILL_DATA, 712, 528, FACING_EAST, IDLE_ANIM, 0
	loadEntityData WESKER_DATA, 152, 880, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	screenPanningUp
	eventWait 100
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	playSfx FIREGUN_SFX
	eventWait 20
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC1_RUN, 30
	changeRoomCamera 2
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	playSfx FIREGUN_SFX
	changeEntityAnimation NPC2_ANIM, GUN_AIM_ANIM, 0
	eventWait 50
	playSfx FIREGUN_SFX
	showEntityMessage JILL_MESSAGE, text_pointer_43D2
	changeEntityAnimation NPC2_ANIM, GUN_AIM_ANIM, 16
	changeEntityAnimation NPC2_ANIM, IDLE_ANIM, 0
	eventWait 120
	changeRoomCamera 7
	changeEntityFacing NPC2_FACING, FACING_CW_DIR, FACING_WEST
	showEntityMessage WESKER_MESSAGE, text_pointer_43C3
	eventWait 150
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 24
	showEntityMessage JILL_MESSAGE, text_pointer_43C6
	moveEntityForward NPC1_WALK, 40
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	changeEntityAnimation NPC2_ANIM, IDLE_ANIM, 24
	showEntityMessage WESKER_MESSAGE, text_pointer_43C9
	showEntityMessage JILL_MESSAGE, text_pointer_43CC
	eventWait 100
	changeRoomCamera 1
	moveEntityForward NPC2_WALK, 3
	changeRoomCamera 2
	moveEntityForward NPC2_WALK, 63
	changeEntityFacing NPC2_FACING, FACING_CW_DIR, FACING_WEST
	eventWait 100
	showEntityMessage JILL_MESSAGE, text_pointer_43CF
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 24
	changeEntityFacing NPC2_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC2_WALK, 6
	loadEntityData WESKER_DATA, -720, 976, FACING_SOUTH, IDLE_ANIM, 0
	updateBgAndSprites
	eventWait 150
	copyNpc1DataToPlayer
	endEventScript


event_563E:
	resetAllEntitiesData
	loadRoom WAY_TO_GUARDHOUSE, 4
	loadEntityData JILL_DATA, -808, -264, FACING_NORTH, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	showEntityMessage BRAD_MESSAGE, text_pointer_4342
	eventWait 150
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 24
	showEntityMessage JILL_MESSAGE, text_pointer_4396
	eventWait 150
	copyNpc1DataToPlayer
	endEventScript


event_5663:
	resetAllEntitiesData
	loadRoom LESSONS_ROOM, 2
	loadEntityData JILL_DATA, 120, -504, FACING_SOUTH_WEST, PICK_ITEM_ANIM, 0
	loadEntityData BARRY_DATA, -272, 656, FACING_SOUTH, IDLE_ANIM, 24
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	playSfx OPEN_DOOR_SFX
	eventWait 50
	playSfx CLOSE_DOOR_SFX
	eventWait 51
	changeRoomCamera 0
	moveEntityForward NPC4_WALK, 80
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	changeRoomCamera 2
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, 2
	moveEntityForward NPC4_WALK, 30
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 24
	moveEntityForward NPC4_WALK, 40
	changeEntityAnimation NPC4_ANIM, KNIFE_AIM_ANIM, 0
	showEntityMessage BARRY_MESSAGE, text_pointer_4561
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_4564
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_4567
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_456A
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_456D
	eventWait 100
	showDoorAnimation ROPE_DOWNWARD
	resetAllEntitiesData
	loadRoom TREVORS_TOMB, 0
	loadEntityData JILL_DATA, 80, 256, FACING_SOUTH_WEST, PICK_ITEM_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	showEntityMessage JILL_MESSAGE, text_pointer_4570
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, FACING_WEST
	eventWait 150
	resetAllEntitiesData
	loadRoom LESSONS_ROOM, 2
	loadEntityData BARRY_DATA, 120, -504, FACING_SOUTH_WEST, KNIFE_AIM_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	showEntityMessage BARRY_MESSAGE, text_pointer_4573
	eventWait 150
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 0
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, FACING_WEST
	moveEntityForward NPC4_WALK, 30
	eventWait 50
	resetAllEntitiesData
	loadRoom TREVORS_TOMB, 0
	loadEntityData JILL_DATA, 80, 256, FACING_NORTH_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	showEntityMessage JILL_MESSAGE, text_pointer_4576
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, FACING_WEST
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 24
	eventWait 160
	copyNpc1DataToPlayer
	endEventScript


event_571C:
	resetAllEntitiesData
	loadRoom LESSONS_ROOM, 2
	loadEntityData BARRY_DATA, -96, 208, FACING_SOUTH_WEST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	playSfx OPEN_DOOR_SFX
	moveEntityForward NPC4_RUN, 25
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, 2
	moveEntityForward NPC4_RUN, 10
	changeEntityAnimation NPC4_ANIM, KNIFE_AIM_ANIM, 0
	showEntityMessage BARRY_MESSAGE, text_pointer_4579
	eventWait 150
	resetAllEntitiesData
	loadRoom TREVORS_TOMB, 0
	loadEntityData JILL_DATA, 80, 256, FACING_NORTH_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 150
	screenFadeOut
	resetAllEntitiesData
	loadRoom LESSONS_ROOM, 2
	loadEntityData JILL_DATA, 120, -504, FACING_NORTH, IDLE_ANIM, 0
	loadEntityData BARRY_DATA, 168, -296, FACING_SOUTH_WEST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	showEntityMessage BARRY_MESSAGE, text_pointer_457C
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 24
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_457F
	eventWait 150
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 24
	showEntityMessage BARRY_MESSAGE, text_pointer_4582
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_4585
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_4588
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_42D0
	eventWait 100
	showEntityMessage JILL_MESSAGE, text_pointer_42DF
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, FACING_WEST
	moveEntityForward NPC4_WALK, 70
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, 2
	playSfx OPEN_DOOR_SFX
	eventWait 30
	playSfx CLOSE_DOOR_SFX
	eventWait 100
	copyNpc1DataToPlayer
	endEventScript


event_57AB:
	resetAllEntitiesData
	loadRoom UNDERGROUND_BRANCHED_PASSAGE, 0
	loadEntityData JILL_DATA, -272, 24, FACING_WEST, GUN_AIM_ANIM, 8
	loadEntityData BARRY_DATA, -64, 8, FACING_WEST, GUN_AIM_ANIM, 8
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	changeEntityAnimation NPC1_ANIM, GUN_AIM_ANIM, 16
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 24
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, FACING_WEST
	changeEntityAnimation NPC4_ANIM, GUN_AIM_ANIM, 16
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 24
	showEntityMessage BARRY_MESSAGE, text_pointer_435A
	showEntityMessage JILL_MESSAGE, text_pointer_435D
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_4360
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_4363
	eventWait 150
	eventWait 150
	screenPanningDown
	copyNpc1DataToPlayer
	endEventScript


event_57F1:
	resetAllEntitiesData
	loadRoom UNDERGROUND_SOUTH_PASSAGE, 3
	loadEntityData JILL_DATA, 544, 720, FACING_WEST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	moveEntityForward NPC1_WALK, 5
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC1_WALK, 10
	showEntityMessage ENRICO_MESSAGE, text_pointer_4366
	moveEntityForward NPC1_WALK, 50
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, 2
	eventWait 150
	changeRoomCamera 5
	moveEntityForward NPC1_WALK, 40
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	showEntityMessage JILL_MESSAGE, text_pointer_4369
	eventWait 150
	showEntityMessage ENRICO_MESSAGE, text_pointer_436C
	eventWait 150
	moveEntityForward NPC1_WALK, 30
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	showEntityMessage JILL_MESSAGE, text_pointer_436F
	eventWait 150
	showEntityMessage ENRICO_MESSAGE, text_pointer_4372
	eventWait 150
	changeRoomCamera 4
	showEntityMessage JILL_MESSAGE, text_pointer_4375
	eventWait 150
	loadEntityData BARRY_DATA, 592, 616, FACING_SOUTH, IDLE_ANIM, 0
	updateBgAndSprites
	changeRoomCamera 3
	showEntityMessage BARRY_MESSAGE, text_pointer_4378
	eventWait 150
	moveEntityForward NPC4_RUN, 30
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, 2
	moveEntityForward NPC4_RUN, 20
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 24
	changeRoomCamera 5
	showEntityMessage ENRICO_MESSAGE, text_pointer_437B
	eventWait 150
	changeRoomCamera 4
	showEntityMessage BARRY_MESSAGE, text_pointer_437E
	eventWait 150
	changeRoomCamera 5
	showEntityMessage ENRICO_MESSAGE, text_pointer_4381
	eventWait 150
	changeRoomCamera 3
	showEntityMessage ENRICO_MESSAGE, text_pointer_4384
	playSfx FIREGUN_SFX
	showEntityMessage ENRICO_MESSAGE, text_pointer_4387
	eventWait 150
	changeRoomCamera 5
	moveEntityForward NPC4_RUN, 10
	changeEntityAnimation NPC4_ANIM, KNIFE_AIM_ANIM, 0
	showEntityMessage JILL_MESSAGE, text_pointer_438A
	eventWait 150
	changeRoomCamera 3
	eventWait 150
	copyNpc1DataToPlayer
	endEventScript


event_588C:
	resetAllEntitiesData
	loadRoom DETENTION_ROOM_PASSAGE, 2
	loadEntityData JILL_DATA, 288, -248, FACING_SOUTH_WEST, IDLE_ANIM, 24
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	eventWait 100
	changeRoomCamera 3
	showEntityMessage CHRIS_MESSAGE, text_pointer_42FD
	eventWait 150
	changeRoomCamera 2
	showEntityMessage JILL_MESSAGE, text_pointer_43D5
	eventWait 150
	showEntityMessage CHRIS_MESSAGE, text_pointer_44A4
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_44A7
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_44AA
	eventWait 150
	changeRoomCamera 3
	showEntityMessage CHRIS_MESSAGE, text_pointer_44AD
	eventWait 150
	changeRoomCamera 2
	eventWait 150
	copyNpc1DataToPlayer
	endEventScript


event_58CE:
	resetAllEntitiesData
	loadRoom LAB_ELEVATOR_ENTRY, 3
	loadEntityData JILL_DATA, 912, 56, FACING_EAST, IDLE_ANIM, 0
	loadEntityData BARRY_DATA, 0, -440, FACING_NORTH, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	moveEntityForward NPC4_RUN, 10
	eventWait 100
	changeRoomCamera 2
	moveEntityForward NPC4_RUN, 5
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC4_RUN, 70
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC4_RUN, 5
	changeRoomCamera 3
	moveEntityForward NPC4_RUN, 25
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC1_WALK, 10
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	eventWait 60
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 0
	showEntityMessage BARRY_MESSAGE, text_pointer_4498
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_449B
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_449E
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_44A1
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC4_WALK, 10
	eventWait 100
	screenFadeOut
	screenPanningDown
	loadRoom HELIPORT_ELEVATOR, 0
	loadEntityData JILL_DATA, 0, -64, FACING_EAST, IDLE_ANIM, 0
	loadEntityData BARRY_DATA, 0, 64, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	eventWait 150
	loadRoom MAIN_LAB_ENTRY, 0
	loadEntityData JILL_DATA, 720, -136, FACING_EAST, IDLE_ANIM, 0
	loadEntityData BARRY_DATA, 720, -312, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	eventWait 50
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	eventWait 90
	changeRoomCamera 1
	eventWait 100


event_59BE:
	loadRoom MAIN_LAB_ENTRY, 3
	loadEntityData JILL_DATA, -312, 0, FACING_EAST, IDLE_ANIM, 0
	loadEntityData BARRY_DATA, -312, -432, FACING_EAST, IDLE_ANIM, 0
	loadEntityData WESKER_DATA, -608, 464, FACING_SOUTH, IDLE_ANIM, 24
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	moveEntityForward NPC1_WALK, 40
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, 2
	moveEntityForward NPC4_WALK, 20
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, 2
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	showEntityMessage JILL_MESSAGE, text_pointer_426A
	eventWait 150
	showEntityMessage WESKER_MESSAGE, text_pointer_44B0
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, 2
	changeEntityAnimation NPC4_ANIM, GUN_AIM_ANIM, 16
	changeEntityAnimation NPC4_ANIM, GUN_AIM_ANIM, 8
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 24
	eventWait 150
	changeRoomCamera 5
	showEntityMessage JILL_MESSAGE, text_pointer_44B3
	eventWait 150
	changeRoomCamera 2
	showEntityMessage WESKER_MESSAGE, text_pointer_44B6
	eventWait 150
	changeRoomCamera 5
	showEntityMessage JILL_MESSAGE, text_pointer_44B9
	eventWait 150
	changeRoomCamera 3
	showEntityMessage WESKER_MESSAGE, text_pointer_44BC
	eventWait 150
	changeRoomCamera 5
	showEntityMessage JILL_MESSAGE, text_pointer_44BF
	eventWait 150
	changeRoomCamera 2
	showEntityMessage WESKER_MESSAGE, text_pointer_44C2
	eventWait 150
	changeRoomCamera 5
	showEntityMessage JILL_MESSAGE, text_pointer_44C5
	eventWait 150
	showEntityMessage WESKER_MESSAGE, text_pointer_44C8
	eventWait 150
	changeRoomCamera 3
	showEntityMessage WESKER_MESSAGE, text_pointer_44CB
	eventWait 150
	changeRoomCamera 5
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 24
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, 6
	moveEntityForward NPC4_WALK, 5
	eventWait 50
	changeRoomCamera 3
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	showEntityMessage WESKER_MESSAGE, text_pointer_44CE
	moveEntityForward NPC4_RUN, 50
	eventWait 100
	showEntityMessage JILL_MESSAGE, text_pointer_44D1
	eventWait 150
	changeRoomCamera 3
	showEntityMessage WESKER_MESSAGE, text_pointer_44D1
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_44D4
	eventWait 150
	showEntityMessage WESKER_MESSAGE, text_pointer_44D7
	eventWait 150
	changeRoomCamera 3
	showEntityMessage JILL_MESSAGE, text_pointer_44DA
	eventWait 150
	changeRoomCamera 2
	moveEntityForward NPC2_WALK, 40
	changeEntityFacing NPC2_FACING, FACING_CW_DIR, 2
	moveEntityForward NPC2_WALK, 20
	changeEntityFacing NPC2_FACING, FACING_CCW_DIR, 2
	moveEntityForward NPC2_WALK, 10
	changeEntityFacing NPC2_FACING, FACING_CCW_DIR, 2
	moveEntityForward NPC2_WALK, 20
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, FACING_WEST
	changeEntityFacing NPC2_FACING, FACING_CCW_DIR, 6
	showEntityMessage WESKER_MESSAGE, text_pointer_4534
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, FACING_WEST
	moveEntityForward NPC4_RUN, 50
	eventWait 120
	showEntityMessage JILL_MESSAGE, text_pointer_44DD
	eventWait 150
	changeRoomCamera 5
	showEntityMessage WESKER_MESSAGE, text_pointer_44E0
	moveEntityForward NPC4_RUN, 20
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC4_RUN, 10
	eventWait 150
	changeRoomCamera 2
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 0
	changeEntityAnimation NPC2_ANIM, IDLE_ANIM, 24
	changeEntityFacing NPC2_FACING, FACING_CW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC2_WALK, 15
	changeEntityAnimation NPC2_ANIM, KNIFE_AIM_ANIM, 0
	showEntityMessage JILL_MESSAGE, text_pointer_452E
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_44E3
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_44E6
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_44E9
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_44EC
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_43F3
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_44EF
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_44F2
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_44F5
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_44F8
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_44FB
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_44FE
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, FACING_WEST
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	eventWait 150
	showDoorAnimation DOUBLE_DOOR_A, DOOR_BROWN_PAL
	loadEntityData JILL_DATA, -624, -712, FACING_NORTH, IDLE_ANIM, 0
	loadRoom MAIN_LABORATORY, 1
	copyNpc1DataToPlayer
	endEventScript


event_5B2F:
	resetAllEntitiesData
	loadRoom MAIN_LABORATORY, 1
	loadEntityData JILL_DATA, -512, -48, FACING_NORTH, IDLE_ANIM, 0
	loadEntityData BARRY_DATA, -656, -48, FACING_NORTH, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	changeRoomCamera 2
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, 2
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, 2
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	changeRoomCamera 5
	eventWait 100
	changeRoomCamera 6
	eventWait 120
	changeRoomCamera 5
	showEntityMessage JILL_MESSAGE, text_pointer_4504
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_4507
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_450A
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_450D
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_4510
	moveEntityForward NPC4_WALK, 40
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, 2
	moveEntityForward NPC4_WALK, 10
	eventWait 150
	changeRoomCamera 5
	moveEntityBackward NPC4_BACKWARD_WALK, 20
	eventWait 150
	changeRoomCamera 5
	moveEntityBackward NPC1_BACKWARD_WALK, 20
	eventWait 150
	changeRoomCamera 2
	showEntityMessage JILL_MESSAGE, text_pointer_4513
	changeEntityAnimation NPC4_ANIM, KNIFE_AIM_ANIM, 0
	eventWait 150
	changeRoomCamera 5
	showEntityMessage JILL_MESSAGE, text_pointer_4501
	moveEntityBackward NPC1_BACKWARD_WALK, 20
	eventWait 100
	copyNpc1DataToPlayer
	endEventScript


event_5BEC:
	resetAllEntitiesData
	loadRoom MAIN_LABORATORY, 5
	loadEntityData JILL_DATA, -576, 640, FACING_NORTH_EAST, PICK_ITEM_ANIM, 0
	loadEntityData BARRY_DATA, -624, 752, FACING_NORTH, KNIFE_AIM_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	changeEntityAnimation NPC1_ANIM, PICK_ITEM_ANIM, 0
	showEntityMessage JILL_MESSAGE, text_pointer_4576
	eventWait 150
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	showEntityMessage JILL_MESSAGE, text_pointer_436F
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_438D
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 0
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_43E7
	eventWait 150
	changeRoomCamera 2
	changeEntityFacing NPC4_FACING, FACING_CW_DIR, 6
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, FACING_WEST
	eventWait 150
	copyNpc1DataToPlayer
	endEventScript


event_5C34:
	resetAllEntitiesData
	loadRoom MAIN_LAB_ENTRY, 2
	loadEntityData JILL_DATA, -512, 256, FACING_SOUTH, IDLE_ANIM, 24
	loadEntityData BARRY_DATA, -712, 256, FACING_SOUTH, IDLE_ANIM, 24
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	moveEntityForward NPC1_WALK, 5
	moveEntityForward NPC4_WALK, 5
	showEntityMessage JILL_MESSAGE, text_pointer_4516
	eventWait 150
	showEntityMessage CHRIS_MESSAGE, text_pointer_446E
	eventWait 150
	showEntityMessage BARRY_MESSAGE, text_pointer_4519
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC1_RUN, 25
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC1_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC1_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC1_RUN, 5
	changeEntityFacing NPC4_FACING, FACING_CCW_DIR, FACING_NORTH_WEST
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC1_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC1_RUN, 5
	eventWait 15
	changeRoomCamera 1
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC1_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC1_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC1_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC1_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC1_RUN, 5
	changeRoomCamera 0
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC1_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC1_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC1_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC1_RUN, 5
	moveEntityForward NPC4_RUN, 5
	moveEntityForward NPC1_RUN, 5
	showDoorAnimation DOUBLE_DOOR_A, DOOR_BROWN_PAL
	copyNpc1DataToPlayer
	endEventScript


event_5CB4:
	resetAllEntitiesData
	loadRoom DETENTION_ROOM, 2
	loadEntityData CHRIS_DATA, -16, -256, FACING_NORTH, IDLE_ANIM, 24
	loadEntityData JILL_DATA, -16, 256, FACING_SOUTH, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	eventWait 50
	changeRoomCamera 1
	showEntityMessage CHRIS_MESSAGE, text_pointer_451C
	moveEntityForward PLAYER_WALK, 50
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	eventWait 100
	changeRoomCamera 2
	showEntityMessage JILL_MESSAGE, text_pointer_4528
	eventWait 150
	showEntityMessage CHRIS_MESSAGE, text_pointer_4516
	eventWait 150
	showEntityMessage JILL_MESSAGE, text_pointer_452B
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, FACING_WEST
	moveEntityForward NPC1_WALK, 5
	moveEntityForward PLAYER_WALK, 10
	showDoorAnimation DOUBLE_DOOR_A, DOOR_BROWN_PAL
	copyNpc1DataToPlayer
	endEventScript


event_5CFC:
	resetAllEntitiesData
	loadRoom DETENTION_ROOM, 2
	loadEntityData CHRIS_DATA, -16, -256, FACING_NORTH, IDLE_ANIM, 24
	loadEntityData JILL_DATA, -16, 256, FACING_SOUTH, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	eventWait 50
	changeRoomCamera 1
	showEntityMessage CHRIS_MESSAGE, text_pointer_451C
	moveEntityForward PLAYER_WALK, 50
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	eventWait 100
	changeRoomCamera 2
	showEntityMessage JILL_MESSAGE, text_pointer_451F
	eventWait 150
	showEntityMessage CHRIS_MESSAGE, text_pointer_4522
	eventWait 50
	showEntityMessage JILL_MESSAGE, text_pointer_4525
	changeEntityFacing NPC1_FACING, FACING_CCW_DIR, FACING_WEST
	moveEntityForward NPC1_WALK, 5
	moveEntityForward PLAYER_WALK, 10
	showDoorAnimation DOUBLE_DOOR_A, DOOR_BROWN_PAL
	copyNpc1DataToPlayer
	endEventScript


event_5D44:
	resetAllEntitiesData
	loadRoom LAB_B3F_WEST_CORRIDOR, 3
	loadEntityData CHRIS_DATA, 720, 64, FACING_EAST, IDLE_ANIM, 0
	loadEntityData JILL_DATA, 720, -96, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	eventWait 150
	moveEntityForward PLAYER_RUN, 20
	changeRoomCamera 2
	moveEntityForward PLAYER_RUN, 30
	changeRoomCamera 1
	moveEntityForward PLAYER_RUN, 20
	changeRoomCamera 0
	moveEntityForward PLAYER_RUN, 20
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	changeEntityFacing PLAYER_FACING, FACING_CCW_DIR, 6
	showEntityMessage CHRIS_MESSAGE, text_pointer_43E7
	eventWait 80
	changeEntityFacing PLAYER_FACING, FACING_CW_DIR, 6
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 24
	eventWait 150
	changeRoomCamera 3
	eventWait 100
	copyNpc1DataToPlayer
	endEventScript


event_5D8C:
	resetAllEntitiesData
	loadRoom LAB_LADDER_ROOM, 1
	loadEntityData CHRIS_DATA, 104, 288, FACING_SOUTH, IDLE_ANIM, 0
	loadEntityData JILL_DATA, -24, -336, FACING_NORTH, IDLE_ANIM, 24
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	moveEntityForward PLAYER_RUN, 20
	changeEntityAnimation PLAYER_ANIM, IDLE_ANIM, 0
	showEntityMessage CHRIS_MESSAGE, text_pointer_44A1
	eventWait 80
	changeEntityFacing PLAYER_FACING, FACING_CCW_DIR, FACING_WEST
	moveEntityForward PLAYER_RUN, 50
	eventWait 100
	copyNpc1DataToPlayer
	endEventScript


event_5DBF:
	resetAllEntitiesData
	loadRoom LAB_ENTRANCE, 2
	loadEntityData BARRY_DATA, 144, -144, FACING_SOUTH_WEST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	showEntityMessage BARRY_MESSAGE, text_pointer_42A3
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 24
	eventWait 20
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 0
	eventWait 10
	changeEntityAnimation NPC4_ANIM, IDLE_ANIM, 24
	eventWait 150
	copyNpc1DataToPlayer
	endEventScript


event_5DE9:
	resetAllEntitiesData
	loadRoom EMERGENCY_TUNNEL, 2
	loadEntityData JILL_DATA, 168, 512, FACING_SOUTH_WEST, IDLE_ANIM, 0
	loadEntityData BARRY_DATA, 72, 688, FACING_SOUTH_WEST, IDLE_ANIM, 24
	loadEntityData CHRIS_DATA, 200, 976, FACING_SOUTH_WEST, GUN_AIM_ANIM, 8
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	showEntityMessage LAB_ALERT_MESSAGE, text_pointer_4531
	eventWait 150
	copyNpc1DataToPlayer
	endEventScript


event_5E1C:
	resetAllEntitiesData
	loadRoom HELIPORT, 1
	loadEntityData JILL_DATA, 240, 32, FACING_EAST, PICK_ITEM_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 0
	eventWait 50
	changeEntityAnimation NPC1_ANIM, IDLE_ANIM, 24
	changeEntityFacing NPC1_FACING, FACING_CW_DIR, FACING_WEST
	eventWait 100
	changeRoomCamera 4
	eventWait 100
	changeRoomCamera 2
	eventWait 100
	changeRoomCamera 5
	eventWait 100
	changeRoomCamera 2
	eventWait 100
	changeRoomCamera 0
	eventWait 150
	copyNpc1DataToPlayer
	endEventScript


event_5E54:
	resetAllEntitiesData
	loadRoom HELIPORT, 5
	updateBgAndSprites
	screenFadeIn
	eventWait 50
	screenPanningUp
	eventWait 50
	copyNpc1DataToPlayer
	endEventScript


