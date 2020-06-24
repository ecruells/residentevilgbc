loadPlayerSelectScreen:: ;00:33EB
    ld hl, playerSelectScreenTilemapStruct
    ld a, 20 ; tiles width
    call loadTileMapImage
    ld a, BANK(policeIdCardExtraColorsSprites)
    call bankSwitch
; copy sprites tiles data in buffer
    ld de, policeIdCardExtraColorsSprites
    ld hl, wSpriteTilesBuffer
    ld bc, $180
    call copyBytesData
    ld de, policeIdCardCharFaces
    ld hl, wSpriteTilesBufferCC+$80
    ld bc, $300
    call copyBytesData
    ld de, arrowCursor
    ld hl, wSpriteTilesBufferCF+$80
    ld bc, $20
    call copyBytesData
;
    ld a, $01
    call bankSwitch
    call enableHDMA
    xor a ; 0
    ld [wCursorPosId], a ; set cursor id 0 (chris)
    ld a, 40
    ld [wPoliceCardXpos], a ; set police card x pos
    ld a, 56
    ld [wPoliceCardYpos], a ; set police card y pos
    ld a, SET_FADE_IN
    ld [wPaletteFadeCounter], a
.playerSelectLoop
    call updatePolicecardFacePosition
    call updatePolicecardLogoColorsPosition
    call updatePolicecardCursors
    call haltCPU
    call updatePolicecardTilesPosition
    call swapCurrentOAMBuffer
    call hideOAM
    ld a, [wPaletteFadeCounter]
    or a
    jr nz, .Label3480
    ld a, [wPoliceCardXpos]
    cp a, 40
    jr z, .Label346C
; police card is moving, keep moving 8 pixels left
    sub a, 8
    ld [wPoliceCardXpos], a
    cp a, -64
    jr nz, .Label3480
 ; swap selected player id (0 or 1) when card has rotated
    ld a, [wCursorPosId]
    xor a, $01
    ld [wCursorPosId], a
    jr .Label3480
.Label346C
    ld a, [wButtonPressId]
    and a, LEFT_RIGHT_INPUT
    jr z, .Label3480
; start moving police card if left/right input is pressed
    ld a, [wPoliceCardXpos]
    sub a, 8
    ld [wPoliceCardXpos], a
    ld a, SELECT_MENU_SFX
    call playSFX
.Label3480
    ld a, [wPoliceCardXpos]
    cp a, 40
    jr nz, .Label34A1
    ld a, [wPaletteFadeCounter]
    cp a, FADE_OUT_FINISHED
    ret z
    or a
    jr nz, .Label34A1
    ld a, [wButtonPressId]
    and a, A_START_INPUT
    jr z, .Label34A1
; if player is selected
    ld a, SET_FADE_OUT
    ld [wPaletteFadeCounter], a
    ld a, START_GAME_SFX
    call playSFX
.Label34A1
    ld hl, playerSelectScreenTilemapStruct+8
    call loadBgImagePalette
    jr .playerSelectLoop

;00:34A9