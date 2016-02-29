;mansion map room locations
;6 unsign bytes size boxes
;

Room_00_map: ;05:5EE7
	db $23, $24 ; xpos, ypos
	db $10, $0F ; width, heigh
	db $00, $00 ; roomId, roomId high

Room_01_map:
	db $12, $27
	db $10, $07
	db $01, $00

Room_02_map:
	db $0F, $19
	db $03, $03
	db $02, $00

Room_03_map_A:
	db $16, $16
	db $05, $02
	db $03, $00

Room_03_map_B:
	db $1B, $17
	db $05, $01
	db $03, $00

Room_03_map_C:
	db $1F, $17
	db $01, $03
	db $03, $00

Room_03_map_D:
	db $16, $18
	db $01, $0B
	db $03, $00

Room_04_map_A:
	db $34, $2B
	db $07, $05
	db $04, $00

Room_04_map_B:
	db $39, $29
	db $04, $01
	db $04, $00

Room_04_map_C:
	db $3D, $29
	db $02, $03
	db $04, $00

Room_04_map_D:
	db $3B, $2B
	db $02, $01
	db $04, $00

Room_05_map_A:
	db $0F, $22
	db $02, $02
	db $05, $00

Room_05_map_B:
	db $0F, $24
	db $0F, $02
	db $05, $00

Room_06_map_A:
	db $1C, $19
	db $02, $02
	db $06, $00

Room_06_map_B:
	db $1C, $1B
	db $04, $01
	db $06, $00

Room_07_map_A:
	db $18, $1D
	db $05, $06
	db $07, $00

Room_07_map_B:
	db $1D, $1D
	db $03, $01
	db $07, $00

Room_07_map_C:
	db $1D, $22
	db $01, $01
	db $07, $00

Room_08_map_A:
	db $0C, $16
	db $09, $02
	db $08, $00

Room_08_map_B:
	db $0C, $18
	db $02, $05
	db $08, $00

Room_08_map_C:
	db $0C, $1D
	db $06, $04
	db $08, $00

Room_09_map:
	db $13, $19
	db $02, $03
	db $09, $00

Room_0A_map_A:
	db $3C, $1C
	db $02, $02
	db $0A, $00

Room_0A_map_B:
	db $3D, $1B
	db $01, $01
	db $0A, $00

Room_0A_map_C:
	db $3D, $1A
	db $06, $01
	db $0A, $00

Room_0A_map_D:
	db $42, $1B
	db $01, $02
	db $0A, $00

Room_0A_map_E:
	db $42, $1D
	db $04, $01
	db $0A, $00

Room_0A_map_F:
	db $46, $1D
	db $02, $04
	db $0A, $00

Room_0B_map_A:
	db $34, $18
	db $01, $04
	db $0B, $00

Room_0B_map_B:
	db $34, $1C
	db $07, $02
	db $0B, $00

Room_0C_map_A:
	db $3C, $2E
	db $0A, $02
	db $0C, $00

Room_0C_map_B:
	db $46, $22
	db $02, $0C
	db $0C, $00

Room_0D_map_A:
	db $38, $14
	db $04, $03
	db $0D, $00

Room_0D_map_B:
	db $38, $17
	db $02, $04
	db $0D, $00

Room_0E_map_A:
	db $13, $1D
	db $02, $05
	db $0E, $00

Room_0E_map_B:
	db $12, $22
	db $01, $01
	db $0E, $00

Room_0F_map_A:
	db $1E, $1F
	db $04, $02
	db $0F, $00

Room_0F_map_B:
	db $21, $21
	db $01, $03
	db $0F, $00

Room_0F_map_C:
	db $1F, $24
	db $03, $02
	db $0F, $00

Room_10_map_A:
	db $34, $24
	db $0B, $01
	db $10, $00

Room_10_map_B:
	db $37, $25
	db $01, $01
	db $10, $00

Room_10_map_C:
	db $34, $26
	db $04, $04
	db $10, $00

Room_11_map:
	db $44, $1A
	db $04, $02
	db $11, $00

Room_12_map_A:
	db $43, $18
	db $07, $01
	db $12, $00

Room_12_map_B:
	db $49, $19
	db $01, $06
	db $12, $00

currentRoomMapTileData: ;5FF5
	db $7F, $00
	db $00, $BF
	db $00, $00
	db $DF, $00
	db $00, $EF
	db $00, $00
	db $F7, $00
	db $00, $FB
	db $00, $00
	db $FD, $00
	db $00, $FE
	db $00, $00

unvisitedRoomMapTileData: ;600D
	db $7F, $00
	db $80, $BF
	db $00, $40
	db $DF, $00
	db $20, $EF
	db $00, $10
	db $F7, $00
	db $08, $FB
	db $00, $04
	db $FD, $00
	db $02, $FE
	db $00, $01

visitedRoomMapTileData: ;5:6025
	db $7F, $80
	db $00, $BF
	db $40, $00
	db $DF, $20
	db $00, $EF
	db $10, $00
	db $F7, $08
	db $00, $FB
	db $04, $00
	db $FD, $02
	db $00, $FE
	db $01, $00
;603D
