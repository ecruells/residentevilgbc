checkDoorsInteractions: ;01:685A
    ld a, [wDoorInteractionID]
    cp a, DOOR_00
    jp z, dinningRoomDoorInvestigationMsg
    cp a, DOOR_20
    jp z, trevorsTombSwitch
    cp a, DOOR_35
    jp z, showPasscodePanel
    cp a, DOOR_3F
    jp z, showCourtyardElevatorMsg
    cp a, DOOR_5C
    jp z, showDorm002DoorEventMsg
    cp a, DOOR_60
    jp z, checkNumericPanel
    cp a, DOOR_72
    jp z, showNoPowerElevatorMsg
; only door interaction type that is not a door
    cp a, USE_TYPEWRITER_ACTION
    jp z, checkTypewriter
    ret
;6886


dinningRoomDoorInvestigationMsg: ;01:6886
    ld hl, text_pointer_402A ; Investigation here is not over yet.
    jp displayActionMessage


trevorsTombSwitch:
    ld a, [wSelectedCharacter]
    or a
    jr z, Label6898 ; if chris
; if jill
    ld a, $FF
    ld [wShowRopeInTrevorsTombFlag], a
    ret
Label6898: ;01:6898
    call clearMessageBox
    call scrollDownScreen
    call showSwitchBelowChoice
    or a
    jp nz, scrollUpScreen ; return if switch not pushed
; if switch pushed
    ld a, $FF
    ld [wTrevorsTombMovedFlag], a
    call loadRoomScreenBackgroundMaskCaller
    ld hl, text_pointer_4003 ; Something has happened!
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen


showPasscodePanel:
    ld a, PASSCODE_PANEL_SCREEN
    ld [wRoomCameraId], a
    call loadEventRoomScreen
    call scrollUpScreen ; it should be scrollDownScreen. TODO: fix this
    call clearMessageBox
    ld hl, text_pointer_4108  ; A pass code panel.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld a, [wSelectedCharacter]
    or a
    jr z, dontHavePasscode ; if chris
; if jill
    ld a, [wMansionPasscodeFiledFlag]
    or a
    jr z, dontHavePasscode
    ld hl, text_pointer_410E ; You've entered the passcode
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld a, $FF
    ld [wMansionPasscodeFiledFlag], a
    ld [wDoorsLocksFlags+DOOR_35], a ; unlock door
    jp scrollUpScreen
dontHavePasscode
    ld hl, text_pointer_410B ; You don't have the passcode
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen


showCourtyardElevatorMsg:
    ld a, [wRoomId]
    cp a, WATERFALL_GARDEN
    jr z, Label6915
    ld hl, text_pointer_409F ; .A winch for the elevator. The elevator is down.
    jp displayActionMessage
Label6915
    ld hl, text_pointer_40B4 ; I've got to get power to the elevator.
    jp displayActionMessage



showDorm002DoorEventMsg:
    ld a, [wDorm002EventSceneFlag]
    or a
    jp nz, showDorm002LockedDoorMsg
    ld a, [wSelectedCharacter]
    or a
    jp z, showDorm002LockedDoorMsg ; if chris
; if jill
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40BA ; Voices can be heard from the other side of the door.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld a, JILL_HEARS_BARRY_CONVERSATION_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wDorm002EventSceneFlag], a
    jp scrollUpScreen



showBrokenNumericPanelMsg: ;6948
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4084 ; A numeric key panel.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_40B7 ; It's broken.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen


checkNumericPanel: ;6969
    ld a, [wSelectedCharacter]
    or a
    jr z, showBrokenNumericPanelMsg ; if chris
; if jill
    xor a
    ld [wNumericPanelKeyId], a
    ld a, NUMERIC_PANEL_SCREEN
    ld [wRoomCameraId], a
    call loadEventRoomScreen
    ld de, wNumPanelKey01PressedFlag
    ld b, 9 * 3 ; values count
    ld hl, defaultNumericPanelValues
setNumericPanelDefaultValues
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, setNumericPanelDefaultValues
    call updateNumericPanelSpritesCaller
    call enableHDMA
    call swapCurrentOAMBuffer
    ld hl, text_pointer_40C0 ; There's a panel with number keys.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_40C3 ; Will you push the keys?  Yes No
    call displayMessage
Label69A4
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr z, Label69A4
Label69AE
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr nz, Label69AE
    ld a, [wChoiceId]
    or a
    ret nz
    call clearMessageBox
    jp numericPanelPuzzle
;69C0

defaultNumericPanelValues: ;69C0
; value, xPos, yPos
	db $FF, 36, 68 ; key 1
	db $00, 36, 83 ; key 2
	db $00, 36, 98 ; key 3
	db $FF, 53, 68 ; key 4
	db $FF, 53, 83 ; key 5
	db $00, 53, 98 ; key 6
	db $FF, 69, 68 ; key 7
	db $00, 69, 83 ; key 8
	db $FF, 69, 98 ; key 9
;69DB


showDorm002LockedDoorMsg: ;01:69DB
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_416E ; It's locked.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_4171 ; The plate says 002.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen


showNoPowerElevatorMsg:
    ld hl, text_pointer_4111 ; There's no reaction. It has no power.
    jp displayActionMessage


checkTypewriter: ;01:6A02
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4183 ; It's an old typewriter.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_4189 ; You can save your progress with this.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_418C ; Will you use the ink ribbon? Yes No
    call displayMessage
Label6A26
    call haltCPU
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, Label6A26
    ld a, [wChoiceId]
    or a
    jp nz, Label6A3F
    ld a, LOAD_SAVE_MENU_ACTION
    ld [wActionButtonEventId], a
Label6A3F
    call clearMessageBox
    call scrollUpScreen
    ret
;6A46
