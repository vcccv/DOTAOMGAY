#pragma once
// by Asphodelus
#include "../memory_hack_constant.j"



library AMHMath
    function MHMath_GetLocalRandomInt takes integer lower_bound, integer upper_bound returns integer
        JapiPlaceHolder 0
    endfunction
    function MHMath_GetLocalRandomReal takes real lower_bound, real upper_bound returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMath_IsBitSet takes integer flag, integer bit returns boolean
        JapiPlaceHolder false
    endfunction
    function MHMath_AddBit takes integer flag, integer bit returns integer
        JapiPlaceHolder 0
    endfunction
    function MHMath_RemoveBit takes integer flag, integer bit returns integer
        JapiPlaceHolder 0
    endfunction
        function MHMath_Xor takes boolean op1, boolean op2 returns boolean
        JapiPlaceHolder false
    endfunction
    function MHMath_BitwiseNot takes integer op1 returns integer
        JapiPlaceHolder 0
    endfunction
    function MHMath_BitwiseAnd takes integer op1, integer op2 returns integer
        JapiPlaceHolder 0
    endfunction
    function MHMath_BitwiseOr takes integer op1, integer op2 returns integer
        JapiPlaceHolder 0
    endfunction
    function MHMath_BitwiseXor takes integer op1, integer op2 returns integer
        JapiPlaceHolder 0
    endfunction
    function MHMath_LShift takes integer op1, integer op2 returns integer
        JapiPlaceHolder 0
    endfunction
    function MHMath_RShift takes integer op1, integer op2 returns integer
        JapiPlaceHolder 0
    endfunction
    function MHMath_Log2 takes integer op1 returns integer
        JapiPlaceHolder 0
    endfunction
    function MHMath_ModI takes integer dividend, integer modulus returns integer
        JapiPlaceHolder 0
    endfunction
    function MHMath_ModF takes real dividend, real modulus returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMath_Get4Bytes takes integer byte_1, integer byte_2, integer byte_3, integer byte_4 returns integer
        JapiPlaceHolder 0
    endfunction
    function MHMath_ToHex takes integer dec returns string
        JapiPlaceHolder null
    endfunction
    function MHMath_ToDec takes string hex returns integer
        JapiPlaceHolder 0
    endfunction
    function MHMath_Bezier2 takes real start, real control, real end, real progress returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMath_Bezier3 takes real start, real control1, real control2, real end, real progress returns real
        JapiPlaceHolder 0.
    endfunction
endlibrary
