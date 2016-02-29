;room boundaries
;8 bytes per room, divide by 4 16bit sign coordenates (low-high)
;lXhX|-lXhX|lYhY|-lYhY

room00_boundaries: ;4000
	dw $FF86 ; left
	dw $007A ; right
	dw $FF86 ; top
	dw $0062 ; bottom

room01_boundaries: ;4008
	dw $FF8E
	dw $0072
	dw $FFD6
	dw $002A

room02_boundaries: ;4010
	dw $FFE6
	dw $001A
	dw $FFE6
	dw $002A

room03_boundaries: ;4018
	dw $FF92
	dw $006E
	dw $FF88
	dw $0078

room04_boundaries: ;4020
	dw $FFD6
	dw $005A
	dw $FFBE
	dw $00A2

room05_boundaries: ;4028
	dw $FF86
	dw $008A
	dw $FFFA
	dw $0036

room06_boundaries: ;4030
	dw $FFA6
	dw $001A
	dw $FFE4
	dw $002A

room07_boundaries: ;4038
	dw $FF80
	dw $003A
	dw $FF9E
	dw $003A

room08_boundaries: ;4040
	dw $FFD8
	dw $007A
	dw $FFA6
	dw $0072

room09_boundaries: ;4048
	dw $FFE6
	dw $0014
	dw $FFE6
	dw $001A

room0A_boundaries: ;4050
	dw $FFB2
	dw $003E
	dw $FFAA
	dw $009E

room0B_boundaries: ;4058
	dw $FFBE
	dw $0042
	dw $FFF5
	dw $003A

room0C_boundaries: ;4060
	dw $FFB6
	dw $004A
	dw $FFA2
	dw $004A

room0D_boundaries: ;4068
	dw $FFE6
	dw $007A
	dw $FFD6
	dw $002A

room0E_boundaries: ;4070
	dw $FFC6
	dw $003A
	dw $FFE6
	dw $001A

room0F_boundaries: ;4078
	dw $FFC6
	dw $003A
	dw $FFE6
	dw $0040

room10_boundaries: ;4080
	dw $FFC6
	dw $001A
	dw $FFA6
	dw $0062

room11_boundaries: ;4088
	dw $FFD6
	dw $002A
	dw $FFF2
	dw $002A

room12_boundaries: ;4090
	dw $FFD6
	dw $005A
	dw $FFC6
	dw $004A

room13_boundaries: ;4098
	dw $FFDE
	dw $0012
	dw $FF86
	dw $005A

room14_boundaries: ;40A0
	dw $FFF2
	dw $000E
	dw $FFF6
	dw $000A

room15_boundaries: ;40A8
	dw $FFE6
	dw $001A
	dw $FFFF
	dw $000A

room16_boundaries: ;40B0
	dw $FFE6
	dw $001A
	dw $FFE6
	dw $001A

room17_boundaries: ;40B8
	dw $FFD6
	dw $002A
	dw $FFD6
	dw $002A

room18_boundaries: ;40C0
	dw $FFDE
	dw $0022
	dw $FFDE
	dw $0022

room19_boundaries: ;40C8
	dw $FFE6
	dw $001A
	dw $FFE6
	dw $001A

room1A_boundaries: ;40D0
	dw $FF8E
	dw $003A
	dw $FFCA
	dw $002E

room1B_boundaries: ;40D8
	dw $FF76
	dw $007A
	dw $FFCA
	dw $002E

room1C_boundaries: ;40E0
	dw $FF86
	dw $007A
	dw $FFD6
	dw $002A

room1D_boundaries: ;40E8
	dw $FF86
	dw $007A
	dw $FF86
	dw $0062

room1E_boundaries: ;40F0
	dw $FFC6
	dw $003A
	dw $FFC6
	dw $003A

room1F_boundaries: ;40F8
	dw $FFE6
	dw $001A
	dw $FFE6
	dw $001A

room20_boundaries: ;4100
	dw $FFA6
	dw $0042
	dw $FF5E
	dw $001E

room21_boundaries: ;4108
	dw $FFD6
	dw $003A
	dw $FFFA
	dw $0006

room22_boundaries: ;4110
	dw $FFD6
	dw $002A
	dw $FFDE
	dw $0042

room23_boundaries: ;4118
	dw $FFC6
	dw $003A
	dw $FFEE
	dw $0012

room24_boundaries: ;4120
	dw $FF6C
	dw $0012
	dw $FF86
	dw $006A

room25_boundaries: ;4128
	dw $FF86
	dw $0042
	dw $FFC6
	dw $007A

room26_boundaries: ;4130
	dw $FFDE
	dw $0022
	dw $FFDE
	dw $0022

room27_boundaries: ;4138
	dw $FFA6
	dw $005A
	dw $FFA6
	dw $005A

room28_boundaries: ;4140
	dw $FFD6
	dw $0032
	dw $FFC6
	dw $003A

room29_boundaries: ;4148
	dw $FFE2
	dw $001E
	dw $FFE2
	dw $001E

room2A_boundaries: ;4150
	dw $FFF6
	dw $000A
	dw $FFD6
	dw $002A

room2B_boundaries: ;4158
	dw $FFDE
	dw $0022
	dw $FFAE
	dw $005A

room2C_boundaries: ;4160
	dw $FFCE
	dw $001A
	dw $FF96
	dw $003A

room2D_boundaries: ;4168
	dw $FFA6
	dw $0012
	dw $FFD6
	dw $002A

room2E_boundaries: ;4170
	dw $FFEE
	dw $0012
	dw $FFCE
	dw $0022

room2F_boundaries: ;4178
	dw $FFC6
	dw $0036
	dw $FFE6
	dw $001A

room30_boundaries: ;4180
	dw $FFE2
	dw $001E
	dw $FFDE
	dw $0022

room31_boundaries: ;4188
	dw $FFE6
	dw $005E
	dw $FFAE
	dw $002A

room32_boundaries: ;4190
	dw $FFF6
	dw $003A
	dw $FFB6
	dw $001A

room33_boundaries: ;4198
	dw $FFF6
	dw $000A
	dw $FFE6
	dw $001A

room34_boundaries: ;41A0
	dw $FFDE
	dw $0022
	dw $FFDE
	dw $0022

room35_boundaries: ;41A8
	dw $FFC6
	dw $0062
	dw $FF86
	dw $005A

room36_boundaries: ;41B0
	dw $FF86
	dw $007A
	dw $FF76
	dw $009A

room37_boundaries: ;41B8
	dw $FF9E
	dw $0082
	dw $FF7E
	dw $007A

room38_boundaries: ;41C0
	dw $FFA6
	dw $005A
	dw $FFA6
	dw $005A

room39_boundaries: ;41C8
	dw $FF86
	dw $007A
	dw $FF86
	dw $007A

room3A_boundaries: ;41D0
	dw $FF90
	dw $0080
	dw $FF86
	dw $0092

room3B_boundaries: ;41D8
	dw $FFE6
	dw $001A
	dw $FFE6
	dw $001A

room3C_boundaries: ;41E0
	dw $FFC6
	dw $004A
	dw $FFA6
	dw $005A

room3D_boundaries: ;41E8
	dw $FF86
	dw $0058
	dw $FFC6
	dw $003A

room3E_boundaries: ;41F0
	dw $FF86
	dw $007A
	dw $FFA6
	dw $007A

room3F_boundaries: ;41F8
	dw $FFBE
	dw $0042
	dw $FFA6
	dw $006A

room40_boundaries: ;4200
	dw $FFE6
	dw $001A
	dw $FFE6
	dw $001A

room41_boundaries: ;4208
	dw $FFAE
	dw $009A
	dw $FFAE
	dw $007A

room42_boundaries: ;4210
	dw $FFC6
	dw $0062
	dw $FF86
	dw $005A

room43_boundaries: ;4218
	dw $FFDE
	dw $002A
	dw $FF86
	dw $007A

room44_boundaries: ;4220
	dw $FF8E
	dw $007A
	dw $FF86
	dw $0052

room45_boundaries: ;4228
	dw $FFD6
	dw $002A
	dw $FFC6
	dw $003A

room46_boundaries: ;4230
	dw $FF76
	dw $007A
	dw $FFF2
	dw $000E

room47_boundaries: ;4238
	dw $FF86
	dw $004A
	dw $FF86
	dw $0012

room48_boundaries: ;4240
	dw $FFCE
	dw $0032
	dw $FFCE
	dw $004A

room49_boundaries: ;4248
	dw $FFE6
	dw $001A
	dw $FFEC
	dw $001A

room4A_boundaries: ;4250
	dw $FFD6
	dw $002A
	dw $FFD6
	dw $002A

room4B_boundaries: ;4258
	dw $FF86
	dw $007A
	dw $FF86
	dw $007A

room4C_boundaries: ;4260
	dw $FF86
	dw $007A
	dw $FF7E
	dw $009A

room4D_boundaries: ;4268
	dw $FFE6
	dw $001A
	dw $FFD6
	dw $002A

room4E_boundaries: ;4270
	dw $FF86
	dw $0022
	dw $FF86
	dw $007A

room4F_boundaries: ;4278
	dw $FFA6
	dw $006E
	dw $FF66
	dw $007A

room50_boundaries: ;4280
	dw $FFD6
	dw $0032
	dw $FFCE
	dw $004A

room51_boundaries: ;4288
	dw $FFE6
	dw $001A
	dw $FFEC
	dw $001A

room52_boundaries: ;4290
	dw $FF86
	dw $0074
	dw $FFC0
	dw $007A

room53_boundaries: ;4298
	dw $FFDE
	dw $0022
	dw $FFEE
	dw $0012

room54_boundaries: ;42A0
	dw $FFD6
	dw $0032
	dw $FFCE
	dw $004A

room55_boundaries: ;42A8
	dw $FFE6
	dw $001A
	dw $FFEC
	dw $001A

room56_boundaries: ;42B0
	dw $FFA6
	dw $005A
	dw $FFA6
	dw $005A

room57_boundaries: ;42B8
	dw $FFE4
	dw $0022
	dw $FFEE
	dw $0012

room58_boundaries: ;42C0
	dw $FFC6
	dw $003A
	dw $FFDE
	dw $0022

room59_boundaries: ;42C8
	dw $FF86
	dw $007A
	dw $FF86
	dw $007A

room5A_boundaries: ;42D0
	dw $FFC6
	dw $002A
	dw $FFD6
	dw $0052

room5B_boundaries: ;42D8
	dw $FFE6
	dw $001A
	dw $FFD6
	dw $002A

room5C_boundaries: ;42E0
	dw $FF86
	dw $007A
	dw $FFBE
	dw $003A

room5D_boundaries: ;42E8
	dw $FFD6
	dw $002A
	dw $FFC6
	dw $003A

room5E_boundaries: ;42F0
	dw $FF86
	dw $007A
	dw $FF86
	dw $007A

room5F_boundaries: ;42F8
	dw $FFB6
	dw $003A
	dw $FFDE
	dw $001A

room60_boundaries: ;4300
	dw $FF86
	dw $005A
	dw $FFAE
	dw $001A

room61_boundaries: ;4308
	dw $FFA6
	dw $005A
	dw $FFF4
	dw $000C

room62_boundaries: ;4310
	dw $FFCE
	dw $0032
	dw $FFCE
	dw $001A

room63_boundaries: ;4318
	dw $FFDA
	dw $0026
	dw $FFCE
	dw $0032

room64_boundaries: ;4320
	dw $FFC6
	dw $003A
	dw $FFC6
	dw $0072

room65_boundaries: ;4328
	dw $FF66
	dw $0082
	dw $FF86
	dw $001A

room66_boundaries: ;4330
	dw $FFF2
	dw $000E
	dw $FFF2
	dw $000E

room67_boundaries: ;4338
	dw $FFE0
	dw $0020
	dw $FFD8
	dw $0028

room68_boundaries: ;4340
	dw $FF96
	dw $006A
	dw $FFA6
	dw $0072

room69_boundaries: ;4348
	dw $FFB0
	dw $0076
	dw $FFB6
	dw $005A

room6A_boundaries: ;4350
	dw $FF8E
	dw $0072
	dw $FFC6
	dw $0034

room6B_boundaries: ;4358
	dw $FFF2
	dw $000E
	dw $FFF2
	dw $000E

room6C_boundaries: ;4360
	dw $FFA6
	dw $005A
	dw $FFC6
	dw $003A

room6D_boundaries: ;4368
	dw $FFE0
	dw $0020
	dw $FFE0
	dw $0020

room6E_boundaries: ;4370
	dw $FFA6
	dw $005A
	dw $FF76
	dw $006A

room6F_boundaries: ;4378
	dw $FF86
	dw $005A
	dw $FFD6
	dw $002A

room70_boundaries: ;4380
	dw $FFE2
	dw $001E
	dw $FFE2
	dw $001E

room71_boundaries: ;4388
	dw $FFF0
	dw $0010
	dw $FFEE
	dw $001A

room72_boundaries: ;4390
	dw $FF86
	dw $007A
	dw $FF86
	dw $007A

room73_boundaries: ;4398
	dw $FFAC
	dw $007A
	dw $FFCE
	dw $0022

