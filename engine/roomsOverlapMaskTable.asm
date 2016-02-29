
Room01_00_overlapMaskA: ;439E
	db $34 ; Y-sort overlap
	db $30, $10 ;unused
	db $38 ; mask Y pos
	db $28 ; mask height
	db $02 ; mask count
	;mask parts [mask X pos][mask Addr Low][mask Addr High]
	dbw $30, room01_00_olmask_A1 ;46E3
	dbw $38, room01_00_olmask_A2 ;470B

Room01_00_overlapMaskB: ;43AA
	db $32, $70, $18, $38, $30
	db $03
	dbw $70, room01_00_olmask_B1 ;4733
	dbw $78, room01_00_olmask_B2 ;4763
	dbw $80, room01_00_olmask_B3 ;4793

Room01_02_overlapMaskA: ;43B9
	db $3D, $30, $10, $48, $28
	db $02
	dbw $30, room01_02_olmask_A1 ;47C3
	dbw $38, room01_02_olmask_A2 ;47EB


Room01_02_overlapMaskB: ;43C5
	db $42, $60, $10, $48, $28
	db $02
	dbw $60, room01_02_olmask_B1 ;4813
	dbw $68, room01_02_olmask_B2 ;483B


Room04_00_overlapMask: ;43D1
	db $01, $28, $28, $20, $70
	db $05
	dbw $28, room04_00_olmask_A1 ;4863
	dbw $30, room04_00_olmask_A2 ;48D3
	dbw $38, room04_00_olmask_A3 ;4943
	dbw $40, room04_00_olmask_A4 ;49B3
	dbw $48, room04_00_olmask_A5 ;4A23

Room04_01_overlapMask: ;43E6
	db $1F, $40, $28, $20, $60
	db $05
	dbw $40, room04_01_olmask_A1 ;4A93
	dbw $48, room04_01_olmask_A2 ;4AF3
	dbw $50, room04_01_olmask_A3 ;4B53
	dbw $58, room04_01_olmask_A4 ;4BB3
	dbw $60, room04_01_olmask_A5 ;4C13

Room04_02_overlapMask: ;43FB
	db $01, $58, $50, $58, $38
	db $0A
	dbw $58, room04_02_olmask_A1 ;4C73
	dbw $60, room04_02_olmask_A2 ;4CAB
	dbw $68, room04_02_olmask_A3 ;4CE3
	dbw $70, room04_02_olmask_A4 ;4D1B
	dbw $78, room04_02_olmask_A5 ;4D53
	dbw $80, room04_02_olmask_A6 ;4D8B
	dbw $88, room04_02_olmask_A7 ;4DC3
	dbw $90, room04_02_olmask_A8 ;4DFB
	dbw $98, room04_02_olmask_A9 ;4E33
	dbw $A0, room04_02_olmask_A10 ;4E6B


Room05_01_overlapMask: ;441F
	db $22, $70, $38, $30, $40
	db $07
	dbw $70, room05_01_olmask_A1 ;4EA3
	dbw $78, room05_01_olmask_A2 ;4EE3
	dbw $80, room05_01_olmask_A3 ;4F23
	dbw $88, room05_01_olmask_A4 ;4F63
	dbw $90, room05_01_olmask_A5 ;4FA3
	dbw $98, room05_01_olmask_A6 ;4FE3
	dbw $A0, room05_01_olmask_A7 ;5023

Room08_02_overlapMask: ;443A
	db $2F, $50, $10, $38, $38
	db $02
	dbw $50, room08_02_olmask_A1 ;5063
	dbw $58, room08_02_olmask_A2 ;509B


Room08_04_overlapMask: ;4446
	db $01, $70, $28, $28, $28
	db $05
	dbw $70, room08_04_olmask_A1 ;50D3
	dbw $78, room08_04_olmask_A2 ;50FB
	dbw $80, room08_04_olmask_A3 ;5123
	dbw $88, room08_04_olmask_A4 ;514B
	dbw $90, room08_04_olmask_A5 ;5173

Room0E_00_overlapMask: ;445B
	db $01, $08, $78, $70, $20
	db $0F
	dbw $08, room0E_00_olmask_A1 ;519B
	dbw $10, room0E_00_olmask_A2 ;51BB
	dbw $18, room0E_00_olmask_A3 ;51DB
	dbw $20, room0E_00_olmask_A4 ;51FB
	dbw $28, room0E_00_olmask_A5 ;521B
	dbw $30, room0E_00_olmask_A6 ;523B
	dbw $38, room0E_00_olmask_A7 ;525B
	dbw $40, room0E_00_olmask_A8 ;527B
	dbw $48, room0E_00_olmask_A9 ;529B
	dbw $50, room0E_00_olmask_A10 ;52BB
	dbw $58, room0E_00_olmask_A11 ;52DB
	dbw $60, room0E_00_olmask_A12 ;52FB
	dbw $68, room0E_00_olmask_A13 ;531B
	dbw $70, room0E_00_olmask_A14 ;533B
	dbw $78, room0E_00_olmask_A15 ;535B

Room0E_01_overlapMask: ;448E
	db $01, $20, $78, $68, $28
	db $0D
	dbw $40, room0E_01_olmask_A1 ;537B
	dbw $48, room0E_01_olmask_A2 ;53A3
	dbw $50, room0E_01_olmask_A3 ;53CB
	dbw $58, room0E_01_olmask_A4 ;53F3
	dbw $60, room0E_01_olmask_A5 ;541B
	dbw $68, room0E_01_olmask_A6 ;5443
	dbw $70, room0E_01_olmask_A7 ;546B
	dbw $78, room0E_01_olmask_A8 ;5493
	dbw $80, room0E_01_olmask_A9 ;54BB
	dbw $88, room0E_01_olmask_A10 ;54E3
	dbw $90, room0E_01_olmask_A11 ;550B
	dbw $98, room0E_01_olmask_A12 ;5533
	dbw $A0, room0E_01_olmask_A13 ;555B

Room0E_02_overlapMask: ;44BB
	db $01, $20, $78, $58, $28
	db $04
	dbw $20, room0E_02_olmask_A1 ;5583
	dbw $28, room0E_02_olmask_A2 ;55AB
	dbw $30, room0E_02_olmask_A3 ;55D3
	dbw $38, room0E_02_olmask_A4 ;55FB


Room10_00_overlapMask: ;44CD
	db $01, $30, $28, $30, $58
	db $05
	dbw $30, room10_00_olmask_A1 ;57DB
	dbw $38, room10_00_olmask_A2 ;5833
	dbw $40, room10_00_olmask_A3 ;588B
	dbw $48, room10_00_olmask_A4 ;58E3
	dbw $50, room10_00_olmask_A5 ;593B

Room10_01_overlapMaskA: ;44E2
	db $01, $08, $18, $30, $40
	db $03
	dbw $08, room10_01_olmask_A1 ;5993
	dbw $10, room10_01_olmask_A2 ;59D3
	dbw $18, room10_01_olmask_A3 ;5A13

Room10_01_overlapMaskB: ;44F1
	db $01, $58, $20, $30, $50
	db $04
	dbw $58, room10_01_olmask_B1 ;5A53
	dbw $60, room10_01_olmask_B2 ;5AA3
	dbw $68, room10_01_olmask_B3 ;5AF3
	dbw $70, room10_01_olmask_B4 ;5B43


Room10_02_overlapMask: ;4503
	db $01, $60, $28, $38, $40
	db $05
	dbw $60, room10_02_olmask_A1 ;5B93
	dbw $68, room10_02_olmask_A2 ;5BD3
	dbw $70, room10_02_olmask_A3 ;5C13
	dbw $78, room10_02_olmask_A4 ;5C53
	dbw $80, room10_02_olmask_A5 ;5C93

Room22_00_overlapMask: ;4518
	db $01, $38, $38, $60, $28
	db $07
	dbw $38, room22_00_olmask_A1 ;5CD3
	dbw $40, room22_00_olmask_A2 ;5CFB
	dbw $48, room22_00_olmask_A3 ;5D23
	dbw $50, room22_00_olmask_A4 ;5D4B
	dbw $58, room22_00_olmask_A5 ;5D73
	dbw $60, room22_00_olmask_A6 ;5D9B
	dbw $68, room22_00_olmask_A7 ;5DC3

Room22_01_overlapMask: ;4533
	db $01, $40, $38, $58, $28
	db $07
	dbw $40, room22_01_olmask_A1 ;5DEB
	dbw $48, room22_01_olmask_A2 ;5E13
	dbw $50, room22_01_olmask_A3 ;5E3B
	dbw $58, room22_01_olmask_A4 ;5E63
	dbw $60, room22_01_olmask_A5 ;5E8B
	dbw $68, room22_01_olmask_A6 ;5EB3
	dbw $70, room22_01_olmask_A7 ;5EDB

Room24_00_overlapMaskA: ;454E
	db $01, $48, $20, $40, $30
	db $04
	dbw $48, room24_00_olmask_A1 ;5F03
	dbw $50, room24_00_olmask_A2 ;5F33
	dbw $58, room24_00_olmask_A3 ;5F63
	dbw $60, room24_00_olmask_A4 ;5F93


Room24_00_overlapMaskB: ;4560
	db $01, $68, $20, $20, $50
	db $04
	dbw $68, room24_00_olmask_B1 ;5FC3
	dbw $70, room24_00_olmask_B2 ;6013
	dbw $78, room24_00_olmask_B3 ;6063
	dbw $80, room24_00_olmask_B4 ;60B3


Room24_00_overlapMaskC: ;4572
	db $01, $88, $20, $10, $38
	db $04
	dbw $88, room24_00_olmask_C1 ;6103
	dbw $90, room24_00_olmask_C2 ;613B
	dbw $98, room24_00_olmask_C3 ;6173
	dbw $A0, room24_00_olmask_C4 ;61AB


Room24_04_overlapMaskA: ;4584
	db $01, $20, $40, $50, $28
	db $08
	dbw $20, room24_04_olmask_A1 ;61E3
	dbw $28, room24_04_olmask_A2 ;620B
	dbw $30, room24_04_olmask_A3 ;6233
	dbw $38, room24_04_olmask_A4 ;625B
	dbw $40, room24_04_olmask_A5 ;6283
	dbw $48, room24_04_olmask_A6 ;62AB
	dbw $50, room24_04_olmask_A7 ;62D3
	dbw $58, room24_04_olmask_A8 ;62FB


Room24_04_overlapMaskB: ;45A2
	db $01, $60, $08, $10, $68
	db $01
	dbw $60, room24_04_olmask_B1 ;6323

Room24_04_overlapMaskC: ;45AB
	db $01, $68, $38, $50, $28
	db $07
	dbw $68, room24_04_olmask_C1 ;638B
	dbw $70, room24_04_olmask_C2 ;63B3
	dbw $78, room24_04_olmask_C3 ;63DB
	dbw $80, room24_04_olmask_C4 ;6403
	dbw $88, room24_04_olmask_C5 ;642B
	dbw $90, room24_04_olmask_C6 ;6453


Room29_00_overlapMask: ;45C3
	db $01, $08, $40, $48, $48
	db $08
	dbw $08, room29_00_olmask_A1 ;64A3
	dbw $10, room29_00_olmask_A2 ;64EB
	dbw $18, room29_00_olmask_A3 ;6533
	dbw $20, room29_00_olmask_A4 ;657B
	dbw $28, room29_00_olmask_A5 ;65C3
	dbw $30, room29_00_olmask_A6 ;660B
	dbw $38, room29_00_olmask_A7 ;6653
	dbw $40, room29_00_olmask_A8 ;669B


Room2C_01_overlapMaskA: ;45E1
	db $24, $48, $18, $28, $40
	db $03
	dbw $48, room2C_01_olmask_A1 ;66E3
	dbw $50, room2C_01_olmask_A2 ;6723
	dbw $58, room2C_01_olmask_A3 ;6763

Room2C_01_overlapMaskB: ;45F0
	db $18, $38, $20, $58, $28
	db $04
	dbw $38, room2C_01_olmask_B1 ;67A3
	dbw $40, room2C_01_olmask_B2 ;67CB
	dbw $48, room2C_01_olmask_B3 ;67F3
	dbw $50, room2C_01_olmask_B4 ;681B


Room2C_01_overlapMaskC: ;4602
	db $25, $78, $18, $30, $38
	db $03
	dbw $78, room2C_01_olmask_C1 ;6843
	dbw $80, room2C_01_olmask_C2 ;687B
	dbw $88, room2C_01_olmask_C3 ;68B3

Room2C_02_overlapMaskA: ;4611
	db $01, $48, $18, $38, $40
	db $03
	dbw $48, room2C_02_olmask_A1 ;68EB
	dbw $50, room2C_02_olmask_A2 ;692B
	dbw $58, room2C_02_olmask_A3 ;696B
	dbw $60, room2C_02_olmask_B1 ;69AB


Room2C_02_overlapMaskB: ;4623
	db $01, $58, $20, $58, $20
	db $04
	dbw $58, room2C_02_olmask_B1 ;69AB
	dbw $60, room2C_02_olmask_B2 ;69CB
	dbw $68, room2C_02_olmask_B3 ;69EB
	dbw $70, room2C_02_olmask_B4 ;6A0B
	dbw $78, room2C_02_olmask_C1 ;6A2B

Room2C_02_overlapMaskC: ;4638
	db $01, $18, $10, $38, $38
	db $02
	dbw $18, room2C_02_olmask_C1 ;6A2B
	dbw $20, room2C_02_olmask_C2 ;6A63


Room4C_05_overlapMask: ;4644
	db $01, $60, $10, $38, $18
	db $02
	dbw $60, room4C_05_olmask_A1 ;6A9B
	dbw $68, room4C_05_olmask_A2 ;6AB3


Room54_05_overlapMask: ;4650
	db $01, $08, $28, $50, $40
	db $05
	dbw $08, room54_05_olmask_A1 ;6ACB
	dbw $10, room54_05_olmask_A2 ;6B0B
	dbw $18, room54_05_olmask_A3 ;6B4B
	dbw $20, room54_05_olmask_A4 ;6B8B
	dbw $28, room54_05_olmask_A5 ;6BCB

Room54_02_overlapMaskA: ;4665 34
	db $01, $30, $28, $50, $40
	db $05
	dbw $30, room54_02_olmask_A1 ;6C0B
	dbw $38, room54_02_olmask_A2 ;6C4B
	dbw $40, room54_02_olmask_A3 ;6C8B
	dbw $48, room54_02_olmask_A4 ;6CCB
	dbw $50, room54_02_olmask_A5 ;6D0B

Room54_01_overlapMaskA: ;467A
	db $01, $40, $10, $38, $40
	db $02
	dbw $40, room54_01_olmask_A1 ;6D4B
	dbw $48, room54_01_olmask_A2 ;6D8B


Room54_02_overlapMaskB: ;4686
	db $01, $78, $30, $58, $38
	db $06
	dbw $78, room54_02_olmask_B1 ;6DCB
	dbw $80, room54_02_olmask_B2 ;6E03
	dbw $88, room54_02_olmask_B3 ;6E3B
	dbw $90, room54_02_olmask_B4 ;6E73
	dbw $98, room54_02_olmask_B5 ;6EAB
	dbw $A0, room54_02_olmask_B6 ;6EE3


Room54_01_overlapMaskB: ;469E
	db $26, $68, $18, $50, $20
	db $03
	dbw $68, room54_01_olmask_B1 ;6F1B
	dbw $70, room54_01_olmask_B2 ;6F3B
	dbw $78, room54_01_olmask_B3 ;6F5B

Room54_02_overlapMaskC: ;46AD
	db $01, $08, $28, $38, $58
	db $05
	dbw $08, room54_02_olmask_C1 ;6F7B
	dbw $10, room54_02_olmask_C2 ;6FD3
	dbw $18, room54_02_olmask_C3 ;702B
	dbw $20, room54_02_olmask_C4 ;7083
	dbw $28, room54_02_olmask_C5 ;70DB

Room54_03_overlapMask: ;46C2
	db $01, $40, $48, $48, $48
	db $09
	dbw $40, room54_03_olmask_A1 ;7133
	dbw $48, room54_03_olmask_A2 ;717B
	dbw $50, room54_03_olmask_A3 ;71C3
	dbw $58, room54_03_olmask_A4 ;720B
	dbw $60, room54_03_olmask_A5 ;7253
	dbw $68, room54_03_olmask_A6 ;729B
	dbw $70, room54_03_olmask_A7 ;72E3
	dbw $78, room54_03_olmask_A8 ;732B
	dbw $80, room54_03_olmask_A9 ;7373
