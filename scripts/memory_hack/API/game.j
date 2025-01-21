#pragma once
// by Asphodelus
#include "../memory_hack_constant.j"



library AMHGame
    function MHGame_GetMemoryUsage takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHGame_GetMemoryMaxUsage takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHGame_GetGameVersion takes nothing returns string
        JapiPlaceHolder null
    endfunction
    function MHGame_GetPluginVersion takes nothing returns string
        JapiPlaceHolder null
    endfunction
    function MHGame_GetMapName takes nothing returns string
        JapiPlaceHolder null
    endfunction
    function MHGame_GetMapDescription takes nothing returns string
        JapiPlaceHolder null
    endfunction
    function MHGame_GetMapPath takes nothing returns string
        JapiPlaceHolder null
    endfunction
    function MHGame_GetCheatFlag takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHGame_SetCheatFlag takes integer flag returns nothing
        JapiPlaceHolder
    endfunction
    function MHGame_IsCheatFlag takes integer flag returns boolean
        JapiPlaceHolder false
    endfunction
    function MHGame_CheckInherit takes integer child_id, integer parent_id returns boolean
        JapiPlaceHolder false
    endfunction
    function MHGame_GetCode takes string func_name returns code
        JapiPlaceHolder null
    endfunction
    function MHGame_ExecuteCode takes code c returns integer
        JapiPlaceHolder 0
    endfunction
    function MHGame_ExecuteCodeEx takes integer c returns integer
        JapiPlaceHolder 0
    endfunction
    function MHGame_ExecuteFunc takes string func_name returns integer
        JapiPlaceHolder 0
    endfunction
    function MHGame_RemoveModelCache takes string model_path returns nothing
        JapiPlaceHolder
    endfunction
    function MHGame_GetAxisZ takes real x, real y returns real
        JapiPlaceHolder 0.
    endfunction
    function MHGame_IsLan takes nothing returns boolean
        JapiPlaceHolder false
    endfunction
    function MHGame_IsReplay takes nothing returns boolean
        JapiPlaceHolder false
    endfunction
    function MHGame_GetGameStamp takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHGame_GetLocalStamp takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
endlibrary



library AMHGameHook
    function MHGame_DisablePause takes boolean is_disable returns nothing
        JapiPlaceHolder
    endfunction
endlibrary



#include "event.j"
library AMHGameEvent
    function MHGameStartEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHGameTickEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHGameTickEvent_GetStamp takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHGameStopEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHGameExitEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
endlibrary
