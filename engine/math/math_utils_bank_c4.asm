div8WordC4: ;C4:66E7
    ld a, d
    cp a, $80
    jr c, Label3126FF
    call reverseWordSignC4
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    call reverseWordSignC4
    ret
Label3126FF: ;C4:66FF
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ret
;670C

multiply8SignedWordC4: ;C4:670C
    ld a, d
    cp a, $80
    jr c, Label312721
    call reverseWordSignC4
    push hl
    push de
    pop hl
    add hl, hl
    add hl, hl
    add hl, hl
    push hl
    pop de
    pop hl
    call reverseWordSignC4
    ret
Label312721: ;C4:6721
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
;672B

reverseWordSignC4: ;C4:672B
    ld a, $00
    sub a, e
    ld e, a
    ld a, $00
    sbc a, d
    ld d, a
    ret