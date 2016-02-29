;all room screens bg lookup table
;byte 1: bank
;byte 2-3: bg pointer

room_00_bg_pointers: ;7385
	dbw BANK(room00_00),		room00_00
	dbw BANK(room00_01),		room00_01
	dbw BANK(room00_02),		room00_02
	dbw BANK(room00_03_b10),	room00_03_b10
	dbw BANK(room00_04),		room00_04
	dbw BANK(room00_05),		room00_05
	dbw BANK(room00_06),		room00_06
room_01_bg_pointers: ;739A
	dbw BANK(room01_00_b11),	room01_00_b11
	dbw BANK(room01_01),		room01_01
	dbw BANK(room01_02),		room01_02
	dbw BANK(room01_03_b12),	room01_03_b12
	dbw BANK(room01_04),		room01_04
	dbw BANK(room01_05),		room01_05
	dbw BANK(room01_06_b13),	room01_06_b13
room_02_bg_pointers: ;73AF
	dbw BANK(room02_00),		room02_00
	dbw BANK(room02_01),		room02_01
	dbw BANK(room02_02),		room02_02
	dbw BANK(room02_03_b14),	room02_03_b14
	dbw BANK(room02_04),		room02_04
	dbw BANK(room02_05),		room02_05
room_03_bg_pointers: ;73C1
	dbw BANK(room03_00),		room03_00
	dbw BANK(room03_01),		room03_01
	dbw BANK(room03_02_b15),	room03_02_b15
	dbw BANK(room03_03),		room03_03
	dbw BANK(room03_04),		room03_04
	dbw BANK(room03_05),		room03_05
	dbw BANK(room03_06_b16),	room03_06_b16
room_04_bg_pointers: ;73D6
	dbw BANK(room04_00),		room04_00
	dbw BANK(room04_01),		room04_01
	dbw BANK(room04_02),		room04_02
	dbw BANK(room04_03_b17),	room04_03_b17
	dbw BANK(room04_04),		room04_04
	dbw BANK(room04_05),		room04_05
	dbw BANK(room04_06_b18),	room04_06_b18
	dbw BANK(room04_07),		room04_07
room_05_bg_pointers: ;73EE
	dbw BANK(room05_00),		room05_00
	dbw BANK(room05_01),		room05_01
	dbw BANK(room05_02),		room05_02
	dbw BANK(room05_03_b19),	room05_03_b19
	dbw BANK(room05_04),		room05_04
	dbw BANK(room05_05),		room05_05
room_06_bg_pointers: ;7400
	dbw BANK(room06_00),		room06_00
	dbw BANK(room06_01_b1A),	room06_01_b1A
	dbw BANK(room06_02),		room06_02
	dbw BANK(room06_03),		room06_03
	dbw BANK(room06_04_b1B),	room06_04_b1B
	dbw BANK(room06_05),		room06_05
room_07_bg_pointers: ;7412
	dbw BANK(room07_00),		room07_00
	dbw BANK(room07_01),		room07_01
	dbw BANK(room07_02),		room07_02
	dbw BANK(room07_03_b1C),	room07_03_b1C
	dbw BANK(room07_04),		room07_04
	dbw BANK(room07_05),		room07_05
	dbw BANK(room07_06),		room07_06
	dbw BANK(room07_07),		room07_07
room_08_bg_pointers: ;742A
	dbw BANK(room08_00_b1D),	room08_00_b1D
	dbw BANK(room08_01),		room08_01
	dbw BANK(room08_02),		room08_02
	dbw BANK(room08_03),		room08_03
	dbw BANK(room08_04_b1E),	room08_04_b1E
	dbw BANK(room08_05),		room08_05
room_09_bg_pointers: ;743C
	dbw BANK(room09_00),		room09_00
	dbw BANK(room09_01),		room09_01
	dbw BANK(room09_02),		room09_02
	dbw BANK(room09_03_b1F),	room09_03_b1F
room_0A_bg_pointers: ;7448
	dbw BANK(room0A_00),		room0A_00
	dbw BANK(room0A_01),		room0A_01
	dbw BANK(room0A_02),		room0A_02
	dbw BANK(room0A_03_b20),	room0A_03_b20
	dbw BANK(room0A_04),		room0A_04
	dbw BANK(room0A_05),		room0A_05
	dbw BANK(room0A_06),		room0A_06
room_0B_bg_pointers: ;745D
	dbw BANK(room0B_00_b21),	room0B_00_b21
	dbw BANK(room0B_01),		room0B_01
	dbw BANK(room0B_02),		room0B_02
	dbw BANK(room0B_03_b22),	room0B_03_b22
	dbw BANK(room0B_04),		room0B_04
room_0C_bg_pointers: ;746C
	dbw BANK(room0C_00),		room0C_00
	dbw BANK(room0C_01),		room0C_01
	dbw BANK(room0C_02_b23),	room0C_02_b23
	dbw BANK(room0C_03),		room0C_03
room_0D_bg_pointers: ;7478
	dbw BANK(room0D_00),		room0D_00
	dbw BANK(room0D_01),		room0D_01
	dbw BANK(room0D_02),		room0D_02
	dbw BANK(room0D_03_b24),	room0D_03_b24
room_0E_bg_pointers: ;7484
	dbw BANK(room0E_00),		room0E_00
	dbw BANK(room0E_01),		room0E_01
	dbw BANK(room0E_02),		room0E_02
	dbw BANK(room0E_03_b25),	room0E_03_b25
room_0F_bg_pointers: ;7490
	dbw BANK(room0F_00),		room0F_00
	dbw BANK(room0F_01),		room0F_01
	dbw BANK(room0F_02),		room0F_02
	dbw BANK(room0F_03_b26),	room0F_03_b26
	dbw BANK(room0F_04),		room0F_04
room_10_bg_pointers: ;749F
	dbw BANK(room10_00),		room10_00
	dbw BANK(room10_01),		room10_01
	dbw BANK(room10_02_b27),	room10_02_b27
	dbw BANK(room10_03),		room10_03
	dbw BANK(room10_04),		room10_04
room_11_bg_pointers: ;74AE
	dbw BANK(room11_00),		room11_00
	dbw BANK(room11_01_b28),	room11_01_b28
	dbw BANK(room11_02),		room11_02
	dbw BANK(room11_03),		room11_03
room_12_bg_pointers: ;74BA
	dbw BANK(room12_00),		room12_00
	dbw BANK(room12_01_b29),	room12_01_b29
	dbw BANK(room12_02),		room12_02
	dbw BANK(room12_03),		room12_03
room_13_bg_pointers: ;74C6
	dbw BANK(room13_00_b2A),	room13_00_b2A
	dbw BANK(room13_01),		room13_01
	dbw BANK(room13_02),		room13_02
	dbw BANK(room13_03_b2B),	room13_03_b2B
	dbw BANK(room13_04),		room13_04
room_14_bg_pointers: ;74D5
	dbw BANK(room14_00),		room14_00
	dbw BANK(room14_01),		room14_01
room_15_bg_pointers: ;74DB
	dbw BANK(room15_00_b2C),	room15_00_b2C
	dbw BANK(room15_01),		room15_01
	dbw BANK(room15_02),		room15_02
room_16_bg_pointers: ;74E4
	dbw BANK(room16_00),		room16_00
	dbw BANK(room16_01),		room16_01
	dbw BANK(room16_02_b2D),	room16_02_b2D
room_17_bg_pointers: ;74ED
	dbw BANK(room17_00),		room17_00
	dbw BANK(room17_01),		room17_01
room_18_bg_pointers: ;74F3
	dbw BANK(room18_00_b2E),	room18_00_b2E
	dbw BANK(room18_01),		room18_01
room_19_bg_pointers: ;74F9
	dbw BANK(room19_00),		room19_00
	dbw BANK(room19_01),		room19_01
	dbw BANK(room19_02_b2F),	room19_02_b2F
	dbw BANK(room19_03),		room19_03
room_1A_bg_pointers: ;7505
	dbw BANK(room1A_00),		room1A_00
	dbw BANK(room1A_01),		room1A_01
	dbw BANK(room1A_02),		room1A_02
	dbw BANK(room1A_03_b30),	room1A_03_b30
	dbw BANK(room1A_04),		room1A_04
	dbw BANK(room1A_05),		room1A_05
room_1B_bg_pointers: ;7517
	dbw BANK(room1B_00),		room1B_00
	dbw BANK(room1B_01_b31),	room1B_01_b31
	dbw BANK(room1B_02),		room1B_02
	dbw BANK(room1B_03),		room1B_03
	dbw BANK(room1B_04),		room1B_04
	dbw BANK(room1B_05_b32),	room1B_05_b32
room_1C_bg_pointers: ;7529
	dbw BANK(room1C_00),		room1C_00
	dbw BANK(room1C_01),		room1C_01
	dbw BANK(room1C_02_b33),	room1C_02_b33
	dbw BANK(room1C_03),		room1C_03
	dbw BANK(room1C_04),		room1C_04
	dbw BANK(room1C_05),		room1C_05
room_1D_bg_pointers: ;753B
	dbw BANK(room1D_00_b34),	room1D_00_b34
	dbw BANK(room1D_01),		room1D_01
	dbw BANK(room1D_02),		room1D_02
	dbw BANK(room1D_03),		room1D_03
	dbw BANK(room1D_04),		room1D_04
room_1E_bg_pointers: ;754A
	dbw BANK(room1E_00_b35),	room1E_00_b35
	dbw BANK(room1E_01),		room1E_01
	dbw BANK(room1E_02),		room1E_02
	dbw BANK(room1E_03),		room1E_03
	dbw BANK(room1E_04_b36),	room1E_04_b36
	dbw BANK(room1E_05),		room1E_05
room_1F_bg_pointers: ;755C
	dbw BANK(room1F_00),		room1F_00
	dbw BANK(room1F_01_b37),	room1F_01_b37
	dbw BANK(room1F_02),		room1F_02
room_20_bg_pointers: ;7565
	dbw BANK(room20_00),		room20_00
	dbw BANK(room20_01),		room20_01
	dbw BANK(room20_02),		room20_02
	dbw BANK(room20_03_b38),	room20_03_b38
	dbw BANK(room20_04),		room20_04
	dbw BANK(room20_05),		room20_05
	dbw BANK(room20_06),		room20_06
room_21_bg_pointers: ;757A
	dbw BANK(room21_00),		room21_00
	dbw BANK(room21_01_b39),	room21_01_b39
	dbw BANK(room21_02),		room21_02
room_22_bg_pointers: ;7583
	dbw BANK(room22_00),		room22_00
	dbw BANK(room22_01),		room22_01
	dbw BANK(room22_02_b3A),	room22_02_b3A
room_23_bg_pointers: ;758C
	dbw BANK(room23_00),		room23_00
	dbw BANK(room23_01),		room23_01
	dbw BANK(room23_02_b3B),	room23_02_b3B
	dbw BANK(room23_03),		room23_03
room_24_bg_pointers: ;7598
	dbw BANK(room24_00),		room24_00
	dbw BANK(room24_01),		room24_01
	dbw BANK(room24_02_b3C),	room24_02_b3C
	dbw BANK(room24_03),		room24_03
	dbw BANK(room24_04),		room24_04
	dbw BANK(room24_05),		room24_05
	dbw BANK(room24_06),		room24_06
room_25_bg_pointers: ;75AD
	dbw BANK(room25_00),		room25_00
	dbw BANK(room25_01_b3D),	room25_01_b3D
	dbw BANK(room25_02),		room25_02
	dbw BANK(room25_03),		room25_03
	dbw BANK(room25_04),		room25_04
room_26_bg_pointers: ;75BC
	dbw BANK(room26_00),		room26_00
	dbw BANK(room26_01_b3E),	room26_01_b3E
	dbw BANK(room26_02),		room26_02
room_27_bg_pointers: ;75C5
	dbw BANK(room27_00),		room27_00
	dbw BANK(room27_01),		room27_01
	dbw BANK(room27_02),		room27_02
	dbw BANK(room27_03_b3F),	room27_03_b3F
	dbw BANK(room27_04),		room27_04
room_28_bg_pointers: ;75D4
	dbw BANK(room28_00),		room28_00
	dbw BANK(room28_01),		room28_01
	dbw BANK(room28_02_b40),	room28_02_b40
	dbw BANK(room28_03),		room28_03
	dbw BANK(room28_04),		room28_04
room_29_bg_pointers: ;75E3
	dbw BANK(room29_00_b41),	room29_00_b41
	dbw BANK(room29_01),		room29_01
	dbw BANK(room29_02),		room29_02
room_2A_bg_pointers: ;75EC
	dbw BANK(room2A_00),		room2A_00
	dbw BANK(room2A_01_b42),	room2A_01_b42
	dbw BANK(room2A_02),		room2A_02
	dbw BANK(room2A_03),		room2A_03
room_2B_bg_pointers: ;75F8
	dbw BANK(room2B_00_b43),	room2B_00_b43
	dbw BANK(room2B_01),		room2B_01
	dbw BANK(room2B_02),		room2B_02
	dbw BANK(room2B_03_b44),	room2B_03_b44
room_2C_bg_pointers: ;7604
	dbw BANK(room2C_00),		room2C_00
	dbw BANK(room2C_01),		room2C_01
	dbw BANK(room2C_02_b45),	room2C_02_b45
	dbw BANK(room2C_03),		room2C_03
	dbw BANK(room2C_04),		room2C_04
	dbw BANK(room2C_05_b46),	room2C_05_b46
	dbw BANK(room2C_06),		room2C_06
room_2D_bg_pointers: ;7619
	dbw BANK(room2D_00),		room2D_00
	dbw BANK(room2D_01_b47),	room2D_01_b47
	dbw BANK(room2D_02),		room2D_02
	dbw BANK(room2D_03),		room2D_03
room_2E_bg_pointers: ;7625
	dbw BANK(room2E_00),		room2E_00
	dbw BANK(room2E_01_b48),	room2E_01_b48
room_2F_bg_pointers: ;762B
	dbw BANK(room2F_00),		room2F_00
	dbw BANK(room2F_01),		room2F_01
	dbw BANK(room2F_02),		room2F_02
	dbw BANK(room2F_03_b49),	room2F_03_b49
	dbw BANK(room2F_04),		room2F_04
room_30_bg_pointers: ;763A
	dbw BANK(room30_00),		room30_00
	dbw BANK(room30_01),		room30_01
	dbw BANK(room30_02_b4A),	room30_02_b4A
	dbw BANK(room30_03),		room30_03
room_31_bg_pointers: ;7646
	dbw BANK(room31_00),		room31_00
	dbw BANK(room31_01),		room31_01
	dbw BANK(room31_02_b4B),	room31_02_b4B
	dbw BANK(room31_03),		room31_03
	dbw BANK(room31_04),		room31_04
	dbw BANK(room31_05_b4C),	room31_05_b4C
room_32_bg_pointers: ;7658
	dbw BANK(room32_00),		room32_00
	dbw BANK(room32_01),		room32_01
	dbw BANK(room32_02_b4D),	room32_02_b4D
	dbw BANK(room32_03),		room32_03
	dbw BANK(room32_04),		room32_04
	dbw BANK(room32_05),		room32_05
	dbw BANK(room32_06_b4E),	room32_06_b4E
	dbw BANK(room32_07),		room32_07
room_33_bg_pointers: ;7670
	dbw BANK(room33_00),		room33_00
	dbw BANK(room33_01_b4F),	room33_01_b4F
room_34_bg_pointers: ;7676
	dbw BANK(room34_00),		room34_00
	dbw BANK(room34_01),		room34_01
	dbw BANK(room34_02_b50),	room34_02_b50
room_35_bg_pointers: ;767F
	dbw BANK(room35_00),		room35_00
	dbw BANK(room35_01),		room35_01
	dbw BANK(room35_02_b51),	room35_02_b51
	dbw BANK(room35_03),		room35_03
	dbw BANK(room35_04),		room35_04
	dbw BANK(room35_05),		room35_05
	dbw BANK(room35_06),		room35_06
	dbw BANK(room35_07_b52),	room35_07_b52
room_36_bg_pointers: ;7697
	dbw BANK(room36_00),		room36_00
	dbw BANK(room36_01),		room36_01
	dbw BANK(room36_02_b53),	room36_02_b53
	dbw BANK(room36_03),		room36_03
	dbw BANK(room36_04),		room36_04
	dbw BANK(room36_05_b54),	room36_05_b54
	dbw BANK(room36_06),		room36_06
room_37_bg_pointers: ;76AC
	dbw BANK(room37_00),		room37_00
	dbw BANK(room37_01_b55),	room37_01_b55
	dbw BANK(room37_02),		room37_02
	dbw BANK(room37_03),		room37_03
	dbw BANK(room37_04_b56),	room37_04_b56
	dbw BANK(room37_05),		room37_05
	dbw BANK(room37_06),		room37_06
	dbw BANK(room37_07_b57),	room37_07_b57
room_38_bg_pointers: ;76C4
	dbw BANK(room38_00),		room38_00
	dbw BANK(room38_01),		room38_01
	dbw BANK(room38_02_b58),	room38_02_b58
	dbw BANK(room38_03),		room38_03
	dbw BANK(room38_04),		room38_04
	dbw BANK(room38_05_b59),	room38_05_b59
	dbw BANK(room38_06),		room38_06
	dbw BANK(room38_07),		room38_07
room_39_bg_pointers: ;76DC
	dbw BANK(room39_00_b5A),	room39_00_b5A
	dbw BANK(room39_01),		room39_01
	dbw BANK(room39_02),		room39_02
	dbw BANK(room39_03_b5B),	room39_03_b5B
	dbw BANK(room39_04),		room39_04
	dbw BANK(room39_05),		room39_05
	dbw BANK(room39_06),		room39_06
	dbw BANK(room39_07_b5C),	room39_07_b5C
room_3A_bg_pointers: ;76F4
	dbw BANK(room3A_00),		room3A_00
	dbw BANK(room3A_01),		room3A_01
	dbw BANK(room3A_02_b5D),	room3A_02_b5D
	dbw BANK(room3A_03),		room3A_03
	dbw BANK(room3A_04),		room3A_04
	dbw BANK(room3A_05_b5E),	room3A_05_b5E
room_3B_bg_pointers: ;7706
	dbw BANK(room3B_00),		room3B_00
	dbw BANK(room3B_01_b5F),	room3B_01_b5F
	dbw BANK(room3B_02),		room3B_02
	dbw BANK(room3B_03),		room3B_03
room_3C_bg_pointers: ;7712
	dbw BANK(room3C_00_b60),	room3C_00_b60
	dbw BANK(room3C_01),		room3C_01
	dbw BANK(room3C_02),		room3C_02
	dbw BANK(room3C_03_b61),	room3C_03_b61
	dbw BANK(room3C_04),		room3C_04
	dbw BANK(room3C_05),		room3C_05
	dbw BANK(room3C_06_b62),	room3C_06_b62
	dbw BANK(room3C_07),		room3C_07
room_3D_bg_pointers: ;772A
	dbw BANK(room3D_00),		room3D_00
	dbw BANK(room3D_01_b63),	room3D_01_b63
	dbw BANK(room3D_02),		room3D_02
	dbw BANK(room3D_03),		room3D_03
	dbw BANK(room3D_04_b64),	room3D_04_b64
	dbw BANK(room3D_05),		room3D_05
	dbw BANK(room3D_06),		room3D_06
	dbw BANK(room3D_07_b65),	room3D_07_b65
room_3E_bg_pointers: ;7742
	dbw BANK(room3E_00),		room3E_00
	dbw BANK(room3E_01_b66),	room3E_01_b66
	dbw BANK(room3E_02),		room3E_02
	dbw BANK(room3E_03),		room3E_03
	dbw BANK(room3E_04_b67),	room3E_04_b67
	dbw BANK(room3E_05),		room3E_05
	dbw BANK(room3E_06),		room3E_06
	dbw BANK(room3E_07_b68),	room3E_07_b68
room_3F_bg_pointers: ;775A
	dbw BANK(room3F_00),		room3F_00
	dbw BANK(room3F_01),		room3F_01
	dbw BANK(room3F_02_b69),	room3F_02_b69
	dbw BANK(room3F_03),		room3F_03
	dbw BANK(room3F_04),		room3F_04
	dbw BANK(room3F_05_b6A),	room3F_05_b6A
	dbw BANK(room3F_06),		room3F_06
room_40_bg_pointers: ;776F
	dbw BANK(room40_00),		room40_00
	dbw BANK(room40_01_b6B),	room40_01_b6B
	dbw BANK(room40_02),		room40_02
	dbw BANK(room40_03),		room40_03
	dbw BANK(room40_04),		room40_04
room_41_bg_pointers: ;777E
	dbw BANK(room41_00_b6C),	room41_00_b6C
	dbw BANK(room41_01),		room41_01
	dbw BANK(room41_02),		room41_02
	dbw BANK(room41_03_b6D),	room41_03_b6D
	dbw BANK(room41_04),		room41_04
	dbw BANK(room41_05),		room41_05
	dbw BANK(room41_06_b6E),	room41_06_b6E
	dbw BANK(room41_07),		room41_07
room_42_bg_pointers: ;7796
	dbw BANK(room42_00),		room42_00
room_43_bg_pointers: ;7799
	dbw BANK(room43_00_b6F),	room43_00_b6F
	dbw BANK(room43_01),		room43_01
	dbw BANK(room43_02),		room43_02
	dbw BANK(room43_03_b70),	room43_03_b70
	dbw BANK(room43_04),		room43_04
	dbw BANK(room43_05_b71),	room43_05_b71
room_44_bg_pointers: ;77AB
	dbw BANK(room44_00),		room44_00
	dbw BANK(room44_01),		room44_01
	dbw BANK(room44_02_b72),	room44_02_b72
	dbw BANK(room44_03),		room44_03
	dbw BANK(room44_04),		room44_04
	dbw BANK(room44_05_b73),	room44_05_b73
	dbw BANK(room44_06),		room44_06
	dbw BANK(room44_07),		room44_07
room_45_bg_pointers: ;77C3
	dbw BANK(room45_00_b74),	room45_00_b74
	dbw BANK(room45_01),		room45_01
	dbw BANK(room45_02),		room45_02
	dbw BANK(room45_03_b75),	room45_03_b75
room_46_bg_pointers: ;77CF
	dbw BANK(room46_00),		room46_00
	dbw BANK(room46_01),		room46_01
	dbw BANK(room46_02_b76),	room46_02_b76
	dbw BANK(room46_03),		room46_03
	dbw BANK(room46_04),		room46_04
room_47_bg_pointers: ;77DE
	dbw BANK(room47_00_b77),	room47_00_b77
	dbw BANK(room47_01),		room47_01
	dbw BANK(room47_02),		room47_02
	dbw BANK(room47_03_b78),	room47_03_b78
	dbw BANK(room47_04),		room47_04
	dbw BANK(room47_05),		room47_05
room_48_bg_pointers: ;77F0
	dbw BANK(room48_00_b79),	room48_00_b79
	dbw BANK(room48_01),		room48_01
	dbw BANK(room48_02),		room48_02
	dbw BANK(room48_03_b7A),	room48_03_b7A
	dbw BANK(room48_04),		room48_04
room_49_bg_pointers: ;77FF
	dbw BANK(room49_00),		room49_00
	dbw BANK(room49_01),		room49_01
room_4A_bg_pointers: ;7805
	dbw BANK(room4A_00_b7B),	room4A_00_b7B
	dbw BANK(room4A_01),		room4A_01
	dbw BANK(room4A_02),		room4A_02
room_4B_bg_pointers: ;780E
	dbw BANK(room4B_00_b7C),	room4B_00_b7C
	dbw BANK(room4B_01),		room4B_01
	dbw BANK(room4B_02),		room4B_02
	dbw BANK(room4B_03),		room4B_03
	dbw BANK(room4B_04_b7D),	room4B_04_b7D
	dbw BANK(room4B_05),		room4B_05
room_4C_bg_pointers: ;7820
	dbw BANK(room4C_00),		room4C_00
	dbw BANK(room4C_01),		room4C_01
	dbw BANK(room4C_02_b7E),	room4C_02_b7E
	dbw BANK(room4C_03),		room4C_03
	dbw BANK(room4C_04),		room4C_04
	dbw BANK(room4C_05_b7F),	room4C_05_b7F
	dbw BANK(room4C_06),		room4C_06
	dbw BANK(room4C_07),		room4C_07
room_4D_bg_pointers: ;7838
	dbw BANK(room4D_00_b80),	room4D_00_b80
	dbw BANK(room4D_01),		room4D_01
	dbw BANK(room4D_02),		room4D_02
	dbw BANK(room4D_03),		room4D_03
	dbw BANK(room4D_04),		room4D_04
room_4E_bg_pointers: ;7847
	dbw BANK(room4E_00_b81),	room4E_00_b81
	dbw BANK(room4E_01),		room4E_01
	dbw BANK(room4E_02),		room4E_02
	dbw BANK(room4E_03_b82),	room4E_03_b82
	dbw BANK(room4E_04),		room4E_04
	dbw BANK(room4E_05),		room4E_05
room_4F_bg_pointers: ;7859
	dbw BANK(room4F_00_b83),	room4F_00_b83
	dbw BANK(room4F_01),		room4F_01
	dbw BANK(room4F_02),		room4F_02
	dbw BANK(room4F_03_b84),	room4F_03_b84
	dbw BANK(room4F_04),		room4F_04
	dbw BANK(room4F_05_b85),	room4F_05_b85
	dbw BANK(room4F_06),		room4F_06
	dbw BANK(room4F_07),		room4F_07
room_50_bg_pointers: ;7871
	dbw BANK(room50_00_b86),	room50_00_b86
	dbw BANK(room50_01),		room50_01
	dbw BANK(room50_02),		room50_02
	dbw BANK(room50_03),		room50_03
	dbw BANK(room50_04_b87),	room50_04_b87
	dbw BANK(room50_05),		room50_05
	dbw BANK(room50_06),		room50_06
room_51_bg_pointers: ;7886
	dbw BANK(room51_00_b88),	room51_00_b88
	dbw BANK(room51_01),		room51_01
room_52_bg_pointers: ;788C
	dbw BANK(room52_00),		room52_00
	dbw BANK(room52_01),		room52_01
	dbw BANK(room52_02_b89),	room52_02_b89
	dbw BANK(room52_03),		room52_03
	dbw BANK(room52_04),		room52_04
	dbw BANK(room52_05_b8A),	room52_05_b8A
	dbw BANK(room52_06),		room52_06
	dbw BANK(room52_07),		room52_07
room_53_bg_pointers: ;78A4
	dbw BANK(room53_00),		room53_00
	dbw BANK(room53_01_b8B),	room53_01_b8B
	dbw BANK(room53_02),		room53_02
	dbw BANK(room53_03),		room53_03
room_54_bg_pointers: ;78B0
	dbw BANK(room54_00_b8C),	room54_00_b8C
	dbw BANK(room54_01),		room54_01
	dbw BANK(room54_02),		room54_02
	dbw BANK(room54_03_b8D),	room54_03_b8D
	dbw BANK(room54_04),		room54_04
	dbw BANK(room54_05),		room54_05
	dbw BANK(room54_06),		room54_06
room_55_bg_pointers: ;78C5
	dbw BANK(room55_00_b8E),	room55_00_b8E
	dbw BANK(room55_01),		room55_01
room_56_bg_pointers: ;78CB
	dbw BANK(room56_00),		room56_00
	dbw BANK(room56_01_b8F),	room56_01_b8F
	dbw BANK(room56_02),		room56_02
	dbw BANK(room56_03),		room56_03
	dbw BANK(room56_04),		room56_04
	dbw BANK(room56_05_b90),	room56_05_b90
	dbw BANK(room56_06),		room56_06
room_57_bg_pointers: ;78E0
	dbw BANK(room57_00),		room57_00
	dbw BANK(room57_01_b91),	room57_01_b91
room_58_bg_pointers: ;78E6
	dbw BANK(room58_00),		room58_00
	dbw BANK(room58_01),		room58_01
	dbw BANK(room58_02_b92),	room58_02_b92
	dbw BANK(room58_03),		room58_03
	dbw BANK(room58_04),		room58_04
room_59_bg_pointers: ;78F5
	dbw BANK(room59_00_b93),	room59_00_b93
	dbw BANK(room59_01),		room59_01
	dbw BANK(room59_02),		room59_02
	dbw BANK(room59_03),		room59_03
	dbw BANK(room59_04_b94),	room59_04_b94
	dbw BANK(room59_05),		room59_05
	dbw BANK(room59_06),		room59_06
	dbw BANK(room59_07_b95),	room59_07_b95
room_5A_bg_pointers: ;790D
	dbw BANK(room5A_00),		room5A_00
	dbw BANK(room5A_01),		room5A_01
	dbw BANK(room5A_02),		room5A_02
	dbw BANK(room5A_03_b96),	room5A_03_b96
	dbw BANK(room5A_04),		room5A_04
room_5B_bg_pointers: ;791C
	dbw BANK(room5B_00),		room5B_00
	dbw BANK(room5B_01),		room5B_01
	dbw BANK(room5B_02_b97),	room5B_02_b97
	dbw BANK(room5B_03),		room5B_03
room_5C_bg_pointers: ;7928
	dbw BANK(room5C_00),		room5C_00
	dbw BANK(room5C_01_b98),	room5C_01_b98
	dbw BANK(room5C_02),		room5C_02
	dbw BANK(room5C_03),		room5C_03
	dbw BANK(room5C_04_b99),	room5C_04_b99
	dbw BANK(room5C_05),		room5C_05
room_5D_bg_pointers: ;793A
	dbw BANK(room5D_00),		room5D_00
	dbw BANK(room5D_01),		room5D_01
	dbw BANK(room5D_02_b9A),	room5D_02_b9A
	dbw BANK(room5D_03),		room5D_03
	dbw BANK(room5D_04),		room5D_04
room_5E_bg_pointers: ;7949
	dbw BANK(room5E_00),		room5E_00
	dbw BANK(room5E_01),		room5E_01
	dbw BANK(room5E_02_b9B),	room5E_02_b9B
	dbw BANK(room5E_03),		room5E_03
	dbw BANK(room5E_04),		room5E_04
	dbw BANK(room5E_05_b9C),	room5E_05_b9C
	dbw BANK(room5E_06),		room5E_06
	dbw BANK(room5E_07),		room5E_07
room_5F_bg_pointers: ;7961
	dbw BANK(room5F_00_b9D),	room5F_00_b9D
	dbw BANK(room5F_01),		room5F_01
	dbw BANK(room5F_02),		room5F_02
	dbw BANK(room5F_03),		room5F_03
	dbw BANK(room5F_04),		room5F_04
room_60_bg_pointers: ;7970
	dbw BANK(room60_00_b9E),	room60_00_b9E
	dbw BANK(room60_01),		room60_01
	dbw BANK(room60_02),		room60_02
	dbw BANK(room60_03),		room60_03
	dbw BANK(room60_04_b9F),	room60_04_b9F
	dbw BANK(room60_05),		room60_05
	dbw BANK(room60_06),		room60_06
	dbw BANK(room60_07),		room60_07
room_61_bg_pointers: ;7988
	dbw BANK(room61_00),		room61_00
	dbw BANK(room61_01_bA0),	room61_01_bA0
	dbw BANK(room61_02),		room61_02
	dbw BANK(room61_03),		room61_03
	dbw BANK(room61_04),		room61_04
room_62_bg_pointers: ;7997
	dbw BANK(room62_00),		room62_00
	dbw BANK(room62_01),		room62_01
	dbw BANK(room62_02_bA1),	room62_02_bA1
	dbw BANK(room62_03),		room62_03
	dbw BANK(room62_04),		room62_04
	dbw BANK(room62_05),		room62_05
room_63_bg_pointers: ;79A9
	dbw BANK(room63_00),		room63_00
	dbw BANK(room63_01),		room63_01
	dbw BANK(room63_02_bA2),	room63_02_bA2
	dbw BANK(room63_03),		room63_03
	dbw BANK(room63_04),		room63_04
room_64_bg_pointers: ;79B8
	dbw BANK(room64_00),		room64_00
	dbw BANK(room64_01),		room64_01
	dbw BANK(room64_02_bA3),	room64_02_bA3
	dbw BANK(room64_03),		room64_03
room_65_bg_pointers: ;79C4
	dbw BANK(room65_00),		room65_00
	dbw BANK(room65_01),		room65_01
	dbw BANK(room65_02_bA4),	room65_02_bA4
	dbw BANK(room65_03),		room65_03
	dbw BANK(room65_04),		room65_04
	dbw BANK(room65_05),		room65_05
room_66_bg_pointers: ;79D6
	dbw BANK(room66_00_bA5),	room66_00_bA5
room_67_bg_pointers: ;79D9
	dbw BANK(room67_00),		room67_00
	dbw BANK(room67_01),		room67_01
room_68_bg_pointers: ;79DF
	dbw BANK(room68_00_bA6),	room68_00_bA6
	dbw BANK(room68_01),		room68_01
	dbw BANK(room68_02),		room68_02
	dbw BANK(room68_03),		room68_03
	dbw BANK(room68_04_bA7),	room68_04_bA7
	dbw BANK(room68_05),		room68_05
	dbw BANK(room68_06),		room68_06
	dbw BANK(room68_07_bA8),	room68_07_bA8
room_69_bg_pointers: ;79F7
	dbw BANK(room69_00),		room69_00
	dbw BANK(room69_01),		room69_01
	dbw BANK(room69_02_bA9),	room69_02_bA9
	dbw BANK(room69_03),		room69_03
	dbw BANK(room69_04),		room69_04
	dbw BANK(room69_05),		room69_05
	dbw BANK(room69_06_bAA),	room69_06_bAA
	dbw BANK(room69_07),		room69_07
room_6A_bg_pointers: ;7A0F
	dbw BANK(room6A_00),		room6A_00
	dbw BANK(room6A_01_bAB),	room6A_01_bAB
	dbw BANK(room6A_02),		room6A_02
	dbw BANK(room6A_03),		room6A_03
	dbw BANK(room6A_04_bAC),	room6A_04_bAC
	dbw BANK(room6A_05),		room6A_05
room_6B_bg_pointers: ;7A21
	dbw BANK(room6B_00),		room6B_00
room_6C_bg_pointers: ;7A24
	dbw BANK(room6C_00),		room6C_00
	dbw BANK(room6C_01_bAD),	room6C_01_bAD
	dbw BANK(room6C_02),		room6C_02
	dbw BANK(room6C_03),		room6C_03
	dbw BANK(room6C_04_bAE),	room6C_04_bAE
room_6D_bg_pointers: ;7A33
	dbw BANK(room6D_00),		room6D_00
	dbw BANK(room6D_01),		room6D_01
	dbw BANK(room6D_02),		room6D_02
	dbw BANK(room6D_03),		room6D_03
	dbw BANK(room6D_04_bAF),	room6D_04_bAF
	dbw BANK(room6D_05),		room6D_05
	dbw BANK(room6D_06),		room6D_06
room_6E_bg_pointers: ;7A48
	dbw BANK(room6E_00),		room6E_00
	dbw BANK(room6E_01_bB0),	room6E_01_bB0
	dbw BANK(room6E_02),		room6E_02
	dbw BANK(room6E_03),		room6E_03
	dbw BANK(room6E_04_bB1),	room6E_04_bB1
	dbw BANK(room6E_05),		room6E_05
	dbw BANK(room6E_06),		room6E_06
	dbw BANK(room6E_07),		room6E_07
room_6F_bg_pointers: ;7A60
	dbw BANK(room6F_00_bB2),	room6F_00_bB2
	dbw BANK(room6F_01),		room6F_01
	dbw BANK(room6F_02),		room6F_02
	dbw BANK(room6F_03),		room6F_03
	dbw BANK(room6F_04_bB3),	room6F_04_bB3
	dbw BANK(room6F_05),		room6F_05
	dbw BANK(room6F_06),		room6F_06
	dbw BANK(room6F_07),		room6F_07
room_70_bg_pointers: ;7A78
	dbw BANK(room70_00),		room70_00
	dbw BANK(room70_01_bB4),	room70_01_bB4
room_71_bg_pointers: ;7A7E
	dbw BANK(room71_00),		room71_00
	dbw BANK(room71_01),		room71_01
room_72_bg_pointers: ;7A84
	dbw BANK(room72_00_bB5),	room72_00_bB5
room_73_bg_pointers: ;7A87
	dbw BANK(room73_00),		room73_00
	dbw BANK(room73_01),		room73_01
	dbw BANK(room73_02_bB6),	room73_02_bB6
	dbw BANK(room73_03),		room73_03
	dbw BANK(room73_04),		room73_04
;7A96

;rooms bg masks

room06_01_masks_pointers: ;7A96
	dbw BANK(room06_01_mask_plant1),			room06_01_mask_plant1
	dbw BANK(room06_01_mask_plant2_bB7),		room06_01_mask_plant2_bB7
	dbw BANK(room06_01_mask_plant3),			room06_01_mask_plant3
	dbw BANK(room06_01_mask_plant4),			room06_01_mask_plant4
room06_02_masks_pointers: ;7AA2
	dbw BANK(room06_02_mask_plant1),			room06_02_mask_plant1
	dbw BANK(room06_02_mask_plant2),			room06_02_mask_plant2
	dbw BANK(room06_02_mask_plant3),			room06_02_mask_plant3
	dbw BANK(room06_02_mask_plant4),			room06_02_mask_plant4
room56_00_mask:;7AAE
	dbw BANK(room56_00_mask_plant42),			room56_00_mask_plant42
	dbw BANK(room56_01_mask_plant42),			room56_01_mask_plant42
	dbw BANK(room56_02_mask_plant42),			room56_02_mask_plant42
	dbw BANK(room56_03_mask_plant42_bB8),		room56_03_mask_plant42_bB8
	dbw BANK(room56_04_mask_plant_42_),			room56_04_mask_plant_42_
	dbw BANK(room56_05_mask_plant_42),			room56_05_mask_plant_42

room6F_paintings_masks: ;7AC0
	dbw BANK(room6F_04_mask_painting),			room6F_04_mask_painting
	dbw BANK(room6F_05_mask_painting),			room6F_05_mask_painting
	dbw BANK(room6F_06_mask_painting),			room6F_06_mask_painting

room5D_button_panel_mask: ;7AC9
	dbw BANK(room5D_03_mask_button_panel),		room5D_03_mask_button_panel

room5D_lab_column_masks: ;7ACC
	dbw BANK(room5D_00_mask_lab_column1),			room5D_00_mask_lab_column1
	dbw BANK(room5D_00_mask_lab_column2),			room5D_00_mask_lab_column2
	dbw BANK(room5D_02_mask_lab_column1),			room5D_02_mask_lab_column1
	dbw BANK(room5D_02_mask_lab_column2),			room5D_02_mask_lab_column2
	dbw BANK(room5D_01_mask_lab_column1),			room5D_01_mask_lab_column1
	dbw BANK(room5D_01_mask_lab_column2),			room5D_01_mask_lab_column2

room01_broken_statue_masks_pointers: ;7ADE
	dbw BANK(room01_01_mask_broken_statue_bB9),		room01_01_mask_broken_statue_bB9
	dbw BANK(room01_02_mask_broken_statue),			room01_02_mask_broken_statue
	dbw BANK(room01_04_mask_broken_statue),			room01_04_mask_broken_statue
lion_statue_masks_pointers: ;7AE7
	dbw BANK(room14_01_mask_lion_statue1),			room14_01_mask_lion_statue1
	dbw BANK(room14_01_mask_lion_statue2),			room14_01_mask_lion_statue2
	dbw BANK(room14_01_mask_lion_statue3),			room14_01_mask_lion_statue3
	dbw BANK(room14_01_mask_lion_statue4_bBA),		room14_01_mask_lion_statue4_bBA
	dbw BANK(room14_01_mask_lion_statue5),			room14_01_mask_lion_statue5
	dbw BANK(room14_01_mask_lion_statue6),			room14_01_mask_lion_statue6
	dbw BANK(room14_01_mask_lion_statue7),			room14_01_mask_lion_statue7
	dbw BANK(room14_00_mask_lion_statue1),			room14_00_mask_lion_statue1
	dbw BANK(room14_00_mask_lion_statue2),			room14_00_mask_lion_statue2
room07_secret_door_masks_pointers: ;7B02
	dbw BANK(room07_01_mask_secret_door1),			room07_01_mask_secret_door1
	dbw BANK(room07_03_mask_secret_door1),			room07_03_mask_secret_door1
	dbw BANK(room07_07_mask_secret_door1_bBB),		room07_07_mask_secret_door1_bBB
	dbw BANK(room07_07_mask_secret_door2),			room07_07_mask_secret_door2
	dbw BANK(room07_07_mask_secret_door3),			room07_07_mask_secret_door3
	dbw BANK(room07_03_mask_secret_door2),			room07_03_mask_secret_door2
	dbw BANK(room07_03_mask_secret_door3),			room07_03_mask_secret_door3
	dbw BANK(room07_03_mask_secret_door4),			room07_03_mask_secret_door4
room13_crest_panel_masks_pointer: ;7B1A
	dbw BANK(room13_04_mask_crest_panel),			room13_04_mask_crest_panel
room01_03_blood_mask_pointer: ;7B1D
	dbw BANK(room01_03_mask_blood),					room01_03_mask_blood
room38_02_masks_pointers: ;7B20
	dbw BANK(room38_02_mask_cascade1),				room38_02_mask_cascade1
	dbw BANK(room38_02_mask_cascade2),				room38_02_mask_cascade2
	dbw BANK(room38_02_mask_cascade3),				room38_02_mask_cascade3
	dbw BANK(room38_02_mask_cascade4),				room38_02_mask_cascade4
room4B_aqua_tank_flood_masks: ;7B2C
	dbw BANK(room4B_00_mask_aquarium_flood_bBC),		room4B_00_mask_aquarium_flood_bBC
	dbw BANK(room4B_01_mask_aquarium_flood),			room4B_01_mask_aquarium_flood
	dbw BANK(room4B_02_mask_aquarium_flood),			room4B_02_mask_aquarium_flood
	dbw BANK(room4B_03_mask_aquarium_flood),			room4B_03_mask_aquarium_flood
	dbw BANK(room4B_04_mask_aquarium_flood),			room4B_04_mask_aquarium_flood
	dbw BANK(room4B_05_mask_aquarium_flood_bBD),		room4B_05_mask_aquarium_flood_bBD

room4C_flooded_corridor_masks: ;7B3E
	dbw BANK(room4C_05_mask_corridor_flood),			room4C_05_mask_corridor_flood

room4D_control_room_flooded_masks: ;7B41
	dbw BANK(room4D_00_mask_flood),					room4D_00_mask_flood
	dbw BANK(room4D_01_mask_flood),					room4D_01_mask_flood
	dbw BANK(room4D_02_mask_flood),					room4D_02_mask_flood
	dbw BANK(room4D_03_mask_switch1_bBE),			room4D_03_mask_switch1_bBE
	dbw BANK(room4D_03_mask_switch2),				room4D_03_mask_switch2

room37_flooded_gate_masks: ;7B50
	dbw BANK(room37_00_mask_full_pool),				room37_00_mask_full_pool
	dbw BANK(room37_01_mask_full_pool),				room37_01_mask_full_pool
	dbw BANK(room37_02_mask_full_pool),				room37_02_mask_full_pool

room58_flooded_roots_masks: ;7B59
	dbw BANK(room58_00_mask_flood_roots_bBF),		room58_00_mask_flood_roots_bBF
	dbw BANK(room58_01_mask_flood_roots),			room58_01_mask_flood_roots
	dbw BANK(room58_02_mask_flood_roots),			room58_02_mask_flood_roots
	dbw BANK(room58_03_mask_flood_roots),			room58_03_mask_flood_roots
	dbw BANK(room58_04_mask_flood_roots),			room58_04_mask_flood_roots
room11_bathtub_masks_pointers: ;7B68
	dbw BANK(room11_03_mask_full_bathtube_bC0),		room11_03_mask_full_bathtube_bC0
	dbw BANK(room11_01_mask_full_bathtube),			room11_01_mask_full_bathtube
room49_dorm_bathtub_masks: ;7B6E
	dbw BANK(room49_00_mask_full_bathtube),			room49_00_mask_full_bathtube
	dbw BANK(room49_01_mask_full_bathtube),			room49_01_mask_full_bathtube

room58_roots_masks: ;7B74
	dbw BANK(room58_01_mask_roots),				room58_01_mask_roots
	dbw BANK(room58_02_mask_roots),				room58_02_mask_roots

room2A_01_rope_mask_pointer: ;7B7A
	dbw BANK(room2A_01_mask_rope),				room2A_01_mask_rope

room2A_tomb_mask_pointer: ;7B7D
	dbw BANK(room2A_01_mask_open_tomb),			room2A_01_mask_open_tomb
	dbw BANK(room2A_02_mask_open_tomb1),		room2A_02_mask_open_tomb1
	dbw BANK(room2A_02_mask_open_tomb2_bC1),	room2A_02_mask_open_tomb2_bC1

room2A_03_rope_mask_pointer: ;7B86
	dbw BANK(room2A_03_mask_rope),				room2A_03_mask_rope

room3E_rotate_floor_2_masks: ;7B89
	dbw BANK(room3E_05_mask_catacomb_crank1),			room3E_05_mask_catacomb_crank1
	dbw BANK(room3E_05_mask_catacomb_crank2),			room3E_05_mask_catacomb_crank2
	dbw BANK(room3E_05_mask_catacomb_crank3),			room3E_05_mask_catacomb_crank3
room3E_rotate_floor_1_masks: ;7B92
	dbw BANK(room3F_05_mask_catacomb_crank1),			room3F_05_mask_catacomb_crank1
	dbw BANK(room3F_05_mask_catacomb_crank2),			room3F_05_mask_catacomb_crank2
	dbw BANK(room3F_05_mask_catacomb_crank3_bC2),		room3F_05_mask_catacomb_crank3_bC2
	dbw BANK(room3F_05_mask_catacomb_crank4),			room3F_05_mask_catacomb_crank4
	dbw BANK(room3F_05_mask_catacomb_crank5),			room3F_05_mask_catacomb_crank5

room45_03_masks_pointers: ;7BA1
	dbw BANK(room45_03_mask_spiderweb1),			room45_03_mask_spiderweb1
	dbw BANK(room45_03_mask_spiderweb2),			room45_03_mask_spiderweb2
	dbw BANK(room45_03_mask_spiderweb3),			room45_03_mask_spiderweb3
room45_00_masks_pointers: ;7BAA
	dbw BANK(room45_00_mask_spiderweb1),			room45_00_mask_spiderweb1
	dbw BANK(room45_00_mask_spiderweb2),			room45_00_mask_spiderweb2
	dbw BANK(room45_00_mask_spiderweb3),			room45_00_mask_spiderweb3
room45_01_masks_pointers: ;7BB3
	dbw BANK(room45_01_mask_spiderweb),				room45_01_mask_spiderweb
room45_02_masks_pointers: ;7BB6
	dbw BANK(room45_02_mask_spiderweb),				room45_02_mask_spiderweb
	dbw BANK(room45_incomplete_mask_spiderweb),		room45_incomplete_mask_spiderweb


; valid BG Masks ends here, next addresses are not valid %fix
;7BBC
	dbw $C4, $41B0
computer_keyboard_bg: ;7BBF
	dbw $C4, $4500
selected_keyboard_keys_bg: ;7BC2
	dbw $C4, $4D40
lab_computer_startup_bg_mask: ;7BC5
	dbw $C4, $5310
underground_statue_wall_masks: ;$7BC8
	dbw $C4, $5670
;7BCB
	dbw $C4, $5B20
;7BCE
	dbw $C4, $5F70
;7BD1
	dbw $C4, $6280
library_secret_door_mask: ;7BD4
	dbw $C4, $65B0

;projector slides
projector_slide_02_mask: ;7BD7
	dbw $C4, $6B50
projector_slide_03_mask: ;7BDA
	dbw $C4, $7350
projector_slide_04_mask: ;7BDD
	dbw $C4, $7BC0
projector_slide_05_mask: ;7BE0
	dbw $C5, $4510
projector_slide_01_mask: ;7BE3
	dbw $C5, $50E0
