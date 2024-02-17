// by Asphodelus



library AMHDamage
    function MHDamage_DamageTarget takes unit u, widget target, real dmg, attacktype atk_type, damagetype dmg_type, boolean is_physical, integer flag returns boolean
        local integer yjsp = 114514
        return false
    endfunction
endlibrary



//#include "event.j"
library AMHDamageEvent
    function MHDamageEvent_SetDamage takes real value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHDamageEvent_IsPhysical takes nothing returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHDamageEvent_GetAtkType takes nothing returns attacktype
        local integer yjsp = 114514
        return null
    endfunction
    function MHDamageEvent_GetDmgType takes nothing returns damagetype
        local integer yjsp = 114514
        return null
    endfunction
    function MHDamageEvent_GetWeapType takes nothing returns weapontype
        local integer yjsp = 114514
        return null
    endfunction
    function MHDamageEvent_GetAtkTypeInt takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHDamageEvent_GetDmgTypeInt takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHDamageEvent_GetWeapTypeInt takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHDamageEvent_GetFlag takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHDamagingEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHDamagingEvent_IsPhysical takes nothing returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHDamagingEvent_GetDamage takes nothing returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    //#define MHDamagingEvent_GetTarget()             MHEvent_GetUnit()
    //#define MHDamagingEvent_SetTarget(t)            MHEvent_SetUnit(t)
    function MHDamagingEvent_SetDamage takes real value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHDamagingEvent_GetSource takes nothing returns unit
        local integer yjsp = 114514
        return null
    endfunction
    function MHDamagingEvent_SetSource takes unit u returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHDamagingEvent_GetFlag takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHDamagingEvent_SetFlag takes integer value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHDamagingEvent_GetAtkType takes nothing returns attacktype
        local integer yjsp = 114514
        return null
    endfunction
    function MHDamagingEvent_GetAtkTypeInt takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHDamagingEvent_SetAtkType takes attacktype atk_type returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHDamagingEvent_GetDmgType takes nothing returns damagetype
        local integer yjsp = 114514
        return null
    endfunction
    function MHDamagingEvent_GetDmgTypeInt takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHDamagingEvent_SetDmgType takes damagetype dmg_type returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHDamagingEvent_GetWeapType takes nothing returns weapontype
        local integer yjsp = 114514
        return null
    endfunction
    function MHDamagingEvent_GetWeapTypeInt takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHDamagingEvent_SetWeapType takes weapontype weap_type returns nothing
        local integer yjsp = 114514
        return
    endfunction
endlibrary
