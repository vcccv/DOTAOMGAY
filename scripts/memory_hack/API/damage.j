#pragma once
// by Asphodelus
#include "../memory_hack_constant.j"



library AMHDamage
    function MHDamage_DamageTarget takes unit u, widget target, real dmg, attacktype atk_type, damagetype dmg_type, boolean is_physical, integer flag returns real
        JapiPlaceHolder 0.
    endfunction
    #define MHDamage_DamageUnit(u,target,dmg,atk_type,dmg_type,is_physical,flag) MHDamage_DamageTarget(u,target,dmg,atk_type,dmg_type,is_physical,flag)
endlibrary



#include "event.j"
library AMHDamageEvent
    function MHDamagingEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHDamagingEvent_IsPhysical takes nothing returns boolean
        JapiPlaceHolder false
    endfunction
    function MHDamagingEvent_GetDamage takes nothing returns real
        JapiPlaceHolder 0.
    endfunction
    function MHDamagingEvent_SetDamage takes real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHDamagingEvent_GetSource takes nothing returns unit
        JapiPlaceHolder null
    endfunction
    function MHDamagingEvent_SetSource takes unit u returns nothing
        JapiPlaceHolder
    endfunction
    function MHDamagingEvent_GetFlag takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHDamagingEvent_SetFlag takes integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHDamagingEvent_GetAtkType takes nothing returns attacktype
        JapiPlaceHolder null
    endfunction
    function MHDamagingEvent_GetAtkTypeInt takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHDamagingEvent_SetAtkType takes attacktype atk_type returns nothing
        JapiPlaceHolder
    endfunction
    function MHDamagingEvent_GetDmgType takes nothing returns damagetype
        JapiPlaceHolder null
    endfunction
    function MHDamagingEvent_GetDmgTypeInt takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHDamagingEvent_SetDmgType takes damagetype dmg_type returns nothing
        JapiPlaceHolder
    endfunction
    function MHDamagingEvent_GetWeapType takes nothing returns weapontype
        JapiPlaceHolder null
    endfunction
    function MHDamagingEvent_GetWeapTypeInt takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHDamagingEvent_SetWeapType takes weapontype weap_type returns nothing
        JapiPlaceHolder
    endfunction
    function MHDamageEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHDamageEvent_IsPhysical takes nothing returns boolean
        JapiPlaceHolder false
    endfunction
    function MHDamageEvent_GetDamage takes nothing returns real
        JapiPlaceHolder 0.
    endfunction
    function MHDamageEvent_SetDamage takes real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHDamageEvent_GetSource takes nothing returns unit
        JapiPlaceHolder null
    endfunction
    function MHDamageEvent_SetSource takes unit u returns nothing
        JapiPlaceHolder
    endfunction
    function MHDamageEvent_GetFlag takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHDamageEvent_GetAtkType takes nothing returns attacktype
        JapiPlaceHolder null
    endfunction
    function MHDamageEvent_GetAtkTypeInt takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHDamageEvent_GetDmgType takes nothing returns damagetype
        JapiPlaceHolder null
    endfunction
    function MHDamageEvent_GetDmgTypeInt takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHDamageEvent_GetWeapType takes nothing returns weapontype
        JapiPlaceHolder null
    endfunction
    function MHDamageEvent_GetWeapTypeInt takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHNativeDamageEvent_IsPhysical takes nothing returns boolean
        JapiPlaceHolder false
    endfunction
    function MHNativeDamageEvent_GetDamage takes nothing returns real
        JapiPlaceHolder 0.
    endfunction
    function MHNativeDamageEvent_SetDamage takes real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHNativeDamageEvent_GetFlag takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHNativeDamageEvent_GetAtkType takes nothing returns attacktype
        JapiPlaceHolder null
    endfunction
    function MHNativeDamageEvent_GetAtkTypeInt takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHNativeDamageEvent_GetDmgType takes nothing returns damagetype
        JapiPlaceHolder null
    endfunction
    function MHNativeDamageEvent_GetDmgTypeInt takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHNativeDamageEvent_GetWeapType takes nothing returns weapontype
        JapiPlaceHolder null
    endfunction
    function MHNativeDamageEvent_GetWeapTypeInt takes nothing returns integer
        JapiPlaceHolder 0
    endfunction



    #define YDWEIsEventPhysicalDamage() MHNativeDamageEvent_IsPhysical()
    #define YDWEIsEventAttackDamage()   MHMath_IsBitSet(MHNativeDamageEvent_GetFlag(), 0x100)
    #define YDWEIsEventRangedDamage()   MHMath_IsBitSet(MHNativeDamageEvent_GetFlag(), 0x1)
    #define YDWEIsEventDamageType(a)    (MHNativeDamageEvent_GetDmgType() == a)
    #define YDWEIsEventWeaponType(a)    (MHNativeDamageEvent_GetWeapType() == a)
    #define YDWEIsEventAttackType(a)    (MHNativeDamageEvent_GetAtkType() == a)
    #define YDWESetEventDamage(a)       MHNativeDamageEvent_SetDamage(a)
endlibrary
