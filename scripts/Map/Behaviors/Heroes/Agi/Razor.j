
scope Razor

    globals
        constant integer HERO_INDEX_RAZOR = 71
    endglobals

    //***************************************************************************
    //*
    //*  静电连接
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_STATIC_LINK = GetHeroSKillIndexBySlot(HERO_INDEX_RAZOR, 2)
    endglobals
    
    function EYA takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer h = GetHandleId(t)
        local integer i = LoadInteger(ObjectHashTable, h, 1)
        call UnitAddStateBonus(LoadUnitHandle(ObjectHashTable, h, 1), i, UNIT_BONUS_ATTACK)
        call UnitSubStateBonus(LoadUnitHandle(ObjectHashTable, h, 0), i, UNIT_BONUS_DAMAGE)
        call DestroyTimerAndFlushHT_P(t)
        set t = null
    endfunction
    function EZA takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer h = GetHandleId(t)
        local integer UYX = LoadInteger(ObjectHashTable, h, 0) + 1
        local integer O3O = LoadInteger(ObjectHashTable, h, 1)
        local unit u1 = LoadUnitHandle(ObjectHashTable, h, 0)
        local unit u2 = LoadUnitHandle(ObjectHashTable, h, 1)
        local unit dummyUnit = LoadUnitHandle(ObjectHashTable, h, 33)
        local real x2 = GetWidgetX(u2)
        local real y2 = GetWidgetY(u2)
        local real x1 = GetWidgetX(u1)
        local real y1 = GetWidgetY(u1)
        local real range = 700 + GetUnitCastRangeBonus(u1)
        if UYX == 320 or IsUnitDeath(u1) or IsUnitDeath(u2) or GetDistanceBetween(x1, y1, x2, y2) > range then
            call DestroyLightning(LoadLightningHandle(ObjectHashTable, h, 2))
            call UnitAddAbilityLevel1ToTimed(u1,'C023','D023', 18)
            call UnitAddAbilityLevel1ToTimed(u2,'C024','D024', 18)
            call TimerStart(t, 18, false, function EYA)
            call RemoveUnit(dummyUnit)
            set u2 = null
            set u1 = null
            set t = null
            set dummyUnit = null
            return
        endif
        call SaveInteger(ObjectHashTable, h, 0, UYX)
        call MoveLightning(LoadLightningHandle(ObjectHashTable, h, 2), false, x1, y1, x2, y2)
        call SetUnitPosition(dummyUnit, GetUnitX(u2), GetUnitY(u2))
        set UYX = R2I(LoadInteger(ObjectHashTable, h, 2)* UYX * 1. / 40.)
        if LoadInteger(ObjectHashTable, h, 1)<= UYX then
            call UnitSubStateBonus(u2, UYX -LoadInteger(ObjectHashTable, h, 1), UNIT_BONUS_ATTACK)
            call UnitAddStateBonus(u1, UYX -LoadInteger(ObjectHashTable, h, 1), UNIT_BONUS_DAMAGE)
            call SaveInteger(ObjectHashTable, h, 1, UYX)
        endif
        set dummyUnit = null
        set u2 = null
        set u1 = null
        set t = null
    endfunction
    function StaticLinkOnSpellEffect takes nothing returns nothing
        local lightning l = null
        local timer t = CreateTimer()
        local unit u = GetTriggerUnit()
        local unit d = GetSpellTargetUnit()
        local integer h = GetHandleId(t)
        local integer i = GetUnitAbilityLevel(u,'A1DP')
        local unit dummyUnit
        if GetUnitTypeId(u)=='e00E'then
            set u = PlayerHeroes[GetPlayerId(GetOwningPlayer(u))]
        endif
        set dummyUnit = CreateUnit(GetOwningPlayer(u),'h088', GetUnitX(d), GetUnitY(d), 0)
        set l = AddLightning("CLSB", true, GetWidgetX(u), GetWidgetY(u), GetWidgetX(d), GetWidgetY(d))
        set i = 7 * i
        call SetLightningColor(l, .3, .5, 1, 1)
        call SaveUnitHandle(ObjectHashTable, h, 0, u)
        call SaveUnitHandle(ObjectHashTable, h, 1, d)
        call SaveUnitHandle(ObjectHashTable, h, 33, dummyUnit)
        call SaveLightningHandle(ObjectHashTable, h, 2, l)
        call SaveInteger(ObjectHashTable, h, 0, 0)
        call SaveInteger(ObjectHashTable, h, 2, i)
        call TimerStart(t, .025, true, function EZA)
        set d = null
        set u = null
        set l = null
        set t = null
        set dummyUnit = null
    endfunction

endscope
