
library AbilityCustomCastType requires ErrorMessage

    globals
        private constant integer BERSERKER_CAST_TYPE = ABILITY_CAST_TYPE_NONTARGET + ABILITY_CAST_TYPE_INSTANT
    endglobals
    
    function SetAbilityCastType takes integer abilId, integer castType returns nothing
        static if DEBUG_MODE then
            call ThrowError(not MHAbility_SetCastTypeEx(abilId, castType), "AbilityCustomCastType", "SetAbilityCastType", GetObjectName(abilId), abilId, "castType:" + I2S(castType) )
        else
            call MHAbility_SetCastTypeEx(abilId, castType)
        endif
    endfunction

    function AbilityCustomCastType_Init takes nothing returns nothing
        
    endfunction

endlibrary
