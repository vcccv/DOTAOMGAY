
scope BaneElemental

    globals
        constant integer HERO_INDEX_BANE_ELEMENTAL = 75
    endglobals
    //***************************************************************************
    //*
    //*  噩梦
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_NIGHTMARE = GetHeroSKillIndexBySlot(HERO_INDEX_BANE_ELEMENTAL, 3)
    endglobals
    function FMI takes nothing returns boolean
        local trigger FPI = GetTriggeringTrigger()
        local integer h = GetHandleId(FPI)
        local integer level =(LoadInteger(HY,(h), 30))
        local unit targetUnit = LoadUnitHandle(HY, h, 30)
        local unit sourceUnit =(LoadUnitHandle(HY,(h), 2))
        local player FQI =(LoadPlayerHandle(HY,(h), 54))
        local integer FSI =(LoadInteger(HY,(h), 5))
        local unit FTI
        local boolean b = GetTriggerEventId() == EVENT_GAME_TIMER_EXPIRED
        if GetUnitAbilityLevel(targetUnit,'B02F') == 0 then
            if GetUnitAbilityLevel(targetUnit, 'A04Y') > 0 then
                call ToggleSkill.SetState(targetUnit, 'A04Y', false)
            endif
            
            // call SetPlayerAbilityAvailable(GetOwningPlayer(targetUnit),'A04Y', true)
            // call SetPlayerAbilityAvailable(GetOwningPlayer(targetUnit),'A2O9', false)
            
            call UnitRemoveAbility(targetUnit,'A37S')
            call UnitRemoveAbility(targetUnit,'A3C9')
            call UnitAddAbilityToTimed(targetUnit,'A3CA', 1, 1,'A3CA')
            if HaveSavedHandle(HY, GetHandleId(targetUnit),'VisD') then
                call UnitRemoveAbility(LoadUnitHandle(HY, GetHandleId(targetUnit),'VisD'),'A37S')
                call UnitRemoveAbility(LoadUnitHandle(HY, GetHandleId(targetUnit),'VisD'),'A3C9')
                call UnitAddAbilityToTimed(LoadUnitHandle(HY, GetHandleId(targetUnit),'VisD'),'A3CA', 1, 1,'A3CA')
            endif
            call FlushChildHashtable(HY,(h))
            call DestroyTrigger(FPI)
        elseif b == false and GetTriggerUnit() == targetUnit then
            if GetUnitAbilityLevel(targetUnit, 'A04Y') > 0 then
                call ToggleSkill.SetState(targetUnit, 'A04Y', false)
            endif

            // call SetPlayerAbilityAvailable(GetOwningPlayer(targetUnit),'A04Y', true)
            // call SetPlayerAbilityAvailable(GetOwningPlayer(targetUnit),'A2O9', false)
            call UnitRemoveAbility(targetUnit,'B02F')
            set FTI = CreateUnit(FQI,'e00E', GetUnitX(targetUnit), GetUnitY(targetUnit), 0)
            call UnitAddPermanentAbility(FTI,'A04Y')
            call UnitRemoveAbility(targetUnit,'A37S')
            call UnitRemoveAbility(targetUnit,'A3C9')
            call UnitAddAbilityToTimed(targetUnit,'A3CA', 1, 1,'A3CA')
            if HaveSavedHandle(HY, GetHandleId(targetUnit),'VisD') then
                call UnitRemoveAbility(LoadUnitHandle(HY, GetHandleId(targetUnit),'VisD'),'A37S')
                call UnitRemoveAbility(LoadUnitHandle(HY, GetHandleId(targetUnit),'VisD'),'A3C9')
                call UnitAddAbilityToTimed(LoadUnitHandle(HY, GetHandleId(targetUnit),'VisD'),'A3CA', 1, 1,'A3CA')
            endif
            call SetUnitAbilityLevel(FTI,'A04Y', FSI)
            call IssueTargetOrderById(FTI, 852227, GetAttacker())
            call FlushChildHashtable(HY,(h))
            call DestroyTrigger(FPI)
        elseif b then
            call SaveInteger(HY, h, 0, LoadInteger(HY, h, 0)+ 1)
            if LoadInteger(HY, h, 0) == 9 then
                call UnitRemoveAbility(targetUnit,'A3C9')
                if HaveSavedHandle(HY, GetHandleId(targetUnit),'VisD') then
                    call UnitRemoveAbility(LoadUnitHandle(HY, GetHandleId(targetUnit),'VisD'),'A3C9')
                endif
            endif
            if ModuloInteger(LoadInteger(HY, h, 0), 10) == 0 then
                if GetUnitState(targetUnit, UNIT_STATE_LIFE)> 21 then
                    call SetUnitState(targetUnit, UNIT_STATE_LIFE, GetUnitState(targetUnit, UNIT_STATE_LIFE)-20)
                else
                    if GetUnitAbilityLevel(targetUnit, 'A04Y') > 0 then
                        call ToggleSkill.SetState(targetUnit, 'A04Y', false)
                    endif
                    
                    // call SetPlayerAbilityAvailable(GetOwningPlayer(targetUnit),'A04Y', true)
                    // call SetPlayerAbilityAvailable(GetOwningPlayer(targetUnit),'A2O9', false)
                    call UnitRemoveAbility(targetUnit,'B02F')
                    call UnitRemoveAbility(targetUnit,'A37S')
                    call UnitRemoveAbility(targetUnit,'A3C9')
                    if HaveSavedHandle(HY, GetHandleId(targetUnit),'VisD') then
                        call UnitRemoveAbility(LoadUnitHandle(HY, GetHandleId(targetUnit),'VisD'),'A37S')
                        call UnitRemoveAbility(LoadUnitHandle(HY, GetHandleId(targetUnit),'VisD'),'A3C9')
                        call UnitAddAbilityToTimed(targetUnit,'A3CA', 1, 1,'A3CA')
                    endif
                    call UnitAddAbilityToTimed(targetUnit,'A3CA', 1, 1,'A3CA')
                    call UnitDamageTargetEx(sourceUnit, targetUnit, 1, 50)
                    call FlushChildHashtable(HY,(h))
                    call DestroyTrigger(FPI)
                endif
            endif
        endif
        set FPI = null
        set FQI = null
        set FTI = null
        set targetUnit = null
        set sourceUnit = null
        return false
    endfunction
    function FUI takes unit sourceUnit, unit targetUnit returns nothing
        local trigger FPI = CreateTrigger()
        local integer Y6R = GetHandleId(FPI)
        set Y6R = GetHandleId(FPI)
        call SaveUnitHandle(HY,(Y6R), 30,((targetUnit)))
        call SaveUnitHandle(HY,(Y6R), 2,(sourceUnit))
        call SavePlayerHandle(HY,(Y6R), 54,(GetOwningPlayer(sourceUnit)))
        call SaveInteger(HY,(Y6R), 5,(GetUnitAbilityLevel(sourceUnit,'A04Y')))
        call TriggerRegisterAnyUnitEvent(FPI, EVENT_PLAYER_UNIT_ATTACKED)
        call TriggerRegisterTimerEvent(FPI, .1, true)
        call TriggerAddCondition(FPI, Condition(function FMI))

        if GetUnitAbilityLevel(targetUnit, 'A04Y') > 0 then
            call ToggleSkill.SetState(targetUnit, 'A04Y', true)
        endif

        //if GetUnitAbilityLevel(targetUnit,'A04Y') > 0 then
        //    // call SetPlayerAbilityAvailable(GetOwningPlayer(targetUnit),'A04Y', false)
        //    // call UnitAddPermanentAbility(targetUnit,'A2O9')
        //    // call SetPlayerAbilityAvailable(GetOwningPlayer(targetUnit),'A2O9', true)
        //endif

        // 减视野
        call UnitAddAbility(targetUnit,'A37S') // - 2000
        call UnitAddAbility(targetUnit,'A3C9') // - 9999

        if HaveSavedHandle(HY, GetHandleId(targetUnit),'VisD') then
            call UnitAddAbility(LoadUnitHandle(HY, GetHandleId(targetUnit),'VisD'),'A37S')
            call UnitAddAbility(LoadUnitHandle(HY, GetHandleId(targetUnit),'VisD'),'A3C9')
        endif
        set DMV = true
        call UnitDamageTargetEx(sourceUnit, targetUnit, 2, 0)
        set DMV = false
        set FPI = null
    endfunction
    function FWI takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer h = GetHandleId(t)
        call FUI(LoadUnitHandle(HY, h, 0), LoadUnitHandle(HY, h, 1))
        call FlushChildHashtable(HY, h)
        call DestroyTimer(t)
        set t = null
    endfunction
    function NightmareOnSpellEffect takes nothing returns nothing
        local timer t
        local integer h
        if IsUnitCourier(GetSpellTargetUnit()) == false and not UnitHasSpellShield(GetSpellTargetUnit()) then
            set t = CreateTimer()
            set h = GetHandleId(t)
            call TimerStart(t, 0, false, function FWI)
            call SaveUnitHandle(HY, h, 0, GetTriggerUnit())
            call SaveUnitHandle(HY, h, 1, GetSpellTargetUnit())
            set t = null
        endif
    endfunction
    
    function FYI takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit u = LoadUnitHandle(ObjectHashTable, GetHandleId(t), 0)
        call UnitRemoveAbility(u,'B02F')
        // call UnitRemoveAbility(u,'A2O9')
        // call SetPlayerAbilityAvailableEx(GetOwningPlayer(u),'A04Y', true)
        call DestroyTimerAndFlushHT_P(t)
        set t = null
        set u = null
    endfunction
    function FZI takes nothing returns boolean
        local timer t = null
        local unit u = GetTriggerUnit()
        if GetIssuedOrderId() == GetAbilityOrderId('A2O9') and GetUnitAbilityLevel(u,'A2O9')> 0 then

            call BJDebugMsg("激活了")
            set t = CreateTimer()
            call TimerStart(t, 0, false, function FYI)
            call SaveUnitHandle(ObjectHashTable, GetHandleId(t), 0, u)
            set t = null
        endif
        set u = null
        return false
    endfunction
    function NightmareOnInitializer takes nothing returns nothing
        local trigger t = CreateTrigger()
        call TriggerRegisterAnyUnitEvent(t, EVENT_PLAYER_UNIT_ISSUED_ORDER)
        call TriggerAddCondition(t, Condition(function FZI))
        set t = null
    endfunction
    //***************************************************************************
    //*
    //*  恶魔的掌握
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_FIEND_GRIP = GetHeroSKillIndexBySlot(HERO_INDEX_BANE_ELEMENTAL, 4)
    endglobals
    function F_I takes unit R8X, unit targetUnit returns nothing
        local unit u
        if LoadBoolean(ObjectHashTable, GetHandleId(targetUnit),'Grip') then
            if IsUnitEnemy(R8X, GetOwningPlayer(targetUnit)) then
                set u = CreateUnit(GetOwningPlayer(R8X),'e00E', GetUnitX(targetUnit), GetUnitY(targetUnit), 0)
                call UnitAddPermanentAbility(u,'A04Y')
                call SetUnitAbilityLevel(u,'A04Y', 2)
                call IssueTargetOrderById(u, 852227, R8X)
                set u = null
            endif
        endif
    endfunction
    function TFA takes nothing returns nothing
        call F_I(DESource, DETarget)
    endfunction

    function F0I takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local unit targetUnit =(LoadUnitHandle(HY, h, 17))
        local real W5R
        local integer count = 6
        local fogmodifier fm =(LoadFogModifierHandle(HY, h, 42))
        if GetUnitAbilityLevel(whichUnit,'A1D9')> 0 then
            set count = 8
        endif
        if GetTriggerEventId() == EVENT_UNIT_SPELL_ENDCAST then
            call FogModifierStop(fm)
            call DestroyFogModifier(fm)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            call SaveBoolean(ObjectHashTable, GetHandleId(whichUnit),'Grip', false)
            call FIX(targetUnit)
        elseif GetTriggerEvalCount(t)> count or(GetTriggerEvalCount(t) == 1 and GetUnitAbilityLevel(targetUnit,'A3E9') == 1) then
            call FogModifierStop(fm)
            call DestroyFogModifier(fm)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            call EXStopUnit(whichUnit)
            call SaveBoolean(ObjectHashTable, GetHandleId(whichUnit),'Grip', false)
            call FIX(targetUnit)
        else
            if GetUnitAbilityLevel(whichUnit,'A1D9')> 0 then
                set W5R = RMinBJ(.1 * GetUnitState(targetUnit, UNIT_STATE_MAX_MANA), GetUnitState(targetUnit, UNIT_STATE_MANA))
            else
                set W5R = RMinBJ(.05 * GetUnitState(targetUnit, UNIT_STATE_MAX_MANA), GetUnitState(targetUnit, UNIT_STATE_MANA))
            endif
            if W5R > 0 then
                call SetUnitState(whichUnit, UNIT_STATE_MANA, GetUnitState(whichUnit, UNIT_STATE_MANA) + W5R)
                call SetUnitState(targetUnit, UNIT_STATE_MANA, GetUnitState(targetUnit, UNIT_STATE_MANA)-W5R)
            endif
            if IsUnitDeath(targetUnit) == false and GetUnitAbilityLevel(targetUnit,'Bdet') == 0 then
                call FAX(whichUnit, targetUnit)
            endif
        endif
        set t = null
        set whichUnit = null
        set targetUnit = null
        set fm = null
        return false
    endfunction
    function F1I takes nothing returns nothing
        local unit whichUnit = GetTriggerUnit()
        local unit targetUnit = GetSpellTargetUnit()
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local fogmodifier ff = CreateFogModifierRadius(GetOwningPlayer(whichUnit), FOG_OF_WAR_VISIBLE, GetUnitX(targetUnit), GetUnitY(targetUnit), 350, true, true)
        call FogModifierStart(ff)
        call UnitRemoveAbility(targetUnit,'B02F')
        call UnitRemoveAbility(targetUnit,'BUsp')
        call UnitRemoveAbility(targetUnit,'Bust')
        call TriggerRegisterTimerEvent(t, 1, true)
        call TriggerRegisterTimerEvent(t, .1, false)
        call TriggerRegisterUnitEvent(t, whichUnit, EVENT_UNIT_SPELL_ENDCAST)
        call TriggerAddCondition(t, Condition(function F0I))
        call SaveUnitHandle(HY, h, 2, whichUnit)
        call SaveUnitHandle(HY, h, 17, targetUnit)
        call SaveFogModifierHandle(HY, h, 42, ff)
        call SaveBoolean(ObjectHashTable, GetHandleId(whichUnit),'Grip', GetUnitAbilityLevel(whichUnit,'A1D9')> 0)
        call FAX(whichUnit, targetUnit)
        set whichUnit = null
        set targetUnit = null
        set t = null
        set ff = null
    endfunction
    function FiendGripOnSpellEffect takes nothing returns nothing
        if not UnitHasSpellShield(GetSpellTargetUnit()) then
            call F1I()
        endif
    endfunction

endscope
