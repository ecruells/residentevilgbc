
byteMultiply: ;01:6ED0
;multiply e by l
;e: multiplicand
;l: multiplier
    ld a, e
    cp a, $80
    jr c, Label6EF9
    ld a, l
    cp a, $80
    jr c, Label6EE8
    ld a, l
    xor a, $FF
    inc a
    ld l, a
    ld a, e
    xor a, $FF
    inc a
    ld e, a
    call multiply
    ret
Label6EE8: ;01:6EE8
    ld a, e
    xor a, $FF
    inc a
    ld e, a
    call multiply
    ld a, $00
    sub a, e
    ld e, a
    ld a, $00
    sbc a, d
    ld d, a
    ret
Label6EF9: ;01:6EF9
    ld a, l
    cp a, $80
    jr c, Label6F0E
    xor a, $FF
    inc a
    ld l, a
    call multiply
    ld a, $00
    sub a, e
    ld e, a
    ld a, $00
    sbc a, d
    ld d, a
    ret
Label6F0E: ;01:6F0E
    jp multiply
;6F11

wordMultiply: ;01:6F11
;multiply de by l
;de: multiplicand
;l: multiplier
    ld a, d
    cp a, $80
    jr c, .Label6F2F ; jump if de is positive
    ld a, l
    cp a, $80
    jr c, .turnDEPositive ; jump if l is positive
;if both de & l are negative, turn them positive
    ld a, l
	;reverse l sign
    xor a, $FF
    inc a
    ld l, a
    call reverseDESign
    jp multiply
.turnDEPositive
    call reverseDESign
    call multiply
    jp reverseDESign ;return de to its original sign
.Label6F2F
    ld a, l
    cp a, $80
    jr c, .Label6F3F ; jump if l is positive
    ld a, l
	;reverse l sign
    xor a, $FF
    inc a
    ld l, a
    call multiply
    jp reverseDESign
.Label6F3F
    jp multiply

multiply: ;6F42
;de: multiplicand
;l: multiplier
    push hl ;store cam pos x
    ld c, h ;cam pos high
    ld a, l
;clear hl
    ld b, $00
    ld h, b
    ld l, b
    add a
    jr nc, Label6F4E
    add hl, de
    adc a, b
Label6F4E
    add hl, hl
    adc a
    jr nc, Label6F54
    add hl, de
    adc a, b
Label6F54
    add hl, hl
    adc a
    jr nc, Label6F5A
    add hl, de
    adc a, b
Label6F5A
    add hl, hl
    adc a
    jr nc, Label6F60
    add hl, de
    adc a, b
Label6F60
    add hl, hl
    adc a
    jr nc, Label6F66
    add hl, de
    adc a, b
Label6F66
    add hl, hl
    adc a
    jr nc, Label6F6C
    add hl, de
    adc a, b
Label6F6C
    add hl, hl
    adc a
    jr nc, Label6F72
    add hl, de
    adc a, b
Label6F72
    add hl, hl
    adc a
    jr nc, Label6F78
    add hl, de
    adc a, b
Label6F78
    push hl
    ld h, b ;reset hl
    ld l, b
    ld b, a
    ld a, c
    ld c, h
    add a
    jr nc, Label6F83
    add hl, de
    adc a, c
Label6F83
    add hl, hl
    adc a
    jr nc, Label6F89
    add hl, de
    adc a, c
Label6F89
    add hl, hl
    adc a
    jr nc, Label6F8F
    add hl, de
    adc a, c
Label6F8F
    add hl, hl
    adc a
    jr nc, Label6F95
    add hl, de
    adc a, c
Label6F95
    add hl, hl
    adc a
    jr nc, Label6F9B
    add hl, de
    adc a, c
Label6F9B
    add hl, hl
    adc a
    jr nc, Label6FA1
    add hl, de
    adc a, c
Label6FA1
    add hl, hl
    adc a
    jr nc, Label6FA7
    add hl, de
    adc a, c
Label6FA7
    add hl, hl
    adc a
    jr nc, Label6FAD
    add hl, de
    adc a, c
Label6FAD
    pop de
    ld c, a
    ld a, d
    add a, l
    ld d, a
    ld a, b
    adc a, h
    ld h, a
    ld a, c
    adc a, $00
    ld b, a
    ld c, h
    pop hl
    ret

wordDivision: ;01:6FBC
;divide de by bc
    ld a, d
    cp a, $80
    jr c, .Label6FD5 ;jump if positive
	;else reverse sign
    ld a, $00
    sub a, e
    ld e, a
    ld a, $00
    sbc a, d
    ld d, a
    call divide
	;reverse sign
    ld a, $00
    sub a, e
    ld e, a
    ld a, $00
    sbc a, d
    ld d, a
    ret
.Label6FD5
	jp divide


divide: ;01:6FD8
;divide de by bc, leaving reminder into bc
;de: dividend
;bc: divisor-reminder
    ld hl, wc150
    ld [hl], c
    inc hl
    ld [hl], b
    inc hl
    ld [hl], $11
    ld bc, $0000
Label6FE4:
    ld hl, wc152
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
    jp nc, Label7009
    dec l
    ld a, c
    add a, [hl]
    ld c, a
    inc l
    ld a, b
    adc a, [hl]
    ld b, a
Label7009:
    ccf ;clear carry flag
    jp Label6FE4
    ld a, d
    cp a, $80
    jr nc, Label7016
    ld e, d
    ld d, $00
    ret
Label7016: ;01:7016
    ld a, $00
    sub a, e
    ld e, a
    ld a, $00
    sbc a, d
    ld d, a
    ld e, d
    ld d, $00
    ld a, $00
    sub a, e
    ld e, a
    ld a, $00
    sbc a, d
    ld d, a
    ret

Function702A: ;01:702A
    push de
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, d
    cp a, $80
    jr c, Label7042
    call reverseDESign
    srl d
    rr e
    call reverseDESign
    ld [hl], d
    dec hl
    ld [hl], e
    pop de
    ret
Label7042: ;01:7042
    srl d
    rr e
    ld [hl], d
    dec hl
    ld [hl], e
    pop de
    ret

;signWordsFunctions

div4WordVariable: ;01:704B
;divide by 4 a 16bit variable in HL pointer
    push de
    ld e, [hl] ;get var low
    inc hl
    ld d, [hl] ;get var high
    ld a, d
    cp a, $80
    jr c, .Label7067 ; jump if positive
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
.Label7067
    srl d
    rr e
    srl d
    rr e
    ld [hl], d
    dec hl
    ld [hl], e
    pop de
    ret

reverseDESign:: ;01:7074
    ld a, $00
    sub a, e
    ld e, a
    ld a, $00
    sbc a, d
    ld d, a
    ret
reverseHLSign:: ;01:707D
    ld a, $00
    sub a, l
    ld l, a
    ld a, $00
    sbc a, h
    ld h, a
    ret
;7086

div128signedWord:: ;01:7086
;divide a signed word by 128
    ld a, d
    cp a, $80
    jr c, .Label70AE ;if positive
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
.Label70AE
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


div64signedWord: ;01:70CB
;divide a signed word by 64
    ld a, d
    cp a, $80
    jr c, .Label70EF ;if positive
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
.Label70EF
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

div16SignedWord:: ;01:7108
;divide a signed word by 16
    ld a, d
    cp a, $80
    jr c, .Label7124 ;if positive
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
.Label7124
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ret

div8SignedWord:: ;01:7135
;divide a signed word by 8
    ld a, d
    cp a, $80
    jr c, .Label714D
    call reverseDESign
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    call reverseDESign
    ret
.Label714D
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ret

div2SignedWord:: ;01:715A
;divide a signed word by 2
    ld a, d
    cp a, $80
    jr c, .Label716A ;if positive
    call reverseDESign
    srl d
    rr e
    call reverseDESign
    ret
.Label716A
    srl d
    rr e
    ret
;716F

div2SignedBCWord: ;01:716F
    push de
    ld e, c
    ld d, b
    call div2SignedWord
    ld c, e
    ld b, d
    pop de
    ret
;7179

multiply4SignedWord01: ;01:7179
    ld a, d
    cp a, $80
    jr c, Label718D
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
Label718D: ;01:718D
    push hl
    push de
    pop hl
    add hl, hl
    add hl, hl
    push hl
    pop de
    pop hl
    ret
;7196

multiply8SignedWord01: ;01:7196
    ld a, d
    cp a, $80
    jr c, Label71AB
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
Label71AB: ;01:71AB
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
