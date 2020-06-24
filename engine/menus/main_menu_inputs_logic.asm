checkMenuInputPress:: ;00:37E3
    ld a, [wMainMenuSelectedCursorId]
    cp a, SUBMENUS_CURSOR
    jr nc, submenusOrCombineInputCheck
; item slots and top options cursor
    call checkMenuLeftKeyPress
    call checkMenuRightKeyPress
    call checkMenuUpKeyPress
    call checkMenuDownKeyPress
    call checkMenuConfirmKeyPress
    ld a, [wButtonPressId]
    and a, B_INPUT
    jr z, .resetMenuBInputPress
    ld a, [wPressingBButton]
    or a
    ret nz ; return if B input press
.exitMenu
    dec a ; enable B button press
    ld [wPressingBButton], a
    ld a, CHANGE_SCREEN_FADE_OUT
    ld [wPaletteFadeCounter], a
    ret
.resetMenuBInputPress
    xor a
    ld [wPressingBButton], a
    ret

; if cursor is in a submenu (files, map, radio, item options or combine grid)
submenusOrCombineInputCheck ;00:3814
    cp a, COMBINE_ITEM_MODE
    jr c, .checkSubmenuInputs
.combineGridInputs
    call checkMenuLeftKeyPress
    call checkMenuRightKeyPress
    call checkCombineGridUpInput
    call checkCombineGridDownInput
    call checkCombineGridConfirmInput
    jp checkSubmenuCancelInput
.checkSubmenuInputs
    call checkSubmenuLeftInput
    call checkSubmenuRightInput
    call checkSubmenuUpInput
    call checkSubmenuDownInput
    call checkSubmenuConfirmInput
    jp checkSubmenuCancelInput

checkSubmenuUpInput: ;383C
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jr z, Label386D
    ld a, [wPressingUpKey]
    or a
    ret nz
; Up key pressed
    ld a, $FF
    ld [wPressingUpKey], a
    ld a, [wMainMenuSelectedCursorId]
    cp a, FILE_MENU
    jr z, checkFilebookSubmenuUpInput
    cp a, CHECK_ITEM_CURSOR
    ret c ; if top submenu
; cursor is in item check submenu
    dec a ; move to use/equip
    ld [wMainMenuSelectedCursorId], a
    call updateItemSubmenuTilemap
    ld a, SELECT_MENU_SFX
    jp playSFX

checkFilebookSubmenuUpInput
    ld a, [wFileBookmarkCursorPos]
    or a
    ret z ; return if top bookmark
    dec a
    ld [wFileBookmarkCursorPos], a
    ret
Label386D: ;00:386D
    xor a
    ld [wPressingUpKey], a
    ret
;3872

checkSubmenuDownInput: ;00:3872
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jr z, Label38A7
    ld a, [wPressingDownKey]
    or a
    ret nz
    ld a, $FF
    ld [wPressingDownKey], a
    ld a, [wMainMenuSelectedCursorId]
    cp a, FILE_MENU
    jr z, checkFilebookSubmenuDownInput
    cp a, USE_EQUIP_CURSOR
    ret c
; cursor is in use/equip submenu
    cp a, COMBINE_CURSOR
    ret nc ; return if in combine submenu
    inc a ; move to check option submenu
    ld [wMainMenuSelectedCursorId], a
    call updateItemSubmenuTilemap
    ld a, SELECT_MENU_SFX
    jp playSFX

checkFilebookSubmenuDownInput
    ld a, [wFileBookmarkCursorPos]
    cp a, FILE_MENU
    ret z ; return if bottom bookmark
    inc a
    ld [wFileBookmarkCursorPos], a
    ret
Label38A7: ;00:38A7
    xor a
    ld [wPressingDownKey], a
    ret
;38AC

checkSubmenuLeftInput: ;00:38AC
    ld a, [wButtonPressId]
    and a, LEFT_INPUT
    ret z
    ld a, [wMainMenuSelectedCursorId]
    cp a, FILE_MENU
    ret nz ; return if not filebook menu
; filebooks submenu
    ld a, [wFileBookId]
    or a
    ret z ; ret if first filebook
    dec a
    ld [wFileBookId], a
    ld a, SELECT_MENU_SFX
    call playSFX
    call updateFilebookSubmenuTilemap
    call updateFileBookmarksCursors
    ld b, $20
    jp routineDelay

checkSubmenuRightInput: ;38D1
    ld a, [wButtonPressId]
    and a, RIGHT_INPUT
    ret z
    ld a, [wMainMenuSelectedCursorId]
    cp a, FILE_MENU
    ret nz
; filebook submenu
    ld a, [wFileBookId]
    cp a, 2
    ret z ; return if last filebook
    inc a
    ld [wFileBookId], a
    ld a, SELECT_MENU_SFX
    call playSFX
    call updateFilebookSubmenuTilemap
    call updateFileBookmarksCursors
    ld b, $20
    jp routineDelay

checkSubmenuCancelInput: ;01:38F7
    ld a, [wButtonPressId]
    and a, B_INPUT
    jr z, Label3934
    ld a, [wPressingBButton]
    or a
    ret nz
    dec a
    ld [wPressingBButton], a
    ld a, [wMainMenuSelectedCursorId]
    cp a, FILE_MENU
    jr z, exitFilebookSubmenu
    cp a, MAP_MENU
    jr z, exitMapSubmenu
    cp a, MAP_DETAIL_MENU
    jr z, exitMapDetailSubmenu
    cp a, USE_EQUIP_CURSOR
    ret c
; if in item check or combine submenus
    ld a, ITEM_SLOT_1
    ld [wMainMenuSelectedCursorId], a ; back to item slot 1
    call clearItemDetailWindowBgMap
    call loadMainMenuPalette
    call clearItemDetailWindowTiles
    call displaySelectedItemName
    ld a, CANCEL_SFX
    call playSFX
    ld b, $10
    jp routineDelay
Label3934:
    xor a
    ld [wPressingBButton], a ; reset B input press
    ret

exitFilebookSubmenu ;00:3939
    call loadMainMenuPalette
    call clearItemDetailWindowBgMap
    call clearItemDetailWindowTiles
    ld a, ITEM_SLOT_1
    ld [wMainMenuSelectedCursorId], a ; return to item slot 1
    call updateFileBookmarksCursors ; hide bookmarks sprites
    ld a, CANCEL_SFX
    jp playSFX

exitMapSubmenu
    call loadMainMenuPalette
    call clearItemDetailWindowTiles
    ld a, ITEM_SLOT_1
    ld [wMainMenuSelectedCursorId], a ; return to item slot 1
    ld a, CANCEL_SFX
    jp playSFX

exitMapDetailSubmenu
    call loadMainMenuPalette
    call clearItemDetailWindowTiles
    call updateMapSubmenuTilemap
    ld a, MAP_MENU
    ld [wMainMenuSelectedCursorId], a ; back to map submenu
    ld a, CANCEL_SFX
    call playSFX
    ld b, $20
    jp routineDelay


checkCombineGridConfirmInput: ;3977
    ld a, [wButtonPressId]
    and a, A_INPUT
    ret z
    jp combineSelectedItems

checkSubmenuConfirmInput:
    ld a, [wButtonPressId]
    and a, A_INPUT
    jp z, resetSubmenuConfirmInputPress
    ld a, [wPressingAButton]
    or a
    ret nz
    ld a, $FF
    ld [wPressingAButton], a
    ld a, [wMainMenuSelectedCursorId]
    cp a, USE_EQUIP_CURSOR
    jr z, checkUseEquipSubmenuConfirmInput
    cp a, CHECK_ITEM_CURSOR
    jp z, checkItemCheckSubmenuConfirmInput
    cp a, COMBINE_CURSOR
    jp z, checkItemCombineSubmenuConfirmInput
    cp a, FILE_MENU
    jp z, checkFilebooksSubmenuConfirmInput
    cp a, MAP_MENU
    ret nz
; is map menu
    cp a, ITEM_DESC_MODE
    jp z, checkItemDescriptionConfirmInput ; return
; check map selection confirm input
    call clearItemDetailWindowTiles
    call clearItemDetailWindowBgMap
    call loadRoomsMapWindow
    ld a, MAP_DETAIL_MENU
    ld [wMainMenuSelectedCursorId], a ; set map detail mode
    ld a, CONFIRM_SFX
    jp playSFX

checkUseEquipSubmenuConfirmInput:
    ld a, [wSelectedSlotId]
    sub a, ITEM_SLOT_1
    ld e, a
    ld d, 0
    ld hl, wItemIdSlot1
    add hl, de
    ld a, [hl] ; get selected item id
    cp a, BERRETTA
    jr z, equipSelectedWeapon
    cp a, COMBAT_KNIFE
    jr z, equipSelectedWeapon
    cp a, SHOTGUN
    jr z, equipSelectedWeapon
; not a weapon, so check if item can be used
    jp checkItemUsage

; a: weapon item id
equipSelectedWeapon:
    ld c, a
    ld a, [wEquippedItemId]
    cp a, c
    jr nz, .Label39E8
; if the same weapon, unequip it
    ld c, EMPTY
.Label39E8
    ld a, c
    ld [wEquippedItemId], a
    ld a, CONFIRM_SFX
    call playSFX
    ld a, ITEM_SLOT_1
    ld [wMainMenuSelectedCursorId], a ; return to item slot mode
    call clearItemDetailWindowBgMap
    call loadMainMenuPalette
    call clearItemDetailWindowTiles
    call loadEquippedItemSpriteCaller
    ld b, $10
    jp routineDelay


checkItemCheckSubmenuConfirmInput: ;3A07
    call clearItemDetailWindowBgMap
    call clearItemDetailWindowTiles
    call loadItemBigSpriteCaller
    call displaySelectedItemName
    ld a, CONFIRM_SFX
    call playSFX
    ld a, ITEM_DESC_MODE
    ld [wMainMenuSelectedCursorId], a ; set item description mode
    ld a, [wSelectedSlotId]
    sub a, ITEM_SLOT_1
    ld e, a
    ld d, 0
    ld hl, wItemIdSlot1
    add hl, de
    ld a, [hl] ; get selected item id
; obtain the medal when finish checking a doom book
    cp a, DOOM_BOOK_1
    jr z, checkDoomBook1
    cp a, DOOM_BOOK_2
    jr z, checkDoomBook2
exitCheckItem:
    ld b, $08
    jp routineDelay

checkDoomBook1
    ld [hl], EAGLE_MEDAL
    jr exitCheckItem
checkDoomBook2
    ld [hl], WOLF_MEDAL
    jr exitCheckItem


checkItemDescriptionConfirmInput: ;3A3F
    ret
;3A40

checkItemCombineSubmenuConfirmInput: ;00:3A40
    call clearItemDetailWindowBgMap
    call loadMainMenuPalette
    call clearItemDetailWindowTiles
    ld a, CONFIRM_SFX
    call playSFX
    ld a, [wSelectedSlotId]
    add a, COMBINE_ITEM_MODE
    ld [wMainMenuSelectedCursorId], a ; set combine item mode
    ld b, $08
    jp routineDelay
;3A5B

resetSubmenuConfirmInputPress: ;00:3A5B
    xor a
    ld [wPressingAButton], a
    ret
;3A60

checkFilebooksSubmenuConfirmInput: ;00:3A60
    ld a, [wFileBookId]
    ld c, a
    add a
    add a
    ld b, a
    add a
    add a, b
    add a, c
    ld c, a
    ld b, 0
    ld hl, wFilesFlags
    add hl, bc ; get file flag pointer offset by book
    ld a, [wFileBookmarkCursorPos]
    ld c, a
    ld b, 0
    add hl, bc
    ld a, [hl] ; get selected file flag
    or a
    ret z ; return if no file
    call displayFile
    xor a
    call loadMainMenuTileMap ; reload menu tilemap
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    ld a, BANK(mainMenuPalette)
    ld hl, mainMenuPalette
    call loadBgPalette
    jp updateFilebookSubmenuTilemap
;3A92

checkMenuConfirmKeyPress: ;3A92
    ld a, [wButtonPressId]
    and a, A_INPUT
    jp z, resetAInputPress
    ld a, [wPressingAButton]
    or a
    ret nz
    ld a, $FF
    ld [wPressingAButton], a
    ld a, [wPaletteFadeCounter]
    or a
    ret nz
; if A input is pressed
    ld a, [wMainMenuSelectedCursorId]
    cp a, ITEM_SLOT_1
    jr nc, checkItemSlotConfirmInput
    cp a, EXIT_OPTION
    jr nz, checkTopMenuConfirmInput
.exitMainMenu
    ld a, CHANGE_SCREEN_FADE_OUT
    ld [wPaletteFadeCounter], a
    ld a, CONFIRM_SFX
    jp playSFX


checkTopMenuConfirmInput: ;3ABE
    cp a, FILE_OPTION
    jr nz, Label3AD6
; file option
    ld a, [wMenuFileEnable]
    or a
    jp z, returnFromConfirmInput ; file option disabled
; load file submenu
    call updateFilebookSubmenuTilemap
    ld a, FILE_MENU
    ld [wMainMenuSelectedCursorId], a ; set filebook menu mode
    ld a, CONFIRM_SFX
    jp playSFX

Label3AD6:
    cp a, RADIO_OPTION
    jr nz, Label3AEA
; radio option
    ld a, [wMenuRadioEnable]
    or a
    jr z, returnFromConfirmInput ; radio option disabled
    ld a, RADIO_SELECTED
    ld [wMainMenuSelectedCursorId], a ; set radio menu mode
    ld a, CONFIRM_SFX
    jp playSFX

Label3AEA:
    ld a, [wMenuMapEnable]
    or a
    jr z, returnFromConfirmInput ; map option disabled
; map option
    call loadMainMenuPalette
    call updateMapSubmenuTilemap
    ld a, MAP_MENU
    ld [wMainMenuSelectedCursorId], a ; set map menu mode
    ld a, CONFIRM_SFX
    call playSFX
    ld b, $20
    jp routineDelay
;3B05

checkItemSlotConfirmInput: ;3B05
    ld a, [wMainMenuSelectedCursorId]
    sub a, ITEM_SLOT_1
    ld l, a
    ld h, 0
    ld de, wItemIdSlot1
    add hl, de
    ld a, [hl] ; get selected item id
    cp a, EMPTY
    jr z, .emptyItemSlotSelected
    ld [wSelectedItemId], a ; store selected item id
    ld a, [wMainMenuSelectedCursorId]
    ld [wSelectedSlotId], a ; store selected item slot
    ld a, USE_EQUIP_CURSOR
    ld [wMainMenuSelectedCursorId], a ; set item use/equip submenu mode
    ld a, SELECT_MENU_SFX
    call playSFX
    ld c, MENU_TOP_OPTIONS_ENABLED
    call updateMainMenuSlotsCursorsCaller
    call updateItemSubmenuTilemap
    ld b, $20
    jp routineDelay
.emptyItemSlotSelected
    ret
;3B37

returnFromConfirmInput: ;00:3B37
    ld a, CANCEL_SFX
    jp playSFX
;3B3C

resetAInputPress: ;3B3C
    xor a
    ld [wPressingAButton], a
    ret
;3B41

checkMenuLeftKeyPress: ;00:3B41
    ld a, [wButtonPressId]
    and a, LEFT_INPUT
    ret z
    ld a, [wMainMenuSelectedCursorId]
    and a, $01
    ret z ; already in left column
    ld a, [wMainMenuSelectedCursorId]
    and a, $FE ; move cursor to left
    ld [wMainMenuSelectedCursorId], a
    call displaySelectedItemName
    ld a, CURSOR_SFX
    jp playSFX
;3B5D

checkMenuRightKeyPress: ;3B5D
    ld a, [wButtonPressId]
    and a, RIGHT_INPUT
    ret z
    ld a, [wMainMenuSelectedCursorId]
    and a, $01 ; already in right column
    ret nz
    ld a, [wMainMenuSelectedCursorId]
    or a, $01 ; move to right column cursor
    ld [wMainMenuSelectedCursorId], a
    call displaySelectedItemName
    ld a, CURSOR_SFX
    jp playSFX
;3B79

checkMenuUpKeyPress: ;3B79
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jr z, Label3B9D
    ld a, [wPressingUpKey]
    or a
    ret nz
    ld a, $FF
    ld [wPressingUpKey], a
    ld a, [wMainMenuSelectedCursorId]
    cp a, FILE_OPTION
    ret c ; already in top row
    sub a, 2 ; move cursor to above row
    ld [wMainMenuSelectedCursorId], a
    call displaySelectedItemName
    ld a, CURSOR_SFX
    jp playSFX
Label3B9D:
    xor a
    ld [wPressingUpKey], a ; reset A input press
    ret
;3BA2

checkMenuDownKeyPress: ;00:3BA2
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jr z, Label3BCF
    ld a, [wPressingDownKey]
    or a
    ret nz
    ld a, $FF
    ld [wPressingDownKey], a
    ld c, ITEM_SLOT_5 ; chris bottom slot
    ld a, [wSelectedCharacter]
    or a
    jr z, .Label3BBD
    ld c, ITEM_SLOT_7 ; jill bottom slot
.Label3BBD
    ld a, [wMainMenuSelectedCursorId]
    cp a, c
    ret nc ; already in bottom row
    add a, 2 ; move cursor to below row
    ld [wMainMenuSelectedCursorId], a
    call displaySelectedItemName
    ld a, CURSOR_SFX
    jp playSFX
Label3BCF:
    xor a
    ld [wPressingDownKey], a
    ret
;3BD4

checkCombineGridUpInput: ;00:3BD4
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jr z, Label3BF8
    ld a, [wPressingUpKey]
    or a
    ret nz
    ld a, $FF
    ld [wPressingUpKey], a
    ld a, [wMainMenuSelectedCursorId]
    cp a, COMBINE_SLOT_3
    ret c ; already in top row
    sub a, 2 ; move cursor to above row
    ld [wMainMenuSelectedCursorId], a
    call displaySelectedItemName
    ld a, CURSOR_SFX
    jp playSFX
Label3BF8:
    xor a
    ld [wPressingUpKey], a
    ret
;3BFD

checkCombineGridDownInput: ;00:3BFD
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jr z, Label3C2A
    ld a, [wPressingDownKey]
    or a
    ret nz
    ld a, $FF
    ld [wPressingDownKey], a
    ld c, COMBINE_SLOT_5 ; chris botton row
    ld a, [wSelectedCharacter]
    or a
    jr z, .Label3C18
    ld c, COMBINE_SLOT_7 ; jill bottom row
.Label3C18
    ld a, [wMainMenuSelectedCursorId]
    cp a, c
    ret nc ; already in bottom row
    add a, 2 ; move cursor to below row
    ld [wMainMenuSelectedCursorId], a
    call displaySelectedItemName
    ld a, CURSOR_SFX
    jp playSFX
Label3C2A:
    xor a
    ld [wPressingDownKey], a
    ret
;3C2F


updateMainMenuSlotsCursorsCaller: ;00:3C2F
    ld hl, updateMainMenuSlotsCursors
    ld a, BANK(updateMainMenuSlotsCursors)
    jp jumpToHLRoutineA
