
library Base requires TriggerDestroyQueue, GroupAlloc, ErrorMessage
    
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


    // unit

    // 获取物品在物品栏的格数（指定物品类型）
    // Translates 0-based slot indices to 1-based slot indices.
    function GetInventoryIndexOfItemType takes unit whichUnit, integer itemId returns integer
        local integer index
        local item indexItem

        set index = 0
        loop
            set indexItem = UnitItemInSlot(whichUnit, index)
            if(indexItem != null) and(GetItemTypeId(indexItem) == itemId) then
                return index + 1
            endif

            set index = index + 1
            exitwhen index >= 5
        endloop

        set indexItem = null
        return 0
    endfunction

    // 获取英雄携带的物品（指定物品类型）
    function GetItemOfTypeFromUnit takes unit whichUnit, integer itemId returns item
        local integer index
        local item    indexItem
        set index = 0
        loop
            set indexItem = UnitItemInSlot(whichUnit, index)
            if indexItem != null and GetItemTypeId(indexItem) == itemId then
                set indexItem = null
                return UnitItemInSlot(whichUnit, index)
            endif
            set index = index + 1
            exitwhen index > bj_MAX_INVENTORY
        endloop
        set indexItem = null
        return null
    endfunction

    // 查询英雄是否已有物品（指定物品类型）
    function UnitHasItemOfType takes unit whichUnit, integer itemId returns boolean
        return GetInventoryIndexOfItemType(whichUnit, itemId) > 0
    endfunction

endlibrary

