// by Asphodelus
#pragma once
#include "../memory_hack_constant.j"



library AMHMissile
    function MHMissile_Hide takes integer missile, boolean is_hide returns nothing
        JapiPlaceHolder
    endfunction
    function MHMissile_IsHidden takes integer missile returns boolean
        JapiPlaceHolder false
    endfunction
    function MHMissile_GetX takes integer missile returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMissile_GetY takes integer missile returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMissile_GetZ takes integer missile returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMissile_GetSource takes integer missile returns unit
        JapiPlaceHolder null
    endfunction
    function MHMissile_SetSource takes integer missile, unit source returns nothing
        JapiPlaceHolder
    endfunction
    function MHMissile_GetTargetUnit takes integer missile returns unit
        JapiPlaceHolder null
    endfunction
    function MHMissile_GetTargetItem takes integer missile returns item
        JapiPlaceHolder null
    endfunction
    function MHMissile_GetTargetDest takes integer missile returns destructable
        JapiPlaceHolder null
    endfunction
    function MHMissile_SetTarget takes integer missile, widget target returns nothing
        JapiPlaceHolder
    endfunction
    function MHMissile_GetAbility takes integer missile returns integer
        JapiPlaceHolder 0
    endfunction
    function MHMissile_SetModel takes integer missile, string model_path returns nothing
        JapiPlaceHolder
    endfunction
    function MHMissile_GetDataInt takes integer missile, integer flag returns integer
        JapiPlaceHolder 0
    endfunction
    function MHMissile_SetDataInt takes integer missile, integer flag, integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHMissile_GetDataReal takes integer missile, integer flag returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMissile_SetDataReal takes integer missile, integer flag, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHMissile_EnumInRange takes real x, real y, real range, code callback returns nothing
        JapiPlaceHolder
    endfunction
    function MHMissile_EnumInRangeEx takes real x, real y, real range, string func_name returns nothing
        JapiPlaceHolder
    endfunction
    function MHMissile_GetEnumMissile takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
endlibrary



#include "event.j"
library AMHMissileEvent
    function MHMissileLaunchEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    #define MHMissileLaunchEvent_GetMissile()       MHEvent_GetMissile()
    function MHMissileHitEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    #define MHMissileHitEvent_GetMissile()          MHEvent_GetMissile()
    function MHMissileHitEvent_GetTargetUnit takes nothing returns unit
        JapiPlaceHolder null
    endfunction
    function MHMissileHitEvent_GetTargetItem takes nothing returns unit
        JapiPlaceHolder null
    endfunction
    function MHMissileHitEvent_GetTargetDest takes nothing returns unit
        JapiPlaceHolder null
    endfunction
    function MHMissileHitEvent_SetTarget takes widget target returns nothing
        JapiPlaceHolder
    endfunction
    function MHMissileHitEvent_GetDamage takes nothing returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMissileHitEvent_SetDamage takes real damage returns nothing
        JapiPlaceHolder
    endfunction
    function MHMissileHitEvent_Reset takes unit source, widget target returns boolean
        JapiPlaceHolder false
    endfunction
endlibrary
