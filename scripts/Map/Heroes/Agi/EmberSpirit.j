
scope EmberSpirit

    //***************************************************************************
    //*
    //*  无影拳
    //*
    //***************************************************************************
    function KUA takes nothing returns nothing
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = LoadUnitHandle(HY, h, 0)
        local unit targetUnit = LoadUnitHandle(HY, h, 1)
        local group g = LoadGroupHandle(HY, h, 2)
        local group gg = LoadGroupHandle(HY, h, 3)
        if GetTriggerEventId() == EVENT_UNIT_DAMAGED then
            if GetEventDamageSource() == whichUnit and AD < 1 then
                call GroupAddUnit(g, targetUnit)
                call GroupRemoveUnit(gg, targetUnit)
                call FlushChildHashtable(HY, h)
                call AddTriggerToDestroyQueue(t)
            endif
        else
            call FlushChildHashtable(HY, h)
            call AddTriggerToDestroyQueue(t)
        endif
        set whichUnit = null
        set targetUnit = null
        set t = null
    endfunction
    function KYA takes unit whichUnit, unit targetUnit, integer level returns nothing
        local real a = GetRandomReal(0, 360)
        local real x = GetUnitX(targetUnit)+ 50 * Cos(a * bj_DEGTORAD)
        local real y = GetUnitY(targetUnit)+ 50 * Sin(a * bj_DEGTORAD)
        local trigger t = null
        local integer h
        call SetUnitPosition(whichUnit, x, y)
        call SetUnitFacing(whichUnit, bj_RADTODEG * Atan2(GetUnitY(targetUnit)-GetUnitY(whichUnit), GetUnitX(targetUnit)-GetUnitX(whichUnit)))
        call SetUnitAnimation(whichUnit, "Attack")
        call DestroyEffect(AddSpecialEffectTarget("war3mapImported\\Fire_Blink_2.mdx", whichUnit, "chest"))
        call KMA(whichUnit)
        if IsUnitType(targetUnit, UNIT_TYPE_HERO) or IsUnitIllusion(targetUnit) then
            call KTA(whichUnit, level)
            call UnitRemoveAbility(whichUnit,'A2JF')
            if Mode__BalanceOff == false then
                if (GetUnitAbilityLevel(whichUnit,'A1J2')> 0) then
                    call SetUnitAbilityLevel(whichUnit,'A1J2', 2)
                elseif (GetUnitAbilityLevel(whichUnit,'A1IT')> 0) then
                    call SetUnitAbilityLevel(whichUnit,'A1IT', 2)
                elseif (GetUnitAbilityLevel(whichUnit,'A1J1')> 0) then
                    call SetUnitAbilityLevel(whichUnit,'A1J1', 2)
                elseif (GetUnitAbilityLevel(whichUnit,'A1J0')> 0) then
                    call SetUnitAbilityLevel(whichUnit,'A1J0', 2)
                endif
            endif
        else
            // 对小兵50%伤害
            call UnitAddPermanentAbility(whichUnit,'A2JF')
            call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A2JF', false)
        endif

        if IssueTargetOrderById(whichUnit, 851983, targetUnit) then
            set t = CreateTrigger()
            call TriggerRegisterUnitEvent(t, targetUnit, EVENT_UNIT_DAMAGED)
            call TriggerRegisterTimerEvent(t, .2, false)
            call TriggerAddCondition(t, Condition(function KUA))
            set h = GetHandleId(t)
            call SaveUnitHandle(HY, h, 0, whichUnit)
            call SaveUnitHandle(HY, h, 1, targetUnit)
            call SaveGroupHandle(HY, h, 2, LoadGroupHandle(HY, GetHandleId(GetTriggeringTrigger()), 187))
            call SaveGroupHandle(HY, h, 3, LoadGroupHandle(HY, GetHandleId(GetTriggeringTrigger()), 22))
            set t = null
        else
            call GroupAddUnit(LoadGroupHandle(HY, GetHandleId(GetTriggeringTrigger()), 187), targetUnit)
            call GroupRemoveUnit(LoadGroupHandle(HY, GetHandleId(GetTriggeringTrigger()), 22), targetUnit)
        endif
    endfunction
    // 移除所有缠绕效果
    function KZA takes unit u returns nothing
        call FHX(u)
    endfunction
    function SleightOfFistUpdateAttack takes nothing returns boolean
        local trigger     t = GetTriggeringTrigger()
        local integer     h = GetHandleId(t)
        local unit        u = LoadUnitHandle(HY, h, 2)
        local real        x = LoadReal(HY, h, 6)
        local real        y = LoadReal(HY, h, 7)
        local group       targGroup = LoadGroupHandle(HY, h, 187)
        local group       g = LoadGroupHandle(HY, h, 22)
        local unit        target = null
        local boolean     b = false
        local fogmodifier fm = LoadFogModifierHandle(HY, h, 42)
        local trigger     tt
        loop
        exitwhen FirstOfGroup(g) == null or b
            set target = FirstOfGroup(g)
            call GroupRemoveUnit(g, target)
            if UnitIsDead(target) then
                call GroupRemoveUnit(g, target)
            elseif IsUnitInGroup(target, targGroup) and target != null then
                set target = null
                set b = false
            else
                set b = true
            endif
        endloop
        call KZA(u)
        if b == false or(LoadInteger(HY, GetHandleId(u), 4319)) == 1 or UnitIsDead(u) then
            call SaveInteger(HY, GetHandleId(u), 4318, 2)
            call KLA(u)
            call UnitRemoveAbility(u,'QF90')
            call UnitRemoveAbility(u,'QF91')
            call UnitRemoveAbility(u,'QF92')
            call UnitRemoveAbility(u,'QF93')
            call UnitRemoveAbility(u,'QF94')
            call UnitRemoveAbility(u,'QF95')
            call UnitRemoveAbility(u,'A2JF')
            call KMA(u)
            call KZA(u)
            call KKA(u)
            //	call UnitAddAbility(u,'A2H2')
            //	call UnitRemoveAbility(u,'A2H2')
            call SetPlayerAbilityAvailable(GetOwningPlayer(u),'A1UL', true)
            //	call RAX(u, LoadInteger(HY, h, 25))
            call YDWEUnitTransform( u, LoadInteger(ExtraHT, GetHandleId(u), HTKEY_UNIT_ORIGIN_TYPEID ) )
            call SetUnitCurrentScaleEx(u, GetUnitCurrentScale(u))
            //call FixUnitSkillsBug(u)
            if (LoadInteger(HY, GetHandleId(u), 4319) == 1) == false then
                call SetUnitX(u, LoadReal(HY, h, 189))
                call SetUnitY(u, LoadReal(HY, h, 190))
            endif
            call ResetUnitVertexColor(u)
            call SetUnitVertexColorEx(u,-1,-1,-1, 255)
            call UnitSubNoPathingCount(u)
            call UnitSubInvulnerableCount(u)
            if GetUnitAbilityLevel(u,'A0MQ')+ GetUnitAbilityLevel(u,'A1B6')> 0 then
                call SetPlayerAbilityAvailable(GetOwningPlayer(u),'A0MQ', true)
                call SetPlayerAbilityAvailable(GetOwningPlayer(u),'A1B6', true)
            endif
            call SetUnitTimeScale(u, 1)
            call DeallocateGroup(targGroup)
            call DeallocateGroup(g)
            call RemoveUnit((LoadUnitHandle(HY, h, 19)))
            call FogModifierStop(fm)
            call DestroyFogModifier(fm)
            call FlushChildHashtable(HY, h)
            call AddTriggerToDestroyQueue(t)
        else
            call GroupAddUnit(targGroup, target)
            call KYA(u, target, LoadInteger(HY, h, 0) )
        endif
        set fm = null
        set t = null
        set u = null
        set target = null
        set g = null
        set tt = null
        set targGroup = null
        return false
    endfunction
    function SleightOfFistDelay takes nothing returns nothing
        local timer       t = GetExpiredTimer()
        local integer     h = GetHandleId(t)
        local unit        u = LoadUnitHandle(HY, h, 0)
        local real        x = LoadReal(HY, h, 1)
        local real        y = LoadReal(HY, h, 2)
        local integer     lv = LoadInteger(HY, h, 0)
        local trigger     tt = CreateTrigger()
        local integer     th = GetHandleId(tt)
        local fogmodifier fm = CreateFogModifierRadius(GetOwningPlayer(u), FOG_OF_WAR_VISIBLE, x, y, 600, true, true)
        local unit        dummyCaster = CreateUnit(GetOwningPlayer(u),'h0E7', GetUnitX(u), GetUnitY(u), GetUnitFacing(u))
        local group       g  = AllocationGroup(465)
        local group       targGroup  = AllocationGroup(466)
        local integer     id = O5X(GetUnitTypeId(u))
        local real        modelScale
        local unit        first
        local real        area = 150 + 100 * lv
        local player      p    = GetOwningPlayer(u)
        
        call FlushChildHashtable(HY, h)
        call DestroyTimer(t)

        call UnitRemoveAbility(u,'B01N')
        call UnitRemoveAbility(u,'Aetl')
        call SetUnitVertexColor(dummyCaster, 255, 255, 255, 100)
        call FogModifierStart(fm)
        call SaveInteger(HY, GetHandleId(u), 4318, 1)

        call BJDebugMsg("1")
        call GroupEnumUnitsInRange(g, x, y, area, null)
        loop
            set first = FirstOfGroup(g)
            exitwhen first == null
            call GroupRemoveUnit(g, first)
            if IsAliveNotStrucNotWard(first) and IsUnitInRangeXY(first, x, y, area) and UnitVisibleToPlayer(first, p) and IsUnitEnemy(first, p) then
                call GroupAddUnit(targGroup, first)
            endif
        endloop

        call DeallocateGroup(g)

        call KZA(u)
        call KKA(u)
        if GetUnitAbilityLevel(u,'A0MQ')+ GetUnitAbilityLevel(u,'A1B6')> 0 then
            call SetPlayerAbilityAvailable(GetOwningPlayer(u),'A0MQ', false)
            call SetPlayerAbilityAvailable(GetOwningPlayer(u),'A1B6', false)
        endif
        call SetPlayerAbilityAvailable(GetOwningPlayer(u),'A1UL', false)
        
        //call YDWEUnitTransform(u,'N0MH')

        // 获取火猫的模型缩放后
        set modelScale = SetUnitCurrentScaleEx(u, GetUnitCurrentScale(u))
        call SetUnitScale(dummyCaster, modelScale, modelScale, modelScale)
        //call MHUnit_SetModel(dummyCaster, MHUnit_GetDefDataStr(GetUnitTypeId(u), UNIT_DEF_DATA_MODEL), false)

        //call FixUnitSkillsBug(u)
        call SetUnitVertexColorEx(u, -1, -1, -1, 125)
        call UnitAddNoPathingCount(u)
        call UnitAddInvulnerableCount(u)
        call SetUnitTimeScale(u, 3)
        call TriggerRegisterTimerEvent(tt, .2, true)
        call TriggerAddCondition(tt, Condition(function SleightOfFistUpdateAttack))
        call SaveUnitHandle(HY, th, 2, u)
        call SaveInteger(HY, th, 0, lv)
        call SaveReal(HY, th, 6, x * 1.)
        call SaveReal(HY, th, 7, y * 1.)
        call SaveReal(HY, th, 189, GetUnitX(u)* 1.)
        call SaveReal(HY, th, 190, GetUnitY(u)* 1.)
        call SaveGroupHandle(HY, th, 187, AllocationGroup(466))
        call SaveGroupHandle(HY, th, 22, targGroup)
        call SaveFogModifierHandle(HY, th, 42, fm)
        call SaveUnitHandle(HY, th, 19, dummyCaster)
        call KSA(u)
        call TriggerEvaluate(tt)
        set u = null
        set t = null
        set fm = null
        set dummyCaster = null
        set g = null
        set tt = null
    endfunction
    function SleightOfFistOnSpellEffect takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local real x = GetSpellTargetX()
        local real y = GetSpellTargetY()
        local integer level = GetUnitAbilityLevel(u,'A2H0')+ GetUnitAbilityLevel(u,'QB0L')
        local timer t = CreateTimer()
        local integer h = GetHandleId(t)
        call SaveUnitHandle(HY, h, 0, u)
        call SaveReal(HY, h, 1, x)
        call SaveReal(HY, h, 2, y)
        call SaveInteger(HY, h, 0, level)
        call TimerStart(t, 0, false, function SleightOfFistDelay)
        set t = null
        set u = null
    endfunction

endscope
