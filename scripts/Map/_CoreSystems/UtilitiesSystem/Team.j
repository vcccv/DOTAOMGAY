
library TeamUtils

    globals
        Team ScourgeTeam  = Team[1]
        Team SentinelTeam = Team[2]
    endglobals

    struct Team extends array
        
        // 队伍链表
        static User head
        static User tail
        User prev
        User next

    endstruct

endlibrary

