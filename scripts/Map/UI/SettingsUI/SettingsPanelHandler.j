
library SettingsPanelHandler requires SettingsPanelFrame

    globals
        private constant integer SETTINGS_PANEL_STATE_NONE    = 0
        private constant integer SETTINGS_PANEL_STATE_HOTKEYS = 1
        private constant integer SETTINGS_PANEL_STATE_OPTIONS = 2


        private integer SettingsPanelState = SETTINGS_PANEL_STATE_NONE
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
        call BJDebugMsg("show！！")
        call GetSettingsPanelFrame().SetVisible(false)
    endfunction

    function SettingsPanelHandler_Init takes nothing returns nothing
        call BJDebugMsg("init")
        call GetSettingsPanelFrameReturnButton().RegisterEventByCode(EVENT_ID_FRAME_MOUSE_CLICK, function SettingsPanelReturnButtonOnClickASync, false)

        call GetSettinsPanelButtonByIndex(1).RegisterEventByCode(EVENT_ID_FRAME_MOUSE_CLICK, function SettingsPanelHotkeysButtonOnClickASync, false)
    
        // 默认焦点快捷键
        call SettingsPanel_SetFocusHotkeysPanel()
    endfunction

endlibrary

