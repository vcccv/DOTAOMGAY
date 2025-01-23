
library Base requires TriggerDestroyQueue, GroupAlloc
    
    //创建一个一次性计时器，返回值是计时器的整数地址，需要手动销毁。
    function TimerStartSingle takes real timeout, code callback returns integer
        local timer   t = CreateTimer()
        local integer h = GetHandleId(t)
        call FlushChildHashtable(HY, h)
        call TimerStart(t, timeout, false, callback)
        set t = null
        return h
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

endlibrary

