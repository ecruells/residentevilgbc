instrumentsTables: ;4A8F
; instruments table 0
	dw Label18ACF
	dw Label18ADB
	dw Label18AE7
	dw Label18AF3
	dw Label18AFF
	dw Label18B0B
	dw Label18B17
	dw Label18B23
	dw Label18B2F
	dw Label18B3B
	dw Label18B47
	dw Label18B53
	dw Label18B5F
	dw Label18B6B
	dw Label18B77
	dw Label18B83
; instruments table 1
	dw Label18B8F
	dw Label18B9B
	dw Label18BA7
	dw Label18BB3
	dw Label18BBF
	dw Label18BCB
	dw Label18BD7
	dw Label18BE3
	dw Label18BEF
	dw Label18BFB
	dw Label18C07
	dw Label18C13
	dw Label18C1F
	dw Label18C2B
	dw Label18C37
	dw Label18C43
;4ACF


Label18ACF: ;06:4ACF
	db $80
	db $00
	db $02
	dbw $00, $0000
	dbw $00, $0000
	dbw $00, $0000

Label18ADB: ; noise instrument
	db %11000000 ; restart sound & enable length counter
	db $BD ; sound length
	db $00 ; envelope
	dbw $01, Label18C4F
	dbw $01, Label18D56
	dbw $00, $0000

Label18AE7:
	db $80
	db $80
	db $00
	dbw $01, Label18C58
	dbw $01, Label18D59
	dbw $00, $0000

Label18AF3:
	db $C0
	db $BB
	db $31
	dbw $00, $0000
	dbw $01, Label18D7A
	dbw $00, $0000

Label18AFF:
	db $C0
	db $BB
	db $41
	dbw $00, $0000
	dbw $01, Label18D7A
	dbw $00, $0000

Label18B0B:
	db $80
	db $80
	db $00
	dbw $01, Label18C63
	dbw $01, Label18D59
	dbw $00, $0000

Label18B17:
	db $80
	db $80
	db $00
	dbw $01, Label18CD1
	dbw $02, Label18DD1
	dbw $00, $0000

Label18B23:
	db $80
	db $80
	db $00
	dbw $01, Label18C8C
	dbw $01, Label18DBE
	dbw $00, $0000

Label18B2F:
	dbw $80, $2700
	dbw $00, $0000
	dbw $00, $0000
	dbw $01, Label18E55

Label18B3B:
	db $80
	db $80
	db $00
	dbw $01, Label18CA8
	dbw $00, $0000
	dbw $01, Label18E60

Label18B47: ;4B47
	db $80 ; init
	db $80 ; wave pattern 50%
	db $37 ; envelope
	dbw $00, $0000
	dbw $01, Label18DBE
	dbw $00, $0000

Label18B53:
	db $80
	db $80
	db $97
	dbw $00, $0000
	dbw $01, Label18DBE
	dbw $00, $0000

Label18B5F:
	db $80
	db $80
	db $00
	dbw $01, Label18CB5
	dbw $01, Label18DBE
	dbw $00, $0000

Label18B6B:
	db $80
	db $80
	db $62
	dbw $00, $0000
	dbw $01, Label18DD1
	dbw $00, $0000

Label18B77:
	db $80
	db $80
	db $80
	dbw $01, Label18CC4
	dbw $02, Label18DE4
	dbw $00, $0000

Label18B83:
	db $80
	db $80
	db $80
	dbw $01, Label18CD1
	dbw $02, Label18DE4
	dbw $00, $0000

Label18B8F:
	db $C0
	db $00
	db $00
	dbw $01, Label18D05
	dbw $00, $0000
	dbw $00, $0000

Label18B9B:
	db $C0 ; trigger channel start (init) | Consecutive select/length counter enable
	db $00
	db $00
	dbw $01, Label18D10
	dbw $00, $0000
	dbw $00, $0000

Label18BA7:
	db $80
	db $00
	db $00
	dbw $01, Label18D19
	dbw $01, Label18E0A
	dbw $00, $0000

Label18BB3:
	db $80
	db $80
	db $00
	dbw $01, Label18CE4
	dbw $00, $0000
	dbw $01, Label18E90

Label18BBF:
	db $80
	db $80
	db $64
	dbw $00, $0000
	dbw $00, $0000
	dbw $01, Label18E9F

Label18BCB:
	db $80
	db $80
	db $64
	dbw $00, $0000
	dbw $00, $0000
	dbw $01, Label18EAE

Label18BD7:
	db $80
	db $80
	db $00
	dbw $01, Label18CE4
	dbw $00, $0000
	dbw $02, Label18EBD

Label18BE3:
	db $80
	db $80
	db $56
	dbw $00, $0000
	dbw $00, $0000
	dbw $01, Label18ECC

Label18BEF:
	db $80
	db $00
	db $00
	dbw $01, Label18D26
	dbw $01, Label18E0A
	dbw $00, $0000

Label18BFB:
	db $80
	db $00
	db $00
	dbw $01, Label18D26
	dbw $00, $0000
	dbw $00, $0000

Label18C07: ;4c07
	db $80 ; trigger channel start (init)
	db $40
	db $00
	dbw $01, Label18CFC
	dbw $01, Label18DBE
	dbw $00, $0000

Label18C13:
	db $80
	db $80
	db $00
	dbw $01, Label18CD1
	dbw $00, $0000
	dbw $01, Label18E6D

Label18C1F:
	db $80
	db $80
	db $00
	dbw $01, Label18D3B
	dbw $00, $0000
	dbw $01, Label18EE6

Label18C2B:
	db $80
	db $80
	db $00
	dbw $01, Label18D44
	dbw $01, Label18E20
	dbw $00, $0000

Label18C37:
	db $80
	db $80
	db $00
	dbw $01, Label18D4D
	dbw $01, Label18E20
	dbw $00, $0000

Label18C43:
	db $80
	db $80
	db $00
	dbw $01, Label18CD1
	dbw $02, Label18DF7
	dbw $00, $0000
;4C4F
