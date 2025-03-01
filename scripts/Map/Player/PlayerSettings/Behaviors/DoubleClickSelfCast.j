
library DoubleTapAbilityToSelfCast requires Table, TownPortalScrollHandler

    globals
        // 500ms
        private constant integer DOUBE_TAP_TIME_THRESHOLD = 500

        private constant key     KEY

        private integer array LastKeyPressTimestamp
        private integer TargetModeAbilityId = 0

        private trigger KeyDownTrig         = null
        private trigger CallTargetModeTrig  = null
        private trigger CancelIndicatorTrig = null
    endglobals
    
    function RegisterDoubleTapToSelfCastAbilityById takes integer abilId returns nothing
        local integer hotkey = MHAbility_GetDefDataInt(abilId, ABILITY_DEF_DATA_HOTKEY)
        if hotkey > 0 then
            set Table[KEY].boolean[abilId] = true
        endif
    endfunction

    function IsAbilityCanDoubleTapSelfCastById takes integer abilId returns boolean
        return Table[KEY].boolean[abilId]
    endfunction

    private function OnKeyDown takes nothing returns boolean
        local integer pressedKey
        local integer abilKey
        local integer abilId
        local integer castType
        local integer flag
        static if LIBRARY_PlayerSettingsManager then
            if not PlayerSettings(User.LocalId).IsDoubleTapAbilityToSelfCast() then
                return false
            endif
        endif

        if MHUI_IsChatEditBarOn() then
            return false
        endif

        set abilId     = MHUIData_GetTargetModeAbility()
        set pressedKey = MHEvent_GetKey()
        if not IsAbilityCanDoubleTapSelfCastById(abilId) then
            set LastKeyPressTimestamp[pressedKey] = MHGame_GetGameStamp()
            return false
        endif

        set abilKey = MHAbility_GetDefDataInt(abilId, ABILITY_DEF_DATA_HOTKEY)
        if MHMsg_IsIndicatorOn(INDICATOR_TYPE_TARGET_MODE) /*
            */ and ( abilId == TargetModeAbilityId ) /*
            */ and ( abilKey == pressedKey ) /*
            */ and ( ( MHGame_GetGameStamp() - DOUBE_TAP_TIME_THRESHOLD ) < LastKeyPressTimestamp[pressedKey] ) then

            // 对自己施法
            if TOWN_PORTAL_SCROLL_ABILITY_ID == abilId then
                // tp特殊处理，双击时对家里施法
                call TownPortalScroll_SelfCast(MHPlayer_GetSelectUnit())
            else
                call MHFrame_Click(MHUI_GetPortraitButton())
            endif
            // 按住shift时取消指示器
            if MHMsg_IsKeyDown(0x10) then
                call MHMsg_CancelIndicator()
            endif

        endif
        set LastKeyPressTimestamp[pressedKey] = MHGame_GetGameStamp()

        return false
    endfunction

    private function IsLocalAbilityCooldown takes integer abilId returns boolean
        return MHAbility_GetAbilityCooldown(MHUnit_GetAbility(MHPlayer_GetSelectUnit(), abilId, false)) > 0.
    endfunction

    private function OnCallTargetMode takes nothing returns boolean
        local integer abilId
        static if LIBRARY_PlayerSettingsManager then
            if not PlayerSettings(User.LocalId).IsDoubleTapAbilityToSelfCast() then
                return false
            endif
        endif

        set abilId = MHMsgCallTargetModeEvent_GetAbility()
        if IsAbilityCanDoubleTapSelfCastById(abilId) /*
            */ and MHMath_IsBitSet(MHMsgCallTargetModeEvent_GetCastType(), ABILITY_CAST_TYPE_TARGET) /*
            */ and not IsLocalAbilityCooldown(abilId) then
            set TargetModeAbilityId = abilId
        else
            set TargetModeAbilityId = 0
        endif 
        return false
    endfunction

    private function OnCancelIndicator takes nothing returns boolean
        set TargetModeAbilityId = 0
        return false
    endfunction

    function RegisterDoubleTapAbilitys takes nothing returns nothing
        call RegisterDoubleTapToSelfCastAbilityById(TOWN_PORTAL_SCROLL_ABILITY_ID) // TP

        call RegisterDoubleTapToSelfCastAbilityById('A11N') // X标记
        call RegisterDoubleTapToSelfCastAbilityById('A08V') // 全能魔免
        call RegisterDoubleTapToSelfCastAbilityById('A08N') // 全能加血
        call RegisterDoubleTapToSelfCastAbilityById('A2ML') // 大树护甲
        call RegisterDoubleTapToSelfCastAbilityById('A0QP') // 神灵活血术
        call RegisterDoubleTapToSelfCastAbilityById('A2J2') // 军团加血
        call RegisterDoubleTapToSelfCastAbilityById('A0MF') // 死骑套子
        call RegisterDoubleTapToSelfCastAbilityById('A037') // 猛犸授予力量
        call RegisterDoubleTapToSelfCastAbilityById('A047') // 剑圣棒子
        call RegisterDoubleTapToSelfCastAbilityById('A44X') // 血魔d
        call RegisterDoubleTapToSelfCastAbilityById('A3DM') // A杖蚂蚁大
        call RegisterDoubleTapToSelfCastAbilityById('A0N8') // 地卜师忽悠
        call RegisterDoubleTapToSelfCastAbilityById('A112') // 光法加魔
        call RegisterDoubleTapToSelfCastAbilityById('A21E') // 先知发芽
        call RegisterDoubleTapToSelfCastAbilityById('A0QG') // 兔子套子
        call RegisterDoubleTapToSelfCastAbilityById('A0R7') // 兔子加速
        call RegisterDoubleTapToSelfCastAbilityById('A08R') // 巫妖冰甲
        call RegisterDoubleTapToSelfCastAbilityById('A2TD') // 骨法虚无
        call RegisterDoubleTapToSelfCastAbilityById('A0OJ') // 黑鸟t
        call RegisterDoubleTapToSelfCastAbilityById('A0AS') // 术士暗言术
        call RegisterDoubleTapToSelfCastAbilityById('A1S8') // 毒狗关人
        call RegisterDoubleTapToSelfCastAbilityById('A10L') // 薄葬
        call RegisterDoubleTapToSelfCastAbilityById('A0OR') // 暗牧加血
        call RegisterDoubleTapToSelfCastAbilityById('Z607') // 灵动迅捷
        call RegisterDoubleTapToSelfCastAbilityById('A2LB') // 冰龙加血
        call RegisterDoubleTapToSelfCastAbilityById('A01Z') // 大自然的掩护
        call RegisterDoubleTapToSelfCastAbilityById('A0AS') // 暗言术
        call RegisterDoubleTapToSelfCastAbilityById('A2T5') // 命运敕令
        call RegisterDoubleTapToSelfCastAbilityById('A2SG') // 涤罪之焰
        call RegisterDoubleTapToSelfCastAbilityById('A2TF') // 虚妄诺言
        call RegisterDoubleTapToSelfCastAbilityById('A0G8') // 复制
        call RegisterDoubleTapToSelfCastAbilityById('A04Y') // 噩梦
        call RegisterDoubleTapToSelfCastAbilityById('A00U') // 月蚀
        call RegisterDoubleTapToSelfCastAbilityById('A43H') // 超新星
        call RegisterDoubleTapToSelfCastAbilityById('A083') // 嗜血术
        call RegisterDoubleTapToSelfCastAbilityById('A06B') // 自爆
        call RegisterDoubleTapToSelfCastAbilityById('A471') // A杖自爆
    endfunction
    
    function DoubleTapAbilityToSelfCast_Init takes nothing returns nothing
        call RegisterDoubleTapAbilitys()

        set KeyDownTrig = CreateTrigger()
        call MHMsgKeyDownEvent_Register(KeyDownTrig)
        call TriggerAddCondition(KeyDownTrig, Condition(function OnKeyDown))

        set CallTargetModeTrig = CreateTrigger()
        call MHMsgCallTargetModeEvent_Register(CallTargetModeTrig)
        call TriggerAddCondition(CallTargetModeTrig, Condition(function OnCallTargetMode))

        set CancelIndicatorTrig = CreateTrigger()
        call MHMsgCancelIndicatorEvent_Register(CancelIndicatorTrig)
        call TriggerAddCondition(CancelIndicatorTrig, Condition(function OnCancelIndicator))
    endfunction
    
endlibrary
