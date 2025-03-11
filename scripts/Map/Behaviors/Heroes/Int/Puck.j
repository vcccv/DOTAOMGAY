
scope Puck

    globals
        constant integer HERO_INDEX_PUCK = 44
    endglobals
    //***************************************************************************
    //*
    //*  幻象法球
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_ILLUSORY_ORB = GetHeroSKillIndexBySlot(HERO_INDEX_PUCK, 1)
    endglobals
    function T5R takes nothing returns nothing
        if IsUnitInGroup(GetEnumUnit(), DK) == false then
            call GroupAddUnit(DK, GetEnumUnit())
            call UnitDamageTargetEx(TempUnit, GetEnumUnit(), 1, TempReal1)
        endif
    endfunction
    function T6R takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local group g =(LoadGroupHandle(HY, h, 22))
        local unit dummyCaster =(LoadUnitHandle(HY, h, 19))
        local integer level =(LoadInteger(HY, h, 5))
        local real a =(LoadReal(HY, h, 13))
        local unit whichUnit =(LoadUnitHandle(HY, h, 14))
        local group T7R
        local real x
        local real y
        local real maxDist = LoadReal(HY, h, 30)
        local real dist    = LoadReal(HY, h, 31)
        if GetTriggerEventId() == EVENT_WIDGET_DEATH then
            if GetUnitTypeId(whichUnit)=='e00E' then
                set whichUnit = PlayerHeroes[GetPlayerId(GetOwningPlayer(whichUnit))]
            endif
            set TempUnit = CreateUnit(GetOwningPlayer(dummyCaster),'h06O', GetUnitX(whichUnit), GetUnitY(whichUnit), 0)
            call SetUnitScale(TempUnit, 2.5, 2.5, 2.5)
            call KillUnit(TempUnit)
            call SetUnitPosition(whichUnit, GetUnitX(dummyCaster), GetUnitY(dummyCaster))
            call ShowUnit(whichUnit, false)
            call ShowUnit(whichUnit, true)
            call SelectUnitAddForPlayer(whichUnit, GetOwningPlayer(whichUnit))
            set H5V[GetPlayerId(GetOwningPlayer(dummyCaster))] = null
            call DeallocateGroup(g)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        elseif dist >= maxDist then
            set H5V[GetPlayerId(GetOwningPlayer(dummyCaster))] = null
            call DeallocateGroup(g)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            call SetUnitScale(dummyCaster, 2.5, 2.5, 2.5)
            call KillUnit(dummyCaster)
        else
            set x   = GetUnitX(dummyCaster)
            set y   = GetUnitY(dummyCaster)
            set T7R = AllocationGroup(199)
            set DK  = g
            set TempUnit = dummyCaster
            set TempReal1 = level * 70
            call GroupEnumUnitsInRange(T7R, x, y, 250, Condition(function DUX))
            call ForGroup(T7R, function T5R)
            call DeallocateGroup(T7R)
            call SaveReal(HY, h, 31, dist + 16.25)
            call SetUnitX(dummyCaster, CoordinateX50(x + 16.25 * Cos(a * bj_DEGTORAD)))
            call SetUnitY(dummyCaster, CoordinateY50(y + 16.25 * Sin(a * bj_DEGTORAD)))
        endif
        set t = null
        set g = null
        set T7R = null
        set dummyCaster = null
        set whichUnit = null
        return false
    endfunction
    function IllusoryOrbOnSpellEffect takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local group g = AllocationGroup(200)
        local unit trigUnit = GetTriggerUnit()
        local real x1 = GetUnitX(trigUnit)
        local real y1 = GetUnitY(trigUnit)
        local real x2 = GetSpellTargetX()
        local real y2 = GetSpellTargetY()
        local real a = AngleBetweenXY(x1, y1, x2, y2)
        local integer level = GetUnitAbilityLevel(trigUnit,'A0S9')
        local unit dummyCaster = CreateUnit(GetOwningPlayer(trigUnit),'h06O', x1, y1, a)
        local real maxDist     = 1800. + GetUnitCastRangeBonus(trigUnit)
        call A5X(KC, x1, y1)
        call UnitAddPermanentAbility(GetTriggerUnit(),'A0SA')
        set H5V[GetPlayerId(GetOwningPlayer(trigUnit))] = dummyCaster
        call SetUnitScale(dummyCaster, 3.5, 3.5, 3.5)
        call SaveUnitHandle(HY, h, 19,(dummyCaster))
        call SaveInteger(HY, h, 5,(level))
        call SaveGroupHandle(HY, h, 22,(g))
        call SaveReal(HY, h, 13,((a)* 1.))
        call SaveUnitHandle(HY, h, 14,(trigUnit))
        call SaveReal(HY, h, 30, maxDist)
        call SaveReal(HY, h, 31, 0.)
        call TriggerRegisterTimerEvent(t, .025, true)
        call TriggerRegisterDeathEvent(t, dummyCaster)
        call TriggerAddCondition(t, Condition(function T6R))
        set t = null
        set dummyCaster = null
        set g = null
        set trigUnit = null
    endfunction

    //***************************************************************************
    //*
    //*  相位转移
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_PHASE_SHIFT = GetHeroSKillIndexBySlot(HERO_INDEX_PUCK, 3)
    endglobals
    function T_R takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit trigUnit =(LoadUnitHandle(HY, h, 14))
        local integer level
        local integer S4R
        local integer d
        if (GetTriggerEventId() == EVENT_UNIT_ISSUED_ORDER and GetIssuedOrderId()!= 852514) or GetTriggerEventId() == EVENT_UNIT_ISSUED_POINT_ORDER or GetTriggerEventId() == EVENT_UNIT_ISSUED_TARGET_ORDER or GetTriggerEventId() == EVENT_WIDGET_DEATH then
            call UnitDecInvulnerableCount(trigUnit)
            call UnitRemoveAbility(trigUnit,'A04R')
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        else
            set level =(LoadInteger(HY, h, 5))
            set d = 3 * level
            if level == 4 then
                set d = d + 1
            endif
            set S4R =(LoadInteger(HY, h, 28))+ 1
            call SaveInteger(HY, h, 28,(S4R))
            // 如果受到强制位移>125则会中断相位转移
            if S4R > d or GetDistanceBetween(GetUnitX(trigUnit), GetUnitY(trigUnit),(LoadReal(HY, h, 6)),(LoadReal(HY, h, 7)))> 125 then
                call UnitDecInvulnerableCount(trigUnit)
                call UnitRemoveAbility(trigUnit, 'A04R')
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
            endif
        endif
        set t = null
        set trigUnit = null
        return false
    endfunction
    function T0R takes nothing returns nothing
        local timer t = GetExpiredTimer()
        call UnitAddAbility(LoadUnitHandle(ObjectHashTable, GetHandleId(t), 0),'A04R')
        call DestroyTimerAndFlushHT_P(t)
        set t = null
    endfunction
    function PhaseShiftOnSpellEffect takes nothing returns nothing
        local timer time = CreateTimer()
        local unit trigUnit = GetTriggerUnit()
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        call SaveUnitHandle(ObjectHashTable, GetHandleId(time), 0, trigUnit)
        call TimerStart(time, 0, false, function T0R)

        call UnitIncInvulnerableCount(trigUnit)
        call SaveUnitHandle(HY, h, 14,(trigUnit))
        call SaveInteger(HY, h, 5,(GetUnitAbilityLevel(trigUnit,'A0SB')))
        call SaveInteger(HY, h, 28, 0)
        call SaveReal(HY, h, 6,((GetUnitX(trigUnit))* 1.))
        call SaveReal(HY, h, 7,((GetUnitY(trigUnit))* 1.))
        call TriggerRegisterTimerEvent(t, .25, true)
        call TriggerRegisterUnitEvent(t, trigUnit, EVENT_UNIT_ISSUED_ORDER)
        call TriggerRegisterUnitEvent(t, trigUnit, EVENT_UNIT_ISSUED_POINT_ORDER)
        call TriggerRegisterUnitEvent(t, trigUnit, EVENT_UNIT_ISSUED_TARGET_ORDER)
        call TriggerRegisterDeathEvent(t, trigUnit)
        call TriggerAddCondition(t, Condition(function T_R))
        set t = null
        set trigUnit = null
        set time = null
    endfunction
    function T2R takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit trigUnit =(LoadUnitHandle(HY, h, 14))
        call IssueImmediateOrderById(trigUnit, 852516)
        call FlushChildHashtable(HY, h)
        call DestroyTrigger(t)
        set t = null
        set trigUnit = null
        return false
    endfunction
    function T3R takes nothing returns nothing
        local unit trigUnit = GetTriggerUnit()
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        call SaveUnitHandle(HY, h, 14,(trigUnit))
        call TriggerRegisterTimerEvent(t, 0, false)
        call TriggerAddCondition(t, Condition(function T2R))
        set t = null
        set trigUnit = null
    endfunction
    function T4R takes nothing returns boolean
        if GetIssuedOrderId()== 852514 and not IsUnitIllusion(GetTriggerUnit()) then
            call PhaseShiftOnSpellEffect()
        elseif GetIssuedOrderId()== 852515 then
            call T3R()
        endif
        return false
    endfunction
    function PhaseShiftOnInit takes nothing returns nothing
        local trigger t = CreateTrigger()
        call TriggerRegisterUserUnitEvent(t, EVENT_PLAYER_UNIT_ISSUED_ORDER)
        call TriggerAddCondition(t, Condition(function T4R))
        set t = null
    endfunction

endscope
