scope TrollWarlord

    globals
        constant integer HERO_INDEX_TROLL_WARLORD = 27
    endglobals
    //***************************************************************************
    //*
    //*  旋风飞斧
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_WHIRLING_AXES = GetHeroSKillIndexBySlot(HERO_INDEX_TROLL_WARLORD, 2)
        constant integer WHIRLING_AXES_MELEE_ABILITY_ID  = 'A21N'
        constant integer WHIRLING_AXES_RANGED_ABILITY_ID = 'A21M'
    endglobals

    function BAI takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local integer level = GetUnitAbilityLevel(whichUnit,'A21L')
        if level == 0 then
            set level = GetUnitAbilityLevel(whichUnit, WHIRLING_AXES_RANGED_ABILITY_ID)
        endif
        call SetUnitAbilityLevel(whichUnit, WHIRLING_AXES_MELEE_ABILITY_ID , level)
        call SetUnitAbilityLevel(whichUnit, WHIRLING_AXES_RANGED_ABILITY_ID, level)
        set t = null
        set whichUnit = null
        return false
    endfunction
    function WhirlingAxesOnLearn takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = GetTriggerUnit()
        call UnitAddPermanentAbility(whichUnit, WHIRLING_AXES_MELEE_ABILITY_ID )
        call UnitAddPermanentAbility(whichUnit, WHIRLING_AXES_RANGED_ABILITY_ID)
        call SaveInteger(HY,(GetHandleId((whichUnit))),(4416), 2)
        call SaveInteger(HY,(GetHandleId((whichUnit))),(4417), 2)
        call TriggerRegisterTimerEvent(t, .05, true)
        call TriggerAddCondition(t, Condition(function BAI))
        call SaveUnitHandle(HY, h, 2,(whichUnit))
        call SavePlayerHandle(HY, h, 54,(GetOwningPlayer(whichUnit)))
        set t = null
        set whichUnit = null
    endfunction

    //***************************************************************************
    //*
    //*  旋风飞斧 - 远程
    //*
    //***************************************************************************
    function N8I takes unit whichUnit, unit targetUnit, unit dummyCaster, integer level returns nothing
        call SetUnitOwner(dummyCaster, GetOwningPlayer(targetUnit), false)
        call SetUnitAbilityLevel(dummyCaster,'A21P', level)
        call IssueTargetOrderById(dummyCaster, 852075, targetUnit)
        call UnitDamageTargetEx(whichUnit, targetUnit, 1, 75)
        call DestroyEffect(AddSpecialEffectTarget("Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl", targetUnit, "overhead"))
    endfunction
    function N9I takes nothing returns nothing
        if IsUnitInGroup(GetEnumUnit(), KNV) == false then
            call GroupAddUnit(KNV, GetEnumUnit())
            call N8I(KIV, GetEnumUnit(), KAV, KBV)
        endif
    endfunction
    function BVI takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = LoadUnitHandle(HY, h, 2)
        local real x = LoadReal(HY, h, 6)
        local real y = LoadReal(HY, h, 7)
        local unit BEI = LoadUnitHandle(HY, h, 393)
        local unit BXI = LoadUnitHandle(HY, h, 394)
        local unit BOI = LoadUnitHandle(HY, h, 395)
        local unit BRI = LoadUnitHandle(HY, h, 396)
        local unit BII = LoadUnitHandle(HY, h, 397)
        local real a = LoadReal(HY, h, 13)-12.5
        local real d = LoadReal(HY, h, 433)
        local integer level = LoadInteger(HY, h, 5)
        local unit u
        local group g
        local group D7R = LoadGroupHandle(HY, h, 187)
        local unit dummyUnit = LoadUnitHandle(HY, h, 19)
        local integer i = 0
        // 非匀速
        set d = d + 900 / 20.
        call SaveReal(HY, h, 433, d * 1.)
        set KIV = whichUnit
        set KAV = dummyUnit
        set KNV = D7R
        set KBV = level
        set g = AllocationGroup(290)
        loop
        exitwhen HaveSavedHandle(HY, h, 393 + i) == false
            set u = LoadUnitHandle(HY, h, 393 + i)
            if u != null and UnitAlive(u) then
                call SetUnitX(u, CoordinateX50(LoadReal(HY, h, 6) + d * Cos(a * bj_DEGTORAD)))
                call SetUnitY(u, CoordinateY50(LoadReal(HY, h, 7) + d * Sin(a * bj_DEGTORAD)))
                set x = GetUnitX(u)
                set y = GetUnitY(u)
                set TempUnit = whichUnit
                call GroupEnumUnitsInRange(g, x, y, 125, Condition(function DJX))
                call ForGroup(g, function N9I)
                call GroupClear(g)
            endif
            set a = a + 6.25
            set i = i + 1
        endloop
        call DeallocateGroup(g)
        if GetTriggerEvalCount(t)> 20 then
            call KillUnit(BEI)
            call KillUnit(BXI)
            call KillUnit(BOI)
            call KillUnit(BRI)
            call KillUnit(BII)
            call KillUnit(dummyUnit)
            call DeallocateGroup(D7R)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        endif
        set t = null
        set whichUnit = null
        set BEI = null
        set BXI = null
        set BOI = null
        set BRI = null
        set BII = null
        set dummyUnit = null
        set u = null
        set D7R = null
        set g = null
        return false
    endfunction
    function WhirlingAxesRangedOnSpellEfffect takes nothing returns nothing
        local unit whichUnit = GetTriggerUnit()
        local real x0 = GetUnitX(whichUnit)
        local real y0 = GetUnitY(whichUnit)
        local real x1 = GetSpellTargetX()
        local real y1 = GetSpellTargetY()
        local real a = AngleBetweenXY(x0, y0, x1, y1)
        local unit BEI = CreateUnit(GetOwningPlayer(whichUnit),'e02Z', x0, y0, a -12.5)
        local unit BXI = CreateUnit(GetOwningPlayer(whichUnit),'e02Z', x0, y0, a -6.25)
        local unit BOI = CreateUnit(GetOwningPlayer(whichUnit),'e02Z', x0, y0, a)
        local unit BRI = CreateUnit(GetOwningPlayer(whichUnit),'e02Z', x0, y0, a + 6.25)
        local unit BII = CreateUnit(GetOwningPlayer(whichUnit),'e02Z', x0, y0, a + 12.5)
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit d = CreateUnit(GetOwningPlayer(whichUnit),'e00E', x0, y0, 0)
        call UnitAddAbility(d,'A21P')
        call SaveUnitHandle(HY, h, 2, whichUnit)
        call SaveUnitHandle(HY, h, 19, d)
        call SaveUnitHandle(HY, h, 393, BEI)
        call SaveUnitHandle(HY, h, 394, BXI)
        call SaveUnitHandle(HY, h, 395, BOI)
        call SaveUnitHandle(HY, h, 396, BRI)
        call SaveUnitHandle(HY, h, 397, BII)
        call SaveReal(HY, h, 6, x0 * 1.)
        call SaveReal(HY, h, 7, y0 * 1.)
        call SaveReal(HY, h, 433, 0 * 1.)
        call SaveReal(HY, h, 13, a * 1.)
        call SaveGroupHandle(HY, h, 187, AllocationGroup(291))
        call SaveInteger(HY, h, 5, GetUnitAbilityLevel(whichUnit,WHIRLING_AXES_RANGED_ABILITY_ID))
        call TriggerRegisterTimerEvent(t, .03, true)
        call TriggerAddCondition(t, Condition(function BVI))
        set whichUnit = null
        set BEI = null
        set BXI = null
        set BOI = null
        set BRI = null
        set BII = null
        set t = null
        set d = null
    endfunction
    //***************************************************************************
    //*
    //*  旋风飞斧 - 近战
    //*
    //***************************************************************************
    function N3I takes unit whichUnit, unit targetUnit, unit dummyCaster, integer level returns nothing
        call SetUnitOwner(dummyCaster, GetOwningPlayer(targetUnit), false)
        call SetUnitAbilityLevel(dummyCaster,'A21O', level)
        call IssueTargetOrderById(dummyCaster,852190, targetUnit)
        call UnitDamageTargetEx(whichUnit, targetUnit, 1, 50 + 50 * level)
        call DestroyEffect(AddSpecialEffectTarget("Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl", targetUnit, "overhead"))
    endfunction
    function N4I takes nothing returns nothing
        if IsUnitInGroup(GetEnumUnit(), KNV) == false then
            call GroupAddUnit(KNV, GetEnumUnit())
            call N3I(KIV, GetEnumUnit(), KAV, KBV)
        endif
    endfunction
    function N5I takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local unit dummyCaster =(LoadUnitHandle(HY, h, 19))
        local real x = GetUnitX(whichUnit)
        local real y = GetUnitY(whichUnit)
        local unit N6I =(LoadUnitHandle(HY, h, 675))
        local unit N7I =(LoadUnitHandle(HY, h, 676))
        local real a =(LoadReal(HY, h, 13))
        local real d =(LoadReal(HY, h, 433))
        local integer level =(LoadInteger(HY, h, 5))
        local group D7R =(LoadGroupHandle(HY, h, 187))
        local group g = AllocationGroup(288)
        if GetTriggerEvalCount(t)<= 50 then
            set a = a + 20
            set d = d + 7
            call SaveReal(HY, h, 13,((a)* 1.))
            call SaveReal(HY, h, 433,((d)* 1.))
        elseif GetTriggerEvalCount(t)<= 100  then
            set a = a + 20
            set d = d -7
            call SaveReal(HY, h, 13,((a)* 1.))
            call SaveReal(HY, h, 433,((d)* 1.))
        endif
        call SetUnitX(N6I, CoordinateX50(x + d * Cos(a * bj_DEGTORAD)))
        call SetUnitY(N6I, CoordinateY50(y + d * Sin(a * bj_DEGTORAD)))
        set a = a + 180
        call SetUnitX(N7I, CoordinateX50(x + d * Cos(a * bj_DEGTORAD)))
        call SetUnitY(N7I, CoordinateY50(y + d * Sin(a * bj_DEGTORAD)))
        set TempUnit = whichUnit
        set KIV = whichUnit
        set KAV = dummyCaster
        set KNV = D7R
        set KBV = level
        call GroupEnumUnitsInRange(g, GetUnitX(N6I), GetUnitY(N6I), 125, Condition(function DHX))
        call ForGroup(g, function N4I)
        set TempUnit = whichUnit
        call GroupEnumUnitsInRange(g, GetUnitX(N7I), GetUnitY(N7I), 125, Condition(function DHX))
        call ForGroup(g, function N4I)
        call DeallocateGroup(g)
        if GetTriggerEvalCount(t)> 100  then
            call KillUnit(N6I)
            call KillUnit(N7I)
            call KillUnit(dummyCaster)
            call DeallocateGroup(D7R)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        endif
        set t = null
        set whichUnit = null
        set N6I = null
        set N7I = null
        set dummyCaster = null
        set D7R = null
        set g = null
        return false
    endfunction
    function WhirlingAxesMeleeOnSpellEfffect takes nothing returns nothing
        local unit whichUnit = GetTriggerUnit()
        local real x = GetUnitX(whichUnit)
        local real y = GetUnitY(whichUnit)
        local unit N6I = CreateUnit(GetOwningPlayer(whichUnit),'e02Y', x, y, 0)
        local unit N7I = CreateUnit(GetOwningPlayer(whichUnit),'e02Y', x, y, 0)
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit dummyCaster = CreateUnit(GetOwningPlayer(whichUnit),'e00E', x, y, 0)
        call UnitAddAbility(dummyCaster,'A21O')
        call SaveUnitHandle(HY, h, 2,(whichUnit))
        call SaveUnitHandle(HY, h, 19,(dummyCaster))
        call SaveUnitHandle(HY, h, 675,(N6I))
        call SaveUnitHandle(HY, h, 676,(N7I))
        call SaveReal(HY, h, 13,(0 * 1.))
        call SaveReal(HY, h, 433,(0 * 1.))
        call SaveInteger(HY, h, 5,(GetUnitAbilityLevel(whichUnit,WHIRLING_AXES_MELEE_ABILITY_ID)))
        call SaveGroupHandle(HY, h, 187,(AllocationGroup(289)))
        call TriggerRegisterTimerEvent(t, .03, true)
        call TriggerAddCondition(t, Condition(function N5I))
        call EnableAttackEffectByTime(16, 12.)
        set whichUnit = null
        set N6I = null
        set N7I = null
        set t = null
        set dummyCaster = null
    endfunction

endscope
