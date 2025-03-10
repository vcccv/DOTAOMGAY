
scope Terrorblade

    //***************************************************************************
    //*
    //*  灵魂汲取
    //*
    //***************************************************************************
    function RJA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local unit targetUnit =(LoadUnitHandle(HY, h, 17))
        local unit d =(LoadUnitHandle(HY, h, 19))
        local integer level =(LoadInteger(HY, h, 5))
        local real range = 600. + GetUnitCastRangeBonus(whichUnit)
        if GetTriggerEventId() == EVENT_WIDGET_DEATH or GetTriggerEvalCount(t)> 28 or IsUnitSilenced(whichUnit) or GetUnitDistanceEx(whichUnit, targetUnit)> range or IsUnitVisibleToPlayer(targetUnit, GetOwningPlayer(whichUnit)) == false then
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            call KillUnit(d)
        elseif GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
            if GetTriggerEvalCount(t)> 1 and GetSpellAbilityId()=='A1RA' then
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
                call UnitRemoveAbility(whichUnit,'A1RA')
                call KillUnit(d)
            endif
        else
            if IsUnitEnemy(whichUnit, GetOwningPlayer(targetUnit)) then
                call SetWidgetLife(whichUnit, GetWidgetLife(whichUnit) + level * 25. / 4.)
            else
                call SetWidgetLife(targetUnit, GetWidgetLife(targetUnit) + level * 25. / 4.)
            endif
        endif
        set t = null
        set whichUnit = null
        set targetUnit = null
        set d = null
        return false
    endfunction

    function RKA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local unit targetUnit =(LoadUnitHandle(HY, h, 17))
        local unit d =(LoadUnitHandle(HY, h, 19))
        local boolean b = HaveSavedHandle(HY, h, 21)
        if GetTriggerEventId() == EVENT_WIDGET_DEATH then
            call UnitRemoveAbility(whichUnit,'A1RA')
            if b then
                call RemoveUnit(LoadUnitHandle(HY, h, 21))
            endif
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        else
            if GetTriggerEvalCount(t) == 1 then
                call IssueImmediateOrderById(whichUnit, 851993)
            endif
            if IsUnitEnemy(whichUnit, GetOwningPlayer(targetUnit)) then
                call SetUnitX(d, GetUnitX(whichUnit))
                call SetUnitY(d, GetUnitY(whichUnit))
                call SetUnitX(LoadUnitHandle(HY, h, 21), GetUnitX(targetUnit))
                call SetUnitY(LoadUnitHandle(HY, h, 21), GetUnitY(targetUnit))
            else
                call SetUnitX(d, GetUnitX(targetUnit))
                call SetUnitY(d, GetUnitY(targetUnit))
            endif
        endif
        set t = null
        set whichUnit = null
        set targetUnit = null
        set d = null
        return false
    endfunction
    function RLA takes nothing returns nothing
        local unit whichUnit = GetTriggerUnit()
        local unit targetUnit = GetSpellTargetUnit()
        local integer level = GetUnitAbilityLevel(whichUnit,'A1PH')
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit d
        if GetUnitTypeId(whichUnit)=='e00E' then
            if HaveSavedHandle(HY, GetHandleId(whichUnit), 0) then
                set whichUnit = LoadUnitHandle(HY, GetHandleId(whichUnit), 0)
            else
                set whichUnit = PlayerHeroes[GetPlayerId(GetOwningPlayer(whichUnit))]
            endif
        endif
        if IsUnitEnemy(whichUnit, GetOwningPlayer(targetUnit)) then
            set d = CreateUnit(GetOwningPlayer(whichUnit),'u01G', 0, 0, 0)
            call UnitAddAbility(d,'A04L')
            call SetUnitAbilityLevel(d,'A04L', level)
            call SetUnitX(d, GetUnitX(whichUnit))
            call SetUnitY(d, GetUnitY(whichUnit))
            call IssueTargetOrderById(d, 852487, targetUnit)
        else
            call UnitAddPermanentAbility(whichUnit,'A1RA')
            set d = CreateUnit(NeutralCreepPlayer,'u01G', 0, 0, 0)
            call SetUnitUserData(d, GetPlayerId(GetOwningPlayer(whichUnit)))
            call UnitAddAbility(d,'A04L')
            call SetUnitAbilityLevel(d,'A04L', level)
            call SetUnitX(d, GetUnitX(targetUnit))
            call SetUnitY(d, GetUnitY(targetUnit))
            call U1V(d, 852487, whichUnit)
        endif
        call TriggerRegisterTimerEvent(t, .25, true)
        call TriggerRegisterDeathEvent(t, whichUnit)
        call TriggerRegisterDeathEvent(t, targetUnit)
        call TriggerRegisterUnitEvent(t, whichUnit, EVENT_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(t, Condition(function RJA))
        call SaveUnitHandle(HY, h, 2,(whichUnit))
        call SaveUnitHandle(HY, h, 17,(targetUnit))
        call SaveUnitHandle(HY, h, 19,(d))
        call SaveInteger(HY, h, 5,(level))
        set t = CreateTrigger()
        set h = GetHandleId(t)
        call TriggerRegisterTimerEvent(t, .01, true)
        call TriggerRegisterDeathEvent(t, d)
        call TriggerAddCondition(t, Condition(function RKA))
        call SaveUnitHandle(HY, h, 2,(whichUnit))
        call SaveUnitHandle(HY, h, 17,(targetUnit))
        call SaveUnitHandle(HY, h, 19,(d))
        if IsUnitEnemy(targetUnit, GetOwningPlayer(whichUnit)) then
            call SaveUnitHandle(HY, h, 21, CreateUnit(GetOwningPlayer(whichUnit),'hBST', GetUnitX(targetUnit), GetUnitY(targetUnit), 0))
        endif
        set whichUnit = null
        set targetUnit = null
        set t = null
        set d = null
    endfunction
    function SoulStealOnSpellEffect takes nothing returns boolean
        if GetUnitTypeId(GetSpellTargetUnit())!='n00L' and(IsUnitAlly(GetSpellTargetUnit(), GetOwningPlayer(GetTriggerUnit())) or(not UnitHasSpellShield(GetSpellTargetUnit()))) then
            call RLA()
        endif
        return false
    endfunction

    //***************************************************************************
    //*
    //*  魔法镜像
    //*
    //***************************************************************************
    function ConjureImageOnSpellEffect takes nothing returns nothing
        local unit    whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local integer level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real    angle     = GetUnitFacing(whichUnit) * bj_DEGTORAD
        local real    vel       = GetUnitCollisionSize(whichUnit) * 0.5 + 64.
        local real    x         = GetUnitX(whichUnit) + vel * Cos(angle)
        local real    y         = GetUnitY(whichUnit) + vel * Sin(angle)
        local unit    illusionUnit
        local real    damageDealt
        local real    damageTaken
        local real    duration

        set damageDealt = 0.2 + 0.1 * level
        set damageTaken = 3.0
        set duration    = 32.
        if not IsUnitType(whichUnit, UNIT_TYPE_MELEE_ATTACKER) then
            set damageDealt = 0.1 + 0.1 * level
            set damageTaken = 3.5
            call MHAbility_SetAbilityCustomLevelDataReal(GetSpellAbility(), level, ABILITY_LEVEL_DEF_DATA_COOLDOWN, 20.)
        else
            call MHAbility_SetAbilityCustomLevelDataReal(GetSpellAbility(), level, ABILITY_LEVEL_DEF_DATA_COOLDOWN, 16.)
        endif
        set illusionUnit = CreateIllusion(GetOwningPlayer(whichUnit), whichUnit, damageDealt, damageTaken, x, y, 'Btbi', duration)
        call SetUnitVertexColor(illusionUnit, 150, 150, 150, 200) 

        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\AIil\\AIilTarget.mdl", illusionUnit, "origin"))

        set illusionUnit = null
        set whichUnit = null
    endfunction
    
endscope
