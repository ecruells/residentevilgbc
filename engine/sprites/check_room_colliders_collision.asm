checkRoomsCollidersCollision:: ;FD:511C
    ld a, [wRoomId]
    ld l, a
    ld a, [wRoomIdHigh]
    ld h, a
    add hl, hl
    ld de, roomsCollidersTable
    add hl, de
    ld a, [hli] ; get colliders count
    ld h, [hl] ; get room colliders struct address
    ld l, a
    ld a, [hli]
    or a
    ret z
    ld b, a ; set colliders count
checkCollidersLoop:
    push bc
    ld a, [hli]
    ld [wColliderRectRightX], a
    ld c, a
    ld a, [hli]
    ld [wColliderRectRightX+1], a
    ld b, a
    inc hl
    inc hl
    ld a, [hli]
    add a, c
    ld [wColliderRectLeftX], a
    ld a, [hld]
    adc a, b
    ld [wColliderRectLeftX+1], a
    dec hl
    dec hl
    ld a, [hli]
    ld [wColliderRectBottomY], a
    ld c, a
    ld a, [hli]
    ld [wColliderRectBottomY+1], a
    ld b, a
    inc hl
    inc hl
    ld a, [hli]
    add a, c
    ld [wColliderRectTopY], a
    ld a, [hli]
    adc a, b
    ld [wColliderRectTopY+1], a
    push hl
; get player position
    ld a, [wEntityPositionX]
    ld e, a
    ld a, [wEntityPositionX+1]
    ld d, a
    call div8WordFD
    push de
    ld a, [wEntityPositionZ]
    ld e, a
    ld a, [wEntityPositionZ+1]
    ld d, a
    call div8WordFD
    ld l, e
    ld h, d
    pop de
    call detectRoomColliderCollision
    pop hl
    pop bc
    dec b
    jp nz, checkCollidersLoop
    ret
;5184

; detect a room collider collision with the player, if a collision is detected, the player position
; is limited by the collider borders
;
; de: player x-pos
; hl: player z-pos
detectRoomColliderCollision: ;FD:5184
;
; fast collision detection
    ld a, [wColliderRectRightX]
    sub a, e
    ld a, [wColliderRectRightX+1]
    sbc a, d
    cp a, $FF
    ret nz
    ld a, [wColliderRectLeftX]
    sub a, e
    ld a, [wColliderRectLeftX+1]
    sbc a, d
    or a
    ret nz
    ld a, [wColliderRectBottomY]
    sub a, l
    ld a, [wColliderRectBottomY+1]
    sbc a, h
    cp a, $FF
    ret nz
    ld a, [wColliderRectTopY]
    sub a, l
    ld a, [wColliderRectTopY+1]
    sbc a, h
    or a
    ret nz
; collision with some border detected, now check all collider borders
    push de
    push hl
    ld a, [wEntityRoomPositionX]
    ld e, a
    ld a, [wEntityRoomPositionX+1]
    ld d, a
    ld a, [wEntityRoomPositionZ]
    ld l, a
    ld a, [wEntityRoomPositionZ+1]
    ld h, a
; detectColliderBottomBorderCollision
    ld a, [wColliderRectBottomY]
    sub a, l
    ld a, [wColliderRectBottomY+1]
    sbc a, h
    or a
    jr nz, detectColliderTopBorderCollision
    ld a, [wColliderRectBottomY]
    ld e, a
    ld a, [wColliderRectBottomY+1]
    ld d, a
    call multiply8SignedWordFD
    ld a, e
    sub a, $01
    ld [wEntityPositionZ], a
    ld a, d
    sbc a, $00
    ld [wEntityPositionZ+1], a
    pop hl
    pop de
    ret
;51E5

detectColliderTopBorderCollision: ;FD:51E5
    ld a, [wColliderRectTopY]
    sub a, l
    ld a, [wColliderRectTopY+1]
    sbc a, h
    cp a, $FF
    jr nz, detectColliderRightBorderCollision
    ld a, [wColliderRectTopY]
    ld e, a
    ld a, [wColliderRectTopY+1]
    ld d, a
    call multiply8SignedWordFD
    ld a, e
    add a, $08
    ld [wEntityPositionZ], a
    ld a, d
    adc a, $00
    ld [wEntityPositionZ+1], a
    pop hl
    pop de
    ret
;520B

detectColliderRightBorderCollision: ;FD:520B
    ld a, [wColliderRectRightX]
    sub a, e
    ld a, [wColliderRectRightX+1]
    sbc a, d
    or a
    jr nz, detectColliderLeftBorderCollision
    ld a, [wColliderRectRightX]
    ld e, a
    ld a, [wColliderRectRightX+1]
    ld d, a
    call multiply8SignedWordFD
    ld a, e
    sub a, $01
    ld [wEntityPositionX], a
    ld a, d
    sbc a, $00
    ld [wEntityPositionX+1], a
    pop hl
    pop de
    ret
;5230

detectColliderLeftBorderCollision: ;FD:5230
    ld a, [wColliderRectLeftX]
    ld e, a
    ld a, [wColliderRectLeftX+1]
    ld d, a
    call multiply8SignedWordFD
    ld a, e
    add a, $08
    ld [wEntityPositionX], a
    ld a, d
    adc a, $00
    ld [wEntityPositionX+1], a
    pop hl
    pop de
    ret
;524A
