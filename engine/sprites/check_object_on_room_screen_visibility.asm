; check if an object entity is visible in the current room screen. Return true if
; is visible ($FF), if not, return false ($00)
;
; de: entity data struct address
checkObjectOnRoomScreenVisibility:: ;C4:6421
    ld a, [wCurrentSpriteCharId]
    cp a, MAP_STEP_LADDER
    jp z, Label312445
    cp a, WOODEN_RACK
    jp z, Label312450
    cp a, DORM_002_CLOSET
    jp z, Label31245B
    cp a, HIDDEN_LIBRARY_STATUE
    jp z, Label312466
    cp a, WOODEN_BOX
    jp z, Label312480
; visible by default
    ld a, $FF
    ret

objectIsVisible: ;C4:6440
    ld a, $FF
    ret
objectIsNotVisible: ;C4:6443
    xor a
    ret

Label312445: ;C4:6445
    ld a, [wRoomCameraId]
    cp a, 2
    jp z, objectIsVisible
    jp objectIsNotVisible

Label312450:
    ld a, [wRoomCameraId]
    cp a, 2
    jp z, objectIsVisible
    jp objectIsNotVisible

Label31245B:
    ld a, [wRoomCameraId]
    cp a, 3
    jp z, objectIsVisible
    jp objectIsNotVisible

Label312466:
    ld a, [wRoomCameraId]
    cp a, 2
    jp z, objectIsVisible
    cp a, 4
    jp z, objectIsVisible
    cp a, 6
    jp z, objectIsVisible
    cp a, 7
    jp z, objectIsVisible
    jp objectIsNotVisible

Label312480:
    ld a, [wRoomCameraId]
    cp a, 5
    jp z, objectIsVisible
    jp objectIsNotVisible
    
;C4:648B
