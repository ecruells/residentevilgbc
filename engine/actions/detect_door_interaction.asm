; detect if the action button press in front of a door trigger a door interaction trigger

; It also returns true ($FF) if an action is triggered, if not, return false ($00), but this return value
; is never checked, only the checkEvent var is check in another routine.
; 
; hl: door interaction position pointer
detectDoorInteraction:: ;C5:6519
    ld a, [wActionButtonEventId]
    or a
    jp nz, notDoorInteraction
    ld de, 4
    add hl, de ; offset to door interaction facing
    ld a, [hl]
    ld [wButtonActionFacing], a
    ld de, -4 ; offset back
    add hl, de
    ld a, [wEntityPositionX]
    sub a, [hl]
    ld c, a ; get x-distance
    inc hl
    ld a, [wEntityPositionX+1]
    sbc a, [hl]
    inc hl
    or a
    jr z, setActionRangePositiveXAxis ; if positive x-axis
    cp a, $FF
    jr z, setActionRangeNegativeXAxis ; if negative x-axis
returnNoPosXMatch
    ld de, -2
    add hl, de
    jp notDoorInteraction
setActionRangePositiveXAxis:
    ld b, 8 ; distance when facing at north-south
    ld a, [wButtonActionFacing]
    and a, $0F ; mask only east-west facing
    jr nz, Label316550
	; set distance when facing east-west
    ld b, 128
Label316550
    ld a, c
    cp a, b
    jr nc, returnNoPosXMatch ; return if out of action x-range
    jr checkDoorZDistance
setActionRangeNegativeXAxis:
    ld b, -8 ; distance when facing at north-south
    ld a, [wButtonActionFacing]
    and a, $0F ;mask only east-west facing
    jr nz, Label316561
	; set distance when facing east-west
    ld b, $80
Label316561
    ld a, c
    cp a, b
    jr c, returnNoPosXMatch ; return if out of action x-range
checkDoorZDistance
    ld a, [wEntityPositionZ]
    sub a, [hl]
    ld c, a ; get z-distance
    inc hl
    ld a, [wEntityPositionZ+1]
    sbc a, [hl]
    inc hl
    or a
    jr z, setActionRangePositiveYAxis
    cp a, $FF
    jr z, setActionRangeNegativeYAxis
doorZDistanceOutRange
    ld de, -4
    add hl, de
    jp notDoorInteraction
setActionRangePositiveYAxis
    ld b, $80
    ld a, [wButtonActionFacing]
    and a, $0F ; mask only east-west facing
    jr nz, Label316589
    ld b, $08
Label316589
    ld a, c
    cp a, b
    jr nc, doorZDistanceOutRange
    jr checkDoorInteractionFacing
setActionRangeNegativeYAxis
    ld b, $80
    ld a, [wButtonActionFacing]
    and a, $0F
    jr nz, Label31659A
    ld b, $F8
Label31659A
    ld a, c
    cp a, b
    jr c, doorZDistanceOutRange
checkDoorInteractionFacing
    ld a, [wEntityFacing]
    ld c, a
    ld a, [hl]
    ld de, -4
    add hl, de
    add a, $10
    sub a, c
    and a, $1F
    cp a, $08
    jr c, checkDoorInteractionInput
    cp a, $18
    jr nc, checkDoorInteractionInput
    jp notDoorInteraction
checkDoorInteractionInput
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr z, endDoorInteraction
; avoid interaction when using a weapon
    ld a, [wEntityAnimationId]
    cp a, GUN_AIM_ANIM
    jr z, endDoorInteraction
    cp a, KNIFE_AIM_ANIM
    jr z, endDoorInteraction
    cp a, SHOTGUN_AIM_ANIM
    jr z, endDoorInteraction
    ld de, -5 ; offset back to door type ID
    add hl, de
    call checkDoorUnlocked
    or a
    jp z, checkedDoorIsLocked
; door is unlocked
    ld a, [hl] ; door type id
    ld [wDoorAnimationType], a
    srl a
    srl a
    srl a
    ld [wDoorSpriteId], a
    ld a, [hl]
    and a, 7
    ld [wDoorPaletteId], a
    ld de, 3
    add hl, de ; get door other side struct pointer
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    inc de
    ld a, [de] ; get other side room id
    ld [wRoomId], a
    inc de
    ld a, [de]
    ld [wRoomIdHigh], a
; offset to other side door position
    inc de
    inc de
    inc de
; set player position to the other side of the door
    ld a, [de]
    ld [wEntityPositionX], a
    inc de
    ld a, [de]
    ld [wEntityPositionX+1], a
    inc de
    ld a, [de]
    ld [wEntityPositionZ], a
    inc de
    ld a, [de]
    ld [wEntityPositionZ+1], a
    inc de
    ld a, [de]
    ld [wEntityFacing], a
    ld a, OPEN_DOOR_ACTION
    ld [wActionButtonEventId], a
endDoorInteraction
    ld a, $FF
    ret
;6620
notDoorInteraction: ;C5:6620
    xor a
    ret
;6622
checkedDoorIsLocked: ;C5:6622
    ld de, 5 ; offset to interaction position
    add hl, de
    ld a, $FF
    ld [wRoomInteractionID], a
    ld a, [wDoorLockFlagId]
    ld [wDoorInteractionID], a ; door id event
    ld a, BTN_CHECK_ACTION
    ld [wActionButtonEventId], a ; normal check action
    xor a
    ret
;6638
