
library PlayerChatUtils /*
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
    
    struct PlayerChat extends array
        
        private static trigger         Trig

        private static constant string PREFIX       = "CHAT"
        private static constant real   DEFAULT_TIME = 10.

        static method method_name takes player p, string msg, real dur, integer channel returns nothing
            
        endmethod

        private static method OnSynced takes nothing returns nothing
            local User    p       = User[DzGetTriggerSyncPlayer()]
            local string  msg
            local integer channel
            
            call MHUI_SendPlayerChat(p.handle, msg, DEFAULT_TIME, channel)
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
