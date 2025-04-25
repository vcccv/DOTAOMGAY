
library OptionsPanelHandler requires OptionsPanelFrame, PlayerSettingsLib

    
    // 同步事件
    private function CheckBoxOnClickSync takes nothing returns nothing
        local Frame   frame = Frame.GetTriggerFrame()
        local integer index = GetSettingsPanelCheckBoxIndex(frame)
        local User    pid   = User[Frame.GetTriggerPlayer()]

        local Frame   highlight = GetSettingsPanelCheckBoxHighLightByIndex(index)

        call PlayerSettings[pid].EnableSetting(index, not PlayerSettings[pid].IsSettingEnable(index))
        if pid == User.LocalId then
            call highlight.SetVisible(PlayerSettings[pid].IsSettingEnable(index))
        endif

        if index == PlayerSettings.SHOW_COMMAND_BUTTON_HOTKEY then
            call MHUI_EnableDrawAbilsHotkey(PlayerSettings[pid].IsSettingEnable(index))
        endif
    endfunction

    // 异步事件
    private function CheckBoxOnClickASync takes nothing returns boolean
        local Frame   frame = Frame.GetTriggerFrame()
        local integer index = GetSettingsPanelCheckBoxIndex(frame)

        local Frame   highlight = GetSettingsPanelCheckBoxHighLightByIndex(index)

        call highlight.SetVisible(not highlight.IsVisible())
        return true
    endfunction

    private function SetCheckBoxData takes integer index, string tip, string ubertip returns nothing
        call SettingsPanelCheckBoxSetTextByIndex(index, tip)
        call SettingsPanelCheckBoxSetActivatByIndex(index, PlayerSettings[User.LocalId].IsSettingEnable(index))
        call SettingsPanelCheckBoxSetTooltipByIndex(index, tip, ubertip)
        
        call GetSettingsPanelCheckBoxByIndex(index).RegisterEventByCode(EVENT_ID_FRAME_MOUSE_CLICK, function CheckBoxOnClickASync, false)
        call GetSettingsPanelCheckBoxByIndex(index).RegisterEventByCode(EVENT_ID_FRAME_MOUSE_CLICK, function CheckBoxOnClickSync , true)
    endfunction
    

    function OptionsPanelHandler_Init takes nothing returns nothing
        call SetCheckBoxData(PlayerSettings.AUTO_SELECT_SUMMONED_UNITS, "自动选择召唤物", /*
        */ "开启后使用召唤类技能(包括镜像)将会自动选取被召唤单位。")

        call SetCheckBoxData(PlayerSettings.DOUBLE_TAP_ABILITY_TO_SELF_CAST, "双击对己施法", /*
        */ "开启后快速双击技能快捷键将对自己释放技能。")

       call SetCheckBoxData(PlayerSettings.TELEPORT_REQUIRES_HOLD_OR_STOP, "传送时选中能量圈", /*
        */ "开启后使用回城卷轴时会额外选中自己的能量圈，防止右键点击取消传送。")

        call SetCheckBoxData(PlayerSettings.HOLDING_ALT_SHOWS_NEUTRAL_SPAWNBOXES, "按住ALT键显示野怪刷新范围", /*
        */ "按住ALT键会显示中立生物的刷新范围。")

        call SetCheckBoxData(PlayerSettings.HOLDING_ALT_SHOWS_TOWER_ATTACK_RANGE, "按住ALT键显示防御塔攻击范围", /*
        */ "按住ALT键会显示防御塔的攻击范围。")
    endfunction

endlibrary

