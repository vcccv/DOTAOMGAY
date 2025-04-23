
library HotkeysPanelHandler requires HotkeysPanelFrame, TownPortalScrollHandler

    globals
        private constant integer CHANGE_STATE_NONE                      = 0
        private constant integer CHANGE_STATE_HOTKEY                    = 1
        private constant integer CHANGE_STATE_LEARN_HOTKEY              = 2
        private constant integer CHANGE_STATE_TOWN_PORTAL_SCROLL_HOTKEY = 3

        private trigger KeyDownTrig = null

        private integer ChangeHotKeyState = CHANGE_STATE_NONE
        private Frame   FoucsFrame

        private integer array FrameIndex

        private integer array HotkeyList
        private integer array LearnHotkeyList
    endglobals

    private function EnableAllHotkeyButton takes boolean enable returns nothing
        local integer i

        set i = 1
        loop
            exitwhen i > 12
            call GetSettingsPanelHotkeyButton(i, false).SetEnable(enable)
            call GetSettingsPanelHotkeyButton(i, true ).SetEnable(enable)
            set i = i + 1
        endloop

        call SetTownPortalScrollHotkeyButtonState(enable, -1)
    endfunction

    function HotkeysPanelButtonOnClickASync takes nothing returns nothing
        local Frame   frame = Frame.GetTriggerFrame()

        call EnableAllHotkeyButton(false)

        set ChangeHotKeyState = CHANGE_STATE_HOTKEY
        set FoucsFrame        = frame
    endfunction

    function HotkeysPanelLearnButtonOnClickASync takes nothing returns nothing
        local Frame   frame = Frame.GetTriggerFrame()

        call EnableAllHotkeyButton(false)

        set ChangeHotKeyState = CHANGE_STATE_LEARN_HOTKEY
        set FoucsFrame        = frame
    endfunction

    function HotkeysPanelTownPortalScrollHotkeyOnClickASync takes nothing returns nothing
        local Frame   frame = Frame.GetTriggerFrame()

        call EnableAllHotkeyButton(false)

        set ChangeHotKeyState = CHANGE_STATE_TOWN_PORTAL_SCROLL_HOTKEY
        set FoucsFrame        = frame
    endfunction

    private function CancelChangeHotKey takes nothing returns nothing
        call EnableAllHotkeyButton(true)
    
        call FoucsFrame.SetText("")
        set FoucsFrame        = 0
        set ChangeHotKeyState = CHANGE_STATE_NONE
    endfunction

    private function SetHotkey takes integer hotkey returns nothing
        local integer i
        set i = 1
        loop
            exitwhen i > 12

            if HotkeyList[i] == hotkey then
                call GetSettingsPanelHotkeyButton(i, false).SetText("")
                set HotkeyList[i] = - 1
            endif

            set i = i + 1
        endloop

        // 查找重复快捷键，并移除重复的快捷键
        

        call EnableAllHotkeyButton(true)

        call FoucsFrame.SetText(StringCase(Key2Str(hotkey), true))
        set HotkeyList[FrameIndex[FoucsFrame]] = hotkey

        set FoucsFrame        = 0
        set ChangeHotKeyState = CHANGE_STATE_NONE
    endfunction
    private function SetLearnHotkey takes integer hotkey returns nothing
        local integer i
        set i = 1
        loop
            exitwhen i > 12

            if LearnHotkeyList[i] == hotkey then
                call GetSettingsPanelHotkeyButton(i, true).SetText("")
                set LearnHotkeyList[i] = - 1
            endif

            set i = i + 1
        endloop

        // 查找重复快捷键，并移除重复的快捷键


        call EnableAllHotkeyButton(true)

        call FoucsFrame.SetText(StringCase(Key2Str(hotkey), true))
        set LearnHotkeyList[FrameIndex[FoucsFrame]] = hotkey

        set FoucsFrame        = 0
        set ChangeHotKeyState = CHANGE_STATE_NONE

    endfunction

    private function SetTownPortalScrollHotkey takes integer hotkey returns nothing
        call EnableAllHotkeyButton(true)
        
        //call FoucsFrame.SetText(StringCase(Key2Str(hotkey), true))
        call SetTownPortalScrollHotkeyButtonState(true, hotkey)
        call TownPortalScrollHandler_SetHotkey(hotkey)

        set FoucsFrame        = 0
        set ChangeHotKeyState = CHANGE_STATE_NONE
    endfunction

    private function OnKeyDownASync takes nothing returns boolean
        local integer pressedKey = MHEvent_GetKey()

        if ChangeHotKeyState == CHANGE_STATE_NONE then
            return false
        endif

        call MHEvent_SetKey(-1)

        if pressedKey == OSKEY_ESCAPE then
            call CancelChangeHotKey()
            return false
        endif

        if ChangeHotKeyState == CHANGE_STATE_HOTKEY then
            call SetHotkey(pressedKey)
        elseif ChangeHotKeyState == CHANGE_STATE_LEARN_HOTKEY then
            call SetLearnHotkey(pressedKey)
        elseif ChangeHotKeyState == CHANGE_STATE_TOWN_PORTAL_SCROLL_HOTKEY then
            call SetTownPortalScrollHotkey(pressedKey)
        endif

        return false
    endfunction

    function HotkeysPanelHandler_Init takes nothing returns nothing
        local integer i
        local Frame   frame

        set i = 1

        loop
            exitwhen i > 12
            
            set frame = GetSettingsPanelHotkeyButton(i, false)
            set FrameIndex[frame] = i
            call frame.RegisterEventByCode(EVENT_ID_FRAME_MOUSE_CLICK, function HotkeysPanelButtonOnClickASync, false)

            set frame = GetSettingsPanelHotkeyButton(i, true )
            call frame.RegisterEventByCode(EVENT_ID_FRAME_MOUSE_CLICK, function HotkeysPanelLearnButtonOnClickASync, false)
            set FrameIndex[frame] = i

            set i = i + 1
        endloop

        call GetSettingsPanelTownPortalScrollHotkeyButton().RegisterEventByCode(EVENT_ID_FRAME_MOUSE_CLICK, function HotkeysPanelTownPortalScrollHotkeyOnClickASync, false)

        set KeyDownTrig = CreateTrigger()
        call MHMsgKeyDownEvent_Register(KeyDownTrig)
        call TriggerAddCondition(KeyDownTrig, Condition(function OnKeyDownASync))
    endfunction

endlibrary
