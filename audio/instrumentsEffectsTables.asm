;amplitude envelopes tables
;arg0: envelope value
;arg1: ticks

Label18C4F: ;4C4F
	db $A0, $01
	db $00, $01
	db $30, $01
	db $00, $01
	envelopeTableEnd

Label18C58: ;4C58
	db $50, $01
	db $40, $02
	db $20, $02
	db $10, $02
	db $00, $01
	envelopeTableEnd

Label18C63: ;4C63
	db $50, $03
	db $20, $02
	db $10, $02
	db $00, $01
	envelopeTableEnd

Label18C6C: ;4C6C
	db $60, $01
	db $50, $01
	db $30, $03
	db $20, $04
	db $10, $04
	db $00, $01
	envelopeTableEnd

Label18C79: ;4C79
	db $A0, $01
	db $50, $01
	db $A0, $01
	db $50, $01
	db $A0, $01
	db $50, $01
	db $A0, $01
	db $50, $01
	db $00, $01
	envelopeTableEnd

Label18C8C: ;4C8C
	db $70, $02
	db $60, $02
	db $50, $02
	db $40, $06
	db $30, $14
	db $20, $28
	db $10, $32
	db $00, $00
	envelopeTableEnd

Label18C9D: ;4C9D
	db $10, $03
	db $20, $02
	db $20, $05
	db $10, $05
	db $00, $01
	envelopeTableEnd

Label18CA8: ;4CA8
	db $A0, $01
	db $50, $01
	db $40, $01
	db $30, $01
	db $20, $01
	db $00, $01
	envelopeTableEnd

Label18CB5: ;4CB5
	db $50, $01
	db $40, $01
	db $30, $05
	db $20, $1E
	db $10, $32
	db $10, $28
	db $00, $01
	envelopeTableEnd

Label18CC4: ;4CC4
	db $20, $04
	db $30, $04
	db $30, $21
	db $20, $0F
	db $10, $80
	db $00, $01
	envelopeTableEnd

Label18CD1: ;4CD1
	db $20, $04
	db $30, $04
	db $40, $04
	db $50, $08
	db $40, $0C
	db $30, $3C
	db $20, $78
	db $10, $96
	db $00, $01
	envelopeTableEnd

Label18CE4: ;4CE4
	db $10, $14
	db $20, $28
	db $30, $50
	db $20, $28
	db $10, $28
	envelopeTableEnd

Label18CEF: ;4CEF
	db $50, $02
	db $40, $04
	db $30, $08
	db $20, $10
	db $20, $20
	db $10, $40
	envelopeTableEnd

Label18CFC: ;4CFC
	db $30, $01
	db $20, $02
	db $10, $32
	db $00, $01
	envelopeTableEnd

Label18D05: ;4D05
	db $20, $01
	db $40, $0A
	db $40, $0C
	db $60, $1E
	db $00, $01
	envelopeTableEnd

Label18D10: ;4D10
	db $20, $01
	db $40, $06
	db $60, $14
	db $00, $01
	envelopeTableEnd

Label18D19: ;4D19
	db $60, $02
	db $40, $04
	db $40, $01
	db $40, $78
	db $60, $A0
	db $00, $01
	envelopeTableEnd

Label18D26: ;4D26
	db $20, $01
	db $40, $0A
	db $60, $BE
	db $00, $01
	envelopeTableEnd

Label18D2F: ;4D2F
	envelopeTableEnd

Label18D30: ;4D30
	db $40, $01
	db $30, $02
	db $20, $02
	db $10, $02
	db $00, $01
	envelopeTableEnd

Label18D3B: ;4D3B
	db $70, $C8
	db $60, $C8
	db $50, $C8
	db $00, $01
	envelopeTableEnd

Label18D44: ;4D44
	db $90, $01
	db $40, $02
	db $20, $02
	db $00, $01
	envelopeTableEnd

Label18D4D: ;4D4D
	db $50, $01
	db $20, $01
	db $10, $01
	db $00, $01
	envelopeTableEnd



;pitch bend tables & noise poly counter tables

Label18D56: ;4D56 noise poly counter
	db $60, $C8
	pitchBendTableEnd

Label18D59: ;4D59
	db $22, $01
	db $64, $02
	db $22, $02
	db $37, $01
	db $22, $01
	db $37, $01
	db $22, $01
	db $22, $01
	db $37, $01
	db $22, $01
	db $37, $01
	db $22, $01
	db $37, $01
	db $22, $01
	db $37, $01
	db $22, $10
	pitchBendTableEnd

Label18D7A: ;4D7A
	db $12, $C8
	pitchBendTableEnd

Label18D7D: ;4D7D
	db $22, $01
	db $10, $C8
	pitchBendTableEnd

Label18D82: ;4D82
	db $02, $01
	db $FE, $01
	db $02, $01
	db $FE, $01
	db $02, $01
	db $FE, $01
	db $02, $01
	db $FE, $01
	pitchBendTableLoop Label18D82

Label18D95: ;4D95
	db $00, $02
	db $FF, $01
	db $FE, $01
	db $FD, $01
	db $FC, $01
	db $FB, $01
	db $FA, $01
	db $F9, $01
	db $F8, $01
	db $F7, $01
	db $F6, $01
	db $F5, $01
	db $F4, $01
	db $F3, $01
	db $F2, $01
	db $F1, $01
	db $F0, $01
	db $EF, $01
	db $EC, $01
	db $E7, $01
	pitchBendTableEnd

Label18DBE: ;4DBE pitches per note
	db $02, $03 ;02: pitch, 03: ticks
	db $FE, $03
	db $FE, $03
	db $02, $03
	db $02, $03
	db $FE, $03
	db $FE, $03
	db $02, $03
	pitchBendTableLoop Label18DBE

Label18DD1: ;4DD1
	db $04, $03
	db $FC, $03
	db $FC, $03
	db $04, $03
	db $04, $03
	db $FC, $03
	db $FC, $03
	db $04, $03
	pitchBendTableLoop Label18DD1

Label18DE4: ;4DE4
	db $FC, $03
	db $04, $03
	db $04, $03
	db $FC, $03
	db $FC, $03
	db $04, $03
	db $04, $03
	db $FC, $03
	pitchBendTableLoop Label18DE4

Label18DF7: ;4DF7
	db $FB, $02
	db $05, $02
	db $05, $02
	db $FB, $02
	db $FB, $02
	db $05, $02
	db $05, $02
	db $FB, $02
	pitchBendTableLoop Label18DF7

Label18E0A: ;4E0A
	db $08, $03
	db $F8, $03
	db $F8, $03
	db $08, $03
	db $08, $03
	db $F8, $03
	db $F8, $03
	db $08, $03
	pitchBendTableLoop Label18E0A

Label18E1D: ;4E1D
	db $FD, $FD
	pitchBendTableEnd

Label18E20: ;4E20
	db $22, $01
	db $22, $02
	db $37, $64
	pitchBendTableEnd



;vibrato tables

Label18E27: ;4E27
	db $08, $00
	db $08, $0C
	db $08, $00
	db $08, $0C
	db $08, $00
	db $08, $0C
	vibratoTableLoop Label18E27

Label18E36: ;4E36
	db $01, $FF
	db $01, $FE
	db $01, $FD
	db $01, $FC
	db $01, $FB
	db $01, $FA
	db $01, $F9
	db $01, $F8
	db $01, $F7
	db $01, $F6
	db $01, $F5
	db $01, $F4
	db $01, $F3
	db $C8, $F3
	vibratoTableLoop Label18E36

Label18E55: ;4E55
	db $03, $00 ;03: ticks, 00: note tsp
	db $03, $01
	db $03, $00
	db $03, $01
	vibratoTableLoop Label18E55

Label18E60: ;4E60
	db $02, $00
	db $01, $01
	db $01, $02
	db $01, $03
	db $C8, $03
	vibratoTableLoop Label18E60

Label18E6D: ;4E6D
	db $03, $00
	db $03, $0C
	db $03, $00
	db $03, $0C
	db $04, $00
	db $04, $0C
	db $04, $00
	db $04, $0C
	db $05, $00
	db $05, $0C
	db $05, $00
	db $05, $0C
	db $06, $00
	db $06, $0C
	db $06, $00
	db $06, $0C
	vibratoTableLoop Label18E6D

Label18E90: ;4E90
	db $01, $00
	db $01, $04
	db $01, $07
	db $01, $00
	db $01, $04
	db $01, $07
	vibratoTableLoop Label18E90

Label18E9F: ;4E9F
	db $01, $04
	db $01, $07
	db $01, $0C
	db $01, $04
	db $01, $07
	db $01, $0C
	vibratoTableLoop Label18E9F

Label18EAE: ;4EAE
	db $01, $07
	db $01, $0C
	db $01, $10
	db $01, $07
	db $01, $0C
	db $01, $10
	vibratoTableLoop Label18EAE

Label18EBD: ;4EBD
	db $01, $00
	db $01, $03
	db $01, $07
	db $01, $00
	db $01, $03
	db $01, $07
	vibratoTableLoop Label18EBD

Label18ECC: ;4ECC
	db $01, $00
	db $01, $03
	db $01, $06
	db $01, $00
	db $01, $03
	db $01, $06
	vibratoTableLoop Label18ECC

Label18EDB: ;4EDB
	db $01, $0C
	db $C8, $00
	db $C8, $00
	db $C8, $00
	vibratoTableLoop Label18EDB

Label18EE6: ;4EE6
	db $01, $00
	db $01, $01
	db $01, $02
	db $01, $03
	db $01, $04
	db $01, $05
	vibratoTableLoop Label18EE6
;4EF5
