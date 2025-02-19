
scope Tuskarr

    //***************************************************************************
    //*
    //*  海象飞踢
    //*
    //***************************************************************************
    globals
        constant integer WALRUS_KICK_ABILITY_ID = 'A3DF'
    endglobals

    function WalrusPunchOnGetScepterUpgrade takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()

        if not UnitAddPermanentAbility(whichUnit, WALRUS_KICK_ABILITY_ID) then
            call UnitDisableAbility(whichUnit, WALRUS_KICK_ABILITY_ID, false, true)
        endif

        set whichUnit = null
    endfunction
    function WalrusPunchOnLostScepterUpgrade takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()

        call UnitDisableAbility(whichUnit, WALRUS_KICK_ABILITY_ID, true, true)

        set whichUnit = null
    endfunction
    
    function HWA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY,(h), 2))
        local unit targetUnit =(LoadUnitHandle(HY,(h), 17))
        local real HYA =(LoadReal(HY,(h), 6))
        local real HZA =(LoadReal(HY,(h), 7))
        local real a = LoadReal(HY, h, 1)
        local real H_A =(LoadReal(HY,(h), 23))
        local real H0A =(LoadReal(HY,(h), 24))
        local real nX
        local real nY
        local boolean X_A = false
        local real LMR = LoadReal(HY, h, 0)
        set nX = H_A + LMR * Cos(a)
        set nY = H0A + LMR * Sin(a)
        if GetDistanceBetween(nX, nY, HYA, HZA)<(5 + LMR) then
            set nX = HYA
            set nY = HZA
            set X_A = true
        endif
        set nX = CoordinateX50(nX)
        set nY = CoordinateY50(nY)
        if GetTriggerEventId() == EVENT_WIDGET_DEATH or GetUnitAbilityLevel(targetUnit,'B08V')> 0 or GetTriggerEvalCount(t)> 200 then
            set X_A = true
        else
            call SetUnitPosition(targetUnit, nX, nY)
            call SetUnitX(targetUnit, nX)
            call SetUnitY(targetUnit, nY)
            call KillTreeByCircle(nX, nY, 120)
            call SaveReal(HY,(h), 23,((nX)* 1.))
            call SaveReal(HY,(h), 24,((nY)* 1.))
        endif
        if X_A then
            call SetUnitPathing(targetUnit, true)
            call FlushChildHashtable(HY,(h))
            call DestroyTrigger(t)
        endif
        set targetUnit = null
        set t = null
        set whichUnit = null
        return false
    endfunction
    function H1A takes nothing returns nothing
        local unit targetUnit = GetSpellTargetUnit()
        local unit whichUnit = GetTriggerUnit()
        local integer level = 1
        local trigger t
        local integer h
        local real N8X
        local real x = GetUnitX(whichUnit)
        local real y = GetUnitY(whichUnit)
        local integer i =-1
        local boolean H2A = false
        local real EOX = 900
        set N8X = AngleBetweenUnit(whichUnit, targetUnit)* bj_DEGTORAD
        set t = CreateTrigger()
        set h = GetHandleId(t)
        loop
        exitwhen H2A or i == 23
            set i = i + 1
            set x = CoordinateX50(GetUnitX(targetUnit)+(EOX -i * 25)* Cos(N8X))
            set y = CoordinateY50(GetUnitY(targetUnit)+(EOX -i * 25)* Sin(N8X))
            if (IsPointInRegion(TerrainCliffRegion,((x)* 1.),((y)* 1.))) == false then
                set H2A = true
            endif
        endloop
        call SetUnitPathing(targetUnit, false)
        call TriggerRegisterTimerEvent(t, .03, true)
        call TriggerRegisterDeathEvent(t, targetUnit)
        call TriggerAddCondition(t, Condition(function HWA))
        call SaveUnitHandle(HY,(h), 2,(whichUnit))
        call SaveUnitHandle(HY,(h), 17,(targetUnit))
        call SaveReal(HY,(h), 6,((x)* 1.))
        call SaveReal(HY,(h), 7,((y)* 1.))
        call SaveReal(HY,(h), 23,((GetUnitX(targetUnit))* 1.))
        call SaveReal(HY,(h), 24,((GetUnitY(targetUnit))* 1.))
        call SaveInteger(HY,(h), 34, 0)
        call SaveReal(HY, h, 0, 900 * .03)
        call SaveReal(HY, h, 1, N8X)
        call UnitAddAbilityToTimed(targetUnit,'A3DG', 1, 5,'B3DG')
        call UnitDamageTargetEx(whichUnit, targetUnit, 1, 200)
        set targetUnit = null
        set whichUnit = null
        set t = null
    endfunction

    function WalrusKickOnSpellEffect takes nothing returns nothing
        if not UnitHasSpellShield(GetSpellTargetUnit()) then
            call H1A()
        endif
    endfunction

endscope
