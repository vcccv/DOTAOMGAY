
scope HotkeySystem

    globals
        boolean ChangingHotkey                                      = false
        integer FoucsHotKeyMenuIndex                                = 0

        // 改键
        // 改键主界面框架
        integer                         HotkeyMenuFrame
        // 改键的输入框
        integer         array           HotKeyMenuButtons
        real                            ChangHotkeyTime             = 0.
        boolean                         ResetSetupButtons           = false

        // 12 + 11
        constant        integer         MAX_HOTKEY_MENU_COUNT       = 23
        key HOTKEY_BUTTON_INDEX
    endglobals

    function EnableSetupButtons takes boolean enable returns nothing
        call DzFrameSetEnable(MapSetupReturnButton, enable)
        call DzFrameSetEnable(MapSetupResetButton , enable)
        call DzFrameSetEnable(MapSetupOKButton    , enable)
    endfunction

    function ClickHotKeyMenuButtonsActions takes nothing returns nothing
        local integer index = GetFrameIndex(DzGetTriggerUIEventFrame(), HOTKEY_BUTTON_INDEX)
        local integer i     = 1

        loop
            exitwhen i > MAX_HOTKEY_MENU_COUNT
            call DzFrameSetEnable(HotKeyMenuButtons[i], false)
            set i = i + 1
        endloop

        call EnableSetupButtons(false)
        set FoucsHotKeyMenuIndex = index
        set ChangingHotkey       = true
    endfunction

    function ResetHotkey takes nothing returns nothing
        local integer i = 1
        loop
        exitwhen i > MAX_HOTKEY_MENU_COUNT
            call DzFrameSetText(HotKeyMenuButtons[i], null)
            set LocalCommandButtonHotkey[i] = 0
            set i = i + 1
        endloop
    endfunction

    function CancelChangeHotKey takes nothing returns nothing
        local integer i = 1

        if FoucsHotKeyMenuIndex != 0 then
            set LocalCommandButtonHotkey[FoucsHotKeyMenuIndex] = 0
            call DzFrameSetText(HotKeyMenuButtons[FoucsHotKeyMenuIndex], null)
        endif
        loop
            exitwhen i > MAX_HOTKEY_MENU_COUNT
            call DzFrameSetEnable(HotKeyMenuButtons[i], true)
            set i = i + 1
        endloop
        call EnableSetupButtons(true)
        set FoucsHotKeyMenuIndex = 0
        set ChangingHotkey       = false
    endfunction

    function LocalChangeHotKeyActions takes integer key returns nothing
        local integer i    = 1
        local integer min
        local integer max

        if FoucsHotKeyMenuIndex <= 12 then
            set min = 0
            set max = 12
        else
            set min = 12
            set max = MAX_HOTKEY_MENU_COUNT
        endif

        loop
            exitwhen i > MAX_HOTKEY_MENU_COUNT
            if LocalCommandButtonHotkey[i] == key and i <= max and i >= min then
                set LocalCommandButtonHotkey[i] = 0
                call DzFrameSetText(HotKeyMenuButtons[i], null)
            endif
            call DzFrameSetEnable(HotKeyMenuButtons[i], true)
            set i = i + 1
        endloop

        set LocalCommandButtonHotkey[FoucsHotKeyMenuIndex] = key
        call DzFrameSetText(HotKeyMenuButtons[FoucsHotKeyMenuIndex], StringCase(Key2Str(key), true))
        set FoucsHotKeyMenuIndex = 0
        set ChangingHotkey       = false
        set ResetSetupButtons    = true
    endfunction

    // 初始化改键的UI
    function HotkeySystem_Init takes nothing returns nothing
        local integer index   = 1
        local real    xOffSet = 0.03
        local real    yOffSet = - 0.03
        local integer row     = 0
        local integer column  = 0
        local real    size    = 0.035

        set HotkeyMenuFrame = DzCreateFrameByTagName("FRAME", null, EscMenuMapOptionsPanel, null, 0)
        call DzFrameSetPriority(HotkeyMenuFrame, -1)
        call DzFrameSetSize(HotkeyMenuFrame, 0.30, 0.20)

        loop
            
            if ModuloInteger(index, 4) == 1 then
                set column = column + 1
                set row    = 1
            else
                set row = row + 1
            endif

            set HotKeyMenuButtons[index] = DzCreateFrameByTagName("GLUETEXTBUTTON", "HotkeyMenuFrameButton" + I2S(index), HotkeyMenuFrame, "ScriptDialogButton", index)
            call SetFrameIndex(HotKeyMenuButtons[index], HOTKEY_BUTTON_INDEX, index)

            call DzFrameSetAbsolutePoint(HotKeyMenuButtons[index], FRAMEPOINT_CENTER, 0.47 + xOffSet * row, 0.490 + yOffSet * column)
            call DzFrameSetSize(HotKeyMenuButtons[index], size, size)
            
            call DzFrameSetScriptByCode(HotKeyMenuButtons[index], FRAMEEVENT_CONTROL_CLICK, function ClickHotKeyMenuButtonsActions, false)
            exitwhen index == 12
            set index = index + 1
        endloop

        set index  = index + 1
        set row    = 0
        set column = 0
        loop

            if ModuloInteger(index-12, 4) == 1 then
                set column = column + 1
                set row    = 1
            else
                set row = row + 1
            endif

            set HotKeyMenuButtons[index] = DzCreateFrameByTagName("GLUETEXTBUTTON", "HotkeyMenuFrameButton" + I2S(index), HotkeyMenuFrame, "ScriptDialogButton", index)
            call SetFrameIndex(HotKeyMenuButtons[index], HOTKEY_BUTTON_INDEX, index)

            call DzFrameSetAbsolutePoint(HotKeyMenuButtons[index], FRAMEPOINT_CENTER, 0.47 + xOffSet * row, 0.37 + yOffSet * column)
            call DzFrameSetSize(HotKeyMenuButtons[index], size, size)
            
            call DzFrameSetScriptByCode(HotKeyMenuButtons[index], FRAMEEVENT_CONTROL_CLICK, function ClickHotKeyMenuButtonsActions, false)
            exitwhen index == MAX_HOTKEY_MENU_COUNT
            set index = index + 1
        endloop

    endfunction

endscope
