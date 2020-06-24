event_5E61:
	loadRoom MANSION_ELEVATOR, 0
	loadEntityData CHRIS_DATA, 0, 0, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 100
	shakeEventScreen
	eventWait 10
	screenFadeOut
	loadRoom MAIN_LAB_ENTRY, 0
	loadEntityData CHRIS_DATA, 720, -256, FACING_EAST, IDLE_ANIM, 0
	endEventScript


event_5E86:
	loadRoom MANSION_ELEVATOR, 0
	loadEntityData CHRIS_DATA, 0, 0, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 100
	shakeEventScreen
	eventWait 10
	screenFadeOut
	loadRoom LAB_ELEVATOR_ENTRY, 0
	loadEntityData CHRIS_DATA, 888, 208, FACING_SOUTH, IDLE_ANIM, 0
	endEventScript


event_5EAB:
	loadRoom MANSION_ELEVATOR, 0
	loadEntityData CHRIS_DATA, 0, 0, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 100
	shakeEventScreen
	eventWait 10
	screenFadeOut
	loadRoom MANSION_KITCHEN, 0
	loadEntityData CHRIS_DATA, 920, -88, FACING_WEST, IDLE_ANIM, 0
	endEventScript


event_5ED0:
	loadRoom MANSION_ELEVATOR, 0
	loadEntityData CHRIS_DATA, 0, 0, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 100
	shakeEventScreen
	eventWait 10
	screenFadeOut
	loadRoom ELEVATOR_ROOM_2F, 0
	loadEntityData CHRIS_DATA, 456, -256, FACING_WEST, IDLE_ANIM, 0
	endEventScript


event_5EF5:
	loadRoom MAIN_LAB_ENTRY_ELEVATOR, 0
	loadEntityData CHRIS_DATA, 0, 0, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 100
	shakeEventScreen
	eventWait 10
	screenFadeOut
	loadRoom HELIPORT, 0
	loadEntityData CHRIS_DATA, -568, 768, FACING_WEST, IDLE_ANIM, 0
	endEventScript


event_5F1A:
	loadRoom MAIN_LAB_ENTRY_ELEVATOR, 0
	loadEntityData CHRIS_DATA, 0, 0, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 100
	shakeEventScreen
	eventWait 10
	screenFadeOut
	loadRoom EMERGENCY_TUNNEL, 0
	loadEntityData CHRIS_DATA, -976, -848, FACING_WEST, IDLE_ANIM, 0
	endEventScript


event_5F3F:
	loadRoom HELIPORT_ELEVATOR, 0
	loadEntityData CHRIS_DATA, 0, 0, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 100
	shakeEventScreen
	eventWait 10
	screenFadeOut
	loadRoom LAB_ELEVATOR_ENTRY, 0
	loadEntityData CHRIS_DATA, 888, 208, FACING_SOUTH, IDLE_ANIM, 0
	endEventScript


event_5F64:
	loadRoom HELIPORT_ELEVATOR, 0
	loadEntityData CHRIS_DATA, 0, 0, FACING_EAST, IDLE_ANIM, 0
	updateBgAndSprites
	screenFadeIn
	eventWait 100
	shakeEventScreen
	eventWait 10
	screenFadeOut
	loadRoom LAB_ELEVATOR_ENTRY, 0
	loadEntityData CHRIS_DATA, 888, 208, FACING_SOUTH, IDLE_ANIM, 0
	endEventScript


event_5F89:
	showBgImage FIRST_ZOMBIE_IMAGE
	screenFadeIn
	eventWait 220
	screenFadeOut
	endEventScript


event_5F90:
	loadRoom TIGER_STATUE_ROOM, 1
	updateBgAndSprites
	screenFadeIn
	eventWait 100
	updateJewelsStatuesState ROTATE_TIGER_STATUE_RIGHT
	updateRoomBgMask
	eventWait 50
	updateJewelsStatuesState ROTATE_TIGER_STATUE_RIGHT
	updateRoomBgMask
	eventWait 50
	updateJewelsStatuesState ROTATE_TIGER_STATUE_RIGHT
	updateRoomBgMask
	eventWait 50
	screenFadeOut
	loadRoom TIGER_STATUE_ROOM, 0
	endEventScript


event_5FAB:
	loadRoom TIGER_STATUE_ROOM, 1
	updateBgAndSprites
	screenFadeIn
	eventWait 100
	updateJewelsStatuesState ROTATE_TIGER_STATUE_LEFT
	updateRoomBgMask
	eventWait 50
	updateJewelsStatuesState ROTATE_TIGER_STATUE_LEFT
	updateRoomBgMask
	eventWait 50
	updateJewelsStatuesState ROTATE_TIGER_STATUE_LEFT
	updateRoomBgMask
	eventWait 50
	screenFadeOut
	loadRoom TIGER_STATUE_ROOM, 0
	endEventScript


event_5FC6:
	showBgImage FALLING_STATUE_IMAGE
	screenFadeIn
	eventWait 220
	screenFadeOut
	playSfx BROKEN_JEWEL_STATUE_SFX
	updateJewelsStatuesState DISABLE_JEWEL_STATUE
	endEventScript


