; detect if the action button press in front of an itembox triggers an itembox use action event.

; It also returns true ($FF) if an action is triggered, if not, return false ($00), but this return value
; is never checked, only the checkEvent var is check in another routine.
; 
; hl: 
detectItemboxInteraction: ;C5:66C8
    ld a, [wActionButtonEventId]
    or a
    jp nz, noItemboxInteraction
    ld a, [wEntityPositionX]
    sub a, [hl]
    ld c, a ; get x-distance
    inc hl
    ld a, [wEntityPositionX+1]
    sbc a, [hl]
    inc hl
    or a
    jr z, Label3166E8 ; if positive x-axis
    cp a, $FF
    jr z, Label3166EF ; if negative x-axis
itemBoxOutofXRange
    ld de, -2
    add hl, de
    jp noItemboxInteraction
Label3166E8
    ld a, c
    cp a, 64
    jr nc, itemBoxOutofXRange ; return if x-distance >= 64 map units
    jr Label3166F4
Label3166EF
    ld a, c
    cp a, -64
    jr c, itemBoxOutofXRange ; return if x-distance < -64 map units
Label3166F4
    ld a, [wEntityPositionZ]
    sub a, [hl]
    ld c, a ; get z-distance
    inc hl
    ld a, [wEntityPositionZ+1]
    sbc a, [hl]
    inc hl ; get interaction facing
    or a
    jr z, Label31670D ; if positive z-axis
    cp a, $FF
    jr z, Label316714 ; if negative z-axis
itemBoxOutofZRange
    ld de, -4
    add hl, de
    jp noItemboxInteraction
Label31670D
    ld a, c
    cp a, 64
    jr nc, itemBoxOutofZRange
    jr checkItemboxInteractionFacing
Label316714
    ld a, c
    cp a, -64
    jr c, itemBoxOutofZRange
checkItemboxInteractionFacing
    ld a, [wEntityFacing]
    ld c, a
    ld a, [hl]
    ld de, -4
    add hl, de
    add a, $10
    sub a, c
    and a, $1F
    cp a, $04
    jr c, checkItemboxInteractionInput
    cp a, $1C
    jr nc, checkItemboxInteractionInput
    jp noItemboxInteraction
checkItemboxInteractionInput
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr z, endItemboxInteraction
; avoid interaction when using a weapon
    ld a, [wEntityAnimationId]
    cp a, GUN_AIM_ANIM
    jr z, endItemboxInteraction
; set itembox action mode
    ld a, ITEMBOX_MENU_ACTION
    ld [wActionButtonEventId], a
endItemboxInteraction
    ld a, $FF
    ret
noItemboxInteraction: ;C5:6748
    xor a
    ret
;674A
