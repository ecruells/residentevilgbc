
defaultCamera: MACRO
    ld c, \1
ENDM

setCamera: MACRO
    ld c, \1
ENDM

setCameraAndJump: MACRO
    ld c, \1
    jr \2
ENDM

; x > 0
changeCamOnXGtZero: MACRO
    ld a, h
    or a
    jr nz, .checkNextCondition\@
    ld a, l
    or a
    jr z, .checkNextCondition\@
    ld c, \1
.checkNextCondition\@
ENDM

; z > 0
changeCamOnZGtZero: MACRO
    ld a, d
    or a
    jr nz, .checkNextCondition\@
    ld a, e
    or a
    jr z, .checkNextCondition\@
    ld c, \1
.checkNextCondition\@
ENDM

; x >= 0
changeCamOnXGteZero: MACRO
    ld a, h
    or a
    jr nz, .checkNextCondition\@
    ld c, \1
.checkNextCondition\@
ENDM

; z >= 0
changeCamOnZGteZero: MACRO
    ld a, d
    or a
    jr nz, .checkNextCondition\@
    ld c, \1
.checkNextCondition\@
ENDM

; x pos < 0
changeCamOnXLtZero: MACRO
    ld a, h
    or a
    jr z, .checkNextCondition\@
    ld c, \1
.checkNextCondition\@
ENDM

; z pos < 0
changeCamOnZLtZero: MACRO
    ld a, d
    or a
    jr z, .checkNextCondition\@
    ld c, \1
.checkNextCondition\@
ENDM

; x pos < 0
changeCamOnXLtZeroV2: MACRO
    ld a, h
    cp a, $FF
    jr nz, .checkNextCondition\@
    ld c, \1
.checkNextCondition\@
ENDM

; z pos < 0
changeCamOnZLtZeroV2: MACRO
    ld a, d
    cp a, $FF
    jr nz, .checkNextCondition\@
    ld c, \1
.checkNextCondition\@
ENDM

; x < arg1
changeCamOnLtX: MACRO
    ld a, h
if \1 >= 0
    or a
    jr nz, .changeCamera\@
    ld a, l
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
else
    cp a, HIGH(\1)
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
endc
.changeCamera\@
    ld c, \2
.checkNextCondition\@
    ENDM

; z < arg1
changeCamOnLtZ: MACRO
    ld a, d
if \1 >= 0
    or a
    jr nz, .changeCamera\@
    ld a, e
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
else
    cp a, HIGH(\1)
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
endc
.changeCamera\@
    ld c, \2
.checkNextCondition\@
    ENDM

; z < arg1
changeCamOnLtZV2: MACRO
    ld a, d
    cp a, $FF
    jr z, .changeCamera\@
    ld a, e
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
.changeCamera\@
    ld c, \2
.checkNextCondition\@
ENDM

; x >= arg1
changeCamOnGteX: MACRO
    ld a, h
if \1 >= 0
    or a
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
else
    cp a, HIGH(\1)
    jr nz, .changeCamera\@
    ld a, l
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
endc
.changeCamera\@
    ld c, \2
.checkNextCondition\@
    ENDM

; x >= arg1
changeCamOnGteXV2: MACRO
    ld a, h
    or a
    jr z, .changeCamera\@
    ld a, l
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
.changeCamera\@
    ld c, \2
.checkNextCondition\@
ENDM

; z >= arg1
changeCamOnGteZ: MACRO
    ld a, d
if \1 >= 0
    or a
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
else
    cp a, HIGH(\1)
    jr nz, .changeCamera\@
    ld a, e
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
endc
.changeCamera\@
    ld c, \2
.checkNextCondition\@
    ENDM

; z >= arg1
changeCamOnGteZV2: MACRO
    ld a, d
    or a
    jr z, .changeCamera\@
    ld a, e
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
.changeCamera\@
    ld c, \2
.checkNextCondition\@
ENDM



; multi axis conditions

changeCamOnXGteZeroAndXGteZero: MACRO
    ld a, h
    or a
    jr nz, .checkNextCondition\@
    ld a, d
    or a
    jr nz, .checkNextCondition\@
    ld c, \1
.checkNextCondition\@
ENDM


changeCamOnLtXAndLtZ: MACRO
    ld a, h
if \1 >= 0 
    or a
    jr nz, .checkZAxis\@
    ld a, l
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
else
    cp a, HIGH(\1)
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
endc
.checkZAxis\@
    ld a, d
if \2 >= 0 
    or a
    jr nz, .changeCamera\@
    ld a, e
    cp a, LOW(\2)
    jr nc, .checkNextCondition\@
else
    cp a, HIGH(\2)
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\2)
    jr nc, .checkNextCondition\@
endc
.changeCamera\@
    ld c, \3
.checkNextCondition\@
ENDM


changeCamOnLtXAndZLtZero: MACRO
    ld a, h
    or a
    jr nz, .checkNextAxis\@
    ld a, l
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
.checkNextAxis\@
    ld a, d
    cp a, $FF
    jr nz, .checkNextCondition\@
    ld c, \2
.checkNextCondition\@
ENDM


changeCamOnLtZAndLtX: MACRO
    ld a, d
if \1 >= 0
    or a
    jr nz, .checkNextAxis\@
    ld a, e
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
else
    cp a, HIGH(\1)
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
endc
.checkNextAxis\@
    ld a, h
if \2 >= 0
    or a
    jr nz, .changeCamera\@
    ld a, l
    cp a, LOW(\2)
    jr nc, .checkNextCondition\@
else
    cp a, HIGH(\2)
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\2)
    jr nc, .checkNextCondition\@
endc
.changeCamera\@
    ld c, \3
.checkNextCondition\@
ENDM


changeCamOnLtXAndGteZ: MACRO
    ld a, h
if \1 >= 0
    or a
    jr nz, .checkNextAxis\@
    ld a, l
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
else
    cp a, HIGH(\1)
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
endc
.checkNextAxis\@
    ld a, d
if \2 >= 0   
    or a
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\2)
    jr c, .checkNextCondition\@
else
    cp a, HIGH(\2)
    jr nz, .changeCamera\@
    ld a, e
    cp a, LOW(\2)
    jr c, .checkNextCondition\@
endc
.changeCamera\@
    ld c, \3
.checkNextCondition\@
ENDM

changeCamOnLtZAndGteX: MACRO
    ld a, d
if \1 >= 0
    or a
    jr nz, .checkNextAxis\@
    ld a, e
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
else
    cp a, HIGH(\1)
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
endc
.checkNextAxis\@
    ld a, h
if \2 >= 0
    or a
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\2)
    jr c, .checkNextCondition\@
else
    cp a, HIGH(\2)
    jr nz, .changeCamera\@
    ld a, l
    cp a, LOW(\2)
    jr c, .checkNextCondition\@
endc
.changeCamera\@
    ld c, \3
.checkNextCondition\@
ENDM


changeCamOnGteZAndGteX: MACRO
    ld a, d
if \1 >= 0 
    or a
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
else
    cp a, HIGH(\1)
    jr nz, .checkXaxis\@
    ld a, e
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
endc
.checkXaxis\@
if \2 >= 0   
    ld a, h
    or a
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\2)
    jr c, .checkNextCondition\@ 
else
    ld a, h
    cp a, HIGH(\2)
    jr nz, .changeCamera\@
    ld a, l
    cp a, LOW(\2)
    jr c, .checkNextCondition\@
endc
.changeCamera\@
    ld c, \3
.checkNextCondition\@
ENDM


changeCamOnGteXAndGteZ: MACRO
    ld a, h
 if \1 >= 0   
    or a
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
else
    cp a, HIGH(\1)
    jr nz, .checkNextAxis\@
    ld a, l
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
endc
.checkNextAxis\@
    ld a, d
if \2 >= 0
    or a
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\2)
    jr c, .checkNextCondition\@
else
    cp a, HIGH(\2)
    jr nz, .changeCamera\@
    ld a, e
    cp a, LOW(\2)
    jr c, .checkNextCondition\@
endc
.changeCamera\@
    ld c, \3
.checkNextCondition\@
ENDM


changeCamOnGteZAndLtZ: MACRO
    ld a, d
    cp a, HIGH(\1)
    jr nz, .checkOtherRange\@
    ld a, e
    cp a, LOW(\1)
    jr nc, .changeCamera\@
    jr .checkNextCondition\@
.checkOtherRange\@
    ld a, e
    cp a, LOW(\2)
    jr nc, .checkNextCondition\@
.changeCamera\@
    ld c, \3
.checkNextCondition\@
ENDM

; xpos >= a1 and zpos < a2
changeCamOnGteXAndLtZ: MACRO
    ld a, h
if \1 >= 0
    or a
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
else
    cp a, HIGH(\1)
    jr nz, .checkNextAxis\@
    ld a, l
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
endc
.checkNextAxis\@
    ld a, d
if \2 >= 0
    or a
    jr nz, .changeCamera\@
    ld a, e
    cp a, LOW(\2)
    jr nc, .checkNextCondition\@
else
    cp a, HIGH(\2)
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\2)
    jr nc, .checkNextCondition\@
endc
.changeCamera\@
    ld c, \3
.checkNextCondition\@
ENDM


changeCamOnGteXAndLtZV2: MACRO
    ld a, h
    cp a, HIGH(\1)
    jr nz, .checkNextAxis\@
    ld a, l
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
.checkNextAxis\@
    ld a, d
    or a
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\2)
    jr nc, .checkNextCondition\@
.changeCamera\@
    ld c, \3
.checkNextCondition\@
ENDM

changeCamOnGteZAndLtX: MACRO
    ld a, d
if \1 >= 0
    or a
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
else
    cp a, HIGH(\1)
    jr nz, .checkNextAxis\@
    ld a, e
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
endc
.checkNextAxis\@
    ld a, h
if \2 >= 0
    or a
    jr nz, .changeCamera\@
    ld a, l
    cp a, LOW(\2)
    jr nc, .checkNextCondition\@
else
    cp a, HIGH(\2)
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\2)
    jr nc, .checkNextCondition\@
endc
.changeCamera\@
    ld c, \3
.checkNextCondition\@
ENDM

changeCamOnGteZAndLtXV2: MACRO
    ld a, d
    or a
    jr nz, .changeCamera\@
    ld a, e
    cp a, LOW(\1)
    jr c, .changeCamera\@
    ld a, h
    or a
    jr nz, .changeCamera\@
    ld a, l
    cp a, LOW(\2)
    jr nc, .checkNextCondition\@
.changeCamera\@
    ld c, $02
.checkNextCondition\@
ENDM


changeCamOnLtXAndGteX: MACRO
    ld a, h
    or a
    jr z, .checkOtherRange\@
    ld a, l
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
.checkOtherRange\@
    ld a, e
    cp a, LOW(\2)
    jr nc, .checkNextCondition\@
    ld c, \3
.checkNextCondition\@
ENDM

changeCamOnGteZAndXLtZero: MACRO
    ld a, d
    or a
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
    ld a, h
    cp a, $FF
    jr nz, .checkNextCondition\@
    ld c, \2
.checkNextCondition\@
ENDM


changeCamOnGteZAndXGtZero: MACRO
    ld a, d
if \1 >= 0
    or a
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
else
    cp a, HIGH(\1)
    jr nz, .checkNextAxis\@
    ld a, e
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
endc
.checkNextAxis\@
    ld a, h
    or a
    jr nz, .checkNextCondition\@
    ld a, l
    or a
    jr z, .checkNextCondition\@
    ld c, \2
.checkNextCondition\@
ENDM

changeCamOnGteZAndXGteZero: MACRO
    ld a, d
    cp a, HIGH(\1)
    jr nz, .checkNextAxis\@
    ld a, e
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
.checkNextAxis\@
    ld a, h
    cp a, $FF
    jr nz, .checkNextCondition\@
.changeCamera\@
    ld c, \2
.checkNextCondition\@
ENDM

changeCamOnXEqZeroAndZLtZero: MACRO
    ld a, h
    or a
    jr nz, .checkNextCondition\@
    ld a, l
    or a
    jr z, .checkNextCondition\@
    ld a, d
    cp a, $FF
    jr nz, .checkNextCondition\@
    ld c, \1
.checkNextCondition\@
ENDM

changeCamOnLtZAndXGteZero: MACRO
    ld a, d
    or a
    jr nz, .checkNextAxis\@
    ld a, e
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
.checkNextAxis\@
    ld a, h
    or a
    jr nz, .checkNextCondition\@
    ld a, l
    or a
    jr z, .checkNextCondition\@
    ld c, \2
.checkNextCondition\@
ENDM



; multi with range

; xpos >= a1 and zpos >= a2 and zpos < a3
changeCamOnGteXAndGteZAndLtZ: MACRO
	ld a, h
    or a
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
    ld a, d
    cp a, HIGH(\2)
    jr nz, .checkOtherRange\@
    ld a, e
    cp a, LOW(\2)
    jr c, .checkNextCondition\@
    jr .changeCamera\@
.checkOtherRange\@
    ld a, e
    cp a, LOW(\3)
    jr nc, .checkNextCondition\@
.changeCamera\@
    ld c, \4
.checkNextCondition\@
ENDM

changeCamOnGteXAndGteZAndLtZV2: MACRO
	ld a, h
    or a
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
    ld a, d
    cp a, HIGH(\2)
    jr nz, .checkOtherRange\@
    ld a, e
    cp a, LOW(\2)
    jr c, .checkNextCondition\@
    jr .changeCamera\@
.checkOtherRange\@
    ld a, d
    or a
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\3)
    jr nc, .checkNextCondition\@
.changeCamera\@
    ld c, \4
.checkNextCondition\@
ENDM

changeCamOnLtZAndGteXAndLtX: MACRO
    ld a, d
    cp a, HIGH(\1)
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
    ld a, h
    cp a, HIGH(\2)
    jr nz, .checkOtherRange\@
    ld a, l
    cp a, LOW(\2)
    jr c, .checkNextCondition\@
    jr .changeCamera\@
.checkOtherRange\@
    ld a, l
    cp a, LOW(\3)
    jr nc, .checkNextCondition\@
.changeCamera\@
    ld c, \4
.checkNextCondition\@
ENDM

changeCamOnLtZAndGteXAndLtXV2: MACRO
    ld a, d
    cp a, HIGH(\1)
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
    ld a, h
    cp a, HIGH(\2)
    jr nz, .checkOtherRange\@
    ld a, l
    cp a, LOW(\2)
    jr c, .checkNextCondition\@
    jr .changeCamera\@
.checkOtherRange\@
    ld a, h
    or a
    jr nz, .checkNextCondition\@
    ld a, l
    cp a,LOW(\3)
    jr nc, .checkNextCondition\@
.changeCamera\@
    ld c, \4
.checkNextCondition\@
ENDM


changeCamOnLtXAndGteXAnfLtZ: MACRO
    ld a, d
    cp a, HIGH(\1)
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
.checkOtherXRange\@
    cp a, LOW(\2)
    jr c, .checkNextCondition\@
    ld a, h
    cp a, HIGH(\3)
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\3)
    jr nc, .checkNextCondition\@
.changeCamera\@
    ld c, \4
.checkNextCondition\@
ENDM

changeCamOnGteZAndLtZAndGteX: MACRO
    ld a, d
    cp a, HIGH(\1)
    jr nz, .checkOtherRange\@
    ld a, e
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
.checkOtherRange\@
    ld a, e
    cp a, LOW(\2)
    jr nc, .checkNextCondition\@
    ld a, h
    or a
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\3)
    jr c, .checkNextCondition\@
.changeCamera\@
    ld c, \4
.checkNextCondition\@
ENDM

; ( z >= a1 or z < a1 ) and x >= a3
changeCamOnGteZOrLtZAndGteX: MACRO
    ld a, d
    cp a, HIGH(\1)
    jr nz, .checkOtherRange\@
    ld a, e
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
    jr .checkNextAxis\@
.checkOtherRange\@
    ld a, e
    cp a, LOW(\2)
    jr nc, .checkNextCondition\@
.checkNextAxis\@
    ld a, h
    or a
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\3)
    jr c, .checkNextCondition\@
.changeCamera\@
    ld c, \4
.checkNextCondition\@
ENDM

; z < a1 and x1 < a2 and x2 < a3
changeCamLtZAndLtX1AndLtX2: MACRO
    ld a, d
    cp a, HIGH(\1)
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
    ld a, h
    cp a, HIGH(\2)
    jr nz, .checkOtherRange\@
    ld a, l
    cp a, LOW(\2)
    jr nc, .changeCamera\@
.checkOtherRange\@
    ld a, h
    or a
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\3)
    jr nc, .checkNextCondition\@
.changeCamera\@
    ld c, \4
.checkNextCondition\@
ENDM

changeCamOnXLtZeroAndGteZAndLtZ: MACRO
    ld a, h
    or a
    jr z, .checkNextCondition\@
    ld a, d
    cp a, HIGH(\1)
    jr nz, .checkOtherRange\@
    ld a, e
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
    jr .changeCamera\@
.checkOtherRange\@
    ld a, e
    cp a, LOW(\2)
    jr nc, .checkNextCondition\@
.changeCamera\@
    ld c, \3
.checkNextCondition\@
ENDM

changeCamOnLtXAndGteZAndLtZ: MACRO
    ld a, h
    cp a, HIGH(\1)
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
    ld a, d
    cp a, HIGH(\2)
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\2)
    jr c, .checkNextCondition\@
    cp a, LOW(\3)
    jr nc, .checkNextCondition\@
.changeCamera\@
    ld c, \4
.checkNextCondition\@
ENDM

changeCamOnLtXAndLtZAndGteZ: MACRO
    ld a, h
    cp a, HIGH(\1)
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
    ld a, d
    cp a, HIGH(\2)
    jr nz, .checkOtherRange\@
    ld a, e
    cp a, LOW(\2)
    jr c, .checkNextCondition\@
    jr .changeCamera\@
.checkOtherRange\@
    ld a, d
    or a
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\3)
    jr nc, .checkNextCondition\@
.changeCamera\@
    ld c, \4
.checkNextCondition\@
ENDM

changeCamOnGteZAndGteXAndLtX: MACRO
    ld a, d
    or a
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
    ld a, h
    cp a, HIGH(\2)
    jr nz, .checkOtherRange\@
    ld a, l
    cp a, LOW(\2)
    jr c, .checkNextCondition\@
    jr .changeCamera\@
.checkOtherRange\@
    ld a, h
    or a
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\3)
    jr nc, .checkNextCondition\@
.changeCamera\@
    ld c, \4
.checkNextCondition\@
ENDM


; multi cam conditions

changeCam1OnLtXOrCam2OnGteX: MACRO
    ld a, h
    cp a, $FF
    jr z, .changeCamera2\@
    or a
    jr nz, .changeCamera1\@
    ld a, l
    cp a, LOW(\1)
    jr c, .changeCamera2\@
.changeCamera1\@
    ld c, \3
    jr .checkNextCondition\@
.changeCamera2\@
    ld c, \2
    jr .checkNextCondition\@
.checkNextCondition\@
ENDM

; cam 1 on xpos >= a1 and cam2 on zpos < a2
changeCam1OnGteXAndCam2OnLtZ: MACRO
    ld a, h
if \1 >= 0
    or a
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
else
    cp a, HIGH(\1)
    jr nz, .changeCamera1\@
    ld a, l
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
endc
.changeCamera1\@
    ld c, \2
    ld a, d
if \3 >= 0
    or a
    jr nz, .changeCamera2\@
    ld a, e
    cp a, LOW(\3)
    jr nc, .checkNextCondition\@
else
    cp a, HIGH(\3)
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\3)
    jr nc, .checkNextCondition\@
endc
.changeCamera2\@
    ld c, \4
.checkNextCondition\@
ENDM

changeCam1OnGteZAndCam2OnLtX: MACRO
    ld a, d
    or a
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
.changeCamera1\@
    ld c, \2
    ld a, h
    or a
    jr nz, .changeCamera2\@
    ld a, l
    cp a, LOW(\3)
    jr nc, .checkNextCondition\@
.changeCamera2\@
    ld c, \4
.checkNextCondition\@
ENDM

changeCam1OnXGteZeroAndLtX1OrCam2GteX1: MACRO
    ld a, h
    or a
    jr nz, .checkNextCondition\@
.changeCamera1\@
    ld c, \2
    ld a, l
    cp a, \1
    jr c, .checkNextCondition\@
.changeCamera2\@
    ld c, \3
.checkNextCondition\@
ENDM

changeCam1OnZGteZeroAndCam2OnXLtZero: MACRO
    ld a, d
    or a
    jr nz, .checkNextCondition\@
    ld a, e
    or a
    jr z, .checkNextCondition\@
.changeCamera1\@
    ld c, \1
    ld a, h
    cp a, $FF
    jr nz, .checkNextCondition\@
.changeCamera2\@
    ld c, \2
.checkNextCondition\@
ENDM


changeCam1OnGteXAndCam2OnGteZ: MACRO
    ld a, h
    or a
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
.changeCamera1\@
    ld c, \2
    ld a, d
    or a
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\3)
    jr c, .checkNextCondition\@
.changeCamera2\@
    ld c, \4
.checkNextCondition\@
ENDM


changeCam1OnXGteZeroLtX1OrCam2GteX1: MACRO
    ld a, h
if \1 >= 0
    or a
else
    cp a, HIGH(\1)
endc
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\1)
    jr c, .changeCamera2\@
.changeCamera1\@
    ld c, \2
    jr .checkNextCondition\@
.changeCamera2\@
    ld c, \3
.checkNextCondition\@
ENDM


changeCam2GteX1OrCam1OnXGteZeroLtX1: MACRO
    ld a, h
if \1 >= 0
    or a
else
    cp a, HIGH(\1)
endc
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\1)
    jr c, .changeCamera2\@
.changeCamera1\@
    ld c, \3
    jr .checkNextCondition\@
.changeCamera2\@
    ld c, \2
.checkNextCondition\@
ENDM

changeCam1OnLtZAndCam2OnLtX: MACRO
    ld a, d
    cp a, HIGH(\1)
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
.changeCamera1\@
    ld c, \2
    ld a, h
    cp a, HIGH(\3)
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\3)
    jr nc, .checkNextCondition\@
.changeCamera2\@
    ld c, \4
.checkNextCondition\@
ENDM

; cam1: z >= a1 and x1 >= a2
; cam2: z >= a1 and x2 >= a4
changeCam1OnGteZGteX1orCam2OnGteZGteX2: MACRO
    ld a, d
    or a
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
    ld a, h
    or a
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\4)
    jr nc, .changeCamera2\@
    cp a, LOW(\2)
    jr c, .checkNextCondition\@
.changeCamera1\@
    ld c, \3
    jr .checkNextCondition\@
.changeCamera2\@
    ld c, \5
.checkNextCondition\@
ENDM

; cam1: z < 0
; cam2: x >= a2
changeCam1OnZLtZeroAndCam2OnGteX: MACRO
    ld a, d
    cp a, $FF
    jr nz, .checkNextCondition\@
.changeCamera1\@
    ld c, \1
    ld a, h
    or a
    jr z, .changeCamera2\@
    ld a, l
    cp a, LOW(\2)
    jr c, .checkNextCondition\@
.changeCamera2\@
    ld c, \3
.checkNextCondition\@
ENDM

changeCam1OnGteZOrCam1OnLtZ: MACRO
    ld a, d
    or a
    jr nz, .changeCamera2\@
    ld a, e
    cp a, LOW(\1)
    jr c, .changeCamera2\@
.changeCamera1\@
    ld c, \2
    jr .checkNextCondition\@
.changeCamera2\@
    ld c, \3
.checkNextCondition\@
ENDM

; cam1: z < a1
; cam2: z < a3 and x >= a4
changeCam1OnLtZOrCam2OnLtZGteX: MACRO
    ld a, d
    cp a, HIGH(\1)
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\1)
    jr nc, .checkOtherRange\@
.changeCamera1\@
    ld c, \2
.checkOtherRange\@
    ld a, e
    cp a, LOW(\3)
    jr nc, .checkNextCondition\@
    ld a, h
    or a
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\4)
    jr c, .checkNextCondition\@
.changeCamera2\@
    ld c, \5
.checkNextCondition\@
ENDM

; cam1: z >= a1 and z < a2 or change to cam2
changeCam1OnGteZAndLtZOrCam2: MACRO
    ld a, d
    or a
    jr z, .checkOtherRange\@
    ld a, e
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
.changeCamera1\@
    ld c, \3
    jr .checkNextCondition\@
.checkOtherRange\@
    ld c, \3
    ld a, e
    cp a, LOW(\2)
    jr c, .checkNextCondition\@
.changeCamera2\@
    ld c, \4
.checkNextCondition\@
ENDM

; cam1: z < a1 and z >= a2
; cam2: z < a2
changeCam1OnLtZ1AndGteZ2OrCam2OnLtZ2: MACRO
    ld a, d
if \2 >= 0
    or a
    jr nz, .changeCamera2\@
    ld a, e
    cp a, LOW(\1)
    jr nc, .checkOtherRange\@
    ld c, \3
.checkOtherRange\@
    ld a, d
    or a
    jr nz, .changeCamera2\@
    ld a, e
    cp a, LOW(\2)
    jr nc, .checkNextCondition\@    
else
    cp a, HIGH(\2)
    jr z, .checkOtherRange\@
    ld a, e
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
    jr .changeCamera1\@
.checkOtherRange\@
    ld a, e
    cp a, LOW(\2)
    jr c, .changeCamera2\@
.changeCamera1\@
    ld c, \3
    jr .checkNextCondition\@
endc
.changeCamera2\@
    ld c, \4
.checkNextCondition\@
ENDM

changeCam1OnLtX1AndGteX2OrCam2OnLtX2: MACRO
    ld a, h
    cp a, HIGH(\2)
    jr nz, .changeCamera2\@
    ld a, l
    cp a, LOW(\2)
    jr nc, .changeCamera1\@
    ld c, \4
    jr .checkNextCondition\@
.changeCamera2\@
    ld a, l
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
.changeCamera1\@
    ld c, \3
.checkNextCondition\@
ENDM

changeCam1OnGteX1AndLtX2OrCam2OnGteX2: MACRO
    ld a, h
    cp a, HIGH(\1)
    jr nz, .checkOtherRange\@
    ld a, l
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
.changeCamera1\@
    ld c, \3
    jr .checkNextCondition\@
.checkOtherRange\@
    ld a, l
    cp a, LOW(\2)
    jr c, .changeCamera1\@
.changeCamera2\@
    ld c, \4
.checkNextCondition\@
ENDM

changeCam1OnGteZ1AndLtZ2OrCam2OnGteZ2: MACRO
    ld a, d
if \2 >= 0
    or a
    jr nz, .checkNextCondition\@
else
    or a
    jr z, .changeCamera2\@
endc
    ld a, e
    cp a, LOW(\2)
    jr nc, .changeCamera2\@
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
.changeCamera1\@
    ld c, \3
    jr .checkNextCondition\@
.changeCamera2\@
    ld c, \4
.checkNextCondition\@
ENDM

changeCam1OnLtX1AndGteX2OrCam2OnGteX1: MACRO
    ld a, h
    or a
    jr nz, .checkOtherRange\@
    ld a, l
    cp a, LOW(\1)
    jr c, .changeCamera1\@
.changeCamera2\@
    ld c, \4
    jr .checkNextCondition\@
.checkOtherRange\@
    ld a, l
    cp a, LOW(\2)
    jr c, .checkNextCondition\@
.changeCamera1\@
    ld c, \3
.checkNextCondition\@
ENDM

changeCam1OnLtZOrCam2OnXLtZero: MACRO
    ld a, d
    cp a, HIGH(\1)
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
    ld c, \2
    ld a, h
    or a
    jr z, .checkNextCondition\@
    ld c, \3
.checkNextCondition\@
ENDM

changeCam1OnGteX1LtX2OrCam2OnGteX2: MACRO
    ld a, h
    or a
    jr nz, .checkOtherRange\@
    ld a, l
    cp a, LOW(\2)
    jr c, .changeCamera1\@
.changeCamera2\@
    ld c, \4
    jr .checkNextCondition\@
.checkOtherRange\@
    ld a, h
    cp a, HIGH(\1)
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
.changeCamera1\@
    ld c, \3
.checkNextCondition\@
ENDM

changeCam1OnGteX1LtX2OrCam2OnGteX2V2: MACRO
    ld a, h
    or a
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, LOW(\2)
    jr nc, .changeCamera2\@
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
.changeCamera1\@
    ld c, \3
    jr .checkNextCondition\@
.changeCamera2\@
    ld c, \4
.checkNextCondition\@
ENDM

changeCam1OnXLtZeroOrCam2OnXGteZero: MACRO
    ld a, h
    cp a, $80
    jr c, .changeCamera2\@
.changeCamera1\@
    ld c, \1
    jr .checkNextCondition\@
.changeCamera2\@
    ld c, \2
.checkNextCondition\@
ENDM

changeCam1OnXGteZeroOrCam2OnLtZeroThenJump: MACRO
    ld a, h
    cp a, $80
    jr nc, .changeCamera1\@
.changeCamera2\@
    ld c, \2
    jr \3
.changeCamera1\@:
    ld c, \1
    jr \3
ENDM

; cam1: x < a1
; cam2: x >= a1 and x < a2
; cam3: x >= a2 and x < a3
changeCam1OnLtX1OrCam2OnGteX1LtX2OrCam3OnGteX2LtX3: MACRO
    ld a, h
    or a
    jr nz, .checkOtherRange\@
    ld a, l
    cp a, LOW(\3)
    jr nc, .checkNextCondition\@
    jr .changeCamera3\@
.checkOtherRange\@
    ld a, l
    cp a, LOW(\1)
    jr c, .changeCamera1\@
    cp a, LOW(\2)
    jr c, .changeCamera2\@
.changeCamera3\@
    ld c, \6
    jr .checkNextCondition\@
.changeCamera1\@
    ld c, \4
    jr .checkNextCondition\@
.changeCamera2\@
    ld c, \5
.checkNextCondition\@
ENDM

; cam1: x >= a1 and x < a2
; cam2: x >= a2 and x < a4
; cam3: x >= a3
changeCam1OnGteX1LtX2OrCam2OnGteX2LtX3OrCam3OnGteX3: MACRO
    ld a, h
    or a
    jr z, .checkOtherRange\@
    ld a, l
    cp a, LOW(\2)
    jr nc, .changeCamera2\@
    cp a, LOW(\1)
    jr c, .checkNextCondition\@
.changeCamera1\@
    ld c, \4
    jr .checkNextCondition\@
.checkOtherRange\@
    ld a, l
    cp a, LOW(\3)
    jr nc, .changeCamera3\@
.changeCamera2\@
    ld c, \5
    jr .checkNextCondition\@
.changeCamera3\@
    ld c, \6
.checkNextCondition\@
ENDM

changeCam1OnLtX1GteX2OrCam2OnLtX2GteX3OrCam3LtX3: MACRO
    ld a, h
    cp a, HIGH(\3)
    jr nz, .checkOtherRange\@
    ld a, l
    cp a, LOW(\3)
    jr c, .changeCamera3\@
    jr .changeCamera2\@
.checkOtherRange\@
    ld a, l
    cp a, LOW(\2)
    jr c, .changeCamera2\@
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
.changeCamera1\@
    ld c, \4
    jr .checkNextCondition\@
.changeCamera2\@
    ld c, \5
    jr .checkNextCondition\@
.changeCamera3\@
    ld c, \6
    jr .checkNextCondition\@
.checkNextCondition\@
ENDM


; conditions with jump pointers as args

continueOnXGteZeroOrJump: MACRO
    ld a, h
    or a
    jr nz, \1
ENDM

continueOnZGteZeroOrJump: MACRO
    ld a, d
    or a
    jr nz, \1
ENDM

continueOnXLtZeroOrJump: MACRO
    ld a, h
    cp a, $FF
    jr nz, \1
ENDM

continueOnGteXOrJump: MACRO
    ld a, h
if \1 >= 0
    or a
    jr nz, \2
    ld a, l
    cp a, LOW(\1)
else
    cp a, HIGH(\1)
    jr nz, \2
    ld a, l
    cp a, LOW(\1)
endc
    jr c, \2
ENDM

continueOnLtXOrJump: MACRO
    ld a, h
if \1 >= 0
    or a
    jr nz, \2
    ld a, l
    cp a, LOW(\1)
else
    cp a, HIGH(\1)
    jr nz, \2
    ld a, l
    cp a, LOW(\1)
endc
    jr nc, \2
ENDM

continueOnLtXOrJumpV2: MACRO
    ld a, h
    cp a, $FF
    jr z, .checkNextCondition\@
    ld a, l
    cp a, LOW(\1)
    jr nc, \2
.checkNextCondition\@
ENDM

continueOnGteZOrJump: MACRO
    ld a, d
if \1 >= 0
    or a
    jr nz, \2
    ld a, e
    cp a, LOW(\1)
else
    cp a, HIGH(\1)
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\1)
endc  
    jr c, \2
.checkNextCondition\@
ENDM

continueOnLtZOrJump: MACRO
    ld a, d
if \1 >= 0
    or a
    jr nz, .checkNextCondition\@
    cp a, LOW(\1)
else
    cp a, HIGH(\1)
    jr nz, \2
    ld a, e
    cp a, LOW(\1)
endc
    jr nc, \2
.checkNextCondition\@
ENDM

continueOnLtZOrJumpV2: MACRO
    ld a, d
    cp a, HIGH(\1)
    jr nz, \2
    ld a, e
    cp a, LOW(\1)
    jr nc, \2
ENDM

continueOnLtZOrJumpV3: MACRO
    ld a, d
    cp a, HIGH(\1)
    jr c, \2
    ld a, e
    cp a, LOW(\1)
    jr nc, \2
ENDM

continueOnLtZOrJumpV4: MACRO
    ld a, e
    cp a, LOW(\1)
    jr nc, \2
ENDM

; change cam

changeCamOnXGteZeroOrJump: MACRO
    ld a, h
    or a
    jr nz, \2
    ld c, \1
ENDM

changeCamOnZGteZeroOrJump: MACRO
    ld a, d
    or a
    jr nz, \2
    ld c, \1
ENDM

changeCamOnZposLtZeroOrJump: MACRO
    ld a, d
    cp a, $FF
    jr nz, \2
    ld c, \1
ENDM

changeCamOnXLtZeroOrJump: MACRO
    ld a, h
    or a
    jr z, \2 ; break pointer
    ld c, \1
ENDM

changeCamOnZLtZeroOrJump: MACRO
    ld a, d
    or a
    jr z, \2 ; break pointer
    ld c, \1
ENDM

changeCamOnGteXOrJump: MACRO
    ld a, h
if \1 >= 0
    or a
    jr nz, \3
    ld a, l
    cp a, LOW(\1)
else
    cp a, HIGH(\1)
    jr nz, .changeCamera\@
    ld a, l
    cp a, LOW(\1)
endc
    jr c, \3
.changeCamera\@
    ld c, \2
ENDM

changeCamOnGteXOrJumpV2: MACRO
    ld a, h
    cp a, $FF
    jr z, \3 ; jp
    or a
    jr nz, .changeCamera\@
    ld a, l
    cp a, LOW(\1)
    jr c, \3
.changeCamera\@
    ld c, \2
ENDM

changeCamOnGteXAndJump: MACRO
    ld a, h
    or a
    jr nz, .checkNextCondition\@
    ld a, l
    cp a, \1
    jr c, .checkNextCondition\@
    ld c, \2
    jr \3 ; bp
.checkNextCondition\@
ENDM

changeCamOnLtXOrJump: MACRO
    ld a, h
if \1 >= 0
    or a
    jr nz, .changeCamera\@
    ld a, l
    cp a, LOW(\1)
    jr nc, \3
else
    cp a, HIGH(\1)
    jr nz, \3 ; bp
    ld a, l
    cp a, LOW(\1)
    jr nc, \3
endc
.changeCamera\@
    ld c, \2
ENDM

changeCamOnLtXOrJumpV2: MACRO
    ld a, h
    cp a, $FF
    jr z, .changeCamera\@
    ld a, l
    cp a, LOW(\1)
    jr nc, \3
.changeCamera\@
    ld c, \2
ENDM

changeCamOnGteZAndJump: MACRO
    ld a, d
if \1 >= 0
    or a
    jr nz, \3 ; bp
    ld a, e
    cp a, LOW(\1)
else
    cp a, HIGH(\1)
    jr nz, .changeCamera\@
    ld a, e
    cp a, LOW(\1)
endc
    jr c, \3
.changeCamera\@
    ld c, \2
    jr \3
ENDM

changeCamOnGteZOrJump: MACRO
    ld a, d
    cp a, HIGH(\1)
    jr nz, .changeCamera\@
    ld a, e
    cp a, LOW(\1)
    jr c, \3 ; bp
.changeCamera\@
    ld c, \2
ENDM


changeCamOnLtZOrJump: MACRO
    ld a, d
if \1 >= 0
    or a
    jr nz, .changeCamera\@
    ld a, e
    cp a, LOW(\1)
    jr nc, \3 ; bp
else
    cp a, HIGH(\1)
    jr nz, \3
    ld a, e
    cp a, LOW(\1)
    jr nc, \3
endc
.changeCamera\@
    ld c, \2
ENDM

changeCamOnLtZOrJumpV2: MACRO
    ld a, d
    cp a, $FF
    jr z, .changeCamera\@
    ld a, e
    cp a, LOW(\1)
    jr nc, \3
.changeCamera\@
    ld c, \2
ENDM

changeCamOnLtZAndJump: MACRO
    ld a, d
    cp a, HIGH(\1)
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\1)
    jr nc, .checkNextCondition\@
    ld c, \2
    jr \3
.checkNextCondition\@
ENDM

changeCamOnLtZLowOrJump: MACRO
    ld a, e
    cp a, LOW(\1)
    jr nc, \3
    ld c, \2
ENDM

jump1OnGteZOrJump2OnLtZOrContinue: MACRO
    ld a, d
    cp a, HIGH(\1)
    jr nz, .checkNextCondition\@
    ld a, e
    cp a, LOW(\1)
    jr c, \3 ; jp2
    jr \2 ; jp1
.checkNextCondition\@
ENDM

jp1OnLtZ1OrJp2OnLtZ2OrJp3OnGteZ3: MACRO
    ld a, e
    cp a, LOW(\1)
    jr c, \2
    cp a, LOW(\3)
    jr c, \4
    cp a, LOW(\5)
    jr nc, \6
ENDM

changeCamOnLtX1GteX2OrJump: MACRO
    ld a, h
    cp a, HIGH(\2)
    jr z, .checkOtherRange\@
    or a
    jr nz, \4
    ld a, l
    cp a, LOW(\1)
    jr nc, \4
    jr .changeCamera\@
.checkOtherRange\@
    ld a, l
    cp a, LOW(\2)
    jr c, \4
.changeCamera\@
    ld c, \3
ENDM


changeCamOnActiveFlagVar: MACRO
    ld a, [\1]
    or a
    jr z, .checkNextCondition\@
    ld c, \2
.checkNextCondition\@
ENDM
