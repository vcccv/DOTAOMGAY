#pragma once
// by Asphodelus
#include "../memory_hack_constant.j"



library AMHJson
    function MHJson_Create takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHJson_Clear takes integer id returns nothing
        JapiPlaceHolder
    endfunction
    function MHJson_Destroy takes integer id returns nothing
        JapiPlaceHolder
    endfunction
    function MHJson_Parse takes integer id, string ctx returns boolean
        JapiPlaceHolder false
    endfunction
    function MHJson_Dump takes integer id returns string
        JapiPlaceHolder null
    endfunction
    function MHJson_WriteInt takes integer id, string field, integer value returns boolean
        JapiPlaceHolder false
    endfunction
    function MHJson_WriteReal takes integer id, string field, real value returns  boolean
        JapiPlaceHolder false
    endfunction
    function MHJson_WriteBool takes integer id, string field, boolean value returns  boolean
        JapiPlaceHolder false
    endfunction
    function MHJson_WriteStr takes integer id, string field, string value returns  boolean
        JapiPlaceHolder false
    endfunction
    function MHJson_WriteArrayInt takes integer id, string field, integer index, integer value returns boolean
        JapiPlaceHolder false
    endfunction
    function MHJson_WriteArrayReal takes integer id, string field, integer index, real value returns  boolean
        JapiPlaceHolder false
    endfunction
    function MHJson_WriteArrayBool takes integer id, string field, integer index, boolean value returns  boolean
        JapiPlaceHolder false
    endfunction
    function MHJson_WriteArrayStr takes integer id, string field, integer index, string value returns  boolean
        JapiPlaceHolder false
    endfunction
    function MHJson_ReadInt takes integer id, string field returns integer
        JapiPlaceHolder 0
    endfunction
    function MHJson_ReadReal takes integer id, string field returns real
        JapiPlaceHolder 0.
    endfunction
    function MHJson_ReadBool takes integer id, string field returns boolean
        JapiPlaceHolder false
    endfunction
    function MHJson_ReadStr takes integer id, string field returns string
        JapiPlaceHolder null
    endfunction
    function MHJson_ReadArrayInt takes integer id, string field, integer index returns integer
        JapiPlaceHolder 0
    endfunction
    function MHJson_ReadArrayReal takes integer id, string field, integer index returns real
        JapiPlaceHolder 0.
    endfunction
    function MHJson_ReadArrayBool takes integer id, string field, integer index returns boolean
        JapiPlaceHolder false
    endfunction
    function MHJson_ReadArrayStr takes integer id, string field, integer index returns string
        JapiPlaceHolder null
    endfunction
endlibrary
