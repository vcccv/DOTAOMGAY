
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

    function AddSpecialPassiveAbilityList takes integer abilId returns nothing
        set Max = Max + 1
        set List[Max] = abilId
    endfunction

    function SpecialPassiveAbility_Init takes nothing returns nothing
        // 潮汐使者
        call AddSpecialPassiveAbilityList('A522')

        // 余震
        call AddSpecialPassiveAbilityList('QP1G')

        // 反击螺旋
        call AddSpecialPassiveAbilityList('QP17')

        // 勇气之霎
        call AddSpecialPassiveAbilityList('QP1O')

        // 天幕坠落
        call AddSpecialPassiveAbilityList('A3UF')

        // 天幕坠落
        call AddSpecialPassiveAbilityList('A46D')
    endfunction

endlibrary


