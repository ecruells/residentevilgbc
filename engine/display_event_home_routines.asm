; c: text bank
; de: text pointer
; hl: text position (y,x)
displayEventMessage:: ;00:0610
    ld a, [wCurrentRomBank]
    push af
    ld a, $01
    call bankSwitch
    ld a, c
    ld c, e
    ld b, d
    call printTextString
    pop af
    jp bankSwitch

; de: text pointer address
; hl: text position (y,x)
displayEventAutoTypingMessage:: ;00:0623
    ld a, [wCurrentRomBank]
    push af
    ld a, BANK(textPointers)
    call bankSwitch
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld a, [de]
    ld e, a
    ld a, $01
    call bankSwitch
    ld a, e ; message bank
    call printAutoTypingText
    pop af
    jp bankSwitch

loadEventRoomScreen: ;00:0641
    ld a, [wCurrentRomBank]
    push af
    push hl
    ld a, $01
    call bankSwitch
    call resetPalettes
    call hideSprites
    call loadRoomScreenCameraAndBgData
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    call haltCPU
    call updateRoomPalette
    pop hl
    pop af
    jp bankSwitch

loadEventRoomBg:: ;00:0664
    ld a, [wCurrentRomBank]
    push af
    ld a, $01
    call bankSwitch
    call resetPalettes
    call hideSprites
    call loadRoomScreenCameraAndBgData
    pop af
    jp bankSwitch


; fade in/out an event scene screen
;
; c: fading type
eventSceneScreenFade:: ;00:067A
    ld a, [wCurrentRomBank]
    push af
    ld a, $01
    call bankSwitch
    ld a, c
    ld [wPaletteFadeCounter], a
    ld b, 32
Loop689:
    push bc
    call haltCPU
    ld a, [wLoadEventBgImagePal]
    or a
    jr z, .label6AA ; if zero, load Room palette
; else, load bg image palette
    add a
    add a
    ld c, a
    ld b, 0
    ld hl, fallingStatuePaletteStruct+2
    add hl, bc
    inc hl
    inc hl
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, 8
    add hl, de
    call loadBgImagePalette
    jr .label6AD
.label6AA
    call updateRoomPalette
.label6AD
    pop bc
    dec b
    jr nz, Loop689
    pop af
    jp bankSwitch

;6B5

showEventDoorAnimation:: ;00:06B5
    ld a, [wCurrentRomBank]
    push af
    ld a, $01
    call bankSwitch
    call resetPalettes
    ld a, [wDoorAnimationType]
    cp a, STAIRS_1_UPWARD
    jr nc, showTilemapTransitionScene
    call showSpriteDoorsAnimation
    pop af
    jp bankSwitch
showTilemapTransitionScene: ;06CF
    call displayTilemapRoomsTransitions
    pop af
    jp bankSwitch

updateSceneBgAndAllSprites:: ;00:06D6
    ld a, [wCurrentRomBank]
    push af
    ld a, $01
    call bankSwitch
    call resetSpriteStructsBuffers
    call calcAllSpritesSizeAndScreenPosition
    call loadRoomScreenSpritesCaller
    call hideOAM
    call sortSpriteListByDrawPriorityCaller
    call loadAllSpritesTilesData
    call enableHDMA
    call swapCurrentOAMBuffer
    pop af
    jp bankSwitch
;06FB


loadEventRoomBgMask: ;00:06FB
    ld a, [wCurrentRomBank]
    push af
    ld a, $01
    call bankSwitch
    call loadRoomScreenBackgroundMaskCaller
    pop af
    jp bankSwitch


displayEventSceneCaller:: ;00:070B
    ld a, BANK(displayEventScene)
    ld hl, displayEventScene
    jp jumpToHLRoutineA
;713

showEventBgImage: ;00:0713
    ld c, a
    ld a, [wCurrentRomBank]
    push af
    ld a, $01
    call bankSwitch
    push bc
    call resetPalettes
    pop bc
    sla c
    sla c
    ld b, $00
    ld hl, fallingStatuePaletteStruct+2
    add hl, bc
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld a, c
    call loadTileMapImage
    pop af
    jp bankSwitch
