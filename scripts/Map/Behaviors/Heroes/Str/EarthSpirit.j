
scope EarthSpirit

    globals
        constant integer HERO_INDEX_EARTH_SPIRIT = 111
    endglobals

    function PCR takes nothing returns boolean
        return GetUnitTypeId(GetFilterUnit())=='o01X' and GetOwningPlayer(GetFilterUnit()) == GetOwningPlayer(TempUnit)
    endfunction

    //***************************************************************************
    //*
    //*  巨石猛击
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_BOULDER_SMASH = GetHeroSKillIndexBySlot(HERO_INDEX_EARTH_SPIRIT, 1)
    endglobals

    function QDR takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local unit targetUnit = GetSpellTargetUnit()
        local group g = AllocationGroup(185)
        set TempUnit = u
        call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 205, Condition(function PCR))
        if FirstOfGroup(g) == null then
            call EXStopUnit(u)
            if IsUnitType(u, UNIT_TYPE_HERO) then
                call InterfaceErrorForPlayer(GetOwningPlayer(u), "无效目标")
            endif
        endif
        call DeallocateGroup(g)
        set u = null
        set targetUnit = null
        set g = null
    endfunction
    function QFR takes nothing returns nothing
        if GetUnitDistanceEx(GetTriggerUnit(), GetSpellTargetUnit())> 200 then
            call QCR(GetTriggerUnit(), GetSpellTargetUnit())
        endif
    endfunction
    function BoulderSmashOnCast takes nothing returns nothing
        if GetSpellTargetUnit() == null then
            call QDR()
        elseif (GetUnitDistanceEx(GetTriggerUnit(), GetSpellTargetUnit())> 170 and GetUnitTypeId(GetSpellTargetUnit())!='n00L') then
            call QFR()
        elseif GetUnitTypeId(GetSpellTargetUnit())=='n00L' then
            call EXStopUnit(GetTriggerUnit())
            if IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) then
                call InterfaceErrorForPlayer(GetOwningPlayer(GetTriggerUnit()), "无效目标")
            endif
        endif
    endfunction

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

    //***************************************************************************
    //*
    //*  巨石猛击
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_ROLLING_BOULDER = GetHeroSKillIndexBySlot(HERO_INDEX_EARTH_SPIRIT, 2)
    endglobals
    
    function PKR takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local group g =(LoadGroupHandle(HY, h, 187))
        local group gg
        local unit dummyUnit =(LoadUnitHandle(HY, h, 19))
        local real x =(LoadReal(HY, h, 6))
        local real y =(LoadReal(HY, h, 7))
        local real PLR = GetUnitX(whichUnit)
        local real PMR = GetUnitY(whichUnit)
        local real PPR = GetDistanceBetween(x, y, PLR, PMR)
        local real M8R
        local real M9R
        local real PQR =(LoadReal(HY, h, 137))
        local real N3X = 800
        local integer PSR =(LoadInteger(HY, h, 34))
        local real PTR =(LoadReal(HY, h, 138))
        local boolean b = false
        local unit targetUnit =(LoadUnitHandle(HY, h, 810))
        local integer c = GetTriggerEvalCount(t)
        set FH = false
        call SetUnitTimeScale(whichUnit, 3)
        call SetUnitFacing(whichUnit, PQR)
        call SetUnitAnimationByIndex(whichUnit, 0)
        if c > 30 then
            if PSR == 0 then
                set gg = AllocationGroup(176)
                set TempUnit = whichUnit
                call GroupEnumUnitsInRange(gg, PLR, PMR, 175, Condition(function PCR))
                if FirstOfGroup(gg) != null then
                    call KillUnit(FirstOfGroup(gg))
                    set PSR = 1
                    call SaveInteger(HY, h, 34,(PSR))
                endif
                call DeallocateGroup(gg)
            endif
            if PSR == 1 then
                set N3X = N3X * 2
            endif
            if targetUnit != null then
                set PQR = AngleBetweenUnit(whichUnit, targetUnit)
                call SaveReal(HY, h, 137,((PQR)* 1.))
            endif
            set M8R = x + .02 * N3X * Cos(PQR * bj_DEGTORAD)
            set M9R = y + .02 * N3X * Sin(PQR * bj_DEGTORAD)
            if IsUnitType(whichUnit, UNIT_TYPE_HERO) then
                call SaveBoolean(OtherHashTable, GetHandleId(whichUnit), 99, true)
            endif
            call SetUnitX(whichUnit, CoordinateX50(M8R))
            call SetUnitY(whichUnit, CoordinateY50(M9R))
            call SaveReal(HY, h, 6,((GetUnitX(whichUnit))* 1.))
            call SaveReal(HY, h, 7,((GetUnitY(whichUnit))* 1.))
            call SetUnitX(dummyUnit, GetUnitX(whichUnit))
            call SetUnitY(dummyUnit, GetUnitY(whichUnit))
            call KillTreeByCircle(GetUnitX(whichUnit), GetUnitY(whichUnit), 100)
            set PPR = GetDistanceBetween(x, y, GetUnitX(whichUnit), GetUnitY(whichUnit))
            set PTR = PTR + PPR
            call SaveReal(HY, h, 138,((PTR)* 1.))
            set gg = AllocationGroup(177)
            set TempUnit = whichUnit
            set LH = whichUnit
            set KH = g
            set DH = GetUnitAbilityLevel(whichUnit,'A2TJ')
            set MH = null
            set HH = 60 + 30 * DH
            set GH = PSR
            set PH = null
            if c < 40 then
                if c < 35 then
                    call GroupEnumUnitsInRange(gg, GetUnitX(whichUnit), GetUnitY(whichUnit), RMinBJ( 100 ,(c -30)* 25), Condition(function DJX))
                else
                    call GroupEnumUnitsInRange(gg, GetUnitX(whichUnit), GetUnitY(whichUnit), 125, Condition(function DJX))
                endif
            else
                call GroupEnumUnitsInRange(gg, GetUnitX(whichUnit), GetUnitY(whichUnit), 175, Condition(function DJX))
            endif
            call GroupEnumUnitsInRange(gg, GetUnitX(whichUnit), GetUnitY(whichUnit), 175, Condition(function DJX))
            call ForGroup(gg, function PJR)
            call DeallocateGroup(gg)
            if PH != null then
                set gg = AllocationGroup(178)
                set MH = null
                set OJ = 9999
                call GroupEnumUnitsInRange(gg, GetUnitX(PH), GetUnitY(PH), 625, Condition(function PFR))
                call DeallocateGroup(gg)
                if MH == null then
                    set b = true
                    set MH = PH
                else
                    set targetUnit = MH
                    call SaveUnitHandle(HY, h, 810,(targetUnit))
                endif
            endif
        else
            if IsUnitType(whichUnit, UNIT_TYPE_HERO) then
                call SaveBoolean(OtherHashTable, GetHandleId(whichUnit), 99, true)
            endif
            call SetUnitX(whichUnit, x)
            call SetUnitY(whichUnit, y)
        endif
        if C5X(whichUnit) or GetTriggerEventId() == EVENT_WIDGET_DEATH or b or(targetUnit == null and(c > 130 or FH or(PSR == 0 and PTR > 800) or(PSR == 1 and PTR > 1600))) then
            call KillUnit(dummyUnit)
            call DeallocateGroup(g)
            call DestroyEffect(LoadEffectHandle(HY, h, 5))
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            call SetUnitTimeScale(whichUnit, 1)
            if FH then
                set M8R = GetUnitX(MH) + 50 * Cos(PQR * bj_DEGTORAD)
                set M9R = GetUnitY(MH) + 50 * Sin(PQR * bj_DEGTORAD)
                if IsUnitType(whichUnit, UNIT_TYPE_HERO) then
                    call SaveBoolean(OtherHashTable, GetHandleId(whichUnit), 99, true)
                endif
                call SetUnitX(whichUnit, CoordinateX50(M8R))
                call SetUnitY(whichUnit, CoordinateY50(M9R))
                call IssueTargetOrderById(whichUnit, 851983, MH)
            endif
        endif
        set whichUnit = null
        set t = null
        set gg = null
        set g = null
        set dummyUnit = null
        set targetUnit = null
        return false
    endfunction
    function RollingBoulderOnSpellEffect takes unit whichUnit, unit targetUnit returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit d = CreateUnit(GetOwningPlayer(whichUnit),'o01P', GetUnitX(whichUnit), GetUnitY(whichUnit), 0)
        local real I3X = AngleBetweenXY(GetUnitX(whichUnit), GetUnitY(whichUnit), GetSpellTargetX(), GetSpellTargetY())
        call SaveEffectHandle(HY, h, 5, AddSpecialEffectTarget("war3mapImported\\RollingBoulder.mdx", whichUnit, "origin"))
        call SetUnitTimeScale(whichUnit, 3)
        call TriggerRegisterDeathEvent(t, whichUnit)
        call TriggerRegisterTimerEvent(t, .02, true)
        call TriggerAddCondition(t, Condition(function PKR))
        call SaveUnitHandle(HY, h, 2,(whichUnit))
        call SaveGroupHandle(HY, h, 187,(AllocationGroup(179)))
        call SaveUnitHandle(HY, h, 19,(d))
        call SaveReal(HY, h, 6,((GetUnitX(whichUnit))* 1.))
        call SaveReal(HY, h, 7,((GetUnitY(whichUnit))* 1.))
        call SaveReal(HY, h, 137,((I3X)* 1.))
        call SaveInteger(HY, h, 34, 0)
        call SaveReal(HY, h, 138,(0 * 1.))
        call SaveUnitHandle(HY, h, 810,(null))
        if targetUnit != null and GetUnitTypeId(targetUnit)=='o01X' then
            call KillUnit(targetUnit)
        endif
        set t = null
        set d = null
    endfunction
    
    //***************************************************************************
    //*
    //*  地磁之握
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_GEOMAGNETIC_GRIP = GetHeroSKillIndexBySlot(HERO_INDEX_EARTH_SPIRIT, 3)
    endglobals

    function GeomagneticGripOnCast takes nothing returns nothing
        local unit targetUnit = GetSpellTargetUnit()
        local group g
        if targetUnit == null then
            set g = AllocationGroup(174)
            set TempUnit = GetTriggerUnit()
            call GroupEnumUnitsInRange(g, GetSpellTargetX(), GetSpellTargetY(), 265, Condition(function PCR))
            if FirstOfGroup(g) == null then
                call EXStopUnit(GetTriggerUnit())
                if IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) then
                    call InterfaceErrorForPlayer(GetOwningPlayer(GetTriggerUnit()), "附近没有发现岩石")
                endif
            endif
            call DeallocateGroup(g)
        endif
        set g = null
        set targetUnit = null
    endfunction

    function M4R takes nothing returns nothing
        local unit u = GetEnumUnit()
        if GetUnitTypeId(u)!='o01X' then
            call SetUnitPathing(u, true)
        endif
        call SaveInteger(HY,(GetHandleId((u))),(4336), 2)
        set u = null
    endfunction
    function M5R takes unit targetUnit returns nothing
        local unit d = CreateUnit(GetOwningPlayer(targetUnit),'e00E', GetUnitX(targetUnit), GetUnitY(targetUnit), 0)
        call UnitAddAbility(d,'A2TG')
        call SetUnitAbilityLevel(d,'A2TG', EH)
        call IssueTargetOrderById(d, 852668, targetUnit)
        set d = null
    endfunction
    function M6R takes nothing returns nothing
        if IsUnitInGroup(GetEnumUnit(), NH) == false then
            call GroupAddUnit(NH, GetEnumUnit())
            call M5R(GetEnumUnit())
            if XH == 1 then
                call UnitDamageTargetEx(RH, GetEnumUnit(), 1, 50 * EH)
            endif
        endif
    endfunction
    function M7R takes nothing returns nothing
        local unit u = GetEnumUnit()
        local real I3X =(LoadReal(HY,(GetHandleId(u)), 801))
        local real N3X =(LoadReal(HY,(GetHandleId(u)), 802))
        local real M8R = BH + N3X * Cos(I3X)
        local real M9R = CH + N3X * Sin(I3X)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\FlakCannons\\FlakTarget.mdl", M8R, M9R))
        if GetUnitTypeId(u)=='o01X' or GetUnitTypeId(u)=='o020' then
            set XH = 1
            call SetUnitPosition(u, M8R, M9R)
            call SetUnitX(u, M8R)
            call SetUnitY(u, M9R)
        else
            call SetUnitX(u, M8R)
            call SetUnitY(u, M9R)
            call KillTreeByCircle(M8R, M9R, 100)
        endif
        set u = null
    endfunction
    function PVR takes nothing returns nothing
        local unit u = GetEnumUnit()
        if IsUnitDeath(u) or((LoadInteger(HY,(GetHandleId((u))),(4306))) == 1) or GetUnitAbilityLevel(u,'B08V')> 0 or((LoadInteger(HY,(GetHandleId((u))),(4335))) == 1) then
            call GroupRemoveUnit(NH, u)
            call SaveInteger(HY,(GetHandleId((u))),(4336), 2)
            if GetUnitTypeId(u)!='o01X' then
                call SetUnitPathing(u, true)
            endif
        endif
        set u = null
    endfunction
    function PER takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local group g =(LoadGroupHandle(HY, h, 803))
        local real PXR =(LoadReal(HY, h, 6))
        local real POR =(LoadReal(HY, h, 7))
        local real PRR =(LoadReal(HY, h, 23))
        local real PIR =(LoadReal(HY, h, 24))
        local real I3X = bj_DEGTORAD * AngleBetweenXY(PRR, PIR, PXR, POR)
        local real PAR
        local real PNR
        local boolean b = false
        local group gg =(LoadGroupHandle(HY, h, 187))
        local group PBR
        set XH = 0
        set NH = g
        call ForGroup(g, function PVR)
        if GetTriggerEvalCount(t)> 200 or FirstOfGroup(g) == null then
            set b = true
        else
            set PAR = PRR + 1000* .03 * Cos(I3X)
            set PNR = PIR + 1000* .03 * Sin(I3X)
            if GetDistanceBetween(PAR, PNR, PXR, POR)< 30 then
                set PAR = PXR
                set PNR = POR
                set b = true
            endif
            set PAR = CoordinateX50(PAR)
            set PNR = CoordinateY50(PNR)
            set NH = g
            set BH = PAR
            set CH = PNR
            call ForGroup(g, function M7R)
            call SaveReal(HY, h, 23,((PAR)* 1.))
            call SaveReal(HY, h, 24,((PNR)* 1.))
            set PBR = AllocationGroup(170)
            set TempUnit = whichUnit
            set NH = gg
            set RH = whichUnit
            set EH = GetUnitAbilityLevel(whichUnit,'A2QI')
            call GroupEnumUnitsInRange(PBR, PAR, PNR, 205, Condition(function DJX))
            call ForGroup(PBR, function M6R)
            call DeallocateGroup(PBR)
            set PBR = null
        endif
        if b then
            call ForGroup(g, function M4R)
            call DestroyEffect((LoadEffectHandle(HY, h, 32)))
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            call DeallocateGroup(gg)
            call DeallocateGroup(g)
        endif
        set whichUnit = null
        set t = null
        set gg = null
        set g = null
        return false
    endfunction
    function PDR takes nothing returns nothing
        local unit u = GetEnumUnit()
        call SetUnitPathing(u, false)
        call SaveInteger(HY,(GetHandleId((u))),(4336), 1)
        call SaveReal(HY,(GetHandleId(u)), 801,((bj_DEGTORAD * AngleBetweenXY(BH, CH, GetUnitX(u), GetUnitY(u)))* 1.))
        call SaveReal(HY,(GetHandleId(u)), 802,((GetDistanceBetween(BH, CH, GetUnitX(u), GetUnitY(u)))* 1.))
        set u = null
    endfunction
    function GeomagneticGripOnSpellEffect takes nothing returns nothing
        local unit whichUnit = GetTriggerUnit()
        local trigger t
        local integer h
        local real PRR = GetUnitX(GetSpellTargetUnit())
        local real PIR = GetUnitY(GetSpellTargetUnit())
        local real PXR = GetUnitX(whichUnit)
        local real POR = GetUnitY(whichUnit)
        local real I3X = AngleBetweenXY(PXR, POR, PRR, PIR)
        local unit targetUnit = GetSpellTargetUnit()
        local group g
        if targetUnit == null then
            set g = AllocationGroup(171)
            set TempUnit = whichUnit
            call GroupEnumUnitsInRange(g, GetSpellTargetX(), GetSpellTargetY(), 265, Condition(function PCR))
            if FirstOfGroup(g) == null then
                call DeallocateGroup(g)
                set whichUnit = null
                set g = null
                return
            endif
            set targetUnit = FirstOfGroup(g)
            call DeallocateGroup(g)
        endif
        set g = AllocationGroup(172)
        call GroupAddUnit(g, targetUnit)
        set PRR = GetUnitX(targetUnit)
        set PIR = GetUnitY(targetUnit)
        set I3X = AngleBetweenXY(PXR, POR, PRR, PIR)
        set t = CreateTrigger()
        set h = GetHandleId(t)
        set BH = PRR
        set CH = PIR
        call ForGroup(g, function PDR)
        set PXR = PXR + 100 * Cos(I3X * bj_DEGTORAD)
        set POR = POR + 100 * Sin(I3X * bj_DEGTORAD)
        call TriggerRegisterTimerEvent(t, .03, true)
        call TriggerAddCondition(t, Condition(function PER))
        call SaveUnitHandle(HY, h, 2,(whichUnit))
        call SaveReal(HY, h, 6,((PXR)* 1.))
        call SaveReal(HY, h, 7,((POR)* 1.))
        call SaveReal(HY, h, 23,((PRR)* 1.))
        call SaveReal(HY, h, 24,((PIR)* 1.))
        call SaveGroupHandle(HY, h, 187,(AllocationGroup(173)))
        call SaveGroupHandle(HY, h, 803,(g))
        call SaveEffectHandle(HY, h, 32,(AddSpecialEffectTarget("war3mapImported\\MagneticGripTarget.mdx", targetUnit, "chest")))
        set whichUnit = null
        set t = null
        set g = null
        set targetUnit = null
    endfunction

    //***************************************************************************
    //*
    //*  磁化
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_MAGNETRIZE = GetHeroSKillIndexBySlot(HERO_INDEX_EARTH_SPIRIT, 4)
    endglobals
    function QGR takes nothing returns nothing
        set YH = GetEnumUnit()
        call ExecuteFunc("QHR")
    endfunction
    function QJR takes nothing returns boolean
        return IsUnitDeath(GetFilterUnit()) == false and GetUnitTypeId(GetFilterUnit())=='o01X' and((LoadInteger(HY,(GetHandleId((GetFilterUnit()))),(4335))) == 1) == false and((LoadInteger(HY,(GetHandleId((GetFilterUnit()))),(4340))) == 1) == false
    endfunction
    function QKR takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = LoadUnitHandle(HY, h, 2)
        local unit triggerUnit = LoadUnitHandle(HY, h, 17)
        local real x = GetUnitX(triggerUnit)
        local real y = GetUnitY(triggerUnit)
        local group g = AllocationGroup(186)
        local integer C2R = GetTriggerEvalCount(t)
        local integer level = GetUnitAbilityLevel(whichUnit,'A2TI')
        local real QLR =(LoadReal(HY,(GetHandleId(triggerUnit)), 807))
        if ModuloInteger(C2R, 5) == 0 then
            call UnitDamageTargetEx(whichUnit, triggerUnit, 1,(25 + 25 * level)/ 2)
        endif
        set WH = whichUnit
        set TempUnit = whichUnit
        call GroupEnumUnitsInRange(g, x, y, 325, Condition(function QJR))
        call ForGroup(g, function QGR)
        call DeallocateGroup(g)
        if (GetGameTime())> QLR or IsUnitDeath(triggerUnit) then
            call SaveInteger(HY, GetHandleId(triggerUnit), 809, 2)
            call DestroyEffect(LoadEffectHandle(HY, h, 32))
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        endif
        set t = null
        set whichUnit = null
        set triggerUnit = null
        set g = null
        return false
    endfunction
    function QMR takes unit u, unit triggerUnit returns nothing
        local trigger t
        local integer h
        local real QPR = LoadReal(HY, GetHandleId(triggerUnit), 807)
        call SaveReal(HY,(GetHandleId(triggerUnit)), 807,(((GetGameTime()) + 6)* 1.))
        if QPR <(GetGameTime()) then
            call SaveInteger(HY,(GetHandleId((triggerUnit))), 809, 1)
            set t = CreateTrigger()
            set h = GetHandleId(t)
            call SaveUnitHandle(HY, h, 2,(u))
            call SaveUnitHandle(HY, h, 17,(triggerUnit))
            call SaveEffectHandle(HY, h, 32,(AddSpecialEffectTarget("war3mapImported\\MagnetizeTargetOverhead.mdx", triggerUnit, "origin")))
            call TriggerRegisterTimerEvent(t, .1, true)
            call TriggerAddCondition(t, Condition(function QKR))
        endif
        set t = null
    endfunction
    function QQR takes nothing returns nothing
        call QMR(WH, GetEnumUnit())
    endfunction
    function QSR takes unit u, unit targetUnit returns nothing
        local group g = AllocationGroup(187)
        local real x = GetUnitX(targetUnit)
        local real y = GetUnitY(targetUnit)
        local real QTR = 300
        if GetUnitTypeId(targetUnit)=='o01X' then
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\DemolisherMissile\\DemolisherMissile.mdx", GetUnitX(targetUnit), GetUnitY(targetUnit)))
            call UnitApplyTimedLife(targetUnit,'BTLF', 5)
            call SaveInteger(HY,(GetHandleId((targetUnit))),(4340), 1)
            call SetUnitVertexColor(targetUnit, 0, 0, 0, 100)
            set QTR = 600
        else
            call DestroyEffect(AddSpecialEffect("war3mapImported\\MagnetizeCastAoE.mdx", GetUnitX(targetUnit), GetUnitY(targetUnit)))
        endif
        set TempUnit = u
        set WH = u
        set YH = targetUnit
        call GroupEnumUnitsInRange(g, x, y, QTR + 25, Condition(function DJX))
        call ForGroup(g, function QQR)
        call DeallocateGroup(g)
        set g = null
    endfunction
    function QHR takes nothing returns nothing
        call QSR(WH, YH)
    endfunction
    function MagnetrizeOnSpellEffect takes nothing returns nothing
        call QSR(GetTriggerUnit(), GetTriggerUnit())
    endfunction

    globals
        constant key STONE_REMAN_KEY
        constant integer EARTH_SPIRIT_STONE_REMNANT = 'A2TH'
    endglobals
    
    function StoneRemnantOnSpellEffect takes nothing returns nothing
        local unit stoneUnit
        local unit whichUnit     = GetTriggerUnit()
        local integer h          = GetHandleId(whichUnit)
        local integer level      = GetUnitAbilityLevel(whichUnit,'A2TH')
        local integer stoneCount = (LoadInteger(HY, h, 279))
        local unit    lastStone  = (LoadUnitHandle(HY, h, 1401))
        local real    x
        local real    y
        local integer count = GetUnitAbilityCharges(whichUnit, EARTH_SPIRIT_STONE_REMNANT)
        if count > 0 then
            set count = IMaxBJ(0, count -1)
            if count < 2 then
                call DisplayTimedTextToPlayer(GetOwningPlayer(whichUnit), 0, 0, 10, I2S(count) + " 剩余巨石")
            endif
            // call SaveInteger(HY,(GetHandleId(whichUnit)), 800,(count))
            call SetUnitAbilityCharges(whichUnit, EARTH_SPIRIT_STONE_REMNANT, count)
            if GetSpellTargetUnit() == null then
                set x = GetSpellTargetX()
                set y = GetSpellTargetY()
            else
                set x = GetUnitX(GetSpellTargetUnit())
                set y = GetUnitY(GetSpellTargetUnit())
            endif
            set stoneUnit = CreateUnit(GetOwningPlayer(whichUnit),'o01X', x, y, 0)
            call SaveInteger(HY, GetHandleId(stoneUnit), 4335, 0)
            call SaveInteger(HY, GetHandleId(stoneUnit), 4340, 0)
            call UnitApplyTimedLife(stoneUnit,'BTLF', 120)
            call SetUnitPathing(stoneUnit, false)
            set stoneCount = stoneCount + 1
            call SaveUnitHandle(HY, h,( 1400+ stoneCount),(stoneUnit))
            call SaveInteger(HY, h, 279,(stoneCount))
            if (stoneCount > 6) then
                call KillUnit(lastStone)
            endif
        else
            call InterfaceErrorForPlayer(GetOwningPlayer(whichUnit), "没有可用的石头")
        endif
        set stoneUnit = null
        set whichUnit = null
        set lastStone = null
    endfunction

    function StoneRemnantUpdateCharges takes nothing returns boolean
        local trigger t         = GetTriggeringTrigger()
        local integer h         = GetHandleId(t)
        local unit    whichUnit = (LoadUnitHandle(HY, h, 2))
        local real    remaining = (LoadReal(HY, h, 442))
        local integer count     = GetUnitAbilityCharges(whichUnit, EARTH_SPIRIT_STONE_REMNANT)
        if GetTriggerEventId() == EVENT_UNIT_SPELL_CAST then
            if (GetSpellAbilityId()=='A2TH') and count <= 0 then
                call InterfaceErrorForPlayer(GetOwningPlayer(whichUnit), "没有足够的巨石了")
                call EXStopUnit(whichUnit)
            endif
        elseif GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
            if GetSpellAbilityId()=='A2TH' or GetSpellAbilityId()=='A2TJ' then
                if GetSpellAbilityId()=='A2TJ' then
                    call RollingBoulderOnSpellEffect(whichUnit, null)
                endif
            endif
        elseif count < 6 then
            set remaining = remaining -0.2
            call SaveReal(HY, h, 442,((remaining)* 1.))
            if remaining <= 0.00 then
                set count = count + 1
                call SetUnitAbilityCharges(whichUnit, EARTH_SPIRIT_STONE_REMNANT, count)
                call SaveReal(HY, h, 442,(25 * 1.))
            endif
        endif
        set whichUnit = null
        set t = null
        return false
    endfunction
    function UnitAddStoneRemnant takes unit u returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        call TriggerRegisterTimerEvent(t, .2, true)
        call TriggerRegisterUnitEvent(t, u, EVENT_UNIT_SPELL_CAST)
        call TriggerRegisterUnitEvent(t, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(t, Condition(function StoneRemnantUpdateCharges))
        call SaveUnitHandle(HY, h, 2,(u))
        call SaveReal(HY, h, 442, 25.)
        //call SaveInteger(HY,(GetHandleId(u)), 800, 6)

        call SetUnitAbilityCharges(u, EARTH_SPIRIT_STONE_REMNANT, 6)
        set Table[GetHandleId(u)].trigger[STONE_REMAN_KEY] = t
        set t = null
    endfunction

    function StoneRemnantOnAdd takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()

        call UnitAddStoneRemnant(whichUnit)
  
        set whichUnit = null
    endfunction
    function StoneRemnantOnRemove takes nothing returns nothing
        local unit    whichUnit = Event.GetTriggerUnit()
        local trigger trig      = Table[GetHandleId(whichUnit)].trigger[STONE_REMAN_KEY]
  
        call FlushChildHashtable(HY, GetHandleId(trig))
        call DestroyTrigger(trig)

        set trig      = null
        set whichUnit = null
    endfunction

    function EarthSpiritAbilityOnAdd takes nothing returns nothing
        local unit    whichUnit = Event.GetTriggerUnit()
        local integer count     = Table[GetHandleId(whichUnit)].integer[STONE_REMAN_KEY] + 1

        if not IsUnitType(whichUnit, UNIT_TYPE_HERO) then
            set whichUnit = null
            return
        endif

        set Table[GetHandleId(whichUnit)].integer[STONE_REMAN_KEY] = count
        if count == 1 then
            call UnitAddPermanentAbility(whichUnit, EARTH_SPIRIT_STONE_REMNANT)
        endif
  
        set whichUnit = null
    endfunction
    function EarthSpiritAbilityOnRemove takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        local integer count  = Table[GetHandleId(whichUnit)].integer[STONE_REMAN_KEY] - 1

        if not IsUnitType(whichUnit, UNIT_TYPE_HERO) then
            set whichUnit = null
            return
        endif
        
        set Table[GetHandleId(whichUnit)].integer[STONE_REMAN_KEY] = count
        if count == 0 then
            call UnitRemoveAbility(whichUnit, EARTH_SPIRIT_STONE_REMNANT)
        endif

        set whichUnit = null
    endfunction

endscope
