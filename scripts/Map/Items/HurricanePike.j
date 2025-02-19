
scope HurricanePike

    //***************************************************************************
    //*
    //*  飓风之力
    //*
    //***************************************************************************
    function QTYUW takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer h = GetHandleId(t)
        local unit WEEUQ = LoadUnitHandle(HY, h, 0)
        local unit WWUTQ = LoadUnitHandle(HY, h, 1)
        if UnitAlive(WEEUQ) and UnitAlive(WWUTQ) then
            call IssueTargetOrderById(WEEUQ, 851983, WWUTQ)
        endif
        call PauseTimer(t)
        call FlushChildHashtable(HY, GetHandleId(t))
        call DestroyTimer(t)
        set WEEUQ = null
        set WWUTQ = null
        set t = null
    endfunction

    function QTUQW takes unit WEEUQ, unit WWUTQ returns nothing
        local integer h = TimerStartSingle(0.02, function QTYUW)
        call SaveUnitHandle(HY, h, 0, WEEUQ)
        call SaveUnitHandle(HY, h, 1, WWUTQ)
    endfunction

    function QTUEW takes nothing returns nothing
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit u = LoadUnitHandle(HY, h, 0)
        local unit target = LoadUnitHandle(HY, h, 1)
        local integer hu = GetHandleId(u) 
        local integer int = LoadInteger(HY, h, 10)
        local integer id
        if LoadReal(HY, hu,'A3UC')> 0 then
            if GetTriggerEventId() == EVENT_UNIT_ACQUIRED_TARGET then
                call QTUWW(u, GetEventTargetUnit() == target)
            else
                set id = GetIssuedOrderId()
                if id == 851983 or (id == 851971 and GetOrderTargetUnit() == target)  then 
                    call QTUWW(u, GetOrderTargetUnit() == target)
                    set int = int + 1
                    call SaveInteger(HY, h, 10, int)
                endif
            endif
        endif
        if int == 4 or GetTriggerEventId() == EVENT_GAME_TIMER_EXPIRED then
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            call QTUWW(u, false)
            if GetUnitAbilityLevel(u,'A3UC')> 0 then
                call UnitRemoveAbility(u,'A3UC')
                call UnitRemoveAbility(u,'a3UC')
            endif
        endif
        set target = null
        set u = null
        set t = null
    endfunction
    function QTURW takes unit u, unit target returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        call QTUWW(u, true)
        call SaveInteger(HY, h, 10, 0)
        call SaveUnitHandle(HY, h, 0, u)
        call SaveUnitHandle(HY, h, 1, target)
        call TriggerRegisterTimerEvent(t, 5., false)
        call TriggerRegisterUnitEvent(t, u, EVENT_UNIT_ISSUED_TARGET_ORDER)
        call TriggerRegisterUnitEvent(t, u, EVENT_UNIT_ISSUED_POINT_ORDER)
        call TriggerRegisterUnitEvent(t, u, EVENT_UNIT_ACQUIRED_TARGET)
        call TriggerAddCondition(t, Condition(function QTUEW))
        set t = null
    endfunction
    function YRQEQ takes player p, player t returns nothing
        call SaveReal(HY, GetHandleId(t), GetPlayerId(p) +'buff', GetGameTime())
    endfunction
    function QTRUW takes unit u returns boolean
        return LoadBoolean(HY, GetHandleId(u), 4306) or LoadBoolean(HY, GetHandleId(u), 4307)
    endfunction
    function QTTQW takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit WWUTQ =(LoadUnitHandle(HY, h, 17))
        local real TWQUQ =(LoadReal(HY, h, 137))
        local real RTRWQ =(LoadReal(HY, h, 138))
        local real dx
        local real dy
        local integer c = GetTriggerEvalCount(t)
        local integer hu = GetHandleId(WWUTQ)
        if c == 11 or GetTriggerEventId() == EVENT_WIDGET_DEATH or LoadInteger(HY, hu, 4260) == 1 or LoadInteger(HY, hu,'ublo') == 1 then
            call DestroyTrigger(t)
        else
            if (not QTRUW(WWUTQ)) and(LoadInteger(HY, hu, 4324)!= 1) then
                //call CreateSentinelCreeps4(WWUTQ,4414,0.1)
                set dx = CoordinateX50(GetUnitX(WWUTQ) + RTRWQ / 10. * Cos(TWQUQ * bj_DEGTORAD))
                set dy = CoordinateY50(GetUnitY(WWUTQ) + RTRWQ / 10. * Sin(TWQUQ * bj_DEGTORAD))
                call DestroyEffect(AddSpecialEffect(LoadStr(HY, h, 12), dx, dy))
                call SetUnitX(WWUTQ, dx)
                call SetUnitY(WWUTQ, dy)
                if c == 10 then
                    //call K2X(WWUTQ)
                endif
            endif
        endif
        set WWUTQ = null
        set t = null
        return false
    endfunction
    function QTTWW takes unit WEEUQ, unit WWUTQ, real TWRRQ, real QEEQQ, unit QTTEW returns nothing
        local trigger t
        local integer h
        local real x
        local real y
        local real RTRWQ
        local real TWQUQ
        local integer i =-1
        local boolean b = false
        local real QTTRW
        local real QTTTW
        local real dx
        local real dy
        if GetUnitAbilityLevel(WWUTQ,'A32U')!= 0 then
            return
        endif
        set t = CreateTrigger()
        set h = GetHandleId(t)
        if WWUTQ == null and GetSpellTargetItem()!= null then
            set WWUTQ = WEEUQ
        endif
        if QTTEW != null then
            set TWQUQ = AngleBetweenUnit(WEEUQ, WWUTQ)
            if WEEUQ == WWUTQ then
                set TWQUQ = AngleBetweenUnit(QTTEW, WEEUQ)
            endif
        else
            set TWQUQ = GetUnitFacing(WWUTQ)
        endif
        set QTTRW = Cos(TWQUQ * bj_DEGTORAD)
        set QTTTW = Sin(TWQUQ * bj_DEGTORAD)
        set dx = GetUnitX(WWUTQ)
        set dy = GetUnitY(WWUTQ)
        set x = CoordinateX50(dx +(TWRRQ -i * 25)* QTTRW)
        set y = CoordinateY50(dy +(TWRRQ -i * 25)* QTTTW)
        if IsUnitAlly(WWUTQ, GetOwningPlayer(GetTriggerUnit())) then
            if IsUnitType(WWUTQ, UNIT_TYPE_HERO) then
                call YRQEQ(GetOwningPlayer(GetTriggerUnit()), GetOwningPlayer(WWUTQ))
            endif
        endif
        set RTRWQ = SquareRoot((x -GetUnitX(WWUTQ))*(x -GetUnitX(WWUTQ)) +(y -GetUnitY(WWUTQ))*(y -GetUnitY(WWUTQ)))
        call TriggerRegisterTimerEvent(t, QEEQQ / 10., true)
        call TriggerRegisterDeathEvent(t, WWUTQ)
        call TriggerAddCondition(t, Condition(function QTTQW))
        call SaveUnitHandle(HY, h, 17,(WWUTQ))
        call SaveReal(HY, h, 137,((TWQUQ)* 1.0))
        call SaveReal(HY, h, 138,((RTRWQ)* 1.0))
        call SaveStr(HY, h, 12, "Abilities\\Spells\\Human\\FlakCannons\\FlakTarget.mdl")
        set WWUTQ = null
        set t = null
    endfunction

    //大推推 目标敌人
    function QTUTW takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local unit WWUTQ = GetSpellTargetUnit()
        local integer h
        if GetUnitTypeId(u)!='e00E'then
            if GetUnitAbilityLevel(WWUTQ,'A32U') == 0 then
                call QTTWW(u, WWUTQ, 450., 0.2, WWUTQ)
                call QTTWW(u, u, 450., 0.2, WWUTQ)
            endif
        else
            set u = LoadUnitHandle(HY, GetHandleId(u), 0)
        endif
        set h = GetHandleId(u)
        if u != null then
            call UnitAddAbilityToTimed(u,'A3UC', 1, 5.,'a3UC')
            call SaveReal(HY, h,'A3UC', GetGameTime() + 5.)
            if not IsUnitType(u, UNIT_TYPE_MELEE_ATTACKER) then
                call QTUQW(u, WWUTQ)
                call QTURW(u, WWUTQ)
            endif
            call SaveInteger(HY, h,'A3UC', 4)
            call SaveUnitHandle(HY, h,'A3UC', WWUTQ)
        endif
        set u = null
        set WWUTQ = null
    endfunction

    // 大推推
    function ItemAbility_HurricaneThrustOnSpellEffect takes nothing returns nothing
        if IsUnitAlly(GetSpellTargetUnit(), GetTriggerPlayer()) or GetSpellTargetItem()!= null or GetUnitTypeId(GetSpellTargetUnit())=='n00L' then
            call ItemAbility_ForceOnSpellEffect() //推推棒
        elseif GetUnitAbilityLevel(GetSpellTargetUnit(),'B0BI') == 0 then
            call QTUTW()
        endif
    endfunction

endscope
