
#include "UnitWeapon.j"

library UnitData requires UnitUtils
   
    globals
        hashtable UnitDataHashTable = InitHashtable()
        key UNIT_PATHING
    endglobals
    
    function SetUnitPathingEx takes unit u, boolean flag returns nothing
        local integer h = GetHandleId(u)
        if flag and LoadBoolean(UnitDataHashTable, h, UNIT_PATHING) then
            if IsUnitType(u, UNIT_TYPE_FLYING) then
                call MHUnit_SetPathType(u, UNIT_PATH_TYPE_FLY)
                call MHUnit_SetCollisionType(u, UNIT_COLLISION_TYPE_AIR, UNIT_COLLISION_TYPE_NONE)
            elseif IsUnitType(u, UNIT_TYPE_GROUND) then
                call MHUnit_SetPathType(u, UNIT_PATH_TYPE_FOOT)
                call MHUnit_SetCollisionType(u, UNIT_COLLISION_TYPE_FOOT, UNIT_COLLISION_TYPE_GROUND)
            endif
            call RemoveSavedBoolean(UnitDataHashTable, h, UNIT_PATHING)
            call SetUnitPathing(u, true)
        elseif not flag and not LoadBoolean(UnitDataHashTable, h, UNIT_PATHING) then
            call MHUnit_SetPathType(u, UNIT_PATH_TYPE_FLY)
            call MHUnit_SetCollisionType(u, UNIT_COLLISION_TYPE_AIR, UNIT_COLLISION_TYPE_NONE)
            call SaveBoolean(UnitDataHashTable, h, UNIT_PATHING, true)
            call SetUnitPathing(u, false)
        endif
    endfunction
    
    function FlushUnitData takes unit whichUnit returns nothing
        if whichUnit == null then
            return
        endif
        call FlushChildHashtable(UnitDataHashTable, GetHandleId(whichUnit))
    endfunction
    
    globals
        constant integer UNIT_BONUS_DAMAGE     = 'AUdb'
        constant integer UNIT_BONUS_ATTACK     = 'AUab'
        constant integer UNIT_BONUS_ARMOR      = 'AUeb'
        constant integer UNIT_BONUS_LIFE_REGEM = 'AUlb'
    endglobals

    function UnitGetStateBonus takes unit whichUnit, integer abilId returns real
        return Table[GetHandleId(whichUnit)].real[abilId]
    endfunction

    function UnitAddStateBonus takes unit whichUnit, real addValue, integer abilId returns real
        local real    value
        local integer h
        call UnitAddPermanentAbility(whichUnit, abilId)
        if abilId == UNIT_BONUS_ATTACK then
            set addValue = (addValue * 1.) * 0.01
        endif
        set h     = GetHandleId(whichUnit)
        set value = Table[h].real[abilId] + addValue
        set Table[h].real[abilId] = value
        call MHAbility_SetLevelDefDataReal(abilId, 1, ABILITY_LEVEL_DEF_DATA_DATA_A, value)
        call IncUnitAbilityLevel(whichUnit, abilId)
        call DecUnitAbilityLevel(whichUnit, abilId)
        if abilId == UNIT_BONUS_LIFE_REGEM then
            call UnitAddAbility(whichUnit, 'AIml')
            call UnitRemoveAbility(whichUnit, 'AIml')
        endif
        return value
    endfunction
    function UnitSetStateBonus takes unit whichUnit, real newValue, integer abilId returns real
        local real    value
        local integer h
        call UnitAddPermanentAbility(whichUnit, abilId)
        if abilId == UNIT_BONUS_ATTACK then
            set newValue = (newValue * 1.) * 0.01
        endif
        set h     = GetHandleId(whichUnit)
        set Table[h].real[abilId] = newValue
        call MHAbility_SetLevelDefDataReal(abilId, 1, ABILITY_LEVEL_DEF_DATA_DATA_A, newValue)
        call IncUnitAbilityLevel(whichUnit, abilId)
        call DecUnitAbilityLevel(whichUnit, abilId)
        if abilId == UNIT_BONUS_LIFE_REGEM then
            call UnitAddAbility(whichUnit, 'AIml')
            call UnitRemoveAbility(whichUnit, 'AIml')
        endif
        return newValue
    endfunction
    function UnitReduceStateBonus takes unit whichUnit, real reduceValue, integer abilId returns real
        local real    value
        local integer h
        call UnitAddPermanentAbility(whichUnit, abilId)
        if abilId == UNIT_BONUS_ATTACK then
            set reduceValue = (reduceValue * 1.) * 0.01
        endif
        set h     = GetHandleId(whichUnit)
        set value = Table[h].real[abilId] - reduceValue
        set Table[h].real[abilId] = value
        call MHAbility_SetLevelDefDataReal(abilId, 1, ABILITY_LEVEL_DEF_DATA_DATA_A, value)
        call IncUnitAbilityLevel(whichUnit, abilId)
        call DecUnitAbilityLevel(whichUnit, abilId)
        if abilId == UNIT_BONUS_LIFE_REGEM then
            call UnitAddAbility(whichUnit, 'AIml')
            call UnitRemoveAbility(whichUnit, 'AIml')
        endif
        return value
    endfunction

    function UnitAddMoveSpeedBonusPercent takes unit whichUnit, real percent returns nothing
        set percent = percent * 0.01
        call MHUnit_SetData(whichUnit, UNIT_DATA_BONUS_MOVESPEED, MHUnit_GetData(whichUnit, UNIT_DATA_BONUS_MOVESPEED) + percent)
    endfunction
    function UnitReduceMoveSpeedBonusPercent takes unit whichUnit, real percent returns nothing
        set percent = percent * 0.01
        call MHUnit_SetData(whichUnit, UNIT_DATA_BONUS_MOVESPEED, MHUnit_GetData(whichUnit, UNIT_DATA_BONUS_MOVESPEED) - percent)
    endfunction

    function UnitRegenLife takes unit source, unit target, real value returns nothing
        call MHUnit_RestoreLife(target, value)
    endfunction
    function UnitRegenMana takes unit source, unit target, real value returns nothing
        call MHUnit_RestoreMana(target, value)
    endfunction

endlibrary
