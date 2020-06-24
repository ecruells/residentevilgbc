searchSmallKeyInInventory:
    ld hl, wItemIdSlot1
    ld b, CHRIS_MAX_SLOTS
    ld a, [wSelectedCharacter]
    or a
    jr z, .searchSmallKeyLoop
; jill item slots
    ld b, JILL_MAX_SLOTS
.searchSmallKeyLoop
    ld a, [hl]
    cp a, SMALL_KEY_1
    jr z, .smallKeyFound
    cp a, SMALL_KEY_2
    jr z, .smallKeyFound
    cp a, SMALL_KEY_3
    jr z, .smallKeyFound
    cp a, SMALL_KEY_4
    jr z, .smallKeyFound
    cp a, SMALL_KEY_5
    jr z, .smallKeyFound
    cp a, SMALL_KEY_6
    jr z, .smallKeyFound
    inc hl
    dec b
    jr nz, .searchSmallKeyLoop
; small key not found
    xor a
    ret
.smallKeyFound
    ld a, $FF
    ret
;685A