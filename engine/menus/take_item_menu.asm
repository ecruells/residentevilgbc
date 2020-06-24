takeItemMenu: ;00:366F
    call resetPalettes
    xor a
    call loadMainMenuTileMap
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    ld a, $FF
    ld [wMainMenuSelectedCursorId], a ; hide default selected item slot cursor
    ld hl, mainMenuTilemapStruct+8
    call loadBgImagePalette
    call loadItemBigSpriteCaller
    ld a, BANK(itemsTextsPointersStructsTable)
    call bankSwitch
    ld a, [wSelectedItemId]
    ld l, a
    ld h, 0
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, itemsTextsPointersStructsTable
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl] ; get take item string pointer
    ld a, $01
    call bankSwitch
    ldhl 15, 0 ; text position
    ld a, BANK(itemsTextsPointersStructsTable)
    call printTextString ; print take item string ("WILL YOU TAKE XXXX YES  NO")
takeItemMenuLoop:
    call haltCPU
    call updateHealthMeter
    call loadMainMenuFaceSprite
    ld c, MENU_TOP_OPTIONS_ENABLED
    call updateMainMenuSlotsCursorsCaller
    call loadMenuItemsSpritesCaller
    call loadEquippedItemSpriteCaller
    call printChoiceArrow
    call enableHDMA
    call swapCurrentOAMBuffer
    ld a, [wButtonPressId]
    and a, A_START_INPUT
    jp nz, includeFoundItem
; continue until chose an option
    jr takeItemMenuLoop
;36D2
