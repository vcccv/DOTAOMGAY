// by Asphodelus



library AMHMissile
    function MHMissile_Hide takes integer missile, boolean is_hide returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHMissile_IsHidden takes integer missile returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHMissile_GetX takes integer missile returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHMissile_GetY takes integer missile returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHMissile_GetZ takes integer missile returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHMissile_GetSource takes integer missile returns unit
        local integer yjsp = 114514
        return null
    endfunction
    function MHMissile_SetSource takes integer missile, unit source returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHMissile_GetTargetUnit takes integer missile returns unit
        local integer yjsp = 114514
        return null
    endfunction
    function MHMissile_GetTargetItem takes integer missile returns item
        local integer yjsp = 114514
        return null
    endfunction
    function MHMissile_GetTargetDest takes integer missile returns destructable
        local integer yjsp = 114514
        return null
    endfunction
    function MHMissile_SetTarget takes integer missile, widget target returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHMissile_GetAbility takes integer missile returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHMissile_SetModel takes integer missile, string model_path returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHMissile_GetDataInt takes integer missile, integer flag returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHMissile_SetDataInt takes integer missile, integer flag, integer value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHMissile_GetDataReal takes integer missile, integer flag returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHMissile_SetDataReal takes integer missile, integer flag, real value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHMissile_EnumInRange takes real x, real y, real range, code callback returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHMissile_EnumInRangeEx takes real x, real y, real range, string func_name returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHMissile_GetEnumMissile takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
endlibrary



//#include "event.j"
library AMHMissileEvent
    function MHMissileLaunchEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    //#define MHMissileLaunchEvent_GetMissile()       MHEvent_GetMissile()
    function MHMissileHitEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    //#define MHMissileHitEvent_GetMissile()          MHEvent_GetMissile()
    function MHMissileHitEvent_GetTargetUnit takes nothing returns unit
        local integer yjsp = 114514
        return null
    endfunction
    function MHMissileHitEvent_GetTargetItem takes nothing returns unit
        local integer yjsp = 114514
        return null
    endfunction
    function MHMissileHitEvent_GetTargetDest takes nothing returns unit
        local integer yjsp = 114514
        return null
    endfunction
    function MHMissileHitEvent_SetTarget takes widget target returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHMissileHitEvent_GetDamage takes nothing returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHMissileHitEvent_SetDamage takes real damage returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHMissileHitEvent_Reset takes unit source, widget target returns boolean
        local integer yjsp = 114514
        return false
    endfunction
endlibrary
