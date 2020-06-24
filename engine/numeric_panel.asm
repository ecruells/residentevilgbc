numericPanelPuzzle:
    call haltCPU
    call checkNumericPanelInputsCaller
    call updateNumericPanelSpritesCaller
    call enableHDMA
    call swapCurrentOAMBuffer
    ld a, [wButtonPressId]
    and a, B_INPUT
    ret nz
    ld hl, wNumPanelKey01PressedFlag
    ld de, 3 ; key value offset
    ld b, 9 ; panel keys
.validatePanelKeysLoop
    ld a, [hl]
    cp a, $FF
    jr nz, numericPanelPuzzle ; keep looping until all panel lights are on
    add hl, de
    dec b
    jr nz, .validatePanelKeysLoop
; if numeric panel puzzle is solved
    ld a, $FF
    ld [wNumericPanelDoorUnlocked], a
    ld b, $32
    call routineDelay
    ld a, PANEL_PUZZLE_SOLVED_SFX
    call playSFX
    ld hl, text_pointer_4174 ; You unlocked it.
    call displayMessage
    call waitMessageForPlayerInput
    jp clearMessageBox
