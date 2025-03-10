
scope Tuskarr

    globals
        constant integer HERO_INDEX_TUSKARR = 50
    endglobals
    //***************************************************************************
    //*
    //*  寒冰片
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_ICE_SHARDS = GetHeroSKillIndexBySlot(HERO_INDEX_PHOENIX, 1)
    endglobals
    function HDA takes unit whichUnit, unit targetUnit, real sx, real sy, real a2 returns nothing
        local integer i = 0
        local real tx
        local real ty
        local real a
        local real x
        local real y
        local real HFA
        set a = a2
        set tx = sx + 50 * Cos(a * bj_DEGTORAD)
        set ty = sy + 50 * Sin(a * bj_DEGTORAD)
        set HFA = a
        set x = tx + 200* Cos(HFA * bj_DEGTORAD)
        set y = ty + 200* Sin(HFA * bj_DEGTORAD)
        call RemoveDestructableTimed(CreateDestructable('B006', x, y,-1 * HFA, .6, 1), 7)
        call KillTreeByCircle(x, y, 300)
        set HFA = a -40
        set x = tx + 200* Cos(HFA * bj_DEGTORAD)
        set y = ty + 200* Sin(HFA * bj_DEGTORAD)
        call RemoveDestructableTimed(CreateDestructable('B006', x, y,-1 * HFA, .6, 1), 7)
        call KillTreeByCircle(x, y, 300)
        set HFA = a -80
        set x = tx + 200* Cos(HFA * bj_DEGTORAD)
        set y = ty + 200* Sin(HFA * bj_DEGTORAD)
        call RemoveDestructableTimed(CreateDestructable('B006', x, y,-1 * HFA, .6, 1), 7)
        call KillTreeByCircle(x, y, 300)
        set HFA = a + 40
        set x = tx + 200* Cos(HFA * bj_DEGTORAD)
        set y = ty + 200* Sin(HFA * bj_DEGTORAD)
        call RemoveDestructableTimed(CreateDestructable('B006', x, y,-1 * HFA, .6, 1), 7)
        call KillTreeByCircle(x, y, 300)
        set HFA = a + 80
        set x = tx + 200* Cos(HFA * bj_DEGTORAD)
        set y = ty + 200* Sin(HFA * bj_DEGTORAD)
        call RemoveDestructableTimed(CreateDestructable('B006', x, y,-1 * HFA, .6, 1), 7)
        call KillTreeByCircle(x, y, 300)
    endfunction
    function HGA takes nothing returns nothing
        if IsUnitInGroup(GetEnumUnit(), P3V) == false then
            call GroupAddUnit(P3V, GetEnumUnit())
            call DestroyEffect(AddSpecialEffectTarget("war3mapImported\\ChainFreeze_F6.mdx", GetEnumUnit(), "chest"))
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl", GetEnumUnit(), "chest"))
            call UnitDamageTargetEx(P1V, GetEnumUnit(), 1, P2V * 70)
        endif
    endfunction
    function HHA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = LoadUnitHandle(HY, h, 2)
        local unit targetUnit = LoadUnitHandle(HY, h, 17)
        local unit HJA = LoadUnitHandle(HY, h, 45)
        local real HKA = LoadReal(HY, h, 683)
        local real HLA = LoadReal(HY, h, 684)
        local real sx = GetUnitX(HJA)
        local real sy = GetUnitY(HJA)
        local real I3X = Atan2(HLA -sy, HKA -sx)
        local real nx = sx + 22 * Cos(I3X)
        local real ny = sy + 22 * Sin(I3X)
        local group gg = LoadGroupHandle(HY, h, 133)
        local integer level = LoadInteger(HY, h, 0)
        local group g = AllocationGroup(450)
        set TempUnit = whichUnit
        set P1V = whichUnit
        set P3V = gg
        set P2V = level
        call GroupEnumUnitsInRange(g, nx, ny, 225, Condition(function DJX))
        call ForGroup(g, function HGA)
        call DeallocateGroup(g)
        call SetUnitPosition(HJA, nx, ny)
        if GetDistanceBetween(nx, ny, HKA, HLA)< 40 then
            call KillUnit(HJA)
            call SetUnitPathing(HJA, true)
            call HDA(whichUnit, null, nx, ny, I3X * bj_RADTODEG)
            call DeallocateGroup(gg)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        endif
        set whichUnit = null
        set targetUnit = null
        set t = null
        set HJA = null
        set gg = null
        set g = null
        return false
    endfunction
    function IceShardsOnSpellEffect takes nothing returns nothing
        local unit whichUnit = GetTriggerUnit()
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit HJA = CreateUnit(GetOwningPlayer(whichUnit),'h0CS', GetUnitX(whichUnit), GetUnitY(whichUnit), 0)
        local real sx = GetUnitX(whichUnit)
        local real sy = GetUnitY(whichUnit)
        local real tx = GetSpellTargetX()
        local real ty = GetSpellTargetY()
        local real I3X = Atan2(ty -sy, tx -sx)
        local real HKA = CoordinateX50(tx)
        local real HLA = CoordinateY50(ty)
        call SetUnitFacing(HJA, I3X * bj_RADTODEG)
        call SetUnitPathing(HJA, false)
        call TriggerRegisterTimerEvent(t, .02, true)
        call TriggerAddCondition(t, Condition(function HHA))
        call SaveUnitHandle(HY, h, 2, whichUnit)
        call SaveReal(HY, h, 683, HKA * 1.)
        call SaveReal(HY, h, 684, HLA * 1.)
        call SaveReal(HY, h, 13, I3X * 1.)
        call SaveUnitHandle(HY, h, 45, HJA)
        call SaveInteger(HY, h, 0, GetUnitAbilityLevel(whichUnit, GetSpellAbilityId()))
        call SaveGroupHandle(HY, h, 133, AllocationGroup(451))
        set whichUnit = null
        set HJA = null
        set t = null
    endfunction
    //***************************************************************************
    //*
    //*  海象飞踢
    //*
    //***************************************************************************
    globals
        constant integer WALRUS_KICK_ABILITY_ID = 'A3DF'
    endglobals

    function WalrusPunchOnGetScepterUpgrade takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()

        if not UnitAddPermanentAbility(whichUnit, WALRUS_KICK_ABILITY_ID) then
            call UnitEnableAbility(whichUnit, WALRUS_KICK_ABILITY_ID, true)
        endif

        set whichUnit = null
    endfunction
    function WalrusPunchOnLostScepterUpgrade takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()

        call UnitDisableAbility(whichUnit, WALRUS_KICK_ABILITY_ID, true)

        set whichUnit = null
    endfunction
    
    function HWA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY,(h), 2))
        local unit targetUnit =(LoadUnitHandle(HY,(h), 17))
        local real HYA =(LoadReal(HY,(h), 6))
        local real HZA =(LoadReal(HY,(h), 7))
        local real a = LoadReal(HY, h, 1)
        local real H_A =(LoadReal(HY,(h), 23))
        local real H0A =(LoadReal(HY,(h), 24))
        local real nX
        local real nY
        local boolean X_A = false
        local real LMR = LoadReal(HY, h, 0)
        set nX = H_A + LMR * Cos(a)
        set nY = H0A + LMR * Sin(a)
        if GetDistanceBetween(nX, nY, HYA, HZA)<(5 + LMR) then
            set nX = HYA
            set nY = HZA
            set X_A = true
        endif
        set nX = CoordinateX50(nX)
        set nY = CoordinateY50(nY)
        if GetTriggerEventId() == EVENT_WIDGET_DEATH or GetUnitAbilityLevel(targetUnit,'B08V')> 0 or GetTriggerEvalCount(t)> 200 then
            set X_A = true
        else
            call SetUnitPosition(targetUnit, nX, nY)
            call SetUnitX(targetUnit, nX)
            call SetUnitY(targetUnit, nY)
            call KillTreeByCircle(nX, nY, 120)
            call SaveReal(HY,(h), 23,((nX)* 1.))
            call SaveReal(HY,(h), 24,((nY)* 1.))
        endif
        if X_A then
            call SetUnitPathing(targetUnit, true)
            call FlushChildHashtable(HY,(h))
            call DestroyTrigger(t)
        endif
        set targetUnit = null
        set t = null
        set whichUnit = null
        return false
    endfunction
    function H1A takes nothing returns nothing
        local unit targetUnit = GetSpellTargetUnit()
        local unit whichUnit = GetTriggerUnit()
        local integer level = 1
        local trigger t
        local integer h
        local real N8X
        local real x = GetUnitX(whichUnit)
        local real y = GetUnitY(whichUnit)
        local integer i =-1
        local boolean H2A = false
        local real EOX = 900
        set N8X = AngleBetweenUnit(whichUnit, targetUnit)* bj_DEGTORAD
        set t = CreateTrigger()
        set h = GetHandleId(t)
        loop
        exitwhen H2A or i == 23
            set i = i + 1
            set x = CoordinateX50(GetUnitX(targetUnit)+(EOX -i * 25)* Cos(N8X))
            set y = CoordinateY50(GetUnitY(targetUnit)+(EOX -i * 25)* Sin(N8X))
            if (IsPointInRegion(TerrainCliffRegion,((x)* 1.),((y)* 1.))) == false then
                set H2A = true
            endif
        endloop
        call SetUnitPathing(targetUnit, false)
        call TriggerRegisterTimerEvent(t, .03, true)
        call TriggerRegisterDeathEvent(t, targetUnit)
        call TriggerAddCondition(t, Condition(function HWA))
        call SaveUnitHandle(HY,(h), 2,(whichUnit))
        call SaveUnitHandle(HY,(h), 17,(targetUnit))
        call SaveReal(HY,(h), 6,((x)* 1.))
        call SaveReal(HY,(h), 7,((y)* 1.))
        call SaveReal(HY,(h), 23,((GetUnitX(targetUnit))* 1.))
        call SaveReal(HY,(h), 24,((GetUnitY(targetUnit))* 1.))
        call SaveInteger(HY,(h), 34, 0)
        call SaveReal(HY, h, 0, 900 * .03)
        call SaveReal(HY, h, 1, N8X)
        call UnitAddAbilityToTimed(targetUnit,'A3DG', 1, 5,'B3DG')
        call UnitDamageTargetEx(whichUnit, targetUnit, 1, 200)
        set targetUnit = null
        set whichUnit = null
        set t = null
    endfunction

    function WalrusKickOnSpellEffect takes nothing returns nothing
        if not UnitHasSpellShield(GetSpellTargetUnit()) then
            call H1A()
        endif
    endfunction

endscope
