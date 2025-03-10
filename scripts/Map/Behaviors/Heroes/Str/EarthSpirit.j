
scope EarthSpirit

    globals
        constant integer HERO_INDEX_EARTH_SPIRIT = 111
    endglobals
    //***************************************************************************
    //*
    //*  巨石猛击
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_BOULDER_SMASH = GetHeroSKillIndexBySlot(HERO_INDEX_EARTH_SPIRIT, 1)
    endglobals

    function QER takes nothing returns nothing
        if IsUnitInGroup(GetEnumUnit(), ZH) == false then
            call GroupAddUnit(ZH, GetEnumUnit())
            call UnitDamageTargetEx(QH, GetEnumUnit(), 1, NJ)
            if VJ == 1 then
                call QVR(GetEnumUnit())
            endif
            if IsUnitType(GetEnumUnit(), UNIT_TYPE_HERO) and(LoadInteger(HY, GetHandleId(GetEnumUnit()), 809) == 1) then
                set UH = GetEnumUnit()
            endif
        endif
    endfunction
    function QXR takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local unit targetUnit =(LoadUnitHandle(HY, h, 17))
        local real dx =(LoadReal(HY, h, 6))
        local real dy =(LoadReal(HY, h, 7))
        local real QOR
        local real PRR =(LoadReal(HY, h, 23))
        local real PIR =(LoadReal(HY, h, 24))
        local real M8R
        local real M9R
        local boolean b = false
        local group g =(LoadGroupHandle(HY, h, 187))
        local group gg
        local unit QRR =(LoadUnitHandle(HY, h, 810))
        if QRR != null then
            set dx = GetUnitX(QRR)
            set dy = GetUnitY(QRR)
        endif
        set QOR = bj_DEGTORAD * AngleBetweenXY(GetUnitX(targetUnit), GetUnitY(targetUnit), dx, dy)
        set M8R = PRR + 1200* .03 * Cos(QOR)
        set M9R = PIR + 1200* .03 * Sin(QOR)
        if GetDistanceBetween(M8R, M9R, dx, dy)<(5 + 1200* .03) then
            set M8R = dx
            set M9R = dy
            set b = true
        endif
        set M8R = CoordinateX50(M8R)
        set M9R = CoordinateY50(M9R)
        set ZH = g
        set QH = whichUnit
        set XJ = GetUnitAbilityLevel(whichUnit,'A2QM')
        set NJ = 50 * XJ
        set UH = null
        if ((LoadInteger(HY,(GetHandleId(targetUnit)), 4306)) == 1) or GetTriggerEventId() == EVENT_WIDGET_DEATH or GetUnitAbilityLevel(targetUnit,'B08V')> 0 or((LoadInteger(HY,(GetHandleId(targetUnit)), 4336)) == 1) or(QRR == null and GetTriggerEvalCount(t)> 200) then
            set b = true
        else
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\FlakCannons\\FlakTarget.mdl", M8R, M9R))
            if GetUnitTypeId(targetUnit)=='o01X' or GetUnitTypeId(targetUnit)=='o020' then
                set VJ = 1
                call SetUnitPosition(targetUnit, M8R, M9R)
                call SetUnitX(targetUnit, CoordinateX50(M8R))
                call SetUnitY(targetUnit, CoordinateY50(M9R))
            else
                set VJ = 0
                call SetUnitX(targetUnit, CoordinateX50(M8R))
                call SetUnitY(targetUnit, CoordinateY50(M9R))
            endif
            call KillTreeByCircle(M8R, M9R, 150)
            call SaveReal(HY, h, 23,((M8R)* 1.))
            call SaveReal(HY, h, 24,((M9R)* 1.))
            set gg = AllocationGroup(181)
            set TempUnit = whichUnit
            call GroupEnumUnitsInRange(gg, M8R, M9R, 225, Condition(function DJX))
            call GroupRemoveUnit(gg, targetUnit)
            call ForGroup(gg, function QER)
            call DeallocateGroup(gg)
            if UH != null and VJ == 1 then
                set gg = AllocationGroup(182)
                set TH = null
                set OJ = 9999
                call GroupEnumUnitsInRange(gg, GetUnitX(UH), GetUnitY(UH), 625, Condition(function P8R))
                call DeallocateGroup(gg)
                if TH != null then
                    set QRR = TH
                    call SaveUnitHandle(HY, h, 810,(QRR))
                    set b = false
                endif
            endif
            set gg = null
        endif
        if b then
            if GetUnitTypeId(targetUnit)!='o01X' then
                call SetUnitPathing(targetUnit, true)
            endif
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            call DeallocateGroup(g)
            call SaveInteger(HY,(GetHandleId((targetUnit))),(4335), 2)
            if GetTriggerEventId() != EVENT_WIDGET_DEATH then
                if IsPlayerAlly(GetOwningPlayer(whichUnit), GetOwningPlayer(targetUnit)) == false then
                    call UnitDamageTargetEx(QH, targetUnit, 1, NJ)
                endif
            endif
        endif
        set targetUnit = null
        set t = null
        set g = null
        set whichUnit = null
        set QRR = null
        return false
    endfunction
    function QIR takes nothing returns nothing
        local unit targetUnit = GetSpellTargetUnit()
        local unit whichUnit = GetTriggerUnit()
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local real I3X
        local real dx
        local real dy
        local real x = GetUnitX(whichUnit)
        local real y = GetUnitY(whichUnit)
        local integer i =-1
        local boolean b = false
        local real range = 400 + 100 * GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local group g
        if targetUnit == null then
            set g = AllocationGroup(183)
            set TempUnit = whichUnit
            call GroupEnumUnitsInRange(g, x, y, 225, Condition(function PCR))
            set targetUnit = GetClosestUnitInGroup(g, x, y)
            call DeallocateGroup(g)
            set g = null
            set I3X = AngleBetweenXY(GetUnitX(targetUnit), GetUnitY(targetUnit), GetSpellTargetX(), GetSpellTargetY())
        else
            set I3X = AngleBetweenUnit(whichUnit, targetUnit)
        endif
        if targetUnit == null then
            return
        endif
        if GetUnitTypeId(targetUnit)=='o01X' then
            set range = 2000
        endif
        set range = range + GetUnitCastRangeBonus(whichUnit)
        loop
        exitwhen b or i == R2I(range / 25)
            set i = i + 1
            set dx = CoordinateX50(GetUnitX(targetUnit) +(range -i * 25)* Cos(I3X * bj_DEGTORAD))
            set dy = CoordinateY50(GetUnitY(targetUnit) +(range -i * 25)* Sin(I3X * bj_DEGTORAD))
            if (IsPointInRegion(TerrainCliffRegion,((dx)* 1.),((dy)* 1.))) == false then
                set b = true
            endif
        endloop
        call SetUnitPathing(targetUnit, false)
        call TriggerRegisterTimerEvent(t, .03, true)
        call TriggerRegisterDeathEvent(t, targetUnit)
        call TriggerAddCondition(t, Condition(function QXR))
        call SaveUnitHandle(HY, h, 2,(whichUnit))
        call SaveUnitHandle(HY, h, 17,(targetUnit))
        call SaveReal(HY, h, 6,((dx)* 1.))
        call SaveReal(HY, h, 7,((dy)* 1.))
        call SaveReal(HY, h, 23,((GetUnitX(targetUnit))* 1.))
        call SaveReal(HY, h, 24,((GetUnitY(targetUnit))* 1.))
        call SaveInteger(HY, h, 34, 0)
        call SaveGroupHandle(HY, h, 187,(AllocationGroup(184)))
        call SaveUnitHandle(HY, h, 810,(null))
        call SaveInteger(HY,(GetHandleId((targetUnit))),(4335), 1)
        set targetUnit = null
        set whichUnit = null
        set t = null
    endfunction
    function BoulderSmashOnSpellEffect takes nothing returns nothing
        if IsUnitAlly(GetSpellTargetUnit(), GetOwningPlayer(GetTriggerUnit())) or not UnitHasSpellShield(GetSpellTargetUnit()) then
            call QIR()
        endif
    endfunction

endscope
