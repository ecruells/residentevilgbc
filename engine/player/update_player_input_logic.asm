; update player inputs for movement, pick items and weapon aiming/attack/shooting
updatePlayerInputs: ;FC:44DB
    xor a
    ld [wActionButtonEventId], a ; reset button event
; convert player position to map units
; pos x
    ld a, [wEntityPositionX]
    ld e, a
    ld a, [wEntityPositionX+1]
    ld d, a
    call div8WordFC
    ld a, e
    ld [wEntityRoomPositionX], a
    ld a, d
    ld [wEntityRoomPositionX+1], a
; pos z
    ld a, [wEntityPositionZ]
    ld e, a
    ld a, [wEntityPositionZ+1]
    ld d, a
    call div8WordFC
    ld a, e
    ld [wEntityRoomPositionZ], a
    ld a, d
    ld [wEntityRoomPositionZ+1], a
; check if player is already moving
    ld a, [wMoveInputBlockTimer]
    or a
    jr z, .playerIsNotMoving
    dec a
    ld [wMoveInputBlockTimer], a
    cp a, $08
    ret nc ; player is moving
.playerIsNotMoving
    ld a, [wWeaponBlockTimer]
    or a
    jr z, .playerIsNotShooting
; is shooting, decrease timer
    dec a
    ld [wWeaponBlockTimer], a
.playerIsNotShooting
    ld a, [wFiregunFramesId]
    or a
    jr z, .label3F052F
; update firegun frame id
    and a, $7F
    add a, 2
    cp a, $0C
    jr c, .label3F052D
    xor a
    jr .label3F052F
.label3F052D
    or a, $80
.label3F052F
    ld [wFiregunFramesId], a
; update blood frame id
    ld a, [wBloodFramesId]
    or a
    jr z, .label3F0544
    and a, $7F
    inc a
    cp a, $0C
    jr c, .label3F0542
    xor a
    jr .label3F0544
.label3F0542
    or a, $80
.label3F0544 ;4544
    ld [wBloodFramesId], a

.updatePlayerAnimation
    ld a, [wEntityAnimationId]
    cp a, IDLE_ANIM
    jp z, updatePlayerIdleAnimation
    cp a, WALK_ANIM
    jp z, walkAnimationInput
    cp a, RUN_ANIM
    jp z, runAnimationInput
    cp a, GUN_AIM_ANIM
    jp z, checkHandgunShotInput
    cp a, SHOTGUN_AIM_ANIM
    jp z, checkShotgunShootInput
    cp a, KNIFE_AIM_ANIM
    jp z, knifeAimAnimationInput
    cp a, PICK_ITEM_ANIM
    jp z, pickItemAnimationInput
    ld a, IDLE_ANIM
    ld [wEntityAnimationId], a
    xor a
    ld [wEntityAnimationFrameId], a ; reset frameId
    ret
;4577

pickItemAnimationInput: ;FC:4577
    ld a, [wEntityAnimationFrameId]
    inc a
    cp a, 16
    jr nc, .Label3F0583
; player is moving
    ld [wEntityAnimationFrameId], a
    ret
.Label3F0583 ;FC:4583
    ld [wEntityAnimationFrameId], a
    cp a, 16
    jr nz, .Label3F0590
    ld a, DROPPED_ITEM_ACTION
    ld [wActionButtonEventId], a
    ret
.Label3F0590 ;FC:4590
    cp a, 32
    ret c
    ld a, IDLE_ANIM
    ld [wEntityAnimationId], a
    xor a
    ld [wEntityAnimationFrameId], a
    ret
;459D

updatePlayerIdleAnimation: ;FC:459D
    ld a, [wButtonPressId]
    and a, B_INPUT
    jr nz, checkWeaponAimButtonPress
    xor a
    ld [wPressingBButton], a
checkRotationInput:
    ld a, [wButtonPressId]
    and a, LEFT_INPUT
    call nz, indleAnimLeftInput
    ld a, [wButtonPressId]
    and a, RIGHT_INPUT
    call nz, indleAnimRightInput
    ld a, [wButtonPressId]
    and a, UP_INPUT
    call nz, indleAnimUpInput
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    call nz, indleAnimDownInput
    call checkTurnLeftInputPress
    call checkTurnRightInputPress
    ld a, [wButtonPressId]
    and a, ALL_DIRECTION_B_INPUT
    ret nz
    ld a, [wEntityAnimationFrameId]
    cp a, IDLE_ANIM_F2
    ret z ; no input after idle timer stop
; increase idle animation timer
    inc a
    ld [wEntityAnimationFrameId], a
    ret

indleAnimLeftInput: ;FC:45DF
    ret

indleAnimRightInput: ;FC:45E0
    ret

indleAnimUpInput: ;FC:45E1
    ld a, WALK_ANIM ;$01
    ld [wEntityAnimationId], a
    xor a
    ld [wEntityAnimationFrameId], a
    jp movePlayerForward

indleAnimDownInput: ;FC:45ED
    ld a, WALK_ANIM ;$01
    ld [wEntityAnimationId], a
    ld a, $3F
    ld [wEntityAnimationFrameId], a
    jp movePlayerBackward
