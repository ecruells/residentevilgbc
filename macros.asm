;text
text		EQUS "db "
endText		EQUS "db $01"  		; End of text
newLine		EQUS "db $00," 		; New line
nextPage	EQUS "db $00,$02," 	; File next page
typing	    EQUS "db $03," 		; Typing text, not skipable
sclLine		EQUS "db $00,$04," 	; scroll text to next line
sclText		EQUS "db $04," 		; scroll new text
eof			EQUS "db $00,$01"	; end of file

;room actions constants

ITEM_VAR_ID				EQU $00
CHECK_ACTION_ID			EQU $00
SPRITE_VAR_ID			EQU $00
DOOR_VAR_ID				EQU $00
TYPEWRITER_ACTION		EQU $90
ITEMBOX_ACTION			EQU $91
DROPPED_ITEM			EQU $A8
CHECK_ACTION			EQU $A9
END_ROOM_ACTIONS		EQU $FF

;cameras types
NORMAL_CAM				EQU $00
OVERHEAD_CAM			EQU $40

;actions
NO_ACTION				EQU $00
DROPPED_ITEM_ACTION		EQU $01
OPEN_DOOR_ACTION		EQU $01
LOAD_SAVE_MENU_ACTION	EQU $02
GET_ITEM_ACTION			EQU $03
ITEMBOX_MENU_ACTION		EQU $04
BTN_CHECK_ACTION		EQU $05

;loadSave
LOAD_GAME_MODE			EQU $00
SAVE_GAME_MODE			EQU $01

SAVE_SLOT_LENGTH		EQU $600

;weapons damage
BERRETTA_DAMAGE			EQU 12
SHOTGUN_DAMAGE			EQU 24


;workram

WRAM_LENGTH				EQU $1F00



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

;sound
INCLUDE "macros/sound_macros.asm"











