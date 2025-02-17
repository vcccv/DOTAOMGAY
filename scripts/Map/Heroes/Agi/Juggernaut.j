
scope Juggernaut

    //***************************************************************************
    //*
    //*  无敌斩
    //*
    //***************************************************************************
    function WRR takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit u =(LoadUnitHandle(HY, h, 14))
        local unit fovd =(LoadUnitHandle(HY, h, 19))
        local integer max =(LoadInteger(HY, h, 216))
        local integer WNR =(LoadInteger(HY, h, 325))
        local integer S4R =(LoadInteger(HY, h, 28))
        local unit WBR
        if S4R > max then
            if LoadInteger(HY, h, 0)> 0 then
                call UnitReduceStateBonus(u, LoadInteger(HY, h, 0), UNIT_BONUS_ATTACK)
            endif
            call KillUnit(fovd)
            call DestroyEffect((LoadEffectHandle(HY, h, 32)))
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            
            call SaveInteger(HY,(GetHandleId((u))),(4253), 2)
            call SetUnitVertexColorEx(u,-1,-1,-1, 255)

            call UnitSubNoPathingCount(u)
            call UnitSubInvulnerableCount(u)
        else
            call SaveInteger(HY, h, 28,(S4R + 1))
            call WOR(u)
            if TempUnit == null then
                if LoadInteger(HY, h, 0)> 0 then
                    call UnitReduceStateBonus(u, LoadInteger(HY, h, 0), UNIT_BONUS_ATTACK)
                endif
                call KillUnit(fovd)
                call DestroyEffect((LoadEffectHandle(HY, h, 32)))
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
                
                call SaveInteger(HY,(GetHandleId((u))),(4253), 2)
                call SetUnitVertexColorEx(u,-1,-1,-1, 255)
                call UnitSubNoPathingCount(u)
                call UnitSubInvulnerableCount(u)
            endif
        endif
        set t = null
        set u = null
        set WBR = null
        set fovd = null
        return false
    endfunction
    function OmnislashDelay takes nothing returns nothing
        local timer   t2 = GetExpiredTimer()
        local integer h2 = GetHandleId(t2)
        local unit    u = LoadUnitHandle(HY, h2, 0)
        local unit    target = LoadUnitHandle(HY, h2, 1)
        local integer lv = GetUnitAbilityLevel(u,'A0M1')
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local integer WNR = GetUnitAbilityLevel(u,'A05G')
        local player  p = GetOwningPlayer(u)
        local integer max = 3
        local unit    fovd = CreateUnit(GetOwningPlayer(u),'o00D', GetUnitX(u), GetUnitY(u), 0)
        local integer WDR
        local integer WFR
        if IsUnitDummy(u) and HaveSavedHandle(HY, GetHandleId(u), 0) then
            set u = LoadUnitHandle(HY, GetHandleId(u), 0)
        endif
        set WDR = IMaxBJ(GetHeroStr(u, true), IMaxBJ(GetHeroAgi(u, true), GetHeroInt(u, true)))
        set WFR = WDR -GetHeroAgi(u, true)
        if lv == 0 then
            set lv = GetUnitAbilityLevel(u,'A1AX')
            if lv == 1 then
                set max = 6
            elseif lv == 2 then
                set max = 9
            elseif lv == 3 then
                set max = 12
            endif
        elseif lv == 2 then
            set max = 6
        elseif lv == 3 then
            set max = 9
        endif
        call SetUnitVertexColorEx(u,-1,-1,-1, 125)
        call UnitAddNoPathingCount(u)
        call UnitAddInvulnerableCount(u)
        call SaveInteger(HY, GetHandleId(u), 4253, 1)
        call SaveUnitHandle(HY, h, 14,(u))
        call SaveUnitHandle(HY, h, 17,(target))
        call TriggerRegisterTimerEvent(t, 0, false)
        call TriggerAddCondition(t, Condition(function WXR))
        set t = CreateTrigger()
        set h = GetHandleId(t)
        call SaveUnitHandle(HY, h, 14,(u))
        call SaveUnitHandle(HY, h, 19,(fovd))
        call SaveInteger(HY, h, 216,(max))
        call SaveInteger(HY, h, 325,(WNR))
        call SaveInteger(HY, h, 28, 2)
        call SaveEffectHandle(HY, h, 32,(AddSpecialEffectTarget("Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl", u, GetHeroWeaponAttachPointName(u))))
        call TriggerRegisterTimerEvent(t, .4, true)
        call TriggerAddCondition(t, Condition(function WRR))
        if WFR > 0 then
            call UnitAddStateBonus(u, WFR, UNIT_BONUS_ATTACK)
            call SaveInteger(HY, h, 0, WFR)
        endif
        call DestroyTimer(t2)
        call FlushChildHashtable(HY, h2)
        set t2 = null
        set u = null
        set target = null
        set t = null
        set p = null
        set fovd = null
    endfunction
    function OmnislashOnSpellEffect takes nothing returns nothing
        local timer t = null
        local integer h
        if not UnitHasSpellShield(GetSpellTargetUnit()) then
            set t = CreateTimer()
            set h = GetHandleId(t)
            call SaveUnitHandle(HY, h, 0, GetTriggerUnit())
            call SaveUnitHandle(HY, h, 1, GetSpellTargetUnit())
            call TimerStart(t, 0, false, function OmnislashDelay)
            set t = null
        endif
    endfunction

endscope
