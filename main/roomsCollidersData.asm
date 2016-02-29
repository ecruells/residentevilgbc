;first byte of colliders data is the number of colliders
;each collider consist in 16 bytes that form a rect collider (16bits sign int each border)
;xxXX yyYY ofXX ofYY
;xxXX: right border of collider  (low-high)
;yyYY: bottom border of collider (low-high)
;ofXX: left offset of right border
;ofYY: top offset of bottom border

room_00_colliders: ;4518
	db $12 ;colliders count
	dw $FF80, $0040, $0010, $0018
	dw $FFA4, $0040, $0018, $0018
	dw $FFD6, $0040, $001A, $0018
	dw $FFDF, $FFF8, $0041, $0060
	dw $0014, $0040, $0018, $0018
	dw $0044, $0040, $0018, $0018
	dw $0070, $0040, $0010, $0018
	dw $000F, $FFF8, $0018, $0018
	dw $FF88, $FF98, $0016, $0014
	dw $FF88, $FFC0, $0016, $0014
	dw $FF88, $FFE8, $0016, $0014
	dw $FF88, $0014, $0016, $0014
	dw $FFB4, $FFF0, $0016, $0014
	dw $0062, $FF98, $0016, $0014
	dw $0062, $FFC0, $0016, $0014
	dw $0062, $FFE8, $0016, $0014
	dw $0062, $0014, $0016, $0014
	dw $0036, $FFF0, $0016, $0014

room_01_colliders: ;45A9
	db $09
	dw $FF88, $FFD0, $000C, $000C
	dw $FF88, $0024, $000C, $000C
	dw $FF9A, $FFDE, $000C, $000E
	dw $FF9A, $0016, $000C, $000E
	dw $0064, $FFE0, $000C, $000E
	dw $0064, $0014, $000C, $000E
	dw $006C, $FFD0, $000C, $000C
	dw $006C, $0024, $000C, $000C
	dw $0018, $FFD0, $0014, $000C

room_02_colliders: ;45F2
	db $04
	dw $FFE0, $FFE0, $0018, $0010
	dw $FFF6, $FFE0, $002A, $0014
	dw $0014, $FFF6, $000C, $0026
	dw $0008, $0020, $0018, $0010

room_03_colliders: ;4613
	db $05
	dw $FFDA, $FF80, $009E, $001E
	dw $FF9E, $FFAA, $00C4, $005C
	dw $FF9E, $0012, $00C4, $0074
	dw $005C, $FFDA, $001E, $00AC
	dw $FFCE, $FFFA, $00AC, $0024

room_04_colliders: ;463C
	db $08
	dw $002A, $FFB8, $0036, $0090
	dw $FFD0, $0046, $0036, $0064
	dw $0000, $0046, $0010, $000C
	dw $0018, $0046, $0018, $000C
	dw $002C, $0046, $0008, $0050
	dw $0030, $0046, $0010, $0028
	dw $0050, $0046, $0010, $0028
	dw $FFF2, $FFF4, $001C, $0012

room_05_colliders: ;467D
	db $03
	dw $0060, $0014, $0010, $0028
	dw $0060, $002C, $002A, $0010
	dw $FF80, $0008, $00E8, $0034

room_06_colliders: ;4696
	db $03
	dw $FFFA, $FFF0, $001A, $002C
	dw $FFEA, $FFDC, $0036, $0010
	dw $FFA0, $0004, $001E, $002C

room_07_colliders: ;46AF
	db $0A
	dw $FFBA, $FFE8, $000C, $0018
	dw $FFBA, $0008, $000C, $0018
	dw $FFC0, $FF98, $000C, $0026
	dw $FFD0, $FFB8, $000C, $000E
	dw $FFCA, $FFC4, $0040, $003C
	dw $FFDA, $FF98, $0044, $002E
	dw $0014, $FF98, $0032, $001E
	dw $FFCA, $002A, $0076, $0016
	dw $FF70, $FF98, $0056, $005E
	dw $FF70, $0012, $0056, $002E

room_08_colliders: ;4700
	db $04
	dw $FFFA, $FFC2, $008C, $007C
	dw $004A, $0032, $003C, $004C
	dw $FFE0, $0058, $0048, $0020
	dw $FFDA, $FFEE, $001C, $001C

room_09_colliders: ;4721
	db $02
	dw $FFE0, $0014, $0024, $000C
	dw $FFFC, $FFE0, $0024, $0008

room_0A_colliders: ;4732
	db $05
	dw $FFAC, $FFA4, $003E, $0046
	dw $000E, $FFA4, $003C, $002E
	dw $FFFE, $0046, $004C, $0064
	dw $FFE6, $FFDE, $004C, $005C
	dw $FFAC, $FFDE, $0046, $009C

room_0B_colliders: ;475B
	db $01
	dw $FFB8, $000C, $0086, $0040

room_0C_colliders: ;4764
	db $03
	dw $FFB6, $0020, $0044, $0018
	dw $0018, $0020, $0020, $0018
	dw $FFB0, $FF9C, $007E, $0092

room_0D_colliders: ;477D
	db $02
	dw $001A, $FFD0, $0070, $0046
	dw $FFDE, $FFD0, $0022, $0054

room_0E_colliders: ;478E
	db $04
	dw $0028, $FFE0, $001A, $000E
	dw $FFF6, $FFEA, $0014, $0036
	dw $FFC0, $FFEA, $0010, $002C
	dw $FFC0, $0014, $0040, $000C

room_0F_colliders: ;47AF
	db $02
	dw $FFD2, $FFF2, $005C, $0046
	dw $FFD2, $001A, $0074, $0046

room_10_colliders: ;47C0
	db $06
	dw $FFCA, $FFA0, $0056, $0076
	dw $FFCA, $0022, $001C, $0046
	dw $FFF0, $0010, $0020, $0010
	dw $FFF4, $0030, $0018, $0014
	dw $FFC0, $0050, $0010, $0020
	dw $000E, $001E, $0012, $0026

room_11_colliders: ;47F1
	db $05
	dw $000E, $000B, $0012, $0018
	dw $0006, $0018, $002A, $000C
	dw $FFEA, $0020, $0046, $0010
	dw $FFD0, $FFEC, $0018, $000C
	dw $FFE6, $FFEC, $004A, $0014

room_12_colliders: ;481A
	db $02
	dw $FFF2, $FFC0, $006E, $006E
	dw $0014, $0028, $004C, $0014

room_13_colliders: ;482B
	db $01
	dw $FFF2, $FF9A, $0028, $00C8

room_14_colliders: ;4834
	db $00

room_15_colliders: ;4835
	db $01
	dw $FFE0, $0002, $0028, $000E

room_16_colliders: ;483E
	db $03
	dw $FFE0, $FFE0, $000E, $000A
	dw $0012, $FFE0, $000E, $0010
	dw $FFE0, $000C, $000A, $0014

room_17_colliders: ;4857
	db $02
	dw $FFD0, $FFDA, $000A, $0034
	dw $001A, $FFE2, $0016, $0026

room_18_colliders: ;4868
	db $05
	dw $FFF0, $FFD8, $0020, $000C
	dw $001C, $FFD8, $000C, $000C
	dw $FFD8, $001C, $000C, $000C
	dw $FFFD, $FFF0, $0014, $0020
	dw $FFE4, $FFF0, $0015, $0020

room_19_colliders: ;4891
	db $00

room_1A_colliders: ;4892
	db $02
	dw $FF88, $FFC4, $006A, $0056
	dw $0006, $FFDE, $006A, $003C

room_1B_colliders: ;48A3
	db $03
	dw $FF70, $FFC4, $00B2, $0056
	dw $0036, $FFDE, $0080, $003C
	dw $0066, $FFC4, $0020, $0024

room_1C_colliders: ;48BC
	db $01
	dw $FF88, $FFDA, $00F0, $004C

room_1D_colliders: ;48C5
	db $02
	dw $FF90, $FF80, $00E8, $0082
	dw $FFB0, $0014, $00A0, $0048

room_1E_colliders: ;48D6
	db $03
	dw $FFC0, $FFC0, $006E, $0046
	dw $FFC0, $FFC0, $0046, $006E
	dw $0010, $0014, $0018, $0018

room_1F_colliders: ;48EF
	db $01
	dw $FFF4, $FFE0, $0020, $0010

room_20_colliders: ;48F8
	db $04
	dw $FFA0, $FFFE, $004E, $0020
	dw $FFFA, $FFCA, $003E, $0048
	dw $FFA0, $FF58, $007E, $009A
	dw $0018, $FF58, $001E, $0064

room_21_colliders: ;4919
	db $00

room_22_colliders: ;491A
	db $06
	dw $FFE8, $FFEC, $0028, $001E
	dw $001E, $FFD8, $0012, $000E
	dw $FFD0, $0022, $0010, $0028
	dw $FFD0, $0022, $002E, $000C
	dw $0004, $0022, $000C, $000C
	dw $000A, $0022, $0028, $0028

room_23_colliders: ;494B
	db $01
	dw $FFC0, $FFE8, $000E, $0030

room_24_colliders: ;4954
	db $03
	dw $FFD2, $FF92, $0046, $00CC
	dw $FF66, $0022, $0060, $005E
	dw $FF66, $FF80, $0060, $0096

room_25_colliders: ;496D
	db $03
	dw $FF80, $FFD2, $006E, $0100
	dw $FF80, $0052, $008E, $0080
	dw $FFFA, $FFC0, $0080, $0088

room_26_colliders: ;4986
	db $02
	dw $FFE2, $FFD8, $004A, $002E
	dw $0008, $001A, $0020, $000E

room_27_colliders: ;4997
	db $01
	dw $FFA0, $FFBA, $00A6, $008C

room_28_colliders: ;49A0
	db $05
	dw $FFE8, $FFCC, $0018, $0020
	dw $FFD0, $FFC0, $0042, $0010
	dw $FFD0, $FFC0, $0010, $004C
	dw $000C, $002E, $0040, $0014
	dw $000C, $0002, $0040, $0018

room_29_colliders: ;49C9
	db $01
	dw $0012, $FFDC, $001A, $001C

room_2A_colliders: ;49D2
	db $01
	dw $FFF7, $FFE6, $0012, $001A

room_2B_colliders: ;49DB
	db $04
	dw $FFD8, $FFA8, $0014, $001C
	dw $0008, $FFA8, $0028, $0010
	dw $FFD8, $FFEC, $0010, $002C
	dw $0010, $FFB2, $0020, $0020

room_2C_colliders: ;49FC
	db $0A
	dw $FFC8, $FF90, $001E, $005E
	dw $FFC8, $0022, $001E, $001E
	dw $0010, $FFB4, $0018, $002C
	dw $000E, $002E, $0018, $0018
	dw $FFFA, $FFF4, $0018, $0018
	dw $0012, $FF90, $0010, $0014
	dw $FFF4, $0004, $0010, $0010
	dw $FFD6, $0004, $0010, $0010
	dw $FFF2, $FF9C, $0014, $0034
	dw $FFE0, $FFB8, $0026, $0018

room_2D_colliders: ;4A4D
	db $02
	dw $FFA0, $FFD0, $0066, $0024
	dw $FFA0, $FFFB, $0066, $0036

room_2E_colliders: ;4A5E
	db $00

room_2F_colliders: ;4A5F
	db $04
	dw $FFC0, $FFE0, $001C, $0016
	dw $FFD4, $FFE0, $0018, $0010
	dw $FFDE, $0010, $0024, $0010
	dw $FFFA, $FFF2, $0046, $0036

room_30_colliders: ;4A80
	db $04
	dw $FFF2, $FFD8, $001C, $0008
	dw $FFDC, $FFD8, $000C, $0028
	dw $FFF1, $FFEC, $0014, $0014
	dw $FFFE, $FFFA, $0014, $0014

room_31_colliders: ;4AA1
	db $08
	dw $FFE0, $FFA8, $001E, $002E
	dw $FFE0, $0020, $0014, $0010
	dw $0008, $FFA8, $006C, $000C
	dw $001A, $FFC2, $001C, $005C
	dw $0042, $FFC2, $0028, $001C
	dw $0042, $0002, $0028, $001C
	dw $0054, $FFC2, $0028, $005C
	dw $004A, $FFEC, $0010, $0012

room_32_colliders: ;4AE2
	db $04
	dw $000A, $FFDC, $001C, $0030
	dw $000A, $0012, $001C, $0010
	dw $001A, $FFC4, $0028, $0012
	dw $002E, $FFB0, $0020, $0020

room_33_colliders: ;4B03
	db $01
	dw $FFF0, $FFE0, $0020, $0010

room_34_colliders: ;4B0C
	db $02
	dw $FFF4, $FFF4, $0018, $0018
	dw $0006, $0018, $0022, $0010

room_35_colliders: ;4B1D
	db $05
	dw $FFC0, $FF92, $002E, $00D6
	dw $FFFA, $FF80, $0080, $0036
	dw $FFE8, $FFC4, $0066, $0008
	dw $FFFA, $FFC4, $0054, $0020
	dw $FFFA, $FFF2, $0080, $0080

room_36_colliders: ;4B46
	db $05
	dw $FF80, $FF70, $0086, $0056
	dw $FF80, $FFBA, $00B4, $0074
	dw $0064, $FFBA, $001C, $0074
	dw $0013, $FF84, $005E, $0022
	dw $FF80, $004A, $00D6, $0056

room_37_colliders: ;4B6F
	db $07
	dw $FF98, $FF78, $006E, $002E
	dw $FF98, $003A, $00CE, $0046
	dw $FFBA, $FFC2, $004C, $0080
	dw $FF98, $0012, $002E, $0040
	dw $0022, $FF9A, $0044, $003C
	dw $001A, $FFD6, $004C, $0050
	dw $FFFA, $FFC2, $0034, $0024

room_38_colliders: ;4BA8
	db $04
	dw $FFBE, $FFA0, $003C, $0036
	dw $0006, $FFA0, $003C, $0036
	dw $FFA0, $FFFA, $0036, $0066
	dw $002A, $FFFA, $0036, $0066

room_39_colliders: ;4BC9
	db $01
	dw $FF80, $0040, $0038, $0040

room_3A_colliders: ;4BD2
	db $03
	dw $FF88, $001A, $00CE, $00A0
	dw $FFAA, $FF80, $00F6, $007E
	dw $0072, $FF80, $0028, $00F6

room_3B_colliders: ;4BEB
	db $00

room_3C_colliders: ;4BEC
	db $03
	dw $FFEA, $FFA0, $0024, $0096
	dw $FFEA, $FFA0, $0080, $0046
	dw $FFEA, $0028, $0052, $000E

room_3D_colliders: ;4C05
	db $04
	dw $FF80, $FFC0, $008E, $0018
	dw $002A, $FFC0, $0040, $001A
	dw $FF92, $FFFA, $00AC, $0046
	dw $FF80, $0002, $0020, $003E

room_3E_colliders: ;4C26
	db $08
	dw $FF80, $FFC4, $0066, $00BC
	dw $FFDA, $0002, $0034, $007C
	dw $0002, $FFC4, $003C, $007C
	dw $0002, $FFC4, $004C, $0034
	dw $005A, $FFC4, $0030, $0034
	dw $0066, $FFEA, $0020, $0040
	dw $004C, $001E, $0048, $00C8
	dw $0028, $FFEA, $0016, $00C8

room_3F_colliders: ;4C67
	db $01
	dw $FFDA, $FFC2, $004C, $00C8

room_40_colliders: ;4C70
	db $02
	dw $FFE0, $FFE0, $0018, $000A
	dw $FFF2, $FFEC, $001C, $0028

room_41_colliders: ;4C81
	db $03
	dw $FFA8, $FFE2, $003E, $00C0
	dw $0002, $FFA8, $00C0, $001E
	dw $0002, $FFE2, $007C, $007C

room_42_colliders: ;4C9A
	db $00

room_43_colliders: ;4C9B
	db $03
	dw $FFD8, $FF80, $002E, $0072
	dw $FFD8, $000E, $002E, $0072
	dw $0022, $FFA2, $0010, $00FF

room_44_colliders: ;4CB4
	db $08
	dw $FF88, $FF80, $001E, $00B6
	dw $FFBE, $FF9E, $0034, $0034
	dw $FFA0, $FFEA, $004E, $004C
	dw $000A, $FF80, $0024, $0038
	dw $000A, $FFCC, $0024, $00A0
	dw $0022, $FF80, $004C, $0028
	dw $0022, $FFD8, $004C, $0028
	dw $005A, $FF9C, $0020, $0050

room_45_colliders: ;4CF5
	db $00

room_46_colliders: ;4CF6
	db $00

room_47_colliders: ;4CF7
	db $05
	dw $FF9A, $FF80, $00F0, $002E
	dw $001A, $FFC2, $0040, $005C
	dw $FF9A, $FFC2, $006C, $005C
	dw $FF80, $FFD2, $0026, $005C
	dw $FF80, $FF80, $000E, $001C

room_48_colliders: ;4D20
	db $05
	dw $FFCE, $FFFA, $0058, $0056
	dw $FFCE, $FFC8, $0018, $0010
	dw $FFCE, $FFC8, $0014, $0038
	dw $0028, $FFEC, $0020, $0010
	dw $0008, $FFC8, $0040, $001C

room_49_colliders: ;4D49
	db $04
	dw $FFE0, $FFE0, $0020, $0018
	dw $000A, $FFE0, $0016, $0012
	dw $0016, $FFF4, $000A, $000A
	dw $000E, $0014, $0012, $000C

room_4A_colliders: ;4D6A
	db $04
	dw $FFE4, $FFD0, $0024, $0016
	dw $000A, $FFD0, $0030, $002C
	dw $001C, $FFF8, $0014, $0038
	dw $FFDC, $0020, $0032, $0018

room_4B_colliders: ;4D8B
	db $01
	dw $FFA2, $FFBA, $0084, $008C

room_4C_colliders: ;4D94
	db $04
	dw $FF9E, $FF78, $0100, $004A
	dw $FF80, $FFDA, $00E2, $00A8
	dw $FF80, $0076, $0088, $0040
	dw $005E, $000C, $0016, $004C

room_4D_colliders: ;4DB5
	db $03
	dw $FFE0, $FFD0, $0008, $0040
	dw $000A, $FFD0, $0016, $0036
	dw $0014, $0018, $000C, $0018

room_4E_colliders: ;4DCE
	db $05
	dw $FF80, $FF80, $004E, $0016
	dw $FF80, $002A, $0016, $005C
	dw $001A, $FFCA, $0030, $005C
	dw $FF80, $FFFE, $004E, $0038
	dw $FFBA, $FFCA, $0014, $0040

room_4F_colliders: ;4DF7
	db $04
	dw $FFA0, $FF60, $00A6, $008C
	dw $FFA0, $FFE2, $00A6, $0082
	dw $0046, $FF60, $001E, $0044
	dw $005A, $FFB8, $0028, $00C8

room_50_colliders: ;4E18
	db $04
	dw $FFD0, $FFC8, $001C, $002A
	dw $0028, $FFEA, $0020, $0010
	dw $0008, $FFC8, $0040, $001C
	dw $FFCE, $FFFA, $0058, $0056

room_51_colliders: ;4E39
	db $03
	dw $FFE0, $FFE0, $0020, $0018
	dw $000A, $FFE0, $0016, $0012
	dw $0010, $000C, $0010, $0014

room_52_colliders: ;4E52
	db $03
	dw $FF80, $FFB0, $0036, $009E
	dw $FFB0, $FFB0, $004E, $006E
	dw $0012, $FFB0, $0080, $00AE

room_53_colliders: ;4E6B
	db $03
	dw $0014, $FFE8, $0014, $0030
	dw $FFD8, $000C, $002C, $000C
	dw $FFE8, $FFE8, $001D, $0010

room_54_colliders: ;4E84
	db $04
	dw $FFD0, $FFC8, $0018, $002A
	dw $FFCE, $FFFA, $0058, $0056
	dw $002C, $FFEA, $0020, $0010
	dw $FFE0, $FFE4, $0040, $001C

room_55_colliders: ;4EA5
	db $03
	dw $FFE0, $FFE0, $0020, $0020
	dw $000A, $FFE0, $0016, $0012
	dw $0010, $000C, $0010, $0014

room_56_colliders: ;4EBE
	db $01
	dw $FFE4, $004A, $0038, $0016

room_57_colliders: ;4EC7
	db $02
	dw $FFD8, $FFE8, $0050, $0010
	dw $FFD8, $0006, $0030, $0014

room_58_colliders: ;4ED8
	db $02
	dw $0032, $FFD8, $000E, $0010
	dw $FFD0, $FFE4, $0054, $001E

room_59_colliders: ;4EE9
	db $04
	dw $FF80, $FFA2, $002E, $0100
	dw $FFA2, $FFF2, $005C, $0100
	dw $FFCA, $FF80, $0100, $0056
	dw $001A, $FF80, $0100, $00DE

room_5A_colliders: ;4F0A
	db $02
	dw $FFC0, $002A, $005E, $002E
	dw $FFC0, $0022, $0024, $000E

room_5B_colliders: ;4F1B
	db $01
	dw $000E, $FFF4, $0018, $0024

room_5C_colliders: ;4F24
	db $03
	dw $FF80, $FFCA, $0066, $0100
	dw $0016, $FFB8, $006A, $0060
	dw $FFF8, $FFCE, $0068, $004A

room_5D_colliders: ;4F3D
	db $04
	dw $FFEE, $FFD6, $0024, $0054
	dw $FFD0, $FFF4, $000C, $0018
	dw $0024, $FFC0, $000C, $0026
	dw $0024, $0018, $000C, $0018

room_5E_colliders: ;4F5E
	db $03
	dw $FFA8, $FF80, $00B6, $001E
	dw $FFB2, $FFBA, $0054, $0074
	dw $FFFA, $FFBA, $0064, $00A4

room_5F_colliders: ;4F77
	db $03
	dw $FFC2, $FFE0, $0018, $0018
	dw $FFF8, $FFD8, $0048, $000E
	dw $FFE4, $FFF0, $003C, $0020

room_60_colliders: ;4F90
	db $06
	dw $FF80, $FFA8, $008E, $0016
	dw $FF80, $FFF8, $0056, $0028
	dw $FF80, $FFB8, $0068, $0028
	dw $FF80, $FFEC, $0018, $0018
	dw $FFF4, $FFD6, $000C, $0018
	dw $FFFA, $FFA8, $0014, $0078

room_61_colliders: ;4FC1
	db $00

room_62_colliders: ;4FC2
	db $03
	dw $FFEE, $FFFA, $0018, $0026
	dw $0000, $FFC8, $0038, $0010
	dw $0016, $0010, $0028, $0018

room_63_colliders: ;4FDB
	db $03
	dw $FFD4, $0026, $0028, $0012
	dw $001E, $FFE2, $000F, $0012
	dw $001C, $FFFA, $0011, $0014

room_64_colliders: ;4FF4
	db $01
	dw $FFE2, $FFE2, $0100, $0100

room_65_colliders: ;4FFD
	db $03
	dw $FF60, $FF80, $0096, $0068
	dw $000A, $FF80, $0096, $0068
	dw $FF60, $0002, $0100, $0020

room_66_colliders: ;5016
	db $00

room_67_colliders: ;5017
	db $05
	dw $FFD8, $FFD0, $001A, $001A
	dw $FFD8, $FFE8, $0014, $0028
	dw $FFD8, $000E, $0010, $0020
	dw $FFD8, $001E, $0034, $0018
	dw $0000, $0022, $0034, $0018

room_68_colliders: ;5040
	db $05
	dw $FF90, $FFBE, $0022, $009C
	dw $FF90, $0000, $0010, $0080
	dw $FFC2, $FFBE, $0060, $00F0
	dw $0032, $003E, $0060, $0060
	dw $0032, $FFBE, $0028, $0068

room_69_colliders: ;5069
	db $07
	dw $FF80, $FFB0, $00E6, $004A
	dw $FF80, $FFB0, $0046, $0086
	dw $FFDA, $0006, $008C, $0030
	dw $FF80, $004A, $00C0, $0030
	dw $0038, $0030, $0010, $0040
	dw $0046, $002E, $0020, $001A
	dw $0040, $0052, $001E, $0018

room_6A_colliders: ;50A2
	db $01
	dw $FFA8, $FFD8, $00AC, $0050

room_6B_colliders: ;50AB
	db $00

room_6C_colliders: ;50AC
	db $01
	dw $FFC2, $FFFA, $0100, $0100

room_6D_colliders: ;50B5
	db $03
	dw $FFD8, $FFD8, $001E, $002E
	dw $0012, $FFD8, $0016, $0010
	dw $0018, $FFE8, $0010, $000C

room_6E_colliders: ;50CE
	db $02
	dw $FFCA, $FFBA, $006C, $0084
	dw $FFA0, $FF70, $002E, $0036

room_6F_colliders: ;50DF
	db $01
	dw $FF80, $FFFA, $00C6, $000C

room_70_colliders: ;50E8
	db $00

room_71_colliders: ;50E9
	db $01
	dw $0000, $FFE8, $0020, $0014

room_72_colliders: ;50F2
	db $00

room_73_colliders: ;50F3
	db $05
	dw $FFC8, $FFC4, $00E2, $0024
	dw $FFBA, $FFC4, $0014, $001E
	dw $003A, $FFC4, $0038, $004A
	dw $0066, $FFC4, $0020, $0026
	dw $FFC4, $FFEC, $0062, $0030
