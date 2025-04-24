
library SettingsPanelHandler requires SettingsPanelFrame, HotkeysPanelHandler

    globals
        private trigger KeyDownTrig = null

        private constant integer SETTINGS_PANEL_STATE_NONE    = 0
        private constant integer SETTINGS_PANEL_STATE_HOTKEYS = 1
        private constant integer SETTINGS_PANEL_STATE_OPTIONS = 2


        private integer SettingsPanelState = SETTINGS_PANEL_STATE_NONE

        private integer CheckBoxCount = 0
    endglobals

    
    function SettingsPanel_SetFocusHotkeysPanel takes nothing returns nothing
        if SettingsPanelState == SETTINGS_PANEL_STATE_HOTKEYS then
            return
        endif
        
        call ShowSettinsPanelButtonHighLightByIndex(1, true)
        call ShowSettinsPanelButtonHighLightByIndex(2, false)
        call GetSettingsPanelHotkeysPanelFrame().SetVisible(true)
        call GetSettingsPanelOptionsPanelFrame().SetVisible(false)

        set SettingsPanelState = SETTINGS_PANEL_STATE_HOTKEYS
    endfunction

    function SettingsPanelHotkeysButtonOnClickASync takes nothing returns nothing
        call SettingsPanel_SetFocusHotkeysPanel()
    endfunction

    function SettingsPanelReturnButtonOnClickASync takes nothing returns nothing
        call GetSettingsPanelFrame().SetVisible(false)
        //call GetSettingsPanelSimpleButton().SetEnable(true)
    endfunction

    function SettingsPanelSimpleButtonOnClickASync takes nothing returns nothing
        if GetSettingsPanelFrame().IsVisible() then
            return
        endif

        call GetSettingsPanelFrame().SetVisible(true)
        //call GetSettingsPanelSimpleButton().SetEnable(false)

        call MHUI_PlayNativeSound("QuestLogModified")
    endfunction

    public function OnKeyDownASync takes nothing returns boolean
        local integer pressedKey = MHEvent_GetKey()

        if not HotkeysPanelHandler_OnKeyDownASync(pressedKey) then
            return false
        endif
        
        // esc并且ui可见则隐藏
        if pressedKey == OSKEY_ESCAPE and GetSettingsPanelFrame().IsVisible() then
            call SettingsPanelReturnButtonOnClickASync()
            return false
        endif

        return false
    endfunction

    function SettingsPanelHandler_Init takes nothing returns nothing

        call GetSettinsPanelButtonByIndex(1).RegisterEventByCode(EVENT_ID_FRAME_MOUSE_CLICK, function SettingsPanelHotkeysButtonOnClickASync, false)
    
        call GetSettingsPanelSimpleButton().RegisterEventByCode(EVENT_ID_FRAME_MOUSE_CLICK, function SettingsPanelSimpleButtonOnClickASync, false)
        
        // 对于有快捷键的GLUEBUTTON特殊操作
        // call GetSettingsPanelFrameReturnButton().RegisterEventByCode(EVENT_ID_FRAME_MOUSE_CLICK, function SettingsPanelReturnButtonOnClickASync, false)
        call DzFrameSetScriptByCode(GetSettingsPanelFrameReturnButton().GetPtr(), FRAMEEVENT_CONTROL_CLICK, function SettingsPanelReturnButtonOnClickASync, false)

        // 默认焦点快捷键
        call SettingsPanel_SetFocusHotkeysPanel()

        set KeyDownTrig = CreateTrigger()
        call MHMsgKeyDownEvent_Register(KeyDownTrig)
        call TriggerAddCondition(KeyDownTrig, Condition(function OnKeyDownASync))
    endfunction

endlibrary

