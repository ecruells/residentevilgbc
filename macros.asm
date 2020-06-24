; text
text		EQUS "db "
endText		EQUS "db $01"  		; End of text
newLine		EQUS "db $00," 		; New line
nextPage	EQUS "db $00,$02," 	; File next page
typing	    EQUS "db $03," 		; Typing text, not skipable
sclLine		EQUS "db $00,$04," 	; scroll text to next line
sclText		EQUS "db $04," 		; scroll new text
eof			EQUS "db $00,$01"	; end of file
clearText	EQUS "db $C9"	    ; clear text

NEW_LINE				EQU $00
END_OF_STRING			EQU $01
FILE_NEXT_PAGE			EQU $02
TYPING_TEXT				EQU $03
SCROLL_TYPING_TEXT		EQU $04

; actions
NO_ACTION				EQU $00
DROPPED_ITEM_ACTION		EQU $01
OPEN_DOOR_ACTION		EQU $01
LOAD_SAVE_MENU_ACTION	EQU $02
GET_ITEM_ACTION			EQU $03
ITEMBOX_MENU_ACTION		EQU $04
BTN_CHECK_ACTION		EQU $05
USE_TYPEWRITER_ACTION	EQU $80

; loadSave
LOAD_GAME_MODE			EQU $00
SAVE_GAME_MODE			EQU $01

SAVE_SLOT_LENGTH		EQU $600

; weapons damage
BERRETTA_DAMAGE			EQU 12
SHOTGUN_DAMAGE			EQU 24

; enemies attack damage
ZOMBIE_BITE_DAMAGE		EQU 8

ZOMBIE_HP				EQU 64


; workram
WRAM_LENGTH				EQU $1F00


; sprite states
ENTITY_ENABLED_FLAG		EQU %10000000
ENTITY_VISIBLE_FLAG		EQU %01000000


; OAM DMA transfer routine pointer
OAMDMATransfer 			EQU $FF80 ;FF80-FF89

; save game flags
SAVE_GAME_FLAG_0		EQU $4E
SAVE_GAME_FLAG_1		EQU $53
SAVE_GAME_FLAG_2		EQU $50
SAVE_GAME_FLAG_3		EQU $41


; Enumerate constants

const_def: MACRO
const_value = 0
ENDM

const: MACRO
\1 EQU const_value
const_value = const_value + 1
ENDM

shift_const: MACRO
\1 EQU (1 << const_value)
const_value = const_value + 1
ENDM

; macro for putting a byte then a word
dbw: MACRO
	db \1
	dw \2
	ENDM

; macro for putting a word then a byte
dwb: MACRO
	dw \1
	db \2
	ENDM

; items sprites address macro
itemSpritePointer: MACRO
    dw itemsSpriteSheet + ((\1/6)*$180)+((\1%6)*$20)
    ENDM

; load de by comma separated 8bit values
ldde: MACRO
	ld de, (\1 << 8) | \2
ENDM

; load bc by comma separated 8bit values
ldbc: MACRO
	ld bc, (\1 << 8) | \2
ENDM

; load hl by comma separated 8bit values
ldhl: MACRO
	ld hl, (\1 << 8) | \2
ENDM


; title voice pcm macros
titleVoicePcmPart1: MACRO
	ld hl, titleVoicePcm+4
ENDM

titleVoicePcmPart2: MACRO
	ld hl, titleVoicePcm+3202
ENDM

; cameras types
NORMAL_CAM				EQU %00000000
OVERHEAD_CAM			EQU %01000000

; camera struct
cam: MACRO
	dw \1, \2, \3, \4, \5, \6, \7, \8
	db \9
	SHIFT 
	db (\9|$28)
ENDM


INCLUDE "macros/sound_macros.asm"
INCLUDE "macros/camera_change_macros.asm"
INCLUDE "macros/map_position_macros.asm"
INCLUDE "macros/event_scripts_macros.asm"
INCLUDE "macros/room_actions_macros.asm"











