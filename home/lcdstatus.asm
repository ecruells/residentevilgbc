lcdStatus: ;00:02FE
    di
    push af
.loop0300
    ld a, [rSTAT]  ;lcd status
    and a, STATF_OAM
    jr z, .loop0300 ; loop until OAM-RAM flag is disabled
    ld a, [rLCDC]  ;lcd control
; enable all except obj display
    and a, LCDCF_ON | LCDCF_WIN9C00 | LCDCF_WINON | LCDCF_BG8000 | LCDCF_BG9C00 | LCDCF_OBJ16 | LCDCF_BGON
    ld [rLCDC], a ;lcd control
    pop af
    reti
