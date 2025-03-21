
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

    #define SimpleTickTable SimpleTick.GetTable()

    private keyword SimpleTickInit
    // 简易Tick，Create方法中可以携带一个结构实例data
    struct SimpleTick
        
        private static key        KEY
        private static TableArray table
        private static integer    MAX = 0
        private        timer      handle

        integer data

        static method GetTable takes nothing returns TableArray
            return table
        endmethod
        static method GetCount takes nothing returns integer
            return MAX
        endmethod
        static method GetExpired takes nothing returns thistype
            return Table[KEY][GetHandleId(GetExpiredTimer())]
        endmethod
        // 携带一个数据
        static method Create takes integer data returns thistype
            local thistype this = thistype.allocate()
            set MAX = MAX + 1
            if this.handle == null then
                set this.handle = CreateTimer()
                set Table[KEY][GetHandleId(this.handle)] = this
            endif
            set this.data = data
            return this
        endmethod
        static method CreateEx takes nothing returns thistype
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
            call table[this].flush()
            call thistype.deallocate(this)
        endmethod

        implement SimpleTickInit

    endstruct

    private module SimpleTickInit
        private static method onInit takes nothing returns nothing
            set table = TableArray[JASS_MAX_ARRAY_SIZE]
        endmethod
    endmodule
    
endlibrary
