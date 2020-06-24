; detect if the action button press in a room position triggers an interaction event or a pick up item event.

; It also returns true ($FF) if an action is triggered, if not, return false ($00), but this return value
; is never checked, only the checkEvent var is check in another routine.
; 
; hl: room interaction center position pointer
detectRoomIteractionByActionButtonPress: ;C5:63A8
    ld a, [wActionButtonEventId]
    cp a, BTN_CHECK_ACTION
    jr z, .Label3163B3
    or a
    jp nz, notButtonActionDetected
.Label3163B3
    ld de, 4
    add hl, de ; offset to interacion facing
    ld a, [hl]
    ld [wc1f5], a ; unused, it's never read
    ld de, -4
    add hl, de ; offset back to action position
    ld a, [wEntityPositionX]
    sub a, [hl]
    ld c, a ; get x-distance
    inc hl
    ld a, [wEntityPositionX+1]
    sbc a, [hl]
    inc hl
    or a
    jr z, .Label3163D8 ; if positive x-axis
    cp a, $FF
    jr z, .Label3163DF ; if negative x-axis
.Label3163D1
    ld de, -2
    add hl, de
    jp notButtonActionDetected
.Label3163D8
    ld a, c
    cp a, 64
    jr nc, .Label3163D1 ; return if x-distance >= 64
    jr .Label3163E4
.Label3163DF
    ld a, c
    cp a, -64
    jr c, .Label3163D1 ;return if x-distance < -64
.Label3163E4
    ld a, [wEntityPositionZ]
    sub a, [hl]
    ld c, a ; store z-distance
    inc hl
    ld a, [wEntityPositionZ+1]
    sbc a, [hl]
    inc hl
    or a
    jr z, .Label3163FD ; if positive z-axis
    cp a, $FF
    jr z, .Label316404 ; if negative z-axis
.Label3163F6
    ld de, -4
    add hl, de
    jp notButtonActionDetected
.Label3163FD
    ld a, c
    cp a, 64
    jr nc, .Label3163F6 ;return if z-distance >= 64
    jr .checkPickItemFacing
.Label316404
    ld a, c
    cp a, -64
    jr c, .Label3163F6 ;return if z-distance < -64
.checkPickItemFacing
    ld a, [wEntityFacing]
    ld c, a
    ld a, [hl] ; get check action facing
    ld de, -4 ; back to start position offset
    add hl, de
    add a, $10
    sub a, c
    and a, $1F
    cp a, $08
    jr c, .checkPickItemInput
    cp a, 24
    jr nc, .checkPickItemInput
    jp notButtonActionDetected
.checkPickItemInput
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr z, buttonActionDetected
    ld a, [wEntityAnimationId]
    cp a, IDLE_ANIM
    jr nz, buttonActionDetected ; return if not idle anim
    ld de, -2
    add hl, de ; offset to item id
    ld a, [hl] ; get item id
    ld [wSelectedItemId], a
    ld de, -2
    add hl, de ; offset back to room interaction id or room item id
    ld a, [hl] ; get id
    ld [wRoomItemId], a
    call getRoomItemFlagValue
    ld de, 4
    add hl, de ; back to action position
    or a
    jp z, returnNormalCheckAction
; the check action was an iten not picked up yet, so lets trigger a get item action
    ld a, GET_ITEM_ACTION
    ld [wActionButtonEventId], a
buttonActionDetected:
    ld a, $FF
    ret
notButtonActionDetected: ;C5:6453
    xor a
    ret
;6455

; either is a normal room interaction or an already picked up item
returnNormalCheckAction: ;C5:6455
    ld a, [wRoomItemId]
    ld [wRoomInteractionID], a ; store room check action id or room item id
    ld a, $FF
    ld [wDoorInteractionID], a ; set room normal check action mode
    ld a, BTN_CHECK_ACTION
    ld [wActionButtonEventId], a
    xor a
    ret
;6467
