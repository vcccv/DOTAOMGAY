
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
        static method SetTownPortalScrollHotkey takes  integer hotkey returns nothing
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


        // 简化命令按钮
        private boolean hideCommandButton
        method IsCommandButtonHidden takes nothing returns boolean
            return this.hideCommandButton
        endmethod
        method HideCommandButton takes boolean enable returns nothing
            set this.hideCommandButton = enable
        endmethod

        // 双击对己施法
        private boolean doubleTapAbilityToSelfCast
        method IsDoubleTapAbilityToSelfCast takes nothing returns boolean
            return this.doubleTapAbilityToSelfCast
        endmethod
        method EnableDoubleTapAbilityToSelfCast takes boolean enable returns nothing
            set this.doubleTapAbilityToSelfCast = enable
        endmethod

        // 改键仅限英雄
        private boolean changeKeyOnlyHero
        method IsChangekeyOnlyHero takes nothing returns boolean
            return this.changeKeyOnlyHero
        endmethod
        method EnableChangekeyOnlyHero takes boolean enable returns nothing
            set this.changeKeyOnlyHero = enable
        endmethod

        //***************************************************************************
        //*
        //*  选项 Options
        //*
        //***************************************************************************

        // 自动选择召唤物
        private boolean autoSelectSummonedUnits
        method IsAutoSelectSummonedUnits takes nothing returns boolean
            return this.autoSelectSummonedUnits
        endmethod
        method EnableAutoSelectSummonedUnits takes boolean enable returns nothing
            set this.autoSelectSummonedUnits = enable
        endmethod

        // 传送需求Hold/Stop
        private boolean teleportRequiresHoldOrStop
        method IsTeleportRequiresHoldOrStop takes nothing returns boolean
            return true // this.teleportRequiresHoldOrStop
        endmethod
        method EnableTeleportRequiresHoldOrStop takes boolean enable returns nothing
            set this.teleportRequiresHoldOrStop = enable
        endmethod

        // Alt显示中立生物生成区域
        private boolean holdingALTShowsNeutralSpawnboxes
        method IsHoldingALTShowsNeutralSpawnboxes takes nothing returns boolean
            return true //this.holdingALTShowsNeutralSpawnboxes
        endmethod
        method EnableHoldingALTShowsNeutralSpawnboxes takes boolean enable returns nothing
            set this.holdingALTShowsNeutralSpawnboxes = enable
        endmethod

        // Alt显示防御塔攻击范围
        private boolean holdingALTShowsTowerAttackRange
        method IsHoldingALTShowsTowerAttackRange takes nothing returns boolean
            return true//this.holdingALTShowsTowerAttackRange
        endmethod
        method EnableHoldingALTShowsTowerAttackRange takes boolean enable returns nothing
            set this.holdingALTShowsTowerAttackRange = enable
        endmethod

    endstruct


    function PlayerSettingsLib_Init takes nothing returns nothing
        // 热键初始化
        call PlayerSettings.AnalysisHotkey()
    endfunction

endlibrary
