
scope PhantomLancer

    //***************************************************************************
    //*
    //*  灵魂之矛
    //*
    //***************************************************************************
    function CreateSpiritLanceIllusion takes player p, unit whichUnit, unit targetUnit, integer lv returns nothing
        local real    damageDealt = 0.2
        local real    damageTaken = 4.0
        local real    duration    = 2 * lv
        local unit    illusionUnit
        local real    x
        local real    y
        
        set x = GetUnitX(targetUnit)
        set y = GetUnitY(targetUnit)
        set illusionUnit= CreateIllusion(GetOwningPlayer(whichUnit), whichUnit, damageDealt, damageTaken, x, y, 'Bpli', duration)
        call IssueTargetOrderById(illusionUnit, ORDER_attack, targetUnit)
    
        set illusionUnit = null
    endfunction
    function E9I takes unit whichUnit, player p, unit targetUnit, integer level, boolean hasEffect returns nothing
        local unit dummyCaster
        if hasEffect then
            set dummyCaster = CreateUnit(p,'e00E', GetUnitX(targetUnit), GetUnitY(targetUnit), 0)
            call UnitAddAbility(dummyCaster, 'A10C')
            call SetUnitAbilityLevel(dummyCaster, 'A10C', level)
            call IssueTargetOrderById(dummyCaster, 852189, targetUnit)
            call UnitDamageTargetEx(dummyCaster, targetUnit, 1, 50 + 50 * level)
            call CreateSpiritLanceIllusion(p, whichUnit, targetUnit, level)
            set dummyCaster = null
            if GetUnitAbilityLevel(targetUnit,'A3E9') == 1 and IsUnitMagicImmune(whichUnit) == false and HaveSavedHandle(HY, GetHandleId(whichUnit), 0) == false then
                call SaveUnitHandle(OtherHashTable2,'A3E9', 0, targetUnit)
                call SaveUnitHandle(OtherHashTable2,'A3E9', 1, whichUnit)
                call SaveInteger(OtherHashTable2,'A3E9', 0, level)
                call ExecuteFunc("XEI")
            endif
        endif
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl", targetUnit, "origin"))
    endfunction
    function XXI takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local player p
        local unit targetUnit
        local integer level
        local boolean hasEffect
        local unit missileDummy
        local real x
        local real y
        local real tx
        local real ty
        local real NAX
        local real NNX
        local real targetX
        local real targetY
        local boolean NDX
        local real NFX
        local real NGX
        if GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
            if OXX(GetSpellAbilityId()) then
                call SaveBoolean(HY, h, 0, true)
                call SaveReal(HY, h, 0, GetUnitX(GetTriggerUnit()))
                call SaveReal(HY, h, 1, GetUnitY(GetTriggerUnit()))
            endif
        else
            set p = LoadPlayerHandle(HY, h, 54)
            set targetUnit = LoadUnitHandle(HY, h, 30)
            set level = LoadInteger(HY, h, 5)
            set hasEffect = LoadBoolean(HY, h, 302)
            set missileDummy = LoadUnitHandle(HY, h, 45)
            set x = GetUnitX(missileDummy)
            set y = GetUnitY(missileDummy)
            set tx = GetUnitX(targetUnit)
            set ty = GetUnitY(targetUnit)
            set NAX = 1000* .035
            set NDX = LoadBoolean(HY, h, 0)
            if NDX then
                set tx = LoadReal(HY, h, 0)
                set ty = LoadReal(HY, h, 1)
            endif
            set NNX = AngleBetweenXY(x, y, tx, ty)
            set targetX = x + NAX * Cos(NNX * bj_DEGTORAD)
            set targetY = y + NAX * Sin(NNX * bj_DEGTORAD)
            call SetUnitX(missileDummy, targetX)
            call SetUnitY(missileDummy, targetY)
            call SetUnitFacing(missileDummy, NNX)
            if GetDistanceBetween(tx, ty, targetX, targetY)<= NAX then
                if NDX == false then
                    call E9I(LoadUnitHandle(HY, h, 31), p, targetUnit, level, hasEffect)
                endif
                call KillUnit(missileDummy)
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
            endif
        endif
        set t = null
        set targetUnit = null
        set missileDummy = null
        return false
    endfunction
    function UnitLaunchSpiritLance takes unit whichUnit, integer level, unit targetUnit, boolean hasEffect returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit missileDummy = CreateUnit(GetOwningPlayer(whichUnit),'h06L', GetUnitX(whichUnit), GetUnitY(whichUnit), AngleBetweenXY(GetUnitX(whichUnit), GetUnitY(whichUnit), GetUnitX(targetUnit), GetUnitY(targetUnit)))
        call SavePlayerHandle(HY, h, 54, GetOwningPlayer(whichUnit))
        call SaveUnitHandle(HY, h, 30,(targetUnit))
        call SaveUnitHandle(HY, h, 31,(whichUnit))
        call SaveBoolean(HY, h, 302, hasEffect)
        call SaveUnitHandle(HY, h, 45, missileDummy)
        call SaveInteger(HY, h, 5, level)
        call TriggerRegisterTimerEvent(t, .035, true)
        call SaveBoolean(HY, h, 0, false)
        call SaveReal(HY, h, 0, 0)
        call SaveReal(HY, h, 1, 0)
        call TriggerAddCondition(t, Condition(function XXI))
        call TriggerRegisterUnitEvent(t, targetUnit, EVENT_UNIT_SPELL_EFFECT)
        set t = null
        set missileDummy = null
    endfunction
    function XRI takes nothing returns boolean
        if IsUnitIllusion(GetFilterUnit()) and IsPlayerHasSkill(GetOwningPlayer(GetFilterUnit()), 83) and GetOwningPlayer(GetFilterUnit()) == GetOwningPlayer(GetTriggerUnit()) then
            call UnitLaunchSpiritLance(GetFilterUnit(), 3, GetSpellTargetUnit(), false)
        endif
        return false
    endfunction
    function SpiritLanceOnSpellEffect takes nothing returns nothing
        local unit trigUnit = GetTriggerUnit()
        local unit targetUnit = GetSpellTargetUnit()
        local integer level = GetUnitAbilityLevel(trigUnit,'A10D')
        local group g = AllocationGroup(244)
        call GroupEnumUnitsInRange(g, GetUnitX(trigUnit), GetUnitY(trigUnit), 700, Condition(function XRI))
        call DeallocateGroup(g)
        call UnitLaunchSpiritLance(trigUnit, level, targetUnit, not UnitHasSpellShield(GetSpellTargetUnit()))
        set trigUnit = null
        set targetUnit = null
    endfunction
    function XEI takes nothing returns nothing
        call T4V(LoadUnitHandle(OtherHashTable2,'A3E9', 0))
        call UnitLaunchSpiritLance(LoadUnitHandle(OtherHashTable2,'A3E9', 0), LoadInteger(OtherHashTable2,'A3E9', 0), LoadUnitHandle(OtherHashTable2,'A3E9', 1), UnitHasSpellShield(LoadUnitHandle(OtherHashTable2,'A3E9', 1)) == false)
        call FlushChildHashtable(OtherHashTable2,'A3E9')
    endfunction

    //***************************************************************************
    //*
    //*  幻影冲锋
    //*
    //***************************************************************************
    function PhantomRushEnd takes unit u, integer hu, trigger t returns nothing
        local integer h = GetHandleId(t)
        call UnitRemoveAbility(u,'A46F')
        call UnitRemoveAbility(u,'B46F')
        if GetUnitAbilityLevel(u,'A46D')> 0 and LoadBoolean(HY, h, 5) then
            call SetUnitNoLimitMoveSpeed(u, 0)
            call UnitSubPhasedMovementCount(u)
            call BJDebugMsg("不加速了")
        endif
        if GetHandleId(u)> 0 then
            call RemoveSavedHandle(HY, GetHandleId(u),'A46E')
        else
            call RemoveSavedHandle(HY, LoadInteger(HY, h, 0),'A46E')
        endif
        call FlushChildHashtable(HY, h)
        call DestroyTrigger(t)
    endfunction
    function PhantomRushOnUpdate takes nothing returns boolean
        local trigger t          = GetTriggeringTrigger()
        local integer h          = GetHandleId(t)
        local unit    u          = LoadUnitHandle(HY, h, 0)
        local integer hu         = LoadInteger(HY, h, 0)
        local unit    targetUnit = LoadUnitHandle(HY, h, 1)
        local real    distance
        local real    maxDist    = LoadReal(HY, h, 0)
        local real    x
        local real    y
        if GetTriggerEventId() == EVENT_WIDGET_DEATH then
            if GetTriggerUnit() == u then
                // 我死了 停了
                call PhantomRushEnd(u, hu, t)
            else
                if GetUnitCurrentOrder(u) != ORDER_move then
                    // 对面死了，奔现最后地点
                    call DisableTrigger(t)
                    call IssuePointOrderById(u, ORDER_move, LoadReal(HY, h, 10), LoadReal(HY, h, 11))
                    call EnableTrigger(t)
                endif
            endif
        elseif GetTriggerEventId() == EVENT_UNIT_ATTACKED then
            // 我进入射程就停了
            if GetAttacker() == u then
                call PhantomRushEnd(u, hu, t)
            endif
        elseif GetTriggerEventId() == EVENT_UNIT_ISSUED_ORDER or GetTriggerEventId() == EVENT_UNIT_ISSUED_TARGET_ORDER or GetTriggerEventId() == EVENT_UNIT_ISSUED_POINT_ORDER then
            // 转移目标就停了
            if GetIssuedOrderId()!= ORDER_attack and not(GetIssuedOrderId()==ORDER_smart and GetOrderTargetUnit()!= null and IsUnitEnemy(GetOrderTargetUnit(), GetOwningPlayer(u))) then
                call PhantomRushEnd(u, hu, t)
            endif
        else
            // 目标晕 隐藏 妖术 就停了
            if IsUnitStunned(u) or IsUnitHidden(u) or IsUnitHexed(u) or(LoadBoolean(HY, h, 5) and GetUnitAbilityLevel(u,'A46F') == 0) then
                call PhantomRushEnd(u, hu, t)
            else
                set distance = GetUnitDistanceEx(u, targetUnit)
                // 目标看不见了或无敌 就追到最后一次的位置
                if LoadBoolean(HY, h, 5) and(distance > (maxDist + 150) or not IsUnitVisibleToPlayer(targetUnit, GetOwningPlayer(u)) or IsUnitInvulnerable(targetUnit)) then
                    // 就走到那里
                    if GetUnitCurrentOrder(u)!= ORDER_move then
                        if LoadBoolean(HY, h, 0) then
                            // 已经发布过移动命令了 我就停止了
                            call PhantomRushEnd(u, hu, t)
                        else
                            // 还是处于攻击命令就到最后的地点
                            call DisableTrigger(t)
                            call SaveBoolean(HY, h, 0, true)
                            call IssuePointOrderById(u, ORDER_move, LoadReal(HY, h, 10), LoadReal(HY, h, 11))
                            call EnableTrigger(t)
                        endif
                    elseif GetDistanceBetween(GetUnitX(u), GetUnitY(u), LoadReal(HY, h, 10), LoadReal(HY, h, 11))<= 120 then
                        call PhantomRushEnd(u, hu, t)
                    endif
                elseif not LoadBoolean(HY, h, 5) then
                    if not LoadBoolean(HY, h, 0) and GetUnitAbilityLevel(u,'A46F') == 0 and distance <= maxDist and GetUnitAbilityLevel(u,'A46D')> 0 then
                        call UnitAddPermanentAbility(u,'A46F')
                        // 相位移动
                        call SetUnitNoLimitMoveSpeed(u, 800)
                        call StartUnitAbilityCooldown(u, 'A46D')
                        //if GetUnitAbilityLevel(u,'A46D')> 0 then
                        //    call SaveReal(HY, GetHandleId(u),'A46E', GetGameTime())
                        //endif
                        call UnitAddPhasedMovementCount(u)
                        call SaveBoolean(HY, h, 5, true)
                        call BJDebugMsg("加速了")
                    endif
                elseif GetDistanceBetween(GetUnitX(u), GetUnitY(u), LoadReal(HY, h, 10), LoadReal(HY, h, 11))<= 100 then
                    call PhantomRushEnd(u, hu, t)
                else
                    // 存敌人最后的位置
                    call SaveReal(HY, h, 10, GetUnitX(targetUnit))
                    call SaveReal(HY, h, 11, GetUnitY(targetUnit))
                    call SaveBoolean(HY, h, 0, false)
                endif
            endif
        endif
        set t = null
        return false
    endfunction
    function OnPhantomRush takes nothing returns nothing
        local trigger t
        local integer h
        local unit    u          = GetTriggerUnit()
        local integer hu         = GetHandleId(u)
        local integer level      = GetUnitAbilityLevel(u,'A46D')
        local unit    targetUnit = GetOrderTargetUnit()
        local real    distance   = GetUnitDistanceEx(u, targetUnit)
        local real    maxDist    = 500 + 100 * level
        local unit    lastTarget
        if distance > 200. and MHAbility_GetCooldown(u, 'A46D') == 0. then
            if HaveSavedHandle(HY, hu,'A46E') then
                set t = LoadTriggerHandle(HY, hu,'A46E')
                set h = GetHandleId(t)
                set lastTarget = LoadUnitHandle(HY, h, 1)
                if lastTarget != targetUnit then
                    call PhantomRushEnd(u, hu, t)
                endif
            else
                set t = CreateTrigger()
                set h = GetHandleId(t)
                call SaveTriggerHandle(HY, hu,'A46E', t)
                call SaveUnitHandle(HY, h, 0, u)
                call SaveInteger(HY, h, 0, hu)
                call SaveUnitHandle(HY, h, 1, targetUnit)
                call TriggerRegisterTimerEvent(t, .02, true)
                call TriggerRegisterTimerEvent(t, 0, false)
                call TriggerRegisterUnitEvent(t, targetUnit, EVENT_UNIT_ATTACKED)
                call TriggerRegisterDeathEvent(t, targetUnit)
                call TriggerRegisterDeathEvent(t, u)
                call TriggerRegisterUnitEvent(t, u, EVENT_UNIT_ISSUED_ORDER)
                call TriggerRegisterUnitEvent(t, u, EVENT_UNIT_ISSUED_POINT_ORDER)
                call TriggerRegisterUnitEvent(t, u, EVENT_UNIT_ISSUED_TARGET_ORDER)
                call TriggerAddCondition(t, Condition(function PhantomRushOnUpdate))
            endif
            call SaveReal(HY, h, 0, maxDist)
            call SaveReal(HY, h, 10, GetUnitX(targetUnit))
            call SaveReal(HY, h, 11, GetUnitY(targetUnit))
        endif
        set u = null
        set targetUnit = null
        set t = null
    endfunction
    // 幻影冲锋 右键
    function PhantomLancerOnTargetOrder takes nothing returns boolean
        local unit source = GetTriggerUnit()
        local unit target = GetOrderTargetUnit()
        if target != null and IsUnitEnemy(target, GetOwningPlayer(source)) and(GetIssuedOrderId()== ORDER_attack or GetIssuedOrderId()== ORDER_smart) then
            if GetUnitAbilityLevel(source,'A46D')> 0 and not IsUnitBroken(source) then
                call OnPhantomRush()
            endif
        endif
        set source = null
        set target = null
        return false
    endfunction
    // 幻影冲锋
    function XLI takes nothing returns boolean
        local unit u
        if IsUnitIllusion(GetTriggerUnit()) then
            set u = PlayerHeroes[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))]
            if GetUnitAbilityLevel(u,'A46E')> 0 and GetUnitTypeId(GetTriggerUnit()) == GetUnitTypeId(u) then
                call UnitAddPermanentAbility(GetTriggerUnit(),'A46D')
                call SetUnitAbilityLevel(GetTriggerUnit(),'A46D', GetUnitAbilityLevel(u,'A46E'))
            endif
        endif
        set u = null
        return false
    endfunction
    // 注册幻影长矛手触发器
    function RegisterPhantomLancerTrigger takes nothing returns nothing
        local trigger t = CreateTrigger()
        call TriggerRegisterAnyUnitEvent(t, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
        call TriggerAddCondition(t, Condition(function PhantomLancerOnTargetOrder))
        set t = CreateTrigger()
        call YDWETriggerRegisterEnterRectSimpleNull(t, GetWorldBounds())
        call TriggerAddCondition(t, Condition(function XLI))
        set t = null
    endfunction

endscope
