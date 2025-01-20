
library AbilityCustomOrderId

    globals
        private integer OrderIdBase = 950000
    endglobals

    function AllocAbilityOrderId takes integer abilId returns integer 
        set OrderIdBase = OrderIdBase + 1
        call MHAbility_SetHookOrder(abilId, OrderIdBase)
        return OrderIdBase
    endfunction

    function GetAbiltiyOrder takes integer abilId returns string
        local integer id = MHAbility_GetHookOrder(abilId)
        if id == 0 then
            return ""
        endif
        return I2S(id)
    endfunction

    function GetAbiltiyOrderId takes integer abilId returns integer
        return MHAbility_GetHookOrder(abilId)
    endfunction

    function InitAbilityCustomOrderId takes nothing returns nothing
        // 巨浪
        call AllocAbilityOrderId('A046')
        call AllocAbilityOrderId('A3OH')
    endfunction

endlibrary
