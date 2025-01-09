
#include "UnitWeapon.j"
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
