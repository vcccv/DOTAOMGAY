// by Asphodelus
#pragma once
#include "../memory_hack_constant.j"



library AMHMessage
    function MHMsg_GetWindowWidth takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHMsg_GetWindowHeight takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHMsg_SetWindowSize takes integer width, integer height returns boolean
        JapiPlaceHolder false
    endfunction
    function MHMsg_GetCursorX takes nothing returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMsg_GetCursorY takes nothing returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMsg_GetMouseX takes nothing returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMsg_GetMouseY takes nothing returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMsg_GetMouseZ takes nothing returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMsg_PressKey takes integer key returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsg_IsKeyDown takes integer key returns boolean
        JapiPlaceHolder false
    endfunction
    function MHMsg_WorldToScreenX takes real x, real y, real z returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMsg_WorldToScreenY takes real x, real y, real z returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMsg_WorldToScreenScale takes real x, real y, real z returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMsg_ScreenToWorldX takes real x, real y returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMsg_ScreenToWorldY takes real x, real y returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMsg_WorldToMinimapX takes real x returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMsg_WorldToMinimapY takes real y returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMsg_MinimapToWorldX takes real x returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMsg_MinimapToWorldY takes real y returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMsg_InScreen takes real x, real y returns boolean
        JapiPlaceHolder false
    endfunction
    function MHMsg_CallTargetMode takes integer aid, integer oid, integer flag returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsg_CallTargetModeEx takes integer aid, integer oid, integer flag returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsg_CallBuildMode takes integer oid, integer flag returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsg_CancelIndicator takes nothing returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsg_IsIndicatorOn takes integer indicator_type returns boolean
        JapiPlaceHolder false
    endfunction
    function MHMsg_GetCursorUnit takes nothing returns unit
        JapiPlaceHolder null
    endfunction
    function MHMsg_GetCursorItem takes nothing returns item
        JapiPlaceHolder null
    endfunction
    function MHMsg_GetCursorDest takes nothing returns destructable
        JapiPlaceHolder null
    endfunction
    function MHMsg_SendImmediateOrder takes integer oid, integer flag returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsg_SendIndicatorOrder takes widget target, real x, real y, integer oid, integer flag returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsg_SendSelectorOrder takes real x, real y, integer oid, integer flag returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsg_SendDropItemOrder takes unit target, real x, real y, item it, integer flag returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsg_SendSmartOrder takes widget target, integer oid, integer flag returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsg_SetCustomFovFix takes real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsg_EnableWideScreen takes boolean is_enable returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsg_IsWindowedLaunch takes nothing returns boolean
        JapiPlaceHolder false
    endfunction
    function MHMsg_ForceAspectRatio takes nothing returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsg_EnableBorderless takes boolean is_enable returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsg_EnableLockCursor takes boolean is_enable returns nothing
        JapiPlaceHolder
    endfunction
endlibrary



#include "event.j"
library AMHMessageEvent
    function MHMsgKeyUpEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    #define MHMsgKeyUpEvent_GetKey()                MHEvent_GetKey()
    #define MHMsgKeyUpEvent_SetKey(key)             MHEvent_SetKey(key)
    function MHMsgKeyDownEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    #define MHMsgKeyDownEvent_GetKey()              MHEvent_GetKey()
    #define MHMsgKeyDownEvent_SetKey(key)           MHEvent_SetKey(key)
    function MHMsgKeyHoldEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    #define MHMsgKeyHoldEvent_GetKey()              MHEvent_GetKey()
    #define MHMsgKeyHoldEvent_SetKey(key)           MHEvent_SetKey(key)
    function MHMsgMouseUpEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    #define MHMsgMouseUpEvent_GetKey()              MHEvent_GetKey()
    #define MHMsgMouseUpEvent_SetKey(key)           MHEvent_SetKey(key)
    function MHMsgMouseDownEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    #define MHMsgMouseDownEvent_GetKey()            MHEvent_GetKey()
    #define MHMsgMouseDownEvent_SetKey(key)         MHEvent_SetKey(key)
    function MHMsgMouseScrollEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsgMouseScrollEvent_GetValue takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHMsgMouseScrollEvent_SetValue takes integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsgMouseMoveEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsgIndicatorEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsgIndicatorEvent_GetAbility takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHMsgIndicatorEvent_GetTargetUnit takes nothing returns unit
        JapiPlaceHolder null
    endfunction
    function MHMsgIndicatorEvent_GetTargetItem takes nothing returns item
        JapiPlaceHolder null
    endfunction
    function MHMsgIndicatorEvent_GetTargetDest takes nothing returns destructable
        JapiPlaceHolder null
    endfunction
    function MHMsgIndicatorEvent_GetTargetX takes nothing returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMsgIndicatorEvent_GetTargetY takes nothing returns real
        JapiPlaceHolder 0.
    endfunction
    #define MHMsgIndicatorEvent_GetKey()            MHEvent_GetKey()
    #define MHMsgIndicatorEvent_SetKey(key)         MHEvent_SetKey(key)
    #define MHMsgIndicatorEvent_GetOrder()          MHEvent_GetOrder()
    function MHMsgSelectorEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsgSelectorEvent_GetAbility takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHMsgSelectorEvent_GetTargetX takes nothing returns real
        JapiPlaceHolder 0.
    endfunction
    function MHMsgSelectorEvent_GetTargetY takes nothing returns real
        JapiPlaceHolder 0.
    endfunction
    #define MHMsgSelectorEvent_GetKey()             MHEvent_GetKey()
    #define MHMsgSelectorEvent_SetKey(key)          MHEvent_SetKey(key)
    #define MHMsgSelectorEvent_GetOrder()           MHEvent_GetOrder()
    function MHMsgCallTargetModeEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsgCallTargetModeEvent_GetAbility takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    #define MHMsgCallTargetModeEvent_GetOrder()     MHEvent_GetOrder()
    function MHMsgCallTargetModeEvent_GetCastType takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHMsgCallTargetModeEvent_SetCastType takes integer cast_type returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsgCallBuildModeEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    #define MHMsgCallBuildModeEvent_GetOrder()     MHEvent_GetOrder()
    function MHMsgCancelIndicatorEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsgClickButtonEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    #define MHMsgClickButtonEvent_GetButton()           MHEvent_GetFrame()
    #define MHMsgClickButtonEvent_GetAbility()          MHEvent_GetAbility()
    #define MHMsgClickButtonEvent_GetKey()              MHEvent_GetKey()
    #define MHMsgClickButtonEvent_SetKey(key)           MHEvent_SetKey(key)
    function MHMsgImmediateOrderEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    #define MHMsgLocalOrderEvent_GetOrder()         MHEvent_GetOrder()
    #define MHMsgLocalOrderEvent_SetOrder(oid)      MHEvent_SetOrder(oid)
    function MHMsgLocalOrderEvent_GetFlag takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHMsgLocalOrderEvent_SetFlag takes integer flag returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsgWindowResizeEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHMsgWindowResizeEvent_GetOldWidth takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHMsgWindowResizeEvent_GetOldHeight takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
endlibrary
