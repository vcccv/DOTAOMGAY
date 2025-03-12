scope Venomancer

    globals
        constant integer HERO_INDEX_VENOMANCER = 105
    endglobals
    //***************************************************************************
    //*
    //*  瘴气
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_VENOMOUS_GALE = GetHeroSKillIndexBySlot(HERO_INDEX_VENOMANCER, 1)
    endglobals

    function ISA takes nothing returns nothing
        if IsUnitInGroup(GetEnumUnit(), DK) == false then
            set MWV = CreateUnit(GetOwningPlayer(TempUnit),'e00E', GetUnitX(GetEnumUnit()), GetUnitY(GetEnumUnit()), 0)
            call UnitAddPermanentAbility(MWV,'A17N')
            call SetUnitAbilityLevel(MWV,'A17N', MYV)
            if IssueTargetOrderById(MWV, 852527, GetEnumUnit()) == false then
                call UnitShareVision(GetEnumUnit(), GetOwningPlayer(TempUnit), true)
                call IssueTargetOrderById(MWV, 852527, GetEnumUnit())
                call UnitShareVision(GetEnumUnit(), GetOwningPlayer(TempUnit), false)
            endif
            call GroupAddUnit(DK, GetEnumUnit())
            set MWV = null
        endif
    endfunction
    function ITA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local group g =(LoadGroupHandle(HY, h, 22))
        local unit dummyCaster =(LoadUnitHandle(HY, h, 19))
        local integer level =(LoadInteger(HY, h, 5))
        local real a =(LoadReal(HY, h, 13))
        local group T7R
        local real x
        local real y
        local real IUA
        local real IWA
        local real J0R = 30
        set MYV = level
        if GetTriggerEvalCount(t)> LoadInteger(HY, h, 101) then
            call DeallocateGroup(g)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            call ShowUnit(dummyCaster, false)
            call KillUnit(dummyCaster)
        else
            set x = GetUnitX(dummyCaster)
            set y = GetUnitY(dummyCaster)
            set T7R = AllocationGroup(405)
            set DK = g
            set TempUnit = dummyCaster
            set TempReal1 = level * 70
            call GroupEnumUnitsInRange(T7R, x, y, 150, Condition(function DUX))
            call ForGroup(T7R, function ISA)
            call DeallocateGroup(T7R)
            set IUA = CoordinateX50(x + J0R * Cos(a * bj_DEGTORAD))
            set IWA = CoordinateY50(y + J0R * Sin(a * bj_DEGTORAD))
            call SetUnitX(dummyCaster, IUA)
            call SetUnitY(dummyCaster, IWA)
        endif
        set t = null
        set g = null
        set T7R = null
        set dummyCaster = null
        return false
    endfunction
    function VenomousGaleOnSpellEffect takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local group g = AllocationGroup(406)
        local unit trigUnit = GetTriggerUnit()
        local real x1 = GetUnitX(trigUnit)
        local real y1 = GetUnitY(trigUnit)
        local real x2 = GetSpellTargetX()
        local real y2 = GetSpellTargetY()
        local real a = AngleBetweenXY(x1, y1, x2, y2)
        local integer level = GetUnitAbilityLevel(trigUnit,'A173')
        local unit dummyCaster = CreateUnit(GetOwningPlayer(trigUnit),'h07K', x1, y1, a)
        local real range = 840. + GetUnitCastRangeBonus(trigUnit)
        call PlaySoundAtPosition(ShadowStrikeBirthSound, x1, y1)
        call SaveUnitHandle(HY, h, 19,(dummyCaster))
        call SaveInteger(HY, h, 5,(level))
        call SaveInteger(HY, h, 101, R2I(range / 30.))
        call SaveGroupHandle(HY, h, 22,(g))
        call SaveReal(HY, h, 13,((a)* 1.))
        call SaveUnitHandle(HY, h, 14,(trigUnit))
        call TriggerRegisterTimerEvent(t, .025, true)
        call TriggerAddCondition(t, Condition(function ITA))
        set t = null
        set dummyCaster = null
        set g = null
        set trigUnit = null
    endfunction

endscope
