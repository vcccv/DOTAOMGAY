library TriggerDestroyQueue requires TimerUtils, ErrorMessage

    globals
        private trigger array Trig
        private real    array Time
        private integer MAX = 0
    endglobals

    function AddTriggerToDestroyQueue takes trigger t returns nothing
        call DisableTrigger(t)
        set MAX = MAX + 1
        set Trig[MAX]= t
        set Time[MAX]= GameTimer.GetElapsed() + 60.
        call ThrowWarning(MAX > 8000, "DestroyTrigger", "DestroyTrigger", null, 0, "MAX > 8000")
    endfunction

    #define DestroyTrigger(t) AddTriggerToDestroyQueue(t)
    
    // 好像不是队列
    private function Dequeue takes integer i returns nothing
        if i != MAX then
            set Trig[i]= Trig[MAX]
            set Time[i]= Time[MAX]
        endif
        set Trig[MAX] = null
        set Time[MAX] = 0
        set MAX = MAX -1
    endfunction

    private function OnUpdate takes nothing returns nothing
        local real    time = GameTimer.GetElapsed()
        local integer i
        set i = 1
        loop
        exitwhen i > MAX
            if Time[i] < time then
                if Trig[i]== null or IsTriggerEnabled(Trig[i]) then
                    call ThrowWarning(Trig[i]== null, "TriggerDestroyQueue", "OnUpdate", "trigger", GetHandleId(Trig[i]), "null")
                else
                    call DestroyTrigger(Trig[i])
                endif
                call Dequeue(i)
            else
                set i = i + 1
            endif
        endloop
    endfunction
    
    function TriggerDestroyQueue_Init takes nothing returns nothing
        local trigger trig
        set trig = CreateTrigger()
        call TriggerRegisterTimerEvent(trig, 15, true)
        call TriggerAddCondition(trig, Condition(function OnUpdate))
    endfunction

endlibrary
