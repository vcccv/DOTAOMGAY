
library AbilityCustomCastType requires ErrorMessage

    globals
        private constant integer BERSERKER_CAST_TYPE = ABILITY_CAST_TYPE_NONTARGET + ABILITY_CAST_TYPE_INSTANT
    endglobals
    
    function SetAbilityCastType takes integer abilId, integer castType returns nothing
        static if DEBUG_MODE then
            call ThrowError(not MHAbility_SetCastTypeEx(abilId, castType), "AbilityCustomCastType", "SetAbilityCastType", GetObjectName(abilId), abilId, "castType:" + I2S(castType) )
        else
            call MHAbility_SetCastTypeEx(abilId, castType)
        endif
    endfunction

    function AbilityCustomCastType_Init takes nothing returns nothing
        // 锯齿飞轮 - 收回
        call SetAbilityCastType('A2FX', BERSERKER_CAST_TYPE)
        // 双飞之轮 - 收回
        call SetAbilityCastType('A43P', BERSERKER_CAST_TYPE)
        // 先祖之魂 - 收回
        call SetAbilityCastType('A21J', BERSERKER_CAST_TYPE)

        // 噩梦 - 结束
        call SetAbilityCastType('A2O9', BERSERKER_CAST_TYPE)

        // 黑暗之门 - 结束
        call SetAbilityCastType('A2MB', BERSERKER_CAST_TYPE)

        // 复制 - 替换
        call SetAbilityCastType('A0GC', BERSERKER_CAST_TYPE)

        // 脉冲新星
        call SetAbilityCastType('A21F', BERSERKER_CAST_TYPE)
        call SetAbilityCastType('A21G', BERSERKER_CAST_TYPE)
        // 关闭
        call SetAbilityCastType('A21H', BERSERKER_CAST_TYPE)

        // 冰晶爆轰 - 关闭
        call SetAbilityCastType('A1MN', BERSERKER_CAST_TYPE)
        
        // 灵能陷阱 - 触发陷阱
        call SetAbilityCastType(TEMPLAR_ASSASSIN_TRAP_ABILITY_ID, BERSERKER_CAST_TYPE)

        // 幽魂
        call SetAbilityCastType(SPIRITS_IN_ABILITY_ID , BERSERKER_CAST_TYPE)
        call SetAbilityCastType(SPIRITS_OUT_ABILITY_ID, BERSERKER_CAST_TYPE)

        // 力量/敏捷转换
        // call SetAbilityCastType('A0KX', BERSERKER_CAST_TYPE)
        // call SetAbilityCastType('A0KW', BERSERKER_CAST_TYPE)
    endfunction

endlibrary
