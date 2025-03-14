scope TemplarAssassin

    globals
        constant integer HERO_INDEX_TEMPLAR_ASSASSIN = 43
    endglobals
    //***************************************************************************
    //*
    //*  灵能陷阱
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_PSIONIC_TRAP         = GetHeroSKillIndexBySlot(HERO_INDEX_TEMPLAR_ASSASSIN, 4)
        constant integer TEMPLAR_ASSASSIN_TRAP_ABILITY_ID = 'A0RQ'
    endglobals

    function PsionicTrapOnAdd takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        if not IsUnitType(whichUnit, UNIT_TYPE_HERO) then
            set whichUnit = null
            return
        endif
        call UnitAddPermanentAbility(whichUnit, TEMPLAR_ASSASSIN_TRAP_ABILITY_ID)
        set whichUnit = null
    endfunction
    function PsionicTrapOnRemove takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        if not IsUnitType(whichUnit, UNIT_TYPE_HERO) then
            set whichUnit = null
            return
        endif
        call UnitRemoveAbility(whichUnit, TEMPLAR_ASSASSIN_TRAP_ABILITY_ID)
        set whichUnit = null
    endfunction
    
    function B0I takes nothing returns boolean
        local unit t = GetFilterUnit()
        if UnitAlive(t) and IsUnitEnemy(Temp__ArrayUnit[0], GetOwningPlayer(t)) and not IsUnitWard(t) and IsUnitType(t, UNIT_TYPE_STRUCTURE) == false and(IsUnitType(t, UNIT_TYPE_ANCIENT) == false or DRX(t)) then
            call UnitAddAbilityLevel1ToTimed(t, XK[0],'B08M', 5)
            call UnitDamageTargetEx(TempUnit, t, 3, 75)
        endif
        set t = null
        return false
    endfunction
    function B1I takes nothing returns boolean
        local unit t = GetFilterUnit()
        local real d
        local real x
        local real y
        if GetUnitTypeId(t)=='e020' and GetWidgetLife(t)> .405 then
            set x = GetWidgetX(t)-Temp__ArrayReal[1]
            set y = GetWidgetY(t)-Temp__ArrayReal[2]
            set d = SquareRoot(x * x + y * y)
            if Temp__ArrayReal[0]> d then
                set Temp__ArrayUnit[0] = t
                set Temp__ArrayReal[0] = d
            endif
        endif
        set t = null
        return false
    endfunction
    function B2Izi takes nothing returns boolean
        local unit t = GetFilterUnit()
        local integer i
        if GetUnitTypeId(t)=='e020' and GetWidgetLife(t)> .405 then
            set i = LoadInteger(ObjectHashTable, GetHandleId(t), 2)
            if XK[0]== 0 or XK[1]> i then
                set XK[1] = i
                set Temp__ArrayUnit[0] = t
            endif
            set XK[0] = XK[0] + 1
        endif
        set t = null
        return false
    endfunction
    function B3I takes player p, integer WOV returns nothing
        set XK[0] = 0
        call GroupEnumUnitsOfPlayer(AK, p, Condition(function B2Izi))
        if XK[0]> WOV then
            call RemoveUnit(Temp__ArrayUnit[0])
        endif
    endfunction
    function YJV takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local player p = GetOwningPlayer(u)
        local integer hu = GetHandleId(u)
        local integer UYX = LoadInteger(ObjectHashTable, hu,'A0RP')
        local real x
        local real y
        if GetUnitTypeId(u)=='e020'then
            set Temp__ArrayUnit[0] = u
            set XK[0] = LoadInteger(ObjectHashTable, hu, 1) +'A510'
            set u = LoadUnitHandle(ObjectHashTable, hu, 0)
            set hu = GetHandleId(u)
            set UYX = LoadInteger(ObjectHashTable, hu,'A0RP')
        else
            set Temp__ArrayUnit[0] = null
            set Temp__ArrayReal[0] = 99999
            set Temp__ArrayReal[1] = GetWidgetX(u)
            set Temp__ArrayReal[2] = GetWidgetY(u)
            call GroupEnumUnitsOfPlayer(AK, p, Condition(function B1I))
            if Temp__ArrayUnit[0]== null then
                set u = null
                return
            endif
            set XK[0] = LoadInteger(ObjectHashTable, GetHandleId(Temp__ArrayUnit[0]), 1) +'A510'
        endif
        set x = GetWidgetX(Temp__ArrayUnit[0])
        set y = GetWidgetY(Temp__ArrayUnit[0])
        set TempUnit = PlayerHeroes[GetPlayerId(GetOwningPlayer(u))]
        call GroupEnumUnitsInRange(AK, x, y, 400, Condition(function B0I))
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl", x, y))
        call RemoveUnit(LoadUnitHandle(ObjectHashTable, GetHandleId(Temp__ArrayUnit[0]), 1))
        call RemoveUnit(Temp__ArrayUnit[0])
        set p = null
        set u = null
    endfunction
    function B4I takes unit u returns nothing
        if GetUnitTypeId(u)=='e020'then
            call YJV()
        endif
    endfunction
    function WJA takes nothing returns nothing
        call B4I(UEDyingUnit)
    endfunction
    function PsionicTrapOnInitializer takes nothing returns nothing
        call RegisterUnitDeathMethod("WJA")
    endfunction

    function PsionicTrapOnSpellEffect takes nothing returns nothing
        local timer t
        local unit u = GetTriggerUnit()
        local player p = GetOwningPlayer(u)
        local unit d = CreateUnit(p,'e020', GetSpellTargetX(), GetSpellTargetY(), 0)
        local integer hu = GetHandleId(u)
        local integer h = LoadInteger(ObjectHashTable, hu,'A0RP')
        local integer WOV = 2 + 3 *(GetUnitAbilityLevel(u,'A0RP') + GetUnitAbilityLevel(u,'A449'))
        local boolean b = GetUnitAbilityLevel(u,'A449')> 0
        local unit du
        call SaveInteger(ObjectHashTable, hu,'A0RP', h + 1)
        set hu = GetHandleId(d)
        call SaveUnitHandle(ObjectHashTable, hu, 0, u)
        call SaveInteger(ObjectHashTable, hu, 0, 0)
        call SaveInteger(ObjectHashTable, hu, 1, 0)
        call SaveInteger(ObjectHashTable, hu, 2, h)
        call TriggerRegisterUnitEvent(UnitEventMainTrig, d, EVENT_UNIT_SPELL_EFFECT)
        call B3I(p, WOV)
        call W1E(d)
        if b then
            call SaveInteger(ObjectHashTable, hu, 1, 4)
            set du = CreateUnit(p,'e01V', GetSpellTargetX(), GetSpellTargetY(), 0)
            call UnitAddAbility(du,'A44B')
            call SaveUnitHandle(ObjectHashTable, hu, 1, du)
            set du = null
        else
            set t = CreateTimer()
            set h = GetHandleId(t)
            call SaveInteger(ObjectHashTable, h, 0, 0)
            call SaveInteger(ObjectHashTable, h, 1, hu)
            call SaveUnitHandle(ObjectHashTable, h, 0, d)
            call TimerStart(t, 1, true, function B_I)
        endif
        set d = null
        set p = null
        set u = null
        set t = null
    endfunction

endscope
