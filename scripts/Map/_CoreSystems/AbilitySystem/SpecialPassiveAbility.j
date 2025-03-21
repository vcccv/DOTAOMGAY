
library SpecialPassiveAbility requires TimerUtils
    
    globals
        private integer       Max  = 0
        private integer array List
    endglobals

    private function OnEnable takes nothing returns nothing
        local SimpleTick tick  = SimpleTick.GetExpired()
        local unit       whichUnit = SimpleTickTable[tick].unit['U']
        local player     whichPlayer = GetOwningPlayer(whichUnit)
        local integer    i

        set i = 1
        loop
            exitwhen i > Max
            call SetPlayerAbilityAvailable(whichPlayer, List[i], true)
            set i = i + 1
        endloop

        call tick.Destroy()
        set whichUnit = null
    endfunction
    function DisableUnitSpecialPassiveAbility takes unit whichUnit returns nothing
        local SimpleTick tick  = SimpleTick.CreateEx()
        local integer    i
        local player     whichPlayer = GetOwningPlayer(whichUnit)

        set i = 1
        loop
            exitwhen i > Max
            call SetPlayerAbilityAvailable(whichPlayer, List[i], false)
            set i = i + 1
        endloop

        set SimpleTickTable[tick].unit['U'] = whichUnit
        call tick.Start(0., false, function OnEnable) 
    endfunction

    function RegisterSpecialPassiveAbilityById takes integer abilId returns nothing
        set Max = Max + 1
        set List[Max] = abilId
    endfunction

    function SpecialPassiveAbility_Init takes nothing returns nothing
       // // 潮汐使者
       // call RegisterSpecialPassiveAbilityById('A522')

       // // 余震
       // call RegisterSpecialPassiveAbilityById('QP1G')

       // // 反击螺旋
       // call RegisterSpecialPassiveAbilityById('QP17')

       // // 勇气之霎
       // call RegisterSpecialPassiveAbilityById('QP1O')

       // // 幻影冲锋
       // call RegisterSpecialPassiveAbilityById('A46D')

        // 侧面机枪
        call RegisterSpecialPassiveAbilityById('A3UR')
        
        // 天幕坠落
    endfunction

endlibrary


