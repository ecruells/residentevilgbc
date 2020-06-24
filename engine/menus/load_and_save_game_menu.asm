; load/save game menu
;
; a: menu mode (0: load, 1: save)
loadSaveGameMenu:: ;00:2DD0
    ld [wLoadOrSave], a
    ld hl, loadSaveScreenTilemapStruct
    ld a, 22 ; tiles width
    call loadTileMapImage
    ld a, BANK(arrowCursor)
    call bankSwitch
    ld de, arrowCursor
    ld hl, wSpriteTilesBuffer
    ld bc, $20 ; bytes count
    call copyBytesData
    ld a, $01
    call bankSwitch
    ld de, LoadGameText ; LOAD GAME
    ld a, [wLoadOrSave]
    cp a, LOAD_GAME_MODE
    jr z, .Label2DFE
    ld de, SaveGameText ; SAVE GAME
.Label2DFE
    call printTypewriterText
    call printSaveSlotsTexts
    ld de, DoNotLoadText ; DO NOT LOAD
    ld a, [wLoadOrSave]
    cp a, LOAD_GAME_MODE
    jr z, .Label2E11 ; if load mode
; if save mode
    ld de, DoNotSaveText ; DO NOT SAVE
.Label2E11
    call printTypewriterText
    call hideSprites
    call enableHDMA
    xor a
    ld [wCursorPosId], a
    ld a, SET_FADE_IN
    ld [wPaletteFadeCounter], a

loadSaveMenuLoop:
    call haltCPU
    call updateLoadSaveMenuCursor
    ld hl, wCursorPosId
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jr z, .Label2E4A
    ld a, [wPressingUpKey]
    or a
    jr nz, .Label2E4E
    ld a, [hl]
    or a
    jr z, .Label2E4E
    dec [hl] ; dec cursor position
    ld a, $01
    ld [wPressingUpKey], a
    ld a, SAVE_TYPING_SFX
    call playSFX
    jr .Label2E4E
.Label2E4A
    xor a
    ld [wPressingUpKey], a
.Label2E4E
    ld hl, wCursorPosId
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jr z, .Label2E70
    ld a, [wPressingDownKey]
    or a
    jr nz, .Label2E74
    ld a, [hl]
    cp a, $04
    jr z, .Label2E74
    inc [hl] ; inc cursor position
    ld a, $01
    ld [wPressingDownKey], a
    ld a, SAVE_TYPING_SFX
    call playSFX
    jr .Label2E74
.Label2E70
    xor a
    ld [wPressingDownKey], a
.Label2E74
    ld a, [wPaletteFadeCounter]
    cp a, FADE_OUT_FINISHED
    ret z
    or a
    jr nz, continueLoadSaveLoop
    ld a, [wButtonPressId]
    and a, AB_START_INPUT
    jr z, continueLoadSaveLoop
    ld a, [wCursorPosId]
    cp a, $04 ; "do not save/load" position
    jr z, exitLoadSaveMenu
    ld a, [wLoadOrSave]
    cp a, LOAD_GAME_MODE
    jr z, loadGameAction ; if load mode
; if save mode
    call saveGame
    jr exitLoadSaveMenu

loadGameAction:
    ld a, [wCursorIdBuffer]
    push af
    call loadGame
    ld c, a
    pop af
    ld [wCursorIdBuffer], a ; restore cursor id buffer
    ld a, LOAD_GAME_MODE
    ld [wLoadOrSave], a ; set to load mode
    ld a, c
    or a
    jr z, continueLoadSaveLoop
    pop hl
    call resetPalettes
    call hideSprites
    ld de, $023C ; first stack value after load game
    push de
    call displayStartGameWelcomeMessage
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    jp gameLoopWithEventCheck

exitLoadSaveMenu:
    ld a, SET_FADE_OUT
    ld [wPaletteFadeCounter], a
    ld a, [wLoadOrSave]
    cp a, LOAD_GAME_MODE
    jr nz, continueLoadSaveLoop
    ld a, [wCursorPosId]
    cp a, $04
    jr z, continueLoadSaveLoop
    ld a, START_GAME_SFX
    call playSFX
continueLoadSaveLoop:
    call swapCurrentOAMBuffer
    ld hl, loadSaveScreenPaletteStruct
    call loadBgImagePalette
    jp loadSaveMenuLoop
