
scope Slardar

    //***************************************************************************
    //*
    //*  冲刺
    //*
    //***************************************************************************
    function SlardarSprintBuffOnAdd takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        call UnitIncPhasedMovementCount(whichUnit)
        set whichUnit = null
    endfunction
    function SlardarSprintBuffOnRemove takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        call UnitDecPhasedMovementCount(whichUnit)
        set whichUnit = null
    endfunction

    function SlardarSprintOnSpellEffect takes nothing returns nothing
        call RegisterAbilityAddMethod('B013', "SlardarSprintBuffOnAdd")
        call RegisterAbilityRemoveMethod('B013', "SlardarSprintBuffOnRemove")
    endfunction

    //***************************************************************************
    //*
    //*  鱼人碎击
    //*
    //***************************************************************************
    function SlithereenCrushOnSpellEffect takes nothing returns nothing
        local unit whichUnit = GetTriggerUnit()
        local real x = GetUnitX(whichUnit)
        local real y = GetUnitY(whichUnit)
        local unit dummyCaster = CreateUnit(GetOwningPlayer(whichUnit),'e00E', x, y, 0)
        local group g = AllocationGroup(387)
        local integer level = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local unit u
        call UnitAddPermanentAbility(dummyCaster,'A0M9')
        call SetUnitAbilityLevel(dummyCaster,'A0M9', level)
        call IssueImmediateOrderById(dummyCaster, 852096)
        set TempUnit = whichUnit
        call GroupEnumUnitsInRange(g, x, y, 350 + 25, Condition(function DHX))
        loop
            set u = FirstOfGroup(g)
        exitwhen u == null
            call UnitDamageTargetEx(dummyCaster, u, 2, 50 * level)
            call CommonUnitAddStun(u, .5 + level * 1. * .5, false)
            call GroupRemoveUnit(g, u)
        endloop
        call DeallocateGroup(g)
        set whichUnit = null
        set dummyCaster = null
        set g = null
    endfunction


endscope
