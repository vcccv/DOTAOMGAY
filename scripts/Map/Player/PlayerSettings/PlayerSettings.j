
library PlayerSettingsLib requires PlayerUtils

    struct PlayerSettings extends array

        // //! textmacro PlayerSettingsTextMacro takes args
        //     $args$
        // //! endtextmacro

        //***************************************************************************
        //*
        //*  热键 Hotkeys
        //*
        //***************************************************************************

        // 技能热键
        private static integer array hotkeyList
        static method SetHotkey takes integer index, integer hotkey returns nothing
            local string  value
            local integer i

            set thistype.hotkeyList[index] = hotkey
            // 重新计算存档
            set i     = 1
            set value = ""
            loop
                exitwhen i > 12
                set value = value + I2S(thistype.hotkeyList[i]) + "#"
                set i = i + 1
            endloop
            
            call DzAPI_Map_SaveServerValue(GetLocalPlayer(), "SHotkey", value)
        endmethod
        static method GetHotkey takes integer index returns integer
            return thistype.hotkeyList[index]
        endmethod

        // 学习技能热键
        private static integer array learnHotkeyList
        static method SetLearnHotkey takes integer index, integer hotkey returns nothing
            local string  value
            local integer i

            set thistype.learnHotkeyList[index] = hotkey
            // 重新计算存档
            set i     = 1
            set value = ""
            loop
                exitwhen i > 12
                set value = value + I2S(thistype.learnHotkeyList[i]) + "#"
                set i = i + 1
            endloop
            
            call DzAPI_Map_SaveServerValue(GetLocalPlayer(), "SLearnHotkey", value)
        endmethod
        static method GetLearnHotkey takes integer index returns integer
            return thistype.learnHotkeyList[index]
        endmethod

        // 回城卷轴热键
        private static integer townPortalScrollHotkey = 'T'
        static method SetTownPortalScrollHotkey takes integer hotkey returns nothing
            set thistype.townPortalScrollHotkey = hotkey
            call DzAPI_Map_SaveServerValue(GetLocalPlayer(), "SItemHotkey", I2S(hotkey))
        endmethod
        static method GetTownPortalScrollHotkey takes nothing returns integer
            return thistype.townPortalScrollHotkey
        endmethod
        
        static method AnalysisHotkey takes nothing returns nothing
            local string  hotkeyValue
            local string  learnHotkeyValue
            local string  itemHotkeyValue
            local integer i
            local integer hotkey

            set hotkeyValue      = DzAPI_Map_GetServerValue(GetLocalPlayer(), "SHotkey")
            set learnHotkeyValue = DzAPI_Map_GetServerValue(GetLocalPlayer(), "SLearnHotkey")
            set itemHotkeyValue  = DzAPI_Map_GetServerValue(GetLocalPlayer(), "SItemHotkey")

            // 重新计算存档
            set i     = 1
            loop
                exitwhen i > 12

                // 技能热键
                set hotkey = S2I(MHString_Split(hotkeyValue, "#", i))
                if hotkey > 0 then
                    set thistype.hotkeyList[i] = hotkey
                else
                    set thistype.hotkeyList[i] = -1
                endif

                // 学习技能热键
                set hotkey = S2I(MHString_Split(learnHotkeyValue, "#", i))
                if hotkey > 0 then
                    set thistype.learnHotkeyList[i] = hotkey
                else
                    set thistype.learnHotkeyList[i] = -1
                endif

                set i = i + 1
            endloop

            // tp热键(物品)
            set hotkey = S2I(itemHotkeyValue)
            if hotkey > 0 then
                set thistype.townPortalScrollHotkey = hotkey             
            else
                set thistype.townPortalScrollHotkey = -1
            endif
        endmethod



        static integer OPTIONS_MAX_COUNT = 8

        // 启用热键系统
        static integer ENABLE_HOTKEY_SYSTEM                 = 1
        // 简化命令按钮
        static integer HIDE_COMMAND_BUTTON                  = 2
        // 双击对己施法
        static integer DOUBLE_TAP_ABILITY_TO_SELF_CAST      = 3
        // 改键仅限英雄
        static integer CHANGE_KEY_ONLY_HERO                 = 4
        // 自动选择召唤物
        static integer AUTO_SELECT_SUMMONED_UNITS           = 5
        // 传送需求Hold/Stop
        static integer TELEPORT_REQUIRES_HOLD_OR_STOP       = 6
        // Alt显示中立生物生成区域
        static integer HOLDING_ALT_SHOWS_NEUTRAL_SPAWNBOXES = 7
        // Alt显示防御塔攻击范围
        static integer HOLDING_ALT_SHOWS_TOWER_ATTACK_RANGE = 8


        private static boolean array Options [16][500]

        private boolean hotkeySystemState
        method IsSettingEnable takes integer optionIndex returns boolean
            return thistype.Options[this][optionIndex]
        endmethod
        method EnableSetting takes integer optionIndex, boolean enable returns nothing
            local string  value
            local integer i
            set thistype.Options[this][optionIndex] = enable

            // 重新计算存档
            set i     = 1
            set value = ""
            loop
                exitwhen i > OPTIONS_MAX_COUNT
                if thistype.Options[this][i] then
                    set value = value + "1#"
                else
                    set value = value + "0#"
                endif
            endloop

            call DzAPI_Map_SaveServerValue(GetLocalPlayer(), "SOptions", value)
        endmethod
        
        // 不存档
        method EnableSettingNotStore takes integer optionIndex, boolean enable returns nothing
            set thistype.Options[this][optionIndex] = enable
        endmethod

    endstruct

    private function IsPlayerPlaying takes player whichPlayer returns boolean
        return GetPlayerSlotState(whichPlayer) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController(whichPlayer) == MAP_CONTROL_USER
    endfunction

    function PlayerSettingsLib_Init takes nothing returns nothing
        local integer i
        local integer j
        local string  value

        set i = 1
        loop
            exitwhen i > 15

            if IsPlayerPlaying(Player(i)) then
                // 默认开启的选项
                call PlayerSettings[i].EnableSettingNotStore(PlayerSettings.HIDE_COMMAND_BUTTON,                  true)
                call PlayerSettings[i].EnableSettingNotStore(PlayerSettings.DOUBLE_TAP_ABILITY_TO_SELF_CAST,      true)
                call PlayerSettings[i].EnableSettingNotStore(PlayerSettings.AUTO_SELECT_SUMMONED_UNITS,           true)
                call PlayerSettings[i].EnableSettingNotStore(PlayerSettings.TELEPORT_REQUIRES_HOLD_OR_STOP,       true)
                call PlayerSettings[i].EnableSettingNotStore(PlayerSettings.HOLDING_ALT_SHOWS_NEUTRAL_SPAWNBOXES, true)
                call PlayerSettings[i].EnableSettingNotStore(PlayerSettings.HOLDING_ALT_SHOWS_TOWER_ATTACK_RANGE, true)

                set value = DzAPI_Map_GetServerValue(Player(i), "SOptions")
                if StringLength(value) > 0 then
                    set j = 1
                    loop
                        exitwhen j > PlayerSettings.OPTIONS_MAX_COUNT
                        if S2I(MHString_Split(value, "#", j)) == 1 then
                            call PlayerSettings[i].EnableSettingNotStore(j, true)
                        else
                            call PlayerSettings[i].EnableSettingNotStore(j, false)
                        endif
                        set j = j + 1
                    endloop
                endif
            endif

            set i = i + 1
        endloop


	    call ExecuteFunc("DoubleTapAbilityToSelfCast_Init")
        call ExecuteFunc("HotkeysSystem_Init")
        // 热键初始化
        call PlayerSettings.AnalysisHotkey()
    endfunction

endlibrary
