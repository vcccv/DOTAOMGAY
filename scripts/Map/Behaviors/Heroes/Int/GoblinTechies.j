scope GoblinTechies

    globals
        constant integer HERO_INDEX_GOBLIN_TECHIES = 23
    endglobals
    //***************************************************************************
    //*
    //*  遥控炸弹
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_REMOTE_MINES = GetHeroSKillIndexBySlot(HERO_INDEX_GOBLIN_TECHIES, 4)
        constant integer GOBLIN_TECHIES_FOCUSED_DETONATE_ABILITY_ID = 'A1WF'
    endglobals

    function ALI takes nothing returns boolean
        return GetOwningPlayer(GetFilterUnit()) == LoadPlayerHandle(OtherHashTable2,'A0AN', 0) and IsUnitDeath(GetFilterUnit()) == false and IsUnitRemoteMines(GetFilterUnit())
    endfunction
    function AMI takes nothing returns nothing
        call IssueImmediateOrderById(GetEnumUnit(), 852556)
    endfunction
    function FocusedDetonateOnSpellEffect takes nothing returns nothing
        local group g = AllocationGroup(276)
        local real x = GetSpellTargetX()
        local real y = GetSpellTargetY()
        call SavePlayerHandle(OtherHashTable2,'A0AN', 0, GetOwningPlayer(GetTriggerUnit()))
        call GroupEnumUnitsInRange(g, x, y, 716, Condition(function ALI))
        call ForGroup(g, function AMI)
        call FlushChildHashtable(OtherHashTable2,'A0AN')
        call DeallocateGroup(g)
        set g = null
    endfunction

    function RemoteMinesOnAdd takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        if not IsUnitType(whichUnit, UNIT_TYPE_HERO) then
            set whichUnit = null
            return
        endif
        call UnitAddAbility(whichUnit, GOBLIN_TECHIES_FOCUSED_DETONATE_ABILITY_ID)
        set whichUnit = null
    endfunction
    function RemoteMinesOnRemove takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        if not IsUnitType(whichUnit, UNIT_TYPE_HERO) then
            set whichUnit = null
            return
        endif
        call UnitRemoveAbility(whichUnit, GOBLIN_TECHIES_FOCUSED_DETONATE_ABILITY_ID)
        set whichUnit = null
    endfunction

    function ADI takes nothing returns boolean
        return(IsUnitEnemy(GetFilterUnit(), LoadPlayerHandle(OtherHashTable2,'A0AM', 1)) and IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) == false and not IsUnitWard(GetFilterUnit())) != null
    endfunction
    function AFI takes nothing returns nothing
        call UnitDamageTargetEx(LoadUnitHandle(OtherHashTable2,'A0AM', 0), GetEnumUnit(), 1, LoadReal(OtherHashTable2,'A0AM', 0))
    endfunction
    function AGI takes unit u, boolean AHI returns nothing
        local real damageValue = .0
        local integer unitTypeId = GetUnitTypeId(u)
        local group g
        local real x = GetUnitX(u)
        local real y = GetUnitY(u)
        if unitTypeId =='o018' then
            set damageValue = 300.
        elseif unitTypeId =='o002'then
            set damageValue = 450.
        elseif unitTypeId =='o00B'then
            set damageValue = 600.
        elseif unitTypeId =='o01B' then
            set damageValue = 750.
        endif
        set g = AllocationGroup(275)
        call SaveUnitHandle(OtherHashTable2,'A0AM', 0, u)
        call SavePlayerHandle(OtherHashTable2,'A0AM', 1, GetOwningPlayer(u))
        call GroupEnumUnitsInRange(g, x, y, 450, Condition(function ADI))
        call ABX("Abilities\\Spells\\Human\\FlameStrike\\FlameStrike1.mdl", x, y, 5)
        call CreateFogModifierTimedForPlayer(GetOwningPlayer(u), 3, x, y, 500)
        call SaveReal(OtherHashTable2,'A0AM', 0, damageValue)
        set X4 = AHI == false
        call ForGroup(g, function AFI)
        set X4 = false
        call FlushChildHashtable(OtherHashTable2,'A0AM')
        call RemoveUnit(u)
        call DeallocateGroup(g)
        set g = null
    endfunction
    function PinpointDetonateOnSpellEffect takes nothing returns nothing
        call AGI(GetTriggerUnit(), false)
    endfunction
    // 
    // function RemoteMinesOnLearn takes nothing returns nothing
    //     call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 10, "你可以使用 -show 命令将技能遥控炸弹切换至其副技能集中引爆")
    //     if (GetUnitAbilityLevel(GetTriggerUnit(),'A0AK') == 1 or GetUnitAbilityLevel(GetTriggerUnit(),'A1FY') == 1) then
    //         call UnitAddPermanentAbility(GetTriggerUnit(),'A1WF')
    //     endif
    // endfunction
    
    private function RemoteMinesOnEnter takes nothing returns nothing
        if IsUnitRemoteMines(GetSummonedUnit()) then
            call TriggerRegisterUnitEvent(UnitEventMainTrig, GetSummonedUnit(), EVENT_UNIT_SPELL_CAST)
        endif
    endfunction
    function AJI takes unit AKI returns nothing
        if IsUnitRemoteMines(AKI) then
        endif
    endfunction
    function WDA takes nothing returns nothing
        call AJI(UEDyingUnit)
    endfunction
    function WFA takes nothing returns nothing
        call RegisterUnitDeathMethod("WDA")
    endfunction

    function RemoteMinesOnInitializer takes nothing returns nothing
        local trigger t = CreateTrigger()
        call TriggerRegisterAnyUnitEvent(t, EVENT_PLAYER_UNIT_SUMMON)
        call TriggerAddCondition(t, Condition(function RemoteMinesOnEnter))
        call CJX("Units\\Creeps\\GoblinSapper\\GoblinSapperYesAttack1.wav")

        call WFA()
        set t = null
    endfunction

endscope
