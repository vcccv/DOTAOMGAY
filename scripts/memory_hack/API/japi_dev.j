#pragma once
// by Asphodelus
#include "../memory_hack_constant.j"



library AMHDev
    function MHGame_GetGameDLL takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHGame_GetGameWar3 takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHTool_ReadInt takes integer addr returns integer
        JapiPlaceHolder 0
    endfunction
    function MHTool_ReadReal takes integer addr returns real
        JapiPlaceHolder 0.
    endfunction
    function MHTool_ReadBool takes integer addr returns boolean
        JapiPlaceHolder false
    endfunction
    function MHTool_ReadStr takes integer addr returns string
        JapiPlaceHolder null
    endfunction
    function MHTool_WriteInt takes integer addr, integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHTool_WriteReal takes integer addr, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHTool_WriteBool takes integer addr, boolean value returns nothing
        JapiPlaceHolder
    endfunction
    function MHTool_WriteStr takes integer addr, string value returns nothing
        JapiPlaceHolder
    endfunction
    function MHTool_VirtualProtect takes integer addr, integer size, integer flag returns integer
        JapiPlaceHolder 0
    endfunction
    function MHTool_LoadModule takes string lib_path, boolean anonymous returns boolean
        JapiPlaceHolder false
    endfunction
    function MHTool_GetNativeFunc takes string funcName returns integer
        JapiPlaceHolder 0
    endfunction
    function MHTool_GetObject takes integer hash1, integer hash2 returns integer
        JapiPlaceHolder 0
    endfunction
    function MHTool_GetAgent takes integer hash1, integer hash2 returns integer
        JapiPlaceHolder 0
    endfunction
    function MHTool_ToObject takes handle h returns integer
        JapiPlaceHolder 0
    endfunction
    function MHTool_HidToObject takes integer hid returns integer
        JapiPlaceHolder 0
    endfunction
    function MHTool_ToHandle takes integer obj returns integer
        JapiPlaceHolder 0
    endfunction
    function MHTool_IntToCode takes integer c returns code
        JapiPlaceHolder null
    endfunction
    function MHTool_CodeToInt takes code c returns integer
        JapiPlaceHolder 0
    endfunction
endlibrary