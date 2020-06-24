; search an item in inventory, if it's found, then it's removed
;
; c: item id
searchAndRemoveItem:
    push bc
    push hl
    ld hl, wItemIdSlot1
    ld b, CHRIS_MAX_SLOTS
    ld a, [wSelectedCharacter]
    or a
    jr z, .findItemLoop ; if chris
; if jill
    ld b, JILL_MAX_SLOTS
.findItemLoop
    ld a, [hl]
    cp a, c
    jr z, .removeFoundItem
    inc hl
    dec b
    jr nz, .findItemLoop
.itemNotFound
    pop hl
    pop bc
    ret
.removeFoundItem
    ld [hl], EMPTY
    jr .itemNotFound


; search door key in inventory, return true ($FF) if it's found, if not, return false ($00)
;
; c: key id
searchKeyInInventory: ;C5:6A6E
    ld de, wItemIdSlot1
    ld b, INVENTORY_MAX_SLOTS
.searchKeyLoop
    ld a, [de]
    cp a, c
    jr z, doorKeyFound
    inc de
    dec b
    jr nz, .searchKeyLoop
.doorKeyNotFound
    xor a
    ret
doorKeyFound:
    ld a, $FF
    ret
;6A80
