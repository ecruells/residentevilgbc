
function0829:: ;00:0829
    ld a, [wCurrentRomBank]
    push af
    ld a, $04
    call BankSwitch
    call Label10BC4
    pop af
    jp BankSwitch

loadSpriteData:: ;00:0839
    ld a, [wCurrentRomBank]
    push af
    ld a, $04
    call BankSwitch
    call loadSpriteData
    pop af
    jp BankSwitch

callLoadRoomPal:: ;00:0849
    ld a, $03
    call BankSwitch
    call loadRoomPallete
    ld a, $01
    jp BankSwitch

loadNPCsFrameData:: ;00:0856
    ld hl, loadNPCFrames
    ld a, $FC
    jp goToJumpFuncHL

function085E:: ;00:085E
    ld hl, $4AD4
    ld a, $04
    jp goToJumpFuncHL

function0866:: ;00:0866
    ld hl, $4A8E
    ld a, $04
    jp goToJumpFuncHL

function086E:: ;00:086E
    ld hl, $4A00
    ld a, $04
    jp goToJumpFuncHL

callSprtFloodEfect:: ;00:0876
    ld a, $04
    call BankSwitch
    call applySprtWaterEffect
    ld a, $01
    jp BankSwitch

callRoomOverlapSprt:: ;00:0883
    ld a, $08
    call BankSwitch
    call applyRoomOverlapToSprt
    ld a, $01
    jp BankSwitch

function0890:: ;00:0890
    ld hl, $4C5C
    ld a, $04
    jp goToJumpFuncHL

goToCheckGasRooms:: ;00:0898
    ld hl, checkGasRooms
    ld a, $04
    jp goToJumpFuncHL

callLimitEnemiesRange:: ;00:08A0
    ld hl, limitEnemiesChaseRange
    ld a, $FC
    jp goToJumpFuncHL

callCheckActionInput:: ;00:08A8
    call goToApplyPlayerElevation
    ld hl, checkActionInput
    ld a, $FC
    jr goToJumpFuncHL

function08B2:: ;00:08B2
    ld a, $C5
    ld hl, $6273
    jr goToJumpFuncHL

goToLoadItemsSprt:: ;00:08B9
    ld a, $05
    ld hl, loadMenuItemsSprtData
    jr goToJumpFuncHL

goToLoadEquipedItemSprt:: ;00:08C0
    ld a, $05
    ld hl, loadEquipedSpriteData
    jr goToJumpFuncHL

function08C7:: ;00:08C7
    ld a, $05
    ld hl, $5E90
    jr goToJumpFuncHL

goToLoadItemBigSprite:: ;00:08CE
    ld a, $05
    ld hl, loadItemBigSprite
    jr goToJumpFuncHL

goToCheckTitleCursor:: ;00:08D5
    ld a, $05
    ld hl, checkTitleCursor
    jr goToJumpFuncHL

goToSprtPrioritySort:: ;00:08DC
    ld hl, spritePrioritySort
    ld a, $FC

goShowRoomScrnItemSprt:: ;00:08E3
    jr goToJumpFuncHL
    ld hl, applyRoomOverlapToSprt
    ld a, $FB
    jr goToJumpFuncHL

callCheckSpritesCollision:: ;00:08EA
    ld hl, checkSpritesCollision
    ld a, $FB
    jr goToJumpFuncHL

goToCheckRoomColliders: ;00:08F1
    ld hl, setRoomColliders
    ld a, $FD
    jr goToJumpFuncHL

goToRoomBgChanges:: ;00:08F8
    ld hl, applyRoomBGChange
    ld a, $C4
    jr goToJumpFuncHL

callFunc62C5:: ;00:08FF
    ld a, $C5
    ld hl, functionC5_62C5
    jr goToJumpFuncHL

function0906:: ;00:0906
    ld a, $C5
    ld hl, $6ADC
    jr goToJumpFuncHL

goToCheckRoomBoundaries:: ;00:090D
    ld hl, checkRoomBoundaries
    ld a, $FD
    jr goToJumpFuncHL

checkRoomEvents:: ;00:0914
    ld hl, applyRoomOverlapToSprt
    ld a, $C6
    jr goToJumpFuncHL

goToApplyPlayerElevation:: ;00:091B
    ld hl, applyPlayerElevation
    ld a, $0F
    jr goToJumpFuncHL

goToJumpFuncHL:: ;00:0922
    jp jumpToFunctionHL1

function0925:: ;00:0925
    ld hl, $5F7F
    ld a, $0F
    jr goToJumpFuncHL

function092C:: ;00:092C
    ld hl, $5DCB
    ld a, $0F
    jr goToJumpFuncHL

function0933:: ;00:0933
    ld hl, checkAxSpritesScreenId
    ld a, $C4
    jr .label93F

function093A:: ;00:093A
    ld hl, objectsSpritesFunc
    ld a, $C4
.label93F
    jp jumpToFunctionHL

goToLoadRoomBgMask:: ;00:0942
    ld hl, loadRoomBgMask
    ld a, $04
    jp goToJumpFuncHL

