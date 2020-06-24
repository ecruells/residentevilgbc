; jump to routine address in HL, returns to bank 1. BC is not affected
;
; a: routine bank
; hl: routine address
jumpToHLRoutineA:: ;0280
    call bankSwitch
    ld de, returnPointerHL1
    push de
    jp hl
returnPointerHL1:
    push af
    ld a, $01
    call bankSwitch
    pop af
    ret

; jump to routine address in HL, returns to bank 1. DE is not affected
;
; a: routine bank
; hl: routine address
jumpToHLRoutineB:: ;0290
    call bankSwitch
    ld bc, returnPointerHL2
    push bc
    jp hl
returnPointerHL2:
    push af
    ld a, $01
    call bankSwitch
    pop af
    ret

; jump to routine address in HL, returns to previous bank.
;
; a: routine bank
; hl: routine address
jumpToHLRoutineC:: ;02A0
	ld c, a
	ld a, [wCurrentRomBank]
	push af
	ld a, c
	call bankSwitch
	ld de, returnPointerHL3
	push de
	jp hl
returnPointerHL3:
	pop af
	jp bankSwitch