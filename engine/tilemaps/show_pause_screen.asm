; show pause screen and make a quick save
showPauseScreen: ;45A9
; save game
    call enableExtRAM
    ld a, SAVE_GAME_FLAG_1
    ld [wSaveGameFlag1], a
    ld a, SAVE_GAME_FLAG_2
    ld [wSaveGameFlag2], a
    ld a, SAVE_GAME_FLAG_3
    ld [wSaveGameFlag3], a
    ld hl, wWorkRamStart+$100
    ld de, sSRamStart
    ld bc, SAVE_SLOT_LENGTH
.saveDataLoop
    ld a, [hli]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, .saveDataLoop
    call disableExtRAM

restorePauseMenu: ; when restored from quick save, it starts here
    call resetPalettes
    call hideSprites
    xor a
    call playMusic ; stop music
; show pause screen bg
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    ld hl, pauseScreenTilemapStruct
    ld a, 20 ; tiles width
    call loadTileMapImage
    ld hl, pauseScreenPaletteStruct
    call loadBgImagePalette

.pauseLoop1
    call haltCPU
    ld a, [wButtonPressId]
    and a, START_INPUT
    jr nz, .pauseLoop1

.pauseLoop2
    call haltCPU
    ld a, [wButtonPressId]
    and a, START_INPUT
    jr z, .pauseLoop2

.pauseLoop3
    call haltCPU
    ld a, [wButtonPressId]
    and a, START_INPUT
    jr nz, .pauseLoop3

; pause loop broke, erase quick save flags and return to main game loop
    call enableExtRAM
    xor a
    ld [sQuickSaveFlag01], a
    ld [sQuickSaveFlag02], a
    ld [sQuickSaveFlag03], a
    call disableExtRAM
    ld a, [wCurrentMusicId]
    call playMusic ; restore music
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    call resetPalettes
    jp gameLoopWithEventCheck ; go back to game loop
;462B