
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
            set thistype.hotkeyList[index] = hotkey
        endmethod
        static method GetHotkey takes integer index returns integer
            return thistype.hotkeyList[index]
        endmethod

        // 学习技能热键
        private static integer array learnHotkeyList
        static method SetLearnHotkey takes integer index, integer hotkey returns nothing
            set thistype.learnHotkeyList[index] = hotkey
        endmethod
        static method GetLearnHotkey takes integer index returns integer
            return thistype.learnHotkeyList[index]
        endmethod

        // 回城卷轴热键
        private static integer townPortalScrollHotkey = 'T'
        static method SetTownPortalScrollHotkey takes  integer hotkey returns nothing
            set thistype.townPortalScrollHotkey = hotkey
        endmethod
        static method GetTownPortalScrollHotkey takes nothing returns integer
            return thistype.townPortalScrollHotkey
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

endlibrary
