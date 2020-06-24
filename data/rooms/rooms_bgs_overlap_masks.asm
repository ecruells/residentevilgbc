; rooms backgrounds overlaps masks
; byte1: Y-sort overlap trigger
; byte2: mask x position (unused, submask x-pos is used instead)
; byte3: unused value
; byte4: mask y position
; byte5: mask height
; byte6: submasks count
; bytes7-8-9...: submasks
;
; submask struct:
;   byte1: x position
;   word2: mask data pointer 

Room01_00_overlapMaskA:
	db 52, 48, 16, 56, 40
	db 2
	dbw 48, room01_00_olmask_A1
	dbw 56, room01_00_olmask_A2

Room01_00_overlapMaskB:
	db 50, 112, 24, 56, 48
	db 3
	dbw 112, room01_00_olmask_B1
	dbw 120, room01_00_olmask_B2
	dbw 128, room01_00_olmask_B3

Room01_02_overlapMaskA:
	db 61, 48, 16, 72, 40
	db 2
	dbw 48, room01_02_olmask_A1
	dbw 56, room01_02_olmask_A2

Room01_02_overlapMaskB:
	db 66, 96, 16, 72, 40
	db 2
	dbw 96, room01_02_olmask_B1
	dbw 104, room01_02_olmask_B2

Room04_00_overlapMaskA:
	db 1, 40, 40, 32, 112
	db 5
	dbw 40, room04_00_olmask_A1
	dbw 48, room04_00_olmask_A2
	dbw 56, room04_00_olmask_A3
	dbw 64, room04_00_olmask_A4
	dbw 72, room04_00_olmask_A5

Room04_01_overlapMaskA:
	db 31, 64, 40, 32, 96
	db 5
	dbw 64, room04_01_olmask_A1
	dbw 72, room04_01_olmask_A2
	dbw 80, room04_01_olmask_A3
	dbw 88, room04_01_olmask_A4
	dbw 96, room04_01_olmask_A5

Room04_02_overlapMaskA:
	db 1, 88, 80, 88, 56
	db 10
	dbw 88, room04_02_olmask_A1
	dbw 96, room04_02_olmask_A2
	dbw 104, room04_02_olmask_A3
	dbw 112, room04_02_olmask_A4
	dbw 120, room04_02_olmask_A5
	dbw 128, room04_02_olmask_A6
	dbw 136, room04_02_olmask_A7
	dbw 144, room04_02_olmask_A8
	dbw 152, room04_02_olmask_A9
	dbw 160, room04_02_olmask_A10

Room05_01_overlapMaskA:
	db 34, 112, 56, 48, 64
	db 7
	dbw 112, room05_01_olmask_A1
	dbw 120, room05_01_olmask_A2
	dbw 128, room05_01_olmask_A3
	dbw 136, room05_01_olmask_A4
	dbw 144, room05_01_olmask_A5
	dbw 152, room05_01_olmask_A6
	dbw 160, room05_01_olmask_A7

Room08_02_overlapMaskA:
	db 47, 80, 16, 56, 56
	db 2
	dbw 80, room08_02_olmask_A1
	dbw 88, room08_02_olmask_A2

Room08_04_overlapMaskA:
	db 1, 112, 40, 40, 40
	db 5
	dbw 112, room08_04_olmask_A1
	dbw 120, room08_04_olmask_A2
	dbw 128, room08_04_olmask_A3
	dbw 136, room08_04_olmask_A4
	dbw 144, room08_04_olmask_A5

Room0E_00_overlapMaskA:
	db 1, 8, 120, 112, 32
	db 15
	dbw 8, room0E_00_olmask_A1
	dbw 16, room0E_00_olmask_A2
	dbw 24, room0E_00_olmask_A3
	dbw 32, room0E_00_olmask_A4
	dbw 40, room0E_00_olmask_A5
	dbw 48, room0E_00_olmask_A6
	dbw 56, room0E_00_olmask_A7
	dbw 64, room0E_00_olmask_A8
	dbw 72, room0E_00_olmask_A9
	dbw 80, room0E_00_olmask_A10
	dbw 88, room0E_00_olmask_A11
	dbw 96, room0E_00_olmask_A12
	dbw 104, room0E_00_olmask_A13
	dbw 112, room0E_00_olmask_A14
	dbw 120, room0E_00_olmask_A15

Room0E_01_overlapMaskA:
	db 1, 32, 120, 104, 40
	db 13
	dbw 64, room0E_01_olmask_A1
	dbw 72, room0E_01_olmask_A2
	dbw 80, room0E_01_olmask_A3
	dbw 88, room0E_01_olmask_A4
	dbw 96, room0E_01_olmask_A5
	dbw 104, room0E_01_olmask_A6
	dbw 112, room0E_01_olmask_A7
	dbw 120, room0E_01_olmask_A8
	dbw 128, room0E_01_olmask_A9
	dbw 136, room0E_01_olmask_A10
	dbw 144, room0E_01_olmask_A11
	dbw 152, room0E_01_olmask_A12
	dbw 160, room0E_01_olmask_A13

Room0E_02_overlapMaskA:
	db 1, 32, 120, 88, 40
	db 4
	dbw 32, room0E_02_olmask_A1
	dbw 40, room0E_02_olmask_A2
	dbw 48, room0E_02_olmask_A3
	dbw 56, room0E_02_olmask_A4

Room10_00_overlapMaskA:
	db 1, 48, 40, 48, 88
	db 5
	dbw 48, room10_00_olmask_A1
	dbw 56, room10_00_olmask_A2
	dbw 64, room10_00_olmask_A3
	dbw 72, room10_00_olmask_A4
	dbw 80, room10_00_olmask_A5

Room10_01_overlapMaskA:
	db 1, 8, 24, 48, 64
	db 3
	dbw 8, room10_01_olmask_A1
	dbw 16, room10_01_olmask_A2
	dbw 24, room10_01_olmask_A3

Room10_01_overlapMaskB:
	db 1, 88, 32, 48, 80
	db 4
	dbw 88, room10_01_olmask_B1
	dbw 96, room10_01_olmask_B2
	dbw 104, room10_01_olmask_B3
	dbw 112, room10_01_olmask_B4

Room10_02_overlapMaskA:
	db 1, 96, 40, 56, 64
	db 5
	dbw 96, room10_02_olmask_A1
	dbw 104, room10_02_olmask_A2
	dbw 112, room10_02_olmask_A3
	dbw 120, room10_02_olmask_A4
	dbw 128, room10_02_olmask_A5

Room22_00_overlapMaskA:
	db 1, 56, 56, 96, 40
	db 7
	dbw 56, room22_00_olmask_A1
	dbw 64, room22_00_olmask_A2
	dbw 72, room22_00_olmask_A3
	dbw 80, room22_00_olmask_A4
	dbw 88, room22_00_olmask_A5
	dbw 96, room22_00_olmask_A6
	dbw 104, room22_00_olmask_A7

Room22_01_overlapMaskA:
	db 1, 64, 56, 88, 40
	db 7
	dbw 64, room22_01_olmask_A1
	dbw 72, room22_01_olmask_A2
	dbw 80, room22_01_olmask_A3
	dbw 88, room22_01_olmask_A4
	dbw 96, room22_01_olmask_A5
	dbw 104, room22_01_olmask_A6
	dbw 112, room22_01_olmask_A7

Room24_00_overlapMaskA:
	db 1, 72, 32, 64, 48
	db 4
	dbw 72, room24_00_olmask_A1
	dbw 80, room24_00_olmask_A2
	dbw 88, room24_00_olmask_A3
	dbw 96, room24_00_olmask_A4

Room24_00_overlapMaskB:
	db 1, 104, 32, 32, 80
	db 4
	dbw 104, room24_00_olmask_B1
	dbw 112, room24_00_olmask_B2
	dbw 120, room24_00_olmask_B3
	dbw 128, room24_00_olmask_B4

Room24_00_overlapMaskC:
	db 1, 136, 32, 16, 56
	db 4
	dbw 136, room24_00_olmask_C1
	dbw 144, room24_00_olmask_C2
	dbw 152, room24_00_olmask_C3
	dbw 160, room24_00_olmask_C4

Room24_04_overlapMaskA:
	db 1, 32, 64, 80, 40
	db 8
	dbw 32, room24_04_olmask_A1
	dbw 40, room24_04_olmask_A2
	dbw 48, room24_04_olmask_A3
	dbw 56, room24_04_olmask_A4
	dbw 64, room24_04_olmask_A5
	dbw 72, room24_04_olmask_A6
	dbw 80, room24_04_olmask_A7
	dbw 88, room24_04_olmask_A8

Room24_04_overlapMaskB:
	db 1, 96, 8, 16, 104
	db 1
	dbw 96, room24_04_olmask_B1

Room24_04_overlapMaskC:
	db 1, 104, 56, 80, 40
	db 7
	dbw 104, room24_04_olmask_C1
	dbw 112, room24_04_olmask_C2
	dbw 120, room24_04_olmask_C3
	dbw 128, room24_04_olmask_C4
	dbw 136, room24_04_olmask_C5
	dbw 144, room24_04_olmask_C6

Room29_00_overlapMaskA:
	db 1, 8, 64, 72, 72
	db 8
	dbw 8, room29_00_olmask_A1
	dbw 16, room29_00_olmask_A2
	dbw 24, room29_00_olmask_A3
	dbw 32, room29_00_olmask_A4
	dbw 40, room29_00_olmask_A5
	dbw 48, room29_00_olmask_A6
	dbw 56, room29_00_olmask_A7
	dbw 64, room29_00_olmask_A8

Room2C_01_overlapMaskA:
	db 36, 72, 24, 40, 64
	db 3
	dbw 72, room2C_01_olmask_A1
	dbw 80, room2C_01_olmask_A2
	dbw 88, room2C_01_olmask_A3

Room2C_01_overlapMaskB:
	db 24, 56, 32, 88, 40
	db 4
	dbw 56, room2C_01_olmask_B1
	dbw 64, room2C_01_olmask_B2
	dbw 72, room2C_01_olmask_B3
	dbw 80, room2C_01_olmask_B4

Room2C_01_overlapMaskC:
	db 37, 120, 24, 48, 56
	db 3
	dbw 120, room2C_01_olmask_C1
	dbw 128, room2C_01_olmask_C2
	dbw 136, room2C_01_olmask_C3

Room2C_02_overlapMaskA:
	db 1, 72, 24, 56, 64
	db 3
	dbw 72, room2C_02_olmask_A1
	dbw 80, room2C_02_olmask_A2
	dbw 88, room2C_02_olmask_A3
	dbw 96, room2C_02_olmask_B1

Room2C_02_overlapMaskB:
	db 1, 88, 32, 88, 32
	db 4
	dbw 88, room2C_02_olmask_B1
	dbw 96, room2C_02_olmask_B2
	dbw 104, room2C_02_olmask_B3
	dbw 112, room2C_02_olmask_B4
	dbw 120, room2C_02_olmask_C1

Room2C_02_overlapMaskC:
	db 1, 24, 16, 56, 56
	db 2
	dbw 24, room2C_02_olmask_C1
	dbw 32, room2C_02_olmask_C2

Room4C_05_overlapMaskA:
	db 1, 96, 16, 56, 24
	db 2
	dbw 96, room4C_05_olmask_A1
	dbw 104, room4C_05_olmask_A2

Room54_05_overlapMaskA:
	db 1, 8, 40, 80, 64
	db 5
	dbw 8, room54_05_olmask_A1
	dbw 16, room54_05_olmask_A2
	dbw 24, room54_05_olmask_A3
	dbw 32, room54_05_olmask_A4
	dbw 40, room54_05_olmask_A5

Room54_02_overlapMaskA:
	db 1, 48, 40, 80, 64
	db 5
	dbw 48, room54_02_olmask_A1
	dbw 56, room54_02_olmask_A2
	dbw 64, room54_02_olmask_A3
	dbw 72, room54_02_olmask_A4
	dbw 80, room54_02_olmask_A5

Room54_01_overlapMaskA:
	db 1, 64, 16, 56, 64
	db 2
	dbw 64, room54_01_olmask_A1
	dbw 72, room54_01_olmask_A2

Room54_02_overlapMaskB:
	db 1, 120, 48, 88, 56
	db 6
	dbw 120, room54_02_olmask_B1
	dbw 128, room54_02_olmask_B2
	dbw 136, room54_02_olmask_B3
	dbw 144, room54_02_olmask_B4
	dbw 152, room54_02_olmask_B5
	dbw 160, room54_02_olmask_B6

Room54_01_overlapMaskB:
	db 38, 104, 24, 80, 32
	db 3
	dbw 104, room54_01_olmask_B1
	dbw 112, room54_01_olmask_B2
	dbw 120, room54_01_olmask_B3

Room54_02_overlapMaskC:
	db 1, 8, 40, 56, 88
	db 5
	dbw 8, room54_02_olmask_C1
	dbw 16, room54_02_olmask_C2
	dbw 24, room54_02_olmask_C3
	dbw 32, room54_02_olmask_C4
	dbw 40, room54_02_olmask_C5

Room54_03_overlapMaskA:
	db 1, 64, 72, 72, 72
	db 9
	dbw 64, room54_03_olmask_A1
	dbw 72, room54_03_olmask_A2
	dbw 80, room54_03_olmask_A3
	dbw 88, room54_03_olmask_A4
	dbw 96, room54_03_olmask_A5
	dbw 104, room54_03_olmask_A6
	dbw 112, room54_03_olmask_A7
	dbw 120, room54_03_olmask_A8
	dbw 128, room54_03_olmask_A9

