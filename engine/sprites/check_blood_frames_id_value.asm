; de: charData addr
checkBloodFramesIdValue:: ;01:495F
    ld hl, wBloodFramesId - wEntityStructData
    add hl, de
    ld a, [hl]
    or a
    jr z, .Label4973
    and a, $7F
    inc a
    cp a, 12
    jr c, .Label4971
    xor a
    jr .Label4973
.Label4971
    or a, $80
.Label4973
    ld [hl], a
    ret
;01:4975