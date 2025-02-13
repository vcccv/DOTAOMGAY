
library DoubleClickSelfCastLib

    globals
        private constant integer DoubleTapInterval = 500

        private constant key     DOUBLE_CLICK_SELF_CAST

        private integer array KeyStamp
        private integer LastAbilityId       = 0

        private trigger KeyDownTrig         = null
        private trigger CallTargetModeTrig  = null
        private trigger CancelIndicatorTrig = null
    endglobals
    
    function AddDoubleClickSelfCastAbilityById takes integer abilId returns nothing
        local integer hotkey = MHAbility_GetDefDataInt(abilId, ABILITY_DEF_DATA_HOTKEY)
        if hotkey > 0 then
            set Table[DOUBLE_CLICK_SELF_CAST].boolean[abilId] = true
        endif
    endfunction

    function IsAbilityCanDoubeClickSelfById takes integer abilId returns boolean
        return Table[DOUBLE_CLICK_SELF_CAST].boolean[abilId]
    endfunction

    private function SendIndicatorOrder takes unit selectUnit, integer orderId, integer flag returns nothing
        call MHMsg_SendIndicatorOrder(selectUnit, GetUnitX(selectUnit), GetUnitY(selectUnit), orderId, flag)
    endfunction

    private function OnKeyDown takes nothing returns boolean
        local integer key
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

        set abilId        = MHUIData_GetTargetModeAbility()
        set key           = MHEvent_GetKey()
        if not IsAbilityCanDoubeClickSelfById(abilId) then
            set KeyStamp[key] = MHGame_GetGameStamp()
            return false
        endif

        set abilKey = MHAbility_GetDefDataInt(abilId, ABILITY_DEF_DATA_HOTKEY)
        if MHMsg_IsIndicatorOn(INDICATOR_TYPE_TARGET_MODE) /*
            */ and ( abilId == LastAbilityId ) /*
            */ and ( abilKey == key ) /*
            */ and ( ( MHGame_GetGameStamp() - DoubleTapInterval ) < KeyStamp[key] ) then

            /*
            set castType   = MHUIData_GetTargetModeCastType()
            set flag       = LOCAL_ORDER_FLAG_NORMAL

            // 如果按住shift，则添加队列
            if MHMsg_IsKeyDown(0x10) then
                set flag = MHMath_AddBit(flag, LOCAL_ORDER_FLAG_QUEUE)
            endif

            // 根据施法类型设置flag
            if MHMath_IsBitSet(castType, ABILITY_CAST_TYPE_ALONE) then
                set flag = MHMath_AddBit(flag, LOCAL_ORDER_FLAG_ALONE)
            endif
            if MHMath_IsBitSet(castType, ABILITY_CAST_TYPE_INSTANT) then
                set flag = MHMath_AddBit(flag, LOCAL_ORDER_FLAG_INSTANT)
            endif
            if MHMath_IsBitSet(castType, ABILITY_CAST_TYPE_RESTORE) then
                set flag = MHMath_AddBit(flag, LOCAL_ORDER_FLAG_RESTORE)
            endif
            
            // 再次检查是否为目标施法
            if MHMath_IsBitSet(castType, ABILITY_CAST_TYPE_TARGET) then
                call SendIndicatorOrder(MHPlayer_GetSelectUnit(), MHUIData_GetTargetModeOrder(), flag)
                call MHMsg_CancelIndicator()
            endif
            */
            // 对自己施法
            call MHFrame_Click(MHUI_GetPortraitButton())
            // 按住shift时取消指示器
            if MHMsg_IsKeyDown(0x10) then
                call MHMsg_CancelIndicator()
            endif

        endif

        set KeyStamp[key] = MHGame_GetGameStamp()

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
        if IsAbilityCanDoubeClickSelfById(abilId) and MHMath_IsBitSet(castType, ABILITY_CAST_TYPE_TARGET) and not IsLocalAbilityCooldown(abilId) then
            set LastAbilityId = abilId
        else
            set LastAbilityId = 0
        endif 
        return false
    endfunction

    private function OnCancelIndicator takes nothing returns boolean
        set LastAbilityId = 0
        return false
    endfunction

    private function SetAbilityList takes nothing returns nothing
        call AddDoubleClickSelfCastAbilityById('A11N') // X标记
        call AddDoubleClickSelfCastAbilityById('A08V') // 全能魔免
        call AddDoubleClickSelfCastAbilityById('A08N') // 全能加血
        call AddDoubleClickSelfCastAbilityById('A2ML') // 大树护甲
        call AddDoubleClickSelfCastAbilityById('A0QP') // 神灵活血术
        call AddDoubleClickSelfCastAbilityById('A2J2') // 军团加血
        call AddDoubleClickSelfCastAbilityById('A0MF') // 死骑套子
        call AddDoubleClickSelfCastAbilityById('A037') // 猛犸授予力量
        call AddDoubleClickSelfCastAbilityById('A047') // 剑圣棒子
        call AddDoubleClickSelfCastAbilityById('A44X') // 血魔d
        call AddDoubleClickSelfCastAbilityById('A3DM') // A杖蚂蚁大
        call AddDoubleClickSelfCastAbilityById('A0N8') // 地卜师忽悠
        call AddDoubleClickSelfCastAbilityById('A112') // 光法加魔
        call AddDoubleClickSelfCastAbilityById('A21E') // 先知发芽
        call AddDoubleClickSelfCastAbilityById('A0QG') // 兔子套子
        call AddDoubleClickSelfCastAbilityById('A0R7') // 兔子加速
        call AddDoubleClickSelfCastAbilityById('A08R') // 巫妖冰甲
        call AddDoubleClickSelfCastAbilityById('A2TD') // 骨法虚无
        call AddDoubleClickSelfCastAbilityById('A0OJ') // 黑鸟t
        call AddDoubleClickSelfCastAbilityById('A0AS') // 术士暗言术
        call AddDoubleClickSelfCastAbilityById('A1S8') // 毒狗关人
        call AddDoubleClickSelfCastAbilityById('A10L') // 薄葬
        call AddDoubleClickSelfCastAbilityById('A0OR') // 暗牧加血
        call AddDoubleClickSelfCastAbilityById('Z607') // 灵动迅捷
        call AddDoubleClickSelfCastAbilityById('A2LB') // 冰龙加血
        call AddDoubleClickSelfCastAbilityById('A01Z') // 大自然的掩护
        call AddDoubleClickSelfCastAbilityById('A0AS') // 暗言术
        call AddDoubleClickSelfCastAbilityById('A2T5') // 命运敕令
        call AddDoubleClickSelfCastAbilityById('A2SG') // 涤罪之焰
        call AddDoubleClickSelfCastAbilityById('A2TF') // 虚妄诺言
        call AddDoubleClickSelfCastAbilityById('A0G8') // 复制
        call AddDoubleClickSelfCastAbilityById('A04Y') // 噩梦
        call AddDoubleClickSelfCastAbilityById('A00U') // 月蚀
        call AddDoubleClickSelfCastAbilityById('A43H') // 超新星
        call AddDoubleClickSelfCastAbilityById('A083') // 嗜血术
        call AddDoubleClickSelfCastAbilityById('A06B') // 自爆
        call AddDoubleClickSelfCastAbilityById('A471') // A杖自爆
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
