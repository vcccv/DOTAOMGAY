// by Asphodelus



library AMHHero
    function MHHero_GetMaxExp takes unit u, integer level returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHHero_GetNeededExp takes unit u, integer level returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHHero_GetPrimaryAttr takes unit u returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHHero_SetPrimaryAttr takes unit u, integer attr returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHHero_GetPrimaryAttrValue takes unit u, boolean include_bonus returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHHero_SetPrimaryAttrValue takes unit u, integer value, boolean allow_bonus returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHHero_GetAttrPlus takes unit u, integer attr returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHHero_SetAttrPlus takes unit u, integer attr, real value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHHero_ModifyAbility takes unit u, integer old_id, integer new_id returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHHero_ModifyAbilityEx takes unit u, integer index, integer new_id returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHHero_ChangeAbility takes unit u, integer old_id, integer new_id returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHHero_ChangeAbilityEx takes unit u, integer old_id, integer new_id returns boolean
        local integer yjsp = 114514
        return false
    endfunction
endlibrary



//#include "event.j"
library AMHHeroEvent
    function MHHeroGetExpEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHHeroGetExpEvent_GetValue takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHHeroGetExpEvent_SetValue takes integer value returns nothing
        local integer yjsp = 114514
        return
    endfunction
endlibrary
