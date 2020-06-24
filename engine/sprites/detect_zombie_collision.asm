; compare player position with zombie collision box, if there's a collision, 
; limit the player position and return true ($FF), if not, return false ($00)
;
; de: player pos x
; hl: player pos z
detectZombieCollision: ;FB:4FFA
;
; fast collision detection
    ld a, [wColliderRectRightX]
    sub a, e
    ld a, [wColliderRectRightX+1]
    sbc a, d
    cp a, $FF
    jp nz, returnNotZombieCollision
    ld a, [wColliderRectLeftX]
    sub a, e
    ld a, [wColliderRectLeftX+1]
    sbc a, d
    or a
    jp nz, returnNotZombieCollision
    ld a, [wColliderRectBottomY]
    sub a, l
    ld a, [wColliderRectBottomY+1]
    sbc a, h
    cp a, $FF
    jp nz, returnNotZombieCollision
    ld a, [wColliderRectTopY]
    sub a, l
    ld a, [wColliderRectTopY+1]
    sbc a, h
    or a
    jp nz, returnNotZombieCollision
;
; collision detected in some zombie collider border, now check every border collision
;
    push de ; store player pos y
    push hl ; store player pos z
    ld a, [wEntityRoomPositionX]
    ld e, a
    ld a, [wEntityRoomPositionX+1]
    ld d, a
    push de
    ld a, [wEntityRoomPositionZ]
    ld e, a
    ld a, [wEntityRoomPositionZ+1]
    ld d, a
    ld l, e
    ld h, d
    pop de
; checkZombieColliderBottomBorder
    ld a, [wColliderRectBottomY]
    sub a, l
    ld a, [wColliderRectBottomY+1]
    sbc a, h
    or a
    jr nz, checkZombieColliderTopBorder
    ld a, [wColliderRectBottomY]
    ld e, a
    ld a, [wColliderRectBottomY+1]
    ld d, a
    call multiply8SignedWordFB
    ld a, e
    sub a, $01
    ld [wEntityPositionZ], a
    ld a, d
    sbc a, $00
    ld [wEntityPositionZ+1], a
    pop hl
    pop de
    ld a, $FF
    ret
checkZombieColliderTopBorder: ;FB:5069
    ld a, [wColliderRectTopY]
    sub a, l
    ld a, [wColliderRectTopY+1]
    sbc a, h
    cp a, $FF
    jr nz, checkZombieColliderRightBorder
    ld a, [wColliderRectTopY]
    ld e, a
    ld a, [wColliderRectTopY+1]
    ld d, a
    call multiply8SignedWordFB
    ld a, e
    add a, $08
    ld [wEntityPositionZ], a
    ld a, d
    adc a, $00
    ld [wEntityPositionZ+1], a
    pop hl
    pop de
    ld a, $FF
    ret
checkZombieColliderRightBorder: ;FB:5091
    ld a, [wColliderRectRightX]
    sub a, e
    ld a, [wColliderRectRightX+1]
    sbc a, d
    or a
    jr nz, checkZombieColliderLeftBorder
    ld a, [wColliderRectRightX]
    ld e, a
    ld a, [wColliderRectRightX+1]
    ld d, a
    call multiply8SignedWordFB
    ld a, e
    sub a, $01
    ld [wEntityPositionX], a
    ld a, d
    sbc a, $00
    ld [wEntityPositionX+1], a
    pop hl
    pop de
    ld a, $FF
    ret
checkZombieColliderLeftBorder: ;FB:50B8
    ld a, [wColliderRectLeftX]
    ld e, a
    ld a, [wColliderRectLeftX+1]
    ld d, a
    call multiply8SignedWordFB
    ld a, e
    add a, $08
    ld [wEntityPositionX], a
    ld a, d
    adc a, $00
    ld [wEntityPositionX+1], a
    pop hl
    pop de
    ld a, $FF
    ret
;50D4

returnNotZombieCollision: ;FB:50D4
    xor a
    ret
;50D6
