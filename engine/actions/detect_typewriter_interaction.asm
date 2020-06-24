; detect if the action button press in front of a typewriter, triggers a use typewriter action event.

; It also returns true ($FF) if an action is triggered, if not, return false ($00), but this return value
; is never checked, only the checkEvent var is check in another routine.
; 
; hl: typewriter interaction position
detectTypewriterInteraction: ;C5:6638
    ld a, [wActionButtonEventId]
    cp a, BTN_CHECK_ACTION
    jr z, Label316643
    or a
    jp nz, noTypewriterInteraction
Label316643
    ld a, [wEntityPositionX]
    sub a, [hl]
    ld c, a ; store x-distance
    inc hl
    ld a, [wEntityPositionX+1]
    sbc a, [hl]
    inc hl
    or a
    jr z, Label31665C ; if positive x-axis
    cp a, $FF
    jr z, Label316663 ; if negative x-axis
xDistanceOutRange
    ld de, -2
    add hl, de
    jp noTypewriterInteraction
Label31665C
    ld a, c
    cp a, 64
    jr nc, xDistanceOutRange ; return if x-distance >= 64 map units
    jr Label316668
Label316663
    ld a, c
    cp a, -64
    jr c, xDistanceOutRange ; return if x-distance < -64 map units
Label316668
    ld a, [wEntityPositionZ]
    sub a, [hl]
    ld c, a ; store z-distance
    inc hl
    ld a, [wEntityPositionZ+1]
    sbc a, [hl]
    inc hl
    or a
    jr z, Label316681 ; if positive z-axis
    cp a, $FF
    jr z, Label316688 ; if negative z-axis
zDistanceOutRange
    ld de, -4
    add hl, de
    jp noTypewriterInteraction
Label316681
    ld a, c
    cp a, 64
    jr nc, zDistanceOutRange ; return if z-distance >= 64 map units
    jr checkTypewriterFacingInteraction
Label316688
    ld a, c
    cp a, -64
    jr c, zDistanceOutRange ; return if z-distance < -64 map units
checkTypewriterFacingInteraction
    ld a, [wEntityFacing]
    ld c, a
    ld a, [hl] ; get interaction facing
    ld de, -4
    add hl, de
    add a, $10
    sub a, c
    and a, $1F
    cp a, $04
    jr c, checkTypewriterInteractionInput
    cp a, $1C
    jr nc, checkTypewriterInteractionInput
    jp noTypewriterInteraction
checkTypewriterInteractionInput ;C5:66A6
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr z, endTypewriterInteraction ;no A input
; avoid interaction when using weapon
    ld a, [wEntityAnimationId]
    cp a, GUN_AIM_ANIM
    jr z, endTypewriterInteraction
; set use typewriter action
    ld a, $FF
    ld [wRoomInteractionID], a
    ld a, USE_TYPEWRITER_ACTION
    ld [wDoorInteractionID], a
    ld a, BTN_CHECK_ACTION
    ld [wActionButtonEventId], a
endTypewriterInteraction
    ld a, $FF
    ret
noTypewriterInteraction: ;C5:66C6
    xor a
    ret
;66C8
