
library UnitLimitation requires UnitModel

    globals
        private constant key UNIT_CANT_SELECT_COUNT
    endglobals
    function UnitAddCantSelectCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_CANT_SELECT_COUNT] + 1
        set Table[h][UNIT_CANT_SELECT_COUNT] = count
        if count == 1 then
            call MHUnit_Flag1Operator(whichUnit, FLAG_OPERATOR_REMOVE, UNIT_FLAG1_CANSELECT)
        endif
    endfunction
    function UnitSubCantSelectCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_CANT_SELECT_COUNT] - 1
        set Table[h][UNIT_CANT_SELECT_COUNT] = count
        if count == 0 then
            call MHUnit_Flag1Operator(whichUnit, FLAG_OPERATOR_ADD, UNIT_FLAG1_CANSELECT)
        endif
    endfunction

    globals
        private constant key UNIT_HIDEEX_COUNT
    endglobals
    function UnitAddHideExCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_HIDEEX_COUNT] + 1
        set Table[h][UNIT_HIDEEX_COUNT] = count
        if count == 1 then
            call MHUnit_Flag1Operator(whichUnit, FLAG_OPERATOR_ADD, UNIT_FLAG1_HIDE)
        endif
    endfunction
    function UnitSubHideExCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_HIDEEX_COUNT] - 1
        set Table[h][UNIT_HIDEEX_COUNT] = count
        if count == 0 then
            call MHUnit_Flag1Operator(whichUnit, FLAG_OPERATOR_REMOVE, UNIT_FLAG1_HIDE)
        endif
    endfunction

    globals
        private constant key UNIT_HIDE_BY_COLOR_COUNT
    endglobals
    function UnitAddHideByColorCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_HIDE_BY_COLOR_COUNT] + 1
        set Table[h][UNIT_HIDE_BY_COLOR_COUNT] = count
        if count == 1 then
            call SetUnitVertexColorEx(whichUnit, -1, -1, -1, 0)
        endif
    endfunction
    function UnitSubHideByColorCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_HIDE_BY_COLOR_COUNT] - 1
        set Table[h][UNIT_HIDE_BY_COLOR_COUNT] = count
        if count == 0 then
            call SetUnitVertexColorEx(whichUnit, -1, -1, -1, 255)
        endif
    endfunction

    globals
        private constant key UNIT_INVULNERABLE_COUNT
    endglobals
    function UnitAddInvulnerableCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_INVULNERABLE_COUNT] + 1
        set Table[h][UNIT_INVULNERABLE_COUNT] = count
        if count == 1 then
            call SetUnitInvulnerable(whichUnit, true)
        endif
    endfunction
    function UnitSubInvulnerableCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_INVULNERABLE_COUNT] - 1
        set Table[h][UNIT_INVULNERABLE_COUNT] = count
        if count == 0 then
            call SetUnitInvulnerable(whichUnit, false)
        endif
    endfunction

    globals
        private constant key UNIT_NOPATHING_COUNT
    endglobals
    function UnitAddNoPathingCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_NOPATHING_COUNT] + 1
        set Table[h][UNIT_NOPATHING_COUNT] = count
        if count == 1 then
            call SetUnitPathing(whichUnit, false)
        endif
    endfunction
    function UnitSubNoPathingCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_NOPATHING_COUNT] - 1
        set Table[h][UNIT_NOPATHING_COUNT] = count
        if count == 0 then
            call SetUnitPathing(whichUnit, true)
        endif
    endfunction

    globals
        private constant key UNIT_DISABLE_ATTACK_COUNT
    endglobals
    function UnitAddDisableAttackCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_DISABLE_ATTACK_COUNT] + 1
        set Table[h][UNIT_DISABLE_ATTACK_COUNT] = count
        if count == 1 then
            call MHAbility_Disable(whichUnit, 'Aatk', true, false)
        endif
    endfunction
    function UnitSubDisableAttackCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_DISABLE_ATTACK_COUNT] - 1
        set Table[h][UNIT_DISABLE_ATTACK_COUNT] = count
        if count == 0 then
            call MHAbility_Disable(whichUnit, 'Aatk', false, false)
        endif
    endfunction

    globals
        private constant key UNIT_PAUSE_COUNT
    endglobals
    function UnitAddStunCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_PAUSE_COUNT] + 1
        set Table[h][UNIT_PAUSE_COUNT] = count
        if count == 1 then
            call MHUnit_Stun(whichUnit, true)
        endif
    endfunction
    function UnitSubStunCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_PAUSE_COUNT] - 1
        set Table[h][UNIT_PAUSE_COUNT] = count
        if count == 0 then
            call MHUnit_Stun(whichUnit, false)
        endif
    endfunction
    
    globals
        private constant key UNIT_TRUESIGHT_IMMUNITY_COUNT
    endglobals
    function UnitAddTruesightImmunityCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_TRUESIGHT_IMMUNITY_COUNT] + 1
        set Table[h][UNIT_TRUESIGHT_IMMUNITY_COUNT] = count
        if count == 1 then
            call UnitEnableTruesightImmunity(whichUnit)
        endif
    endfunction
    function UnitSubTruesightImmunityCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_TRUESIGHT_IMMUNITY_COUNT] - 1
        set Table[h][UNIT_TRUESIGHT_IMMUNITY_COUNT] = count
        if count == 0 then
            call UnitDisableTruesightImmunity(whichUnit)
        endif
    endfunction

endlibrary
