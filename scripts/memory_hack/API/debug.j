#pragma once
// by Asphodelus
#include "../memory_hack_constant.j"



library AMHDebug
    function MHDebug_EnableConsole takes boolean is_enable returns nothing
        JapiPlaceHolder
    endfunction
    function MHDebug_GetHandleCount takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHDebug_GetHandleMaxCount takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHDebug_EnableCrashTracer takes boolean is_enable returns nothing
        JapiPlaceHolder
    endfunction
    function MHDebug_EnableCrashTracerDump takes boolean is_enable returns nothing
        JapiPlaceHolder
    endfunction
    function MHDebug_EnableDesyncCheck takes nothing returns nothing
        JapiPlaceHolder
    endfunction
    function MHDebug_SetDesyncCheckFileCount takes integer count returns nothing
        JapiPlaceHolder
    endfunction
    function MHDebug_EnableLeakMonitor takes nothing returns nothing
        JapiPlaceHolder
    endfunction
    function MHDebug_ShowLeakMessage takes nothing returns nothing
        JapiPlaceHolder
    endfunction
endlibrary
