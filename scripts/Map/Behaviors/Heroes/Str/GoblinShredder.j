
scope GoblinShredder

    globals
        constant integer HERO_INDEX_GOBLIN_SHREDDER = 57
    endglobals

    //***************************************************************************
    //*
    //*  伐木锯链
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_TIMBER_CHAIN = GetHeroSKillIndexBySlot(HERO_INDEX_GOBLIN_SHREDDER, 2)
    endglobals

    function MFA takes unit whichUnit, unit targetUnit returns nothing
        local integer level = KI
        call UnitDamageTargetEx(whichUnit, targetUnit, 3, 60 + 40 * level)
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl", targetUnit, "origin"))
    endfunction
    function MGA takes nothing returns nothing
        if IsUnitInGroup(GetEnumUnit(), DK) == false then
            call GroupAddUnit(DK, GetEnumUnit())
            call MFA(TempUnit, GetEnumUnit())
        endif
    endfunction
    function MHA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit trigUnit = LoadUnitHandle(HY, h, 14)
        local unit targetUnit = LoadUnitHandle(HY, h, 17)
        local integer KFR = LoadInteger(HY, h, 18)
        local integer count = GetTriggerEvalCount(t)
        local unit KGR
        local group KHR = LoadGroupHandle(HY, h, 16)
        local group g
        local boolean SKX = LoadBoolean(HY, h, 727)
        local boolean MJA = LoadBoolean(HY, h, 740)
        set KI = LoadInteger(HY, h, 0)
        if C5X(trigUnit) then
            set MJA = true
            call SaveBoolean(HY, h, 740, MJA)
        endif
        if SKX == false then
            set KGR = LoadUnitHandle(HY, h, 700 + KFR + 1 -count)
            call RemoveUnit(KGR)
        else
            set KGR = LoadUnitHandle(HY, h, 700 + count)
            if MJA == false then
                if IsUnitType(trigUnit, UNIT_TYPE_HERO) then
                    call SaveBoolean(OtherHashTable, GetHandleId(trigUnit), 99, true)
                endif
                call SetUnitX(trigUnit, GetUnitX(KGR))
                call SetUnitY(trigUnit, GetUnitY(KGR))
            endif
            call RemoveUnit(KGR)
            set g = AllocationGroup(474)
            set TempUnit = trigUnit
            set DK = KHR
            call GroupEnumUnitsInRange(g, GetUnitX(trigUnit), GetUnitY(trigUnit), 250, Condition(function DMX))
            call ForGroup(g, function MGA)
            call DeallocateGroup(g)
        endif
        if count ==(KFR) then
            call KillTreeByCircle(GetUnitX(trigUnit), GetUnitY(trigUnit), 90)
            call DeallocateGroup(KHR)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        endif
        set t = null
        set trigUnit = null
        set targetUnit = null
        set KGR = null
        set KHR = null
        set g = null
        return false
    endfunction
    function MKA takes nothing returns nothing
        if IsTreeDestructable(GetEnumDestructable()) and IsDestructableDeadBJ(GetEnumDestructable()) == false then
            set QYV = QYV + 1
        endif
    endfunction
    function MLA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit trigUnit = LoadUnitHandle(HY, h, 14)
        local real a = LoadReal(HY, h, 13)
        local integer KLR = LoadInteger(HY, h, 12)
        local integer count = GetTriggerEvalCount(t)
        local real x = LoadReal(HY, h, 6) + count * 50 * Cos(a * bj_DEGTORAD)
        local real y = LoadReal(HY, h, 7) + count * 50 * Sin(a * bj_DEGTORAD)
        local boolean KMR = LoadBoolean(HY, h, 15)
        local unit KPR
        local trigger KQR = LoadTriggerHandle(HY, h, 11)
        local integer KSR = GetHandleId(KQR)
        local integer ID ='u01Q'
        local real KJR = 250
        local rect r
        local real d = 90
        local integer level = LoadInteger(HY, h, 0)
        set r = Rect(x -d, y -d, x + d, y + d)
        set QYV = 0
        call EnumDestructablesInRect(r, null, function MKA)
        if QYV > 0 or count == KLR or count ==(KLR -1) or count ==(KLR -2) then
            set ID ='u01P'
        endif
        set KPR = CreateUnit(GetOwningPlayer(trigUnit), ID, x, y, a)
        call SaveUnitHandle(HY, KSR, 700 + count, KPR)
        if QYV > 0 then
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            call TriggerRegisterTimerEvent(KQR, .5 / KLR, true)
            call TriggerAddCondition(KQR, Condition(function MHA))
            call SaveInteger(HY, KSR, 18, count)
            call SaveInteger(HY, KSR, 0, level)
            call SaveBoolean(HY, KSR, 727, true)
            call SaveUnitHandle(HY, KSR, 14, trigUnit)
            call SaveGroupHandle(HY, KSR, 16, AllocationGroup(475))
            call SaveReal(HY, KSR, 6, x * 1.)
            call SaveReal(HY, KSR, 7, y * 1.)
            call SaveBoolean(HY, KSR, 740, false)
        elseif count > KLR then
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            call TriggerRegisterTimerEvent(KQR, .5 / KLR, true)
            call TriggerAddCondition(KQR, Condition(function MHA))
            call SaveInteger(HY, KSR, 18, count)
            call SaveInteger(HY, KSR, 0, level)
            call SaveBoolean(HY, KSR, 727, false)
            call SaveUnitHandle(HY, KSR, 14, trigUnit)
            call SaveGroupHandle(HY, KSR, 16, AllocationGroup(476))
            call SaveBoolean(HY, KSR, 740, false)
        endif
        set t = null
        set trigUnit = null
        set KPR = null
        set KQR = null
        return false
    endfunction
    function TimberChainOnSpellEffect takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit trigUnit = GetTriggerUnit()
        local real a = AngleBetweenXY(GetUnitX(trigUnit), GetUnitY(trigUnit), GetSpellTargetX(), GetSpellTargetY())
        local integer level = GetUnitAbilityLevel(trigUnit,'A2E3')
        local integer KTR
        local integer KLR
        local trigger KUR = CreateTrigger()
        set KTR = 600 + 200* level + R2I(GetUnitCastRangeBonus(trigUnit))
        set KLR = KTR / 50
        call SaveUnitHandle(HY, h, 14,(trigUnit))
        call SaveInteger(HY, h, 5,(level))
        call SaveReal(HY, h, 13,((a)* 1.))
        call SaveInteger(HY, h, 12,(KLR))
        call SaveTriggerHandle(HY, h, 11,(KUR))
        call SaveReal(HY, h, 6,((GetUnitX(trigUnit))* 1.))
        call SaveReal(HY, h, 7,((GetUnitY(trigUnit))* 1.))
        call TriggerRegisterTimerEvent(t, .5 / KLR, true)
        call TriggerAddCondition(t, Condition(function MLA))
        call SaveInteger(HY, h, 0, GetUnitAbilityLevel(trigUnit, GetSpellAbilityId()))
        set t = null
        set trigUnit = null
        set KUR = null
    endfunction

    //***************************************************************************
    //*
    //*  锯齿飞轮
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_CHAKRAM         = GetHeroSKillIndexBySlot(HERO_INDEX_GOBLIN_SHREDDER, 4)
        constant integer CHAKRAM_ABILITY_ID          = 'A2E5'
        constant integer CHAKRAM_UPGRADED_ABILITY_ID = 'A43S'
        constant integer CHAKRAM_RETURN_ABILITY_ID   = 'A2FX'

        constant integer SECOND_CHAKRAM_ABILITY_ID        = 'A43Q'
        constant integer SECOND_CHAKRAM_RETURN_ABILITY_ID = 'A43P'
    endglobals
    function ChakramOnGetScepterUpgrade takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        if UnitAddPermanentAbility(whichUnit, SECOND_CHAKRAM_ABILITY_ID) then
            // 得到双飞之轮时，给予“双飞之轮-结束”技能并隐藏
            if UnitAddPermanentAbility(whichUnit, SECOND_CHAKRAM_RETURN_ABILITY_ID) then
                call UnitDisableAbility(whichUnit, SECOND_CHAKRAM_RETURN_ABILITY_ID, true)
            endif
        else
            call UnitEnableAbility(whichUnit, SECOND_CHAKRAM_ABILITY_ID, true)
        endif
        set whichUnit = null
    endfunction
    function ChakramOnLostScepterUpgrade takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        call UnitDisableAbility(whichUnit, SECOND_CHAKRAM_ABILITY_ID, true)
        set whichUnit = null
    endfunction
    // 得到锯齿飞轮时，给予“锯齿飞轮-结束”技能并隐藏
    function ChakramOnInitializer takes nothing returns nothing
        call RegisterAbilityAddMethod(CHAKRAM_ABILITY_ID         , "ChakramAbilityOnAdd")
        call RegisterAbilityAddMethod(CHAKRAM_UPGRADED_ABILITY_ID, "ChakramAbilityOnAdd")
    endfunction
    function ChakramAbilityOnAdd takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        if UnitAddPermanentAbility(whichUnit, CHAKRAM_RETURN_ABILITY_ID) then
            call UnitDisableAbility(whichUnit, CHAKRAM_RETURN_ABILITY_ID, true)
        endif
        set whichUnit = null
    endfunction

    function MZA takes nothing returns nothing
        if IsGameEnd == false then
            call UnitDamageTargetEx(Q_V, GetEnumUnit(), 3,(25 + 25 * Q0V)* .5)
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl", GetEnumUnit(), "origin"))
            call MWA(Q_V, GetEnumUnit())
        endif
    endfunction
    function M_A takes nothing returns nothing
        if IsUnitInGroup(GetEnumUnit(), QZV) == false then
            call GroupAddUnit(QZV, GetEnumUnit())
            call UnitDamageTargetEx(Q_V, GetEnumUnit(), 3, 60 + 40 * Q0V)
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl", GetEnumUnit(), "origin"))
            call MWA(Q_V, GetEnumUnit())
        endif
    endfunction
    
    function MTA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        call UnitRemoveAbility(whichUnit,'Bpig')
        call UnitRemoveAbility(whichUnit,'BEia')
        call UnitRemoveAbility(whichUnit,'BNms')
        call FlushChildHashtable(HY, h)
        call DestroyTrigger(t)
        set t = null
        set whichUnit = null
        return false
    endfunction
    function M1A takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = LoadUnitHandle(HY, h, 2)
        local unit missileDummy = LoadUnitHandle(HY, h, 45)
        local real tx = LoadReal(HY, h, 6)
        local real ty = LoadReal(HY, h, 7)
        local real x
        local real y
        local real a
        local integer chakramState = LoadInteger(HY, h, 33)
        local group   enumGroup    = LoadGroupHandle(HY, h, 187)
        local group   g
        local integer count = LoadInteger(HY, h, 34)
        local real    manaCost
        local integer abilId           = LoadInteger(HY, h, 2)
        local integer endcastAbilityId = LoadInteger(HY, h, 4)
        local boolean b = false

        if GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
            if GetSpellAbilityId() == endcastAbilityId then
                // 如果是收回
                call SaveInteger(HY, h, 33, 2)
                call GroupClear(enumGroup)

                // 隐藏收回技能，显示正常技能
                call UnitShowAbility(whichUnit, abilId)
                call UnitDisableAbility(whichUnit, endcastAbilityId, true)

                call UnitRemoveBEimAbility(whichUnit)
            endif
        // 单位死亡
        elseif GetTriggerEventId() == EVENT_WIDGET_DEATH then
            // 技能结束，锯齿飞轮消失

            // 不处于返回状态时死亡才会进行
            if chakramState != 2 then
                // 隐藏收回技能，显示正常技能
                call UnitShowAbility(whichUnit, abilId)
                call UnitDisableAbility(whichUnit, endcastAbilityId, true)
            endif
            // 技能结束，启用正常技能
            call UnitEnableAbility(whichUnit, abilId, false)
            call UnitDecDisableAttackCount(whichUnit)
            
            call UnitRemoveBEimAbility(whichUnit)
            call UnitRemoveAbility(whichUnit, 'BNms')
            call KillUnit(missileDummy)

            call DeallocateGroup(enumGroup)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        elseif chakramState == 0 then //前进
            set a = AngleBetweenXY(GetUnitX(missileDummy), GetUnitY(missileDummy), tx, ty)* bj_DEGTORAD
            set x = GetUnitX(missileDummy) + 18 * Cos(a)
            set y = GetUnitY(missileDummy) + 18 * Sin(a)
            call KillTreeByCircle(x, y, 175)
            if GetDistanceBetween(x, y, tx, ty)< 40 then
                set x = tx
                set y = ty
            endif
            call SetUnitX(missileDummy, x)
            call SetUnitY(missileDummy, y)
            set TempUnit = whichUnit
            set Q_V = whichUnit
            set Q0V = LoadInteger(HY, h, 0)
            set QZV = enumGroup
            set g = AllocationGroup(477)
            call GroupEnumUnitsInRange(g, x, y, 200+ 25, Condition(function DHX))
            call ForGroup(g, function M_A)
            call DeallocateGroup(g)
            if x == tx and y == ty then
                call SaveInteger(HY, h, 33, 1)
                call GroupClear(enumGroup)
            endif
        elseif chakramState == 1 then //停留
            set count = count + 1
            if count == 25 then
                set x = GetUnitX(missileDummy)
                set y = GetUnitY(missileDummy)
                call KillTreeByCircle(x, y, 175)
                set count = 0
                set TempUnit = whichUnit
                set Q_V = whichUnit
                set Q0V = LoadInteger(HY, h, 0)
                set g = AllocationGroup(478)
                call GroupEnumUnitsInRange(g, x, y, 200+ 25, Condition(function DHX))
                call ForGroup(g, function MZA)
                call DeallocateGroup(g)
                set manaCost =( 15+ 5 * Q0V)/ 2
                // 判定蓝量
                if GetUnitState(whichUnit, UNIT_STATE_MANA) < manaCost or GetUnitDistanceEx(whichUnit, missileDummy)> 2000 then
                    // 蓝不够了 就进入返回状态
                    call SaveInteger(HY, h, 33, 2)
                    call GroupClear(enumGroup)

                    // 隐藏收回技能，显示正常技能
                    call UnitShowAbility(whichUnit, abilId)
                    call UnitDisableAbility(whichUnit, endcastAbilityId, true)

                    call UnitRemoveBEimAbility(whichUnit)
                    call UnitRemoveAbility(whichUnit,'BNms')
                else
                    call SetUnitState(whichUnit, UNIT_STATE_MANA, GetUnitState(whichUnit, UNIT_STATE_MANA)-manaCost)
                endif
            endif
            call SaveInteger(HY, h, 34,(count))
        elseif chakramState == 2 then //收回
            set a = AngleBetweenXY(GetUnitX(missileDummy), GetUnitY(missileDummy), GetUnitX(whichUnit), GetUnitY(whichUnit))* bj_DEGTORAD
            set x = GetUnitX(missileDummy) + 16 * Cos(a)
            set y = GetUnitY(missileDummy) + 16 * Sin(a)
            call KillTreeByCircle(x, y, 175)
            call SetUnitX(missileDummy, x)
            call SetUnitY(missileDummy, y)
            set TempUnit = whichUnit
            set Q_V = whichUnit
            set Q0V = LoadInteger(HY, h, 0)
            set QZV = enumGroup
            set g = AllocationGroup(479)
            call GroupEnumUnitsInRange(g, x, y, 200+ 25, Condition(function DHX))
            call ForGroup(g, function M_A)
            call DeallocateGroup(g)
            if GetDistanceBetween(x, y, GetUnitX(whichUnit), GetUnitY(whichUnit))< 40 then
                call KillUnit(missileDummy)
                call DeallocateGroup(enumGroup)
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
                
                // 返回成功
                // 技能结束，启用正常技能
                call UnitEnableAbility(whichUnit, abilId, false)
                call UnitDecDisableAttackCount(whichUnit)

            endif
        endif
        set t = null
        set whichUnit = null
        set missileDummy = null
        set enumGroup = null
        set g = null
        return false
    endfunction
    function ChakramOnSpellEffect takes nothing returns nothing
        local unit    whichUnit = GetTriggerUnit()
        local real    x = GetSpellTargetX()
        local real    y = GetSpellTargetY()
        local real    a = AngleBetweenXY(GetUnitX(whichUnit), GetUnitY(whichUnit), x, y)* bj_DEGTORAD
        local unit    missileDummy = CreateUnit(GetOwningPlayer(whichUnit),'h0DS', GetUnitX(whichUnit), GetUnitY(whichUnit), a * bj_RADTODEG)
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local integer endcastAbilityId
        local integer abilId = GetSpellAbilityId()
        call TriggerRegisterTimerEvent(t, .02, true)
        call TriggerRegisterDeathEvent(t, whichUnit)
        call TriggerRegisterUnitEvent(t, whichUnit, EVENT_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(t, Condition(function M1A))
        call SaveUnitHandle(HY, h, 45, missileDummy)
        call SaveUnitHandle(HY, h, 2, whichUnit)
        call SaveReal(HY, h, 6, x * 1.)
        call SaveReal(HY, h, 7, y * 1.)
        call SaveInteger(HY, h, 33, 0)
        call SaveInteger(HY, h, 0, GetUnitAbilityLevel(whichUnit, abilId))
        call SaveGroupHandle(HY, h, 187, AllocationGroup(480))
        call SaveInteger(HY, h, 2, abilId)
        if abilId == CHAKRAM_ABILITY_ID or abilId == CHAKRAM_UPGRADED_ABILITY_ID then
            set endcastAbilityId = CHAKRAM_RETURN_ABILITY_ID
        else
            set endcastAbilityId = SECOND_CHAKRAM_RETURN_ABILITY_ID
        endif
        call UnitIncDisableAttackCount(whichUnit)

        call UnitDisableAbility(whichUnit, abilId, true)
        call UnitEnableAbility(whichUnit, endcastAbilityId, true)
        call SaveInteger(HY, h, 4, endcastAbilityId)

        set whichUnit = null
        set t = null
        set missileDummy = null
    endfunction
    
endscope
