
scope Slark

    //***************************************************************************
    //*
    //*  暗影之舞
    //*
    //***************************************************************************
    function UpdateShadowDance takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit u = LoadUnitHandle(HY, h, 2)
        local unit d = LoadUnitHandle(HY, h, 19)
        if GetUnitAbilityLevel(u,'A1HX') == 0 then
            call KillUnit(d)
            call UnitSubTruesightImmunityCount(u)
            call FlushChildHashtable(HY, h)
            call CleanCurrentTrigger(t)
        else
            call SetUnitX(d, GetUnitX(u))
            call SetUnitY(d, GetUnitY(u))
        endif
        set t = null
        set u = null
        set d = null
        return false
    endfunction
    function ShadowDanceOnSpellEffect takes nothing returns nothing
        local unit    u  = GetTriggerUnit()
        local unit    d  = CreateUnit(GetOwningPlayer(u), 'h0B1', GetUnitX(u), GetUnitY(u), 0)
        local integer lv = GetUnitAbilityLevel(u, 'A1IN')
        local trigger t  = CreateTrigger()
        local integer h  = GetHandleId(t)
        local integer i  = 3
        call UnitDodgeMissile(u)
        if lv > 1 then
            set i = 4
        endif
        call CXX(u,'A1HW', 1, i)
        call CXX(u,'A1HX', 1, i)
        call UnitAddTruesightImmunityCount(u)
        call TriggerRegisterTimerEvent(t, .03, true)
        call TriggerAddCondition(t, Condition(function UpdateShadowDance))
        call SaveUnitHandle(HY, h, 19,(d))
        call SaveUnitHandle(HY, h, 2,(u))
        set u = null
        set d = null
        set t = null
    endfunction

endscope
