
scope PhantomLancer

    //***************************************************************************
    //*
    //*  灵魂之矛
    //*
    //***************************************************************************
    function CreateSpiritLanceIllusion takes player p, unit whichUnit, unit targetUnit, integer lv returns nothing
        local real    damageDealt = 0.2
        local real    damageTaken = 4.0
        local real    duration    = 2 * lv
        local unit    illusionUnit
        local real    x
        local real    y
        
        set x = GetUnitX(targetUnit)
        set y = GetUnitY(targetUnit)
        set illusionUnit= CreateIllusion(GetOwningPlayer(whichUnit), whichUnit, damageDealt, damageTaken, x, y, 'Bpli', duration)
        call IssueTargetOrderById(illusionUnit, ORDER_attack, targetUnit)
    
        set illusionUnit = null
    endfunction
    function E9I takes unit whichUnit, player p, unit targetUnit, integer level, boolean hasEffect returns nothing
        local unit dummyCaster
        if hasEffect then
            set dummyCaster = CreateUnit(p,'e00E', GetUnitX(targetUnit), GetUnitY(targetUnit), 0)
            call UnitAddAbility(dummyCaster, 'A10C')
            call SetUnitAbilityLevel(dummyCaster, 'A10C', level)
            call IssueTargetOrderById(dummyCaster, 852189, targetUnit)
            call UnitDamageTargetEx(dummyCaster, targetUnit, 1, 50 + 50 * level)
            call CreateSpiritLanceIllusion(p, whichUnit, targetUnit, level)
            set dummyCaster = null
            if GetUnitAbilityLevel(targetUnit,'A3E9') == 1 and IsUnitMagicImmune(whichUnit) == false and HaveSavedHandle(HY, GetHandleId(whichUnit), 0) == false then
                call SaveUnitHandle(OtherHashTable2,'A3E9', 0, targetUnit)
                call SaveUnitHandle(OtherHashTable2,'A3E9', 1, whichUnit)
                call SaveInteger(OtherHashTable2,'A3E9', 0, level)
                call ExecuteFunc("XEI")
            endif
        endif
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl", targetUnit, "origin"))
    endfunction
    function XXI takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local player p
        local unit targetUnit
        local integer level
        local boolean hasEffect
        local unit missileDummy
        local real x
        local real y
        local real tx
        local real ty
        local real NAX
        local real NNX
        local real targetX
        local real targetY
        local boolean NDX
        local real NFX
        local real NGX
        if GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
            if OXX(GetSpellAbilityId()) then
                call SaveBoolean(HY, h, 0, true)
                call SaveReal(HY, h, 0, GetUnitX(GetTriggerUnit()))
                call SaveReal(HY, h, 1, GetUnitY(GetTriggerUnit()))
            endif
        else
            set p = LoadPlayerHandle(HY, h, 54)
            set targetUnit = LoadUnitHandle(HY, h, 30)
            set level = LoadInteger(HY, h, 5)
            set hasEffect = LoadBoolean(HY, h, 302)
            set missileDummy = LoadUnitHandle(HY, h, 45)
            set x = GetUnitX(missileDummy)
            set y = GetUnitY(missileDummy)
            set tx = GetUnitX(targetUnit)
            set ty = GetUnitY(targetUnit)
            set NAX = 1000* .035
            set NDX = LoadBoolean(HY, h, 0)
            if NDX then
                set tx = LoadReal(HY, h, 0)
                set ty = LoadReal(HY, h, 1)
            endif
            set NNX = AngleBetweenXY(x, y, tx, ty)
            set targetX = x + NAX * Cos(NNX * bj_DEGTORAD)
            set targetY = y + NAX * Sin(NNX * bj_DEGTORAD)
            call SetUnitX(missileDummy, targetX)
            call SetUnitY(missileDummy, targetY)
            call SetUnitFacing(missileDummy, NNX)
            if GetDistanceBetween(tx, ty, targetX, targetY)<= NAX then
                if NDX == false then
                    call E9I(LoadUnitHandle(HY, h, 31), p, targetUnit, level, hasEffect)
                endif
                call KillUnit(missileDummy)
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
            endif
        endif
        set t = null
        set targetUnit = null
        set missileDummy = null
        return false
    endfunction
    function UnitLaunchSpiritLance takes unit whichUnit, integer level, unit targetUnit, boolean hasEffect returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit missileDummy = CreateUnit(GetOwningPlayer(whichUnit),'h06L', GetUnitX(whichUnit), GetUnitY(whichUnit), AngleBetweenXY(GetUnitX(whichUnit), GetUnitY(whichUnit), GetUnitX(targetUnit), GetUnitY(targetUnit)))
        call SavePlayerHandle(HY, h, 54, GetOwningPlayer(whichUnit))
        call SaveUnitHandle(HY, h, 30,(targetUnit))
        call SaveUnitHandle(HY, h, 31,(whichUnit))
        call SaveBoolean(HY, h, 302, hasEffect)
        call SaveUnitHandle(HY, h, 45, missileDummy)
        call SaveInteger(HY, h, 5, level)
        call TriggerRegisterTimerEvent(t, .035, true)
        call SaveBoolean(HY, h, 0, false)
        call SaveReal(HY, h, 0, 0)
        call SaveReal(HY, h, 1, 0)
        call TriggerAddCondition(t, Condition(function XXI))
        call TriggerRegisterUnitEvent(t, targetUnit, EVENT_UNIT_SPELL_EFFECT)
        set t = null
        set missileDummy = null
    endfunction
    function XRI takes nothing returns boolean
        if IsUnitIllusion(GetFilterUnit()) and IsPlayerHasSkill(GetOwningPlayer(GetFilterUnit()), 83) and GetOwningPlayer(GetFilterUnit()) == GetOwningPlayer(GetTriggerUnit()) then
            call UnitLaunchSpiritLance(GetFilterUnit(), 3, GetSpellTargetUnit(), false)
        endif
        return false
    endfunction
    function SpiritLanceOnSpellEffect takes nothing returns nothing
        local unit trigUnit = GetTriggerUnit()
        local unit targetUnit = GetSpellTargetUnit()
        local integer level = GetUnitAbilityLevel(trigUnit,'A10D')
        local group g = AllocationGroup(244)
        call GroupEnumUnitsInRange(g, GetUnitX(trigUnit), GetUnitY(trigUnit), 700, Condition(function XRI))
        call DeallocateGroup(g)
        call UnitLaunchSpiritLance(trigUnit, level, targetUnit, not UnitHasSpellShield(GetSpellTargetUnit()))
        set trigUnit = null
        set targetUnit = null
    endfunction
    function XEI takes nothing returns nothing
        call T4V(LoadUnitHandle(OtherHashTable2,'A3E9', 0))
        call UnitLaunchSpiritLance(LoadUnitHandle(OtherHashTable2,'A3E9', 0), LoadInteger(OtherHashTable2,'A3E9', 0), LoadUnitHandle(OtherHashTable2,'A3E9', 1), UnitHasSpellShield(LoadUnitHandle(OtherHashTable2,'A3E9', 1)) == false)
        call FlushChildHashtable(OtherHashTable2,'A3E9')
    endfunction

endscope
