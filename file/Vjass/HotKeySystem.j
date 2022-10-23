

globals
    boolean ChangingHotkey                                      = false
	integer FoucsHotKeyMenuIndex                                = 0
    integer HotKeyMenuButtonsInterval
    integer FirstHotKeyMenuButtons
	// 改键
	// 改键主界面框架
	integer                         HotKeyMenuFrame
    integer                         NewHotKey                   = 0
	// 改键的输入框
	integer         array           HotKeyMenuButtons
    constant        integer         MAX_HOTKEY_MENU_COUNT       = 22
endglobals

function EnableSetUpButtons takes boolean enable returns nothing
    call DzFrameSetEnable(SetUpReturnButton, enable)
    call DzFrameSetEnable(SetUpResetButton, enable)
    call DzFrameSetEnable(SetUpOKButton, enable)
endfunction

function ClickHotKeyMenuButtonsActions takes nothing returns nothing
    local integer hTrigFrame = DzGetTriggerUIEventFrame()
    local integer id
	local integer key
    local integer i = 0

    set id = (hTrigFrame - FirstHotKeyMenuButtons) / HotKeyMenuButtonsInterval

    loop
        exitwhen i > MAX_HOTKEY_MENU_COUNT
        call DzFrameSetEnable(HotKeyMenuButtons[i], false)
        set i = i + 1
    endloop    
    call EnableSetUpButtons(false)
    set FoucsHotKeyMenuIndex = id
    set ChangingHotkey = true
endfunction

function CancelChangeHotKey takes nothing returns nothing
    local integer i = 0

    set LocalCommandButtonHotKey[FoucsHotKeyMenuIndex] = 0
    call DzFrameSetText(HotKeyMenuButtons[FoucsHotKeyMenuIndex], null)
    loop
        exitwhen i > MAX_HOTKEY_MENU_COUNT
        call DzFrameSetEnable(HotKeyMenuButtons[i], true)
        set i = i + 1
    endloop
    call EnableSetUpButtons(true)
    set FoucsHotKeyMenuIndex = 0
    set ChangingHotkey = false
endfunction

function LocalChangeHotKeyActions takes integer key returns nothing
    local integer i     = 0
    local integer min
    local integer max
    if FoucsHotKeyMenuIndex <= 11 then
        set min = 0
        set max = MAX_HOTKEY_MENU_COUNT - 12
    else
        set min = 12
        set max = MAX_HOTKEY_MENU_COUNT
    endif
    loop
        exitwhen i > MAX_HOTKEY_MENU_COUNT
        if LocalCommandButtonHotKey[i] == key and i <= max and i >= min then
            set LocalCommandButtonHotKey[i] = 0
            call DzFrameSetText(HotKeyMenuButtons[i], null)
        endif
        call DzFrameSetEnable(HotKeyMenuButtons[i], true)
        set i = i + 1
    endloop

    set LocalCommandButtonHotKey[FoucsHotKeyMenuIndex] = key
    call DzFrameSetText(HotKeyMenuButtons[FoucsHotKeyMenuIndex], StringCase(Key2Str(key), true))
    call EnableSetUpButtons(true)
    set FoucsHotKeyMenuIndex = 0
    set ChangingHotkey = false
endfunction

// 初始化改键的UI
function InitHotKeyMenuFrame takes nothing returns nothing
	local integer index = 0
	local integer tmp__Int
    local real xOffSet = 0.03
    local real yOffSet = - 0.03
    local integer row = 0
    local integer column = 0
    local real size = 0.035
	set HotKeyMenuFrame = DzCreateFrameByTagName("FRAME", null, UIFrame__SetUp, null, 0)
    call DzFrameSetPriority( HotKeyMenuFrame, -1 )
    call DzFrameSetSize( HotKeyMenuFrame, 0.30, 0.20 )
    loop
		set HotKeyMenuButtons[index] = DzCreateFrameByTagName("GLUETEXTBUTTON", null, HotKeyMenuFrame,"ScriptDialogButton",0)
        call DzFrameSetAbsolutePoint(HotKeyMenuButtons[index], 4, 0.5 + xOffSet * row, 0.460 + yOffSet * column )
        call DzFrameSetSize(HotKeyMenuButtons[index], size, size)

        if ModuloInteger(index+1, 4) == 0 then
            set column = column + 1
            set row = 0
        else
            set row = row + 1
        endif
        
        call DzFrameSetScriptByCode(HotKeyMenuButtons[index], FRAME_EVENT_PRESSED, function ClickHotKeyMenuButtonsActions, false)
        exitwhen index == 11
        set index = index + 1
    endloop

    set index = index + 1
    set row = 0
    set column = 0
    loop
		set HotKeyMenuButtons[index] = DzCreateFrameByTagName("GLUETEXTBUTTON", null, HotKeyMenuFrame,"ScriptDialogButton",0)
        call DzFrameSetAbsolutePoint(HotKeyMenuButtons[index], 4, 0.5 + xOffSet * row, 0.34 + yOffSet * column )
        call DzFrameSetSize(HotKeyMenuButtons[index], size, size)

        if ModuloInteger(index+1, 4) == 0 then
            set column = column + 1
            set row = 0
        else
            set row = row + 1
        endif
        
        call DzFrameSetScriptByCode( HotKeyMenuButtons[index], FRAME_EVENT_PRESSED, function ClickHotKeyMenuButtonsActions, false )
        exitwhen index == MAX_HOTKEY_MENU_COUNT
        set index = index + 1
    endloop

    set FirstHotKeyMenuButtons = HotKeyMenuButtons[0]
    set HotKeyMenuButtonsInterval = HotKeyMenuButtons[1] - HotKeyMenuButtons[0]
endfunction
