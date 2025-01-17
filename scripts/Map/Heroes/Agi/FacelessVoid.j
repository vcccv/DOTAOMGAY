
scope FacelessVoid

    //***************************************************************************
    //*
    //*  时间漫游
    //*
    //***************************************************************************
    function LCI takes nothing returns nothing
        if not IsUnitInGroup(GetEnumUnit(), L_V) then
            call GroupAddUnit(L_V, GetEnumUnit())
            call UnitAddAbilityToTimed(GetEnumUnit(), L0V, 1, 3.,'B05Q')
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\SpellShieldAmulet\\SpellShieldCaster.mdl", GetEnumUnit(), "overhead"))
        endif
    endfunction
    function LDI takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit trigUnit = LoadUnitHandle(HY, h, 14)
        local real x2 = LoadReal(HY, h, 66)
        local real y2 = LoadReal(HY, h, 67)
        local real a = LoadReal(HY, h, 137)
        local integer count = GetTriggerEvalCount(t)
        local real x = GetUnitX(trigUnit)
        local real y = GetUnitY(trigUnit)
        local real GXR = LoadReal(HY, h, 23)
        local real GOR = LoadReal(HY, h, 24)
        local unit dummyCaster = LoadUnitHandle(HY, h, 19)
        local group g = AllocationGroup(327)
        local group D7R = LoadGroupHandle(HY, h, 187)
        local integer level = LoadInteger(HY, h, 5)
        if GetDistanceBetween(x, y, x2, y2)<= 53 then
            set x = x2
            set y = y2
        else
            set x = GXR + 60 * Cos(a * bj_DEGTORAD)
            set y = GOR + 60 * Sin(a * bj_DEGTORAD)
        endif
        set x = CoordinateX50(x)
        set y = CoordinateY50(y)
        if level == 1 then
            set L0V ='A294'
        elseif level == 2 then
            set L0V ='A295'
        elseif level == 3 then
            set L0V ='A296'
        elseif level == 4 then
            set L0V ='A297'
        endif
        set U2 = trigUnit
        set L_V = D7R
        call GroupEnumUnitsInRange(g, x, y, 325, Condition(function DJX))
        call ForGroup(g, function LCI)
        call DeallocateGroup(g)
        call SaveReal(HY, h, 23, x * 1.)
        call SaveReal(HY, h, 24, y * 1.)
        call SetUnitPosition(trigUnit, x, y)
        if (x == x2 and y == y2) or count > LoadInteger(HY, h, 0) then
            if IsUnitType(dummyCaster, UNIT_TYPE_HERO) then
                call SaveBoolean(OtherHashTable, GetHandleId(dummyCaster), 99, true)
            endif
            call SetUnitX(dummyCaster, CoordinateX50(x))
            call SetUnitY(dummyCaster, CoordinateY50(y))
            call IssueImmediateOrderById(dummyCaster, 852096)
            call DeallocateGroup(D7R)
            call FlushChildHashtable(HY, h)
            call CleanCurrentTrigger(t)
            call SetUnitAnimation(trigUnit, "stand")
            call SetUnitPathing(trigUnit, true)
            call SetUnitInvulnerable(trigUnit, false)
            call ResetUnitVertexColor(trigUnit)
            call SaveInteger(HY, GetHandleId(trigUnit), 4261, 2)
        endif
        set t = null
        set trigUnit = null
        set dummyCaster = null
        set D7R = null
        set g = null
        return false
    endfunction
    function TimeWalkOnSpellEffect takes nothing returns nothing
        local unit trigUnit = GetTriggerUnit()
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local real x1 = GetUnitX(trigUnit)
        local real y1 = GetUnitY(trigUnit)
        local real x2
        local real y2
        local real a
        local unit dummyCaster = CreateUnit(GetOwningPlayer(trigUnit),'e00E', x1, y1, 0)
        local real distance    = 500 + 200 * GetUnitAbilityLevel(trigUnit,'A0LK') + GetUnitCastRangeBonus(trigUnit)
        if GetSpellTargetUnit() == null then
            set x2 = GetSpellTargetX()
            set y2 = GetSpellTargetY()
        else
            set x2 = GetUnitX(GetSpellTargetUnit())
            set y2 = GetUnitY(GetSpellTargetUnit())
        endif
        set a = AngleBetweenXY(x1, y1, x2, y2)
        call SetUnitAnimationByIndex(trigUnit, 0)
        call SetUnitPathing(trigUnit, false)
        call SetUnitInvulnerable(trigUnit, true)
        call SetUnitVertexColorEx(trigUnit, 0, 0, 0,-1)
        call SaveInteger(HY, GetHandleId(trigUnit), 4261, 1)
        call SaveReal(HY, h, 66, x2 * 1.)
        call SaveReal(HY, h, 67, y2 * 1.)
        call SaveReal(HY, h, 23, x1 * 1.)
        call SaveReal(HY, h, 24, y1 * 1.)
        call SaveReal(HY, h, 137, a * 1.)
        call SaveInteger(HY, h, 5, GetUnitAbilityLevel(trigUnit, GetSpellAbilityId()))
        call SaveUnitHandle(HY, h, 14, trigUnit)
        call SaveUnitHandle(HY, h, 19, dummyCaster)
        call SaveGroupHandle(HY, h, 187, AllocationGroup(328))
        call SaveInteger(HY, h, 0, R2I((distance)/ 60.))
        call UnitAddPermanentAbility(dummyCaster,'A0LA')
        call SetUnitAbilityLevel(dummyCaster,'A0LA', GetUnitAbilityLevel(trigUnit,'A0LK'))
        call TriggerRegisterTimerEvent(t, .02, true)
        call TriggerAddCondition(t, Condition(function LDI))
        set trigUnit = null
        set t = null
        set dummyCaster = null
    endfunction

endscope
