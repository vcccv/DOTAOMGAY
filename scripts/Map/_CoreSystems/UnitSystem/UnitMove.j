
library UnitMove
    
    globals
        private key NO_LIMIT_MOVE_SPEED
        private key NO_LIMIT_MOVE_SPEED_PERCENT
    endglobals

    function GetUnitMoveSpeedBonus takes unit u returns integer
        local integer level = GetUnitAbilityLevel(u,'EUL1')
        local integer U4V   = GetUnitAbilityLevel(u,'EUL2')
        local integer U5V
        if GetUnitAbilityLevel(u, 'A33W')> 0 then
            return 1000
        endif
        if level > 0 then
            if level == 1 then
                set U5V = 40
            elseif level == 2 then
                set U5V = 90
            elseif level == 4 then
                set U5V = 95
            else
                set U5V = 100 
            endif
        endif
        if U4V > 0 then
            if U4V == 1 then
                set U5V = 125
            elseif U4V == 2 then
                set U5V = 140
            endif
        endif
        if level + U4V > 0 then
            return U5V
        endif
        if GetUnitAbilityLevel(u,'A00D')> 0 then
            return 100 
        elseif GetUnitAbilityLevel(u,'A2HR')> 0 then
            return 85
        elseif GetUnitAbilityLevel(u,'A1VR')> 0 then
            return 55
        elseif GetUnitAbilityLevel(u,'A05U')> 0 or GetUnitAbilityLevel(u,'A12V')> 0 then
            return 50
        elseif GetUnitAbilityLevel(u,'AIms')> 0 then
            return 50
        elseif GetUnitAbilityLevel(u,'A2I9')> 0 then
            return 60
        endif
        return 0
    endfunction

    function GetUnitNoLimitMoveSpeed takes unit whichUnit returns integer
        if GetUnitAbilityLevel(whichUnit, 'A46F') > 0 then
            // 幻影冲锋
            return 800
        elseif GetUnitAbilityLevel(whichUnit, 'B0J1') > 0 then
            // 时间结界
            return 700
        elseif GetUnitAbilityLevel(whichUnit, 'B00V') > 0 then
            // 变狼
            return 650
        endif
        return Table[GetHandleId(whichUnit)][NO_LIMIT_MOVE_SPEED]
    endfunction

    // 强制性的无上限移速设置
    function UnitUpdateNoLimitMoveSpeed takes unit whichUnit returns nothing
        local integer h            = GetHandleId(whichUnit)
        local integer percentSpeed = Table[h].integer[NO_LIMIT_MOVE_SPEED_PERCENT]
        local integer moveSpeed    = GetUnitNoLimitMoveSpeed(whichUnit) // 强制移速限制
        local real    value        = GetUnitMoveSpeed(whichUnit)

        if percentSpeed == 0 and moveSpeed == 0. then
            call MHUnit_ResetMoveSpeedLimit(whichUnit)
            call SetUnitMoveSpeed(whichUnit, GetUnitDefaultMoveSpeed(whichUnit))
            return
        endif

        set value = RMinBJ(value, 522.)
        // 单位实际移速值 * 超限制移速百分比 vs 强制移速限制
        // 谁大就谁上
        set value = RMaxBJ(value *(100. + percentSpeed)/ 100., moveSpeed * 1.)

        if value > 522. then
            call MHUnit_SetMoveSpeedLimit(whichUnit, value)
            call SetUnitMoveSpeed(whichUnit, value * 100.)
        else
            call MHUnit_ResetMoveSpeedLimit(whichUnit)    
            // 低于522则恢复
            call SetUnitMoveSpeed(whichUnit, GetUnitDefaultMoveSpeed(whichUnit))
        endif
    endfunction

    function SetUnitNoLimitMoveSpeed takes unit whichUnit, integer moveSpeed returns nothing
        set Table[GetHandleId(whichUnit)].integer[NO_LIMIT_MOVE_SPEED] = moveSpeed
        call UnitUpdateNoLimitMoveSpeed(whichUnit)
    endfunction

    // 无视移速上限的百分比速度奖励
    function SetUnitNoLimitMoveSpeedPercentBonus takes unit whichUnit, integer percent returns nothing
        set Table[GetHandleId(whichUnit)].integer[NO_LIMIT_MOVE_SPEED_PERCENT] = percent
        call UnitUpdateNoLimitMoveSpeed(whichUnit)
    endfunction

endlibrary
