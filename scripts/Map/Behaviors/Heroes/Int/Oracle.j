
scope Oracle

    globals
        constant integer HERO_INDEX_ORACLE = 112
    endglobals
    //***************************************************************************
    //*
    //*  气运之末
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_FORTUNE_END = GetHeroSKillIndexBySlot(HERO_INDEX_ORACLE, 1)
    endglobals
    
    function Q_R takes nothing returns nothing
        call ARX("war3mapImported\\FortunesEndTarget.mdx", GetEnumUnit(), "origin", 3)
        call IssueTargetOrderById(IG, 852111, GetEnumUnit())
        call UnitRemoveAbility(GetEnumUnit(),'A2T4')
        call UnitDamageTargetEx(RG, GetEnumUnit(), 1, 40 + 60 * BG)
    endfunction
    
    function FortuneEndMissileLaunch takes nothing returns nothing
        local unit whichUnit = GetTriggerUnit()
        local unit targetUnit =(LoadUnitHandle(HY,(GetHandleId(whichUnit)), 796))
        local real time = RMinBJ((GetGameTime())-(LoadReal(HY,(GetHandleId(whichUnit)), 358)), 3)
        local integer level = GetUnitAbilityLevel(whichUnit,'A2QT')
        local integer dummyAbilityLevel = R2I(2. * time)
        local unit dummyUnit = CreateUnit(GetOwningPlayer(whichUnit),'e00E', GetUnitX(whichUnit), GetUnitY(whichUnit), GetUnitFacing(whichUnit))
        local unit Q2R
        local group g
        local integer T0V ='A594'
        if dummyAbilityLevel > 3 then
            set T0V ='A595'
            set dummyAbilityLevel = dummyAbilityLevel -3
        endif
        if targetUnit != null then
            set Q2R = CreateUnit(GetOwningPlayer(whichUnit),'o00Z', GetUnitX(targetUnit), GetUnitY(targetUnit), 0)
            call UnitApplyTimedLife(Q2R,'BTLF', .5)
            call UnitAddAbility(dummyUnit, T0V)
            call SetUnitAbilityLevel(dummyUnit, T0V, dummyAbilityLevel)
            set TempUnit = whichUnit
            set RG = whichUnit
            set IG = dummyUnit
            set BG = level
            set g = AllocationGroup(189)
            call GroupEnumUnitsInRange(g, GetUnitX(targetUnit), GetUnitY(targetUnit), 350, Condition(function DHX))
            call ForGroup(g, function Q_R)
            if GetUnitAbilityLevel(targetUnit,'A3E9') == 1 and not IsUnitMagicImmune(whichUnit) then
                if not UnitHasSpellShield(whichUnit) then
                    call SetUnitOwner(dummyUnit, GetOwningPlayer(targetUnit), true)
                    call SetUnitX(dummyUnit, GetUnitX(whichUnit))
                    call SetUnitY(dummyUnit, GetUnitY(whichUnit))
                    set TempUnit = targetUnit
                    set RG = targetUnit
                    set IG = dummyUnit
                    set BG = level
                    call GroupEnumUnitsInRange(g, GetUnitX(whichUnit), GetUnitY(whichUnit), 350, Condition(function DHX))
                    call ForGroup(g, function Q_R)
                else
                    call UnitRemoveSpellShield(whichUnit)
                endif
            endif
            call DeallocateGroup(g)
        endif
        set whichUnit = null
        set targetUnit = null
        set dummyUnit = null
        set Q2R = null
        set g = null
    endfunction

    // 这到底啥用？？
    function Q3R takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 14))
        local unit targetUnit =(LoadUnitHandle(HY, h, 17))
        if GetTriggerEventId() == EVENT_WIDGET_DEATH then
            call SaveReal(HY,(GetHandleId(whichUnit)), 356,((GetUnitX(targetUnit))* 1.))
            call SaveReal(HY,(GetHandleId(whichUnit)), 357,((GetUnitY(targetUnit))* 1.))
        endif
        call FlushChildHashtable(HY, h)
        call DestroyTrigger(t)
        set t = null
        set whichUnit = null
        set targetUnit = null
        return false
    endfunction
    function Q4R takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = GetTriggerUnit()
        call SaveReal(HY,(GetHandleId(whichUnit)), 358,(((GetGameTime()))* 1.))
        call SaveUnitHandle(HY,(GetHandleId(whichUnit)), 796,(GetSpellTargetUnit()))
        call DestroyEffect(AddSpecialEffect("war3mapImported\\CleanseTargetArea.mdx", GetUnitX(GetSpellTargetUnit()), GetUnitY(GetSpellTargetUnit())))
        call SaveUnitHandle(HY, h, 14,(whichUnit))
        call SaveUnitHandle(HY, h, 17,(GetSpellTargetUnit()))
        call TriggerRegisterTimerEvent(t, 10, false)
        call TriggerRegisterDeathEvent(t, GetSpellTargetUnit())
        call TriggerAddCondition(t, Condition(function Q3R))
        set t = null
        set whichUnit = null
    endfunction
    function FortuneEndOnSpellEffect takes nothing returns nothing
        if not UnitHasSpellShield(GetSpellTargetUnit()) then
            call SaveBoolean(HY,(GetHandleId(GetTriggerUnit())), 360,(true))
        endif
    endfunction
    function FortuneEndOnEndCast takes nothing returns nothing
        if LoadBoolean(HY, GetHandleId(GetTriggerUnit()), 360) then
            call FortuneEndMissileLaunch()
        endif
    endfunction
    function FortuneEndOnSpellCast takes nothing returns nothing
        call SaveBoolean(HY,(GetHandleId(GetTriggerUnit())), 360,(false))
        call Q4R()
    endfunction

endscope

