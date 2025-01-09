// by Asphodelus
#pragma once
#include "../memory_hack_constant.j"



library AMHDamage
    function MHDamage_DamageTarget takes unit u, widget target, real dmg, attacktype atk_type, damagetype dmg_type, boolean is_physical, integer flag returns real
        JapiPlaceHolder 0.
    endfunction
    #define MHDamage_DamageUnit(u,target,dmg,atk_type,dmg_type,is_physical,flag) MHDamage_DamageTarget(u,target,dmg,atk_type,dmg_type,is_physical,flag)
endlibrary



#include "event.j"
library AMHDamageEvent
    function MHDamageEvent_SetDamage takes real value returns boolean
        JapiPlaceHolder false
    endfunction
    function MHDamageEvent_IsPhysical takes nothing returns boolean
        JapiPlaceHolder false
    endfunction
    function MHDamageEvent_GetAtkType takes nothing returns attacktype
        JapiPlaceHolder null
    endfunction
    function MHDamageEvent_GetDmgType takes nothing returns damagetype
        JapiPlaceHolder null
    endfunction
    function MHDamageEvent_GetWeapType takes nothing returns weapontype
        JapiPlaceHolder null
    endfunction
    function MHDamageEvent_GetAtkTypeInt takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHDamageEvent_GetDmgTypeInt takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHDamageEvent_GetWeapTypeInt takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHDamageEvent_GetFlag takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHDamagingEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHDamagingEvent_IsPhysical takes nothing returns boolean
        JapiPlaceHolder false
    endfunction
    function MHDamagingEvent_GetDamage takes nothing returns real
        JapiPlaceHolder 0.
    endfunction
    #define MHDamagingEvent_GetTarget()             MHEvent_GetUnit()
    #define MHDamagingEvent_SetTarget(t)            MHEvent_SetUnit(t)
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



    #define YDWEIsEventPhysicalDamage() MHDamageEvent_IsPhysical()
    #define YDWEIsEventAttackDamage()   MHMath_IsBitSet(MHDamageEvent_GetFlag(), 0x100)
    #define YDWEIsEventRangedDamage()   MHMath_IsBitSet(MHDamageEvent_GetFlag(), 0x1)
    #define YDWEIsEventDamageType(a)    (MHDamageEvent_GetDmgType() == a)
    #define YDWEIsEventWeaponType(a)    (MHDamageEvent_GetWeapType() == a)
    #define YDWEIsEventAttackType(a)    (MHDamageEvent_GetAtkType() == a)
    #define YDWESetEventDamage(a)       MHDamageEvent_SetDamage(a)
endlibrary
