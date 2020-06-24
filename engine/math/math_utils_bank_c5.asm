DivideBy8BankC5:: ;C5;6C57
    ld a, d
    cp a, $80
    jr c, .Label316C6F
    call ReverseWordSignC5
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    call ReverseWordSignC5
    ret
.Label316C6F
	srl d
    rr e
    srl d
    rr e
    srl d
    rr e
	ret

ReverseWordSignC5:: ;C5:6C7C
	ld a, $00
	sub e
	ld e, a
	ld a, $00
	sbc d
	ld d, a
	ret
