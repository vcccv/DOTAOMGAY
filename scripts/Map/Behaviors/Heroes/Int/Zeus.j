
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
        constant integer SKILL_INDEX_LIGHTNING_BOLT = GetHeroSKillIndexBySlot(HERO_INDEX_ZEUS, 3)
    endglobals
    function DLI takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) and IsAliveNotStrucNotWard(GetFilterUnit()) and IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(TempUnit)) and IsUnitMagicImmune(GetFilterUnit()) == false) != null
    endfunction
    function DMI takes unit u, unit t, integer lv, boolean FAR, real x, real y returns nothing
        local unit d
        local real damageValue = 25 + lv * 75
        local group g
        if lv == 3 then
            set damageValue = 275
        endif
        if lv == 4 then
            set damageValue = 350
        endif
        if t == null then
            set g = AllocationGroup(299)
            set TempUnit = u
            call GroupEnumUnitsInRange(g, x, y, 425, Condition(function DLI))
            set t = GetClosestUnitInGroup(g, x, y)
            call DeallocateGroup(g)
            set g = null
        endif
        if t != null and UnitHasSpellShield(t) == false then
            if GetUnitAbilityLevel(t,'A3E9') == 1 and IsUnitMagicImmune(u) == false and FAR == false then
                call SaveUnitHandle(OtherHashTable2,'A3E9', 0, t)
                call SaveUnitHandle(OtherHashTable2,'A3E9', 1, u)
                call SaveInteger(OtherHashTable2,'A3E9', 0, lv)
                call ExecuteFunc("DPI")
            endif
            set x = GetUnitX(t)
            set y = GetUnitY(t)
            call TDV(t)
            call IOX(u, t, 1, damageValue, .25)
        endif
        set d = CreateUnit(GetOwningPlayer(u),'e000', x, y, 0)
        call UnitAddAbility(d,'Aloc')
        call UnitAddAbility(d,'A3FR')
        call UnitApplyTimedLife(d,'BTLF', 4.5)
        call SetUnitPathing(d, false)
        if t == null or IssueTargetOrderById(d, 852119, t) == false then
            set t = CreateUnit(GetOwningPlayer(u),'e00C', x, y, 0)
            call UnitApplyTimedLife(t,'BTLF', .2)
            call UnitAddAbility(t,'Aetl')
            call IssueTargetOrderById(d, 852119, t)
            call DestroyEffect(AddSpellEffectById('A3FR', EFFECT_TYPE_TARGET, x, y))
        endif
        set g = null
        set d = null
    endfunction
    function LightningBoltOnSpellEffect takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local unit t = GetSpellTargetUnit()
        call DMI(u, t, GetUnitAbilityLevel(u,'A0JC'), false, GetSpellTargetX(), GetSpellTargetY())
        set u = null
        set t = null
    endfunction
    function DPI takes nothing returns nothing
        local unit whichUnit = LoadUnitHandle(OtherHashTable2,'A3E9', 0)
        local unit targetUnit = LoadUnitHandle(OtherHashTable2,'A3E9', 1)
        local integer lv = LoadInteger(OtherHashTable2,'A3E9', 0)
        call T4V(LoadUnitHandle(OtherHashTable2,'A3E9', 0))
        call DMI(whichUnit, targetUnit, lv, true, GetUnitX(targetUnit), GetUnitY(targetUnit))
        set whichUnit = null
        set targetUnit = null
        call FlushChildHashtable(OtherHashTable2,'A3E9')
    endfunction
    function ETI takes nothing returns nothing
        local unit u = LoadUnitHandle(OtherHashTable2,'A3E9', 0)
        local integer lv = LoadInteger(OtherHashTable2,'A3E9', 0)
        local real x = LoadReal(OtherHashTable2,'A3E9', 0)
        local real y = LoadReal(OtherHashTable2,'A3E9', 1)
        call DMI(u, null, lv, true, x, y)
        set u = null
        call FlushChildHashtable(OtherHashTable2,'A3E9')
    endfunction
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
        local unit      t
        local integer   id ='A06L'

        /*
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
        
        */
        if GetSpellAbilityId() != 'A29G' then
            set id = 'A07C'
        endif
        call UnitAddAbility(d,'Aloc')
        call UnitApplyTimedLife(d,'BTLF', 3.)
        call UnitAddAbility(d, id)
        call SetUnitAbilityLevel(d, id, level)

        // 劈不到就劈地板
        if IsUnitTruesightImmunity(targetUnit) or not IssueTargetOrderById(d, 852119, targetUnit) then
            set t = CreateUnit(GetOwningPlayer(soruceUnit),'e00C', x, y, 0)
            call UnitApplyTimedLife(t,'BTLF', .2)
            call UnitAddAbility(t,'Aetl')
            call IssueTargetOrderById(d, 852119, t)
            call DestroyEffect(AddSpellEffectById('A3FR', EFFECT_TYPE_TARGET, x, y))
        endif
        set d = null
        set t = null
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
