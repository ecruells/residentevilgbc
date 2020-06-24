; Rooms collision boxes
; each collider rect is formed by 4 signed words
; 
; byte header: collision boxes count
; collision box rect words:
;  - word1: rect x
;  - word2: rect z
;  - word3: rect width
;  - word4: rect height

room_00_colliders:
	db 18
	dw -128, 64, 16, 24
	dw -92, 64, 24, 24
	dw -42, 64, 26, 24
	dw -33, -8, 65, 96
	dw 20, 64, 24, 24
	dw 68, 64, 24, 24
	dw 112, 64, 16, 24
	dw 15, -8, 24, 24
	dw -120, -104, 22, 20
	dw -120, -64, 22, 20
	dw -120, -24, 22, 20
	dw -120, 20, 22, 20
	dw -76, -16, 22, 20
	dw 98, -104, 22, 20
	dw 98, -64, 22, 20
	dw 98, -24, 22, 20
	dw 98, 20, 22, 20
	dw 54, -16, 22, 20

room_01_colliders:
	db 9
	dw -120, -48, 12, 12
	dw -120, 36, 12, 12
	dw -102, -34, 12, 14
	dw -102, 22, 12, 14
	dw 100, -32, 12, 14
	dw 100, 20, 12, 14
	dw 108, -48, 12, 12
	dw 108, 36, 12, 12
	dw 24, -48, 20, 12

room_02_colliders:
	db 4
	dw -32, -32, 24, 16
	dw -10, -32, 42, 20
	dw 20, -10, 12, 38
	dw 8, 32, 24, 16

room_03_colliders:
	db 5
	dw -38, -128, 158, 30
	dw -98, -86, 196, 92
	dw -98, 18, 196, 116
	dw 92, -38, 30, 172
	dw -50, -6, 172, 36

room_04_colliders:
	db 8
	dw 42, -72, 54, 144
	dw -48, 70, 54, 100
	dw 0, 70, 16, 12
	dw 24, 70, 24, 12
	dw 44, 70, 8, 80
	dw 48, 70, 16, 40
	dw 80, 70, 16, 40
	dw -14, -12, 28, 18

room_05_colliders:
	db 3
	dw 96, 20, 16, 40
	dw 96, 44, 42, 16
	dw -128, 8, 232, 52

room_06_colliders:
	db 3
	dw -6, -16, 26, 44
	dw -22, -36, 54, 16
	dw -96, 4, 30, 44

room_07_colliders:
	db 10
	dw -70, -24, 12, 24
	dw -70, 8, 12, 24
	dw -64, -104, 12, 38
	dw -48, -72, 12, 14
	dw -54, -60, 64, 60
	dw -38, -104, 68, 46
	dw 20, -104, 50, 30
	dw -54, 42, 118, 22
	dw -144, -104, 86, 94
	dw -144, 18, 86, 46

room_08_colliders:
	db 4
	dw -6, -62, 140, 124
	dw 74, 50, 60, 76
	dw -32, 88, 72, 32
	dw -38, -18, 28, 28

room_09_colliders:
	db 2
	dw -32, 20, 36, 12
	dw -4, -32, 36, 8

room_0A_colliders:
	db 5
	dw -84, -92, 62, 70
	dw 14, -92, 60, 46
	dw -2, 70, 76, 100
	dw -26, -34, 76, 92
	dw -84, -34, 70, 156

room_0B_colliders:
	db 1
	dw -72, 12, 134, 64

room_0C_colliders:
	db 3
	dw -74, 32, 68, 24
	dw 24, 32, 32, 24
	dw -80, -100, 126, 146

room_0D_colliders:
	db 2
	dw 26, -48, 112, 70
	dw -34, -48, 34, 84

room_0E_colliders:
	db 4
	dw 40, -32, 26, 14
	dw -10, -22, 20, 54
	dw -64, -22, 16, 44
	dw -64, 20, 64, 12

room_0F_colliders:
	db 2
	dw -46, -14, 92, 70
	dw -46, 26, 116, 70

room_10_colliders:
	db 6
	dw -54, -96, 86, 118
	dw -54, 34, 28, 70
	dw -16, 16, 32, 16
	dw -12, 48, 24, 20
	dw -64, 80, 16, 32
	dw 14, 30, 18, 38

room_11_colliders:
	db 5
	dw 14, 11, 18, 24
	dw 6, 24, 42, 12
	dw -22, 32, 70, 16
	dw -48, -20, 24, 12
	dw -26, -20, 74, 20

room_12_colliders:
	db 2
	dw -14, -64, 110, 110
	dw 20, 40, 76, 20

room_13_colliders:
	db 1
	dw -14, -102, 40, 200

room_14_colliders:
	db 0

room_15_colliders:
	db 1
	dw -32, 2, 40, 14

room_16_colliders:
	db 3
	dw -32, -32, 14, 10
	dw 18, -32, 14, 16
	dw -32, 12, 10, 20

room_17_colliders:
	db 2
	dw -48, -38, 10, 52
	dw 26, -30, 22, 38

room_18_colliders:
	db 5
	dw -16, -40, 32, 12
	dw 28, -40, 12, 12
	dw -40, 28, 12, 12
	dw -3, -16, 20, 32
	dw -28, -16, 21, 32

room_19_colliders:
	db 0

room_1A_colliders:
	db 2
	dw -120, -60, 106, 86
	dw 6, -34, 106, 60

room_1B_colliders:
	db 3
	dw -144, -60, 178, 86
	dw 54, -34, 128, 60
	dw 102, -60, 32, 36

room_1C_colliders:
	db 1
	dw -120, -38, 240, 76

room_1D_colliders:
	db 2
	dw -112, -128, 232, 130
	dw -80, 20, 160, 72

room_1E_colliders:
	db 3
	dw -64, -64, 110, 70
	dw -64, -64, 70, 110
	dw 16, 20, 24, 24

room_1F_colliders:
	db 1
	dw -12, -32, 32, 16

room_20_colliders:
	db 4
	dw -96, -2, 78, 32
	dw -6, -54, 62, 72
	dw -96, -168, 126, 154
	dw 24, -168, 30, 100

room_21_colliders:
	db 0

room_22_colliders:
	db 6
	dw -24, -20, 40, 30
	dw 30, -40, 18, 14
	dw -48, 34, 16, 40
	dw -48, 34, 46, 12
	dw 4, 34, 12, 12
	dw 10, 34, 40, 40

room_23_colliders:
	db 1
	dw -64, -24, 14, 48

room_24_colliders:
	db 3
	dw -46, -110, 70, 204
	dw -154, 34, 96, 94
	dw -154, -128, 96, 150

room_25_colliders:
	db 3
	dw -128, -46, 110, 256
	dw -128, 82, 142, 128
	dw -6, -64, 128, 136

room_26_colliders:
	db 2
	dw -30, -40, 74, 46
	dw 8, 26, 32, 14

room_27_colliders:
	db 1
	dw -96, -70, 166, 140

room_28_colliders:
	db 5
	dw -24, -52, 24, 32
	dw -48, -64, 66, 16
	dw -48, -64, 16, 76
	dw 12, 46, 64, 20
	dw 12, 2, 64, 24

room_29_colliders:
	db 1
	dw 18, -36, 26, 28

room_2A_colliders:
	db 1
	dw -9, -26, 18, 26

room_2B_colliders:
	db 4
	dw -40, -88, 20, 28
	dw 8, -88, 40, 16
	dw -40, -20, 16, 44
	dw 16, -78, 32, 32

room_2C_colliders:
	db 10
	dw -56, -112, 30, 94
	dw -56, 34, 30, 30
	dw 16, -76, 24, 44
	dw 14, 46, 24, 24
	dw -6, -12, 24, 24
	dw 18, -112, 16, 20
	dw -12, 4, 16, 16
	dw -42, 4, 16, 16
	dw -14, -100, 20, 52
	dw -32, -72, 38, 24

room_2D_colliders:
	db 2
	dw -96, -48, 102, 36
	dw -96, -5, 102, 54

room_2E_colliders:
	db 0

room_2F_colliders:
	db 4
	dw -64, -32, 28, 22
	dw -44, -32, 24, 16
	dw -34, 16, 36, 16
	dw -6, -14, 70, 54

room_30_colliders:
	db 4
	dw -14, -40, 28, 8
	dw -36, -40, 12, 40
	dw -15, -20, 20, 20
	dw -2, -6, 20, 20

room_31_colliders:
	db 8
	dw -32, -88, 30, 46
	dw -32, 32, 20, 16
	dw 8, -88, 108, 12
	dw 26, -62, 28, 92
	dw 66, -62, 40, 28
	dw 66, 2, 40, 28
	dw 84, -62, 40, 92
	dw 74, -20, 16, 18

room_32_colliders:
	db 4
	dw 10, -36, 28, 48
	dw 10, 18, 28, 16
	dw 26, -60, 40, 18
	dw 46, -80, 32, 32

room_33_colliders:
	db 1
	dw -16, -32, 32, 16

room_34_colliders:
	db 2
	dw -12, -12, 24, 24
	dw 6, 24, 34, 16

room_35_colliders:
	db 5
	dw -64, -110, 46, 214
	dw -6, -128, 128, 54
	dw -24, -60, 102, 8
	dw -6, -60, 84, 32
	dw -6, -14, 128, 128

room_36_colliders:
	db 5
	dw -128, -144, 134, 86
	dw -128, -70, 180, 116
	dw 100, -70, 28, 116
	dw 19, -124, 94, 34
	dw -128, 74, 214, 86

room_37_colliders:
	db 7
	dw -104, -136, 110, 46
	dw -104, 58, 206, 70
	dw -70, -62, 76, 128
	dw -104, 18, 46, 64
	dw 34, -102, 68, 60
	dw 26, -42, 76, 80
	dw -6, -62, 52, 36

room_38_colliders:
	db 4
	dw -66, -96, 60, 54
	dw 6, -96, 60, 54
	dw -96, -6, 54, 102
	dw 42, -6, 54, 102

room_39_colliders:
	db 1
	dw -128, 64, 56, 64

room_3A_colliders:
	db 3
	dw -120, 26, 206, 160
	dw -86, -128, 246, 126
	dw 114, -128, 40, 246

room_3B_colliders:
	db 0

room_3C_colliders:
	db 3
	dw -22, -96, 36, 150
	dw -22, -96, 128, 70
	dw -22, 40, 82, 14

room_3D_colliders:
	db 4
	dw -128, -64, 142, 24
	dw 42, -64, 64, 26
	dw -110, -6, 172, 70
	dw -128, 2, 32, 62

room_3E_colliders:
	db 8
	dw -128, -60, 102, 188
	dw -38, 2, 52, 124
	dw 2, -60, 60, 124
	dw 2, -60, 76, 52
	dw 90, -60, 48, 52
	dw 102, -22, 32, 64
	dw 76, 30, 72, 200
	dw 40, -22, 22, 200

room_3F_colliders:
	db 1
	dw -38, -62, 76, 200

room_40_colliders:
	db 2
	dw -32, -32, 24, 10
	dw -14, -20, 28, 40

room_41_colliders:
	db 3
	dw -88, -30, 62, 192
	dw 2, -88, 192, 30
	dw 2, -30, 124, 124

room_42_colliders:
	db 0

room_43_colliders:
	db 3
	dw -40, -128, 46, 114
	dw -40, 14, 46, 114
	dw 34, -94, 16, 255

room_44_colliders:
	db 8
	dw -120, -128, 30, 182
	dw -66, -98, 52, 52
	dw -96, -22, 78, 76
	dw 10, -128, 36, 56
	dw 10, -52, 36, 160
	dw 34, -128, 76, 40
	dw 34, -40, 76, 40
	dw 90, -100, 32, 80

room_45_colliders:
	db 0

room_46_colliders:
	db 0

room_47_colliders:
	db 5
	dw -102, -128, 240, 46
	dw 26, -62, 64, 92
	dw -102, -62, 108, 92
	dw -128, -46, 38, 92
	dw -128, -128, 14, 28

room_48_colliders:
	db 5
	dw -50, -6, 88, 86
	dw -50, -56, 24, 16
	dw -50, -56, 20, 56
	dw 40, -20, 32, 16
	dw 8, -56, 64, 28

room_49_colliders:
	db 4
	dw -32, -32, 32, 24
	dw 10, -32, 22, 18
	dw 22, -12, 10, 10
	dw 14, 20, 18, 12

room_4A_colliders:
	db 4
	dw -28, -48, 36, 22
	dw 10, -48, 48, 44
	dw 28, -8, 20, 56
	dw -36, 32, 50, 24

room_4B_colliders:
	db 1
	dw -94, -70, 132, 140

room_4C_colliders:
	db 4
	dw -98, -136, 256, 74
	dw -128, -38, 226, 168
	dw -128, 118, 136, 64
	dw 94, 12, 22, 76

room_4D_colliders:
	db 3
	dw -32, -48, 8, 64
	dw 10, -48, 22, 54
	dw 20, 24, 12, 24

room_4E_colliders:
	db 5
	dw -128, -128, 78, 22
	dw -128, 42, 22, 92
	dw 26, -54, 48, 92
	dw -128, -2, 78, 56
	dw -70, -54, 20, 64

room_4F_colliders:
	db 4
	dw -96, -160, 166, 140
	dw -96, -30, 166, 130
	dw 70, -160, 30, 68
	dw 90, -72, 40, 200

room_50_colliders:
	db 4
	dw -48, -56, 28, 42
	dw 40, -22, 32, 16
	dw 8, -56, 64, 28
	dw -50, -6, 88, 86

room_51_colliders:
	db 3
	dw -32, -32, 32, 24
	dw 10, -32, 22, 18
	dw 16, 12, 16, 20

room_52_colliders:
	db 3
	dw -128, -80, 54, 158
	dw -80, -80, 78, 110
	dw 18, -80, 128, 174

room_53_colliders:
	db 3
	dw 20, -24, 20, 48
	dw -40, 12, 44, 12
	dw -24, -24, 29, 16

room_54_colliders:
	db 4
	dw -48, -56, 24, 42
	dw -50, -6, 88, 86
	dw 44, -22, 32, 16
	dw -32, -28, 64, 28

room_55_colliders:
	db 3
	dw -32, -32, 32, 32
	dw 10, -32, 22, 18
	dw 16, 12, 16, 20

room_56_colliders:
	db 1
	dw -28, 74, 56, 22

room_57_colliders:
	db 2
	dw -40, -24, 80, 16
	dw -40, 6, 48, 20

room_58_colliders:
	db 2
	dw 50, -40, 14, 16
	dw -48, -28, 84, 30

room_59_colliders:
	db 4
	dw -128, -94, 46, 256
	dw -94, -14, 92, 256
	dw -54, -128, 256, 86
	dw 26, -128, 256, 222

room_5A_colliders:
	db 2
	dw -64, 42, 94, 46
	dw -64, 34, 36, 14

room_5B_colliders:
	db 1
	dw 14, -12, 24, 36

room_5C_colliders:
	db 3
	dw -128, -54, 102, 256
	dw 22, -72, 106, 96
	dw -8, -50, 104, 74

room_5D_colliders:
	db 4
	dw -18, -42, 36, 84
	dw -48, -12, 12, 24
	dw 36, -64, 12, 38
	dw 36, 24, 12, 24

room_5E_colliders:
	db 3
	dw -88, -128, 182, 30
	dw -78, -70, 84, 116
	dw -6, -70, 100, 164

room_5F_colliders:
	db 3
	dw -62, -32, 24, 24
	dw -8, -40, 72, 14
	dw -28, -16, 60, 32

room_60_colliders:
	db 6
	dw -128, -88, 142, 22
	dw -128, -8, 86, 40
	dw -128, -72, 104, 40
	dw -128, -20, 24, 24
	dw -12, -42, 12, 24
	dw -6, -88, 20, 120

room_61_colliders:
	db 0

room_62_colliders:
	db 3
	dw -18, -6, 24, 38
	dw 0, -56, 56, 16
	dw 22, 16, 40, 24

room_63_colliders:
	db 3
	dw -44, 38, 40, 18
	dw 30, -30, 15, 18
	dw 28, -6, 17, 20

room_64_colliders:
	db 1
	dw -30, -30, 256, 256

room_65_colliders:
	db 3
	dw -160, -128, 150, 104
	dw 10, -128, 150, 104
	dw -160, 2, 256, 32

room_66_colliders:
	db 0

room_67_colliders:
	db 5
	dw -40, -48, 26, 26
	dw -40, -24, 20, 40
	dw -40, 14, 16, 32
	dw -40, 30, 52, 24
	dw 0, 34, 52, 24

room_68_colliders:
	db 5
	dw -112, -66, 34, 156
	dw -112, 0, 16, 128
	dw -62, -66, 96, 240
	dw 50, 62, 96, 96
	dw 50, -66, 40, 104

room_69_colliders:
	db 7
	dw -128, -80, 230, 74
	dw -128, -80, 70, 134
	dw -38, 6, 140, 48
	dw -128, 74, 192, 48
	dw 56, 48, 16, 64
	dw 70, 46, 32, 26
	dw 64, 82, 30, 24

room_6A_colliders:
	db 1
	dw -88, -40, 172, 80

room_6B_colliders:
	db 0

room_6C_colliders:
	db 1
	dw -62, -6, 256, 256

room_6D_colliders:
	db 3
	dw -40, -40, 30, 46
	dw 18, -40, 22, 16
	dw 24, -24, 16, 12

room_6E_colliders:
	db 2
	dw -54, -70, 108, 132
	dw -96, -144, 46, 54

room_6F_colliders:
	db 1
	dw -128, -6, 198, 12

room_70_colliders:
	db 0

room_71_colliders:
	db 1
	dw 0, -24, 32, 20

room_72_colliders:
	db 0

room_73_colliders:
	db 5
	dw -56, -60, 226, 36
	dw -70, -60, 20, 30
	dw 58, -60, 56, 74
	dw 102, -60, 32, 38
	dw -60, -20, 98, 48

