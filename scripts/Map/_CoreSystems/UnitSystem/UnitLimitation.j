
library UnitLimitation requires Base, UnitModel

    globals
        private constant key UNIT_CANT_SELECT_COUNT
    endglobals
    function UnitIncCantSelectCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_CANT_SELECT_COUNT] + 1
        set Table[h][UNIT_CANT_SELECT_COUNT] = count
        if count == 1 then
            call MHUnit_Flag1Operator(whichUnit, FLAG_OPERATOR_REMOVE, UNIT_FLAG1_CANSELECT)
        endif
    endfunction
    function UnitDecCantSelectCount takes unit whichUnit returns nothing
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
    function UnitIncHideExCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_HIDEEX_COUNT] + 1
        set Table[h][UNIT_HIDEEX_COUNT] = count
        if count == 1 then
            //call UnitDodgeMissile(whichUnit)
            call UnitAdd0x60Flag(whichUnit, 0x20)
            call MHUnit_Flag1Operator(whichUnit, FLAG_OPERATOR_ADD, UNIT_FLAG1_HIDE)
        endif
    endfunction
    function UnitDecHideExCount takes unit whichUnit returns nothing
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
    function UnitIncHideByColorCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_HIDE_BY_COLOR_COUNT] + 1
        set Table[h][UNIT_HIDE_BY_COLOR_COUNT] = count
        if count == 1 then
            call SetUnitVertexColorEx(whichUnit, -1, -1, -1, 0)
        endif
    endfunction
    function UnitDecHideByColorCount takes unit whichUnit returns nothing
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
    function UnitIncInvulnerableCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_INVULNERABLE_COUNT] + 1
        set Table[h][UNIT_INVULNERABLE_COUNT] = count
        if count == 1 then
            call SetUnitInvulnerable(whichUnit, true)
            call UnitMakeAbilityPermanent(whichUnit, true, 'Avul')
        endif
    endfunction
    function UnitDecInvulnerableCount takes unit whichUnit returns nothing
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
    function UnitIncPhasedMovementCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_PHASED_MOVEMENT_COUNT] + 1
        set Table[h][UNIT_PHASED_MOVEMENT_COUNT] = count
        if count == 1 then
            call UnitEnablePhasedMovement(whichUnit)
        endif
    endfunction
    function UnitDecPhasedMovementCount takes unit whichUnit returns nothing
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
    function UnitIncNoPathingCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_NOPATHING_COUNT] + 1
        set Table[h][UNIT_NOPATHING_COUNT] = count
        if count == 1 then
            call UnitIncPhasedMovementCount(whichUnit)
            call UnitEnableNoPathing(whichUnit)
        endif
    endfunction
    function UnitDecNoPathingCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_NOPATHING_COUNT] - 1
        set Table[h][UNIT_NOPATHING_COUNT] = count
        if count == 0 then
            call UnitDecPhasedMovementCount(whichUnit)
            call UnitDisableNoPathing(whichUnit)
        endif
    endfunction
    function IsUnitNoPathing takes unit whichUnit returns boolean
        return Table[GetHandleId(whichUnit)][UNIT_NOPATHING_COUNT] > 0
    endfunction

    globals
        private constant key UNIT_DISABLE_ATTACK_COUNT
    endglobals
    function UnitIncDisableAttackCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_DISABLE_ATTACK_COUNT] + 1
        set Table[h][UNIT_DISABLE_ATTACK_COUNT] = count
        if count == 1 then
            call MHAbility_Disable(whichUnit, 'Aatk', true, false)
        endif
    endfunction
    function UnitDecDisableAttackCount takes unit whichUnit returns nothing
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
  
    function UnitIncStunCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_PAUSE_COUNT] + 1
        set Table[h][UNIT_PAUSE_COUNT] = count
        if count == 1 then
            call MHUnit_Stun(whichUnit, true)
        endif
    endfunction
    function UnitDecStunCount takes unit whichUnit returns nothing
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
        call UnitIncStunCount(whichUnit)
        call tick.Destroy()
        set whichUnit = null
    endfunction
    function UnitIncStunCountSafe takes unit whichUnit returns nothing
        local SimpleTick tick
        if GetTriggerEventId() == EVENT_PLAYER_UNIT_SPELL_EFFECT or GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
            set tick = SimpleTick.Create(0)
            set SimpleTick.GetTable()[tick].unit['U'] = whichUnit
            call tick.Start(0., false, function OnAddStunCountSafeEnd)
        else
            call UnitIncStunCount(whichUnit)
        endif
    endfunction
    
    globals
        private constant key UNIT_TRUESIGHT_IMMUNITY_COUNT
    endglobals
    function UnitIncTruesightImmunityCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_TRUESIGHT_IMMUNITY_COUNT] + 1
        set Table[h][UNIT_TRUESIGHT_IMMUNITY_COUNT] = count
        if count == 1 then
            call UnitEnableTruesightImmunity(whichUnit)
        endif
    endfunction
    function UnitDecTruesightImmunityCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_TRUESIGHT_IMMUNITY_COUNT] - 1
        set Table[h][UNIT_TRUESIGHT_IMMUNITY_COUNT] = count
        if count == 0 then
            call UnitDisableTruesightImmunity(whichUnit)
        endif
    endfunction

    // 物品沉默
    globals
        private constant key UNIT_MUTE_COUNT
    endglobals
    function UnitEnableMute takes unit whichUnit returns nothing
        local integer i
        local integer j
        local integer abilCount
        local item    whichItem
        local ability whichAbility
        local integer abilId

        set i = 0
        loop
            exitwhen i > 5

            set whichItem = UnitItemInSlot(whichUnit, i)
            if whichItem != null then
                set j = 1

                set abilCount = MHItem_GetAbilityCount(whichItem)
                loop
                    exitwhen j > abilCount
                    
                    set whichAbility = MHItem_GetAbility(whichItem, j)
                    set abilId       = GetAbilityId(whichAbility)
                    // 禁用物品主动技能
                    if not IsAbilityPassiveById(abilId) then
                        call MHAbility_Disable(whichUnit, abilId, true, false)
                    endif

                    set j = j + 1
                endloop

            endif

            set i = i + 1
        endloop

        set whichAbility = null
        set whichItem = null
    endfunction
    function UnitDisableMute takes unit whichUnit returns nothing
        local integer i
        local integer j
        local integer abilCount
        local item    whichItem
        local ability whichAbility
        local integer abilId

        set i = 0
        loop
            exitwhen i > 5

            set whichItem = UnitItemInSlot(whichUnit, i)
            if whichItem != null then
                set j = 1

                set abilCount = MHItem_GetAbilityCount(whichItem)
                loop
                    exitwhen j > abilCount
                    
                    set whichAbility = MHItem_GetAbility(whichItem, j)
                    set abilId       = GetAbilityId(whichAbility)
                    // 启用物品主动技能
                    if not IsAbilityPassiveById(abilId) then
                        call MHAbility_DisableAbility(whichAbility, false, false)
                    endif

                    set j = j + 1
                endloop

            endif

            set i = i + 1
        endloop

        set whichAbility = null
        set whichItem = null
    endfunction

    function UnitIncMuteCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_MUTE_COUNT] + 1
        set Table[h][UNIT_MUTE_COUNT] = count
        if count == 1 then
            call UnitEnableMute(whichUnit)
        endif
    endfunction
    function UnitDecMuteCount takes unit whichUnit returns nothing
        local integer h     = GetHandleId(whichUnit)
        local integer count = Table[h][UNIT_MUTE_COUNT] - 1
        set Table[h][UNIT_MUTE_COUNT] = count
        if count == 0 then
            call UnitDisableMute(whichUnit)
        endif
    endfunction
    function IsUnitMuting takes unit whichUnit returns boolean
        return Table[GetHandleId(whichUnit)][UNIT_MUTE_COUNT] > 0
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
