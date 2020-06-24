; load a room background on the entire viewport, then load its masks and animations
loadRoomScreenBackgroundCaller: ;01:4D5E
    xor a ; 0
    ld [wRoomBgTileTopY], a
    ld a, 16
    ld [wRoomBgTileBottomY], a
    xor a ; 0
    ld [wRoomBgTileLeftX], a
    ld a, 20
    ld [wRoomBgTileRightX], a

    call loadRoomScreenBackground

    xor a
    ld [wTicksCounter], a ; to reset bg animations
    call loadRoomScreenBackgroundMaskCaller
    jp updateRoomBgAnimationMasks
;4D7D