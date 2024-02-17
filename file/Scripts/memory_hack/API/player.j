// by Aphodelus



library AMHPlayer
    function MHPlayer_GetSelectUnit takes nothing returns unit
        local integer yjsp = 114514
        return null
    endfunction
    function MHPlayer_GetSelectItem takes nothing returns item
        local integer yjsp = 114514
        return null
    endfunction
endlibrary



//#include "event.j"
library AMHPlayerEvent
    function MHPlayerGoldChangeEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    //#define MHPlayerGoldChangeEvent_GetPlayer()         MHEvent_GetPlayer()
    //#define MHPlayerGoldChangeEvent_SetPlayer(p)        MHEvent_SetPlayer(p)
    function MHPlayerGoldChangeEvent_GetValue takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHPlayerGoldChangeEvent_SetValue takes integer value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHPlayerGoldChangeEvent_IsTax takes nothing returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHPlayerGoldChangeEvent_SetTax takes boolean is_tax returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHPlayerLumberChangeEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    //#define MHPlayerLumberChangeEvent_GetPlayer()       MHEvent_GetPlayer()
    //#define MHPlayerLumberChangeEvent_SetPlayer(p)      MHEvent_SetPlayer(p)
    function MHPlayerLumberChangeEvent_GetValue takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHPlayerLumberChangeEvent_SetValue takes integer value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHPlayerLumberChangeEvent_IsTax takes nothing returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHPlayerLumberChangeEvent_SetTax takes boolean is_tax returns nothing
        local integer yjsp = 114514
        return
    endfunction
endlibrary