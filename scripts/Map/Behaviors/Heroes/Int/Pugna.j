
scope Pugna

    globals
        constant integer HERO_INDEX_PUGNA = 73
    endglobals
    //***************************************************************************
    //*
    //*  生命汲取
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_LIFE_DRAIN = GetHeroSKillIndexBySlot(HERO_INDEX_PUGNA, 4)
    endglobals
    // Area = 最远汲取距离
    // 适配以太
    function PugnaLifeDrainOnSpellChannel takes nothing returns nothing
        local unit    whichUnit = GetTriggerUnit()
        local integer level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real    value     = GetAbilityRealLevelFieldById(GetSpellAbilityId(), level, ABILITY_LEVEL_DEF_DATA_AREA)
        call SetAbilityRealLevelField(GetSpellAbility(), level, ABILITY_LEVEL_DEF_DATA_AREA, value + GetUnitCastRangeBonus(whichUnit))
        call BJDebugMsg("施法距离奖励：" + R2S(GetUnitCastRangeBonus(whichUnit)))
        call BJDebugMsg("最终距离" + R2S(value + GetUnitCastRangeBonus(whichUnit)))
        set whichUnit = null
    endfunction

endscope
