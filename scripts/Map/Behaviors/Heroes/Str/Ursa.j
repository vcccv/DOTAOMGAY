
scope Ursa

    globals
        constant integer HERO_INDEX_URSA = 17
    endglobals
    //***************************************************************************
    //*
    //*  震撼大地
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_EARTHSOCK = GetHeroSKillIndexBySlot(HERO_INDEX_URSA, 1)
    endglobals

    function EarthshockDummySpellEffect takes unit whichUnit, integer level returns nothing
        local unit d = CreateUnit(GetOwningPlayer(whichUnit),'e00E', GetUnitX(whichUnit), GetUnitY(whichUnit), 0)
        call UnitAddAbility(d,'A3IC')
        call SetUnitAbilityLevel(d, 'A3IC', level)
        call IssueImmediateOrderById(d, 852096)

        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", GetUnitX(whichUnit), GetUnitY(whichUnit)))
        set d = null
    endfunction
    
    function EarthshockLeakOnUpdate takes nothing returns nothing
        local trigger trig          = GetTriggeringTrigger()
        local integer h             = GetHandleId(trig)
        local unit    whichUnit     = LoadUnitHandle(HY, h, 'u')
        local integer level         = LoadInteger(HY, h, 'l')
        local real    remainingDist = LoadReal(HY, h, 'r')
        local real    totalDist     = LoadReal(HY, h, 'd')
        local real    speed         = LoadReal(HY, h, 's')
        local real    angle         = LoadReal(HY, h, 'a')

        local real    targetX   = GetUnitX(whichUnit) + 10. * Cos(angle * bj_DEGTORAD)
        local real    targetY   = GetUnitY(whichUnit) + 10. * Sin(angle * bj_DEGTORAD)

        local real maxHeight     = 83.0
        local real currentHeight = (1.0 - remainingDist / totalDist) * maxHeight * 2.0
        if GetTriggerEventId()==EVENT_WIDGET_DEATH then
            
            call EarthshockDummySpellEffect(whichUnit, level)
            call UnitDecNoPathingCount(whichUnit)
            if not IsUnitModelFlying(whichUnit) then
                call SetUnitFlyHeight(whichUnit, GetUnitDefaultFlyHeight(whichUnit), 0)
            endif
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(trig)
        else

            if currentHeight > maxHeight then
                set currentHeight = maxHeight * 2.0 - currentHeight
            endif

            if not IsUnitModelFlying(whichUnit) then
                call SetUnitFlyHeight(whichUnit, GetUnitDefaultFlyHeight(whichUnit) + RMaxBJ(currentHeight, 0.0), 0)
            endif
        
            call SetUnitX(whichUnit, CoordinateX50(targetX))
            call SetUnitY(whichUnit, CoordinateY50(targetY))

            call SaveReal(HY, h, 'r', remainingDist - 10.0)
            
            call EXSetUnitFacing(whichUnit, angle)

            if currentHeight < 1.0 and remainingDist - totalDist != 0.0 then
                // 清理状态
                call EarthshockDummySpellEffect(whichUnit, level)
                call SetUnitAnimation(whichUnit, "stand")
                call UnitDecNoPathingCount(whichUnit)
                if not IsUnitModelFlying(whichUnit) then
                    call SetUnitFlyHeight(whichUnit, GetUnitDefaultFlyHeight(whichUnit), 0)
                endif
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(trig)
            endif

        endif

        set whichUnit = null
        set trig      = null
    endfunction

    function EarthshockOnSpellEffect takes nothing returns nothing
        local unit    whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local integer level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local trigger trig
        local integer h
        local real    angle

        if IsUnitRooted(whichUnit) then
            call EarthshockDummySpellEffect(whichUnit, level)
        else
            set angle = GetUnitFacing(whichUnit)

            call UnitAddPermanentAbility(whichUnit,'Amrf')
            call UnitRemoveAbility(whichUnit,'Amrf')
            call UnitIncNoPathingCount(whichUnit)

            set trig = CreateTrigger()
            set h    = GetHandleId(trig)
            call TriggerAddCondition(trig, Condition(function EarthshockLeakOnUpdate))
            call TriggerRegisterTimerEvent(trig, 0.01, true)
            call SaveUnitHandle(HY, h, 'u', whichUnit)
            call SaveReal(HY, h, 'd', 250.)
            call SaveReal(HY, h, 'r', 250.)
            call SaveReal(HY, h, 's', 1000)
            call SaveReal(HY, h, 'a', angle)
            call SaveInteger(HY, h, 'l', level)
            set trig = null
        endif

        set whichUnit = null
    endfunction
    
endscope
