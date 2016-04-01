default_main_theme_ch1: ;5B55
	enableSound $FF
	tempo 180
	chainWait 10
	chainWait 10
	chainWait 10
	chainWait 10
	branchId $36
	semitone_tsp -28, 1
	branchId $3A
	semitone_tsp -28, 1
	branchId $3D
	semitone_tsp -40, 1
	chainWait 4
	chlAction0x66 1
	channelLoop default_main_theme_ch1

default_main_theme_ch2: ;5B74
	branchId $37
	semitone_tsp -28, 1
	chainWait 4
	branchId $36
	semitone_tsp -28, 1
	branchId $3A
	semitone_tsp -28, 1
	branchId $3D
	semitone_tsp -40, 1
	channelLoop default_main_theme_ch2

default_main_theme_ch3: ;5B89
	branchId $38
	db $F0, $03
	branchId $3C
	db $F0, $02
	branchId $3F
	db $F0, $01
	channelLoop default_main_theme_ch3

default_main_theme_ch4: ;5B98
	branchId $39
	db $00, $18
	channelLoop default_main_theme_ch4

default_main_theme_branch_5B9F: ;5B9F
	typenote0 A#6, 15, 6
	typenote0 C_7, 15, 6
	typenote0 C#7, 15, 6
	typenote0 F_7, 15, 6
	typenote0 F#7, 15, 4
	typenote0 G#7, 15, 4
	typenote0 A_7, 15, 6
	typenote0 C#8, 15, 6
	typenote0 A_7, 15, 4
	typenote0 F#7, 15, 4
	typenote0 A#7, 15, 8
	typenote0 F_8, 15, 8
	typenote0 F#8, 15, 6
	typenote0 C#8, 15, 6
	typenote0 A_7, 15, 6
	typenote0 F#7, 15, 6
	typenote0 C#8, 15, 4
	typenote0 C_8, 15, 4
	typenote0 C#8, 15, 6
	typenote0 A#7, 15, 6
	typenote0 F_7, 15, 6
	typenote0 A_7, 15, 6
	typenote0 G#7, 15, 6
	typenote0 F#7, 15, 6
	typenote0 C#7, 15, 6
	typenote0 F_7, 15, 8
	typenote0 C#7, 15, 6
	typenote0 A#6, 15, 6
	typenote0 A_6, 15, 10
	branchEnd

default_main_theme_branch_5BDA: ;5BDA
	typenote1 A#7, 10, 13
	typenote1 C_8, 10, 13
	typenote1 C#8, 10, 13
	typenote1 F_8, 10, 13
	typenote1 C#8, 10, 13
	typenote1 C_8, 10, 13
	typenote1 A#7, 10, 13
	typenote1 C_8, 10, 13
	typenote1 C#8, 10, 13
	typenote1 F_8, 10, 13
	typenote1 C#8, 10, 13
	typenote1 C_8, 10, 13
	typenote1 A_7, 10, 13
	typenote1 C#8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 C#8, 10, 13
	typenote1 A_7, 10, 13
	typenote1 C#8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 C#8, 10, 13
	typenote1 A#7, 10, 13
	typenote1 C_8, 10, 13
	typenote1 C#8, 10, 13
	typenote1 F_8, 10, 13
	typenote1 C#8, 10, 13
	typenote1 C_8, 10, 13
	typenote1 A#7, 10, 13
	typenote1 C_8, 10, 13
	typenote1 C#8, 10, 13
	typenote1 F_8, 10, 13
	typenote1 C#8, 10, 13
	typenote1 C_8, 10, 13
	typenote1 A_7, 10, 13
	typenote1 C#8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 C#8, 10, 13
	typenote1 A_7, 10, 13
	typenote1 C#8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 C#8, 10, 13
	branchEnd


default_main_theme_branch_5C3B: ;5C3B
	typenote1 A#5, 2, 8
	typenote1 F_6, 2, 8
	typenote1 F#6, 2, 9
	typenote1 F#5, 2, 4
	typenote1 A_5, 2, 4
	typenote1 A#5, 2, 8
	typenote1 F_6, 2, 8
	typenote1 F#6, 2, 9
	typenote1 F#5, 2, 6
	branchEnd

default_main_theme_branch_5C4E: ;5C4E
	typenote0 C#5, 1, 4
	typenote0 C#5, 1, 4
	typenote0 B_5, 5, 4
	typenote0 C#5, 1, 4
	typenote0 C#5, 1, 6
	typenote0 B_5, 5, 6
	typenote0 C#5, 1, 4
	typenote0 C#5, 1, 4
	typenote0 B_5, 5, 4
	typenote0 C#5, 1, 4
	typenote0 C#5, 1, 4
	typenote0 B_5, 5, 7
	typenote0 C#5, 1, 4
	typenote0 C#5, 1, 4
	typenote0 B_5, 5, 4
	typenote0 C#5, 1, 4
	typenote0 C#5, 1, 4
	typenote0 C#5, 1, 4
	typenote0 B_5, 5, 6
	typenote0 C#5, 1, 4
	typenote0 C#5, 1, 4
	typenote0 B_5, 5, 4
	typenote0 C#5, 1, 4
	typenote0 C#5, 1, 4
	typenote0 B_5, 5, 4
	typenote0 C#5, 1, 6
	branchEnd

default_main_theme_branch_5C83: ;5C83
	typenote1 D#7, 15, 8
	typenote1 A#7, 15, 6
	typenote1 B_7, 15, 4
	typenote1 A#7, 15, 4
	typenote1 A_7, 15, 7
	typenote1 G#7, 15, 4
	typenote1 F#7, 15, 4
	typenote1 A_7, 15, 4
	typenote1 C#8, 15, 6
	typenote1 D#8, 15, 8
	typenote1 A#7, 15, 7
	typenote1 D#8, 15, 2
	typenote1 F_8, 15, 2
	typenote1 F#8, 15, 6
	typenote1 C#8, 15, 6
	typenote1 A_7, 15, 6
	typenote1 F#7, 15, 6
	typenote1 A#6, 15, 6
	typenote1 D#7, 15, 7
	typenote1 E_7, 15, 4
	typenote1 F_7, 15, 6
	typenote1 F#7, 15, 7
	typenote1 G_7, 15, 2
	typenote1 G#7, 15, 2
	typenote1 A_7, 15, 6
	typenote1 C#8, 15, 6
	typenote1 D#8, 15, 6
	typenote1 A#7, 15, 6
	typenote1 F#7, 15, 6
	typenote1 D#7, 15, 6
	typenote1 A_7, 15, 10
	branchEnd

default_main_theme_branch_5CC2: ;5CC2
	typenote1 D#8, 10, 13
	typenote1 F_8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 A#8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 F_8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 F_8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 A#8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 F_8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 G#8, 10, 13
	typenote1 A_8, 10, 13
	typenote1 C#9, 10, 13
	typenote1 A_8, 10, 13
	typenote1 G#8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 G#8, 10, 13
	typenote1 A_8, 10, 13
	typenote1 C#9, 10, 13
	typenote1 A_8, 10, 13
	typenote1 G#8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 F_8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 A#8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 F_8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 F_8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 A#8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 F_8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 G#8, 10, 13
	typenote1 A_8, 10, 13
	typenote1 C#9, 10, 13
	typenote1 A_8, 10, 13
	typenote1 G#8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 G#8, 10, 13
	typenote1 A_8, 10, 13
	typenote1 C#9, 10, 13
	typenote1 A_8, 10, 13
	typenote1 G#8, 10, 13
	branchEnd

default_main_theme_branch_5D23: ;5D23
	typenote1 D#6, 2, 8
	typenote1 D#5, 2, 7
	typenote1 E_5, 2, 2
	typenote1 F_5, 2, 2
	typenote1 F#5, 2, 7
	typenote1 G#5, 2, 4
	typenote1 A_5, 2, 4
	typenote1 F#5, 2, 4
	typenote1 A_5, 2, 4
	typenote1 C#6, 2, 4
	typenote1 D#6, 2, 8
	typenote1 D#5, 2, 7
	typenote1 D#6, 2, 4
	typenote1 F#5, 2, 8
	typenote1 F#6, 2, 4
	typenote1 C#6, 2, 4
	typenote1 A_5, 2, 4
	typenote1 F#5, 2, 4
	branchEnd

default_main_theme_branch_5D48: ;5D48
	typenote0 B_8, 15, 8
	typenote0 B_9, 15, 8
	typenote0 A_9, 15, 10
	typenote0 B_8, 15, 8
	typenote0 B_9, 15, 8
	typenote0 A_9, 15, 10
	typenote0 F_9, 15, 8
	typenote0 D#9, 15, 8
	typenote0 C#9, 15, 8
	typenote0 C_9, 15, 10
	typenote0 C#6, 0, 6
	typenote0 C#6, 0, 4
	branchEnd

default_main_theme_branch_5D61: ;5D61
	typenote1 B_7, 10, 13
	typenote1 C_8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 C_8, 10, 13
	typenote1 B_7, 10, 13
	typenote1 C_8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 C_8, 10, 13
	typenote1 A_7, 10, 13
	typenote1 C_8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 C_8, 10, 13
	typenote1 A_7, 10, 13
	typenote1 C_8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 C_8, 10, 13
	typenote1 B_7, 10, 13
	typenote1 C_8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 C_8, 10, 13
	typenote1 B_7, 10, 13
	typenote1 C_8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 C_8, 10, 13
	typenote1 A_7, 10, 13
	typenote1 C_8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 C_8, 10, 13
	typenote1 A_7, 10, 13
	typenote1 C_8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 C_8, 10, 13
	typenote1 A_7, 10, 13
	typenote1 C_8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 F_8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 C_8, 10, 13
	typenote1 A_7, 10, 13
	typenote1 C_8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 F_8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 C_8, 10, 13
	typenote1 F_7, 10, 13
	typenote1 A_7, 10, 13
	typenote1 C_8, 10, 13
	typenote1 F#8, 10, 13
	typenote1 C_8, 10, 13
	typenote1 A_7, 10, 13
	typenote1 F_7, 10, 13
	typenote1 A_7, 10, 13
	typenote1 C_8, 10, 13
	typenote1 F_8, 10, 13
	typenote1 C_8, 10, 13
	typenote1 A_7, 10, 13
	typenote1 F_7, 10, 13
	typenote1 A_7, 10, 13
	typenote1 C_8, 10, 13
	typenote1 D#8, 10, 13
	typenote1 C_8, 10, 13
	typenote1 A_7, 10, 13
	typenote1 F_7, 10, 13
	typenote1 A_7, 10, 13
	typenote1 C_8, 10, 13
	typenote1 C#8, 10, 13
	typenote1 C_8, 10, 13
	typenote1 A_7, 10, 13
	branchEnd

default_main_theme_branch_5E0A: ;5E0A
	typenote1 B_5, 2, 4
	typenote1 B_5, 2, 6
	typenote1 B_5, 2, 4
	typenote1 B_6, 2, 6
	typenote1 B_5, 2, 6
	typenote1 F_6, 2, 4
	typenote1 F_6, 2, 6
	typenote1 F_6, 2, 4
	typenote1 F_5, 2, 6
	typenote1 F_6, 2, 6
	typenote1 B_5, 2, 4
	typenote1 B_5, 2, 6
	typenote1 B_5, 2, 4
	typenote1 B_6, 2, 6
	typenote1 B_5, 2, 6
	typenote1 F_5, 2, 4
	typenote1 F_5, 2, 6
	typenote1 F_5, 2, 4
	typenote1 F_6, 2, 4
	typenote1 F_5, 2, 4
	typenote1 A_5, 2, 4
	typenote1 F_5, 2, 4
	typenote1 F_5, 2, 4
	typenote1 F_5, 2, 6
	typenote1 F_5, 2, 4
	typenote1 F_6, 2, 6
	typenote1 C_6, 2, 6
	typenote1 F_5, 2, 6
	typenote1 F_6, 2, 6
	typenote1 C_6, 2, 6
	typenote1 F_5, 2, 6
	typenote1 F_6, 2, 6
	typenote1 C_6, 2, 6
	typenote1 F_5, 2, 6
	typenote1 F_6, 2, 6
	branchEnd
;5E51
