Hblank: ;00:02FE
    di
    push af
.loop0300
    ld a, [rSTAT]  ;lcd status
    and a, $02
    jr z, .loop0300 ; loop if searching OAM-RAM Mode flag is disabled
    ld a, [rLCDC]  ;lcd control
    and a, %11111101 ;$FD ; enable all except obj display
    ld [rLCDC], a ;lcd control
    pop af
    reti
