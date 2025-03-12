scope SkeletonKing

    globals
        constant integer HERO_INDEX_SKELETON_KING = 63
    endglobals
    //***************************************************************************
    //*
    //*  冥火暴击
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_HELLFIRE_BLAST = GetHeroSKillIndexBySlot(HERO_INDEX_SKELETON_KING, 1)
    endglobals
    
    function PWI takes nothing returns nothing
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        if GetTriggerEventId() == EVENT_UNIT_DAMAGED then
            if GetEventDamageSource() == LoadUnitHandle(HY, h, 0) then
                if GetUnitAbilityLevel(GetTriggerUnit(),'A3E9') == 1 and IsUnitMagicImmune(LoadUnitHandle(HY, h, 1)) == false and LoadBoolean(HY, h, 0) == false then
                    call SaveUnitHandle(OtherHashTable2,'A3E9', 0, GetTriggerUnit())
                    call SaveUnitHandle(OtherHashTable2,'A3E9', 1, LoadUnitHandle(HY, h, 1))
                    call SaveInteger(OtherHashTable2,'A3E9', 0, R2I(LoadReal(HY, h, 0)))
                    call ExecuteFunc("PYI")
                endif
                call CommonUnitAddStun(GetTriggerUnit(), 2., false)
                call UnitDamageTargetEx(LoadUnitHandle(HY, h, 1), GetTriggerUnit(), 1, 50 * LoadReal(HY, h, 0))
                call PUI(LoadUnitHandle(HY, h, 1), GetTriggerUnit(), R2I(LoadReal(HY, h, 0)))
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
            endif
        else
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        endif
        set t = null
    endfunction
    function PZI takes unit whichUnit, unit targetUnit, integer level, boolean FAR returns nothing
        local trigger t
        local integer h
        local unit d = CreateUnit(GetOwningPlayer(whichUnit),'e00E', GetUnitX(whichUnit), GetUnitY(whichUnit), 0)
        call UnitAddAbility(d,'A42G')
        call B0R(d, targetUnit, 852095)
        set t = CreateTrigger()
        set h = GetHandleId(t)
        call TriggerRegisterTimerEvent(t, 5, false)
        call TriggerRegisterUnitEvent(t, targetUnit, EVENT_UNIT_DAMAGED)
        call TriggerAddCondition(t, Condition(function PWI))
        call SaveUnitHandle(HY, h, 0, d)
        call SaveUnitHandle(HY, h, 1, whichUnit)
        call SaveReal(HY, h, 0, level)
        call SaveBoolean(HY, h, 0, FAR)
        set t = null
        set d = null
    endfunction
    function HellfireBlastOnSpellEffect takes nothing returns nothing
        if not UnitHasSpellShield(GetSpellTargetUnit()) then
            call PZI(GetTriggerUnit(), GetSpellTargetUnit(), GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId()), false)
        endif
    endfunction
    function PYI takes nothing returns nothing
        local unit whichUnit = LoadUnitHandle(OtherHashTable2,'A3E9', 0)
        local unit targetUnit = LoadUnitHandle(OtherHashTable2,'A3E9', 1)
        local integer level = LoadInteger(OtherHashTable2,'A3E9', 0)
        call T4V(LoadUnitHandle(OtherHashTable2,'A3E9', 0))
        if UnitHasSpellShield(targetUnit) == false then
            call PZI(whichUnit, targetUnit, level, true)
        endif
        set whichUnit = null
        set targetUnit = null
        call FlushChildHashtable(OtherHashTable2,'A3E9')
    endfunction

endscope
