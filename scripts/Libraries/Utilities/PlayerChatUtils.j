
library PlayerChatUtils /*
*************************************************************************************
*
*   */ requires /*
*
*************************************************************************************
*
*       */ TimerUtils  /*
*       */ PlayerUtils /*
*
**************************************************************************************
*
*   // 玩家聊天频道：全部
*   constant integer CHAT_CHANNEL_ALL		
*   // 玩家聊天频道：盟友
*   constant integer CHAT_CHANNEL_ALLY		
*   // 玩家聊天频道：裁判
*   constant integer CHAT_CHANNEL_OBSERVER	
*   // 玩家聊天频道：私人
*   constant integer CHAT_CHANNEL_PRIVATE
*
**************************************************************************************
*/

    private keyword PlayerChatInit
    
    // 异步库
    struct PlayerChat extends array
        
        private static trigger          Trig

        private static constant string  PREFIX            = "CHAT"
        private static constant real    DEFAULT_TIME      = 10.
        
        // 限制在同时最多发SEND_CHAT_MAX条 SEND_CHAT_TIMEOUT限制时间
        private static constant real    SEND_CHAT_TIMEOUT = 10.
        private static constant integer SEND_CHAT_MAX     = 10
   
        private static constant integer SEND_TYPE_ALL_PLAYERS    = 1
        private static constant integer SEND_TYPE_ALLIED_PLAYERS = 2

        private static real array sendChatTime
        
        // 是否抵达了当前发送限制
        private static method GetSendLimit takes nothing returns boolean
            local integer i = 1
            local real    t = GameTimer.GetElapsed() - SEND_CHAT_TIMEOUT
            loop
                exitwhen i > SEND_CHAT_MAX
                if sendChatTime[i] < t then
                    set sendChatTime[i] = GameTimer.GetElapsed()
                    return false
                elseif sendChatTime[i] == null then
                    set sendChatTime[i] = GameTimer.GetElapsed()
                    return false
                endif
                set i = i + 1
            endloop
            return true
        endmethod

        // 本地使用，发送同步信息给所有玩家
        static method SendChatToAllPlayers takes string msg, integer channel returns nothing
            if not GetSendLimit() then
                call DzSyncData(PREFIX, msg + "#" + R2S(DEFAULT_TIME) + "#" + I2S(channel) + "#" + I2S(SEND_TYPE_ALL_PLAYERS))
            endif
        endmethod

        // 本地使用，发送同步信息给盟友玩家
        static method SendChatToAlliedPlayers takes string msg, integer channel returns nothing
            if not GetSendLimit() then
                call DzSyncData(PREFIX, msg + "#" + R2S(DEFAULT_TIME) + "#" + I2S(channel) + "#" + I2S(SEND_TYPE_ALLIED_PLAYERS))
            endif
        endmethod

        private static method OnSynced takes nothing returns nothing
            local User    p       = User[DzGetTriggerSyncPlayer()]
            local string  data    = DzGetTriggerSyncData()
            local string  msg     = MHString_Split(data, "#", 1)
            local real    dur     = S2R(MHString_Split(data, "#", 2))
            local integer channel = S2I(MHString_Split(data, "#", 3))
            call MHUI_SendPlayerChat(p.handle, msg, dur, channel)
        endmethod

        implement PlayerChatInit
    endstruct

    private module PlayerChatInit
        private static method onInit takes nothing returns nothing
            set Trig = CreateTrigger()
            call DzTriggerRegisterSyncData(Trig, PREFIX, false)
            call TriggerAddCondition(Trig, Condition(function thistype.OnSynced))
        endmethod
    endmodule

endlibrary
