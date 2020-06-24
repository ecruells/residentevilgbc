; search an NPC exists in the sprites data list. Return true ($FF) 
; if find it or false ($00) if not.
;
; c: sprite id
searchNPC:
    ld de, wNPCEntitiesDataStructs
    ld b, 7
.searchNpcLoop
    ld hl, wEntityId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, c
    jr z, .npcFound
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, .searchNpcLoop
.npcNotFound
    xor a
    ret
.npcFound
    ld a, $FF
    ret
