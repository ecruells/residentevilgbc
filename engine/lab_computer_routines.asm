; keys constants
ESC_KEY     EQU $00
ENTER_KEY   EQU $01
BS_KEY      EQU $02
SPACE_KEY   EQU $20

clearComputerLogin: ;01:6A46
    ld hl, wComputerLoginChar01
    jr Label6A4E
clearComputerPassword:
    ld hl, wComputerPasswordChar01
Label6A4E:
    ld a, SPACE_KEY
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], $01
    xor a
    ld [wLoginPasswordLastCharId], a
    ret
;6A5B

checkComputerLogin: ;01:6A5B
    call loadMainFontsBold
    ld hl, wComputerKeyboardKeyId
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    call clearComputerLogin
    call clearComputerPassword
    call showAndUpdateLabComputerKeyboard
    ld hl, text_pointer_4105 ; Accessing computer.
    call displayMessage
    ld hl, text_pointer_4147 ; $ Umbrella Corp.
    ldde 1, 1
    ld a, BANK(text_pointer_4147)
    call printTextAtPosition
    ld hl, text_pointer_414A ; Login:
    ldde 2, 1
    ld a, BANK(text_pointer_414A)
    call printTextAtPosition

keyboardInputLoop:
    call haltCPU
    call updateSelectedKeyboardKey
    ld a, [wComputerKeyboardKeyId]
    ld [wCompKeyboardKeyIdUpdated], a

    call checkKeySelectionInput

    ld a, [wComputerLoginEntered]
    or a
    jr z, .printLogin
.printPassword
    ld bc, wComputerPasswordChar01
    ldhl 3, 10
    ld a, BANK(textPointers)
    call printTextString
.printLogin
    ld bc, wComputerLoginChar01
    ldhl 2, 7
    ld a, BANK(textPointers)
    call printTextString
    ld a, [wButtonPressId]
    and a, B_INPUT
    jr z, keyboardInputLoop
    call resetPalettes
    call loadFontTiles
    ret
;6AC6

checkKeySelectionInput: ;01:6AC6
    call checkLabPCKeyboardInputsCaller
    ld a, [wButtonPressId]
    and a, A_INPUT
    jp nz, Label6AD6
    xor a
    ld [wPressingAButton], a
    ret
;6AD6
Label6AD6: ;01:6AD6
    ld hl, wPressingAButton
    ld a, [hl]
    or a
    ret nz
    ld [hl], $FF
    ld a, [wComputerKeyboardKeyId]
    ld e, a
    ld d, 0
    ld hl, keyboardKeys
    add hl, de ; selected key offset
    ld a, [hl] ; get key value
; if command keys
    cp a, ESC_KEY
    jp z, keyboardESCKeySelected
    cp a, ENTER_KEY
    jp z, keyboardEnterKeySelected
    cp a, BS_KEY
    jp z, keyboardBackspaceKeySelected
; if char key
    ld c, a
    ld a, [wLoginPasswordLastCharId]
    ld e, a
    ld d, $00
    call getCurrentKeyboardInputAddr
    add hl, de
    ld [hl], c ; set current input char
    ld a, [wLoginPasswordLastCharId]
    cp a, 3
    jr z, .Label6B0F ; jump if last char
; else, increment char id
    inc a
    ld [wLoginPasswordLastCharId], a
.Label6B0F
    ld a, CONFIRM_SFX
    jp playSFX
;6B14

computerUsername: ;01:6B14
    db "JOHN"
computerPassword: ;01:6B18
	db "ADA "
ElectronicLocksPassword: ;01:6B1C
	db "MOLE"

keyboardEnterKeySelected: ;01:6B20
    ld a, [wComputerLoginEntered]
    or a
    jp z, printEnterPasswordInput ; jump if login is not enter yet
	; if login & password are entered
; checkLogin Username
    ld hl, wComputerLoginChar01
    ld de, computerUsername
    ld b, 4
.validateUsernameLoop
    ld a, [de]
    cp a, [hl]
    jp nz, computerLoginIncorrect
    inc de
    inc hl
    dec b
    jr nz, .validateUsernameLoop
;checkComputerPassword
    ld hl, wComputerPasswordChar01
    ld de, computerPassword
    ld b, 4
.validatePasswordLoop
    ld a, [de]
    cp a, [hl]
    jp nz, computerPasswordIncorrect
    inc de
    inc hl
    dec b
    jr nz, .validatePasswordLoop
    xor a ; 0
    ld [wComputerPasswordMode], a
    jr computerLoginOkeyed
computerPasswordIncorrect:
    ld hl, wComputerPasswordChar01
    ld de, ElectronicLocksPassword
    ld b, 4
.validateLocksPassword
    ld a, [de]
    cp a, [hl]
    jp nz, eLocksPasswordIncorrect
    inc de
    inc hl
    dec b
    jr nz, .validateLocksPassword
    ld a, 1
    ld [wComputerPasswordMode], a
    jr eLocksLoginOkeyed
computerLoginOkeyed
    ld a, [wLabElectronicDoorsUnlockFlag]
    or a
    jr nz, loginError
    ld hl, text_pointer_4153 ;   LOGIN OKAYED
    ldde 4, 1
    ld a, BANK(text_pointer_4153)
    call printTextAtPosition
    call waitMessageForPlayerInput
    call clearComputerLoginText
    call clearComputerPassword
    jp checkFloorLocksSelection
eLocksLoginOkeyed:
    ld a, [wLabElectronicDoors2UnlockFlag]
    or a
    jr nz, loginError
    ld hl, text_pointer_4153 ;   LOGIN OKAYED
    ldde 4, 1
    ld a, BANK(text_pointer_4153)
    call printTextAtPosition
    call waitMessageForPlayerInput
    call clearComputerLoginText
    call clearComputerPassword
    jp checkFloorLocksSelection
loginError:
    ld hl, text_pointer_4159 ;      ERROR
    ldde 4, 1
    ld a, BANK(text_pointer_4159)
    call printTextAtPosition
    call waitMessageForPlayerInput
    call clearLoginResponse
    call clearComputerPassword
    ld a, OPEN_DOOR_SFX
    jp playSFX

printEnterPasswordInput:
    inc a
    ld [wComputerLoginEntered], a
    xor a
    ld [wLoginPasswordLastCharId], a
    ld hl, text_pointer_414D ; Password:
    ldde 3, 1
    ld a, BANK(text_pointer_414D)
    call printTextAtPosition
    ld a, OPEN_DOOR_SFX
    jp playSFX

eLocksPasswordIncorrect:
    ld hl, text_pointer_4156 ;      DENIED
    ldde 4, 1
    ld a, BANK(text_pointer_4156)
    call printTextAtPosition
    call waitMessageForPlayerInput
    call clearLoginResponse
    call clearComputerPassword
    ld a, CURSOR_SFX
    jp playSFX

computerLoginIncorrect:
    ld hl, text_pointer_4150 ;   LOGIN DENIED
    ldde 4, 1
    ld a, BANK(text_pointer_4150)
    call printTextAtPosition
    call waitMessageForPlayerInput
    call clearComputerLoginText
    ld a, CONFIRM_SFX
    call playSFX
    pop hl
    jp checkComputerLogin

keyboardBackspaceKeySelected:
    ld a, [wLoginPasswordLastCharId]
    ld e, a
    ld d, 0
    call getCurrentKeyboardInputAddr
    add hl, de ; get last input char
    ld a, [hl]
    cp a, SPACE_KEY
    jr z, .deletePreviousChar ; jump if last char is space
; delete last char
    ld [hl], SPACE_KEY
    jr .Label6C2A
.deletePreviousChar
    ld a, [wLoginPasswordLastCharId]
    or a
    ret z ; return if first login-password char
; else, delete previous input char
    dec hl
    ld [hl], SPACE_KEY
    ld a, [wLoginPasswordLastCharId]
    dec a
    ld [wLoginPasswordLastCharId], a
.Label6C2A
    ld a, CLOSE_DOOR_SFX ; it should be a del or cancel sound. TODO: fix this
    jp playSFX

keyboardESCKeySelected:
    pop hl
    ld a, CANCEL_SFX
    jp playSFX

; get current keyboard input
getCurrentKeyboardInputAddr:
    ld hl, wComputerLoginChar01
    ld a, [wComputerLoginEntered]
    or a
    ret z ; return Login chars addr. if login is not enter
; else, return password chars addr
    ld hl, wComputerPasswordChar01
    ret
;6C41


keyboardKeys: ;01:6C41
	db ESC_KEY, "ABCDEFGHIJKLMN", ENTER_KEY
	db "OPQRSTU", ENTER_KEY
	db "VWXYZ", BS_KEY, BS_KEY, ENTER_KEY
;6C61

; selection ids:
SELECTION_B2        EQU 0
SELECTION_B3        EQU 1
SELECTION_CANCEL    EQU 2

checkFloorLocksSelection: ;01:6C61
    xor a
    ld [wElectronicUnlockFloorSelectId], a
    ld hl, text_pointer_415C ; Select Floor
    ldde 1, 1
    ld a, BANK(text_pointer_415C)
    call printTextAtPosition
selectionLoop:
    call checkELocksFloorSelectInputCaller
    call haltCPU
; B2
    ld hl, text_pointer_415F ; B2
    ldde 3, 1
    ld c, BANK(text_pointer_415F) 
    ld b, SELECTION_B2
    call printFloorSelectionOption
; B3
    ld hl, text_pointer_4162 ; B3
    ldde 4, 1
    ld c, BANK(text_pointer_4162)
    ld b, SELECTION_B3
    call printFloorSelectionOption
; Cancel
    ld hl, text_pointer_4165 ; Cancel
    ldde 5, 1
    ld c, BANK(text_pointer_4165)
    ld b, SELECTION_CANCEL
    call printFloorSelectionOption
; check button press
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr nz, Label6CB6
    ld a, [wButtonPressId]
    and a, B_INPUT
    jr z, selectionLoop
.loop6CAB
    call haltCPU
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr nz, .loop6CAB
    ret
Label6CB6: ;01:6CB6
    ld a, [wElectronicUnlockFloorSelectId]
    cp a, SELECTION_CANCEL
    jp z, cancelFloorSelectionChoice
    cp a, SELECTION_B3
    jr z, B3ChoiceSelected
.B2ChoiceSelected
    call haltCPU
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr nz, .B2ChoiceSelected
    ld a, [wVisualDataRoomDoorLock]
    or a
    jp nz, unlockDoorError ;jump if door is unlock
    ld a, [wComputerPasswordMode]
    or a
    jr z, .Label6CE7 ; jump if password is "ADA" mode
; if password is "MOLE" mode
    ld a, [wLabElectronicDoors2UnlockFlag]
    or a
    jp nz, unlockDoorError
    ld a, $FF
    ld [wLabElectronicDoors2UnlockFlag], a
    jr .unlockVisualDataRoomDoor
.Label6CE7
    ld a, [wLabElectronicDoorsUnlockFlag]
    or a
    jp nz, unlockDoorError
    ld a, $FF
    ld [wLabElectronicDoorsUnlockFlag], a
.unlockVisualDataRoomDoor
    ld a, $FF
    ld [wVisualDataRoomDoorLock], a
    ld hl, text_pointer_4168 ; Verified
    ldde 4, 1
    ld a, BANK(text_pointer_4168)
    call printTextAtPosition
    call waitMessageForPlayerInput
    ld hl, text_pointer_416B  ; Unlocked
    ldde 4, 1
    ld a, BANK(text_pointer_416B)
    call printTextAtPosition
    jr reloadPasswordInputTextbox
B3ChoiceSelected:
    call haltCPU
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr nz, B3ChoiceSelected
    ld a, [wLabResearcherRoomDoorLock]
    or a
    jp nz, unlockDoorError ; jump if door is unlock
    ld a, [wComputerPasswordMode]
    or a
    jr z, .Label6D38 ; jump if password is "ADA" mode
	; if password is "MOLE" mode
    ld a, [wLabElectronicDoors2UnlockFlag]
    or a
    jp nz, unlockDoorError
    ld a, $FF
    ld [wLabElectronicDoors2UnlockFlag], a
    jr .unlockLabResearcherRoomDoor
.Label6D38
    ld a, [wLabElectronicDoorsUnlockFlag]
    or a
    jp nz, unlockDoorError
    ld a, $FF
    ld [wLabElectronicDoorsUnlockFlag], a
.unlockLabResearcherRoomDoor
    ld a, $FF
    ld [wLabResearcherRoomDoorLock], a
    ld hl, text_pointer_4168 ; Verified
    ldde 4, 1
    ld a, BANK(text_pointer_4168)
    call printTextAtPosition
    call waitMessageForPlayerInput
    ld hl, text_pointer_416B ; Unlocked
    ldde 4, 1
    ld a, BANK(text_pointer_416B)
    call printTextAtPosition
    jr reloadPasswordInputTextbox
cancelFloorSelectionChoice:
    call haltCPU
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr nz, cancelFloorSelectionChoice
    jr reloadPasswordInputTextbox
unlockDoorError:
    ld hl, text_pointer_4159 ; ERROR
    ldde 1, 1
    ld a, BANK(text_pointer_4159)
    call printTextAtPosition
    call waitMessageForPlayerInput
reloadPasswordInputTextbox:
    call clearComputerLoginText
    ld hl, text_pointer_4105 ; Accessing computer.
    call displayMessage
    ld hl, text_pointer_4147 ; $ Umbrella Corp.
    ldde 1, 1
    ld a, BANK(text_pointer_4147)
    call printTextAtPosition
    ld hl, text_pointer_414A ; Login:
    ldde 2, 1
    ld a, BANK(text_pointer_414A)
    call printTextAtPosition
    ld hl, text_pointer_414D ; Password:
    ldde 3, 1
    ld a, BANK(text_pointer_414D)
    call printTextAtPosition
    ret
;6DA9

clearComputerLoginText: ;01:6DA9
    ld b, 5 ; lines to clear
.loop6DAB
    push bc
    ld h, b
    ld l, $01
    ld bc, ClearOneTextLine
    ld a, BANK(ClearOneTextLine)
    call printTextString
    pop bc
    dec b
    jr nz, .loop6DAB
    ret
;6DBC

clearLoginResponse: ;01:6DBC
    ld b, 2
.clearLoop
    push bc
    ld h, b
    inc h
    inc h
    inc h
    ld l, $01
    ld bc, ClearOneTextLine
    ld a, BANK(ClearOneTextLine)
    call printTextString
    pop bc
    dec b
    jr nz, .clearLoop
    ret

; b: option to eval
; c: text bank
printFloorSelectionOption: ;01:6DD2
    ld a, [wElectronicUnlockFloorSelectId]
    cp a, b
    jr z, .printSelectedOption
.printUnselectedOption
    ld a, c
    jp printTextAtPosition
.printSelectedOption
    ld a, c
    jp printHighlightedText