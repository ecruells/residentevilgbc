; Entities sprite frames are 32px wide, divided in two main sections of 16px. Each section horizontal
; lines are stored in an interlazed pattern, odd lines for the left side (left 8px) and even lines for 
; the right side (right 8px).
; When these 8px subsections lines are shrank, gaps of empty space are generated, so to "join" these
; parts, we must shift each line parts to join them. The left main side lines are shifted to the right
; and the right main side lines are shifted to the left.
; 
; full 32px line example (no shrinking)
; xxxxxxxxyyyyyyyynnnnnnnneeeeeeee
; 
; left side                  right side
; xxxxxxxx-yyyyyyyy | nnnnnnnn-eeeeeeee
; odd      even       odd      even
; 
; this looks like if we shrink them by a width pattern of x7 ( 8 to 5 in odd line (01101101)* and 8 to 4 in 
; even line (10101010)*) [*zeros are skipped pixels]
; ...xxxxx....yyyy...nnnnn....eeee
; 
; Shift the left side first, as we are using a width pattern of 7, we use "right_shifting_x4" routine, this
; shift only the odd line 4 pixels to the right
; ...xxxxx....yyyy => .......xxxxxyyyy
; 
; then, we shift the right side, using the width pattern of x7, we use "left_shift_lines_x3_x4" routine, this
; shift the odd line 3px to the left and the even line 4 pixels to the left
; ...nnnnn....eeee => nnnnneeee.......
; 
; as a result, we get a joined shrank sprite line
; .......xxxxxyyyynnnnneeee.......


shrankLinesShiftingRoutines: ; 00:270B
; left sprite side (16px) shifting routines
	dw no_right_shifting ; 	0
	dw right_shifting_x1 ; 	1
	dw right_shifting_x1 ; 	2
	dw right_shifting_x2 ; 	3
	dw right_shifting_x2 ; 	4
	dw right_shifting_x3 ; 	5
	dw right_shifting_x3 ; 	6
	dw right_shifting_x4 ; 	7
	dw right_shifting_x4 ; 	8
	dw right_shifting_x5 ; 	9
	dw right_shifting_x5 ; 	10
	dw right_shifting_x6 ; 	11
	dw right_shifting_x6 ; 	12
	dw $0000
	dw $0000
	dw $0000
; right sprite side (16px) shifting routines
	dw no_left_shifting         ; 0
	dw left_shift_even_line_x1  ; 1
	dw left_shift_lines_x1      ; 2
	dw left_shift_lines_x1_x2   ; 3
	dw left_shift_lines_x2      ; 4
	dw left_shift_lines_x2_x3   ; 5
	dw left_shift_lines_x3      ; 6
	dw left_shift_lines_x3_x4   ; 7
	dw left_shift_lines_x4_x8   ; 8
	dw left_shift_lines_x4_x9   ; 9
	dw left_shift_lines_x5_x10  ; 10
	dw left_shift_lines_x5_x11  ; 11
	dw left_shift_lines_x6_x12  ; 12

no_right_shifting: ; full width
	ret

; de: odd line bytes
; bc: even line bytes
; bc = ((de & 101) * 128) | bc
; de = de >> 1 (reset MSB)
right_shifting_x1: ; 00:2746
    ld a, e
    and a, $01 ; ((e & 1) * 128) | c
    add a
    add a
    add a
    add a
    add a
    add a
    add a
    or a, c
    ld c, a
    srl e
    ld a, d
    and a, $01 ; ((d & 1) * 128) | b
    add a
    add a
    add a
    add a
    add a
    add a
    add a
    or a, b
    ld b, a
    srl d
    ret

; de: odd line bytes
; bc: even line bytes
; bc = ((de & 303) * 64) | bc
; de = de >> 2 (reset MSB)
right_shifting_x2: ; 00:2763
    ld a, e
    and a, $03
    add a
    add a
    add a
    add a
    add a
    add a
    or a, c
    ld c, a
    srl e
    srl e
    ld a, d
    and a, $03
    add a
    add a
    add a
    add a
    add a
    add a
    or a, b
    ld b, a
    srl d
    srl d
    ret

; de: odd line bytes
; bc: even line bytes
; bc = ((de & 707) * 32) | bc
; de = de >> 3 (reset MSB)
right_shifting_x3: ; 00:2782
    ld a, e
    and a, $07
    add a
    add a
    add a
    add a
    add a
    or a, c
    ld c, a
    srl e
    srl e
    srl e
    ld a, d
    and a, $07
    add a
    add a
    add a
    add a
    add a
    or a, b
    ld b, a
    srl d
    srl d
    srl d
    ret

; de: odd line bytes
; bc: even line bytes
; bc = ((de & F0F) * 16) | bc
; de = 0
right_shifting_x4: ; 00:27A3
    ld a, e
    and a, $0F
    add a
    add a
    add a
    add a
    or a, c
    ld c, a
    ld e, $00
    ld a, d
    and a, $0F
    add a
    add a
    add a
    add a
    or a, b
    ld b, a
    ld d, $00
    ret

; de: odd line bytes
; bc: even line bytes
; bc = (de * 8) | bc
; de = 0
right_shifting_x5: ; 00:27BA
    ld a, e
    add a
    add a
    add a
    or a, c
    ld c, a
    ld e, $00
    ld a, d
    add a
    add a
    add a
    or a, b
    ld b, a
    ld d, $00
    ret

; de: odd line bytes
; bc: even line bytes
; bc = (de * 4) | bc
; de = 0
right_shifting_x6: ; 00:27CB
    ld a, e
    add a
    add a
    or a, c
    ld c, a
    ld e, $00
    ld a, d
    add a
    add a
    or a, b
    ld b, a
    ld d, $00
    ret

no_left_shifting: ; 00:27DA
	ret

; bc: even line bytes
; bc = bc << 1 (Reset LSB)
left_shift_even_line_x1: ; 00:27DB
    sla c
    sla b
    ret

; de: odd line bytes
; bc: even line bytes
; de = (bc >> 6) | (de << 1)
; bc = (bc & 3F3F) * 4
left_shift_lines_x1: ; 00:27E0
    sla e
    ld a, c
    srl a
    srl a
    srl a
    srl a
    srl a
    srl a
    or a, e
    ld e, a ; e = (c >> 6) | (e << 1)
    ld a, c
    and a, $3F
    add a
    add a
    ld c, a ; c = (c & 3F) * 4
    sla d
    ld a, b
    srl a
    srl a
    srl a
    srl a
    srl a
    srl a
    or a, d
    ld d, a ; d = (b >> 6) | (d << 1)
    ld a, b
    and a, $3F
    add a
    add a
    ld b, a ; b = (b & 3F) * 4
    ret

; left shift odd line 1px and even line 2px
; de: odd line bytes
; bc: even line bytes
; de = (bc >> 5) | (de << 1)
; bc = (bc & 1F1F) * 8
left_shift_lines_x1_x2: ; 00:280F
    sla e
    ld a, c
    srl a
    srl a
    srl a
    srl a
    srl a
    or a, e
    ld e, a
    ld a, c
    and a, $1F
    add a
    add a
    add a
    ld c, a
    sla d
    ld a, b
    srl a
    srl a
    srl a
    srl a
    srl a
    or a, d
    ld d, a
    ld a, b
    and a, $1F
    add a
    add a
    add a
    ld b, a
    ret

; left shift lines by 2px
; de: odd line bytes
; bc: even line bytes
; de = (bc >> 4) | (de << 2)
; bc = (bc & F0F) * 16
left_shift_lines_x2: ; 00:283C
    sla e
    sla e
    ld a, c
    srl a
    srl a
    srl a
    srl a
    or a, e
    ld e, a
    ld a, c
    and a, $0F
    add a
    add a
    add a
    add a
    ld c, a
    sla d
    sla d
    ld a, b
    srl a
    srl a
    srl a
    srl a
    or a, d
    ld d, a
    ld a, b
    and a, $0F
    add a
    add a
    add a
    add a
    ld b, a
    ret

; left shift odd line 2px and even line 3px
; de: odd line bytes
; bc: even line bytes
; de = (bc >> 3) | (de << 2)
; bc = (bc & 707) * 32
left_shift_lines_x2_x3: ; 00:286B
    sla e
    sla e
    ld a, c
    srl a
    srl a
    srl a
    or a, e
    ld e, a
    ld a, c
    and a, $07
    add a
    add a
    add a
    add a
    add a
    ld c, a
    sla d
    sla d
    ld a, b
    srl a
    srl a
    srl a
    or a, d
    ld d, a
    ld a, b
    and a, $07
    add a
    add a
    add a
    add a
    add a
    ld b, a
    ret

; left shift lines 3px
; de: odd line bytes
; bc: even line bytes
; de = (bc >> 2) | (de << 3)
; bc = (bc & 303) * 64
left_shift_lines_x3: ; 00:2898
    sla e
    sla e
    sla e
    ld a, c
    srl a
    srl a
    or a, e
    ld e, a
    ld a, c
    and a, $03
    add a
    add a
    add a
    add a
    add a
    add a
    ld c, a
    sla d
    sla d
    sla d
    ld a, b
    srl a
    srl a
    or a, d
    ld d, a
    ld a, b
    and a, $03
    add a
    add a
    add a
    add a
    add a
    add a
    ld b, a
    ret

; left shift odd line 3px and even line 4px
; de: odd line bytes
; bc: even line bytes
; de = (bc >> 1) | (de << 3)
; bc = (bc & 101) * 128
left_shift_lines_x3_x4: ; 00:28C7
    sla e
    sla e
    sla e
    ld a, c
    srl a
    or a, e
    ld e, a
    ld a, c
    and a, $01
    add a
    add a
    add a
    add a
    add a
    add a
    add a
    ld c, a
    sla d
    sla d
    sla d
    ld a, b
    srl a
    or a, d
    ld d, a
    ld a, b
    and a, $01
    add a
    add a
    add a
    add a
    add a
    add a
    add a
    ld b, a
    ret

; left shift odd line 4px and even line 8px
; de: odd line bytes
; bc: even line bytes
; de = (de << 4) | bc
; bc = 0
left_shift_lines_x4_x8: ; 00:28F4
    sla e
    sla e
    sla e
    sla e
    ld a, c
    or a, e
    ld e, a
    ld c, $00
    sla d
    sla d
    sla d
    sla d
    ld a, b
    or a, d
    ld d, a
    ld b, $00
    ret

; left shift odd line 4px and even line 9px
; de: odd line bytes
; bc: even line bytes
; de = (de << 4) | (bc * 2)
; bc = 0
left_shift_lines_x4_x9: ; 00:290F
    sla e
    sla e
    sla e
    sla e
    ld a, c
    add a
    or a, e
    ld e, a
    ld c, $00
    sla d
    sla d
    sla d
    sla d
    ld a, b
    add a
    or a, d
    ld d, a
    ld b, $00
    ret

; left shift odd line 5px and even line 10px
; de: odd line bytes
; bc: even line bytes
; de = (de << 5) | (bc * 4)
; bc = 0
left_shift_lines_x5_x10: ; 00:292C
    sla e
    sla e
    sla e
    sla e
    sla e
    ld a, c
    add a
    add a
    or a, e
    ld e, a
    ld c, $00
    sla d
    sla d
    sla d
    sla d
    sla d
    ld a, b
    add a
    add a
    or a, d
    ld d, a
    ld b, $00
    ret

; left shift odd line 5px and even line 11px
; de: odd line bytes
; bc: even line bytes
; de = (de << 5) | (bc * 8)
; bc = 0
left_shift_lines_x5_x11: ; 00:294F
    sla e
    sla e
    sla e
    sla e
    sla e
    ld a, c
    add a
    add a
    add a
    or a, e
    ld e, a
    ld c, $00
    sla d
    sla d
    sla d
    sla d
    sla d
    ld a, b
    add a
    add a
    add a
    or a, d
    ld d, a
    ld b, $00
    ret

; left shift odd line 6px and even line 12px
; de: odd line bytes
; bc: even line bytes
; de = (de << 6) | (bc * 16)
; bc = 0
left_shift_lines_x6_x12: ; 00:2974
    sla e
    sla e
    sla e
    sla e
    sla e
    sla e
    ld a, c
    add a
    add a
    add a
    add a
    or a, e
    ld e, a
    ld c, $00
    sla d
    sla d
    sla d
    sla d
    sla d
    sla d
    ld a, b
    add a
    add a
    add a
    add a
    or a, d
    ld d, a
    ld b, $00
    ret

