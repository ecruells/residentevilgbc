
; multiply e by l (unused)
;
; e: multiplicand
; l: multiplier
;
; result: e
byteMultiply: ;01:6ED0
    ld a, e
    cp a, %10000000
    jr c, Label6EF9
    ld a, l
    cp a, %10000000
    jr c, Label6EE8
    ld a, l
    xor a, $FF
    inc a
    ld l, a
    ld a, e
    xor a, $FF
    inc a
    ld e, a
    call unrolledMultiply
    ret
Label6EE8: ;01:6EE8
    ld a, e
    xor a, $FF
    inc a
    ld e, a
    call unrolledMultiply
    ld a, 0
    sub a, e
    ld e, a
    ld a, 0
    sbc a, d
    ld d, a
    ret
Label6EF9: ;01:6EF9
    ld a, l
    cp a, %10000000
    jr c, Label6F0E
    xor a, $FF
    inc a
    ld l, a
    call unrolledMultiply
    ld a, 0
    sub a, e
    ld e, a
    ld a, 0
    sbc a, d
    ld d, a
    ret
Label6F0E: ;01:6F0E
    jp unrolledMultiply



; multiply de by l
;
; de: multiplicand
; l: multiplier
;
; result: de
wordAndByteMultiply: ;01:6F11
    ld a, d
    cp a, %10000000
    jr c, .positiveMultiplicant
    ld a, l
    cp a, %10000000
    jr c, .negAndPositiveMult
; negative and negative mult
    ld a, l
    xor a, $FF
    inc a
    ld l, a
    call reverseDESign
    jp unrolledMultiply
.negAndPositiveMult
    call reverseDESign
    call unrolledMultiply
    jp reverseDESign
.positiveMultiplicant
    ld a, l
    cp a, %10000000
    jr c, .positiveMult
; positive and negative mult
    ld a, l
    xor a, $FF
    inc a
    ld l, a
    call unrolledMultiply
    jp reverseDESign
.positiveMult
    jp unrolledMultiply


; unrolled 16bit by 8bit multiplication.
;
; de: multiplicand
; l: multiplier
;
; result: de
unrolledMultiply: ;6F42
    push hl
    ld c, h
    ld a, l
; clear hl
    ld b, 0 ; acc
    ld h, b
    ld l, b
    add a
    jr nc, .label6F4E
    add hl, de
    adc a, b
.label6F4E
    add hl, hl
    adc a
    jr nc, .label6F54
    add hl, de
    adc a, b
.label6F54
    add hl, hl
    adc a
    jr nc, .label6F5A
    add hl, de
    adc a, b
.label6F5A
    add hl, hl
    adc a
    jr nc, .label6F60
    add hl, de
    adc a, b
.label6F60
    add hl, hl
    adc a
    jr nc, .label6F66
    add hl, de
    adc a, b
.label6F66
    add hl, hl
    adc a
    jr nc, .label6F6C
    add hl, de
    adc a, b
.label6F6C
    add hl, hl
    adc a
    jr nc, .label6F72
    add hl, de
    adc a, b
.label6F72
    add hl, hl
    adc a
    jr nc, .label6F78
    add hl, de
    adc a, b
.label6F78
    push hl
    ld h, b ; reset hl
    ld l, b
    ld b, a
    ld a, c
    ld c, h
    add a
    jr nc, .label6F83
    add hl, de
    adc a, c
.label6F83
    add hl, hl
    adc a
    jr nc, .label6F89
    add hl, de
    adc a, c
.label6F89
    add hl, hl
    adc a
    jr nc, .label6F8F
    add hl, de
    adc a, c
.label6F8F
    add hl, hl
    adc a
    jr nc, .label6F95
    add hl, de
    adc a, c
.label6F95
    add hl, hl
    adc a
    jr nc, .label6F9B
    add hl, de
    adc a, c
.label6F9B
    add hl, hl
    adc a
    jr nc, .label6FA1
    add hl, de
    adc a, c
.label6FA1
    add hl, hl
    adc a
    jr nc, .label6FA7
    add hl, de
    adc a, c
.label6FA7
    add hl, hl
    adc a
    jr nc, .label6FAD
    add hl, de
    adc a, c
.label6FAD
    pop de
    ld c, a
    ld a, d
    add a, l
    ld d, a
    ld a, b
    adc a, h
    ld h, a
    ld a, c
    adc a, 0
    ld b, a
    ld c, h
    pop hl
    ret

; divide de by bc
wordDivision: ;01:6FBC
    ld a, d
    cp a, %10000000
    jr c, .positiveDiv
; negative div
    ld a, 0
    sub a, e
    ld e, a
    ld a, 0
    sbc a, d
    ld d, a
    call divide
    ld a, 0
    sub a, e
    ld e, a
    ld a, 0
    sbc a, d
    ld d, a
    ret
.positiveDiv
	jp divide


; divide DE by BC
;
; de: dividend
; bc: divisor
;
; result:
;   quotient: de
;   reminder: bc
divide: ;01:6FD8
    ld hl, wDivisor
    ld [hl], c
    inc hl
    ld [hl], b
    inc hl
    ld [hl], 17 ; loop counter
    ld bc, 0 ; acc
divLoop:
    ld hl, wDivLoopCounter
    ld a, e
    rla
    ld e, a
    ld a, d
    rla
    ld d, a
    dec [hl]
    ret z
    ld a, c
    rla
    ld c, a
    ld a, b
    rla
    ld b, a
    dec l
    dec l
    ld a, c
    sub a, [hl]
    ld c, a
    inc hl
    ld a, b
    sbc a, [hl]
    ld b, a
    jp nc, .label7009
    dec l
    ld a, c
    add a, [hl]
    ld c, a
    inc l
    ld a, b
    adc a, [hl]
    ld b, a
.label7009
    ccf ; clear carry flag
    jp divLoop
    ld a, d
    cp a, %10000000
    jr nc, .label7016
    ld e, d
    ld d, 0
    ret
.label7016
    ld a, 0
    sub a, e
    ld e, a
    ld a, 0
    sbc a, d
    ld d, a
    ld e, d
    ld d, 0
    ld a, 0
    sub a, e
    ld e, a
    ld a, 0
    sbc a, d
    ld d, a
    ret


; divide a 16bit variable value by 2 (unused).
;
; hl: variable low byte pointer
; result is stored in the same var pointer
div2WordVar: ;01:702A
    push de
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, d
    cp a, %10000000
    jr c, .positiveDiv
    call reverseDESign
    srl d
    rr e
    call reverseDESign
    ld [hl], d
    dec hl
    ld [hl], e
    pop de
    ret
.positiveDiv
    srl d
    rr e
    ld [hl], d
    dec hl
    ld [hl], e
    pop de
    ret


; divide a 16bit variable value by 4.
;
; hl: variable low byte pointer
; result is stored in the same var pointer
div4WordVar: ;01:704B
    push de
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, d
    cp a, %10000000
    jr c, .positiveDiv
    call reverseDESign
    srl d
    rr e
    srl d
    rr e
    call reverseDESign
    ld [hl], d
    dec hl
    ld [hl], e
    pop de
    ret
.positiveDiv
    srl d
    rr e
    srl d
    rr e
    ld [hl], d
    dec hl
    ld [hl], e
    pop de
    ret

; reverse DE value sign
reverseDESign:: ;01:7074
    ld a, $00
    sub a, e
    ld e, a
    ld a, $00
    sbc a, d
    ld d, a
    ret

; reverse HL value sign
reverseHLSign:: ;01:707D
    ld a, $00
    sub a, l
    ld l, a
    ld a, $00
    sbc a, h
    ld h, a
    ret


; divide a 16bit value by 128.
;
; de: value
; result: de
div128Word:: ;01:7086
    ld a, d
    cp a, %10000000
    jr c, .positiveDiv
    call reverseDESign
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    call reverseDESign
    ret
.positiveDiv
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ret


; divide a 16bit value by 64.
;
; de: value
; result: de
div64Word: ;01:70CB
    ld a, d
    cp a, %10000000
    jr c, .positiveDiv
    call reverseDESign
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    call reverseDESign
    ret
.positiveDiv
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ret

; divide a 16bit value by 16.
;
; de: value
; result: de
div16Word:: ;01:7108
    ld a, d
    cp a, %10000000
    jr c, .positiveDiv
    call reverseDESign
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    call reverseDESign
    ret
.positiveDiv
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ret

; divide a 16bit value by 8.
;
; de: value
; result: de
div8Word:: ;01:7135
    ld a, d
    cp a, %10000000
    jr c, .positiveDiv
    call reverseDESign
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    call reverseDESign
    ret
.positiveDiv
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ret

; divide a 16bit value by 2.
;
; de: value
; result: de
div2Word:: ;01:715A
    ld a, d
    cp a, %10000000
    jr c, .positiveDiv
    call reverseDESign
    srl d
    rr e
    call reverseDESign
    ret
.positiveDiv
    srl d
    rr e
    ret


; divide a 16bit value in BC by 2 (unused).
;
; bc: value
; result: bc
div2BcWord: ;01:716F
    push de
    ld e, c
    ld d, b
    call div2Word
    ld c, e
    ld b, d
    pop de
    ret


; multiply a 16bit value by 4 (unused).
;
; de: value
; result: de
mult4Word: ;01:7179
    ld a, d
    cp a, %10000000
    jr c, .positiveMult
    call reverseDESign
    push hl
    push de
    pop hl
    add hl, hl
    add hl, hl
    push hl
    pop de
    pop hl
    call reverseDESign
    ret
.positiveMult
    push hl
    push de
    pop hl
    add hl, hl
    add hl, hl
    push hl
    pop de
    pop hl
    ret


; multiply a 16bit value by 8 (unused).
;
; de: value
; result: de
mult8Word: ;01:7196
    ld a, d
    cp a, %10000000
    jr c, .positiveMult
    call reverseDESign
    push hl
    push de
    pop hl
    add hl, hl
    add hl, hl
    add hl, hl
    push hl
    pop de
    pop hl
    call reverseDESign
    ret
.positiveMult
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
;71B5
