
ReadJoypad:: ;02BB
    ld a, $20
    ld [$FF00], a ;write joypad info
    ld a, [$FF00]  ;read joypad info
    ld a, [$FF00]  ;read joypad info
    cpl
    and a, $0F
    swap a
    ld b, a
    ld a, $10
    ld [$FF00], a ;write joypad info
    ld a, [$FF00]  ;read joypad info
    ld a, [$FF00]  ;read joypad info
    ld a, [$FF00]  ;read joypad info
    ld a, [$FF00]  ;read joypad info
    ld a, [$FF00]  ;read joypad info
    ld a, [$FF00]  ;read joypad info
    cpl
    and a, $0F
    or a, b
    ld d, a
    ld a, [wButtonsCombinationValue] ;get last button combination
    or a, d
    ld [wButtonsCombinationValue], a ;combine new button press with last button comb
    ld a, d
    ld [wButtonPressId], a ;store pressed button id ito wram
    ld a, $30
    ld [$FF00], a ;write joypad info
    ret
