#pragma once
// by Asphodelus
#include "../memory_hack_constant.j"



library AMHItem
    function MHItem_GetOwner takes item it returns unit
        JapiPlaceHolder null
    endfunction
    function MHItem_GetAbilityCount takes item it returns integer
        JapiPlaceHolder 0
    endfunction
    function MHItem_GetAbility takes item it, integer index returns ability
        JapiPlaceHolder null
    endfunction
    function MHItem_GetAbilityId takes item it, integer index returns integer
        JapiPlaceHolder 0
    endfunction
    function MHItem_SetCollisionType takes item it, integer to_other, integer from_other returns nothing
        JapiPlaceHolder
    endfunction
    function MHItem_GetDefDataInt takes integer item_id, integer flag returns integer
        JapiPlaceHolder 0
    endfunction
    function MHItem_GetDefDataBool takes integer item_id, integer flag returns boolean
        JapiPlaceHolder false
    endfunction
    function MHItem_GetDefDataStr takes integer item_id, integer flag returns string
        JapiPlaceHolder null
    endfunction
    function MHItem_SetDefDataInt takes integer item_id, integer flag, integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHItem_SetDefDataBool takes integer item_id, integer flag, boolean value returns nothing
        JapiPlaceHolder
    endfunction
    function MHItem_SetDefDataStr takes integer item_id, integer flag, string value returns nothing
        JapiPlaceHolder
    endfunction
endlibrary



library AMHItemHook
    function MHItem_SetHookIcon takes item it, string path returns nothing
        JapiPlaceHolder
    endfunction
    function MHItem_GetHookIcon takes item it returns string
        JapiPlaceHolder null
    endfunction
    function MHItem_ResetHookIcon takes item it returns nothing
        JapiPlaceHolder
    endfunction
    function MHItem_SetHookName takes item it, string path returns nothing
        JapiPlaceHolder
    endfunction
    function MHItem_GetHookName takes item it returns string
        JapiPlaceHolder null
    endfunction
    function MHItem_ResetHookName takes item it returns nothing
        JapiPlaceHolder
    endfunction
    function MHItem_SetHookTip takes item it, string path returns nothing
        JapiPlaceHolder
    endfunction
    function MHItem_GetHookTip takes item it returns string
        JapiPlaceHolder null
    endfunction
    function MHItem_ResetHookTip takes item it returns nothing
        JapiPlaceHolder
    endfunction
    function MHItem_SetHookUbertip takes item it, string path returns nothing
        JapiPlaceHolder
    endfunction
    function MHItem_GetHookUbertip takes item it returns string
        JapiPlaceHolder null
    endfunction
    function MHItem_ResetHookUbertip takes item it returns nothing
        JapiPlaceHolder
    endfunction
    function MHItem_DisablePreSelectUI takes item it, boolean is_disable returns nothing
        JapiPlaceHolder
    endfunction
endlibrary



library AMHItemEvent
    function MHItemCreateEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHItemRemoveEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
endlibrary
