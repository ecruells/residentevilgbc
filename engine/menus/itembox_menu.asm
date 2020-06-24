itemboxMenu: ;01:40F6
    ld a, ITEMBOX_MEMU_MODE
    call loadMainMenuTileMap
    xor a
    ld [wCursorPosId], a
    ld a, ITEM_SLOT_1
    ld [wMainMenuSelectedCursorId], a
    ld a, 40
    ld [wPoliceCardXpos], a ; unused var in this menu
    ld a, 56
    ld [wPoliceCardYpos], a ; unused var in this menu
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    call displaySelectedItemName
    call displayItemboxItemsList
.itemboxMenuLoop
    call haltCPU
    call updateHealthMeter
    call loadMainMenuFaceSprite
    ld c, MENU_TOP_OPTIONS_DISABLED
    call updateMainMenuSlotsCursorsCaller
    call loadMenuItemsSpritesCaller
    call loadEquippedItemSpriteCaller
    call loadItemboxItemSpriteCaller
    call updateItemboxCursorCaller
    ld a, [wPaletteFadeCounter]
    or a
    call z, updateItemboxMenuInputs
    call enableHDMA
    call swapCurrentOAMBuffer
    ld a, [wPaletteFadeCounter]
    cp a, FADE_OUT_FINISHED
    ret z
    ld hl, itemBoxMenuTilemapStruct+8
    call loadBgImagePalette
    jr .itemboxMenuLoop
