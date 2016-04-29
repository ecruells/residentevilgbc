
_scalingFuncionTable: ;00:270B
	dw Function2745 ;$45, $27
	dw Function2746 ;$46, $27
	dw Function2746 ;$46, $27
	dw Function2763 ;$63, $27
	dw Function2763 ;$63, $27
	dw Function2782 ;$82, $27
	dw Function2782 ;$82, $27
	dw Function27A3 ;$A3, $27
	dw Function27A3 ;$A3, $27
	dw Function27BA ;$BA, $27
	dw Function27BA ;$BA, $27
	dw Function27CB ;$CB, $27
	dw Function27CB ;$CB, $27
	dw $0000
	dw $0000
	dw $0000
	dw Function27DA ;$DA, $27
	dw Function27DB ;$DB, $27
	dw Function27E0 ;$E0, $27
	dw Function280F ;$0F, $28
	dw Function283C ;$3C, $28
	dw Function286B ;$6B, $28
	dw Function2898 ;$98, $28
	dw Function28C7 ;$C7, $28
	dw Function28F4 ;$F4, $28
	dw Function290F ;$0F, $29
	dw Function292C ;$2C, $29
	dw Function294F ;$4F, $29
	dw Function2974 ;$74, $29

Function2745: ;00:2745
	ret
Function2746: ;00:2746
;de: odd line bytes
;bc: even line bytes
    ld a, e
    and a, $01 ;((e & 1) * 128) | c
    add a
    add a
    add a
    add a
    add a
    add a
    add a
    or a, c
    ld c, a
    srl e
    ld a, d
    and a, $01 ;((d & 1) * 128) | b
    add a
    add a
    add a
    add a
    add a
    add a
    add a
    or a, b
    ld b, a
    srl d
    ret

Function2763: ;00:2763
    ld a, e
    and a, $03
    add a
    add a
    add a
    add a
    add a
    add a
    or a, c
    ld c, a
    srl e
    srl e
    ld a, d
    and a, $03
    add a
    add a
    add a
    add a
    add a
    add a
    or a, b
    ld b, a
    srl d
    srl d
    ret

Function2782: ;00:2782
    ld a, e
    and a, $07
    add a
    add a
    add a
    add a
    add a
    or a, c
    ld c, a
    srl e
    srl e
    srl e
    ld a, d
    and a, $07
    add a
    add a
    add a
    add a
    add a
    or a, b
    ld b, a
    srl d
    srl d
    srl d
    ret

Function27A3: ;00:27A3
    ld a, e
    and a, $0F
    add a
    add a
    add a
    add a
    or a, c
    ld c, a
    ld e, $00
    ld a, d
    and a, $0F
    add a
    add a
    add a
    add a
    or a, b
    ld b, a
    ld d, $00
    ret

Function27BA: ;00:27BA
    ld a, e
    add a
    add a
    add a
    or a, c
    ld c, a
    ld e, $00
    ld a, d
    add a
    add a
    add a
    or a, b
    ld b, a
    ld d, $00
    ret

Function27CB: ;00:27CB
    ld a, e
    add a
    add a
    or a, c
    ld c, a
    ld e, $00
    ld a, d
    add a
    add a
    or a, b
    ld b, a
    ld d, $00
    ret

Function27DA: ;00:27DA
	ret

Function27DB: ;00:27DB
    sla c
    sla b
    ret

Function27E0: ;00:27E0
    sla e
    ld a, c
    srl a
    srl a
    srl a
    srl a
    srl a
    srl a
    or a, e
    ld e, a
    ld a, c
    and a, $3F
    add a
    add a
    ld c, a
    sla d
    ld a, b
    srl a
    srl a
    srl a
    srl a
    srl a
    srl a
    or a, d
    ld d, a
    ld a, b
    and a, $3F
    add a
    add a
    ld b, a
    ret

Function280F: ;00:280F
    sla e
    ld a, c
    srl a
    srl a
    srl a
    srl a
    srl a
    or a, e
    ld e, a
    ld a, c
    and a, $1F
    add a
    add a
    add a
    ld c, a
    sla d
    ld a, b
    srl a
    srl a
    srl a
    srl a
    srl a
    or a, d
    ld d, a
    ld a, b
    and a, $1F
    add a
    add a
    add a
    ld b, a
    ret

Function283C: ;00:283C
    sla e
    sla e
    ld a, c
    srl a
    srl a
    srl a
    srl a
    or a, e
    ld e, a
    ld a, c
    and a, $0F
    add a
    add a
    add a
    add a
    ld c, a
    sla d
    sla d
    ld a, b
    srl a
    srl a
    srl a
    srl a
    or a, d
    ld d, a
    ld a, b
    and a, $0F
    add a
    add a
    add a
    add a
    ld b, a
    ret

Function286B: ;00:286B
    sla e
    sla e
    ld a, c
    srl a
    srl a
    srl a
    or a, e
    ld e, a
    ld a, c
    and a, $07
    add a
    add a
    add a
    add a
    add a
    ld c, a
    sla d
    sla d
    ld a, b
    srl a
    srl a
    srl a
    or a, d
    ld d, a
    ld a, b
    and a, $07
    add a
    add a
    add a
    add a
    add a
    ld b, a
    ret

Function2898: ;00:2898
    sla e
    sla e
    sla e
    ld a, c
    srl a
    srl a
    or a, e
    ld e, a
    ld a, c
    and a, $03
    add a
    add a
    add a
    add a
    add a
    add a
    ld c, a
    sla d
    sla d
    sla d
    ld a, b
    srl a
    srl a
    or a, d
    ld d, a
    ld a, b
    and a, $03
    add a
    add a
    add a
    add a
    add a
    add a
    ld b, a
    ret

Function28C7: ;00:28C7
    sla e
    sla e
    sla e
    ld a, c
    srl a
    or a, e
    ld e, a
    ld a, c
    and a, $01
    add a
    add a
    add a
    add a
    add a
    add a
    add a
    ld c, a
    sla d
    sla d
    sla d
    ld a, b
    srl a
    or a, d
    ld d, a
    ld a, b
    and a, $01
    add a
    add a
    add a
    add a
    add a
    add a
    add a
    ld b, a
    ret

Function28F4: ;00:28F4
    sla e
    sla e
    sla e
    sla e
    ld a, c
    or a, e
    ld e, a
    ld c, $00
    sla d
    sla d
    sla d
    sla d
    ld a, b
    or a, d
    ld d, a
    ld b, $00
    ret

Function290F: ;00:290F
    sla e
    sla e
    sla e
    sla e
    ld a, c
    add a
    or a, e
    ld e, a
    ld c, $00
    sla d
    sla d
    sla d
    sla d
    ld a, b
    add a
    or a, d
    ld d, a
    ld b, $00
    ret

Function292C: ;00:292C
    sla e
    sla e
    sla e
    sla e
    sla e
    ld a, c
    add a
    add a
    or a, e
    ld e, a
    ld c, $00
    sla d
    sla d
    sla d
    sla d
    sla d
    ld a, b
    add a
    add a
    or a, d
    ld d, a
    ld b, $00
    ret

Function294F: ;00:294F
    sla e
    sla e
    sla e
    sla e
    sla e
    ld a, c
    add a
    add a
    add a
    or a, e
    ld e, a
    ld c, $00
    sla d
    sla d
    sla d
    sla d
    sla d
    ld a, b
    add a
    add a
    add a
    or a, d
    ld d, a
    ld b, $00
    ret

Function2974: ;00:2974
    sla e
    sla e
    sla e
    sla e
    sla e
    sla e
    ld a, c
    add a
    add a
    add a
    add a
    or a, e
    ld e, a
    ld c, $00
    sla d
    sla d
    sla d
    sla d
    sla d
    sla d
    ld a, b
    add a
    add a
    add a
    add a
    or a, d
    ld d, a
    ld b, $00
    ret

;299F

