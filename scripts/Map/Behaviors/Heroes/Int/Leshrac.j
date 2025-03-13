scope Leshrac

    globals
        constant integer HERO_INDEX_LESHRAC = 100
    endglobals
    //***************************************************************************
    //*
    //*  脉冲新星
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_PULSE_NOVA = GetHeroSKillIndexBySlot(HERO_INDEX_LESHRAC, 4)
    endglobals
    function UOI takes nothing returns nothing
        local unit whichUnit = L6V
        local unit targetUnit = GetEnumUnit()
        call UnitDamageTargetEx(whichUnit, targetUnit, 1, L7V)
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl", targetUnit, "origin"))
        set whichUnit = null
        set targetUnit = null
    endfunction
    // 脉冲新星动作
    function URI takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit u = LoadUnitHandle(HY, h, 2)
        local integer lv = GetUnitAbilityLevel(u,'A21F')
        local group g
        local boolean b = GetUnitAbilityLevel(u,'A21G') > 0
        if not b then
            set L7V = 70 + 30 * lv
        else
            set lv = GetUnitAbilityLevel(u,'A21G')
            set L7V = 140 + 20 * lv
        endif
        if GetTriggerEvalCount(t) == 1 and b then
            call UnitAddPermanentAbility(u,'A345')
        endif
        //set b = false
        // if LoadInteger(HY, GetHandleId(u), 704) == - 1 then
        //     if not PlayerHaveAbilityByActive(GetOwningPlayer(u), 'A21F') then
        //         set b = true //如果窃取技能丢失,则判断单位是否选择了该技能,如果没选择则设置b=true结束此触发
        //     endif
        // endif
        // 脉冲新星结束 事件==死亡 or 魔法不足 or 释放关闭技能 LoadInteger(HY, GetHandleId(u), 704) == -1 and not 
        if GetTriggerEventId() == EVENT_WIDGET_DEATH or GetUnitState(u, UNIT_STATE_MANA)< 20 * lv /*or b*/ or( GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT and( GetSpellAbilityId()=='A21H' or GetSpellAbilityId()=='A27H' or GetSpellAbilityId()=='A30J' )) then
            //set b = Rubick_AbilityFilter(u, 'A21F')
            //if b then
            //    call SetPlayerAbilityAvailableEx(GetOwningPlayer(u),'A21F', true)
            //endif
            //if b or LoadInteger(HY, GetHandleId(u), 704)=='A21G' then
            //    call SetPlayerAbilityAvailableEx(GetOwningPlayer(u),'A21G', true)
            //endif
            //call SetPlayerAbilityAvailableEx(GetOwningPlayer(u),'A21H', false)
            call ToggleSkill.SetState(u, 'A21F', false)
            if GetUnitAbilityLevel(u,'A21G') > 0 then
                call SetUnitAbilityCooldownAbsolute(u, 'A21G', 1.)
            else
                call SetUnitAbilityCooldownAbsolute(u, 'A21F', 1.)
            endif

            call UnitRemoveAbility(u,'A345')
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        elseif GetTriggerEventId() != EVENT_UNIT_SPELL_EFFECT then
            call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA)-20 * lv)
            set TempUnit = u
            set L6V = u
            set g = AllocationGroup(354)
            call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 475, Condition(function DPX))
            call ForGroup(g, function UOI)
            call DeallocateGroup(g)
            set g = null
        endif
        set t = null
        set u = null
        return false
    endfunction
    //脉冲新星
    function PulseNovaOnSpellEffect takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl", u, "origin"))
        // call SetPlayerAbilityAvailableEx(GetOwningPlayer(u),'A21F', false)
        // call SetPlayerAbilityAvailableEx(GetOwningPlayer(u),'A21G', false)
        // call SetPlayerAbilityAvailableEx(GetOwningPlayer(u),'A21H', true)
        // call UnitAddPermanentAbility(u,'A21H')
        
        call ToggleSkill.SetState(u, 'A21F', true)

        call TriggerRegisterTimerEvent(t, 1, true)
        call TriggerRegisterTimerEvent(t, 0, false)
        call TriggerRegisterDeathEvent(t, u)
        call TriggerRegisterUnitEvent(t, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(t, Condition(function URI))
        call SaveUnitHandle(HY, h, 2,(u))
        call TriggerEvaluate(t)
        set u = null
        set t = null
    endfunction
endscope
