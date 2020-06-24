div8WordFC: ;FC:4982
    ld a, d
    cp a, $80
    jr c, Label3F099A
    call reverseWordSignFC
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    call reverseWordSignFC
    ret
Label3F099A: ;FC:499A
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ret

reverseWordSignFC: ;FC:49A7
    ld a, $00
    sub a, e
    ld e, a
    ld a, $00
    sbc a, d
    ld d, a
    ret
;49B0
