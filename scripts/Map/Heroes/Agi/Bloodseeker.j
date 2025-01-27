
scope Bloodseeker

    //***************************************************************************
    //*
    //*  嗜血渴望
    //*
    //***************************************************************************
    private function CreateVisionDummy takes unit u, unit owner returns nothing
        local unit dummyUnit
        local integer h = GetHandleId(u)
        if (LoadBoolean(OtherHashTable, h, 24) == false) then
            call SaveBoolean(OtherHashTable, h, 24, true)
            set dummyUnit = CreateUnit(GetOwningPlayer(owner),'hBST', GetUnitX(u), GetUnitY(u), 0)
            call SaveUnitHandle(OtherHashTable, h, 24, dummyUnit) // 视野马甲
            call SetUnitMoveSpeed(dummyUnit, 522)
            call IssueTargetOrderById(dummyUnit, 851986, u)
        else
            set dummyUnit = LoadUnitHandle(OtherHashTable, h, 24)
            call SetUnitX(dummyUnit, GetUnitX(u))
            call SetUnitY(dummyUnit, GetUnitY(u))
            if IsUnitInvision(u) then
                if GetUnitAbilityLevel(u,'A1HX')> 0 then
                    call UnitRemoveAbility(dummyUnit,'A30X')
                elseif GetUnitAbilityLevel(dummyUnit,'A30X') == 0 then
                    call UnitAddAbility(dummyUnit,'A30X')
                endif
            else
                if GetUnitAbilityLevel(dummyUnit,'A30X')> 0 then
                    call UnitRemoveAbility(dummyUnit,'A30X')
                endif
            endif
        endif
        set dummyUnit = null
    endfunction

    private function RemoveVisionDummy takes unit u, unit owner returns nothing
        local integer h = GetHandleId(u)
        if (LoadBoolean(OtherHashTable, h, 24)) then
            call SaveBoolean(OtherHashTable, h, 24, false)
            call SetUnitPosition(LoadUnitHandle(OtherHashTable, h, 24), 7536,-7632)
            call KillUnit(LoadUnitHandle(OtherHashTable, h, 24))
            call UnitRemoveAbility(u, 'B0EY') // 焦渴buff
        endif
    endfunction

    function ThirstHeroFilter takes unit strygwry, unit hero returns boolean
        local real    lifePercent
        local real    needPercent = 30.
        if UnitAlive(strygwry) and UnitAlive(hero) then
            set lifePercent = GetUnitLifePercent(hero)
            // 25~30 时不看隐身
            return 25. > lifePercent or (lifePercent < needPercent and not IsUnitInvision(hero))
        endif
        return false
    endfunction

    function StrygwyrThirstOnUpdate takes nothing returns boolean
        local trigger t               = GetTriggeringTrigger()
        local integer h               = GetHandleId(t)
        local unit    whichUnit       = LoadUnitHandle(HY, h, 2)
        local integer level           = GetUnitAbilityLevel(whichUnit,'A0I8')
        local integer damageBonus     = level * 10-5
        local integer moveSpeedBonus  = ( 10* level -5)
        local boolean isHaveBonus     = LoadBoolean(HY, h, 0)
        local integer lastDamageBonus = LoadInteger(HY, h, 0)
        local integer lastMoveSpeedBonus = LoadInteger(HY, h, 1)
        local integer count     = 0
        local integer start     = 1
        local integer maxPlayer = 5
        local integer i
        local unit    u
        local boolean isSentinel = IsSentinelPlayer(GetOwningPlayer(whichUnit))
        local boolean isBreak    = IsUnitBreak(whichUnit)
        local real    moveBonus

        set i = start
        loop
            if isSentinel then
                set u = Player__Hero[GetPlayerId(ScourgePlayers[i])]
            else
                set u = Player__Hero[GetPlayerId(SentinelPlayers[i])]
            endif
            if u != null then
                if not isBreak and ThirstHeroFilter(whichUnit, u) then
                    call CreateVisionDummy(u, whichUnit)
                    set count = count + 1
                elseif (LoadBoolean(OtherHashTable, GetHandleId(u), 24)) then
                    call RemoveVisionDummy(u, whichUnit)
                endif
            endif
            set i = i + 1
        exitwhen i > maxPlayer
        endloop
        if count == 0 then
            call UnitRemoveAbility(whichUnit,'A214')
            if isHaveBonus then
                call UnitReduceStateBonus(whichUnit, lastDamageBonus, UNIT_BONUS_DAMAGE)
                call SaveBoolean(HY, h, 0, false)
            endif
            call SaveInteger(OtherHashTable, GetHandleId(whichUnit),'A214', 0)
        else
            set damageBonus = damageBonus * count
            set moveSpeedBonus = moveSpeedBonus * count
            if not isHaveBonus then
                call UnitAddStateBonus(whichUnit, damageBonus, UNIT_BONUS_DAMAGE)
                call UnitAddMoveSpeedBonusPercent(whichUnit, moveSpeedBonus)
                call SaveBoolean(HY, h, 0, true)
                call SaveInteger(HY, h, 0, damageBonus)
                call SaveInteger(HY, h, 1, moveSpeedBonus)
            elseif lastDamageBonus != damageBonus then
                call UnitReduceMoveSpeedBonusPercent(whichUnit, lastMoveSpeedBonus)
                call UnitAddMoveSpeedBonusPercent(whichUnit, moveSpeedBonus)
                call UnitReduceStateBonus(whichUnit, lastDamageBonus, UNIT_BONUS_DAMAGE)
                call UnitAddStateBonus(whichUnit, damageBonus, UNIT_BONUS_DAMAGE)
                call SaveInteger(HY, h, 0, damageBonus)
                call SaveInteger(HY, h, 1, moveSpeedBonus)
            endif
    
            call SaveInteger(OtherHashTable, GetHandleId(whichUnit),'A214', count)
            call SaveInteger(OtherHashTable, GetHandleId(whichUnit),'A215', level)
            call UnitAddPermanentAbility(whichUnit,'A214')
        endif

        set i = 1
        loop
            if (LoadBoolean(OtherHashTable, GetHandleId(Player__Hero[i]), 24)) then
                call SetUnitX(LoadUnitHandle(OtherHashTable, GetHandleId(Player__Hero[i]), 24), GetUnitX(Player__Hero[i]))
                call SetUnitY(LoadUnitHandle(OtherHashTable, GetHandleId(Player__Hero[i]), 24), GetUnitY(Player__Hero[i]))
                // 让视野马甲跟随英雄
                call IssueTargetOrderById(LoadUnitHandle(OtherHashTable, GetHandleId(Player__Hero[i]), 24), 851986, Player__Hero[i])
            endif
            set i = i + 1
            if i == 6 then
                set i = 7
            endif
        exitwhen i > 11
        endloop

        set t = null
        set whichUnit = null
        set u = null
        return false
    endfunction

    function StrygwyrThirstOnLearn takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = GetTriggerUnit()
        call TriggerRegisterTimerEvent(t, .1, true)
        call TriggerAddCondition(t, Condition(function StrygwyrThirstOnUpdate))
        call SaveUnitHandle(HY, h, 2,(whichUnit))
        set t = null
        set whichUnit = null
    endfunction

endscope

