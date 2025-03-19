
library AbilityCustomCastType requires Base, SkillSystem, ScepterUpgradeSystem

    globals
        private constant integer BERSERKER_CAST_TYPE = ABILITY_CAST_TYPE_NONTARGET + ABILITY_CAST_TYPE_INSTANT
        private constant integer PASSIVE_CAST_TYPE   = 0
    endglobals
    
    // 0 = 被动
    function SetAbilityCastType takes integer abilId, integer castType returns nothing
        static if DEBUG_MODE then
            call ThrowError(not MHAbility_SetCastTypeEx(abilId, castType), "AbilityCustomCastType", "SetAbilityCastType", GetObjectName(abilId), abilId, "castType:" + I2S(castType) )
        else
            call MHAbility_SetCastTypeEx(abilId, castType)
        endif
    endfunction

    function SetAbilityCastTypeByIndex takes integer skillIndex, integer castType returns nothing
        local integer abilityId           = HeroSkill_BaseId[skillIndex]
        local integer passiveIndex
        local integer scepterUpgradeIndex
        
        set passiveIndex = GetPassiveSkillIndexByLearnedId(abilityId)
        if passiveIndex != 0 then
            call BJDebugMsg("!" + Id2String(PassiveSkill_Show[passiveIndex]) + GetObjectName(PassiveSkill_Show[passiveIndex]))
            call SetAbilityCastType(PassiveSkill_Show[passiveIndex], castType)
            return
        endif
        call BJDebugMsg("2" + Id2String(abilityId) + GetObjectName(abilityId))
        set scepterUpgradeIndex = GetScepterUpgradeIndexById(abilityId)
        if scepterUpgradeIndex > 0 then
            call SetAbilityCastType(ScepterUpgrade_BaseId[scepterUpgradeIndex], castType)
            call SetAbilityCastType(ScepterUpgrade_UpgradedId[scepterUpgradeIndex], castType)
        else
            call SetAbilityCastType(abilityId, castType)
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

        call SetAbilityCastTypeByIndex(SKILL_INDEX_TIDEBRINGER , PASSIVE_CAST_TYPE)
        call SetAbilityCastTypeByIndex(SKILL_INDEX_PHANTOM_RUSH, PASSIVE_CAST_TYPE)
        call SetAbilityCastTypeByIndex(SKILL_INDEX_AFTERSHOCK, PASSIVE_CAST_TYPE)

        // 力量/敏捷转换
        // call SetAbilityCastType('A0KX', BERSERKER_CAST_TYPE)
        // call SetAbilityCastType('A0KW', BERSERKER_CAST_TYPE)
    endfunction

endlibrary
