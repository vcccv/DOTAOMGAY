
scope Tiny

    globals
        constant integer HERO_INDEX_TINY = 22
    endglobals
    //***************************************************************************
    //*
    //*  长大
    //*
    //***************************************************************************
    // 'A2KK' 魔法书
    // 'A1W0' 50%分裂
    // 'A1W4' 1.75粉碎对建筑
    function GrowOnGetScepterUpgrade takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()

        call UnitAddAttackRangeBonus(whichUnit, 107.)
        call UnitAddPermanentAbility(whichUnit, 'A2KK')
        call UnitMakeAbilityPermanent(whichUnit, true, 'A1W0')
        call UnitMakeAbilityPermanent(whichUnit, true, 'A1W4')
        call UnitHideAbility(whichUnit, 'A2KK', true)

        if GetUnitTypeId(whichUnit) == 'Ucrl' then
            call AddUnitAnimationProperties(whichUnit, "upgrade", true)
        endif
        
        set whichUnit = null
    endfunction
    function GrowOnLostScepterUpgrade takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()

        call UnitReduceAttackRangeBonus(whichUnit, 107.)
        call UnitRemoveAbility(whichUnit, 'A2KK')

        if GetUnitTypeId(whichUnit) == 'Ucrl' then
            call AddUnitAnimationProperties(whichUnit, "upgrade", false)
        endif

        set whichUnit = null
    endfunction

endscope
