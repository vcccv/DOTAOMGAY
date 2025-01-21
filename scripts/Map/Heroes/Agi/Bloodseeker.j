
scope Bloodseeker

    //***************************************************************************
    //*
    //*  嗜血渴望
    //*
    //***************************************************************************
    function G6I takes unit u returns nothing
        local unit dummyUnit
        local integer h = GetHandleId(u)
        if (LoadBoolean(OtherHashTable, h, 24) == false) then
            call SaveBoolean(OtherHashTable, h, 24, true)
            set dummyUnit = CreateUnit(GetOwningPlayer(LRV),'hBST', GetUnitX(u), GetUnitY(u), 0)
            call SaveUnitHandle(OtherHashTable, h, 24, dummyUnit)
            call SetUnitMoveSpeed(dummyUnit, 522)
            call IssueTargetOrderById(dummyUnit, 851986, u)
        else
            set dummyUnit = LoadUnitHandle(OtherHashTable, h, 24)
            call SetUnitX(dummyUnit, GetUnitX(u))
            call SetUnitY(dummyUnit, GetUnitY(u))
            if DOX(u) then
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
    function G7I takes unit u returns nothing
        local integer h = GetHandleId(u)
        if (LoadBoolean(OtherHashTable, h, 24)) then
            call SaveBoolean(OtherHashTable, h, 24, false)
            call SetUnitPosition(LoadUnitHandle(OtherHashTable, h, 24), 7536,-7632)
            call KillUnit(LoadUnitHandle(OtherHashTable, h, 24))
            call UnitRemoveAbility(u,'B0EY')
        endif
    endfunction

    function StrygwyrThirstOnUpdateAttack takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = LoadUnitHandle(HY, h, 2)
        local integer level = GetUnitAbilityLevel(whichUnit,'A0I8')
        local integer CJR = level * 10-5
        local boolean G9I = LoadBoolean(HY, h, 0)
        local integer HVI = LoadInteger(HY, h, 0)
        local integer HEI = LoadInteger(HY, h, 2)
        local integer UYX = 0
        local integer HXI = 0
        local integer HOI = 1
        local integer HRI = 5
        local integer i
        local unit u
        local boolean b = IsSentinelPlayer(GetOwningPlayer(whichUnit))
        local boolean br = GetUnitAbilityLevel(whichUnit,'A36D') == 1
        set i = HOI
        loop
            if b then
                set u = Player__Hero[GetPlayerId(ScourgePlayers[i])]
            else
                set u = Player__Hero[GetPlayerId(SentinelPlayers[i])]
            endif
            if u != null then
                set LRV = whichUnit
                if (G5I(u)) and br == false then
                    call G6I(u)
                    set UYX = UYX + 1
                elseif (LoadBoolean(OtherHashTable, GetHandleId(u), 24)) then
                    call G7I(u)
                endif
            endif
            set i = i + 1
        exitwhen i > HRI
        endloop
        if UYX == 0 then
            call SaveInteger(HY, h, 2, 0)
            call UnitRemoveAbility(whichUnit,'A214')
            if G9I then
                call UnitReduceStateBonus(whichUnit, HVI, "damage")
                call SaveBoolean(HY, h, 0, false)
            endif
            call SaveInteger(OtherHashTable, GetHandleId(whichUnit),'A214', 0)
        else
            set CJR = CJR * UYX
            if G9I == false then
                call UnitAddStateBonus(whichUnit, CJR, "damage")
                call SaveBoolean(HY, h, 0, true)
                call SaveInteger(HY, h, 0, CJR)
            elseif HVI != CJR then
                call UnitReduceStateBonus(whichUnit, HVI, "damage")
                call UnitAddStateBonus(whichUnit, CJR, "damage")
                call SaveInteger(HY, h, 0, CJR)
            endif
            set HXI = level * 7 * UYX
            if HXI != HEI then
                call SaveInteger(HY, h, 2, HXI)
            endif
            call SaveInteger(OtherHashTable, GetHandleId(whichUnit),'A214', UYX)
            call SaveInteger(OtherHashTable, GetHandleId(whichUnit),'A215', level)
            call UnitAddPermanentAbility(whichUnit,'A214')
        endif
        set t = null
        set whichUnit = null
        set u = null
        return false
    endfunction

    function StrygwyrThirstOnUpdateMoveSpeed takes nothing returns nothing
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit u = LoadUnitHandle(HY, h, 0)
        local integer i = 1
        local integer UYX = LoadInteger(OtherHashTable, GetHandleId(u),'A214')
        local integer level = LoadInteger(OtherHashTable, GetHandleId(u),'A215')
        local integer I2X =( 10* level -5)* UYX
        loop
            if (LoadBoolean(OtherHashTable, GetHandleId(Player__Hero[i]), 24)) then
                call SetUnitX(LoadUnitHandle(OtherHashTable, GetHandleId(Player__Hero[i]), 24), GetUnitX(Player__Hero[i]))
                call SetUnitY(LoadUnitHandle(OtherHashTable, GetHandleId(Player__Hero[i]), 24), GetUnitY(Player__Hero[i]))
                call IssueTargetOrderById(LoadUnitHandle(OtherHashTable, GetHandleId(Player__Hero[i]), 24), 851986, Player__Hero[i])
            endif
            set i = i + 1
            if i == 6 then
                set i = 7
            endif
        exitwhen i > 11
        endloop
        call SetUnitNoLimitMoveSpeed(u, I2X)
        set t = null
        set u = null
    endfunction
    function StrygwyrThirstOnLearn takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = GetTriggerUnit()
        call TriggerRegisterTimerEvent(t, .25, true)
        call TriggerAddCondition(t, Condition(function StrygwyrThirstOnUpdateAttack))
        call SaveUnitHandle(HY, h, 2,(whichUnit))
        set t = CreateTrigger()
        call TriggerRegisterTimerEvent(t, .1, true)
        call TriggerAddCondition(t, Condition(function StrygwyrThirstOnUpdateMoveSpeed))
        call SaveUnitHandle(HY, GetHandleId(t), 0, whichUnit)
        set t = null
        set whichUnit = null
    endfunction

endscope

