displayItemboxItemsList: ;00:3F43
    ld b, 3 ; items names to be print from list
displayItemboxItemLoop:
    push bc
    ld a, [wSelectedItemBoxSlotId]
    add a, b
    sub a, 2
    and a, MAX_ITEMBOX_ITEMS-1
    ld e, a ; (slotId + loopId - 2) & 31
    ld d, 0
    ld hl, wItemBoxSlot01
    add hl, de
    ld a, [hl] ; get slot item id
    ld l, a
    ld h, 0
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, itemsNamesPointer
    add hl, de
    ld a, BANK(itemsNamesPointer)
    call bankSwitch
    ld e, [hl]
    inc hl
    ld d, [hl] ; get item name pointer
    ld a, $01
    call bankSwitch
;calc item name display position
    ld h, b
    dec h ; y-pos
    ld l, 0 ; x-pos
    ld a, b
    cp a, 2
    jr nz, printItemBoxItemName ; print prev or next item name
    ld a, [wMainMenuSelectedCursorId]
    cp a, ITEM_SLOT_8+1
    jr c, printItemBoxItemName ; print item name without highlight
; print selected slot item name
    ld c, e
    ld b, d
    ld a, BANK(itemsNamesPointer)
    call printItemBoxSelectedSlot ; highlighted item name
    jr Label3F8D
printItemBoxItemName
    ld c, e
    ld b, d
    ld a, BANK(itemsNamesPointer)
    call printTextString ; print item name
Label3F8D
    pop bc
    dec b
    jr nz, displayItemboxItemLoop
    ret
;3F92
