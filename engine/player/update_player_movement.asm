walkAnimationInput: ;FC:4794
    ld a, [wButtonPressId]
    and a, B_INPUT
    jr nz, .checkRunning
    ld a, [wButtonPressId]
    and a, ALL_DIRECTION_INPUT
    jr nz, .updatePlayerMovement
.stopWalking
    ld a, IDLE_ANIM
    ld [wEntityAnimationId], a
    xor a
    ld [wEntityAnimationFrameId], a
    ret
.checkRunning ;FC:47AC
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jr nz, .updatePlayerMovement
.beginRunning
    ld a, RUN_ANIM
    ld [wEntityAnimationId], a
.updatePlayerMovement
    ld a, [wButtonPressId]
    and a, UP_INPUT
    call nz, movePlayerForward
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    call nz, movePlayerBackward
    call checkTurnLeftInputPress
    call checkTurnRightInputPress
    ret
;47CF

runAnimationInput: ;FC:47CF
    ld a, [wButtonPressId]
    and a, B_INPUT
    jr z, .stopRunning
    ld a, [wButtonPressId]
    and a, ALL_DIRECTION_INPUT
    jr nz, .updatePlayerMovement
.stopMoving
    ld a, IDLE_ANIM
    ld [wEntityAnimationId], a
    xor a
    ld [wEntityAnimationFrameId], a
    ld a, $FF
    ld [wPressingBButton], a
    ret
.stopRunning
    ld a, WALK_ANIM
    ld [wEntityAnimationId], a
.updatePlayerMovement
    ld a, [wButtonPressId]
    and a, UP_INPUT
    call nz, movePlayerForward
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    call nz, movePlayerBackward
    call checkTurnLeftInputPress
    call checkTurnRightInputPress
    ret
;4808

checkTurnLeftInputPress: ;FC:4808
    ld hl, wPressingLeftKey
    ld a, [wButtonPressId]
    and a, LEFT_INPUT
    jp z, leftInputNotPressed
    ld a, [hl]
    or a
    jr z, .label3F081F ; key is being pressed repeatedly and timer reached zero
; left key is being held down, decrease input timer for next rotation
    dec [hl]
    ld a, [hl]
    or a
    ret nz ; input timer is decreasing yet, keep waiting for next rotation
    ld [hl], 6 ; set input timer (shorter time by held down key)
    jr .updateFacingDirection
.label3F081F
    ld [hl], 10 ; set input timer (longer time by press repeatedly)
.updateFacingDirection
    ld a, [wEntityFacing]
    add a, 4 ; rotate left
    and a, $1F ; set limit
    ld [wEntityFacing], a
    ld a, [wEntityAnimationId]
    cp a, WALK_ANIM
    jr z, Label3F083D
    cp a, IDLE_ANIM
    ret nz
; if idle, reset frame id
    xor a
    ld [wEntityAnimationFrameId], a
    ret
leftInputNotPressed: ;FC:483A
    ld [hl], 0 ; reset input timer
    ret
Label3F083D:
	ret

checkTurnRightInputPress: ;FC:483E
    ld hl, wPressingRightKey
    ld a, [wButtonPressId]
    and a, RIGHT_INPUT
    jp z, rightInputNotPressed
    ld a, [hl]
    or a
    jr z, .label3F0855 ; key is being pressed repeatedly and timer reached zero
; right key is being held down, decrease input timer for next rotation
    dec [hl]
    ld a, [hl]
    or a
    ret nz
    ld [hl], 6 ; set input timer (shorter time by held down key)
    jr .updateFacingDirection
.label3F0855
    ld [hl], 10 ; set input timer (longer time by press repeatedly)
.updateFacingDirection
    ld a, [wEntityFacing]
    sub a, 4 ; turn right
    and a, $1F
    ld [wEntityFacing], a
    ld a, [wEntityAnimationId]
    cp a, WALK_ANIM
    jr z, Label3F0873
    cp a, IDLE_ANIM
    ret nz
; if idle, reset frame id
    xor a
    ld [wEntityAnimationFrameId], a
    ret
rightInputNotPressed: ;FC:4870
    ld [hl], 0 ; reset input timer
    ret
Label3F0873:
	ret

movePlayerForward: ;FC:4874
    ld a, [wEntityAnimationFrameId]
    add a, 4 ; update move animation frame
    and a, $3F ; set limit frame
    ld [wEntityAnimationFrameId], a
.moveNorth
    ld bc, 0
    ld de, 14
    ld a, [wEntityFacing]
    cp a, FACING_NORTH_WEST
    jr c, .applyMoveOffset
.moveNorthWest
    ld bc, 12
    ld de, 12
    cp a, FACING_WEST
    jr c, .applyMoveOffset
.moveWest
    ld bc, 14
    ld de, 0
    cp a, FACING_SOUTH_WEST
    jr c, .applyMoveOffset
.moveSouthWest
    ld bc, 12
    ld de, -12
    cp a, FACING_SOUTH
    jr c, .applyMoveOffset
.moveSouth
    ld bc, 0
    ld de, -14
    cp a, FACING_SOUTH_EAST
    jr c, .applyMoveOffset
.moveSouthEast
    ld bc, -12
    ld de, -12
    cp a, FACING_EAST
    jr c, .applyMoveOffset
.moveEast
    ld bc, -14
    ld de, 0
    cp a, FACING_NORTH_EAST
    jr c, .applyMoveOffset
.moveNorthEast
    ld bc, -12
    ld de, 12
.applyMoveOffset ;48CD
    call duplicateMoveSpeed ; duplicte speed if running
; sum x axis movement offset
    ld a, [wEntityPositionX]
    add a, c
    ld [wEntityPositionX], a
    ld a, [wEntityPositionX+1]
    adc a, b
    ld [wEntityPositionX+1], a
; sum z axis movement offset
    ld a, [wEntityPositionZ]
    add a, e
    ld [wEntityPositionZ], a
    ld a, [wEntityPositionZ+1]
    adc a, d
    ld [wEntityPositionZ+1], a
; player steps sfx every 3 anim ticks
    ld a, [wEntityAnimationFrameId]
    and a, $1F
    cp a, $03
    jr c, .playWalkSfx
    ret
.playWalkSfx ;FC:48F6
    ld a, STEPS_SFX
    jp playSFX

movePlayerBackward: ;FC:48FB
    ld a, [wEntityAnimationFrameId]
    sub a, $03
    and a, $3F
    ld [wEntityAnimationFrameId], a
.moveSouth
    ld bc, 0
    ld de, -7
    ld a, [wEntityFacing]
    cp a, FACING_NORTH_WEST
    jr c, .applyBackwardMovement
.moveSouthEast
    ld bc, -6
    ld de, -6
    cp a, FACING_WEST
    jr c, .applyBackwardMovement
.moveEast
    ld bc, -7
    ld de, 0
    cp a, FACING_SOUTH_WEST
    jr c, .applyBackwardMovement
.moveNorthEast
    ld bc, -6
    ld de, 6
    cp a, FACING_SOUTH
    jr c, .applyBackwardMovement
.moveNorth
    ld bc, 0
    ld de, 7
    cp a, FACING_SOUTH_EAST
    jr c, .applyBackwardMovement
.moveNorthWest
    ld bc, 6
    ld de, 6
    cp a, FACING_EAST
    jr c, .applyBackwardMovement
.moveWest
    ld bc, 7
    ld de, 0
    cp a, FACING_NORTH_EAST
    jr c, .applyBackwardMovement
.moveSouthWest
    ld bc, 6
    ld de, -6
.applyBackwardMovement
    ld a, [wEntityPositionX]
    add a, c
    ld [wEntityPositionX], a
    ld a, [wEntityPositionX+1]
    adc a, b
    ld [wEntityPositionX+1], a
    ld a, [wEntityPositionZ]
    add a, e
    ld [wEntityPositionZ], a
    ld a, [wEntityPositionZ+1]
    adc a, d
    ld [wEntityPositionZ+1], a
    ret
;4971

; bc: x axis move offset
; de: z axis move offset
duplicateMoveSpeed: ;FC:4971
    ld a, [wEntityAnimationId]
    cp a, RUN_ANIM
    ret nz
    push bc
    pop hl
    add hl, bc ; bc * 2
    ld c, l
    ld b, h
    push de
    pop hl
    add hl, de ; de * 2
    ld e, l
    ld d, h
    ret
;4982
