// by Asphodelus
#pragma once
#include "../memory_hack_constant.j"



library AMHGroup
    function MHGroup_GetSize takes group g returns integer
        JapiPlaceHolder 0
    endfunction
    function MHGroup_GetSizeEx takes group g returns integer
        JapiPlaceHolder 0
    endfunction
    function MHGroup_ContainsUnit takes group g, unit u returns boolean
        JapiPlaceHolder false
    endfunction
    function MHGroup_GetUnit takes group g, integer index returns unit
        JapiPlaceHolder null
    endfunction
    function MHGroup_GetRandomUnit takes group g returns unit
        JapiPlaceHolder null
    endfunction
    function MHGroup_AddGroup takes group this_group, group that_group returns boolean
        JapiPlaceHolder false
    endfunction
    function MHGroup_RemoveGroup takes group this_group, group that_group returns boolean
        JapiPlaceHolder false
    endfunction
endlibrary
