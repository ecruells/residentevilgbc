moonlight_sonata_ch1: ;65C2
	enableSound $FF
	tempo 185
	playBranch moonlightSonataBranches, 0, -28, 1
	playBranch moonlightSonataBranches, 3, -28, 1
	chlAction0x66 1
	chainWait 0
	endChannel

moonlight_sonata_ch2: ;65D3
	playBranch moonlightSonataBranches, 1, -28, 1
	playBranch moonlightSonataBranches, 4, -28, 1
	chainWait 0
	endChannel

moonlight_sonata_ch3: ;65DE
	playBranch moonlightSonataBranches, 2, -16, 1
	playBranch moonlightSonataBranches, 5, -16, 1
	chainWait 0
	endChannel

moonlight_sonata_ch4: ;65E9
	endChannel



moonlight_sonata_branch_65EA: ;65EA
	typenote0 C#6, 0, 12
	typenote0 C#6, 0, 12
	typenote0 C#6, 0, 12
	typenote0 C#6, 0, 12
	typenote0 C#6, 0, 11
	typenote0 A_8, 12, 7
	typenote0 A_8, 12, 4
	branchEnd

moonlight_sonata_branch_65F9: ;65F9
	typenote0 A_7, 10, 14
	typenote0 D_8, 10, 14
	typenote0 F_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 D_8, 10, 14
	typenote0 F_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 D_8, 10, 14
	typenote0 F_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 D_8, 10, 14
	typenote0 F_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 D_8, 10, 14
	typenote0 F_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 D_8, 10, 14
	typenote0 F_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 D_8, 10, 14
	typenote0 F_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 D_8, 10, 14
	typenote0 F_8, 10, 14
	typenote0 A#7, 10, 14
	typenote0 D_8, 10, 14
	typenote0 F_8, 10, 14
	typenote0 A#7, 10, 14
	typenote0 D_8, 10, 14
	typenote0 F_8, 10, 14
	typenote0 A#7, 10, 14
	typenote0 D#8, 10, 14
	typenote0 G_8, 10, 14
	typenote0 A#7, 10, 14
	typenote0 D#8, 10, 14
	typenote0 G_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 C#8, 10, 14
	typenote0 G_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 D_8, 10, 14
	typenote0 F_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 D_8, 10, 14
	typenote0 E_8, 10, 14
	typenote0 G_7, 10, 14
	typenote0 C#8, 10, 14
	typenote0 E_8, 10, 14
	typenote0 F_7, 10, 14
	typenote0 A_7, 10, 14
	typenote0 D_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 D_8, 10, 14
	typenote0 F_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 D_8, 10, 14
	typenote0 F_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 D_8, 10, 14
	typenote0 F_8, 10, 14
	branchEnd

moonlight_sonata_branch_6672: ;6672
	typenote1 D_6, 2, 12
	typenote1 C_6, 2, 12
	typenote1 A#5, 2, 10
	typenote1 G_5, 2, 10
	typenote1 A_5, 2, 10
	typenote1 A_5, 2, 10
	typenote1 D_6, 2, 12
	branchEnd

moonlight_sonata_branch_6681: ;6681
	typenote0 A_8, 12, 11
	typenote0 A_8, 12, 7
	typenote0 A_8, 12, 4
	typenote0 A_8, 12, 10
	typenote0 A#8, 12, 10
	typenote0 A_8, 12, 10
	typenote0 G_8, 12, 8
	typenote0 C_9, 12, 8
	typenote0 F_8, 12, 12
	typenote0 F_8, 12, 12
	branchEnd

moonlight_sonata_branch_6696: ;6696
	typenote0 A_7, 10, 14
	typenote0 E_8, 10, 14
	typenote0 G_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 E_8, 10, 14
	typenote0 G_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 E_8, 10, 14
	typenote0 G_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 E_8, 10, 14
	typenote0 G_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 D_8, 10, 14
	typenote0 F_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 D_8, 10, 14
	typenote0 F_8, 10, 14
	typenote0 A#7, 10, 14
	typenote0 D_8, 10, 14
	typenote0 G_8, 10, 14
	typenote0 A#7, 10, 14
	typenote0 D_8, 10, 14
	typenote0 G_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 C_8, 10, 14
	typenote0 F_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 C_8, 10, 14
	typenote0 F_8, 10, 14
	typenote0 A#7, 10, 14
	typenote0 C_8, 10, 14
	typenote0 E_8, 10, 14
	typenote0 A#7, 10, 14
	typenote0 C_8, 10, 14
	typenote0 E_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 C_8, 10, 14
	typenote0 F_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 C_8, 10, 14
	typenote0 F_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 C_8, 10, 14
	typenote0 F_8, 10, 14
	typenote0 A_7, 10, 14
	typenote0 C_8, 10, 14
	typenote0 F_8, 10, 14
	typenote0 A_7, 12, 12
	branchEnd

moonlight_sonata_branch_66F9: ;66F9
	typenote1 C#6, 2, 12
	typenote1 D_6, 2, 10
	typenote1 G_5, 2, 10
	typenote1 C_6, 2, 10
	typenote1 C_6, 2, 10
	typenote1 F_6, 2, 12
	typenote1 F_5, 2, 12
	branchEnd
;6708
