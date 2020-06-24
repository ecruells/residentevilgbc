


MAX_FADE_STEPS 			    EQU $1F

UPDATE_BG_PALETTE           EQU $01 ; instant fade-in, used to update bg palettes
SET_FADE_IN                 EQU $20
SET_FADE_OUT                EQU $40
CHANGE_SCREEN_FADE_OUT      EQU $5C ; instant fade-out, used to enter or exit menus
FADE_OUT_FINISHED           EQU $5E
