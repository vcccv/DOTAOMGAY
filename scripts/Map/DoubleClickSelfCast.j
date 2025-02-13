
library DoubleClickSelfCast

    globals
        private constant integer DOUBLE_CLICK_TIME_THRESHOLD = 500

        private constant key     DOUBLE_CLICK_SELF_CAST

        private integer array LastKeyPressTimestamp
        private integer TargetModeAbilityId = 0

        private trigger KeyDownTrig         = null
        private trigger CallTargetModeTrig  = null
        private trigger CancelIndicatorTrig = null
    endglobals
    
    function RegisterDoubleClickSelfCastAbilityById takes integer abilId returns nothing
        local integer hotkey = MHAbility_GetDefDataInt(abilId, ABILITY_DEF_DATA_HOTKEY)
        if hotkey > 0 then
            set Table[DOUBLE_CLICK_SELF_CAST].boolean[abilId] = true
        endif
    endfunction

    function IsAbilityCanDoubleClickSelfById takes integer abilId returns boolean
        return Table[DOUBLE_CLICK_SELF_CAST].boolean[abilId]
    endfunction

    private function SendIndicatorOrder takes unit selectUnit, integer orderId, integer flag returns nothing
        call MHMsg_SendIndicatorOrder(selectUnit, GetUnitX(selectUnit), GetUnitY(selectUnit), orderId, flag)
    endfunction

    private function OnKeyDown takes nothing returns boolean
        local integer pressedKey
        local integer abilKey
        local integer abilId
        local integer castType
        local integer flag
        static if LIBRARY_PlayerSettingsManager then
            if not PlayerSettings(User.LocalId).IsDoubleClickSelfCastEnabled() then
                return false
            endif
        endif

        if MHUI_IsChatEditBarOn() then
            return false
        endif

        set abilId     = MHUIData_GetTargetModeAbility()
        set pressedKey = MHEvent_GetKey()
        if not IsAbilityCanDoubleClickSelfById(abilId) then
            set LastKeyPressTimestamp[pressedKey] = MHGame_GetGameStamp()
            return false
        endif

        set abilKey = MHAbility_GetDefDataInt(abilId, ABILITY_DEF_DATA_HOTKEY)
        if MHMsg_IsIndicatorOn(INDICATOR_TYPE_TARGET_MODE) /*
            */ and ( abilId == TargetModeAbilityId ) /*
            */ and ( abilKey == pressedKey ) /*
            */ and ( ( MHGame_GetGameStamp() - DOUBLE_CLICK_TIME_THRESHOLD ) < LastKeyPressTimestamp[pressedKey] ) then

            // 对自己施法
            call MHFrame_Click(MHUI_GetPortraitButton())
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
        local integer castType
        static if LIBRARY_PlayerSettingsManager then
            if not PlayerSettings(User.LocalId).IsDoubleClickSelfCastEnabled() then
                return false
            endif
        endif

        set abilId   = MHMsgCallTargetModeEvent_GetAbility()
        set castType = MHMsgCallTargetModeEvent_GetCastType()
        if IsAbilityCanDoubleClickSelfById(abilId) and MHMath_IsBitSet(castType, ABILITY_CAST_TYPE_TARGET) and not IsLocalAbilityCooldown(abilId) then
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

    private function SetAbilityList takes nothing returns nothing
        call RegisterDoubleClickSelfCastAbilityById('A11N') // X标记
        call RegisterDoubleClickSelfCastAbilityById('A08V') // 全能魔免
        call RegisterDoubleClickSelfCastAbilityById('A08N') // 全能加血
        call RegisterDoubleClickSelfCastAbilityById('A2ML') // 大树护甲
        call RegisterDoubleClickSelfCastAbilityById('A0QP') // 神灵活血术
        call RegisterDoubleClickSelfCastAbilityById('A2J2') // 军团加血
        call RegisterDoubleClickSelfCastAbilityById('A0MF') // 死骑套子
        call RegisterDoubleClickSelfCastAbilityById('A037') // 猛犸授予力量
        call RegisterDoubleClickSelfCastAbilityById('A047') // 剑圣棒子
        call RegisterDoubleClickSelfCastAbilityById('A44X') // 血魔d
        call RegisterDoubleClickSelfCastAbilityById('A3DM') // A杖蚂蚁大
        call RegisterDoubleClickSelfCastAbilityById('A0N8') // 地卜师忽悠
        call RegisterDoubleClickSelfCastAbilityById('A112') // 光法加魔
        call RegisterDoubleClickSelfCastAbilityById('A21E') // 先知发芽
        call RegisterDoubleClickSelfCastAbilityById('A0QG') // 兔子套子
        call RegisterDoubleClickSelfCastAbilityById('A0R7') // 兔子加速
        call RegisterDoubleClickSelfCastAbilityById('A08R') // 巫妖冰甲
        call RegisterDoubleClickSelfCastAbilityById('A2TD') // 骨法虚无
        call RegisterDoubleClickSelfCastAbilityById('A0OJ') // 黑鸟t
        call RegisterDoubleClickSelfCastAbilityById('A0AS') // 术士暗言术
        call RegisterDoubleClickSelfCastAbilityById('A1S8') // 毒狗关人
        call RegisterDoubleClickSelfCastAbilityById('A10L') // 薄葬
        call RegisterDoubleClickSelfCastAbilityById('A0OR') // 暗牧加血
        call RegisterDoubleClickSelfCastAbilityById('Z607') // 灵动迅捷
        call RegisterDoubleClickSelfCastAbilityById('A2LB') // 冰龙加血
        call RegisterDoubleClickSelfCastAbilityById('A01Z') // 大自然的掩护
        call RegisterDoubleClickSelfCastAbilityById('A0AS') // 暗言术
        call RegisterDoubleClickSelfCastAbilityById('A2T5') // 命运敕令
        call RegisterDoubleClickSelfCastAbilityById('A2SG') // 涤罪之焰
        call RegisterDoubleClickSelfCastAbilityById('A2TF') // 虚妄诺言
        call RegisterDoubleClickSelfCastAbilityById('A0G8') // 复制
        call RegisterDoubleClickSelfCastAbilityById('A04Y') // 噩梦
        call RegisterDoubleClickSelfCastAbilityById('A00U') // 月蚀
        call RegisterDoubleClickSelfCastAbilityById('A43H') // 超新星
        call RegisterDoubleClickSelfCastAbilityById('A083') // 嗜血术
        call RegisterDoubleClickSelfCastAbilityById('A06B') // 自爆
        call RegisterDoubleClickSelfCastAbilityById('A471') // A杖自爆
    endfunction

    function DoubleClickSelfCast_Init takes nothing returns nothing
        call SetAbilityList()

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
