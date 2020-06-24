

; sound channels
SOUND_CHANNEL_1		EQU $00 ; tone & sweep
SOUND_CHANNEL_2		EQU $01 ; tone
SOUND_CHANNEL_3		EQU $02 ; wave
SOUND_CHANNEL_4		EQU $03 ; noise

; channel states
CHANNEL_ACTIVE		EQU %00000001
CHANNEL_PLAYING		EQU %00000010

; ----------------------
; music branch constants

; similar to chain wait, but this extends the last played note length
lastNoteWait: MACRO
	db $60, \1
	ENDM

endChannel: MACRO
	db $61
	ENDM

channelLoop: MACRO
	db $62
	dw \1
	ENDM

; branch play data macro
;
; raw data struct:
; 	byte1 ($64): play branch header
; 	byte2: branch id (relative from the start of all music branches)
; 	byte3: branch seminotes transpose value
;   byte4: branch play counter, must be at least 1
;
; macro params:
; 	1: music branch pointer
; 	2: branch id relative to the music branch pointer
; 	3: branch seminote transposition
; 	4: branch play counter
playBranch: MACRO
	db $64, (\1 - music_branches_table) / 2 + \2, \3, \4
	ENDM

branchEnd: MACRO
	db $65
	ENDM

chlAction0x66: MACRO
	db $66, \1
	ENDM

enableSound: MACRO
	db $67, \1
	ENDM

tempo: MACRO
	db $69
	db \1
	ENDM

; actually, the chain wait is the note "C#6" with silent instrument,
; and its length is the wait length
chainWait: MACRO
	db $24, \1
	ENDM

; notes line macro
; 1: instrument table id (bit 7) & note (bits 6-0)
; 2: instrument id
; 3: note length
typenote0: MACRO
	db \1, (\2 << 4) | \3
	ENDM

typenote1: MACRO
	db $80 | (\1), (\2 << 4) | \3
	ENDM

; instruments effects table macros
envelopeTableEnd: MACRO
	db $FF
	ENDM

pitchBendTableEnd: MACRO
	db $7E
	ENDM

pitchBendTableLoop: MACRO
	db $7D
	dw \1
	ENDM

vibratoTableLoop: MACRO
	db $FF
	dw \1
	ENDM

; sfx macros
sfxChannel: MACRO
	db \1
	ENDM

soundEffectEnd: MACRO
	db $FF
	ENDM

soundEffectBranch: MACRO
	db $FE
	dw \1
	ENDM


; notes
C#3		EQU $00
D_3		EQU $01
D#3		EQU $02
E_3		EQU $03
F_3		EQU $04
F#3		EQU $05
G_3		EQU $06
G#3		EQU $07
A_3		EQU $08
A#3		EQU $09
B_3		EQU $0A
C_4		EQU $0B
C#4		EQU $0C
D_4		EQU $0D
D#4		EQU $0E
E_4		EQU $0F
F_4		EQU $10
F#4		EQU $11
G_4		EQU $12
G#4		EQU $13
A_4		EQU $14
A#4		EQU $15
B_4		EQU $16
C_5		EQU $17
C#5		EQU $18
D_5		EQU $19
D#5		EQU $1A
E_5		EQU $1B
F_5		EQU $1C
F#5		EQU $1D
G_5		EQU $1E
G#5		EQU $1F
A_5		EQU $20
A#5		EQU $21
B_5		EQU $22
C_6		EQU $23
C#6		EQU $24
D_6		EQU $25
D#6		EQU $26
E_6		EQU $27
F_6		EQU $28
F#6		EQU $29
G_6		EQU $2A
G#6		EQU $2B
A_6		EQU $2C
A#6		EQU $2D
B_6		EQU $2E
C_7		EQU $2F
C#7		EQU $30
D_7		EQU $31
D#7		EQU $32
E_7		EQU $33
F_7		EQU $34
F#7		EQU $35
G_7		EQU $36
G#7		EQU $37
A_7		EQU $38
A#7		EQU $39
B_7		EQU $3A
C_8		EQU $3B
C#8		EQU $3C
D_8		EQU $3D
D#8		EQU $3E
E_8		EQU $3F
F_8		EQU $40
F#8		EQU $41
G_8		EQU $42
G#8		EQU $43
A_8		EQU $44
A#8		EQU $45
B_8		EQU $46
C_9		EQU $47
C#9		EQU $48
D_9		EQU $49
D#9		EQU $4A
E_9		EQU $4B
F_9		EQU $4C
F#9		EQU $4D
G_9		EQU $4E
G#9		EQU $4F
A_9		EQU $50
A#9		EQU $51
B_9		EQU $52
C_10	EQU $53
C#10	EQU $54
D_10	EQU $55
D_10_2	EQU $56
D#10	EQU $57
E_10	EQU $58
E_10_2	EQU $59
F_10	EQU $5A
F_10_2	EQU $5B
F#10	EQU $5C
F#10_2	EQU $5D
G_10	EQU $5E
G_10_2	EQU $5F
