scope Beastmaster

    globals
        constant integer HERO_INDEX_BEAST_MASTER = 37
    endglobals

    //***************************************************************************
    //*
    //*  野性呼唤
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_CALL_OF_THE_WILD     = GetHeroSKillIndexBySlot(HERO_INDEX_BEAST_MASTER, 2)
        constant integer CALL_OF_THE_WILD_HAWK_ABILITY_ID = 'A300'
        constant integer CALL_OF_THE_WILD_BOAR_ABILITY_ID = 'A301'
    endglobals
        
    function GVR takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit GER =(LoadUnitHandle(HY, h, 2))
        local real GXR =(LoadReal(HY, h, 6))
        local real GOR =(LoadReal(HY, h, 7))
        local real GRR = GetUnitX(GER)
        local real GIR = GetUnitY(GER)
        call SaveReal(HY, h, 6,((GRR)* 1.))
        call SaveReal(HY, h, 7,((GIR)* 1.))
        if GetTriggerEventId() == EVENT_UNIT_DEATH then
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        else
            if GXR == GRR and GOR == GIR then
                if GetUnitAbilityLevel(GER,'A1WG') == 0 then
                    call UnitAddPermanentAbility(GER,'A1WG')
                endif
            else
                if GetUnitAbilityLevel(GER,'A1WG')> 0 then
                    call UnitRemoveAbility(GER,'A1WG')
                endif
            endif
        endif
        set t = null
        set GER = null
        return false
    endfunction
    function CallOfTheWildBoarOnSpellEffect takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local integer i = GetUnitAbilityLevel(u, CALL_OF_THE_WILD_BOAR_ABILITY_ID)
        local group g
        local unit GAR = null
        local integer id
        if GetUnitTypeId(u)=='e00E' then
            set u = PlayerHeroes[GetPlayerId(GetOwningPlayer(u))]
        endif
        if i == 1 then
            set id ='h30A'
        elseif i == 2 then
            set id ='n01M'
        elseif i == 3 then
            set id ='n01S'
        else
            set id ='h30B'
        endif
        set GAR = CreateUnit(GetOwningPlayer(u), id, GetUnitX(u), GetUnitY(u), GetUnitFacing(u))
        call UnitApplyTimedLife(GAR,'BTLF', 60)
        call SetUnitAbilityLevel(GAR,'A0OP', i)
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Orc\\FeralSpirit\\feralspiritdone.mdl", GAR, "chest"))
        set i = GetUnitAbilityLevel(u,'A0A8')
        if i > 0 then
            call UnitAddMaxLife(GAR, 100 * i)
            call UnitAddPermanentAbilitySetLevel(GAR,'A3IM', i)
        endif
        set GAR = null
        set u = null
    endfunction
    function CallOfTheWildHawkOnSpellEffect takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local integer i = GetUnitAbilityLevel(u, CALL_OF_THE_WILD_HAWK_ABILITY_ID)
        local trigger t
        local integer h
        local unit GNR
        local integer id
        if GetUnitTypeId(u)=='e00E' then
            set u = PlayerHeroes[GetPlayerId(GetOwningPlayer(u))]
        endif
        if i == 1 then
            set id ='h308'
        elseif i == 2 then
            set id ='n01Q'
        elseif i == 3 then
            set id ='n01R'
        else
            set id ='h309'
        endif
        set GNR = CreateUnit(GetOwningPlayer(u), id, GetUnitX(u), GetUnitY(u), GetUnitFacing(u))
        call UnitApplyTimedLife(GNR,'BTLF', 60)
        if i > 2 then
            set t = CreateTrigger()
            set h = GetHandleId(t)
            call TriggerRegisterTimerEvent(t, .05, true)
            call TriggerRegisterUnitEvent(t, GNR, EVENT_UNIT_DEATH)
            call SaveReal(HY, h, 6,((GetUnitX(GNR))* 1.))
            call SaveReal(HY, h, 7,((GetUnitY(GNR))* 1.))
            call SaveUnitHandle(HY, h, 2,(GNR))
            call TriggerAddCondition(t, Condition(function GVR))
            set t = null
        endif
        set i = GetUnitAbilityLevel(u,'A0A8')
        if i > 0 then
            call SetUnitMoveSpeed(GNR, GetUnitDefaultMoveSpeed(GNR) + 50 * i)
            call UnitAddPermanentAbility(GNR,'Amim')
        endif
        set u = null
        set GNR = null
    endfunction
    
    function CallOfTheWildOnLearn takes nothing returns nothing
        local unit    u         = GetTriggerUnit()
        local integer abilLevel = GetUnitAbilityLevel(u,'A0OO')
        if (abilLevel == 1) then
            call UnitAddPermanentAbility(u, CALL_OF_THE_WILD_HAWK_ABILITY_ID)
            call UnitAddPermanentAbility(u, CALL_OF_THE_WILD_BOAR_ABILITY_ID)
        endif
        call SetUnitAbilityLevel(u, CALL_OF_THE_WILD_HAWK_ABILITY_ID, abilLevel)
        call SetUnitAbilityLevel(u, CALL_OF_THE_WILD_BOAR_ABILITY_ID, abilLevel)
        set u = null
    endfunction

endscope
