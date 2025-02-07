
library UnitLimitation requires Base, UnitModel

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
            //call UnitDodgeMissile(whichUnit)
            call UnitAdd0x60Flag(whichUnit, 0x20)
            call MHUnit_Flag1Operator(whichUnit, FLAG_OPERATOR_ADD, UNIT_FLAG1_HIDE)
        endif
    endfunction
    function UnitSubHideExCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_HIDEEX_COUNT] - 1
        set Table[h][UNIT_HIDEEX_COUNT] = count
        if count == 0 then
            call UnitRemove0x60Flag(whichUnit, 0x20)
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
            call UnitMakeAbilityPermanent(whichUnit, true, 'Avul')
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
        private constant key UNIT_PHASED_MOVEMENT_COUNT
    endglobals
    function UnitEnablePhasedMovement takes unit whichUnit returns nothing
        local integer id    = GetUnitTypeId(whichUnit)
        if IsUnitType(whichUnit, UNIT_TYPE_FLYING) then
            call MHUnit_SetCollisionType(whichUnit, UNIT_COLLISION_TYPE_AIR, UNIT_COLLISION_TYPE_BUILDING)
        else
            call MHUnit_SetCollisionType(whichUnit, UNIT_COLLISION_TYPE_HARVESTER, UNIT_COLLISION_TYPE_BUILDING)
        endif
    endfunction
    function UnitDisablePhasedMovement takes unit whichUnit returns nothing
        local integer id    = GetUnitTypeId(whichUnit)
        call MHUnit_SetCollisionType(whichUnit, MHUnit_GetDefDataInt(id, UNIT_DEF_DATA_COLLISION_TYPE_TO_OTHER), MHUnit_GetDefDataInt(id, UNIT_DEF_DATA_COLLISION_TYPE_FROM_OTHER))
    endfunction
    function UnitAddPhasedMovementCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_PHASED_MOVEMENT_COUNT] + 1
        set Table[h][UNIT_PHASED_MOVEMENT_COUNT] = count
        if count == 1 then
            call UnitEnablePhasedMovement(whichUnit)
        endif
    endfunction
    function UnitSubPhasedMovementCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_PHASED_MOVEMENT_COUNT] - 1
        set Table[h][UNIT_PHASED_MOVEMENT_COUNT] = count
        if count == 0 then
            call UnitDisablePhasedMovement(whichUnit)
        endif
    endfunction
    function IsUnitPhasedMovenent takes unit whichUnit returns boolean
        return Table[GetHandleId(whichUnit)][UNIT_PHASED_MOVEMENT_COUNT] > 0
    endfunction

    globals
        private constant key UNIT_NOPATHING_COUNT
    endglobals
    function UnitEnableNoPathing takes unit whichUnit returns nothing
        call SetUnitPathing(whichUnit, false)
        call MHUnit_SetPathType(whichUnit, UNIT_PATH_TYPE_FLY)
    endfunction
    function UnitDisableNoPathing takes unit whichUnit returns nothing
        call SetUnitPathing(whichUnit, true)
        if IsUnitType(whichUnit, UNIT_TYPE_FLYING) then
            call MHUnit_SetPathType(whichUnit, UNIT_PATH_TYPE_FLY)
        else
            call MHUnit_SetPathType(whichUnit, UNIT_PATH_TYPE_FOOT)
        endif
    endfunction
    function UnitAddNoPathingCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_NOPATHING_COUNT] + 1
        set Table[h][UNIT_NOPATHING_COUNT] = count
        if count == 1 then
            call UnitAddPhasedMovementCount(whichUnit)
            call UnitEnableNoPathing(whichUnit)
        endif
        call BJDebugMsg("now count:" + I2S(count))
    endfunction
    function UnitSubNoPathingCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_NOPATHING_COUNT] - 1
        set Table[h][UNIT_NOPATHING_COUNT] = count
        if count == 0 then
            call UnitSubPhasedMovementCount(whichUnit)
            call UnitDisableNoPathing(whichUnit)
        endif
        call BJDebugMsg("now count:" + I2S(count))
    endfunction
    function IsUnitNoPathing takes unit whichUnit returns boolean
        return Table[GetHandleId(whichUnit)][UNIT_NOPATHING_COUNT] > 0
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
    private function OnAddStunCountSafeEnd takes nothing returns nothing
        local SimpleTick tick      = SimpleTick.GetExpired()
        local unit       whichUnit = SimpleTick.GetTable()[tick].unit['U']
        call UnitAddStunCount(whichUnit)
        call tick.Destroy()
        set whichUnit = null
    endfunction
    function UnitAddStunCountSafe takes unit whichUnit returns nothing
        local SimpleTick tick
        if GetTriggerEventId() == EVENT_PLAYER_UNIT_SPELL_EFFECT or GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
            set tick = SimpleTick.Create(0)
            set SimpleTick.GetTable()[tick].unit['U'] = whichUnit
            call tick.Start(0., false, function OnAddStunCountSafeEnd)
        else
            call UnitAddStunCount(whichUnit)
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

    // 通常在变身后刷新
    function UpdateUnitLimitation takes unit whichUnit returns nothing
        // 相位移动
        if IsUnitPhasedMovenent(whichUnit) then
            call UnitEnablePhasedMovement(whichUnit)
        else
            call UnitDisablePhasedMovement(whichUnit)
        endif
        // 无路径
        if IsUnitNoPathing(whichUnit) then
            call UnitEnableNoPathing(whichUnit)
        else
            call UnitDisableNoPathing(whichUnit)
        endif
    endfunction

endlibrary
