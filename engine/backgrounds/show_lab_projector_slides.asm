; visual data room projector slides. All slides bg masks are unfinished, all pointers
; points to empty space or other code data resulting in blank or glitched bg tiles
; TODO: add the slides tilemaps
showLabProjectorSlide1: ;01:4D2D
    ld hl, labProjectorSlide01 ; umbrella inc slide
    jr showSlide
showLabProjectorSlide2:
    ld hl, labProjectorSlide02 ; cerberus slide
    jr showSlide
showLabProjectorSlide3:
    ld hl, labProjectorSlide03 ; neptune slide
    jr showSlide
showLabProjectorSlide4:
    ld hl, labProjectorSlide04 ; hunter slide
    jr showSlide
showLabProjectorSlide5:
    ld hl, labProjectorSlide05 ; tyrant slide
; missing umbrella research staff slide pointer

showSlide:
    ld a, 2
    ld [wRoomBgTileTopY], a
    ld a, 14
    ld [wRoomBgTileBottomY], a
    ld a, 2
    ld [wRoomBgTileLeftX], a
    ld a, 18
    ld [wRoomBgTileRightX], a
    call loadRoomBackgroundArea
    jp waitMessageForPlayerInput
;4D5E
