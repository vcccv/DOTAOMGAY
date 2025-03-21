#pragma once
// by Asphodelus
#include "../memory_hack_constant.j"



library AMHTextTag
    function MHTextTag_SetFont takes string path, integer style returns boolean
        JapiPlaceHolder false
    endfunction
    function MHTextTag_SetLimit takes integer limit returns boolean
        JapiPlaceHolder false
    endfunction
    function MHTextTag_GetText takes texttag tag returns string
        JapiPlaceHolder null
    endfunction
    function MHTextTag_SetAlpha takes texttag tag, integer alpha returns boolean
        JapiPlaceHolder false
    endfunction
    function MHTextTag_SetShadowColor takes texttag tag, integer color returns boolean
        JapiPlaceHolder false
    endfunction
endlibrary
