
scope ShadowDemon

    //***************************************************************************
    //*
    //*  崩裂禁锢
    //*
    //***************************************************************************
    function FDA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = LoadUnitHandle(HY, h, 2)
        local unit targetUnit = LoadUnitHandle(HY, h, 17)
        local unit FFA = GetSummonedUnit()
        if GetTriggerEventId()!= EVENT_PLAYER_UNIT_SUMMON then
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        elseif GetUnitAbilityLevel(FFA,'B0DA')> 0 and GetOwningPlayer(GetSummoningUnit()) == GetOwningPlayer(whichUnit) then
            if IsUnitAlly(targetUnit, GetOwningPlayer(whichUnit)) then
                call SelectUnitAddForPlayer(FFA, GetOwningPlayer(whichUnit))
            else
                call IssueTargetOrderById(FFA, 851983, targetUnit)
            endif
        endif
        set t = null
        set whichUnit = null
        set targetUnit = null
        set FFA = null
        return false
    endfunction
    function DisruptionOnTimeout takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = LoadUnitHandle(HY, h, 2)
        local unit targetUnit = LoadUnitHandle(HY, h, 17)
        local unit dummyCaster = CreateUnit(GetOwningPlayer(whichUnit),'e00E', GetUnitX(targetUnit), GetUnitY(targetUnit), 0)
        local integer level = LoadInteger(HY, h, 0)
        call DestroyEffect(LoadEffectHandle(HY, h, 32))
        call SaveInteger(HY, GetHandleId(targetUnit), 4293, 2)

        call UnitSubInvulnerableCount(targetUnit)
        call UnitSubStunCount(targetUnit)
        call UnitSubHideExCount(targetUnit)

        call RemoveSavedHandle(HY, GetHandleId(targetUnit), 673)
        call FlushChildHashtable(HY, h)
        call DestroyTrigger(t)
        if GetTriggerEventId()!= EVENT_WIDGET_DEATH then
            call ClearSelectionForPlayer(GetOwningPlayer(targetUnit))
            call SelectUnitAddForPlayer(targetUnit, GetOwningPlayer(targetUnit))
            call A5X(AF, GetUnitX(targetUnit), GetUnitY(targetUnit))
            set t = CreateTrigger()
            set h = GetHandleId(t)
            call TriggerRegisterTimerEvent(t, 3, false)
            call TriggerRegisterPlayerUnitEventBJ(t, EVENT_PLAYER_UNIT_SUMMON)
            call TriggerAddCondition(t, Condition(function FDA))
            call SaveUnitHandle(HY, h, 2, whichUnit)
            call SaveUnitHandle(HY, h, 17, targetUnit)
            call UnitAddPermanentAbility(dummyCaster,'A1S5')
            if IsUnitIllusion(targetUnit) then
                call SaveUnitHandle(HY, GetHandleId(dummyCaster),'0ILU', LoadUnitHandle(HY, GetHandleId(targetUnit),'0ILU'))
            else
                call SaveUnitHandle(HY, GetHandleId(dummyCaster),'0ILU', targetUnit)
            endif
            call SetUnitAbilityLevel(dummyCaster,'A1S5', level)
            call IssueTargetOrderById(dummyCaster, 852274, targetUnit)
            call IssueTargetOrderById(dummyCaster, 852274, targetUnit)
        endif
        set t = null
        set whichUnit = null
        set dummyCaster = null
        set targetUnit = null
        return false
    endfunction
    function DisruptionAction takes nothing returns nothing
        local unit    whichUnit = GetTriggerUnit()
        local unit    targetUnit = GetSpellTargetUnit()
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit    dummyCaster = CreateUnit(GetOwningPlayer(targetUnit),'o019', GetUnitX(targetUnit), GetUnitY(targetUnit), 0)
        call UnitApplyTimedLife(dummyCaster,'BTLF', 2.6)
        if not IsUnitAlly(targetUnit, GetOwningPlayer(whichUnit)) then
            set dummyCaster = CreateUnit(GetOwningPlayer(whichUnit),'o019', GetUnitX(targetUnit), GetUnitY(targetUnit), 0)
            call UnitApplyTimedLife(dummyCaster,'BTLF', 2.6)
        endif

        call UnitAddInvulnerableCount(targetUnit)
        call UnitAddStunCountSafe(targetUnit)
        call UnitAddHideExCount(targetUnit)

        call SaveEffectHandle(HY, h, 32, AddSpecialEffect("war3mapImported\\WILLTHEALMIGHTY-Void5.mdx", GetUnitX(targetUnit), GetUnitY(targetUnit)))
        call SaveUnitHandle(HY, h, 2, whichUnit)
        call SaveUnitHandle(HY, h, 17, targetUnit)
        call SaveInteger(HY, h, 0, GetUnitAbilityLevel(whichUnit, GetSpellAbilityId()))
        call TriggerRegisterTimerEvent(t, 2.5, false)
        call TriggerRegisterDeathEvent(t, targetUnit)
        call TriggerAddCondition(t, Condition(function DisruptionOnTimeout))
        call SaveUnitHandle(HY, GetHandleId(whichUnit), 673, targetUnit)
        call SaveInteger(HY, GetHandleId(targetUnit), 4293, 1)
        set whichUnit = null
        set targetUnit = null
        set t = null
        set dummyCaster = null
    endfunction
    function DisruptionOnSpellEffect takes nothing returns nothing
        if (IsUnitAlly(GetSpellTargetUnit(), GetOwningPlayer(GetTriggerUnit())) or not UnitHasSpellShield(GetSpellTargetUnit())) then
            call DisruptionAction()
        endif
    endfunction
    
endscope
