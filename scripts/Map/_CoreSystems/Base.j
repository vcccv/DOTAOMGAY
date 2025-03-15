
library Base requires TriggerDestroyQueue, GroupAlloc, ErrorMessage, TimerUtils
    
    function B2S takes boolean b returns string
        if b then
            return "true"
        endif
        return "false"
    endfunction

    function PlayerInterfaceErrorSoundForPlayer takes player p, boolean b returns nothing
        if b and User.Local == p then
            call MHUI_PlayErrorSound()
        endif
        //local sound s = CreateSoundFromLabel("InterfaceError", false, false, false, 10, 10)
        //if b then
        //	if (LocalPlayer== p) then
        //		call StartSound(s)
        //	endif
        //endif
        //call KillSoundWhenDone(s)
        //set s = null
    endfunction
    // 会清空信息
    function DisplayLoDWarningForPlayerEx takes player p, boolean expression, string message returns nothing
        if not (expression) then
            return
        endif
        if (LocalPlayer== p) then
            if (message != "") and(message != null) then
                call ClearTextMessages()
                call DisplayTimedTextToPlayer(p, 0, 0, 5, "|c00FF0000[LoD]|r|c006699CC" + " " + message + "|r")
            endif
        endif
    endfunction
    function DisplayLoDWarningForPlayer takes player p, boolean expression, string message returns nothing
        if not (expression) then
            return
        endif
        if (LocalPlayer== p) then
            if (message != "") and(message != null) then
                call DisplayTimedTextToPlayer(p, 0, 0, 5, "|c00FF0000[LoD]|r|c006699CC" + " " + message + "|r")
            endif
        endif
    endfunction
    function DisplayLoDErrorForPlayer takes player p, boolean expression, string message returns nothing
        if not(expression) then
            return
        endif
        call PlayerInterfaceErrorSoundForPlayer(p, expression)
        call DisplayLoDWarningForPlayerEx(p, expression, message)
    endfunction
    
    function PreloadQueueExpireAction takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer h = GetHandleId(t)
        local integer id
        local integer i = LoadInteger(HY, h,-1)
        local integer max = LoadInteger(HY, h, 0)
        if i < max then
            set id = LoadInteger(HY, h, i + 1)
            call UnitAddAbility(PreloadeHero, id)
            call UnitRemoveAbility(PreloadeHero, id)
            call RemoveSavedInteger(HY, h, i + 1)
            call SaveInteger(HY, h,-1, i + 1)
        else
            call PauseTimer(t)
            call SaveBoolean(HY, GetHandleId(PreloadeHero), 0, false)
            call SaveInteger(HY, h, 0, 0)
            call SaveInteger(HY, h,-1, 0)
        endif
        set t = null
    endfunction
    // 将技能加入预读队列 是有间隔的预读 而不是一下全读了 不然可能导致卡顿
    function AddAbilityIDToPreloadQueue takes integer id returns nothing
        local integer hu = GetHandleId(PreloadeHero)
        local timer t = LoadTimerHandle(HY, hu, 0)
        local integer h = GetHandleId(t)
        local integer i
        if LoadBoolean(HY, hu, 0) then
            set i = LoadInteger(HY, h, 0) + 1
        else
            call TimerStart(t, .1, true, function PreloadQueueExpireAction)
            call SaveBoolean(HY, hu, 0, true)
            set i = 1
        endif
        call SaveInteger(HY, h, i, id)
        call SaveInteger(HY, h, 0, i)
        set t = null
    endfunction
    // 直接预读技能
    function PreloadAbility takes integer id returns nothing
        call UnitAddAbility(PreloadeHero, id)
        call UnitRemoveAbility(PreloadeHero, id)
    endfunction

    function SendErrorMessage takes string str returns nothing
        call MHUI_SendErrorMessage(str, 10., 0xFFFFCC00)
        call MHUI_PlayErrorSound()
    endfunction

    // GetBuybackGoldCostByLevel
    function GetBuybackGoldCostByLevel takes integer level returns integer
        local real    time   = GameTimer.GetElapsed() - PickModeElapsed
        local real    minute = (R2I(time)/ 60) - (1 / 2)
        local real    cost   = 100 + level * level * 1.5 + minute * 15
        local integer index
        set index = R2I(cost / 50)
        set index = IMinBJ(index, 59)
        set index = IMaxBJ(index, 0)
        return index
    endfunction

    // 暂时丢这里
    function RegisterUnitAttackFunc takes string s, integer level returns nothing
        local integer i = 0
        loop
        exitwhen HaveSavedString(AbilityDataHashTable,'DMGE'+ level, i) == false
            if LoadStr(AbilityDataHashTable,'DMGE'+ level, i) == s then
                return
            endif
            set i = i + 1
        endloop
        call SaveStr(AbilityDataHashTable,'DMGE'+ level, i, s)
    endfunction

    function PreloadUnit takes integer unitId returns nothing
        call RemoveUnit(CreateUnit(Player(15), unitId, 0, 0, 0))
    endfunction

    function SetAllPlayerAbilityUnavailable takes integer id returns nothing
        call SetPlayerAbilityAvailable(Player(1), id, false)
        call SetPlayerAbilityAvailable(Player(2), id, false)
        call SetPlayerAbilityAvailable(Player(3), id, false)
        call SetPlayerAbilityAvailable(Player(4), id, false)
        call SetPlayerAbilityAvailable(Player(5), id, false)
        call SetPlayerAbilityAvailable(Player(7), id, false)
        call SetPlayerAbilityAvailable(Player(8), id, false)
        call SetPlayerAbilityAvailable(Player(9), id, false)
        call SetPlayerAbilityAvailable(Player(10), id, false)
        call SetPlayerAbilityAvailable(Player(11), id, false)
    endfunction

    //创建一个一次性计时器，返回值是计时器的整数地址，需要手动销毁。
    function TimerStartSingle takes real timeout, code callback returns integer
        local timer   t = CreateTimer()
        local integer h = GetHandleId(t)
        call FlushChildHashtable(HY, h)
        call TimerStart(t, timeout, false, callback)
        set t = null
        return h
    endfunction

    function CreateTimerStartSimple takes real timeout, boolean periodic, code handlerFunc returns integer
        set bj_lastStartedTimer = CreateTimer()
        call TimerStart(bj_lastStartedTimer, timeout, periodic, handlerFunc)
        return GetHandleId(bj_lastStartedTimer)
    endfunction

    //创建一个计时器事件触发器，返回值是触发器的整数地址，需要手动销毁。注意func为触发器的条件Condition而不是动作Action。
    function CreateTimerEventTrigger takes real timeout, boolean periodic, code func returns integer
        local trigger trig = CreateTrigger()
        local integer h    = GetHandleId(trig)

        call TriggerAddCondition(trig, Condition(func))
        call TriggerRegisterTimerEvent(trig, timeout, periodic)

        set trig = null
        return h
    endfunction

    function TriggerRegisterAnyUnitEvent takes trigger t, playerunitevent whichEvent returns nothing
        local integer i = 0
        loop
            call TriggerRegisterPlayerUnitEvent(t, Player(i), whichEvent, null)
            set i = i + 1
        exitwhen i == bj_MAX_PLAYER_SLOTS
        endloop
    endfunction  
    function TriggerRegisterUserUnitEvent takes trigger t, playerunitevent whichEvent returns nothing
        local integer i = 1
        loop
        exitwhen i > 5
            call TriggerRegisterPlayerUnitEvent(t, SentinelPlayers[i], whichEvent, null)
            call TriggerRegisterPlayerUnitEvent(t, ScourgePlayers[i], whichEvent, null)
            set i = i + 1
        endloop
    endfunction

endlibrary
