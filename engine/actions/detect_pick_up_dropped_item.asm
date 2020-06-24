; detect if the action button press over a dropped item triggers a pick up item event.

; It also returns true ($FF) if an action is triggered, if not, return false ($00), but this return value
; is never checked, only the checkEvent var is check in another routine.
; 
; hl: dropped item position pointer
detectPickUpDroppedItem: ;C5:6467
    ld a, [wActionButtonEventId]
    cp a, BTN_CHECK_ACTION
    jr z, .Label316472
    or a
    jp nz, noDroppedItemChecked
.Label316472
    ld de, $4
    add hl, de ; offset to interaction facing
    ld a, [hl]
    ld [wc1f5], a ; unused, it's never read
    ld de, -4
    add hl, de
    ld a, [wEntityPositionX]
    sub a, [hl]
    ld c, a ; get x-distance
    inc hl
    ld a, [wEntityPositionX+1]
    sbc a, [hl]
    inc hl
    or a
    jr z, .Label316497 ; if positive x-axis
    cp a, $FF
    jr z, .Label31649E ; if negative x-axis
.Label316490
    ld de, -2
    add hl, de
    jp noDroppedItemChecked
.Label316497
    ld a, c
    cp a, 32
    jr nc, .Label316490 ;return if x-distance >= 32
    jr .Label3164A3
.Label31649E
    ld a, c
    cp a, -32
    jr c, .Label316490 ;return if x-distance < -32
.Label3164A3
    ld a, [wEntityPositionZ]
    sub a, [hl]
    ld c, a ; get z-distance
    inc hl
    ld a, [wEntityPositionZ+1]
    sbc a, [hl]
    inc hl
    or a
    jr z, .Label3164BC ; if positive z-axis
    cp a, $FF
    jr z, .Label3164C3 ; if negative z-axis
.Label3164B5
    ld de, -4
    add hl, de
    jp noDroppedItemChecked
.Label3164BC
    ld a, c
    cp a, 32
    jr nc, .Label3164B5 ; return if z-distance >= 32
    jr .checkDroppedItemInput
.Label3164C3
    ld a, c
    cp a, -32
    jr c, .Label3164B5 ; return if z-distance < -32
.checkDroppedItemInput
    ld de, -4 ; offset back to start position
    add hl, de
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr z, droppedItemChecked
    ld a, [wEntityAnimationId]
    cp a, IDLE_ANIM
    jr nz, droppedItemChecked
    ld de, -2
    add hl, de ; get item Id
    ld a, [hl]
    ld [wFoundItemId], a
    ld de, -2
    add hl, de ; offset back to room interaction id or room item id
    ld a, [hl] ; get id
    ld [wRoomItemId], a
    call getRoomItemFlagValue
    ld de, 4
    add hl, de ; back to dropped item position
    or a
    jp z, droppedItemPickedUp
; dropped item has not be picked up yet, so lets trigger a get dropped item action,
; and change the player animation
    ld a, PICK_ITEM_ANIM
    ld [wEntityAnimationId], a
    xor a
    ld [wEntityAnimationFrameId], a
    ld [wActionButtonEventId], a
    ret
droppedItemChecked: ;C5:6502
    ld a, $FF
    ret
noDroppedItemChecked: ;C5:6505
    xor a
    ret
;6507

; dropped item is already picked up, so return a normal check interaction
droppedItemPickedUp: ;C5:6507
    ld a, [wRoomItemId]
    ld [wRoomInteractionID], a
    ld a, $FF
    ld [wDoorInteractionID], a
    ld a, BTN_CHECK_ACTION
    ld [wActionButtonEventId], a
    xor a
    ret
;6519
