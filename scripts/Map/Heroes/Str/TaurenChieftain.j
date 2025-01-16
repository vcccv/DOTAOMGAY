
scope TaurenChieftain

    //***************************************************************************
    //*
    //*  裂地者
    //*
    //***************************************************************************

    function EarthSplitterDelayAction takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = LoadUnitHandle(HY, h, 2)
        local real x0 = LoadReal(HY, h, 282)
        local real y0 = LoadReal(HY, h, 283)
        local real a0 = LoadReal(HY, h, 341)
        local integer i = 0
        local real x
        local real y
        local group g = AllocationGroup(271)
        local group targGroup = AllocationGroup(272)
        local integer level = LoadInteger(HY, h, 0)
        local boolean MDR = LoadBoolean(HY, h, 2)
        local unit    first
        local player  p = GetOwningPlayer(whichUnit)
        local real damage
        local real x1
        local real y1
        local real x2
        local real y2
        local real x3
        local real y3
        local real u 
        local real x4
        local real y4
        local integer upgradeLevel
        local real area = 315.

        call FlushChildHashtable(HY, h)
        call CleanCurrentTrigger(t)
        set J1V = CreateUnit(GetOwningPlayer(whichUnit),'e00E', x0, y0, 0)
        call UnitAddPermanentAbility(J1V,'A43M')
        call SetUnitAbilityLevel(J1V,'A43M', level)
        if MDR then
            set upgradeLevel = level
        else
            set upgradeLevel = 0
        endif
        loop
        exitwhen i > 11
            set x = x0 + i * 200* Cos(a0)
            set y = y0 + i * 200* Sin(a0)
            call ABX("Abilities\\Spells\\Orc\\EarthQuake\\EarthQuakeTarget.mdl", x, y, 1.6)
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl", x, y  -250))
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl", x, y))
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl", x + 250, y))
            call A3X(x, y, 300)

            call GroupEnumUnitsInRange(g, x, y, 315 + MAX_UNIT_COLLISION, null)
            loop
                set first = FirstOfGroup(g)
                exitwhen first == null
                call GroupRemoveUnit(g, first)

                if IsUnitInRangeXY(first, x, y, area) and IsAliveNotStrucNotWard(first) and IsUnitEnemy(first, p) then
                    call GroupAddUnit(targGroup, first)
                endif
            endloop

            call GroupAddGroup(g, targGroup)
            call GroupClear(g)
            set i = i + 1
        endloop

        set x1 = x0
        set y1 = y0
        set x2 = x
        set y2 = y

        loop
            set first = FirstOfGroup(targGroup)
            exitwhen first == null
            call GroupRemoveUnit(targGroup, first)

            set x3 = GetUnitX(first)
            set y3 = GetUnitY(first)
            set u =((x3 -x1)*(x2 -x1)+(y3 -y1)*(y2 -y1))/((x1 -x2)*(x1 -x2)+(y1 -y2)*(y1 -y2))
            set x4 = x1 + u *(x2 -x1)
            set y4 = y1 + u *(y2 -y1)
            set damage = GetUnitState(first, UNIT_STATE_MAX_LIFE)* .35 / 2
            if IsUnitType(first, UNIT_TYPE_HERO) then
                call SetUnitPosition(first, x4, y4)
            else
                call SetUnitX(first, x4)
                call SetUnitY(first, y4)
            endif
            call U1V(J1V, 852095, first)
            call UnitDamageTargetEx(whichUnit, first, 1, damage)
            call UnitDamageTargetEx(whichUnit, first, 2, damage)
            if upgradeLevel > 0 and UnitIsDead(first) == false then
                call UnitAddAbilityToTimed(first,'A43L', 1, upgradeLevel + 3., 0)
                call UnitAddAbilityToTimed(first,'A44E', 1, upgradeLevel + 3., 0)
            endif
            
        endloop
        
        call DeallocateGroup(targGroup)
        call DeallocateGroup(g)
        set t = null
        set whichUnit = null
        set g = null
        set targGroup = null
        return false
    endfunction
    function IUI takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = LoadUnitHandle(HY, h, 2)
        local real a = LoadReal(HY, h, 137)
        local real x0 = LoadReal(HY, h, 282)
        local real y0 = LoadReal(HY, h, 283)
        local real a0
        local real IWI
        local real IYI
        local real IZI
        local real I_I
        local real I0I
        local real I1I
        local real I2I
        local real I3I
        local real I4I
        local real I5I
        local real I6I
        local real I7I
        local real x
        local real y
        local integer level
        local ubersplat N4O
        local integer count = GetTriggerEvalCount(t)
        local boolean MDR = LoadBoolean(HY, h, 2)
        local integer maxCount = LoadInteger(HY, h, 10)
        set x = x0 + 200* count * Cos(a)
        set y = y0 + 200* count * Sin(a)
        set N4O = CreateUbersplat(x, y, "THNE", 255, 255, 255, 255, false, false)
        call SetUbersplatRenderAlways(N4O, true)
        set IWI = x + 250* Cos(bj_DEGTORAD *(a * bj_RADTODEG -45))
        set IYI = y + 250* Sin(bj_DEGTORAD *(a * bj_RADTODEG -45))
        set IZI = x + 250* Cos(bj_DEGTORAD *(a * bj_RADTODEG + 45))
        set I_I = y + 250* Sin(bj_DEGTORAD *(a * bj_RADTODEG + 45))
        set I0I = x -125 * Cos(bj_DEGTORAD *(a * bj_RADTODEG -45))
        set I1I = y -125 * Sin(bj_DEGTORAD *(a * bj_RADTODEG -45))
        set I2I = x -125 * Cos(bj_DEGTORAD *(a * bj_RADTODEG + 45))
        set I3I = y -125 * Sin(bj_DEGTORAD *(a * bj_RADTODEG + 45))
        set I4I = x
        set I5I = y
        set I6I = x
        set I7I = y
        call A8X(GetOwningPlayer(whichUnit), 4, x, y, 500)
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl", IWI, IYI))
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl", IZI, I_I))
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl", I0I, I1I))
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl", I2I, I3I))
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl", I4I, I5I))
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl", I6I, I7I))
        if GetTriggerEvalCount(t)> maxCount then
            set x0 = LoadReal(HY, h, 282)
            set y0 = LoadReal(HY, h, 283)
            set a0 = LoadReal(HY, h, 341)
            set level = LoadInteger(HY, h, 0)
            call FlushChildHashtable(HY, h)
            call CleanCurrentTrigger(t)
            set t = CreateTrigger()
            set h = GetHandleId(t)
            call TriggerRegisterTimerEvent(t, .5, false)
            call TriggerAddCondition(t, Condition(function EarthSplitterDelayAction))
            call SaveUnitHandle(HY, h, 2, whichUnit)
            call SaveBoolean(HY, h, 2, MDR)
            call SaveInteger(HY, h, 0, level)
            call SaveReal(HY, h, 282, x0 * 1.)
            call SaveReal(HY, h, 283, y0 * 1.)
            call SaveReal(HY, h, 341, a0 * 1.)
        endif
        set t = null
        set whichUnit = null
        set N4O = null
        return false
    endfunction
    function EarthSplitterOnSpellEffect takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local real x = GetSpellTargetX()
        local real y = GetSpellTargetY()
        local real a = Atan2(y -GetUnitY(whichUnit), x -GetUnitX(whichUnit))
        local boolean b = GetSpellAbilityId()=='A43J'
        local integer maxCount = 11
        if GetUnitAbilityLevel(whichUnit,'A3O3')>0 then
            set maxCount = 12
        endif
        if b then
            call TriggerRegisterTimerEvent(t, .08, true)
        else
            call TriggerRegisterTimerEvent(t, .22, true)
        endif
        call TriggerAddCondition(t, Condition(function IUI))
        call SaveInteger(HY, h, 0, GetUnitAbilityLevel(whichUnit, GetSpellAbilityId()))
        call SaveBoolean(HY, h, 2, b)
        call SaveUnitHandle(HY, h, 2, whichUnit)
        call SaveReal(HY, h, 6, GetUnitX(whichUnit)* 1.)
        call SaveReal(HY, h, 7, GetUnitY(whichUnit)* 1.)
        call SaveReal(HY, h, 137, a * 1.)
        call SaveReal(HY, h, 282, GetUnitX(whichUnit)* 1.)
        call SaveReal(HY, h, 283, GetUnitY(whichUnit)* 1.)
        call SaveReal(HY, h, 341, a * 1.)
        call SaveInteger(HY, h, 10, maxCount)
        set t = null
        set whichUnit = null
    endfunction

endscope
