scope Weaver

    globals
        constant integer HERO_INDEX_WAVER = 79
    endglobals
    //***************************************************************************
    //*
    //*  蝗虫群
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_SWARM = GetHeroSKillIndexBySlot(HERO_INDEX_WAVER, 1)
    endglobals

    function N6A takes nothing returns boolean
        return DHX() and LoadInteger(HY, GetHandleId(GetFilterUnit()), 4290) != 1 and(IsUnitVisibleToPlayer(GetFilterUnit(), GetOwningPlayer(TempUnit)) or IsUnitCloaked(GetFilterUnit()) == false)
    endfunction
    function N7A takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local group   g
        local integer i = 1
        local unit    whichUnit = LoadUnitHandle(HY, h, 2)
        local real    x = LoadReal(HY, h, 6)
        local real    y = LoadReal(HY, h, 7)
        local real    a = LoadReal(HY, h, 137)
        local unit    N5A
        local unit    targetUnit
        local real    tx = LoadReal(HY, h, 47)
        local real    ty = LoadReal(HY, h, 48)
        set x = CoordinateX50(x + 18 * Cos(a))
        set y = CoordinateY50(y + 18 * Sin(a))
        call SaveReal(HY, h, 6, x * 1.)
        call SaveReal(HY, h, 7, y * 1.)
        if GetTriggerEvalCount(t)> LoadInteger(HY, h, 10) then
            loop
            exitwhen i > 12
                if (LoadBoolean(HY, h, 511 + i -1)) == false then
                    call KillUnit(LoadUnitHandle(HY, h, 393 + i -1))
                endif
                set i = i + 1
            endloop
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        else
            set g = AllocationGroup(418)
            set TempUnit = whichUnit
            call GroupEnumUnitsInRange(g, x, y, 400, Condition(function N6A))
            loop
            exitwhen i > 12
                if (LoadBoolean(HY, h, 511 + i -1)) == false then
                    set N5A = LoadUnitHandle(HY, h, 393 + i -1)
                    set x = LoadReal(HY, h, 549 + i -1)
                    set y = LoadReal(HY, h, 567 + i -1)
                    set x = CoordinateX50(x + 18 * Cos(a))
                    set y = CoordinateY50(y + 18 * Sin(a))
                    call SaveReal(HY, h, 549 + i -1, x * 1.)
                    call SaveReal(HY, h, 567 + i -1, y * 1.)
                    call SetUnitX(N5A, x)
                    call SetUnitY(N5A, y)
                    set targetUnit = FirstOfGroup(g)
                    if targetUnit != null then
                        call GroupRemoveUnit(g, targetUnit)
                        call SaveInteger(HY, GetHandleId(targetUnit), 4290, 1)
                        call SaveBoolean(HY, h, 511 + i -1, true)
                        call N4A(N5A, targetUnit, LoadInteger(HY, h, 0))
                    endif
                endif
                set i = i + 1
            endloop
            call DeallocateGroup(g)
            set g = null
            set N5A = null
            set targetUnit = null
        endif
        set t = null
        set whichUnit = null
        return false
    endfunction
    function WaverSwarmOnSpellEffect takes nothing returns nothing
        local real tx = GetSpellTargetX()
        local real ty = GetSpellTargetY()
        local unit whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local real x = GetUnitX(whichUnit)
        local real y = GetUnitY(whichUnit)
        local real a = AngleBetweenXY(x, y, tx, ty)* bj_DEGTORAD
        local unit dummyCaster
        local real targetX = CoordinateX50(x + 3000* Cos(a))
        local real targetY = CoordinateY50(y + 3000* Sin(a))
        local integer i = 1
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local real IMX
        local integer level = GetUnitAbilityLevel(whichUnit,'A1QW')
        local integer OVX
        local real range = 3000 + GetUnitCastRangeBonus(whichUnit)
        if level == 1 then
            set OVX ='u01K'
        elseif level == 2 then
            set OVX ='u01H'
        elseif level == 3 then
            set OVX ='u01J'
        elseif level == 4 then
            set OVX ='u01L'
        endif
        loop
        exitwhen i > 12
            set dummyCaster = CreateUnit(GetOwningPlayer(whichUnit), OVX, x + GetRandomInt(-300, 300), y + GetRandomInt(-300, 300), a * bj_RADTODEG)
            call SaveUnitHandle(HY, h, 393 + i -1, dummyCaster)
            call SaveBoolean(HY, h, 511 + i -1, false)
            call SaveReal(HY, h, 549 + i -1, GetUnitX(dummyCaster)* 1.)
            call SaveReal(HY, h, 567 + i -1, GetUnitY(dummyCaster)* 1.)
            call UnitAddAbility(dummyCaster,'Aloc')
            call UnitAddAbility(dummyCaster,'Abun')
            set i = i + 1
        endloop
        call TriggerRegisterTimerEvent(t, .03, true)
        call TriggerAddCondition(t, Condition(function N7A))
        call SaveUnitHandle(HY, h, 2, whichUnit)
        call SaveReal(HY, h, 6, x * 1.)
        call SaveReal(HY, h, 7, y * 1.)
        call SaveReal(HY, h, 137, a * 1.)
        call SaveReal(HY, h, 47, targetX * 1.)
        call SaveReal(HY, h, 48, targetY * 1.)
        call SaveInteger(HY, h, 0, level)
        call SaveInteger(HY, h, 10, R2I(range / 18))
        set whichUnit = null
        set dummyCaster = null
        set t = null
    endfunction

endscope
