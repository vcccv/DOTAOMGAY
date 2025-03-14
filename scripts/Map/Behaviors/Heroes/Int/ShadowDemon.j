
scope ShadowDemon

    globals
        constant integer HERO_INDEX_SHADOW_DEMON = 101
    endglobals
    //***************************************************************************
    //*
    //*  崩裂禁锢
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_DISRUPTION = GetHeroSKillIndexBySlot(HERO_INDEX_SHADOW_DEMON, 1)
    endglobals
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

        call UnitDecInvulnerableCount(targetUnit)
        call UnitDecStunCount(targetUnit)
        call UnitDecHideExCount(targetUnit)

        call RemoveSavedHandle(HY, GetHandleId(targetUnit), 673)
        call FlushChildHashtable(HY, h)
        call DestroyTrigger(t)
        if GetTriggerEventId()!= EVENT_WIDGET_DEATH then
            call ClearSelectionForPlayer(GetOwningPlayer(targetUnit))
            call SelectUnitAddForPlayer(targetUnit, GetOwningPlayer(targetUnit))
            call PlaySoundAtPosition(AF, GetUnitX(targetUnit), GetUnitY(targetUnit))
            set t = CreateTrigger()
            set h = GetHandleId(t)
            call TriggerRegisterTimerEvent(t, 3, false)
            call TriggerRegisterAnyUnitEvent(t, EVENT_PLAYER_UNIT_SUMMON)
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

        call UnitIncInvulnerableCount(targetUnit)
        call UnitIncHideExCount(targetUnit)
        call UnitIncStunCountSafe(targetUnit)

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

    //***************************************************************************
    //*
    //*  暗影剧毒
    //*
    //***************************************************************************
    
    globals
        constant integer SKILL_INDEX_SHADOW_POISON = GetHeroSKillIndexBySlot(HERO_INDEX_SHADOW_DEMON, 3)

        constant integer SHADOW_POISON_RELEASE_ABILITY_ID = 'A1S9'
    endglobals
    
    function ShadowPoisonOnAdd takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        if not IsUnitType(whichUnit, UNIT_TYPE_HERO) then
            set whichUnit = null
            return
        endif
        call UnitAddPermanentAbility(whichUnit, SHADOW_POISON_RELEASE_ABILITY_ID)
        set whichUnit = null
    endfunction
    function ShadowPoisonOnRemove takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        if not IsUnitType(whichUnit, UNIT_TYPE_HERO) then
            set whichUnit = null
            return
        endif
        call UnitRemoveAbility(whichUnit, SHADOW_POISON_RELEASE_ABILITY_ID)
        set whichUnit = null
    endfunction

    function FIA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local unit targetUnit =(LoadUnitHandle(HY, h, 17))
        local integer count =(LoadInteger(HY,(GetHandleId(targetUnit)), 627))
        local real FAA =(LoadReal(HY,(GetHandleId(targetUnit)), 628))
        local integer level = GetUnitAbilityLevel(whichUnit,'A1S4')
        local real damage =(5 + level * 15)* Pow(2, IMinBJ(count, 5)-1)
        if count == 0 then
            set damage = 0
        else
            set damage = damage + IMaxBJ(count -5, 0)* 50
        endif
        if GetTriggerEventId() == EVENT_WIDGET_DEATH then
            call DestroyEffect((LoadEffectHandle(HY, h, 32)))
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            call SaveInteger(HY,(GetHandleId(targetUnit)), 627, 0)
            call SaveReal(HY,(GetHandleId(targetUnit)), 628,(0 * 1.))
        elseif GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
            if GetSpellAbilityId()=='A1S9' then
                call DestroyEffect((LoadEffectHandle(HY, h, 32)))
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
                call SaveInteger(HY,(GetHandleId(targetUnit)), 627, 0)
                call SaveReal(HY,(GetHandleId(targetUnit)), 628,(0 * 1.))
                if ((LoadInteger(HY,(GetHandleId((targetUnit))),(4293))) == 1) then
                    call SetUnitInvulnerable(targetUnit, false)
                endif
                call UnitDamageTargetEx(whichUnit, targetUnit, 1, damage)
                if ((LoadInteger(HY,(GetHandleId((targetUnit))),(4293))) == 1) then
                    call SetUnitInvulnerable(targetUnit, true)
                endif
                call CommonTextTag(I2S(R2I(damage)) + "!", 2, targetUnit, .025, 100, 0, 200, 216)
            endif
        elseif (GetGameTime())> FAA then
            call DestroyEffect((LoadEffectHandle(HY, h, 32)))
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            call SaveInteger(HY,(GetHandleId(targetUnit)), 627, 0)
            call SaveReal(HY,(GetHandleId(targetUnit)), 628,(0 * 1.))
            if ((LoadInteger(HY,(GetHandleId((targetUnit))),(4293))) == 1) then
                call SetUnitInvulnerable(targetUnit, false)
            endif
            call UnitDamageTargetEx(whichUnit, targetUnit, 1, damage)
            if ((LoadInteger(HY,(GetHandleId((targetUnit))),(4293))) == 1) then
                call SetUnitInvulnerable(targetUnit, true)
            endif
            call CommonTextTag(I2S(R2I(damage)) + "!", 2, targetUnit, .025, 100, 0, 200, 216)
        endif
        set t = null
        set whichUnit = null
        set targetUnit = null
        return false
    endfunction
    function FNA takes unit whichUnit, unit targetUnit returns nothing
        local trigger t
        local integer h
        local integer level = GetUnitAbilityLevel(whichUnit,'A1S4')
        local unit missileDummy
        if (LoadInteger(HY,(GetHandleId(targetUnit)), 627))> 0 then
            call SaveInteger(HY,(GetHandleId(targetUnit)), 627,((LoadInteger(HY,(GetHandleId(targetUnit)), 627)) + 1))
            call SaveReal(HY,(GetHandleId(targetUnit)), 628,(((GetGameTime()) + 10)* 1.))
        else
            set t = CreateTrigger()
            set h = GetHandleId(t)
            call SaveUnitHandle(HY, h, 2,(whichUnit))
            call SaveUnitHandle(HY, h, 17,(targetUnit))
            call SaveInteger(HY,(GetHandleId(targetUnit)), 627, 1)
            if IsUnitType(targetUnit, UNIT_TYPE_HERO) then
                call SaveEffectHandle(HY, h, 32,(AddSpecialEffectTarget("war3mapImported\\shamanyouranus-ShadowyMissile.mdl", targetUnit, "chest")))
            else
                call SaveEffectHandle(HY, h, 32,(AddSpecialEffectTarget("war3mapImported\\shamanyouranus-ShadowyMissile.mdl", targetUnit, "origin")))
            endif
            call SaveReal(HY,(GetHandleId(targetUnit)), 628,(((GetGameTime()) + 10)* 1.))
            call TriggerRegisterTimerEvent(t, .05, true)
            call TriggerRegisterUnitEvent(t, whichUnit, EVENT_UNIT_SPELL_EFFECT)
            call TriggerRegisterDeathEvent(t, targetUnit)
            call TriggerAddCondition(t, Condition(function FIA))
            set missileDummy = null
        endif
        call CommonTextTag("+" + I2S((LoadInteger(HY,(GetHandleId(targetUnit)), 627))), 3, targetUnit, .025, 100, 0, 200, 216)
        call UnitDamageTargetEx(whichUnit, targetUnit, 1, 50)
        set t = null
    endfunction
    function FBA takes nothing returns nothing
        if IsUnitInGroup(GetEnumUnit(), PAV) == false then
            call GroupAddUnit(PAV, GetEnumUnit())
            call FNA(PIV, GetEnumUnit())
        endif
    endfunction
    function FCA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local unit missileDummy =(LoadUnitHandle(HY, h, 45))
        local integer count = GetTriggerEvalCount(t)
        local real a =(LoadReal(HY, h, 137))
        local real x = CoordinateX50(GetUnitX(missileDummy) + 20 * Cos(a))
        local real y = CoordinateY50(GetUnitY(missileDummy) + 20 * Sin(a))
        local group g
        local group CNO =(LoadGroupHandle(HY, h, 133))
        local unit targetUnit
        if count == LoadInteger(HY, h, 10) then
            call DeallocateGroup(CNO)
            call KillUnit(missileDummy)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        else
            set TempUnit = whichUnit
            set PIV = whichUnit
            set PAV = CNO
            call SetUnitX(missileDummy, x)
            call SetUnitY(missileDummy, y)
            set g = AllocationGroup(436)
            call GroupEnumUnitsInRange(g, x, y, 215, Condition(function DPX))
            set targetUnit =(LoadUnitHandle(HY,(GetHandleId(whichUnit)), 673))
            if targetUnit != null then
                if GetDistanceBetween(GetUnitX(targetUnit), GetUnitY(targetUnit), x, y)< 215 and IsUnitEnemy(targetUnit, GetOwningPlayer(whichUnit)) then
                    call GroupAddUnit(g, targetUnit)
                endif
            endif
            call ForGroup(g, function FBA)
            set targetUnit = FirstOfGroup(g)
            call DeallocateGroup(g)
        endif
        set t = null
        set whichUnit = null
        set missileDummy = null
        set g = null
        set targetUnit = null
        set CNO = null
        return false
    endfunction
    function ShadowPoisonOnSpellEffect takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = GetTriggerUnit()
        local real x = GetSpellTargetX()
        local real y = GetSpellTargetY()
        local real a = AngleBetweenXY(GetUnitX(whichUnit), GetUnitY(whichUnit), x, y)* bj_DEGTORAD
        local unit missileDummy = CreateUnit(GetOwningPlayer(whichUnit),'h0C2', GetUnitX(whichUnit), GetUnitY(whichUnit), a * bj_RADTODEG)
        local real range = 1500. + GetUnitCastRangeBonus(whichUnit)
        call TriggerRegisterTimerEvent(t, .02, true)
        call TriggerAddCondition(t, Condition(function FCA))
        call SaveUnitHandle(HY, h, 2,(whichUnit))
        call SaveUnitHandle(HY, h, 45,(missileDummy))
        call SaveReal(HY, h, 137,((a)* 1.))
        call SaveInteger(HY, h, 10, R2I(range / 20.))
        call SaveGroupHandle(HY, h, 133,(AllocationGroup(437)))
        set t = null
        set whichUnit = null
        set missileDummy = null
    endfunction

endscope
