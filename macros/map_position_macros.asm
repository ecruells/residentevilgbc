; set entity positions macros

loadPositionX: MACRO
	ld [hl], LOW(\1)
    inc hl
    ld [hl], HIGH(\1)
ENDM

loadPositionZ: MACRO
	ld [hl], LOW(\1)
    inc hl
    ld [hl], HIGH(\1)
ENDM

loadPositionY: MACRO
	ld [hl], LOW(\1)
    inc hl
    ld [hl], HIGH(\1)
ENDM


; check position var

positionVarGteX: MACRO
    ld a, [wEntityPositionX+1]
    cp a, HIGH(\1)
    ret nz
    ld a, [wEntityPositionX]
    cp a, LOW(\1)
    ret c
ENDM

positionVarGteZ1AndLtZ2: MACRO
    ld a, [wEntityPositionZ+1]
    cp a, HIGH(\1)
    jr z, .checkOtherRange\@
    ld a, [wEntityPositionZ]
    cp a, LOW(\2)
    ret nc
    jr .continue\@
.checkOtherRange\@
    ld a, [wEntityPositionZ]
    cp a, LOW(\1)
    ret c
.continue\@
ENDM


; check position bc (x), de (z)


positionEquX: MACRO
    ld a, b
    or a
    ret nz
    ld a, c
    cp a, LOW(\1)
    ret nz
ENDM

positionGteX: MACRO
    ld a, b
if \1 >= 0
    or a
else
    cp a, HIGH(\1)
endc
    ret nz
    ld a, c
    cp a, LOW(\1)
    ret c
ENDM

positionLtX: MACRO
    ld a, b
if \1 >= 0
    or a
else
    cp a, HIGH(\1)
endc
    ret nz
    ld a, c
    cp a, LOW(\1)
    ret nc
ENDM

positionGteZ: MACRO
    ld a, d
if \1 >= 0
    or a
else
    cp a, HIGH(\1)
endc
    ret nz
    ld a, e
    cp a, LOW(\1)
    ret c
ENDM

positionDEGte: MACRO
    positionGteZ \1
ENDM

positionLtZ: MACRO
    ld a, d
if \1 >= 0
    or a
else
    cp a, HIGH(\1)
endc
    ret nz
    ld a, e
    cp a, LOW(\1)
    ret nc
ENDM

positionDeLt: MACRO
    or a
    ret nz
    ld a, e
    cp a, \1
    ret nc
ENDM

positionLtXLow: MACRO
    cp a, LOW(\1)
    ret nc
ENDM

positionGteZLow: MACRO
    cp a, LOW(\1)
    ret c
ENDM

positionLtZLow: MACRO
    cp a, LOW(\1)
    ret nc
ENDM

positionLtZLowV2: MACRO
    ld a, e
    cp a, LOW(\1)
    ret nc
ENDM

positionDeLtZLow: MACRO
    positionLtZLow \1
ENDM


positionDeLtZero: MACRO
    ld a, d
    cp a, $FF
    ret nz
ENDM

positionDeGteZeroOrJump: MACRO
    ld a, d
    cp a, $FF
    jr z, \1
ENDM

positionDeGteZeroOrJumpV2: MACRO
    ld a, d
    cp a, $80
    jr nc, \1
ENDM


positionGteX1AndLtX2: MACRO
    ld a, b
    cp a, HIGH(\1)
    jr z, .checkOtherRange\@
    ld a, c
    cp a, LOW(\2)
    ret nc
    jr .continue\@
.checkOtherRange\@
    ld a, c
    cp a, LOW(\1)
    ret c
.continue\@
ENDM

positionGteX1AndLtX2V2: MACRO
    ld a, b
    or a
    ret nz
    ld a, c
    cp a, LOW(\1)
    ret c
    cp a, LOW(\2)
    ret nc
ENDM

positionGteZ1AndLtZ2: MACRO
    ld a, d
    cp a, HIGH(\1)
    jr z, .checkOtherRange\@
    ld a, e
    cp a, LOW(\2)
    ret nc
    jr .continue\@
.checkOtherRange\@
    ld a, e
    cp a, LOW(\1)
    ret c
.continue\@
ENDM

positionGteZ1AndLtZ2V2: MACRO
    ld a, d
if \1 >= 0
    or a
else
    cp a, HIGH(\1)
endc
    ret nz
    ld a, e
    cp a, LOW(\1)
    ret c
    cp a, LOW(\2)
    ret nc
ENDM

positionLtZ1AndGteZ2: MACRO
    ld a, d
    or a
    jp z, .checkOtherRange\@
    ld a, e
    cp a, LOW(\2)
    ret c
    jr .continue\@
.checkOtherRange\@:
    ld a, e
    cp a, LOW(\1)
    ret nc
.continue\@
ENDM

positionDeLt1AndGte2: MACRO
    ld a, d
    or a
    jr z, .checkOtherRange\@
    ld a, e
    cp a, LOW(\2)
    ret c
    jr .continue\@
.checkOtherRange\@:
    ld a, e
    cp a, LOW(\1)
    ret nc
.continue\@
ENDM


; position var reference

positionVarLt: MACRO
    ld a, [hld]
if \1 >= 0 && \1 < 256
    or a
else
    cp a, HIGH(\1)
endc
    jp nz, \2
    ld a, [hl]
    cp a, LOW(\1)
    jp nc, \2
ENDM

positionVarLtV2: MACRO
    ld a, [hld]
if \1 >= 0 && \1 < 256
    or a
else
    cp a, HIGH(\1)
endc
    jr nz, \2
    ld a, [hl]
    cp a, LOW(\1)
    jr nc, \2
ENDM

positionVarGte: MACRO
    ld a, [hld]
if \1 >= 0 && \1 < 256
    or a
else
    cp a, HIGH(\1)
endc
    jp nz, \2
    ld a, [hl]
    cp a, LOW(\1)
    jp c, \2
ENDM


