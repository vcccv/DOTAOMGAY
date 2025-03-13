scope AncientApparition

    globals
        constant integer HERO_INDEX_ANCIENT_APPARITION = 97
    endglobals
    //***************************************************************************
    //*
    //*  冰晶爆轰
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_ICE_BLAST = GetHeroSKillIndexBySlot(HERO_INDEX_ANCIENT_APPARITION, 4)
    endglobals
    
    function BUA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit targetUnit = LoadUnitHandle(HY, h, 17)
        local integer level = LoadInteger(HY, h, 5)
        local unit dummyCaster
        local string s
        local real BWA = LoadReal(HY, h, 0)
        local integer c = LoadInteger(HY, h, 0)
        if GetTriggerEventId() == EVENT_WIDGET_DEATH then
            call UnitRemoveAbility(targetUnit,'A1JA')
            call UnitRemoveAbility(targetUnit,'B0CD')
            call RemoveSavedHandle(HY, GetHandleId(targetUnit),'A1MI')
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            // debug call SingleDebug("dest 1")
        elseif GetTriggerEventId() == EVENT_GAME_TIMER_EXPIRED then
            if GetGameTime()> BWA then
                call UnitRemoveAbility(targetUnit,'A1JA')
                call UnitRemoveAbility(targetUnit,'B0CD')
                call RemoveSavedHandle(HY, GetHandleId(targetUnit),'A1MI')
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
            else
                set c = c + 1
                call SaveInteger(HY, h, 0, c)
                if ModuloInteger(c, 10) == 0 then
                    call UnitDamageTargetEx(LoadUnitHandle(HY, h, 0), targetUnit, 1, 5 + 10* level)
                endif
            endif
        else
            if GetUnitAbilityLevel(targetUnit,'A1JA') == 0 then
                if GetTriggerEvalCount(t)> 4 then
                    call UnitRemoveAbility(targetUnit,'A1JA')
                    call UnitRemoveAbility(targetUnit,'B0CD')
                    call RemoveSavedHandle(HY, GetHandleId(targetUnit),'A1MI')
                    call FlushChildHashtable(HY, h)
                    call DestroyTrigger(t)
                endif
            elseif GetOwningPlayer(targetUnit) != GetOwningPlayer(GetEventDamageSource()) and GetUnitState(targetUnit, UNIT_STATE_MAX_LIFE)*(.09 + .01 * level)> GetWidgetLife(targetUnit) and((LoadInteger(HY,(GetHandleId((targetUnit))),( 2485))) != 1) then
                call RemoveSavedHandle(HY, GetHandleId(targetUnit),'A1MI')
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
                call UnitRemoveAbility(targetUnit,'A1JA')
                call UnitRemoveAbility(targetUnit,'B0CD')
                set s = "Abilities\\Spells\\Other\\FrostBolt\\FrostBoltMissile.mdl"
                call DestroyEffect(AddSpecialEffectTarget(s, targetUnit, "overhead"))
                call DestroyEffect(AddSpecialEffectTarget(s, targetUnit, "chest"))
                call DestroyEffect(AddSpecialEffectTarget(s, targetUnit, "origin"))
                set dummyCaster = CreateUnit(GetOwningPlayer(GetEventDamageSource()),'e00E', 0, 0, 0)
                if IsUnitType(targetUnit, UNIT_TYPE_SUMMONED) == false then
                    call UnitRemoveBuffs(targetUnit, true, true)
                endif
                call UnitRemoveAbility(targetUnit,'Aetl')
                call UnitDamageTargetEx(dummyCaster, targetUnit, 4, 100000000.)
                set dummyCaster = null
            endif
        endif
        set t = null
        set targetUnit = null
        return false
    endfunction
    function BYA takes unit whichUnit, unit targetUnit returns nothing
        local integer level = GetUnitAbilityLevel(whichUnit,'A1MI') + GetUnitAbilityLevel(whichUnit,'A2QE')
        local integer id = GetPlayerId(GetOwningPlayer(targetUnit))
        local trigger t
        local integer h
        local real BZA = 7 + level
        if GetUnitAbilityLevel(whichUnit,'A2QE')> 0 then
            set BZA = 17
        endif
        if level > 0 and IsUnitType(targetUnit, UNIT_TYPE_HERO) and not IsUnitWard(targetUnit) then
            if HaveSavedHandle(HY, GetHandleId(targetUnit),'A1MI') then
                set t = LoadTriggerHandle(HY, GetHandleId(targetUnit),'A1MI')
                set h = GetHandleId(t)
            else
                set t = CreateTrigger()
                set h = GetHandleId(t)
                call FlushChildHashtable(HY, h)
                call TriggerRegisterUnitEvent(t, targetUnit, EVENT_UNIT_DAMAGED)
                call TriggerAddCondition(t, Condition(function BUA))
                call TriggerRegisterDeathEvent(t, targetUnit)
                call TriggerRegisterTimerEvent(t, .1, true)
                call SaveReal(HY, h, 0, GetGameTime() + BZA * 1.)
                call SaveUnitHandle(HY, h, 17,(targetUnit))
                call UnitAddPermanentAbility(targetUnit,'A1JA')
                call SaveTriggerHandle(HY, GetHandleId(targetUnit),'A1MI', t)
            endif
            call SaveInteger(HY, h, 5,(level))
            call SaveUnitHandle(HY, h, 0, whichUnit)
            call CXR(targetUnit, BZA)
        endif
        set t = null
    endfunction
    function B4A takes nothing returns nothing
        local unit whichUnit = M9V
        local unit targetUnit = GetEnumUnit()
        local integer level = M8V
        call BYA(whichUnit, targetUnit)
        call UnitDamageTargetEx(whichUnit, targetUnit, 1, 150 + 100 * level)
        call DestroyEffect(AddSpecialEffectTarget("war3mapImported\\PlasmaShot.mdl", targetUnit, "chest"))
        set whichUnit = null
        set targetUnit = null
    endfunction
    function B5A takes nothing returns nothing
        local unit whichUnit = M9V
        local unit targetUnit = GetEnumUnit()
        local integer level = M8V
        call BYA(whichUnit, targetUnit)
        set whichUnit = null
        set targetUnit = null
    endfunction
    function B6A takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit missileDummy = LoadUnitHandle(HY, h, 45)
        local real tx = LoadReal(HY, h, 47)
        local real ty = LoadReal(HY, h, 48)
        local real a = LoadReal(HY, h, 13)
        local real KJR = LoadReal(HY, h, 432)
        local unit whichUnit = LoadUnitHandle(HY, h, 2)
        local integer level = LoadInteger(HY, h, 5)
        local real x = GetUnitX(missileDummy) + 30 * Cos(a)
        local real y = GetUnitY(missileDummy) + 30 * Sin(a)
        local group g
        local fogmodifier fm
        if GetDistanceBetween(x, y, tx, ty)< 35 or x != CoordinateX50(x) or y != CoordinateY50(y) then
            set x = tx
            set y = ty
            call SetUnitX(missileDummy, x)
            call SetUnitY(missileDummy, y)
            call DestroyEffect(LoadEffectHandle(HY, h, 14))
            call DestroyEffect(LoadEffectHandle(HY, h, 32))
            set fm = LoadFogModifierHandle(HY, h, 440)
            call FogModifierStop(fm)
            call DestroyFogModifier(fm)
            set fm = null
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            call KillUnit(missileDummy)
            set TempUnit = whichUnit
            set M9V = whichUnit
            set M8V = level
            set g = AllocationGroup(424)
            call GroupEnumUnitsInRange(g, x, y, KJR + 25, Condition(function DHX))
            call ForGroup(g, function B4A)
            call DeallocateGroup(g)
            set g = null
        else
            call SetUnitX(missileDummy, x)
            call SetUnitY(missileDummy, y)
            set TempUnit = whichUnit
            set M9V = whichUnit
            set M8V = level
            set g = AllocationGroup(425)
            call GroupEnumUnitsInRange(g, x, y, 300, Condition(function DHX))
            call ForGroup(g, function B5A)
            call DeallocateGroup(g)
            set g = null
        endif
        set t = null
        set missileDummy = null
        set whichUnit = null
        return false
    endfunction
    function B7A takes unit whichUnit, real x, real y, real DRI, effect FX, fogmodifier fm, integer level, real PJZ  returns nothing
        local real a = Atan2(y -GetUnitY(whichUnit), x -GetUnitX(whichUnit))
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit missileDummy = CreateUnit(GetOwningPlayer(whichUnit),'h0B6', GetUnitX(whichUnit), GetUnitY(whichUnit), a * bj_RADTODEG)
        local real KJR = RMinBJ(275 + 25 * DRI * 2, 1000)
        local real GIX = GetDistanceBetween(GetUnitX(whichUnit), GetUnitY(whichUnit), x, y)
        local string s = ""
        local effect eff = null
        if IsPlayerAlly(LocalPlayer, GetOwningPlayer(whichUnit)) or IsPlayerObserverEx(LocalPlayer) then
            set s = "H\\AA\\IceBlastAoE.mdx"
        endif
        set eff= AddSpecialEffect(s, x,y)
        call EXSetEffectSize(eff ,0.25*PJZ/100.)
        call SaveEffectHandle(HY, h, 14, eff)
        set eff = null
        if IsUnitEnemy(missileDummy, LocalPlayer) and IsPlayerObserverEx(LocalPlayer) == false then
            call UnitSetUsesAltIcon(missileDummy, true)
        endif
        call TriggerRegisterTimerEvent(t, RMinBJ(2. /(GIX / 30), .04), true)
        call TriggerAddCondition(t, Condition(function B6A))
        call SaveUnitHandle(HY, h, 45, missileDummy)
        call SaveReal(HY, h, 47, x * 1.)
        call SaveReal(HY, h, 48, y * 1.)
        call SaveReal(HY, h, 13, a * 1.)
        call SaveReal(HY, h, 432, KJR * 1.)
        call SaveInteger(HY, h, 5, level)
        call SaveUnitHandle(HY, h, 2, whichUnit)
        call SaveFogModifierHandle(HY, h, 440, fm)
        call SaveEffectHandle(HY, h, 32, FX)
        // call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A1MI', true)
        // call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A2QE', true)
        // call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A1MN', false)
        call ToggleSkill.SetState(whichUnit, 'A1MI', false)

        set t = null
        set missileDummy = null
    endfunction
    function B8A takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit missileDummy = LoadUnitHandle(HY, h, 45)
        local unit whichUnit = LoadUnitHandle(HY, h, 2)
        local real a = LoadReal(HY, h, 13)
        local real x
        local real y
        local real DRI = GetGameTime()-LoadReal(HY, h, 431)
        local real PJZ
        local string s
        local fogmodifier fm
        local effect FX
        local real B9A = GetUnitX(missileDummy) + 30 * Cos(a)
        local real CVA = GetUnitY(missileDummy) + 30 * Sin(a)
        local integer level = LoadInteger(HY, h, 0)
        set x = CoordinateX50(B9A)
        set y = CoordinateY50(CVA)
        call SetUnitX(missileDummy, x)
        call SetUnitY(missileDummy, y)
        if GetTriggerEventId() == EVENT_WIDGET_DEATH or(GetTriggerEventId() == EVENT_PLAYER_UNIT_SPELL_EFFECT and GetSpellAbilityId()=='A1MN') or x != B9A or y != CVA then
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            call RemoveUnit(missileDummy)
            set PJZ= RMinBJ(25+250+50*DRI,1000)
            set s = ""
            if IsPlayerAlly(GetOwningPlayer(whichUnit), LocalPlayer) or IsPlayerObserverEx(LocalPlayer) then
                set s = "war3mapImported\\IceWindGroundFX.mdl"
            endif
            set fm = CreateFogModifierRadius(GetOwningPlayer(whichUnit), FOG_OF_WAR_VISIBLE, x, y, 500, true, true)
            call FogModifierStart(fm)
            set FX = AddSpecialEffect(s, x, y)
            call B7A(whichUnit, x, y, DRI, FX, fm, level, PJZ)
            set fm = null
            set FX = null
        endif
        set t = null
        set missileDummy = null
        set whichUnit = null
        return false
    endfunction
    //冰晶爆轰
    function IceBlastOnSpellEffect takes nothing returns nothing
        local unit whichUnit = GetTriggerUnit()
        local real x = GetSpellTargetX()
        local real y = GetSpellTargetY()
        local real a = Atan2(y -GetUnitY(whichUnit), x -GetUnitX(whichUnit))
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit missileDummy = CreateUnit(GetOwningPlayer(whichUnit),'H0B8', GetUnitX(whichUnit), GetUnitY(whichUnit), a * bj_RADTODEG)
        if IsUnitEnemy(missileDummy, LocalPlayer) and IsPlayerObserverEx(LocalPlayer) == false then
            call UnitSetUsesAltIcon(missileDummy, true)
        endif
        call SaveUnitHandle(HY, h, 45, missileDummy)
        call SaveUnitHandle(HY, h, 2, whichUnit)
        call SaveReal(HY, h, 13, a * 1.)
        call SaveReal(HY, h, 431, GetGameTime()* 1.)
        call TriggerRegisterTimerEvent(t, .02, true)
        call SaveInteger(HY, h, 0, GetUnitAbilityLevel(whichUnit, GetSpellAbilityId()))
        call SaveInteger(HY, h, 1, GetSpellAbilityId())
        call TriggerRegisterAnyUnitEvent(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerRegisterDeathEvent(t, whichUnit)
        call TriggerAddCondition(t, Condition(function B8A))
        call SetUnitColor(missileDummy, GetPlayerColor(Player( 14)))
        // call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A1MI', false)
        // call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A2QE', false)
        // call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A1MN', true)
        // call UnitAddPermanentAbility(whichUnit,'A1MN')
        call ToggleSkill.SetState(whichUnit, 'A1MI', true)

        set whichUnit = null
        set t = null
        set missileDummy = null
    endfunction

endscope
