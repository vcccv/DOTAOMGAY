
library UnitMove
    
    globals
        private key NO_LIMIT_MOVE_SPEED
        private key NO_LIMIT_MOVE_SPEED_PERCENT
    endglobals

    // 强制性的无上限移速设置
    function UpdateUnitNoLimitMoveSpeed takes unit whichUnit returns nothing
        local integer h            = GetHandleId(whichUnit)
        local integer percentSpeed = Table[h][NO_LIMIT_MOVE_SPEED_PERCENT]
        local integer moveSpeed    = Table[h][NO_LIMIT_MOVE_SPEED]
        local real    value        = GetUnitDefaultMoveSpeed(whichUnit) + GetUnitMoveSpeedBonus(u)

        if percentSpeed == 0 and moveSpeed == 0 then
            call MHUnit_ResetMoveSpeedLimit(whichUnit)
            call SetUnitMoveSpeed(whichUnit, value)
            return
        endif

        set value = RMinBJ(value *(100. + percentSpeed)/ 100., value)

        call MHUnit_SetMoveSpeedLimit(whichUnit, value)
        call SetUnitMoveSpeed(whichUnit, value)
    endfunction

    function SetUnitNoLimitMoveSpeed takes unit whichUnit, integer moveSpeed returns nothing
        set Table[GetHandleId(whichUnit)][NO_LIMIT_MOVE_SPEED] = moveSpeed
        call UpdateUnitNoLimitMoveSpeed(whichUnit)
    endfunction

    // 无视移速上限的百分比速度奖励
    function SetUnitNoLimitMoveSpeedPercentBonus takes unit whichUnit, integer percent returns nothing
        set Table[GetHandleId(whichUnit)][NO_LIMIT_MOVE_SPEED_PERCENT] = moveSpeed
        call UpdateUnitNoLimitMoveSpeed(whichUnit)
    endfunction

endlibrary
