
scope Lion

    globals
        constant integer HERO_INDEX_LION = 104
    endglobals
    //***************************************************************************
    //*
    //*  法力汲取
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_MANA_DRAIN = GetHeroSKillIndexBySlot(HERO_INDEX_LION, 3)
    endglobals
    // Area = 最远汲取距离
    // 适配以太
    function LionManaDrainOnSpellChannel takes nothing returns nothing
        local unit    whichUnit = GetTriggerUnit()
        local integer level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real    value     = GetAbilityRealLevelFieldById(GetSpellAbilityId(), level, ABILITY_LEVEL_DEF_DATA_AREA)
        call SetAbilityRealLevelField(GetSpellAbility(), level, ABILITY_LEVEL_DEF_DATA_AREA, value + GetUnitCastRangeBonus(whichUnit))
        set whichUnit = null
    endfunction

endscope
