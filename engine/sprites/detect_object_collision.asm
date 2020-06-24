; Compare player position with an object collision box, if there's a collision, limit player position 
; with the object collider border and return true ($FF). If player is colliding with an step ladder in some
; border, return false ($00).
;
; If there's not a collision, return false and reset step ladder elevation flag.
;
; de: player sprite x position
; hl: player sprite z position
detectObjectCollision: ;FB:50D6
;
; fast collision detection
    ld a, [wColliderRectRightX]
    sub a, e
    ld a, [wColliderRectRightX+1]
    sbc a, d
    cp a, $FF
    jp nz, notObjectCollision
    ld a, [wColliderRectLeftX]
    sub a, e
    ld a, [wColliderRectLeftX+1]
    sbc a, d
    or a
    jp nz, notObjectCollision
    ld a, [wColliderRectBottomY]
    sub a, l
    ld a, [wColliderRectBottomY+1]
    sbc a, h
    cp a, $FF
    jp nz, notObjectCollision
    ld a, [wColliderRectTopY]
    sub a, l
    ld a, [wColliderRectTopY+1]
    sbc a, h
    or a
    jp nz, notObjectCollision
;
; collision with an object border detected, now, check all object collision 
; box borders, and limit player position if there's a collision.
;
    ld a, [wStepLadderElevationMode]
    or a
    jp nz, returnNotObjectCollision ; if using a step ladder
    push de
    push hl
    ld a, [wEntityRoomPositionX]
    ld e, a
    ld a, [wEntityRoomPositionX+1]
    ld d, a
    push de ; store player pos-x
    ld a, [wEntityRoomPositionZ]
    ld e, a
    ld a, [wEntityRoomPositionZ+1]
    ld d, a
    ld l, e
    ld h, d  ;store player pos-z into hl
    pop de ; restore player pos-x
; check collider bottom border
    ld a, [wColliderRectBottomY]
    sub a, l
    ld a, [wColliderRectBottomY+1]
    sbc a, h
    or a
    jr nz, checkObjColliderTopBorder ; jump if z-axis not match
; else, set player z-pos to limit
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

checkObjColliderTopBorder: ;FB:514C
    ld a, [wColliderRectTopY]
    sub a, l
    ld a, [wColliderRectTopY+1]
    sbc a, h
    cp a, $FF
    jr nz, checkObjColliderRightBorder
; collision with top border detected, check if the collider is an step ladder
    ld a, [wCurrentSpriteCharId]
    cp a, MAP_STEP_LADDER
    jr z, .Label3ED161
    jr .Label3ED16F
.Label3ED161
    ld a, [wMansion1FMapStepLadderPushed]
    or a
    jr z, .Label3ED16F ; jump if disabled
    ld a, $FF
    ld [wStepLadderElevationMode], a
    jp collisionWithStepLadder
.Label3ED16F
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
;518B

checkObjColliderRightBorder: ;FB:518B
    ld a, [wColliderRectRightX]
    sub a, e
    ld a, [wColliderRectRightX+1]
    sbc a, d
    or a
    jr nz, checkObjColliderLeftBorder
; collision with left border detected, check if the collider is an step ladder
    ld a, [wCurrentSpriteCharId]
    cp a, SHED_STEP_LADDER
    jr z, .Label3ED19F
    jr .Label3ED1A7
.Label3ED19F
    ld a, $FF
    ld [wStepLadderElevationMode], a
    jp collisionWithStepLadder
.Label3ED1A7
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
;51C3

checkObjColliderLeftBorder: ;FB:51C3
    ld a, [wCurrentSpriteCharId]
    cp a, OPERATING_ROOM_LADDER
    jr z, .Label3ED1CC
    jr .Label3ED1DA
.Label3ED1CC
    ld a, [wLabStepLadderPlacedFlag]
    or a
    jr z, .Label3ED1DA
    ld a, $FF
    ld [wStepLadderElevationMode], a
    jp collisionWithStepLadder
.Label3ED1DA
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
;51F6

notObjectCollision:: ;FB:51F6
    ld a, [wCurrentSpriteCharId]
    cp a, MAP_STEP_LADDER
    jr z, resetStepLadderElevationFlag
    cp a, SHED_STEP_LADDER
    jr z, resetStepLadderElevationFlag
    cp a, OPERATING_ROOM_LADDER
    jr z, resetStepLadderElevationFlag
returnNotObjectCollision: ;FB:5205
    xor a
    ret
collisionWithStepLadder: ;FB:5207
    pop hl
    pop de
    jr returnNotObjectCollision
resetStepLadderElevationFlag:
	xor a
    ld [wStepLadderElevationMode], a ;reset step ladder elevation
    jr returnNotObjectCollision
;5211
