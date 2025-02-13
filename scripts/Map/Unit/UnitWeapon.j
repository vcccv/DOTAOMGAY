
library UnitWeapon requires Base, UnitUtils

    private function DelayUpdateAttackRangeOnExpired takes nothing returns nothing
        local SimpleTick tick      = SimpleTick.GetExpired()
        local unit       whichUnit = SimpleTickTable[tick].unit['u']

        if MHUnit_GetAttackTargetUnit(whichUnit) == null then
            call MHUnit_Stun(whichUnit, true)
            call MHUnit_Stun(whichUnit, false)
        endif

        set whichUnit = null
    endfunction
    // 更新射程后调用，让其重新认知到自己的射程
    function UnitUpdateAttackOrder takes unit whichUnit returns nothing
        local SimpleTick tick
        if MHUnit_GetAttackTargetUnit(whichUnit) == null then
            return
        endif
        set tick = SimpleTick.CreateEx()
        call tick.Start(0., false, function DelayUpdateAttackRangeOnExpired)
        set SimpleTickTable[tick].unit['u'] = whichUnit
    endfunction

endlibrary
