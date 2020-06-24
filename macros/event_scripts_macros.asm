
; 1: room id
; 2: camera id
loadRoom: MACRO
    db LOAD_ROOM, \1, \2
ENDM

; 1: event entity id
; 2: position x
; 3: position z
; 4: facing id
; 5: animation id
; 6: animation frame id
loadEntityData: MACRO
    db \1
	dw \2, \3
	db \4, $00
	db \5, \6
	db $00, $00
ENDM


updateBgAndSprites: MACRO
    db LOAD_SPRITES
ENDM

screenFadeIn: MACRO
    db FADEIN_SCREEN
ENDM

screenFadeOut: MACRO
    db FADEOUT_SCREEN
ENDM


eventWait: MACRO
    db EVENT_WAIT, \1
ENDM

screenPanningUp: MACRO
    db SCREEN_PANNING_UP
ENDM

screenPanningDown: MACRO
    db SCREEN_PANNING_DOWN
ENDM

; 1: camera id
changeRoomCamera: MACRO
	db CHANGE_ROOM_CAMERA, \1
ENDM

; 1: event entity animation id
; 2: animation id
; 3: animation frame id
changeEntityAnimation: MACRO
	db \1, \2, \3
ENDM

; 1: message entity  id
; 2: text pointer
showEntityMessage: MACRO
	dbw \1, \2
ENDM

; 1: entity id
; 2: facing rotation direction
;	- $00: clockwise
;	- $80: counter clockwise
; 3: facing value
changeEntityFacing: MACRO
	db \1, \2 | \3
ENDM


playSfx: MACRO
	db PLAY_SFX, \1
ENDM

moveEntityForward: MACRO
	db \1, \2
ENDM

moveEntityBackward: MACRO
	db \1, \2
ENDM

showDoorAnimation: MACRO
if _NARG > 1
	db SHOW_DOOR_ANIMATION, (\1 << 3) | \2
else
	db SHOW_DOOR_ANIMATION, \1 ; tilemap transition
endc
ENDM

endEventScript: MACRO
    db END_EVENT
ENDM

resetAllEntitiesData: MACRO
	db RESET_ALL_ENTITIES_DATA
ENDM

; used to copy jill event enetity data to player entity struct
copyNpc1DataToPlayer: MACRO
	db COPY_NPC1_DATA_TO_PLAYER
ENDM

; 1: item id
; 2: item flag id
receiveItem: MACRO
	db RECEIVE_ITEM, \1, \2
ENDM

shakeEventScreen: MACRO
	db SHAKE_SCREEN
ENDM

showBgImage: MACRO
	db SHOW_BG_IMAGE, \1
ENDM

ROTATE_TIGER_STATUE_RIGHT	EQU 0
ROTATE_TIGER_STATUE_LEFT	EQU 1
DISABLE_JEWEL_STATUE		EQU 2

updateJewelsStatuesState: MACRO
	db UPDATE_JEWELS_STATUES_STATE, \1
ENDM

updateRoomBgMask: MACRO
	db UPDATE_ROOM_BG_MASK
ENDM


