#pragma once
// by Asphodelus
#include "../memory_hack_constant.j"



library AMHSlk
    function MHSlk_GetInt takes string table, integer id, string field returns integer
        JapiPlaceHolder 0
    endfunction
    function MHSlk_GetReal takes string table, integer id, string field returns real
        JapiPlaceHolder 0.
    endfunction
    function MHSlk_GetBool takes string table, integer id, string field returns boolean
        JapiPlaceHolder false
    endfunction
    function MHSlk_GetStr takes string table, integer id, string field returns string
        JapiPlaceHolder null
    endfunction
endlibrary
