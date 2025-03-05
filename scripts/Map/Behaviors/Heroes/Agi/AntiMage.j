
scope AntiMage

    //***************************************************************************
    //*
    //*  闪烁
    //*
    //***************************************************************************
    function FSR takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit dummyCaster =(LoadUnitHandle(HY, h, 19))
        local integer count = GetTriggerEvalCount(t)
        local integer FTR = R2I(((.9 -0.3)/ .5)/ .03)
        local integer FUR = R2I((175 / FTR))
        local integer FWR = R2I(( 255/ FTR)* 1.75)
        local unit trigUnit =(LoadUnitHandle(HY, h, 14))
        local real x =(LoadReal(HY, h, 6))
        local real y =(LoadReal(HY, h, 7))
        if count > FTR then
            call SetUnitVertexColor(dummyCaster, 255, 255, 255, 0)
            call SetUnitVertexColorEx(trigUnit,-1,-1,-1, 255)
            call ShowUnit(dummyCaster, false)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        else
            call SetUnitVertexColor(dummyCaster, 255, 255, 255, 175 -FUR * count)
            call SetUnitX(dummyCaster, x)
            call SetUnitY(dummyCaster, y)
            call SetUnitVertexColorEx(trigUnit,-1,-1,-1, FWR * count)
        endif
        set t = null
        set dummyCaster = null
        set trigUnit = null
        return false
    endfunction
    function BlinkOnSpellEffect takes nothing returns nothing
        local unit trigUnit    = GetTriggerUnit()
        local unit dummyCaster =(LoadUnitHandle(HY,(GetHandleId(trigUnit)), 293))
        local trigger t     = CreateTrigger()
        local integer h     = GetHandleId(t)
        local real    x     = GetUnitX(trigUnit)
        local real    y     = GetUnitY(trigUnit)
        call SetUnitX(dummyCaster, x)
        call SetUnitY(dummyCaster, y)
        call SetUnitX(trigUnit, x)
        call SetUnitY(trigUnit, y)
        call SetUnitVertexColorEx(trigUnit,-1,-1,-1, 0)
        call SetUnitVertexColor(dummyCaster, 255, 255, 255, 175)
        call SetUnitTimeScale(dummyCaster, .5)
        call SaveUnitHandle(HY, h, 19,(dummyCaster))
        call SaveUnitHandle(HY, h, 14,(trigUnit))
        call SaveReal(HY, h, 6,((x)* 1.))
        call SaveReal(HY, h, 7,((y)* 1.))
        call TriggerRegisterTimerEvent(t, .03, true)
        call TriggerAddCondition(t, Condition(function FSR))

        set trigUnit = null
        set dummyCaster = null
        set t = null
    endfunction
    function BlinkOnSpellCast takes nothing returns nothing
        local unit trigUnit = GetTriggerUnit()
        local unit dummyCaster
        local integer h = GetHandleId(trigUnit)
        local real a = AngleBetweenXY(GetUnitX(trigUnit), GetUnitY(trigUnit), GetSpellTargetX(), GetSpellTargetY())
        local real x = GetUnitX(trigUnit)
        local real y = GetUnitY(trigUnit)

        call UnitIncNoPathingCount(trigUnit)
        call UnitAddPermanentAbility(trigUnit,'Aeth') // ???
        set dummyCaster = CreateUnit(GetOwningPlayer(trigUnit),'h06K', GetUnitX(trigUnit), GetUnitY(trigUnit), a)
        call RemoveUnitToTimed(dummyCaster, 5.)
        call SetUnitPathing(dummyCaster, false)
        call UnitAddPermanentAbility(dummyCaster,'Aeth')
        call UnitAddPermanentAbility(dummyCaster,'Aloc')
        call UnitAddPermanentAbility(dummyCaster,'A04R')
        call SetUnitVertexColor(dummyCaster, 255, 255, 255, 0)
        call SetUnitX(dummyCaster, x)
        call SetUnitY(dummyCaster, y)
        call SetUnitX(trigUnit, x)
        call SetUnitY(trigUnit, y)
        call SetUnitAnimation(dummyCaster, "Spell Throw")
        call UnitDecNoPathingCount(trigUnit)
        call UnitRemoveAbility(trigUnit, 'Aeth') // ???
        call SaveUnitHandle(HY, h, 293,(dummyCaster))
        set trigUnit = null
        set dummyCaster = null
    endfunction

    function BlinkOnSpellChannel takes nothing returns nothing
        local unit    whichUnit = GetTriggerUnit()
        local integer level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real    value     = GetAbilityRealLevelFieldById(GetSpellAbilityId(), level, ABILITY_LEVEL_DEF_DATA_DATA_A)
        call SetAbilityRealLevelField(GetSpellAbility(), level, ABILITY_LEVEL_DEF_DATA_DATA_A, value + GetUnitCastRangeBonus(whichUnit))
        set whichUnit = null
    endfunction

endscope

