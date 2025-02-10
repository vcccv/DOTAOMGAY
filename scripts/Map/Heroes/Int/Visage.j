
scope Visage

    //***************************************************************************
    //*
    //*  召唤佣兽
    //*
    //***************************************************************************

    function ADA takes nothing returns nothing
        local integer level
        local unit whichUnit = GetTriggerUnit()
        local unit dummyCaster
        if GetUnitTypeId(whichUnit)=='u017' or GetUnitTypeId(whichUnit)=='u019' or GetUnitTypeId(whichUnit)=='u018' or GetUnitTypeId(whichUnit)=='u01A' or GetUnitTypeId(whichUnit)=='u01B' or GetUnitTypeId(whichUnit)=='u01C' or GetUnitTypeId(whichUnit)=='u01U' or GetUnitTypeId(whichUnit)=='u01V' or GetUnitTypeId(whichUnit)=='u01W' then
            return
        endif
        set dummyCaster = CreateUnit(GetOwningPlayer(whichUnit),'e00E', GetUnitX(whichUnit), GetUnitY(whichUnit), 0)
        if GetUnitTypeId(whichUnit)=='u014' or GetUnitTypeId(whichUnit)=='u01D' or GetUnitTypeId(whichUnit)=='u01R' then
            set level = 1
        elseif GetUnitTypeId(whichUnit)=='u015' or GetUnitTypeId(whichUnit)=='u01E' or GetUnitTypeId(whichUnit)=='u01S' then
            set level = 2
        else
            set level = 3
        endif
        call UnitAddPermanentAbility(dummyCaster,'A1NF')
        call SetUnitAbilityLevel(dummyCaster,'A1NF', level)
        call IssueImmediateOrderById(dummyCaster, 852127)
        set whichUnit = null
        set dummyCaster = null
    endfunction
    globals
        private key FAMILIAR_ATTACK_DAMAGE_BONUS
    endglobals
    function FamiliarAddAttack takes unit familiarUnit, integer attackDamage, integer level returns nothing
        local integer attackCount
        local integer bonus
        if familiarUnit == null then
            return
        endif
        set bonus = Table[GetHandleId(familiarUnit)].integer[FAMILIAR_ATTACK_DAMAGE_BONUS]
        call UnitReduceStateBonus(familiarUnit, bonus, UNIT_BONUS_DAMAGE)
        if level == 1 then
            set attackCount = 8
        elseif level == 2 then
            set attackCount = 14
        elseif level == 3 then
            set attackCount = 22
        endif
        set bonus = attackDamage * attackCount
        set Table[GetHandleId(familiarUnit)].integer[FAMILIAR_ATTACK_DAMAGE_BONUS] = bonus
        call UnitAddStateBonus(familiarUnit, bonus, UNIT_BONUS_DAMAGE)
    endfunction
    function AJA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit familiarUnit =(LoadUnitHandle(HY, h, 2))
        local unit whichUnit = familiarUnit
        local integer level =(LoadInteger(HY, h, 5))
        local integer S4R =(LoadInteger(HY, h, 28))
        local integer Y2X =(LoadInteger(HY, h, 194))
        if GetTriggerEventId() == EVENT_WIDGET_DEATH then
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        elseif GetTriggerEventId() == EVENT_PLAYER_UNIT_ATTACKED then
            if GetAttacker() == familiarUnit then
                set Y2X = IMaxBJ(Y2X -1, 0)
                call SaveInteger(HY, h, 194,(Y2X))
                call FamiliarAddAttack(familiarUnit, Y2X, level)
            endif
        else
            set S4R = S4R + 1
            call SaveInteger(HY, h, 28,(S4R))
            if ModuloInteger(S4R, 15) == 0 then
                set Y2X = IMinBJ(Y2X + 1, 7)
                call SaveInteger(HY, h, 194,(Y2X))
            endif
            if GetUnitTypeId(whichUnit)=='u017' or GetUnitTypeId(whichUnit)=='u019' or GetUnitTypeId(whichUnit)=='u018' or GetUnitTypeId(whichUnit)=='u01A' or GetUnitTypeId(whichUnit)=='u01B' or GetUnitTypeId(whichUnit)=='u01C' or GetUnitTypeId(whichUnit)=='u01U' or GetUnitTypeId(whichUnit)=='u01V' or GetUnitTypeId(whichUnit)=='u01W' then
                set Y2X = 7
                call SaveInteger(HY, h, 194,(Y2X))
            endif
            call FamiliarAddAttack(familiarUnit, Y2X, level)
            if GetUnitTypeId(familiarUnit)=='u017' or GetUnitTypeId(familiarUnit)=='u019' or GetUnitTypeId(familiarUnit)=='u018' or GetUnitTypeId(familiarUnit)=='u01A' or GetUnitTypeId(familiarUnit)=='u01B' or GetUnitTypeId(familiarUnit)=='u01C' or GetUnitTypeId(familiarUnit)=='u01U' or GetUnitTypeId(familiarUnit)=='u01V' or GetUnitTypeId(familiarUnit)=='u01W' then
                call SetWidgetLife(familiarUnit, GetWidgetLife(familiarUnit)+ 31.25 + 18.75 * level)
            endif
        endif
        set t = null
        set familiarUnit = null
        set whichUnit = null
        return false
    endfunction
    function AKA takes nothing returns boolean
        if GetUnitTypeId(GetFilterUnit())=='u014' or GetUnitTypeId(GetFilterUnit())=='u015' or GetUnitTypeId(GetFilterUnit())=='u016' or GetUnitTypeId(GetFilterUnit())=='u01D' or GetUnitTypeId(GetFilterUnit())=='u01E' or GetUnitTypeId(GetFilterUnit())=='u01F' or GetUnitTypeId(GetFilterUnit())=='u01R' or GetUnitTypeId(GetFilterUnit())=='u01S' or GetUnitTypeId(GetFilterUnit())=='u01T' or GetUnitTypeId(GetFilterUnit())=='u017' or GetUnitTypeId(GetFilterUnit())=='u019' or GetUnitTypeId(GetFilterUnit())=='u018' or GetUnitTypeId(GetFilterUnit())=='u01A' or GetUnitTypeId(GetFilterUnit())=='u01B' or GetUnitTypeId(GetFilterUnit())=='u01C' or GetUnitTypeId(GetFilterUnit())=='u01U' or GetUnitTypeId(GetFilterUnit())=='u01V' or GetUnitTypeId(GetFilterUnit())=='u01W' then
            call KillUnit(GetFilterUnit())
        endif
        return false
    endfunction
    function FamiliarsOnSpellEffect takes nothing returns nothing
        local group g = AllocationGroup(409)
        local unit whichUnit = GetTriggerUnit()
        local real x = GetUnitX(whichUnit)
        local real y = GetUnitY(whichUnit)
        local integer level = GetUnitAbilityLevel(whichUnit,'A1NE')
        local unit familiar1
        local unit familiar2
        local unit familiar3 = null
        local trigger t
        local integer h
        local boolean isUpgrade = false
        local integer i
        call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(whichUnit), Condition(function AKA))
        call DeallocateGroup(g)
        if level == 0 then
            set level = GetUnitAbilityLevel(whichUnit,'A2IG')
            set isUpgrade = true
        endif
        if level == 1 then
            set familiar1 = CreateUnit(GetOwningPlayer(whichUnit),'u014', x + 75, y + 75, GetUnitFacing(whichUnit))
            set familiar2 = CreateUnit(GetOwningPlayer(whichUnit),'u01D', x -75, y -75, GetUnitFacing(whichUnit))
        elseif level == 2 then
            set familiar1 = CreateUnit(GetOwningPlayer(whichUnit),'u015', x + 75, y + 75, GetUnitFacing(whichUnit))
            set familiar2 = CreateUnit(GetOwningPlayer(whichUnit),'u01E', x -75, y -75, GetUnitFacing(whichUnit))
        elseif level == 3 then
            set familiar1 = CreateUnit(GetOwningPlayer(whichUnit),'u016', x + 75, y + 75, GetUnitFacing(whichUnit))
            set familiar2 = CreateUnit(GetOwningPlayer(whichUnit),'u01F', x -75, y -75, GetUnitFacing(whichUnit))
        endif
        set i = GetUnitAbilityLevel(whichUnit,'A0A8')
        call SelectUnitAddForPlayer(familiar1, GetOwningPlayer(whichUnit))
        call SelectUnitAddForPlayer(familiar2, GetOwningPlayer(whichUnit))
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\RaiseSkeletonWarrior\\RaiseSkeleton.mdl", familiar1, "origin"))
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\RaiseSkeletonWarrior\\RaiseSkeleton.mdl", familiar2, "origin"))
        set t = CreateTrigger()
        set h = GetHandleId(t)
        call TriggerRegisterAnyUnitEvent(t, EVENT_PLAYER_UNIT_ATTACKED)
        call TriggerRegisterTimerEvent(t, 1, true)
        call TriggerRegisterDeathEvent(t, familiar1)
        call TriggerAddCondition(t, Condition(function AJA))
        call SaveUnitHandle(HY, h, 2,(familiar1))
        call SaveInteger(HY, h, 5,(level))
        call SaveInteger(HY, h, 28, 0)
        call SaveInteger(HY, h, 194, 7)
        call FamiliarAddAttack(familiar1, 7, level)
        set t = CreateTrigger()
        set h = GetHandleId(t)
        call TriggerRegisterAnyUnitEvent(t, EVENT_PLAYER_UNIT_ATTACKED)
        call TriggerRegisterTimerEvent(t, 1, true)
        call TriggerRegisterDeathEvent(t, familiar2)
        call TriggerAddCondition(t, Condition(function AJA))
        call SaveUnitHandle(HY, h, 2,(familiar2))
        call SaveInteger(HY, h, 5,(level))
        call SaveInteger(HY, h, 28, 0)
        call SaveInteger(HY, h, 194, 7)
        call FamiliarAddAttack(familiar2, 7, level)
        if isUpgrade then
            if level == 1 then
                set familiar3 = CreateUnit(GetOwningPlayer(whichUnit),'u01R', x + 75, y, GetUnitFacing(whichUnit))
            elseif level == 2 then
                set familiar3 = CreateUnit(GetOwningPlayer(whichUnit),'u01S', x + 75, y, GetUnitFacing(whichUnit))
            elseif level == 3 then
                set familiar3 = CreateUnit(GetOwningPlayer(whichUnit),'u01T', x + 75, y, GetUnitFacing(whichUnit))
            endif
            call SelectUnitAddForPlayer(familiar3, GetOwningPlayer(whichUnit))
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\RaiseSkeletonWarrior\\RaiseSkeleton.mdl", familiar3, "origin"))
            set t = CreateTrigger()
            set h = GetHandleId(t)
            call TriggerRegisterAnyUnitEvent(t, EVENT_PLAYER_UNIT_ATTACKED)
            call TriggerRegisterTimerEvent(t, 1, true)
            call TriggerRegisterDeathEvent(t, familiar3)
            call TriggerAddCondition(t, Condition(function AJA))
            call SaveUnitHandle(HY, h, 2,(familiar3))
            call SaveInteger(HY, h, 5,(level))
            call SaveInteger(HY, h, 28, 0)
            call SaveInteger(HY, h, 194, 7)
            call FamiliarAddAttack(familiar3, 7, level)
        endif
        if i > 0 then
            call RGX(familiar1, i)
            call RGX(familiar2, i)
            call RGX(familiar3, i)
        endif
        set g = null
        set whichUnit = null
        set familiar1 = null
        set familiar2 = null
        set familiar3 = null
        set t = null
    endfunction

    function AQA takes nothing returns boolean
        if GetSpellAbilityId()=='A1NB' or GetSpellAbilityId()=='A1NC' or GetSpellAbilityId()=='A1ND' or GetSpellAbilityId()=='A1NL' or GetSpellAbilityId()=='A1NM' or GetSpellAbilityId()=='A1NN' or GetSpellAbilityId()=='A2IZ' or GetSpellAbilityId()=='A2J0' or GetSpellAbilityId()=='A2J1' then
            call ADA()
        endif
        return false
    endfunction
    function PEX takes nothing returns nothing
        local trigger t = CreateTrigger()
        call TriggerRegisterAnyUnitEvent(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(t, Condition(function AQA))
        set t = null
    endfunction

endscope
