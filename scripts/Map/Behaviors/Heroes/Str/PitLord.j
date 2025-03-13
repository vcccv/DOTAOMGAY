scope PitLord

    globals
        constant integer HERO_INDEX_PIT_LORD = 91
    endglobals
    //***************************************************************************
    //*
    //*  黑暗之门
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_DRAK_RIFT = GetHeroSKillIndexBySlot(HERO_INDEX_PIT_LORD, 4)
    endglobals
    
    function VFA takes nothing returns boolean
        return IsUnitAlly(GetFilterUnit(), GetOwningPlayer(TempUnit)) and not IsUnitDummy(GetFilterUnit()) and not IsUnitWard(GetFilterUnit()) and IsUnitDeath(GetFilterUnit()) == false and IsPlayerValid(GetOwningPlayer(GetFilterUnit()))
    endfunction

    function VGA takes unit whichUnit, unit targetUnit returns nothing
        local group g = AllocationGroup(376)
        local player p = GetOwningPlayer(whichUnit)
        local real x1 = GetWidgetX(whichUnit)
        local real y1 = GetWidgetY(whichUnit)
        local real x2 = GetWidgetX(targetUnit)
        local real y2 = GetWidgetY(targetUnit)
        call DestroyEffect(AddSpecialEffect("Doodads\\Cinematic\\ShimmeringPortal\\ShimmeringPortal.mdl", x1, y1))
        call DestroyEffect(AddSpecialEffect("Doodads\\Cinematic\\ShimmeringPortal\\ShimmeringPortal.mdl", x2, y2))
        set TempReal1 = x2
        set TempReal2 = y2
        set TempUnit = whichUnit
        call GroupEnumUnitsInRange(g, x1, y1, 475, Condition(function VFA))
        call ForGroup(g, function VBA)
        call DeallocateGroup(g)
        // call UnitRemoveAbility(whichUnit,'A2MB')
        // call SetPlayerAbilityAvailableEx(p,'A2MB', false)
        // call SetPlayerAbilityAvailableEx(p,'A0R0', true)

        call ToggleSkill.SetState(whichUnit, 'A0R0', false)
        set g = null
        set p = null
    endfunction

    function VHA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local unit targetUnit =(LoadUnitHandle(HY, h, 17))
        local player p = GetOwningPlayer(whichUnit)
        local boolean b = GetSpellAbilityId()=='A2MB'
        if IsUnitDeath(targetUnit) or IsUnitDeath(whichUnit) or targetUnit == null or whichUnit == null or b then
            if b then
                call VDA(whichUnit)
            else
                call InterfaceErrorForPlayer(p, GetObjectName('n03F'))
            endif
            call DestroyEffect((LoadEffectHandle(HY, h, 32)))
            call UnitRemoveType(targetUnit, UNIT_TYPE_PEON)

            // call SetPlayerAbilityAvailableEx(p,'A2MB', false)
            // call SetPlayerAbilityAvailableEx(p,'A0R0', true)
            call ToggleSkill.SetState(whichUnit, 'A0R0', false)

            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            set t = null
            set whichUnit = null
            set targetUnit = null
            return false
        endif
        if GetTriggerEventId() == EVENT_GAME_TIMER_EXPIRED then
            call DestroyEffect((LoadEffectHandle(HY, h, 32)))
            call VGA(whichUnit, targetUnit)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        endif
        set t = null
        set whichUnit = null
        set targetUnit = null
        set p = null
        return false
    endfunction

    function VJA takes nothing returns boolean
        local real d
        if IsUnitAlly(GetFilterUnit(), GetOwningPlayer(GetTriggerUnit())) == false or IsUnitWard(GetFilterUnit()) or GetOwningPlayer(GetFilterUnit()) == Player(15) or IsUnitDeath(GetFilterUnit()) then
            return false
        endif
        if IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) or(LWO(GetFilterUnit())) then
            set d = GetDistanceBetween(TempReal2, TempReal3, GetUnitX(GetFilterUnit()), GetUnitY(GetFilterUnit()))
            if d < TempReal1 then
                set TempReal1 = d
                set TempUnit = GetFilterUnit()
            endif
        endif
        return false
    endfunction

    function GetDarkRiftTargetUnit takes unit whichUnit returns unit
        local group g
        local real x
        local real y
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
        set g = AllocationGroup(377)
        set TempUnit = null
        set TempReal1 = 9999
        set TempReal2 = x
        set TempReal3 = y
        call GroupEnumUnitsInRange(g, x, y, 4000, Condition(function VJA))
        call DeallocateGroup(g)
        set g = null
        return TempUnit
    endfunction

    function VNA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local unit dummyCaster =(LoadUnitHandle(HY, h, 393))
        local integer level =(LoadInteger(HY, h, 5))
        local integer maxCount = 90
        local integer count = GetTriggerEvalCount(t)
        if GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT and GetSpellAbilityId() == 'A2MB' then
            call KillUnit(dummyCaster)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            set t = null
            set dummyCaster = null
            set whichUnit = null
            return false
        endif
        if level == 1 then
            set maxCount = 160
        elseif level == 2 then
            set maxCount = 120
        endif
        call SetUnitX(dummyCaster, GetUnitX(whichUnit))
        call SetUnitY(dummyCaster, GetUnitY(whichUnit))
        if count > maxCount then
            call KillUnit(dummyCaster)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        elseif count == 30 then
            call UnitRemoveAbility(dummyCaster, 'Aloc')
            call ShowUnit(dummyCaster, true)
            call UnitAddAbility(dummyCaster,'Aloc')
        endif
        set t = null
        set dummyCaster = null
        set whichUnit = null
        return false
    endfunction

    function DarkRiftOnSpellEffectAS takes unit sourceUnit returns nothing
        local trigger t
        local integer h
        local unit targetUnit = GetSpellTargetUnit()
        local real x
        local real y
        if targetUnit == null then
            set targetUnit = GetDarkRiftTargetUnit(sourceUnit)
        endif
        if targetUnit == null then
            call InterfaceErrorForPlayer(GetOwningPlayer(sourceUnit), GetObjectName('n03H'))
            return
        endif
        call ToggleSkill.SetState(sourceUnit, 'A0R0', true)
        // call SetPlayerAbilityAvailableEx(GetOwningPlayer(sourceUnit),'A0R0', false)
        // call SetPlayerAbilityAvailableEx(GetOwningPlayer(sourceUnit),'A2MB', true)
        // call UnitAddPermanentAbility(sourceUnit,'A2MB')

        set t = CreateTrigger()
        set h = GetHandleId(t)
        if IsPlayerAlly(LocalPlayer, GetOwningPlayer(sourceUnit)) or IsPlayerObserverEx(LocalPlayer) then
            call PingMinimapEx(GetUnitX(targetUnit), GetUnitY(targetUnit), 3, 255, 255, 255, false)
        endif
        call TriggerRegisterTimerEvent(t, 7 -GetUnitAbilityLevel(sourceUnit,'A0R0'), false)
        call TriggerRegisterDeathEvent(t, targetUnit)
        call TriggerRegisterDeathEvent(t, sourceUnit)
        call TriggerRegisterUnitEvent(t, sourceUnit, EVENT_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(t, Condition(function VHA))
        call SaveEffectHandle(HY, h, 32, AddSpecialEffectTarget("war3mapImported\\DarkHands.mdl", targetUnit, "overhead"))
        call SaveUnitHandle(HY, h, 2, sourceUnit)
        call SaveUnitHandle(HY, h, 17, targetUnit)
        call UnitAddType(targetUnit, UNIT_TYPE_PEON)
        
        set t = CreateTrigger()
        set h = GetHandleId(t)
        call TriggerRegisterTimerEvent(t, .03, true)
        call TriggerAddCondition(t, Condition(function VNA))
        call TriggerRegisterUnitEvent(t, sourceUnit, EVENT_UNIT_SPELL_EFFECT)
        call SaveInteger(HY, h, 5, GetUnitAbilityLevel(sourceUnit,'A0R0'))
        call SaveUnitHandle(HY, h, 2, sourceUnit)
        set targetUnit = CreateUnit(GetOwningPlayer(sourceUnit),'h098', GetUnitX(sourceUnit), GetUnitY(sourceUnit), 0)
        call SaveUnitHandle(HY, h, 393, targetUnit)
        call UnitRemoveAbility(targetUnit,'Aloc')
        call ShowUnit(targetUnit, false)
        
        set t = null
        set targetUnit = null
    endfunction

    function DarkRiftOnSpellCast takes nothing returns nothing
        local unit targetUnit = GetSpellTargetUnit()
        local unit sourceUnit = GetTriggerUnit()
        if targetUnit != null then
            if IsUnitEnemy(targetUnit, GetOwningPlayer(sourceUnit)) or LWO(targetUnit) == false then
                call EXStopUnit(sourceUnit)
                call InterfaceErrorForPlayer(GetOwningPlayer(sourceUnit), GetObjectName('n041'))
            endif
        else
            set targetUnit = GetDarkRiftTargetUnit(sourceUnit)
        endif
        if targetUnit == null then
            call EXStopUnit(sourceUnit)
            call InterfaceErrorForPlayer(GetOwningPlayer(sourceUnit), GetObjectName('n040'))
        endif
        set targetUnit = null
        set sourceUnit = null
    endfunction

    function DarkRiftOnSpellEffect takes nothing returns nothing
        call DarkRiftOnSpellEffectAS(GetTriggerUnit())
    endfunction

endscope
