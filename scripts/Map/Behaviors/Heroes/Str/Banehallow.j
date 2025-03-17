scope Banehallow

    globals
        constant integer HERO_INDEX_BANEHALLOW = 58
    endglobals
    //***************************************************************************
    //*
    //*  召狼
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_SUMMON_WOLVES = GetHeroSKillIndexBySlot(HERO_INDEX_BANEHALLOW, 1)
    endglobals

    // 
    function SummonWolvesOnSpellEffect takes nothing returns nothing
        local unit U1I
        local integer id = 0
        local integer level = GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId())
        local real x = GetUnitX(GetTriggerUnit())
        local real y = GetUnitY(GetTriggerUnit())
        local real a = GetUnitFacing(GetTriggerUnit())
        if level == 1 then
            set id ='o005'
        elseif level == 2then
            set id ='o006'
        elseif level == 3 then
            set id ='o007'
        else
            set id ='o00F'
        endif
        set U1I = CreateUnit(GetTriggerPlayer(), id, x + 30 * Cos(a * bj_DEGTORAD), y + 30 * Sin(a * bj_DEGTORAD), a)
        call UnitApplyTimedLife(U1I,'BTLF', 55)
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl", U1I, "origin"))
        set U1I = CreateUnit(GetTriggerPlayer(), id, x + 30 * Cos(a * bj_DEGTORAD), y + 30 * Sin(a * bj_DEGTORAD), a)
        call UnitApplyTimedLife(U1I,'BTLF', 55)
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl", U1I, "origin"))
        call SetPlayerAbilityAvailableEx(GetOwningPlayer(GetTriggerUnit()),'A03B', true)
        set U1I = null
    endfunction

    //***************************************************************************
    //*
    //*  变狼
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_SHAPESHIFT = GetHeroSKillIndexBySlot(HERO_INDEX_BANEHALLOW, 4)
    endglobals
    
    function UZI takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 14))
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosDone.mdl", whichUnit, "origin"))
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl", whichUnit, "origin"))
        call UnitRemoveAbility(whichUnit,'A0ZC')
        call UnitRemoveAbility(whichUnit,'B00V')
        call UnitRemoveAbility(whichUnit,'A521')
        //call ResetUnitVertexColor(whichUnit)
        //call SetUnitVertexColorEx(whichUnit,-1,-1,-1, 255)
        call RemoveUnit(LoadUnitHandle(HY, h, 15))
        call SetUnitNoLimitMoveSpeed(whichUnit, 0)
        call UnitAddMaxLife(whichUnit,-1 * LoadInteger(HY, h, 16))
        call FlushChildHashtable(HY, h)
        call DestroyTrigger(t)
        set t = null
        set whichUnit = null
        return false
    endfunction
    function Shapeshift_CallBack takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 14))
        local unit d = LoadUnitHandle(HY, h, 15)
        local integer I2X = LoadInteger(HY, h, 16)
        call FlushChildHashtable(HY, h)
        call DestroyTrigger(t)
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosDone.mdl", whichUnit, "origin"))
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl", whichUnit, "origin"))
        set t = CreateTrigger()
        set h = GetHandleId(t)
        call TriggerRegisterTimerEvent(t, 18 -0.1, false)
        call TriggerRegisterDeathEvent(t, whichUnit)
        call TriggerAddCondition(t, Condition(function UZI))
        call SaveUnitHandle(HY, h, 14,(whichUnit))
        call SaveUnitHandle(HY, h, 15, d)
        call SaveInteger(HY, h, 16, I2X)
        call SetUnitNoLimitMoveSpeed(whichUnit, 650)
        set d = null
        set t = null
        set whichUnit = null
        return false
    endfunction
    // 变狼
    function U0I takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = GetTriggerUnit()
        local unit dummyUnit = CreateUnit(GetOwningPlayer(whichUnit),'e01V', 0, 0, 0)
        local real N5O = 18
        local real hp = GetWidgetLife(whichUnit)
        local real extraMaxLife = 100 * GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        call UnitAddMaxLife(whichUnit, R2I(extraMaxLife))
        call SaveInteger(HY, h, 16, R2I(extraMaxLife))
        call SetWidgetLife(whichUnit, hp + extraMaxLife)
        call UnitAddPermanentAbility(dummyUnit,'A0ZC')
        call UnitApplyTimedLife(dummyUnit,'BTLF', N5O)
        //call SetUnitVertexColorEx(whichUnit, 255, 100, 255, 175)
        call TriggerRegisterTimerEvent(t, .1, false)
        call TriggerAddCondition(t, Condition(function Shapeshift_CallBack))
        call SaveUnitHandle(HY, h, 14,(whichUnit))
        call SaveUnitHandle(HY, h, 15, dummyUnit)
        set t = null
        set whichUnit = null
        set dummyUnit = null
    endfunction
    function ShapeshiftOnSpellEffect takes nothing returns nothing
        if GetUnitTypeId(GetTriggerUnit())!='E015' then
            call U0I()
        endif
    endfunction
    
endscope
