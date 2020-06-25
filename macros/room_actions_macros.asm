
DOOR_ACTION             EQU $90 ; all actions less than 90 are doors actions
TYPEWRITER_ACTION		EQU $90
ITEMBOX_ACTION			EQU $91
DROPPED_ITEM			EQU $A8
CHECK_ACTION			EQU $A9
END_ROOM_ACTIONS		EQU $FF

ROOM_INTERACTION_ID     EQU $F0

; 
; door actions
;

doorType: MACRO
if _NARG > 1
	db (\1 * 8) | \2
else
	db \1 ; tilemap transition
endc
ENDM

; 1: roomId
doorRoomId: MACRO
    dw \1
ENDM

; 1: target door pointer
doorTarget: MACRO
    dw \1
ENDM


; check actions

checkAction: MACRO
	db CHECK_ACTION
ENDM

; 1: room item id
; 2: item id
pickItem: MACRO
    dw \1, \2
ENDM

; 1: interaction id
roomInteraction: MACRO
    dw ROOM_INTERACTION_ID+\1, 0
ENDM

; typewriter action
typewriterAction: MACRO
    db TYPEWRITER_ACTION
	dw 0, 0
ENDM

; itembox action
itemboxAction: MACRO
	db ITEMBOX_ACTION
	dw 0, 0
ENDM

;
; room entity macros
;

; 1: entity id
; 2: entity var id
roomEntity: MACRO
    db \1
	dw \2
ENDM

; 1: entity x position
; 2: entity z position
; 3: entity facing
roomEntityPos: MACRO
	dw \1, \2, \3, 0
ENDM

;
; on floor actions
;

checkOnFloorAction: MACRO
	db DROPPED_ITEM
ENDM


; 1: player x position (center point)
; 2: player z position (center point)
; 3: player facing
playerPosition: MACRO
    dw \1, \2
    dw \3
ENDM

endRoomActions: MACRO
	db END_ROOM_ACTIONS
ENDM