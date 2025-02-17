
scope TreantProtector

    //***************************************************************************
    //*
    //*  丛林之眼
    //*
    //***************************************************************************
    #define EYES_IN_THE_FOREST_ABILITY_ID 'A01V'
    
    function OvevgrowthOnGetScepterUpgrade takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()

        if not UnitAddPermanentAbility(whichUnit, EYES_IN_THE_FOREST_ABILITY_ID) then
            call UnitDisableAbility(whichUnit, EYES_IN_THE_FOREST_ABILITY_ID, false, true)
        endif

        set whichUnit = null
    endfunction
    function OvevgrowthOnLostScepterUpgrade takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()

        call UnitDisableAbility(whichUnit, EYES_IN_THE_FOREST_ABILITY_ID, true, true)

        set whichUnit = null
    endfunction

    function X4I takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local integer hu
        local integer i
        local unit u = LoadUnitHandle(HY, h, 2)
        if GetTriggerEventId()!= EVENT_GAME_TIMER_EXPIRED then
            set hu = LoadInteger(HY, h, 0)
            set i = LoadInteger(HY, h, 1) -1
            call DestroyUbersplat(LoadUbersplatHandle(HY, h, 3))
            call KillUnit(u)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            loop
                set i = i + 1
            exitwhen HaveSavedHandle(HY, hu,'EinF'+ i + 1) == false
                call SaveDestructableHandle(HY, hu,'EinF'+ i, LoadDestructableHandle(HY, hu,'EinF'+ i + 1))
            endloop
            call SaveInteger(HY, hu,'EinF', LoadInteger(HY, hu,'EinF') -1)
        else
            call SetUbersplatRenderAlways(LoadUbersplatHandle(HY, h, 3), IsPlayerAlly(LocalPlayer, GetOwningPlayer(u)) or IsObserverPlayer(LocalPlayer) or(IsUnitVisibleToPlayer(u, LocalPlayer)))
        endif
        set t = null
        set u = null
        return false
    endfunction
    function EyesInTheForestOnSpellEffect takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local integer hu = GetHandleId(GetOwningPlayer(u))
        local destructable d = GetSpellTargetDestructable()
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local integer c = LoadInteger(HY, hu,'EinF')
        local unit dummyUnit = CreateUnit(GetOwningPlayer(u),'ewsp', GetDestructableX(d), GetDestructableY(d), 0)
        local ubersplat ub = CreateUbersplat(GetUnitX(dummyUnit), GetUnitY(dummyUnit), "EINF", 255, 255, 255, 40, false, false)
        local unit dummyCaster = CreateUnit(GetOwningPlayer(dummyUnit),'e00E', GetUnitX(dummyUnit), GetUnitY(dummyUnit), 0)
        call UnitAddPermanentAbility(dummyCaster,'A44T')
        call IssueTargetOrderById(dummyCaster, 852069, dummyUnit)
        set dummyCaster = null
        call SetUnitPathing(dummyUnit, false)
        call SetUnitX(dummyUnit, GetDestructableX(d))
        call SetUnitY(dummyUnit, GetDestructableY(d))
        call UnitRemoveType(dummyUnit, UNIT_TYPE_PEON)
        call PauseUnit(dummyUnit, true)
        call TriggerRegisterDeathEvent(t, d)
        call TriggerRegisterTimerEvent(t, .5, true)
        call TriggerAddCondition(t, Condition(function X4I))
        call SaveDestructableHandle(HY, GetHandleId(GetOwningPlayer(u)),'EinF'+ c + 1, d)
        call SaveInteger(HY, hu,'EinF', c + 1)
        call SaveInteger(HY, h, 0, hu)
        call SaveInteger(HY, h, 1, c + 1)
        call SaveUnitHandle(HY, h, 2, dummyUnit)
        call SaveUbersplatHandle(HY, h, 3, ub)
        set ub = null
        set dummyUnit = null
        set t = null
        set d = null
        set u = null
    endfunction

    //***************************************************************************
    //*
    //*  疯狂生长
    //*
    //***************************************************************************
    function XZI takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) == false and IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(GetTriggerUnit())) and UnitIsDead(GetFilterUnit()) == false)
    endfunction
    function X_I takes nothing returns nothing
        local unit R3O = GetTriggerUnit()
        local unit R4O = CreateUnit(GetOwningPlayer(R3O),'e022', GetUnitX(GetEnumUnit()), GetUnitY(GetEnumUnit()), 270)
        call UnitAddPermanentAbility(R4O,'A06T')
        call SetUnitAbilityLevel(R4O,'A06T', GetUnitAbilityLevel(R3O,'A07Z')+ GetUnitAbilityLevel(R3O,'A44S'))
        call UnitRemoveAbility(GetEnumUnit(),'B0ER')
        call IssueTargetOrderById(R4O, 852171, GetEnumUnit())
        set R3O = null
        set R4O = null
    endfunction
    function X0I takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit u
        local integer h = GetHandleId(t)
        local integer i = 1
        local integer X1I = LoadInteger(HY, h, 0)
        local integer C6R = LoadInteger(HY, h,-1)
        local unit whichUnit = LoadUnitHandle(HY, h, 0)
        loop
            if HaveSavedHandle(HY, h, i) then
                set u = LoadUnitHandle(HY, h, i)
                if UnitAlive(u) and GetUnitAbilityLevel(u,'B0ER')> 0 then
                    call UnitDamageTargetEx(whichUnit, u, 1, 175)
                else
                    call RemoveSavedBoolean(HY, LoadInteger(HY, h, i),'B0ER')
                    call RemoveSavedHandle(HY, h, i)
                endif
            endif
            set i = i + 1
        exitwhen i > C6R
        endloop
        if X1I > 10 then
            call PauseTimer(t)
            call FlushChildHashtable(HY, h)
            call DestroyTimer(t)
        elseif X1I == 0 then
            call TimerStart(t, 1, true, function X0I)
        endif
        set t = null
        set u = null
        set whichUnit = null
    endfunction
    function X2I takes unit whichUnit, group g returns nothing
        local timer t = CreateTimer()
        local unit u
        local integer h = GetHandleId(t)
        local integer hu
        local integer i = 1
        loop
            set u = FirstOfGroup(g)
        exitwhen u == null
            set hu = GetHandleId(u)
            if GetUnitAbilityLevel(u,'B0ER') == 0 and LoadBoolean(HY, hu,'B0ER') == false then
                call SaveUnitHandle(HY, h, i, u)
                call SaveInteger(HY, h, i, hu)
                call SaveBoolean(HY, hu,'B0ER', true)
                set i = i + 1
            endif
            call GroupRemoveUnit(g, u)
        endloop
        call TimerStart(t, 0, false, function X0I)
        call SaveUnitHandle(HY, h, 0, whichUnit)
        call SaveInteger(HY, h,-1, i)
        set t = null
        set u = null
    endfunction
    function OvevgrowthOnSpellEffect takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local group g = AllocationGroup(250)
        local boolean MDR = GetSpellAbilityId()!='A07Z'
        local integer hu = GetHandleId(GetOwningPlayer(u))
        local group gg
        local group g3
        local integer i
        local integer k
        local destructable d
        local boolean X3I = IsUnitHaveRearmAbility(u)
        call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 700, Condition(function XZI))
        if MDR then
            set gg = AllocationGroup(251)
            set g3 = AllocationGroup(252)
            set i = 0
            set k = LoadInteger(HY, hu,'EinF')
            loop
                set i = i + 1
            exitwhen i > k
                set d = LoadDestructableHandle(HY, hu,'EinF'+ i)
                if X3I == false or GetDistanceBetween(GetUnitX(u), GetUnitY(u), GetDestructableX(d), GetDestructableY(d))< 3000 then
                    call GroupEnumUnitsInRange(gg, GetDestructableX(d), GetDestructableY(d), 800, Condition(function XZI))
                    call GroupAddGroup(gg, g)
                    call GroupAddGroup(gg, g3)
                endif
            endloop
            call X2I(u, g3)
            call DeallocateGroup(g3)
            call DeallocateGroup(gg)
        endif
        call ForGroup(g, function X_I)
        call DeallocateGroup(g)
        set u = null
        set g = null
        set gg = null
        set g3 = null
        set d = null
    endfunction

endscope
