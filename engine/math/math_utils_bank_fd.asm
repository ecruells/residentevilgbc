; divide signed DE value by 8
div8WordFD: ;FD:524A
    ld a, d
    cp a, $80
    jr c, Label3F5262
    call reverseWordSignFD
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    call reverseWordSignFD
    ret
Label3F5262: ;FD:5262
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ret
;526F

; mutiply signed DE value by 8
multiply8SignedWordFD: ;FD:526F
    ld a, d
    cp a, $80
    jr c, Label3F5284
    call reverseWordSignFD
    push hl
    push de
    pop hl
    add hl, hl
    add hl, hl
    add hl, hl
    push hl
    pop de
    pop hl
    call reverseWordSignFD
    ret
Label3F5284: ;FD:5284
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
;528E

; reverse DE value sign
reverseWordSignFD: ;FD:528E
    ld a, $00
    sub a, e
    ld e, a
    ld a, $00
    sbc a, d
    ld d, a
    ret
;5297
