; divide signed DE value by 8
div8WordFB: ;FB:5481
    ld a, d
    cp a, $80
    jr c, Label3ED499
    call reverseWordSignFB
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    call reverseWordSignFB
    ret
Label3ED499: ;FB:5499
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ret
;54A6

; mutiply signed DE value by 8
multiply8SignedWordFB: ;FB:54A6
    ld a, d
    cp a, $80
    jr c, Label3ED4BB
    call reverseWordSignFB
    push hl
    push de
    pop hl
    add hl, hl
    add hl, hl
    add hl, hl
    push hl
    pop de
    pop hl
    call reverseWordSignFB
    ret
Label3ED4BB ;FB:54BB
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
;54C5

; reverse DE value sign
reverseWordSignFB: ;FB:54C5
    ld a, $00
    sub a, e
    ld e, a
    ld a, $00
    sbc a, d
    ld d, a
    ret