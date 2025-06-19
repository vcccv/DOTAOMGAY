
scope Zeus

    globals
        constant integer HERO_INDEX_ZEUS = 2
    endglobals

    //***************************************************************************
    //*
    //*  雷神之怒
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_THUNDERGOD_WRATH = GetHeroSKillIndexBySlot(HERO_INDEX_ZEUS, 4)
    endglobals

    private function OnUpdate takes nothing returns boolean
        local trigger   trig       = GetTriggeringTrigger()
        local integer   h          = GetHandleId(trig)
        local integer   count      = GetTriggerEvalCount(trig)

        local lightning light      = LoadLightningHandle(HY, h, 'l')
        local unit      targetUnit = LoadUnitHandle(HY, h, 'u')
        local real      x          = LoadReal(HY, h, 'x')
        local real      y          = LoadReal(HY, h, 'y')
        local real      z          = LoadReal(HY, h, 'z')
        //local boolean   isFateOut  = LoadBoolean(HY, h, 'f')

        call MoveLightningEx(light, false, x, y, z, GetUnitX(targetUnit), GetUnitY(targetUnit), MHUnit_GetData(targetUnit, UNIT_DATA_POSITION_Z))
        if count > 12 then
            call SetLightningColor(light, GetLightningColorR(light), GetLightningColorG(light), GetLightningColorB(light), GetLightningColorA(light) - (1 / ( 1. / 0.02 )))
        endif

        if count >= 50 then
            call DestroyLightning(light)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(trig)
        endif

        set targetUnit = null
        set light = null
        set trig  = null
        return false
    endfunction

    private function OnDelayExpired takes nothing returns boolean
        local trigger   trig       = GetTriggeringTrigger()
        local integer   h          = GetHandleId(trig)
        local unit      sourceUnit = LoadUnitHandle(HY, h, 's')
        local unit      targetUnit = LoadUnitHandle(HY, h, 't')
        local real      damage     = LoadReal(HY, h, 'd')

        if IsUnitVisibleToPlayer(targetUnit, GetOwningPlayer(sourceUnit)) then
            call UnitDamageTargetEx(sourceUnit, targetUnit, 1, damage)

            //call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Orc\\LightningBolt\\LightningBoltMissile.mdl", targetUnit, "origin"))
        endif

        call FlushChildHashtable(HY, h)
        call DestroyTrigger(trig)

        set sourceUnit = null
        set targetUnit = null
        set trig       = null
        return false
    endfunction
    
    function ThundergodWrathTargetEffect takes unit soruceUnit, unit targetUnit, integer level returns nothing
        local real      x  = GetUnitX(targetUnit)
        local real      y  = GetUnitY(targetUnit)
        local unit      d  = CreateUnit(GetOwningPlayer(soruceUnit),'e000', x, y, 0)
        local integer   id ='A06L'

        local trigger   updateTrig
        local trigger   delayTrig
        local lightning light
        local integer   h
        local real      damage

        local real      z = MHUnit_GetData(targetUnit, UNIT_DATA_POSITION_Z) + 1000.

        set damage = 100 + 125 * level
    
        if GetSpellAbilityId() != 'A29G' then
            set damage = 340 + 100 * level
        endif

        set light = AddLightningEx("CLPB", false, x, y, z, x, y, z - 1000.)

        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Weapons\\Bolt\\BoltImpact.mdl", targetUnit, "origin"))

        set updateTrig = CreateTrigger()
        set h          = GetHandleId(updateTrig)
        call TriggerAddCondition(updateTrig, Condition(function OnUpdate))
        call TriggerRegisterTimerEvent(updateTrig, 0.02, true)
        call SaveLightningHandle(HY, h, 'l', light)
        call SaveUnitHandle(HY, h, 'u', targetUnit)
        call SaveReal(HY, h, 'x', x)
        call SaveReal(HY, h, 'y', y)
        call SaveReal(HY, h, 'z', z)

        set delayTrig = CreateTrigger()
        set h         = GetHandleId(delayTrig)
        call TriggerAddCondition(delayTrig, Condition(function OnDelayExpired))
        call TriggerRegisterTimerEvent(delayTrig, 0.25, false)
        call SaveUnitHandle(HY, h, 's', soruceUnit)
        call SaveUnitHandle(HY, h, 't', targetUnit)
        call SaveReal(HY, h, 'd', damage)
        
        call UnitAddAbility(d,'Aloc')
        call UnitApplyTimedLife(d,'BTLF', 3.)
        // call UnitAddAbility(d, id)
        // call SetUnitAbilityLevel(d, id, level)
        // if GetUnitAbilityLevel(targetUnit,'A1HX') == 0 then
        //     call IssueTargetOrderById(d, 852119, targetUnit)
        // endif
        set d = null
    endfunction
    function ThundergodWrathOnSpellEffect takes nothing returns nothing
        local group   g           = AllocationGroup(297)
        local unit    whichUnit   = GetRealSpellUnit(GetTriggerUnit())
        local integer level       = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local player  whichPlayer = GetOwningPlayer(whichUnit)
        local unit    first

        call GroupEnumUnitsInRect(g, bj_mapInitialPlayableArea, null)

        loop
            set first = FirstOfGroup(g)
            exitwhen first == null
            call GroupRemoveUnit(g, first)

            // 敌对英雄，并且存活，非米波复制体，非冰晶爆轰
            if IsUnitAlive(first) and IsUnitType(first, UNIT_TYPE_HERO) and IsUnitEnemy(first, whichPlayer) /*
                */ and GetUnitTypeId(first)!='H00J' and GetUnitTypeId(first)!='H0B8' then
                
                call ThundergodWrathTargetEffect(whichUnit, first, level)

            endif
            
        endloop

        call DeallocateGroup(g)
        set g = null
    endfunction

endscope
