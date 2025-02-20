#pragma once
// by Asphodelus
#include "../memory_hack_constant.j"



library AMHSlk
    function MHSlk_ReadInt takes integer table, integer id, string field returns integer
        JapiPlaceHolder 0
    endfunction
    function MHSlk_ReadReal takes integer table, integer id, string field returns real
        JapiPlaceHolder 0.
    endfunction
    function MHSlk_ReadBool takes integer table, integer id, string field returns boolean
        JapiPlaceHolder false
    endfunction
    function MHSlk_ReadStr takes integer table, integer id, string field returns string
        JapiPlaceHolder null
    endfunction
endlibrary
