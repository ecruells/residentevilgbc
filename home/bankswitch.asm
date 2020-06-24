bankSwitch:: ;00:02EE
    push bc
    ld b, a
    ld a, [wCurrentRomBank]
    ld c, a
    ld a, b
    ld [wCurrentRomBank], a
    ld [$2000], a ;bank Switch
    ld a, c
    pop bc
    ret