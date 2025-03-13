
scope TaurenChieftain

    globals
        constant integer HERO_INDEX_TAUREN_CHIEFTAIN = 15
    endglobals
    //***************************************************************************
    //*
    //*  先祖之魂
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_ANCESTRAL_SPIRIT = GetHeroSKillIndexBySlot(HERO_INDEX_TAUREN_CHIEFTAIN, 2)
    endglobals
    function I8I takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer h = GetHandleId(t)
        local unit u = LoadUnitHandle(ObjectHashTable, h, 0)
        call UnitSubStateBonus(u, LoadInteger(ObjectHashTable, h, 3), UNIT_BONUS_DAMAGE)
        call J8X(u, R2I(LoadReal(ObjectHashTable, h, 0)))
        call DestroyTimerAndFlushHT_P(t)
        set t = null
        set u = null
    endfunction
    function I9I takes nothing returns boolean
        local unit t = GetFilterUnit()
        local group g = LoadGroupHandle(ObjectHashTable, XK[0], 2)
        if UnitAlive(t) and IsUnitEnemy(Temp__ArrayUnit[0], GetOwningPlayer(t)) and not IsUnitWard(t) and IsUnitInGroup(t, g) == false and IsUnitType(t, UNIT_TYPE_STRUCTURE) == false then
            if IsUnitType(t, UNIT_TYPE_HERO) then
                call SaveInteger(ObjectHashTable, XK[0], 4, LoadInteger(ObjectHashTable, XK[0], 4) + 1)
            else
                call SaveInteger(ObjectHashTable, XK[0], 3, LoadInteger(ObjectHashTable, XK[0], 3) + 1)
            endif
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\AbsorbMana\\AbsorbManaBirthMissile.mdl", t, "chest"))
            call UnitDamageTargetEx(Temp__ArrayUnit[0], t, 1, XK[1])
            call GroupAddUnit(g, t)
        endif
        set g = null
        set t = null
        return false
    endfunction
    function AVI takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer h = GetHandleId(t)
        local integer i3
        local integer i2
        local integer i1
        local unit u = LoadUnitHandle(ObjectHashTable, h, 0)
        local unit d = LoadUnitHandle(ObjectHashTable, h, 1)
        local real x2 = GetWidgetX(u)
        local real y2 = GetWidgetY(u)
        local real x1 = GetWidgetX(d)
        local real y1 = GetWidgetY(d)
        local real I3X = Atan2(y2 -y1, x2 -x1)
        if LoadBoolean(ObjectHashTable, GetHandleId(d),'A1AA') then
            set d = null
            set u = null
            set t = null
            return
        endif
        set x1 = x1 + 15* Cos(I3X)
        set y1 = y1 + 15* Sin(I3X)
        call SetUnitX(d, x1)
        call SetUnitY(d, y1)
        call SetUnitFacing(d, I3X * bj_RADTODEG)
        set Temp__ArrayUnit[0] = u
        set XK[0] = h
        set XK[1] = LoadInteger(ObjectHashTable, h, 2)
        call GroupEnumUnitsInRange(AK, x1, y1, 300, Condition(function I9I))
        if  100 > SquareRoot((x1 -x2)*(x1 -x2) +(y1 -y2)*(y1 -y2)) then
            set i3 = LoadInteger(ObjectHashTable, h, 1)
            set i2 = LoadInteger(ObjectHashTable, h, 3)
            set i1 = LoadInteger(ObjectHashTable, h, 4)
            if i1 + i2 > 0 then
                set x1 =(i2 + i1 * 5)
                set i3 = i2 *(3 * i3 + 3) + i1 * 10* i3
                call UnitAddAbilityLevel1ToTimed(u,'C015','C015', 9)
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\AbsorbMana\\AbsorbManaBirthMissile.mdl", u, "chest"))
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\AbsorbMana\\AbsorbManaBirthMissile.mdl", u, "origin"))
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\AbsorbMana\\AbsorbManaBirthMissile.mdl", u, "hand,left"))
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\AbsorbMana\\AbsorbManaBirthMissile.mdl", u, "hand,right"))
                call SaveInteger(ObjectHashTable, h, 3, i3)
                call SaveReal(ObjectHashTable, h, 0, x1)
                call J6X(u, R2I(x1))
                call UnitAddStateBonus(u, i3, UNIT_BONUS_DAMAGE)
                call TimerStart(t, 9, false, function I8I)
            else
                call DestroyTimerAndFlushHT_P(t)
            endif
            set h = GetHandleId(u)
            set i1 = LoadInteger(ObjectHashTable, h,'A1A8')
            call SaveInteger(ObjectHashTable, h,'A1A8', i1 -1)
            if i1 == 1 then
                call ToggleSkill.SetState(u, 'A1A8', false)
            endif
            call FlushChildHashtable(ObjectHashTable, GetHandleId(d))
            call RemoveUnit(d)
        endif
        set d = null
        set u = null
        set t = null
    endfunction
    function AEI takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer h = GetHandleId(t)
        local integer UYX = LoadInteger(ObjectHashTable, h, 0)
        local unit u = LoadUnitHandle(ObjectHashTable, h, 0)
        local unit d = LoadUnitHandle(ObjectHashTable, h, 1)
        local real x = GetWidgetX(d)
        local real y = GetWidgetY(d)
        set Temp__ArrayUnit[0] = u
        set XK[0] = h
        set XK[1] = LoadInteger(ObjectHashTable, h, 2)
        call GroupEnumUnitsInRange(AK, x, y, 300, Condition(function I9I))
        // 'A1A8' == 发动返回技能
        if UYX == 80 or LoadBoolean(ObjectHashTable, GetHandleId(u),'A1A8') or LoadBoolean(ObjectHashTable, GetHandleId(d),'A1A8') then
            
            call UnitAddAbility(d,'Aloc')
            call SetUnitAnimationByIndex(d, 1)
            call IssueImmediateOrderById(d, 851972)
            call SaveBoolean(ObjectHashTable, h, 0, true)
            call TimerStart(t, .025, true, function AVI)
            set d = null
            set u = null
            set t = null
            return
        endif
        call SetUnitMoveSpeed(d, GetHeroMoveSpeed(u))
        call SaveInteger(ObjectHashTable, h, 0, UYX + 1)
        set d = null
        set u = null
        set t = null
    endfunction
    
    function AncestralSpiritReturnOnSpellEffect takes nothing returns nothing
        local timer t = CreateTimer()
        local unit  u = GetTriggerUnit()
        call SaveUnitHandle(ObjectHashTable, GetHandleId(t), 0, u)
        call SaveBoolean(ObjectHashTable, GetHandleId(u),'A1A8', true)
        
        set t = null
        set u = null
    endfunction
    function AncestralSpiritOnSpellEffect takes nothing returns nothing
        local timer t = CreateTimer()
        local unit u = GetTriggerUnit()
        local player p = GetOwningPlayer(u)
        local unit d = CreateUnit(p,'h07U', GetSpellTargetX(), GetSpellTargetY(), GetUnitFacing(u) -180)
        local integer h = GetHandleId(t)
        local integer abilLevel = GetUnitAbilityLevel(u,'A1A8')
        local integer id
        call UnitAddAbility(d,'Aloc')
        call UnitRemoveAbility(d,'Aloc')
        call ShowUnit(d, false)
        call ShowUnit(d, true)
        call SaveBoolean(ObjectHashTable, h, 0, false)
        call SaveUnitHandle(ObjectHashTable, h, 0, u)
        call SaveUnitHandle(ObjectHashTable, h, 1, d)
        call SaveGroupHandle(ObjectHashTable, h, 2, AllocationGroup(273))
        call SaveInteger(ObjectHashTable, h, 0, 0)
        call SaveInteger(ObjectHashTable, h, 1, abilLevel)
        call SaveInteger(ObjectHashTable, h, 2, 20 + 40 * abilLevel)
        call SaveInteger(ObjectHashTable, h, 3, 0)
        call SaveInteger(ObjectHashTable, h, 4, 0)
        set h = GetHandleId(u)
        call SaveBoolean(ObjectHashTable, h,'A1A8', false)
        call SaveInteger(ObjectHashTable, h,'A1A8', LoadInteger(ObjectHashTable, h,'A1A8') + 1)
        call SaveUnitHandle(ObjectHashTable, h,'A1A8', d)

        call ToggleSkill.SetState(u, 'A1A8', true)
        
        call TriggerRegisterUnitEvent(UnitEventMainTrig, d, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(UnitEventMainTrig, d, EVENT_UNIT_SPELL_CAST)

        // 同步先祖之魂技能
        call UnitAddAbility(d,'A21J')
        call UnitAddAbility(d,'Aetl')
        if GetUnitAbilityLevel(u,'A1AA')> 0 then
            call UnitAddAbility(d,'A2LK')
        endif
        if GetUnitAbilityLevel(u,'A1CD')> 0 then
            call UnitAddPermanentAbility(d,'A1CQ')
        endif
        call SaveUnitHandle(ObjectHashTable, GetHandleId(d),'A1A8', u)
        call TimerStart(t, .1, true, function AEI)
        set d = null
        set u = null
        set t = null
        set p = null
    endfunction
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
        call DestroyTrigger(t)
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
            call KillTreeByCircle(x, y, 300)

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
            if upgradeLevel > 0 and IsUnitDeath(first) == false then
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
        call CreateFogModifierTimedForPlayer(GetOwningPlayer(whichUnit), 4, x, y, 500)
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
            call DestroyTrigger(t)
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
