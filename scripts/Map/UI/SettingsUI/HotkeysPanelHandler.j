
library HotkeysPanelHandler requires HotkeysPanelFrame, TownPortalScrollHandler, PlayerSettingsLib

    globals
        private constant integer CHANGE_STATE_NONE                      = 0
        private constant integer CHANGE_STATE_HOTKEY                    = 1
        private constant integer CHANGE_STATE_LEARN_HOTKEY              = 2
        private constant integer CHANGE_STATE_TOWN_PORTAL_SCROLL_HOTKEY = 3


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
        call MHUI_PlayNativeSound("GlueScreenClick")

        set ChangeHotKeyState = CHANGE_STATE_HOTKEY
        set FoucsFrame        = frame
    endfunction

    function HotkeysPanelLearnButtonOnClickASync takes nothing returns nothing
        local Frame   frame = Frame.GetTriggerFrame()

        call EnableAllHotkeyButton(false)
        call MHUI_PlayNativeSound("GlueScreenClick")

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
        if ChangeHotKeyState == CHANGE_STATE_HOTKEY then
            call PlayerSettings.SetHotkey(FrameIndex[FoucsFrame], -1)
        elseif ChangeHotKeyState == CHANGE_STATE_LEARN_HOTKEY then
            call PlayerSettings.SetLearnHotkey(FrameIndex[FoucsFrame], -1)
        elseif ChangeHotKeyState == CHANGE_STATE_TOWN_PORTAL_SCROLL_HOTKEY then
            call PlayerSettings.SetTownPortalScrollHotkey(-1)
        endif
 
        set FoucsFrame        = 0
        set ChangeHotKeyState = CHANGE_STATE_NONE
    endfunction

    private function OnSetHotkey takes integer hotkey returns nothing
        local integer i
        set i = 1
        loop
            exitwhen i > 12
            
            if PlayerSettings.GetHotkey(i) == hotkey then
                call GetSettingsPanelHotkeyButton(i, false).SetText("")
                call PlayerSettings.SetHotkey(i, -1)
            endif

            set i = i + 1
        endloop

        // 查找重复快捷键，并移除重复的快捷键
        call EnableAllHotkeyButton(true)

        call FoucsFrame.SetText(StringCase(Key2Str(hotkey), true))
        call PlayerSettings.SetHotkey(FrameIndex[FoucsFrame], hotkey)

        set FoucsFrame        = 0
        set ChangeHotKeyState = CHANGE_STATE_NONE
    endfunction
    private function OnSetLearnHotkey takes integer hotkey returns nothing
        local integer i
        set i = 1
        loop
            exitwhen i > 12

            if PlayerSettings.GetLearnHotkey(i) == hotkey then
                call GetSettingsPanelHotkeyButton(i, true).SetText("")
                call PlayerSettings.SetLearnHotkey(i, -1)
            endif

            set i = i + 1
        endloop

        // 查找重复快捷键，并移除重复的快捷键


        call EnableAllHotkeyButton(true)

        call FoucsFrame.SetText(StringCase(Key2Str(hotkey), true))
        call PlayerSettings.SetLearnHotkey(FrameIndex[FoucsFrame], hotkey)

        set FoucsFrame        = 0
        set ChangeHotKeyState = CHANGE_STATE_NONE

    endfunction

    private function OnSetTownPortalScrollHotkey takes integer hotkey returns nothing
        call EnableAllHotkeyButton(true)
        
        //call FoucsFrame.SetText(StringCase(Key2Str(hotkey), true))
        call SetTownPortalScrollHotkeyButtonState(true, hotkey)
        call TownPortalScrollHandler_SetHotkey(hotkey)

        set FoucsFrame        = 0
        set ChangeHotKeyState = CHANGE_STATE_NONE
    endfunction

    public function OnKeyDownASync takes integer pressedKey returns boolean
        if ChangeHotKeyState == CHANGE_STATE_NONE then
            return true
        endif

        call MHEvent_SetKey(-1)

        if pressedKey == OSKEY_ESCAPE then
            call CancelChangeHotKey()
            return false
        endif

        if ChangeHotKeyState == CHANGE_STATE_HOTKEY then
            call OnSetHotkey(pressedKey)
        elseif ChangeHotKeyState == CHANGE_STATE_LEARN_HOTKEY then
            call OnSetLearnHotkey(pressedKey)
        elseif ChangeHotKeyState == CHANGE_STATE_TOWN_PORTAL_SCROLL_HOTKEY then
            call OnSetTownPortalScrollHotkey(pressedKey)
        endif

        return false
    endfunction

    private function SetCheckBoxData takes integer index, string tip, string ubertip returns nothing
        call SettingsPanelCheckBoxSetTextByIndex(index, tip)
        call SettingsPanelCheckBoxSetActivationByIndex(index, PlayerSettings[User.LocalId].IsSettingEnable(index))
        call SettingsPanelCheckBoxSetTooltipByIndex(index, tip, ubertip)
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
            call frame.SetText(StringCase(Key2Str(PlayerSettings.GetHotkey(i)), true))

            set frame = GetSettingsPanelHotkeyButton(i, true )
            set FrameIndex[frame] = i
            call frame.RegisterEventByCode(EVENT_ID_FRAME_MOUSE_CLICK, function HotkeysPanelLearnButtonOnClickASync, false)
            call frame.SetText(StringCase(Key2Str(PlayerSettings.GetLearnHotkey(i)), true))

            set i = i + 1
        endloop

        call GetSettingsPanelTownPortalScrollHotkeyButton().RegisterEventByCode(EVENT_ID_FRAME_MOUSE_CLICK, function HotkeysPanelTownPortalScrollHotkeyOnClickASync, false)
        // 设置面板内的快捷键显示
        call SetTownPortalScrollHotkeyButtonState(true, PlayerSettings.GetTownPortalScrollHotkey())


        // 复选框
        call SetCheckBoxData(PlayerSettings.ENABLE_HOTKEY_SYSTEM           , "启用热键系统", /*
        */ "开启后，会修改命令栏快捷键，如果没有填写热键，则没有快捷键。")
        call SetCheckBoxData(PlayerSettings.HIDE_COMMAND_BUTTON            , "简化命令按钮", /*
        */ "隐藏除了攻击以外的基础命令按钮，增加可用的命令按钮数量。")
        call SetCheckBoxData(PlayerSettings.DOUBLE_TAP_ABILITY_TO_SELF_CAST, "双击对己施法", /*
        */ "开启后快速双击技能快捷键将对自己释放技能。")
    endfunction

endlibrary
