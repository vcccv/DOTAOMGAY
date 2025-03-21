#pragma once
// by Asphodelus
#include "../memory_hack_constant.j"



library AMHString
    function MHString_FromId takes integer id returns string
        JapiPlaceHolder null
    endfunction
    function MHString_ToId takes string id returns integer
        JapiPlaceHolder 0
    endfunction
    function MHString_Find takes string str, string target, integer start returns integer
        JapiPlaceHolder 0
    endfunction
    function MHString_Reverse takes string str returns string
        JapiPlaceHolder null
    endfunction
    function MHString_Trim takes string str returns string
        JapiPlaceHolder null
    endfunction
    function MHString_LTrim takes string str returns string
        JapiPlaceHolder null
    endfunction
    function MHString_RTrim takes string str returns string
        JapiPlaceHolder null
    endfunction
    function MHString_Contain takes string str, string target returns boolean
        JapiPlaceHolder false
    endfunction
    function MHString_GetCount takes string str, string target returns integer
        JapiPlaceHolder 0
    endfunction
    function MHString_Sub takes string str, integer start, integer length returns string
        JapiPlaceHolder null
    endfunction
    function MHString_Replace takes string str, string old_str, string new_str returns string
        JapiPlaceHolder null
    endfunction
    function MHString_Split takes string str, string delimiter, integer index returns string
        JapiPlaceHolder null
    endfunction
    function MHString_RegexMatch takes string str, string regex returns boolean
        JapiPlaceHolder false
    endfunction
    function MHString_RegexSearch takes string str, string regex, integer index, integer capture returns string
        JapiPlaceHolder null
    endfunction
    function MHString_RegexReplace takes string str, string regex, string new_val returns string
        JapiPlaceHolder null
    endfunction
    function MHString_Concat3 takes string str0, string str1, string str2 returns string
        JapiPlaceHolder null
    endfunction
    function MHString_Concat4 takes string str0, string str1, string str2, string str3 returns string
        JapiPlaceHolder null
    endfunction
    function MHString_Concat5 takes string str0, string str1, string str2, string str3, string str4 returns string
        JapiPlaceHolder null
    endfunction
    function MHString_Concat6 takes string str0, string str1, string str2, string str3, string str4, string str5 returns string
        JapiPlaceHolder null
    endfunction
    function MHString_Concat7 takes string str0, string str1, string str2, string str3, string str4, string str5, string str6 returns string
        JapiPlaceHolder null
    endfunction
    function MHString_Concat8 takes string str0, string str1, string str2, string str3, string str4, string str5, string str6, string str7 returns string
        JapiPlaceHolder null
    endfunction
    function MHString_Concat9 takes string str0, string str1, string str2, string str3, string str4, string str5, string str6, string str7, string str8 returns string
        JapiPlaceHolder null
    endfunction
    function MHString_Concat10 takes string str0, string str1, string str2, string str3, string str4, string str5, string str6, string str7, string str8, string str9 returns string
        JapiPlaceHolder null
    endfunction
    function MHString_Concat11 takes string str0, string str1, string str2, string str3, string str4, string str5, string str6, string str7, string str8, string str9, string strA returns string
        JapiPlaceHolder null
    endfunction
    function MHString_Concat12 takes string str0, string str1, string str2, string str3, string str4, string str5, string str6, string str7, string str8, string str9, string strA, string strB returns string
        JapiPlaceHolder null
    endfunction
    function MHString_Concat13 takes string str0, string str1, string str2, string str3, string str4, string str5, string str6, string str7, string str8, string str9, string strA, string strB, string strC returns string
        JapiPlaceHolder null
    endfunction
    function MHString_Concat14 takes string str0, string str1, string str2, string str3, string str4, string str5, string str6, string str7, string str8, string str9, string strA, string strB, string strC, string strD returns string
        JapiPlaceHolder null
    endfunction
    function MHString_Concat15 takes string str0, string str1, string str2, string str3, string str4, string str5, string str6, string str7, string str8, string str9, string strA, string strB, string strC, string strD, string strE returns string
        JapiPlaceHolder null
    endfunction
    function MHString_Concat16 takes string str0, string str1, string str2, string str3, string str4, string str5, string str6, string str7, string str8, string str9, string strA, string strB, string strC, string strD, string strE, string strF returns string
        JapiPlaceHolder null
    endfunction
    #define MHString_Concat1(a1)    (a1)
    #define MHString_Concat2(a1,a2) ((a1) + (a2))
    #define MHString_Concat(...)    BOOST_PP_CAT(MHString_Concat, __MEMHACK_COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
    function MHString_ConcatFromVar takes string v_name, integer begin, integer end returns string
        JapiPlaceHolder null
    endfunction
endlibrary
