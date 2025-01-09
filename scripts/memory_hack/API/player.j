// by Aphodelus
#pragma once
#include "../memory_hack_constant.j"



library AMHPlayer
    function MHPlayer_GetSelectUnit takes nothing returns unit
        JapiPlaceHolder null
    endfunction
    function MHPlayer_GetSelectItem takes nothing returns item
        JapiPlaceHolder null
    endfunction
    function MHPlayer_CheckAvailable takes player p, integer id returns boolean
        JapiPlaceHolder false
    endfunction
    #define MHPlayer_CheckUnitAvailable(p, id)      MHPlayer_CheckAvailable(p, id)
    #define MHPlayer_CheckAbilAvailable(p, id)      MHPlayer_CheckAvailable(p, id)
    #define MHPlayer_CheckItemAvailable(p, id)      MHPlayer_CheckAvailable(p, id)
    #define MHPlayer_CheckTechAvailable(p, id)      MHPlayer_CheckAvailable(p, id)
endlibrary



#include "event.j"
library AMHPlayerEvent
    function MHPlayerGoldChangeEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    #define MHPlayerGoldChangeEvent_GetPlayer()         MHEvent_GetPlayer()
    #define MHPlayerGoldChangeEvent_SetPlayer(p)        MHEvent_SetPlayer(p)
    function MHPlayerGoldChangeEvent_GetValue takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHPlayerGoldChangeEvent_SetValue takes integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHPlayerGoldChangeEvent_IsTax takes nothing returns boolean
        JapiPlaceHolder false
    endfunction
    function MHPlayerGoldChangeEvent_SetTax takes boolean is_tax returns nothing
        JapiPlaceHolder
    endfunction
    function MHPlayerLumberChangeEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    #define MHPlayerLumberChangeEvent_GetPlayer()       MHEvent_GetPlayer()
    #define MHPlayerLumberChangeEvent_SetPlayer(p)      MHEvent_SetPlayer(p)
    function MHPlayerLumberChangeEvent_GetValue takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHPlayerLumberChangeEvent_SetValue takes integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHPlayerLumberChangeEvent_IsTax takes nothing returns boolean
        JapiPlaceHolder false
    endfunction
    function MHPlayerLumberChangeEvent_SetTax takes boolean is_tax returns nothing
        JapiPlaceHolder
    endfunction
endlibrary
