div8WordC6: ;C6:64E1
    ld a, d
    cp a, $80
    jr c, Label31A4F9
    call reverseWordSignC6
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    call reverseWordSignC6
    ret
Label31A4F9: ;C6:64F9
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ret
;6506

multiply8SignedWordC6: ;C6:6506
    ld a, d
    cp a, $80
    jr c, Label31A51B
    call reverseWordSignC6
    push hl
    push de
    pop hl
    add hl, hl
    add hl, hl
    add hl, hl
    push hl
    pop de
    pop hl
    call reverseWordSignC6
    ret
Label31A51B: ;C6:651B
    push hl
    push de
    pop hl
    add hl, hl
    add hl, hl
    add hl, hl
    push hl
    pop de
    pop hl
    ret
;6525

reverseWordSignC6: ;C6:6525
    ld a, $00
    sub a, e
    ld e, a
    ld a, $00
    sbc a, d
    ld d, a
    ret
