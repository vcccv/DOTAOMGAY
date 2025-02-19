
scope ForceStaff

    //***************************************************************************
    //*
    //*  原力
    //*
    //***************************************************************************
    function C1O takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit stg_u =(LoadUnitHandle(HY, h, 17))
        local real a =(LoadReal(HY, h, 137))
        local real d =(LoadReal(HY, h, 138))
        local real x = CoordinateX50(GetUnitX(stg_u) + d / 10 * Cos(a * bj_DEGTORAD))
        local real y = CoordinateY50(GetUnitY(stg_u) + d / 10 * Sin(a * bj_DEGTORAD))
        if GetTriggerEvalCount(t) == 11 or GetTriggerEventId() == EVENT_WIDGET_DEATH then
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        else
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\FlakCannons\\FlakTarget.mdl", x, y))
            if ((LoadInteger(HY,(GetHandleId((stg_u))),(4306)))!= 1) and GetUnitAbilityLevel(stg_u,'B08V') == 0 then
                call KillTreeByCircle(x, y, 150)
                if IsUnitType(stg_u, UNIT_TYPE_HERO) then
                    call SaveBoolean(OtherHashTable, GetHandleId(stg_u), 99, true)
                endif
                call SetUnitX(stg_u, x)
                call SetUnitY(stg_u, y)
            endif
        endif
        set stg_u = null
        set t = null
        return false
    endfunction
    function C2O takes unit stg_u returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local real x
        local real y
        local real d
        local real a
        local integer i =-1
        local boolean C3O = false
        call EPX(stg_u, 4414, 3)
        set a = GetUnitFacing(stg_u)
        loop
        exitwhen C3O or i == 23
            set x = CoordinateX50(GetUnitX(stg_u) +(600 -i * 25)* Cos(a * bj_DEGTORAD))
            set y = CoordinateY50(GetUnitY(stg_u) +(600 -i * 25)* Sin(a * bj_DEGTORAD))
            if (IsPointInRegion(TerrainCliffRegion,((x)* 1.),((y)* 1.))) == false then
                set C3O = true
            endif
            set i = i + 1
        endloop
        set d = GetDistanceBetween(x, y, GetUnitX(stg_u), GetUnitY(stg_u))
        call TriggerRegisterTimerEvent(t, .04, true)
        call TriggerRegisterDeathEvent(t, stg_u)
        call TriggerAddCondition(t, Condition(function C1O))
        call SaveUnitHandle(HY, h, 17,(stg_u))
        call SaveReal(HY, h, 137,((a)* 1.))
        call SaveReal(HY, h, 138,((d)* 1.))
        set t = null
    endfunction
    function C4O takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO))!= null
    endfunction
    function C5O takes unit u returns nothing
        local group g = AllocationGroup(35)
        set TempUnit = GetTriggerUnit()
        call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u) + 70, 76, Condition(function C4O))
        if FirstOfGroup(g)!= null then
            call C2O(FirstOfGroup(g))
        endif
        call DeallocateGroup(g)
    endfunction
    
    function ItemAbility_ForceOnSpellEffect takes nothing returns nothing
        local unit u = GetSpellTargetUnit()
        local unit whichUnit = GetTriggerUnit()
        local boolean C6O
        if GetSpellTargetItem()!= null then
            set u = whichUnit
        endif
        set C6O = IsUnitHomingMissileById(GetUnitTypeId(u))
        if GetUnitTypeId(u)!='n00L' and GetUnitAbilityLevel(u,'B0FG') == 0 and LoadBoolean(HY, GetHandleId(u), 4306) == false then
            if C6O then
                call C2O(u)
            elseif IsUnitWard(u) and GetUnitMoveSpeed(u) == 0 then
                call C5O(u)
            elseif IsUnitEnemy(u, GetOwningPlayer(whichUnit)) then
                if UnitHasSpellShield(u) == false then
                    call C2O(u)
                endif
            elseif IsUnitAlly(u, GetOwningPlayer(whichUnit)) and(LoadBoolean(HY, GetHandleId(GetOwningPlayer(u)), 139) == false or GetOwningPlayer(u) == GetOwningPlayer(whichUnit)) then
                call C2O(u)
            endif
        endif
        set u = null
        set whichUnit = null
    endfunction
endscope
