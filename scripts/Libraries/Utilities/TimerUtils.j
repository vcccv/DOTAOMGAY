
library TimerUtils /*
*************************************************************************************
*
*   */ requires /*
*
*************************************************************************************
*
*       */ Table  /*
*
**************************************************************************************
*   
*   获取中心计时器逝去时间
*   static method GetElapsed takes nothing returns real
*   
**************************************************************************************
*/

    private keyword GameTimerInit

    struct GameTimer extends array
    
        private static timer MainTimer
        
        private static constant string PREFIX = "CHAT"
    
        // 获取中心计时器逝去时间
        static method GetElapsed takes nothing returns real
            return TimerGetElapsed(MainTimer)
        endmethod
    
        implement GameTimerInit
    endstruct
    
    private module GameTimerInit
        private static method onInit takes nothing returns nothing
            set MainTimer = CreateTimer()
            call TimerStart(MainTimer, 999999., false, null)
        endmethod
    endmodule

    struct SimpleTick
        
        private static integer MAX = 0
        private        timer   handle
        static method GetCount takes nothing returns integer
            return MAX
        endmethod
        static method GetExpired takes nothing returns thistype
            return Table[KEY][GetHandleId(GetExpiredTimer())]
        endmethod
        static method Create takes nothing returns thistype
            local thistype this = thistype.allocate()
            set MAX = MAX + 1
            if this.handle == null then
                set this.handle = CreateTimer()
                set Table[KEY][GetHandleId(this.handle)] = this
            endif
            return this
        endmethod
        method GetHandle takes nothing returns timer
            return this.handle
        endmethod
        method GetElapsed takes nothing returns real
            return TimerGetElapsed(this.handle)
        endmethod
        method GetRemaining takes nothing returns real
            return TimerGetRemaining(this.handle)
        endmethod
        method GetTimeout takes nothing returns real
            return TimerGetTimeout(this.handle)
        endmethod
        method Pause takes nothing returns nothing
            call PauseTimer(this.handle)
        endmethod
        method Resume takes nothing returns nothing
            call ResumeTimer(this.handle)
        endmethod
        method Start takes real r, boolean flag, code c returns nothing
            call TimerStart(this.handle, r, flag, c)
        endmethod
        method Destroy takes nothing returns nothing
            set MAX = MAX - 1
            call PauseTimer(this.handle)
            call thistype.deallocate(this)
        endmethod

    endstruct
    
endlibrary
