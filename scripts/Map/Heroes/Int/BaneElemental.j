
scope BaneElemental

    //***************************************************************************
    //*
    //*  噩梦
    //*
    //***************************************************************************
    function FMI takes nothing returns boolean
        local trigger FPI = GetTriggeringTrigger()
        local integer h = GetHandleId(FPI)
        local integer level =(LoadInteger(HY,(h), 30))
        local unit R3O = LoadUnitHandle(HY, h, 30)
        local unit R4O =(LoadUnitHandle(HY,(h), 2))
        local player FQI =(LoadPlayerHandle(HY,(h), 54))
        local integer FSI =(LoadInteger(HY,(h), 5))
        local unit FTI
        local boolean b = GetTriggerEventId() == EVENT_GAME_TIMER_EXPIRED
        if GetUnitAbilityLevel(R3O,'B02F') == 0 then
            call SetPlayerAbilityAvailable(GetOwningPlayer(R3O),'A04Y', true)
            call SetPlayerAbilityAvailable(GetOwningPlayer(R3O),'A2O9', false)
            call UnitRemoveAbility(R3O,'A37S')
            call UnitRemoveAbility(R3O,'A3C9')
            call UnitAddAbilityToTimed(R3O,'A3CA', 1, 1,'A3CA')
            if HaveSavedHandle(HY, GetHandleId(R3O),'VisD') then
                call UnitRemoveAbility(LoadUnitHandle(HY, GetHandleId(R3O),'VisD'),'A37S')
                call UnitRemoveAbility(LoadUnitHandle(HY, GetHandleId(R3O),'VisD'),'A3C9')
                call UnitAddAbilityToTimed(LoadUnitHandle(HY, GetHandleId(R3O),'VisD'),'A3CA', 1, 1,'A3CA')
            endif
            call FlushChildHashtable(HY,(h))
            call DestroyTrigger(FPI)
        elseif b == false and GetTriggerUnit() == R3O then
            call SetPlayerAbilityAvailable(GetOwningPlayer(R3O),'A04Y', true)
            call SetPlayerAbilityAvailable(GetOwningPlayer(R3O),'A2O9', false)
            call UnitRemoveAbility(R3O,'B02F')
            set FTI = CreateUnit(FQI,'e00E', GetUnitX(R3O), GetUnitY(R3O), 0)
            call UnitAddPermanentAbility(FTI,'A04Y')
            call UnitRemoveAbility(R3O,'A37S')
            call UnitRemoveAbility(R3O,'A3C9')
            call UnitAddAbilityToTimed(R3O,'A3CA', 1, 1,'A3CA')
            if HaveSavedHandle(HY, GetHandleId(R3O),'VisD') then
                call UnitRemoveAbility(LoadUnitHandle(HY, GetHandleId(R3O),'VisD'),'A37S')
                call UnitRemoveAbility(LoadUnitHandle(HY, GetHandleId(R3O),'VisD'),'A3C9')
                call UnitAddAbilityToTimed(LoadUnitHandle(HY, GetHandleId(R3O),'VisD'),'A3CA', 1, 1,'A3CA')
            endif
            call SetUnitAbilityLevel(FTI,'A04Y', FSI)
            call IssueTargetOrderById(FTI, 852227, GetAttacker())
            call FlushChildHashtable(HY,(h))
            call DestroyTrigger(FPI)
        elseif b then
            call SaveInteger(HY, h, 0, LoadInteger(HY, h, 0)+ 1)
            if LoadInteger(HY, h, 0) == 9 then
                call UnitRemoveAbility(R3O,'A3C9')
                if HaveSavedHandle(HY, GetHandleId(R3O),'VisD') then
                    call UnitRemoveAbility(LoadUnitHandle(HY, GetHandleId(R3O),'VisD'),'A3C9')
                endif
            endif
            if ModuloInteger(LoadInteger(HY, h, 0), 10) == 0 then
                if GetUnitState(R3O, UNIT_STATE_LIFE)> 21 then
                    call SetUnitState(R3O, UNIT_STATE_LIFE, GetUnitState(R3O, UNIT_STATE_LIFE)-20)
                else
                    call SetPlayerAbilityAvailable(GetOwningPlayer(R3O),'A04Y', true)
                    call SetPlayerAbilityAvailable(GetOwningPlayer(R3O),'A2O9', false)
                    call UnitRemoveAbility(R3O,'B02F')
                    call UnitRemoveAbility(R3O,'A37S')
                    call UnitRemoveAbility(R3O,'A3C9')
                    if HaveSavedHandle(HY, GetHandleId(R3O),'VisD') then
                        call UnitRemoveAbility(LoadUnitHandle(HY, GetHandleId(R3O),'VisD'),'A37S')
                        call UnitRemoveAbility(LoadUnitHandle(HY, GetHandleId(R3O),'VisD'),'A3C9')
                        call UnitAddAbilityToTimed(R3O,'A3CA', 1, 1,'A3CA')
                    endif
                    call UnitAddAbilityToTimed(R3O,'A3CA', 1, 1,'A3CA')
                    call UnitDamageTargetEx(R4O, R3O, 1, 50)
                    call FlushChildHashtable(HY,(h))
                    call DestroyTrigger(FPI)
                endif
            endif
        endif
        set FPI = null
        set FQI = null
        set FTI = null
        set R3O = null
        set R4O = null
        return false
    endfunction
    function FUI takes unit R3O, unit R4O returns nothing
        local trigger FPI = CreateTrigger()
        local integer Y6R = GetHandleId(FPI)
        set Y6R = GetHandleId(FPI)
        call SaveUnitHandle(HY,(Y6R), 30,((R4O)))
        call SaveUnitHandle(HY,(Y6R), 2,(R3O))
        call SavePlayerHandle(HY,(Y6R), 54,(GetOwningPlayer(R3O)))
        call SaveInteger(HY,(Y6R), 5,(GetUnitAbilityLevel(R3O,'A04Y')))
        call TriggerRegisterPlayerUnitEventBJ(FPI, EVENT_PLAYER_UNIT_ATTACKED)
        call TriggerRegisterTimerEvent(FPI, .1, true)
        call TriggerAddCondition(FPI, Condition(function FMI))
        if GetUnitAbilityLevel(R4O,'A04Y')> 0 then
            call SetPlayerAbilityAvailable(GetOwningPlayer(R4O),'A04Y', false)
            call UnitAddPermanentAbility(R4O,'A2O9')
            call SetPlayerAbilityAvailable(GetOwningPlayer(R4O),'A2O9', true)
        endif
        call UnitAddAbility(R4O,'A37S')
        call UnitAddAbility(R4O,'A3C9')
        if HaveSavedHandle(HY, GetHandleId(R4O),'VisD') then
            call UnitAddAbility(LoadUnitHandle(HY, GetHandleId(R4O),'VisD'),'A37S')
            call UnitAddAbility(LoadUnitHandle(HY, GetHandleId(R4O),'VisD'),'A3C9')
        endif
        set DMV = true
        call UnitDamageTargetEx(R3O, R4O, 2, 0)
        set DMV = false
        set FPI = null
    endfunction
    function FWI takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer h = GetHandleId(t)
        call FUI(LoadUnitHandle(HY, h, 0), LoadUnitHandle(HY, h, 1))
        call FlushChildHashtable(HY, h)
        call DestroyTimer(t)
        set t = null
    endfunction
    function NightmareOnSpellEffect takes nothing returns nothing
        local timer t
        local integer h
        if IsUnitCourier(GetSpellTargetUnit()) == false and not UnitHasSpellShield(GetSpellTargetUnit()) then
            set t = CreateTimer()
            set h = GetHandleId(t)
            call TimerStart(t, 0, false, function FWI)
            call SaveUnitHandle(HY, h, 0, GetTriggerUnit())
            call SaveUnitHandle(HY, h, 1, GetSpellTargetUnit())
            set t = null
        endif
    endfunction

endscope
