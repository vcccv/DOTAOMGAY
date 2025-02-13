
scope Kunkka

    //***************************************************************************
    //*
    //*  潮汐使者
    //*
    //***************************************************************************
    // 2022/1/12 A13T 和 A522 数据互换 不必使用魔法护盾来实现技能cd 重生已经可以
    function Fix_Tidebringer_Add takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = LoadUnitHandle(HY, h, 0)
        local integer level = LoadInteger(HY, h, 1)
        local integer iUnitHandleId = GetHandleId(whichUnit)
        if UnitAlive(whichUnit) then
            call UnitAddStateBonus(whichUnit, 15 * level + 5, UNIT_BONUS_DAMAGE)
            call UnitAddPermanentAbility(whichUnit,'A147')
            call SetUnitAbilityLevel(whichUnit,'A146', level)
            call UnitMakeAbilityPermanent(whichUnit, true,'A146')

            // debug call SingleDebug( "存活，可再加技能" )
            call SaveBoolean(ExtraHT, iUnitHandleId, HTKEY_SKILL_TIDEBRINGER, true)
            call SaveEffectHandle(ExtraHT, iUnitHandleId, HTKEY_SKILL_TIDEBRINGER, AddSpecialEffectTarget("effects\\WaterHands.mdx", whichUnit, GetHeroWeaponAttachPointName(whichUnit)))
            call DestroyTrigger(t)
            call FlushChildHashtable(HY, h)
        endif
        set t = null
        set whichUnit = null
        return false
    endfunction
    // 添加潮汐使者效果
    function Tidebringer_Add takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local trigger trig = null
        local unit whichUnit = LoadUnitHandle(HY, GetHandleId(t), 0)
        local integer level = GetUnitAbilityLevel(whichUnit,'A13T')
        local integer iHandleId = GetHandleId(whichUnit)
        if not UnitAlive(whichUnit) then
            set trig = CreateTrigger()
            call TriggerRegisterTimerEvent(trig, 1, true)
            call TriggerAddCondition(trig, Condition(function Fix_Tidebringer_Add))
            call SaveUnitHandle(HY, GetHandleId(trig), 0, whichUnit)
            call SaveInteger(HY, GetHandleId(trig), 1, level)
            set trig = null
        else
            call UnitAddStateBonus(whichUnit, 15 * level + 5, UNIT_BONUS_DAMAGE)
            call UnitAddPermanentAbility(whichUnit,'A147')
            call SetUnitAbilityLevel(whichUnit,'A146', level)
            call UnitMakeAbilityPermanent(whichUnit, true,'A146')
            set iHandleId = GetHandleId(whichUnit)
            call SaveBoolean(ExtraHT, iHandleId, HTKEY_SKILL_TIDEBRINGER, true)
            call SaveEffectHandle(ExtraHT, iHandleId, HTKEY_SKILL_TIDEBRINGER, AddSpecialEffectTarget("effects\\WaterHands.mdx", whichUnit, GetHeroWeaponAttachPointName(whichUnit)))
        endif
        call DestroyTimerAndFlushHT_P(t)
        set t = null
        set whichUnit = null
    endfunction

    function Tidebringer_Ranged takes unit whichUnit, unit targetUnit, real attackDmg, integer level returns nothing
        local real x1 = GetUnitX(whichUnit)
        local real y1 = GetUnitY(whichUnit)
        local real range = 525 + 100 *(level / 4)
        local real radian = GetUnitFacing(whichUnit) * bj_DEGTORAD
        local real x2 = x1 + range * Cos(radian)
        local real y2 = y1 + range * Sin(radian)
        local real targetUnitArmor = GetUnitState(targetUnit, UNIT_STATE_ARMOR)
        local real reduceRatio = 1
        local unit firstUnit = null
        // 逆推税前伤害
        if IsUnitDefenseTypeFort(targetUnit) then
            set attackDmg = attackDmg * 2
        endif
        if targetUnitArmor >= 0 then
            set reduceRatio = 0.06 * targetUnitArmor / (0.06 * targetUnitArmor + 1)
            set reduceRatio = 1 - reduceRatio
        elseif targetUnitArmor < 0 then
            set reduceRatio = 2 - Pow(1 -0.06, -targetUnitArmor)
        endif
        set attackDmg = attackDmg / reduceRatio
        if IsUnitIllusion(targetUnit) then
            set attackDmg = attackDmg / GetIllusionDamageTaken(targetUnit)
        endif
        if Mode__RearmCombos then
            set Temp__ArrayReal[0]= attackDmg
        else
            set Temp__ArrayReal[0]= attackDmg * .8
        endif
        set Temp__ArrayUnit[0]= whichUnit
        set Temp__ArrayUnit[1]= targetUnit
        set Temp__Player = GetOwningPlayer(whichUnit)
        call GroupEnumUnitsInRange( AK, x2, y2, range, null )
        call GroupRemoveUnit( AK, targetUnit ) // 移除攻击目标 防止造成第二次伤害
        loop
            set firstUnit = FirstOfGroup(AK)
        exitwhen firstUnit == null
            call GroupRemoveUnit(AK, firstUnit)
            // 敌对 非守卫 非建筑 存活
            if IsUnitEnemy(firstUnit, Temp__Player) and not IsUnitWard(firstUnit) and not IsUnitType(firstUnit, UNIT_TYPE_STRUCTURE) and UnitAlive(firstUnit) then
                call UnitDamageTargetEx(Temp__ArrayUnit[0], firstUnit, 2, Temp__ArrayReal[0])
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Weapons\\WaterElementalMissile\\WaterElementalMissile.mdl", firstUnit, "chest"))
            endif
        endloop
        set firstUnit = null
    endfunction

    function IsUnitTidebringerAvailable takes unit whichUnit returns boolean
        return (YDWEGetUnitAbilityState(whichUnit, 'A522', 1) == 0)
    endfunction

    function Tidebringer_Actions takes unit whichUnit, unit targetUnit, real attackDmg returns nothing
        local integer iHandleId = GetHandleId(whichUnit)
        local integer level = GetUnitAbilityLevel(whichUnit,'A522')
        local real cooldown = 16 - 3 * level
        local integer timerHandleId = TimerStartSingle( cooldown, function Tidebringer_Add )
        call SaveUnitHandle(HY, timerHandleId, 0, whichUnit)
        // 移除潮汐使者效果
        call SaveBoolean(ExtraHT, iHandleId, HTKEY_SKILL_TIDEBRINGER, false)
        call DestroyTimerAndFlushHT_P(LoadTimerHandle(ExtraHT, iHandleId, HTKEY_SKILL_TIDEBRINGER))
        call DestroyEffect(LoadEffectHandle(ExtraHT, iHandleId, HTKEY_SKILL_TIDEBRINGER))
        call RemoveSavedHandle(ExtraHT, iHandleId, HTKEY_SKILL_TIDEBRINGER)

        call UnitReduceStateBonus(whichUnit, level * 15+ 5, UNIT_BONUS_DAMAGE)
        call UnitRemoveAbility(whichUnit,'A147')
        //call YDWESetUnitAbilityState(whichUnit,'A522', 1, cooldown)

        call StartUnitAbilityCooldown(whichUnit, 'A522')

        if IsUnitType(whichUnit, UNIT_TYPE_RANGED_ATTACKER) then
            call Tidebringer_Ranged(whichUnit, targetUnit, attackDmg, level) // 远程
        endif
    endfunction

    function DamagedEvent__Tidebringer takes nothing returns nothing
        local integer h = GetHandleId(DESource)
        if IsUnitTidebringerAvailable(DESource) and LoadBoolean(ExtraHT, h, HTKEY_SKILL_TIDEBRINGER) and IsUnitEnemy(DESource, GetOwningPlayer(DETarget)) and(IsUnitType(DESource, UNIT_TYPE_MELEE_ATTACKER) or not IsUnitIllusion(DETarget)) then
            call Tidebringer_Actions(DESource, DETarget, DEDamage)
        endif
    endfunction
    
    function LearnSkill__Tidebringer takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local integer h = GetHandleId(u)
        local boolean isDestroyEffect = IsUnitBroken(u) // 破坏效果
        // 如果有水刀 而且不是禁用技能状态 + 15 攻击力
        if LoadBoolean(ExtraHT, h, HTKEY_SKILL_TIDEBRINGER) and not isDestroyEffect then
            call UnitAddStateBonus(u, 15, UNIT_BONUS_DAMAGE)
        elseif GetUnitAbilityLevel(u,'A13T') == 1 then
            if not isDestroyEffect then
                call UnitAddStateBonus(u, 15 + 5, UNIT_BONUS_DAMAGE)
                call SaveEffectHandle(ExtraHT, h, HTKEY_SKILL_TIDEBRINGER, AddSpecialEffectTarget("effects\\WaterHands.mdx", u, GetHeroWeaponAttachPointName(u)))
            endif
            call SaveBoolean(ExtraHT, h, HTKEY_SKILL_TIDEBRINGER, true)
            if not isDestroyEffect then
                if IsUnitType(u, UNIT_TYPE_MELEE_ATTACKER) then // 如果是近战 就加分裂技能
                    call UnitAddPermanentAbility(u,'A147')
                    call UnitMakeAbilityPermanent(u, true,'A146')
                endif
            endif
        endif
        call SetUnitAbilityLevel(u,'A146', GetUnitAbilityLevel(u,'A13T'))
        set u = null
        set u = null
    endfunction
    function S5A takes nothing returns nothing
        if SpellDamageCount < 1 and DEDamage > 40 or IsUnitType(DETarget, UNIT_TYPE_STRUCTURE) then
            call Tidebringer_Actions(DESource, DETarget, DEDamage)
        endif
    endfunction

endscope
