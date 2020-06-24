mainMenuRoutine: ;01:40A5
    xor a ;main menu mode
    call loadMainMenuTileMap
    xor a
    ld [wCursorPosId], a
    ld a, ITEM_SLOT_1
    ld [wMainMenuSelectedCursorId], a
    ld a, $28
    ld [wPoliceCardXpos], a ; unused var in this routine
    ld a, $38
    ld [wPoliceCardYpos], a ; unused var in this routine
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    call displaySelectedItemName
.mainMenuLoop
    call haltCPU
    call updateHealthMeter
    call loadMainMenuFaceSprite
    ld c, MENU_TOP_OPTIONS_ENABLED
    call updateMainMenuSlotsCursorsCaller
    call loadMenuItemsSpritesCaller
    call loadEquippedItemSpriteCaller
    call updateFileBookmarksCursors
    ld a, [wPaletteFadeCounter]
    or a
    call z, checkMenuInputPress
    call enableHDMA
    call swapCurrentOAMBuffer
    ld a, [wPaletteFadeCounter]
    cp a, FADE_OUT_FINISHED
    ret z
    ld hl, mainMenuTilemapStruct+8
    call loadBgImagePalette
    jr .mainMenuLoop
