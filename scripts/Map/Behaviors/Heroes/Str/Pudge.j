
scope Pudge

    //***************************************************************************
    //*
    //*  肉钩
    //*
    //***************************************************************************
    function V7A takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local integer V8A =(LoadInteger(HY, h, 376))
        local boolean V9A =(LoadBoolean(HY, h, 377))
        local unit u =(LoadUnitHandle(HY, h, 17))
        local unit EVA =(LoadUnitHandle(HY, h,( 2100+ V8A)))
        local real x
        local real y
        local trigger tt
        if V9A then
            set x = GetUnitX(EVA)
            set y = GetUnitY(EVA)
            if GetDistanceBetween(GetUnitX(EVA), GetUnitY(EVA), GetUnitX(u), GetUnitY(u))< 1200 then
                if IsUnitType(u, UNIT_TYPE_HERO) then
                    call SaveBoolean(OtherHashTable, GetHandleId(u), 99, true)
                endif
                call SetUnitX(u, x)
                call SetUnitY(u, y)
                if ModuloInteger(GetTriggerEvalCount(t), 3) == 0 and IsUnitEnemy(u, GetOwningPlayer(EVA)) then
                    call FYX(u , .1)
                endif
            else
                call SaveBoolean(HY, h, 377, false)
            endif
            if u == null then
                call SaveBoolean(HY, h, 377, false)
            endif
        endif
        call RemoveUnit(EVA)
        set V8A = V8A -1
        call SaveInteger(HY, h, 376,(V8A))
        if V8A <= 0 then
            //if (A4X(x, y) == false or IsPointInRegion(TerrainCliffRegion, x, y)) and IsUnitType(u, UNIT_TYPE_HERO) then
            //	set tt = CreateTrigger()
            //	call SaveUnitHandle(HY, GetHandleId(tt), 0, u)
            //	call TriggerRegisterTimerEvent(tt, 5, false)
            //	call TriggerAddCondition(tt, Condition(function V5A))
            //	set tt = null
            //else
            	call UnitDecNoPathingCount(u)
            //endif
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        endif
        set t = null
        set u = null
        set EVA = null
        return false
    endfunction
    function MeatHookOnMoveUpdate takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local integer i =(LoadInteger(HY, h, 376))
        local integer lv =(LoadInteger(HY, h, 5))
        local real a =(LoadReal(HY, h, 13))
        local unit u =(LoadUnitHandle(HY, h, 14))
        local trigger trg2 =(LoadTriggerHandle(HY, h, 11))
        local integer h2 = GetHandleId(trg2)
        local group g
        local unit target
        local real x
        local real y
        local real z
        local integer hp = GetHandleId(GetOwningPlayer(u))
        local real QTR = 110
        local real dist = LoadReal(HY, h, 20) + 40.
        local real distance = LoadReal(HY, h, 12)
        call SaveReal(HY, h, 20, dist)
        if dist < distance then
            set i = i + 1
            if i == 1 then
                set QTR = 50
            elseif i == 2 then
                set QTR = 75
            endif
            call SaveInteger(HY, h, 376,(i))
            set x = GetUnitX(u)+ i * 40 * Cos(a * bj_DEGTORAD)
            set y = GetUnitY(u)+ i * 40 * Sin(a * bj_DEGTORAD)
            call SaveUnitHandle(HY,(h2),( 2100+ i),(CreateUnit(GetOwningPlayer(u),'u00H', x, y, a)))
            set g = AllocationGroup(380)
            call GroupEnumUnitsInRange(g, x, y, QTR, Condition(function D9X))
            call GroupRemoveUnit(g, u)
            if GetUnitTypeId(u)=='e00E' then
                call GroupRemoveUnit(g, PlayerHeroes[GetPlayerId(GetOwningPlayer(u))])
            endif
            set target = GroupPickRandomUnit(g)
            call DeallocateGroup(g)
            if target != null then
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
                call TriggerRegisterTimerEvent(trg2, .025, true)
                call TriggerRegisterDeathEvent(trg2, target)
                call TriggerAddCondition(trg2, Condition(function V7A))
                call SaveInteger(HY,(h2), 376,(i))
                call SaveBoolean(HY,(h2), 377,(true))
                call SaveUnitHandle(HY,(h2), 17,(target))
                call UnitIncNoPathingCount(target)
                if IsUnitEnemy(target, GetOwningPlayer(u)) then
                    if IsUnitType(target, UNIT_TYPE_HERO) then
                        call SaveInteger(OtherHashTable, hp,'HK_H', LoadInteger(OtherHashTable, hp,'HK_H')+ 1)
                        call StoreDrCacheData("HA_Hits" + I2S(GetPlayerId(GetOwningPlayer(u))), LoadInteger(OtherHashTable, hp,'HK_H'))
                        call EPX(u, 4400, 1.5)
                    endif
                    call V6A(u, target)
                    call UnitDamageTargetEx(u, target, 7, 90 * lv)
                    call DestroyEffect(AddSpecialEffectTarget("Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl", target, "origin"))
                endif
            endif
        else
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            call TriggerRegisterTimerEvent(trg2, .025, true)
            call TriggerAddCondition(trg2, Condition(function V7A))
            call SaveInteger(HY,(h2), 376,(i))
            call SaveBoolean(HY,(h2), 377,(false))
        endif
        set t = null
        set u = null
        set trg2 = null
        set g = null
        set target = null
        return false
    endfunction
    function MeatHookOnSpellEffect takes nothing returns nothing
        local unit    u        = GetRealSpellUnit(GetTriggerUnit())
        local real    a        = AngleBetweenXY(GetUnitX(u), GetUnitY(u), GetSpellTargetX(), GetSpellTargetY())
        local trigger t        = CreateTrigger()
        local integer h        = GetHandleId(t)
        local integer hp       = GetHandleId(GetOwningPlayer(u))
        local integer level    = GetUnitAbilityLevel(u, GetSpellAbilityId())
        local real    distance = 900. + level * 100. + GetUnitCastRangeBonus(u)
        call SaveUnitHandle(HY, h, 14,(u))
        call SaveInteger(HY, h, 5, level )
        call SaveReal(HY, h, 13,((a)* 1.))
        call SaveReal(HY, h, 12, distance )
        call SaveInteger(HY, h, 376, 0)
        call SaveTriggerHandle(HY, h, 11,(CreateTrigger()))
        call TriggerRegisterTimerEvent(t, .025, true)
        call TriggerAddCondition(t, Condition(function MeatHookOnMoveUpdate))
        call SaveInteger(OtherHashTable, hp,'HK_T', LoadInteger(OtherHashTable, hp,'HK_T')+ 1)
        call StoreDrCacheData("HA_Total" + I2S(GetPlayerId(GetOwningPlayer(u))), LoadInteger(OtherHashTable, hp,'HK_T'))
        set u = null
        set t = null
    endfunction

endscope
