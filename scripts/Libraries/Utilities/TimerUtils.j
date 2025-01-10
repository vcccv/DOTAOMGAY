
library TimerUtils /*
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
    
endlibrary
