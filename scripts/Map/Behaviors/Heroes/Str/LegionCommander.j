scope LegionCommander

    globals
        constant integer HERO_INDEX_LEGION_COMMANDER = 55
    endglobals
    //***************************************************************************
    //*
    //*  勇气之霎
    //*
    //***************************************************************************
    globals // Moment of Courage
        constant integer SKILL_INDEX_MOMENT_OF_COURAGE = GetHeroSKillIndexBySlot(HERO_INDEX_LEGION_COMMANDER, 3)
    endglobals
    
    function LQA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local integer CVX =(LoadInteger(HY, h, 59))
        call FlushChildHashtable(HY, h)
        call DestroyTrigger(t)
        call UnitRemoveAbility(whichUnit, CVX)
        call UnitRemoveAbility(whichUnit,'B0FJ')
        call UnitRemoveAbility(whichUnit,'B0FK')
        set t = null
        set whichUnit = null
        return false
    endfunction
    function LSA takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit u = LoadUnitHandle(HY, GetHandleId(t), 0)
        call UnitRemoveAbility(u,'A2GD')
        call UnitRemoveAbility(u,'A2GE')
        call UnitRemoveAbility(u,'A2GF')
        call UnitRemoveAbility(u,'A2GC')
        call UnitRemoveAbility(u,'B0FJ')
        call UnitRemoveAbility(u,'B0FK')
        call FlushChildHashtable(HY, GetHandleId(t))
        call DestroyTimer(t)
        set t = null
        set u = null
    endfunction
    function LTA takes unit u, unit targetUnit returns nothing
        local timer t = CreateTimer()
        call TimerStart(t, 0, false, function LSA)
        call SaveUnitHandle(HY, GetHandleId(t), 0, u)
        if not IsUnitIllusion(targetUnit) and not IsUnitType(u, UNIT_TYPE_MELEE_ATTACKER) and not IsUnitType(targetUnit, UNIT_TYPE_STRUCTURE) then
            call UnitRegenLife(u, u, DEDamage *(.1 *(GetUnitAbilityLevel(u, HeroSkill_BaseId[SKILL_INDEX_MOMENT_OF_COURAGE])) + .45))
        endif
        set t = null
    endfunction
    function LUA takes unit targetUnit returns nothing
        local trigger t
        local integer h
        local integer level = GetUnitAbilityLevel(targetUnit, HeroSkill_BaseId[SKILL_INDEX_MOMENT_OF_COURAGE])
        local integer id
        local integer probability = 25
        if IsUnitType(DESource, UNIT_TYPE_HERO) then
            set probability = 35
        endif
        if GetUnitPseudoRandom(targetUnit, HeroSkill_BaseId[SKILL_INDEX_MOMENT_OF_COURAGE], probability) then
            // call EPX(targetUnit, 4316, 3.3 -0.6 * level)
            //call YDWESetUnitAbilityState(targetUnit,'QP1O', 1, 3.31 - level * 0.6)
            call StartUnitAbilityCooldown(targetUnit, HeroSkill_BaseId[SKILL_INDEX_MOMENT_OF_COURAGE])

            if level == 1 then
                set id ='A2GD'
            elseif level == 2 then
                set id ='A2GE'
            elseif level == 3 then
                set id ='A2GF'
            elseif level == 4 then
                set id ='A2GC'
            endif
            call UnitAddPermanentAbility(targetUnit, id)
            call UnitHideAbility(targetUnit, id)

            set t = CreateTrigger()
            set h = GetHandleId(t)
            call TriggerRegisterDeathEvent(t, targetUnit)
            call TriggerRegisterTimerEvent(t, .5, false)
            call TriggerAddCondition(t, Condition(function LQA))
            call SaveUnitHandle(HY, h, 2, targetUnit)
            call SaveInteger(HY, h, 59, id)
            set t = null
        endif
    endfunction
    function LWA takes unit sourceUnit, unit targetUnit returns nothing
        if GetUnitAbilityLevel(targetUnit, HeroSkill_BaseId[SKILL_INDEX_MOMENT_OF_COURAGE])> 0 /*
            */ and GetUnitAbilityCooldownRemaining(targetUnit, HeroSkill_BaseId[SKILL_INDEX_MOMENT_OF_COURAGE]) == 0. /*
            */ and IsUnitEnemy(targetUnit, GetOwningPlayer(sourceUnit)) and not IsUnitBroken(targetUnit) then
            call LUA(targetUnit)
        endif
    endfunction

    function TDA takes nothing returns nothing
        call LWA(DESource, DETarget)
    endfunction

    // 吸血部分
    function SFA takes nothing returns nothing
        if LoadInteger(HY, EO, 120)> 0 and(GetUnitAbilityLevel(DESource,'A2GD')> 0 or GetUnitAbilityLevel(DESource,'A2GE')> 0 or GetUnitAbilityLevel(DESource,'A2GF')> 0 or GetUnitAbilityLevel(DESource,'A2GC')> 0) then
            call SaveInteger(HY, EO, 120, LoadInteger(HY, EO, 120)-1)
            call LTA(DESource, DETarget)
        endif
    endfunction
    function SGA takes nothing returns nothing
        call SaveBoolean(HY, EO, 120, GetUnitAbilityLevel(DESource,'B0FJ')> 0)
        if GetUnitAbilityLevel(DESource,'B0FJ')> 0 then
            call SaveInteger(HY, EO, 120, LoadInteger(HY, EO, 120) + 1)
        endif
    endfunction

    function MomentOfCourageOnInitializer takes nothing returns nothing
        // 受伤 
        call RegisterUnitAttackFunc("SFA", 1)
        // 攻击者是英雄
        call RegisterUnitAttackFunc("SGA",-2)
        // 单位被攻击
        call RegisterUnitAttackFunc("TDA",-1)
    endfunction

endscope
