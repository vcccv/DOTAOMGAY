
scope Puck

    //***************************************************************************
    //*
    //*  相位转移
    //*
    //***************************************************************************
    function T_R takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit trigUnit =(LoadUnitHandle(HY, h, 14))
        local integer level
        local integer S4R
        local integer d
        if (GetTriggerEventId() == EVENT_UNIT_ISSUED_ORDER and GetIssuedOrderId()!= 852514) or GetTriggerEventId() == EVENT_UNIT_ISSUED_POINT_ORDER or GetTriggerEventId() == EVENT_UNIT_ISSUED_TARGET_ORDER or GetTriggerEventId() == EVENT_WIDGET_DEATH then
            call UnitSubInvulnerableCount(trigUnit)
            call UnitRemoveAbility(trigUnit,'A04R')
            call FlushChildHashtable(HY, h)
            call CleanCurrentTrigger(t)
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
                call UnitSubInvulnerableCount(trigUnit)
                call UnitRemoveAbility(trigUnit, 'A04R')
                call FlushChildHashtable(HY, h)
                call CleanCurrentTrigger(t)
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

        call UnitAddInvulnerableCount(trigUnit)
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
        call CleanCurrentTrigger(t)
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
