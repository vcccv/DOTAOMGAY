#pragma once
// by Asphodelus
#include "../memory_hack_constant.j"



library AMHHero
    function MHHero_GetMaxExp takes unit u, integer level returns integer
        JapiPlaceHolder 0
    endfunction
    function MHHero_GetNeededExp takes unit u, integer level returns integer
        JapiPlaceHolder 0
    endfunction
    function MHHero_GetPrimaryAttr takes unit u returns integer
        JapiPlaceHolder 0
    endfunction
    function MHHero_SetPrimaryAttr takes unit u, integer attr returns nothing
        JapiPlaceHolder
    endfunction
    function MHHero_GetPrimaryAttrValue takes unit u, boolean include_bonus returns integer
        JapiPlaceHolder 0
    endfunction
    function MHHero_SetPrimaryAttrValue takes unit u, integer value, boolean allow_bonus returns nothing
        JapiPlaceHolder
    endfunction
    function MHHero_GetAttrPlus takes unit u, integer attr returns real
        JapiPlaceHolder 0.
    endfunction
    function MHHero_SetAttrPlus takes unit u, integer attr, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHHero_ModifyAbility takes unit u, integer old_id, integer new_id returns boolean
        JapiPlaceHolder false
    endfunction
    function MHHero_ModifyAbilityEx takes unit u, integer index, integer new_id returns boolean
        JapiPlaceHolder false
    endfunction
    function MHHero_ChangeAbility takes unit u, integer old_id, integer new_id returns boolean
        JapiPlaceHolder false
    endfunction
    function MHHero_ChangeAbilityEx takes unit u, integer old_id, integer new_id returns boolean
        JapiPlaceHolder false
    endfunction
endlibrary



#include "event.j"
library AMHHeroEvent
    function MHHeroGetExpEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHHeroGetExpEvent_GetValue takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHHeroGetExpEvent_SetValue takes integer value returns nothing
        JapiPlaceHolder
    endfunction
endlibrary
