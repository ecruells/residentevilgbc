
ReadJoypad:: ;02BB
    ld a, %00100000
    ld [_HW], a ; write joypad info
    ld a, [_HW]  ; read joypad info
    ld a, [_HW]  ; read joypad info
    cpl
    and a, $0F
    swap a
    ld b, a
    ld a, %00010000
    ld [_HW], a ; write joypad info
    ld a, [_HW]  ; read joypad info
    ld a, [_HW]  ; read joypad info
    ld a, [_HW]  ; read joypad info
    ld a, [_HW]  ; read joypad info
    ld a, [_HW]  ; read joypad info
    ld a, [_HW]  ; read joypad info
    cpl
    and a, $0F
    or a, b
    ld d, a
    ld a, [wButtonsCombinationValue] ; get last button combination
    or a, d
    ld [wButtonsCombinationValue], a ; combine new button press with last button comb
    ld a, d
    ld [wButtonPressId], a ; store pressed button id ito wram
    ld a, %00110000
    ld [_HW], a ; write joypad info
    ret
