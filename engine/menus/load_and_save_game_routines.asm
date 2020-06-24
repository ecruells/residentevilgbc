; print load/save menu texts
;
; de: text pointer
printSavingChars:: ;01:57DB
	ld a, $FF
	ld [wTypingCharactersFlag], a ; enable typing each char like a typewriter
	jr typingLoop
printTypewriterText:: ;01:57E2
    ld a, [de]
    ld l, a
    ld h, 0
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld bc, _SCRN0
    add hl, bc
    inc de
    ld a, [de]
    add a, l
    ld l, a
    inc de
printSavedText: ;$01:57F4
    xor a
    ld [wTypingCharactersFlag], a ; reset flag to only print normal chars
typingLoop:
    ld a, [de]
    or a ; a = 0 check if char is end of string
    ret z
    cp a, 32 ;if char is space
    jr z, .printSpace
    cp a, 57
    jr c, .printNumericChar 
    cp a, 73
    jr c, .printAlphabetCharCol1
.printAlphabetCharCol2 ; I-Z chars column
    sub a, 73
    push hl ; store tilemap pos
    ld l, a
    ld h, 0
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld bc, _SCRN0+$15 ; set second tilemap fonts column
    add hl, bc
    ld c, l
    ld b, h
    pop hl
    jr .printChar
.printAlphabetCharCol1  ; A-H chars column
    sub a, 65
    push hl
    ld l, a
    ld h, 0
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld bc, _SCRN0+$154 ; start of alphabet
    add hl, bc
    ld c, l
    ld b, h
    pop hl
    jr .printChar
.printNumericChar
    sub a, 48
    push hl
    ld l, a
    ld h, 0
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld bc, _SCRN0+$14
    add hl, bc
    ld c, l
    ld b, h
    pop hl
    jr .printChar

.printChar
    call vblankWait
    ld a, [bc]
    ld [hl], a
    ld a, 1
    ld [rVBK], a ;vram bank select
    ld a, [bc]
    ld [hl], a
    xor a
    ld [rVBK], a ;vram bank select
    ld a, [wTypingCharactersFlag]
    or a
    jr z, .printSpace ; if not typing chars
    push de
    push hl
    ld a, SAVE_TYPING_SFX
    call playSFX
    ld b, $10
    call routineDelay
    pop hl
    pop de
.printSpace
    inc hl
    inc de
    jp typingLoop

printSaveSlotsTexts:: ;01:586A
    ld de, sSaveSlot1Flag
    ld b, 4
.printSlotLoop
    push bc
    push de
    call enableExtRAM
    ld a, [de]
    or a
    jr z, .Label589F ; if save slot is empty
    ld a, 4
    sub a, b
    ld l, a
    ld h, 0
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, _SCRN0+$82
    add hl, de
    ld a, 4
    sub a, b
    add a
    add a
    ld c, a
    add a
    add a
    add a, c
    ld de, sSaveSlot1Info
    add a, e
    ld e, a
    ld a, 0
    adc a, d
    ld d, a
    call printSavedText
    jr .Label58B5
.Label589F
    ld a, 4
    sub a, b
    ld l, a
    ld h, 0
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, _SCRN0+$82
    add hl, de
    ld de, EmptySlotText
    call printSavedText
.Label58B5
    call disableExtRAM
    pop de
    inc de
    inc de
    inc de
    inc de
    pop bc
    dec b
    jr nz, .printSlotLoop
    ret

clearExtRAM: ;01:58C2
    call enableExtRAM
; check if sram is already initialized
    ld a, [sSRamInitiazedFlag0]
    cp a, SAVE_GAME_FLAG_0
    jr nz, .clearExtRam
    ld a, [sSRamInitiazedFlag1]
    cp a, SAVE_GAME_FLAG_1
    jr nz, .clearExtRam
    ld a, [sSRamInitiazedFlag2]
    cp a, SAVE_GAME_FLAG_2
    jr nz, .clearExtRam
    ld a, [sSRamInitiazedFlag3]
    cp a, SAVE_GAME_FLAG_3
    jr nz, .clearExtRam
    jp disableExtRAM
.clearExtRam
    ld hl, sSRamStart
    ld bc, $1FFC ; bytes to clear
.clearExtRamLoop
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or a, c
    jr nz, .clearExtRamLoop
.initializeSram
    ld a, SAVE_GAME_FLAG_0
    ld [sSRamInitiazedFlag0], a
    ld a, SAVE_GAME_FLAG_1
    ld [sSRamInitiazedFlag1], a
    ld a, SAVE_GAME_FLAG_2
    ld [sSRamInitiazedFlag2], a
    ld a, SAVE_GAME_FLAG_3
    ld [sSRamInitiazedFlag3], a
    jp disableExtRAM


; save the current game data in ext ram
saveGame:: ;01:5908
    call deleteSaveSlotText
    ld a, [wCursorPosId]
    add a
    add a
    ld e, a
    ld d, 0
    ld hl, sSaveSlot1Flag
    add hl, de
    call enableExtRAM
    ld [hl], $FF
    ld a, [wCursorPosId]
    add a
    add a
    ld c, a
    add a
    add a
    add a, c
    ld c, a
    ld b, 0
    ld hl, sSaveSlot1Info
    add hl, bc ; apply cursor offset
    push hl
    ld de, ChrisName
    ld a, [wEntityId]
    cp a, CHRIS
    jr z, .Label593A
;if JILL
    ld de, JillName
.Label593A
    ld bc, 6
    call copyBytesData ; copy player name tiles to ext ram
; get save room's name, Main Hall 1F name by default, all others save rooms are called storXF
    ld de, MainHall1FSaveText
    ld a, [wRoomId]
    or a
    jr z, .Label594C ; if MAIN_HALL_1F
; other save rooms
    ld de, StorSaveText
.Label594C
    ld bc, 9 ; max chars
    call copyBytesData ; copy room name to ext ram
    push hl
    ld a, [wSavesCounter]
    add a
    ld e, a
    ld d, 0
    ld hl, SavesCounterNumberTable
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wSavesCounter]
    inc a ; increase saves counter
    ld [wSavesCounter], a
    pop hl
    ld bc, 3
    call copyBytesData ; copy saves number to ext ram
    ld [hl], 0
    ld a, [wCursorPosId]
    ld l, a
    ld h, 0
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, _SCRN0+$82
    add hl, de
    pop de
    call printSavingChars
    ld de, sSRamStart+SAVE_SLOT_LENGTH
    ld a, [wCursorPosId]
    add a
    ld c, a
    add a
    add a, c
    add a, d
    ld d, a
.setSaveFlags
    ld a, SAVE_GAME_FLAG_1
    ld [wSaveGameFlag1], a
    ld a, SAVE_GAME_FLAG_2
    ld [wSaveGameFlag2], a
    ld a, SAVE_GAME_FLAG_3
    ld [wSaveGameFlag3], a
    ld hl, wWRamStart
    ld bc, SAVE_SLOT_LENGTH
.saveGameDataLoop
    ld a, [hli]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, .saveGameDataLoop
    call disableExtRAM
    ld b, $40
    jp routineDelay

; load a saved game data in ext ram into wram
loadGame: ;01:59B6
    ld a, [wCursorPosId] ; save slot Id
    add a
    add a
    ld e, a
    ld d, 0
    ld hl, sSaveSlot1Flag
    add hl, de ; apply save slot offset
    call enableExtRAM
    ld a, [hl]
    or a
    jr z, .Label59F8
    ld de, sSRamStart+SAVE_SLOT_LENGTH
    ld a, [wCursorPosId]
    add a
    ld c, a
    add a
    add a, c
    add a, d
    ld d, a
    ld a, SAVE_GAME_FLAG_1
    ld [wSaveGameFlag1], a
    ld a, SAVE_GAME_FLAG_2
    ld [wSaveGameFlag2], a
    ld a, SAVE_GAME_FLAG_3
    ld [wSaveGameFlag3], a
    ld hl, wWRamStart
    ld bc, SAVE_SLOT_LENGTH
.loadGameDataLoop
    ld a, [de]
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, .loadGameDataLoop
    call disableExtRAM
    ld a, $FF
    ret
.Label59F8
	call disableExtRAM
	xor a
	ret
;59FD