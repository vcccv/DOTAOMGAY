#pragma once
// by Asphodelus
#include "../memory_hack_constant.j"



library AMHEvent
    function MHEvent_GetId takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHEvent_GetUnit takes nothing returns unit
        JapiPlaceHolder null
    endfunction
    function MHEvent_SetUnit takes unit u returns nothing
        JapiPlaceHolder
    endfunction
    function MHEvent_GetAbility takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHEvent_SetAbility takes integer aid returns nothing
        JapiPlaceHolder
    endfunction
    function MHEvent_GetItem takes nothing returns item
        JapiPlaceHolder null
    endfunction
    function MHEvent_SetItem takes item it returns nothing
        JapiPlaceHolder
    endfunction
    function MHEvent_GetPlayer takes nothing returns player
        JapiPlaceHolder null
    endfunction
    function MHEvent_SetPlayer takes player p returns nothing
        JapiPlaceHolder
    endfunction
    function MHEvent_GetMissile takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHEvent_SetMissile takes integer order returns nothing
        JapiPlaceHolder
    endfunction
    function MHEvent_GetOrder takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHEvent_SetOrder takes integer order returns nothing
        JapiPlaceHolder
    endfunction
    function MHEvent_GetKey takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHEvent_SetKey takes integer key returns nothing
        JapiPlaceHolder
    endfunction
    function MHEvent_GetFrame takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHEvent_SetFrame takes integer frame returns nothing
        JapiPlaceHolder
    endfunction
    function MHEvent_GetAudio takes nothing returns integer
        JapiPlaceHolder -1
    endfunction
    function MHEvent_SetAudio takes integer audio returns boolean
        JapiPlaceHolder false
    endfunction
endlibrary
