
library WindWalk requires UnitLimitation, AbilityUtils
    
    function UnitWindWalkBuffOnAdd takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        call UpdateUnitLimitation(whichUnit)
        set whichUnit = null
    endfunction
    function UnitWindWalkDelayUpdateOnExpired takes nothing returns nothing
        local SimpleTick tick = SimpleTick.GetExpired()
        call UpdateUnitLimitation(SimpleTickTable[tick].unit['u'])
        call tick.Destroy()
    endfunction
    function UnitWindWalkBuffOnRemove takes nothing returns nothing
        local SimpleTick tick
        local unit       whichUnit = Event.GetTriggerUnit()

        set tick = SimpleTick.CreateEx()
        call tick.Start(0., false, function UnitWindWalkDelayUpdateOnExpired)
        set SimpleTickTable[tick].unit['u'] = whichUnit

        set whichUnit = null
    endfunction

    function UnitWindWalk_Init takes nothing returns nothing
        // 破碎暗影步
        call RegisterAbilityAddMethod('B39C', "UnitWindWalkBuffOnAdd")
        call RegisterAbilityRemoveMethod('B39C', "UnitWindWalkBuffOnRemove")

        // 隐刀
        call RegisterAbilityAddMethod('B07T', "UnitWindWalkBuffOnAdd")
        call RegisterAbilityRemoveMethod('B07T', "UnitWindWalkBuffOnRemove")

        // 马甲技能
        call RegisterAbilityAddMethod('BOwk', "UnitWindWalkBuffOnAdd")
        call RegisterAbilityRemoveMethod('BOwk', "UnitWindWalkBuffOnRemove")

        // 神出鬼没
        call RegisterAbilityAddMethod('B039', "UnitWindWalkBuffOnAdd")
        call RegisterAbilityRemoveMethod('B039', "UnitWindWalkBuffOnRemove")

        // 不知道谁的疾风步
        call RegisterAbilityAddMethod('B076', "UnitWindWalkBuffOnAdd")
        call RegisterAbilityRemoveMethod('B076', "UnitWindWalkBuffOnRemove")

        // 赏金猎人疾风步
        call RegisterAbilityAddMethod('B068', "UnitWindWalkBuffOnAdd")
        call RegisterAbilityRemoveMethod('B068', "UnitWindWalkBuffOnRemove")

        // 缩地
        call RegisterAbilityAddMethod('BHfs', "UnitWindWalkBuffOnAdd")
        call RegisterAbilityRemoveMethod('BHfs', "UnitWindWalkBuffOnRemove")

        // 隐匿
        call RegisterAbilityAddMethod('B08K', "UnitWindWalkBuffOnAdd")
        call RegisterAbilityRemoveMethod('B08K', "UnitWindWalkBuffOnRemove")

        // 幽灵漫步
        call RegisterAbilityAddMethod('B08X', "UnitWindWalkBuffOnAdd")
        call RegisterAbilityRemoveMethod('B08X', "UnitWindWalkBuffOnRemove")
    endfunction

endlibrary
