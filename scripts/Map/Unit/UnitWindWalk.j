
library WindWalk requires UnitLimitation, AbilityUtils
    
    function UnitWindWalkBuffOnAdd takes nothing returns nothing
        local unit whichUnit = MHEvent_GetUnit()
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
        local unit       whichUnit = MHEvent_GetUnit()

        set tick = SimpleTick.CreateEx()
        call tick.Start(0., false, function UnitWindWalkDelayUpdateOnExpired)
        set SimpleTickTable[tick].unit['u'] = whichUnit

        set whichUnit = null
    endfunction

    function UnitWindWalk_Init takes nothing returns nothing
        // 破碎暗影步
        call SetAbilityAddAction('B39C', "UnitWindWalkBuffOnAdd")
        call SetAbilityRemoveAction('B39C', "UnitWindWalkBuffOnRemove")

        // 隐刀
        call SetAbilityAddAction('B07T', "UnitWindWalkBuffOnAdd")
        call SetAbilityRemoveAction('B07T', "UnitWindWalkBuffOnRemove")

        // 马甲技能
        call SetAbilityAddAction('BOwk', "UnitWindWalkBuffOnAdd")
        call SetAbilityRemoveAction('BOwk', "UnitWindWalkBuffOnRemove")

        // 神出鬼没
        call SetAbilityAddAction('B039', "UnitWindWalkBuffOnAdd")
        call SetAbilityRemoveAction('B039', "UnitWindWalkBuffOnRemove")

        // 不知道谁的疾风步
        call SetAbilityAddAction('B076', "UnitWindWalkBuffOnAdd")
        call SetAbilityRemoveAction('B076', "UnitWindWalkBuffOnRemove")

        // 赏金猎人疾风步
        call SetAbilityAddAction('B068', "UnitWindWalkBuffOnAdd")
        call SetAbilityRemoveAction('B068', "UnitWindWalkBuffOnRemove")

        // 缩地
        call SetAbilityAddAction('BHfs', "UnitWindWalkBuffOnAdd")
        call SetAbilityRemoveAction('BHfs', "UnitWindWalkBuffOnRemove")

        // 隐匿
        call SetAbilityAddAction('B08K', "UnitWindWalkBuffOnAdd")
        call SetAbilityRemoveAction('B08K', "UnitWindWalkBuffOnRemove")

        // 幽灵漫步
        call SetAbilityAddAction('B08X', "UnitWindWalkBuffOnAdd")
        call SetAbilityRemoveAction('B08X', "UnitWindWalkBuffOnRemove")
    endfunction

endlibrary
