displaySelectedItemName: ;00:36D2
    ld bc, ClearTextboxText
    ldhl 15, 0 ; text position
    ld a, BANK(ClearTextboxText)
    call printTextString
    ld de, itemsNamesPointer
    ld a, [wMainMenuSelectedCursorId]
    cp a, ITEM_SLOT_1
    jr c, noItemNameToPrint ; return if selected cursor is not item slot
    cp a, SUBMENUS_CURSOR
    jr c, getItemNameIndex ; cursor id is an item slot
    cp a, COMBINE_ITEM_MODE
    jr c, Label36F3 ; cursor id is a submenu option
; if in combine item grid
    sub a, COMBINE_ITEM_MODE ; get item slot id from combine slot id
    jr getItemNameIndex
Label36F3
    cp a, CHECK_ITEM_CURSOR
    jr nz, noItemNameToPrint ; is other submenu option
; cursor is in check item mode
    ld de, itemsNamesPointer+2
    ld a, [wSelectedSlotId]
getItemNameIndex
    sub a, ITEM_SLOT_1
    ld l, a
    ld h, 0
    ld bc, wItemIdSlot1
    add hl, bc 
    ld a, [hl] ; get item id
    cp a, EMPTY
    jr z, noItemNameToPrint
    ld a, BANK(itemsNamesPointer)
    call bankSwitch
    ld l, [hl]
    ld h, 0
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, de ; get item name pointer
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, $01
    call bankSwitch
    ldhl 15, 0
    ld a, BANK(itemsNamesPointer)
    jp printTextString ; print item name
noItemNameToPrint
    ret
;3728
