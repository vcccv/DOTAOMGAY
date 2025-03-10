
scope ObsidianDestroyer

    //***************************************************************************
    //*
    //*  星体禁锢
    //*
    //***************************************************************************
    function JMI takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local unit targetUnit =(LoadUnitHandle(HY, h, 17))
        call SaveInteger(HY,(GetHandleId((targetUnit))),(4303), 2)
        call DestroyEffect((LoadEffectHandle(HY, h, 32)))

        call UnitDecInvulnerableCount(targetUnit)
        call UnitDecHideExCount(targetUnit)
        call UnitDecStunCount(targetUnit)

        call ClearSelectionForPlayer(GetOwningPlayer(targetUnit))
        call SelectUnitAddForPlayer(targetUnit, GetOwningPlayer(targetUnit))
        call RemoveSavedHandle(HY,(GetHandleId(whichUnit)), 748)
        call FlushChildHashtable(HY, h)
        call DestroyTrigger(t)
        set t = null
        set whichUnit = null
        set targetUnit = null
        return false
    endfunction
    function JPI takes unit whichUnit, unit targetUnit, integer level, boolean Q0X returns nothing
        local integer JLI = IMinBJ(GetHeroInt(targetUnit, false), 1 + level * 3)+ 2
        local trigger t
        local integer h
        local unit dummyCaster = CreateUnit(GetOwningPlayer(targetUnit),'o019', GetUnitX(targetUnit), GetUnitY(targetUnit), 0)
        local boolean b = UnitHasSpellShield(targetUnit)
        if GetUnitTypeId(whichUnit)=='e00E' then
            if HaveSavedHandle(HY, GetHandleId(whichUnit), 0) then
                set whichUnit = LoadUnitHandle(HY, GetHandleId(whichUnit), 0)
                if b then
                    call UnitRemoveSpellShield(targetUnit)
                endif
            else
                set whichUnit = PlayerHeroes[GetPlayerId(GetOwningPlayer(whichUnit))]
            endif
        endif
        if (IsUnitEnemy(targetUnit, GetOwningPlayer(whichUnit))) == false or b == false then
            call UnitApplyTimedLife(dummyCaster,'BTLF', level + 1)
            call SaveInteger(HY, GetHandleId(targetUnit), 4303, 1)
            set t = CreateTrigger()
            set h = GetHandleId(t)
            //call SelectUnitRemoveForPlayer(targetUnit, GetOwningPlayer(targetUnit))

            call UnitIncInvulnerableCount(targetUnit)
            call UnitIncStunCountSafe(targetUnit)
            call UnitIncHideExCount(targetUnit)

            call SaveEffectHandle(HY, h, 32,(AddSpecialEffect("Abilities\\Spells\\Demon\\DarkConversion\\ZombifyTarget.mdl", GetUnitX(targetUnit), GetUnitY(targetUnit))))
            call SaveUnitHandle(HY, h, 2,(whichUnit))
            call SaveUnitHandle(HY, h, 17,(targetUnit))
            call TriggerRegisterTimerEvent(t, level, false)
            call TriggerAddCondition(t, Condition(function JMI))
            if IsUnitEnemy(targetUnit, GetOwningPlayer(whichUnit)) then
                call SaveUnitHandle(HY, GetHandleId(whichUnit), 748, targetUnit)
                call SetHeroInt(targetUnit, GetHeroInt(targetUnit, false)-JLI, true)
                call SetHeroInt(whichUnit, GetHeroInt(whichUnit, false)+ JLI, true)
                set t = CreateTrigger()
                set h = GetHandleId(t)
                call SaveUnitHandle(HY, h, 2,(whichUnit))
                call SaveUnitHandle(HY, h, 17,(targetUnit))
                call SaveInteger(HY, h, 262,(JLI))
                call TriggerRegisterTimerEvent(t, 50, false)
                call TriggerRegisterDeathEvent(t, whichUnit)
                call TriggerRegisterDeathEvent(t, targetUnit)
                call TriggerAddCondition(t, Condition(function JKI))
            endif
        endif
        if IsUnitAlly(targetUnit, GetOwningPlayer(whichUnit)) == false and b and Q0X then
            call UnitRemoveSpellShield(targetUnit)
        endif
        set dummyCaster = null
        set t = null
    endfunction
    function AstralImprisonmentOnSpellEffect takes nothing returns nothing
        call JPI(GetTriggerUnit(), GetSpellTargetUnit(), GetUnitAbilityLevel(GetTriggerUnit(),'A0OJ'), false)
    endfunction

    //***************************************************************************
    //*
    //*  神智之蚀
    //*
    //***************************************************************************
    function JQI takes nothing returns nothing
        local unit targetUnit = GetEnumUnit()
        local unit whichUnit = GetTriggerUnit()
        local integer OJO
        local integer MFR
        local integer array SBF
        local integer level = GetUnitAbilityLevel(whichUnit,'A0OK')
        local integer ratio = 7 + 1 * level
        local integer i
        local boolean UDR = GetUnitAbilityLevel(whichUnit,'A1VW')> 0
        local unit d
        local unit JSI = targetUnit
        if IsUnitIllusion(targetUnit) then
            set JSI = PlayerHeroes[GetPlayerId(GetOwningPlayer(targetUnit))]
        endif
        if GetHeroInt(whichUnit, true) == 0 then
            set whichUnit = PlayerHeroes[GetPlayerId(GetOwningPlayer(whichUnit))]
        endif
        set i = GetHeroMainAttributesType(whichUnit)
        if i == HERO_ATTRIBUTE_INT then
            set OJO = GetHeroInt(whichUnit, true)-GetHeroInt(JSI, true)
        elseif i == HERO_ATTRIBUTE_AGI then
            set OJO = GetHeroAgi(whichUnit, true)-GetHeroAgi(JSI, true)
        else
            set OJO = GetHeroStr(whichUnit, true)-GetHeroStr(JSI, true)
        endif
        if UDR then
            set level = GetUnitAbilityLevel(whichUnit,'A1VW')
            set ratio = 7 + 1 * level + 1
        endif
        set MFR = -10+ 20 * level
        if (OJO > 0) then
            call UnitDamageTargetEx(whichUnit, targetUnit, 1, OJO * ratio)
            call CommonTextTag(I2S(R2I(OJO * ratio)), 3, targetUnit, .023, 216, 30, 30, 216)
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\Feedback\\SpellBreakerAttack.mdl", targetUnit, "overhead"))
            call SetUnitState(targetUnit, UNIT_STATE_MANA, GetUnitState(targetUnit, UNIT_STATE_MANA)* .6)
            if UDR and IsUnitDeath(targetUnit) == false then
                call JPI(whichUnit, targetUnit, 4, true)
            endif
        endif
        set targetUnit = null
        set whichUnit = null
    endfunction
    function JTI takes nothing returns boolean
        return IsUnitIdType(GetUnitTypeId(GetFilterUnit()), UNIT_TYPE_HERO) and IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(GetTriggerUnit()))
    endfunction
    function OCE takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local integer level = GetUnitAbilityLevel(u,'A0OK')
        local real x = GetSpellTargetX()
        local real y = GetSpellTargetY()
        local group g = AllocationGroup(314)
        local integer IMX = 0
        local unit JUI =(LoadUnitHandle(HY,(GetHandleId(u)), 748))
        if level == 0 then
            set level = GetUnitAbilityLevel(u,'A1VW')
        endif
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl", x, y))
        loop
        exitwhen IMX >= 360
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl", x +( 200+ level * 50)* Cos(IMX * bj_DEGTORAD), y +( 200+ level * 50)* Sin(IMX * bj_DEGTORAD)))
            set IMX = IMX + 45
        endloop
        call GroupEnumUnitsInRange(g, x, y, 300 + level * 100 , Condition(function JTI))
        if JUI != null and GetDistanceBetween(x, y, GetUnitX(JUI), GetUnitY(JUI))<(300 + level * 100 ) then
            call SetUnitInvulnerable(JUI, false)
            call GroupAddUnit(g, JUI)
        endif
        call ForGroup(g, function JQI)
        if JUI != null and IsUnitDeath(JUI) == false then
            call SetUnitInvulnerable(JUI, true)
        endif
        call DeallocateGroup(g)
        set g = null
        set JUI = null
        set u = null
    endfunction

endscope
