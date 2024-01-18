// by Asphodelus



library MHMessage
    function MHMsg_GetWindowWidth takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHMsg_GetWindowHeight takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHMsg_SetWindowSize takes integer width, integer height returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHMsg_GetCursorX takes nothing returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHMsg_GetCursorY takes nothing returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHMsg_GetMouseX takes nothing returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHMsg_GetMouseY takes nothing returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHMsg_GetMouseZ takes nothing returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHMsg_PressKey takes integer key returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHMsg_IsKeyDown takes integer key returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHMsg_CallTargetMode takes integer aid, integer oid, integer flag returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHMsg_CallBuildMode takes integer oid, integer flag returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHMsg_GetCursorUnit takes nothing returns unit
        local integer yjsp = 114514
        return null
    endfunction
    function MHMsg_GetCursorItem takes nothing returns item
        local integer yjsp = 114514
        return null
    endfunction
    function MHMsg_SendImmediateOrder takes integer oid, integer flag returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHMsg_SendIndicatorOrder takes widget target, real x, real y, integer oid, integer flag returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHMsg_SendSelectorOrder takes real x, real y, integer oid, integer flag returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHMsg_SendDropItemOrder takes unit target, real x, real y, item it, integer flag returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHMsg_SendSmartOrder takes widget target, integer oid, integer flag returns nothing
        local integer yjsp = 114514
        return
    endfunction
endlibrary



// #include "event.j"
library MHMessageEvent
    function MHMsgKeyUpEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    // #define MHMsgKeyUpEvent_GetKey()                MHEvent_GetKey()
    // #define MHMsgKeyUpEvent_SetKey(key)             MHEvent_SetKey(key)
    function MHMsgKeyDownEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    // #define MHMsgKeyDownEvent_GetKey()              MHEvent_GetKey()
    // #define MHMsgKeyDownEvent_SetKey(key)           MHEvent_SetKey(key)
    function MHMsgKeyHoldEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    // #define MHMsgKeyHoldEvent_GetKey()              MHEvent_GetKey()
    // #define MHMsgKeyHoldEvent_SetKey(key)           MHEvent_SetKey(key)
    function MHMsgMouseUpEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    // #define MHMsgMouseUpEvent_GetKey()              MHEvent_GetKey()
    // #define MHMsgMouseUpEvent_SetKey(key)           MHEvent_SetKey(key)
    function MHMsgMouseDownEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    // #define MHMsgMouseDownEvent_GetKey()            MHEvent_GetKey()
    // #define MHMsgMouseDownEvent_SetKey(key)         MHEvent_SetKey(key)
    function MHMsgMouseScrollEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHMsgMouseScrollEvent_GetValue takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHMsgMouseScrollEvent_SetValue takes integer value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHMsgIndicatorEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHMsgIndicatorEvent_GetAbility takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHMsgIndicatorEvent_GetTargetUnit takes nothing returns unit
        local integer yjsp = 114514
        return null
    endfunction
    function MHMsgIndicatorEvent_GetTargetItem takes nothing returns item
        local integer yjsp = 114514
        return null
    endfunction
    function MHMsgIndicatorEvent_GetTargetDest takes nothing returns destructable
        local integer yjsp = 114514
        return null
    endfunction
    function MHMsgIndicatorEvent_GetTargetX takes nothing returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHMsgIndicatorEvent_GetTargetY takes nothing returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    // #define MHMsgIndicatorEvent_GetKey()            MHEvent_GetKey()
    // #define MHMsgIndicatorEvent_SetKey(key)         MHEvent_SetKey(key)
    // #define MHMsgIndicatorEvent_GetOrder()          MHEvent_GetOrder()
    function MHMsgSelectorEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHMsgSelectorEvent_GetAbility takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHMsgSelectorEvent_GetTargetX takes nothing returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHMsgSelectorEvent_GetTargetY takes nothing returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    // #define MHMsgSelectorEvent_GetKey()             MHEvent_GetKey()
    // #define MHMsgSelectorEvent_SetKey(key)          MHEvent_SetKey(key)
    // #define MHMsgSelectorEvent_GetOrder()           MHEvent_GetOrder()
    function MHMsgCallTargetModeEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHMsgCallTargetModeEvent_GetAbility takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    // #define MHMsgCallTargetModeEvent_GetOrder()     MHEvent_GetOrder()
    function MHMsgCallTargetModeEvent_GetCastType takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHMsgCallTargetModeEvent_SetCastType takes integer cast_type returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHMsgCallBuildModeEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    // #define MHMsgCallBuildModeEvent_GetOrder()     MHEvent_GetOrder()
    function MHMsgClickButtonEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    // #define MHMsgClickButtonEvent_GetButton()           MHEvent_GetFrame()
    // #define MHMsgClickButtonEvent_GetAbility()          MHEvent_GetAbility()
    // #define MHMsgClickButtonEvent_GetKey()              MHEvent_GetKey()
    // #define MHMsgClickButtonEvent_SetKey(key)           MHEvent_SetKey(key)
    function MHMsgImmediateOrderEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    // #define MHMsgLocalOrderEvent_GetOrder()         MHEvent_GetOrder()
    // #define MHMsgLocalOrderEvent_SetOrder(oid)      MHEvent_SetOrder(oid)
    function MHMsgLocalOrderEvent_GetFlag takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHMsgLocalOrderEvent_SetFlag takes integer flag returns nothing
        local integer yjsp = 114514
        return
    endfunction 
endlibrary
