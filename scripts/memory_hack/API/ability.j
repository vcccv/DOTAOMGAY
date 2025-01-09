// by Asphodelus
#pragma once
#include "../memory_hack_constant.j"



library AMHAbility
    function MHAbility_GetDefDataInt takes integer aid, integer flag returns integer
        JapiPlaceHolder 0
    endfunction
    function MHAbility_SetDefDataInt takes integer aid, integer flag, integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetDefDataReal takes integer aid, integer flag returns real
        JapiPlaceHolder 0.
    endfunction
    function MHAbility_SetDefDataReal takes integer aid, integer flag, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetDefDataBool takes integer aid, integer flag returns boolean
        JapiPlaceHolder false
    endfunction
    function MHAbility_SetDefDataBool takes integer aid, integer flag, boolean value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetDefDataStr takes integer aid, integer flag returns string
        JapiPlaceHolder null
    endfunction
    function MHAbility_SetDefDataStr takes integer aid, integer flag, string value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetLevelDefDataInt takes integer aid, integer level, integer flag returns integer
        JapiPlaceHolder 0
    endfunction
    function MHAbility_SetLevelDefDataInt takes integer aid, integer level, integer flag, integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetLevelDefDataReal takes integer aid, integer level, integer flag returns real
        JapiPlaceHolder 0.
    endfunction
    function MHAbility_SetLevelDefDataReal takes integer aid, integer level, integer flag, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetLevelDefDataStr takes integer aid, integer level, integer flag returns string
        JapiPlaceHolder null
    endfunction
    function MHAbility_SetLevelDefDataStr takes integer aid, integer level, integer flag, string value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetAll takes unit u, hashtable ht returns integer
        JapiPlaceHolder 0
    endfunction
    function MHAbility_GetHeroAll takes unit u, hashtable ht returns integer
        JapiPlaceHolder 0
    endfunction
    function MHAbility_GetBaseId takes unit u, integer aid returns integer
        JapiPlaceHolder 0
    endfunction
    function MHAbility_Cast takes unit source, widget target, real target_x, real target_y, integer aid returns boolean
        JapiPlaceHolder false
    endfunction
    function MHAbility_CastEx takes unit source, widget target, real target_x, real target_y, integer aid returns boolean
        JapiPlaceHolder false
    endfunction
    function MHAbility_GetOrder takes unit u, integer aid, integer order_flag returns integer
        JapiPlaceHolder 0
    endfunction
    function MHAbility_GetOrderCast takes unit u, integer aid returns integer
        JapiPlaceHolder 0
    endfunction
    function MHAbility_GetOrderOn takes unit u, integer aid returns integer
        JapiPlaceHolder 0
    endfunction
    function MHAbility_GetOrderOff takes unit u, integer aid returns integer
        JapiPlaceHolder 0
    endfunction
    function MHAbility_GetCastType takes unit u, integer aid returns integer
        JapiPlaceHolder 0
    endfunction
    function MHAbility_GetTargetAllow takes unit u, integer aid returns integer
        JapiPlaceHolder 0
    endfunction
    function MHAbility_SetTargetAllow takes unit u, integer aid, integer flag returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetFlag takes unit u, integer aid returns integer
        JapiPlaceHolder 0
    endfunction
    function MHAbility_SetFlag takes unit u, integer aid, integer flag returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_IsFlag takes unit u, integer aid, integer flag returns boolean
        JapiPlaceHolder false
    endfunction
    function MHAbility_FlagOperator takes unit u, integer aid, integer op, integer flag returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_IsPassive takes unit u, integer aid returns boolean
        JapiPlaceHolder false
    endfunction
    function MHAbility_IsOnCooldown takes unit u, integer aid returns boolean
        JapiPlaceHolder false
    endfunction
    function MHAbility_GetCooldown takes unit u, integer aid returns real
        JapiPlaceHolder 0.
    endfunction
    function MHAbility_SetCooldown takes unit u, integer aid, real dur returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetAbilityCooldown takes ability abil returns real
        JapiPlaceHolder 0.
    endfunction
    function MHAbility_SetAbilityCooldown takes ability abil, real dur returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetSpellRemain takes unit u, integer aid returns real
        JapiPlaceHolder 0.
    endfunction
    function MHAbility_SetSpellRemain takes unit u, integer aid, real dur returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetTargetUnit takes unit u, integer aid returns unit
        JapiPlaceHolder null
    endfunction
    function MHAbility_GetTargetItem takes unit u, integer aid returns item
        JapiPlaceHolder null
    endfunction
    function MHAbility_GetTargetDest takes unit u, integer aid returns destructable
        JapiPlaceHolder null
    endfunction
    function MHAbility_SetTarget takes unit u, integer aid, widget target returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetTargetX takes unit u, integer aid returns real
        JapiPlaceHolder 0.
    endfunction
    function MHAbility_SetTargetX takes unit u, integer aid, real x returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetTargetY takes unit u, integer aid returns real
        JapiPlaceHolder 0.
    endfunction
    function MHAbility_SetTargetY takes unit u, integer aid, real x returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_Hide takes unit u, integer aid, boolean is_hide returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetHideCount takes unit u, integer aid returns integer
        JapiPlaceHolder 0
    endfunction
    function MHAbility_Disable takes unit u, integer aid, boolean is_disable, boolean is_hide returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetDisableCount takes unit u, integer aid returns integer
        JapiPlaceHolder 0
    endfunction
    function MHAbility_DisableEx takes unit u, integer aid, boolean is_disable returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetDisableExCount takes unit u, integer aid returns integer
        JapiPlaceHolder 0
    endfunction
    function MHAbility_IsPolarity takes unit u, integer aid, integer polarity returns boolean
        JapiPlaceHolder false
    endfunction
    function MHAbility_GetCastpoint takes unit u, integer aid returns real
        JapiPlaceHolder 0.
    endfunction
    function MHAbility_SetCastpoint takes unit u, integer aid, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetBackswing takes unit u, integer aid returns real
        JapiPlaceHolder 0.
    endfunction
    function MHAbility_SetBackswing takes unit u, integer aid, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetSourceItem takes unit u, integer aid returns item
        JapiPlaceHolder null
    endfunction
    function MHAbility_GetAbilitySourceItem takes ability abil returns item
        JapiPlaceHolder null
    endfunction
endlibrary



library AMHAbilityHook
    function MHAbility_SetHookOrder takes integer aid, integer oid returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetHookOrder takes integer aid returns integer
        JapiPlaceHolder 0
    endfunction
    function MHAbility_RestoreHookOrder takes integer aid returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_SetChargeCount takes unit u, integer aid, integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetChargeCount takes unit u, integer aid returns integer
        JapiPlaceHolder 0
    endfunction
    function MHAbility_SetChargeState takes unit u, integer aid, boolean flag returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetChargeState takes unit u, integer aid returns boolean
        JapiPlaceHolder false
    endfunction
    function MHAbility_SetChargeText takes unit u, integer aid, string text returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetChargeText takes unit u, integer aid returns string
        JapiPlaceHolder null
    endfunction
    function MHAbility_SetCastType takes unit u, integer aid, integer cast_type returns boolean
        JapiPlaceHolder false
    endfunction
    function MHAbility_RestoreCastType takes unit u, integer aid returns boolean
        JapiPlaceHolder false
    endfunction
    function MHAbility_SetCastTypeEx takes integer aid, integer cast_type returns boolean
        JapiPlaceHolder false
    endfunction
    function MHAbility_RestoreCastTypeEx takes integer aid returns boolean
        JapiPlaceHolder false
    endfunction
    function MHAbility_HideEx takes unit u, integer aid, boolean is_hide returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_IsHideEx takes unit u, integer aid returns boolean
        JapiPlaceHolder false
    endfunction
endlibrary



library AMHAbilitySystem
    function MHDrawCooldown_GetText takes integer index returns integer
        JapiPlaceHolder 0
    endfunction
    function MHDrawCooldown_SetDivide takes real divide returns nothing
        JapiPlaceHolder
    endfunction
    function MHDrawCooldown_Initialize takes nothing returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetCustomDataInt takes unit u, integer aid, integer flag returns integer
        JapiPlaceHolder 0
    endfunction
    function MHAbility_GetCustomDataReal takes unit u, integer aid, integer flag returns real
        JapiPlaceHolder 0.
    endfunction
    function MHAbility_GetCustomDataBool takes unit u, integer aid, integer flag returns boolean
        JapiPlaceHolder false
    endfunction
    function MHAbility_GetCustomDataStr takes unit u, integer aid, integer flag returns string
        JapiPlaceHolder null
    endfunction
    function MHAbility_SetCustomDataInt takes unit u, integer aid, integer flag, integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_SetCustomDataReal takes unit u, integer aid, integer flag, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_SetCustomDataBool takes unit u, integer aid, integer flag, boolean value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_SetCustomDataStr takes unit u, integer aid, integer flag, string value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetCustomLevelDataInt takes unit u, integer aid, integer level, integer flag returns integer
        JapiPlaceHolder 0
    endfunction
    function MHAbility_GetCustomLevelDataReal takes unit u, integer aid, integer level, integer flag returns real
        JapiPlaceHolder 0.
    endfunction
    function MHAbility_GetCustomLevelDataBool takes unit u, integer aid, integer level, integer flag returns boolean
        JapiPlaceHolder false
    endfunction
    function MHAbility_GetCustomLevelDataStr takes unit u, integer aid, integer level, integer flag returns string
        JapiPlaceHolder null
    endfunction
    function MHAbility_SetCustomLevelDataInt takes unit u, integer aid, integer level, integer flag, integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_SetCustomLevelDataReal takes unit u, integer aid, integer level, integer flag, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_SetCustomLevelDataBool takes unit u, integer aid, integer level, integer flag, boolean value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_SetCustomLevelDataStr takes unit u, integer aid, integer level, integer flag, string value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_ResetCustomData takes unit u, integer aid returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetAbilityCustomDataInt takes ability abil, integer flag returns integer
        JapiPlaceHolder 0
    endfunction
    function MHAbility_GetAbilityCustomDataReal takes ability abil, integer flag returns real
        JapiPlaceHolder 0.
    endfunction
    function MHAbility_GetAbilityCustomDataBool takes ability abil, integer flag returns boolean
        JapiPlaceHolder false
    endfunction
    function MHAbility_GetAbilityCustomDataStr takes ability abil, integer flag returns string
        JapiPlaceHolder null
    endfunction
    function MHAbility_SetAbilityCustomDataInt takes ability abil, integer flag, integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_SetAbilityCustomDataReal takes ability abil, integer flag, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_SetAbilityCustomDataBool takes ability abil, integer flag, boolean value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_SetAbilityCustomDataStr takes ability abil, integer flag, string value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_GetAbilityCustomLevelDataInt takes ability abil, integer level, integer flag returns integer
        JapiPlaceHolder 0
    endfunction
    function MHAbility_GetAbilityCustomLevelDataReal takes ability abil, integer level, integer flag returns real
        JapiPlaceHolder 0.
    endfunction
    function MHAbility_GetAbilityCustomLevelDataBool takes ability abil, integer level, integer flag returns boolean
        JapiPlaceHolder false
    endfunction
    function MHAbility_GetAbilityCustomLevelDataStr takes ability abil, integer level, integer flag returns string
        JapiPlaceHolder null
    endfunction
    function MHAbility_SetAbilityCustomLevelDataInt takes ability abil, integer level, integer flag, integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_SetAbilityCustomLevelDataReal takes ability abil, integer level, integer flag, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_SetAbilityCustomLevelDataBool takes ability abil, integer level, integer flag, boolean value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_SetAbilityCustomLevelDataStr takes ability abil, integer level, integer flag, string value returns nothing
        JapiPlaceHolder
    endfunction
    function MHAbility_ResetAbilityCustomData takes ability abil returns nothing
        JapiPlaceHolder
    endfunction
endlibrary



#include "event.j"
library AMHAbilityEvent
    function MHAbilityAddEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    #define MHAbilityAddEvent_GetUnit()                     MHEvent_GetUnit()
    #define MHAbilityAddEvent_GetAbility()                  MHEvent_GetAbility()
    function MHAbilityRemoveEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    #define MHAbilityRemoveEvent_GetUnit()                  MHEvent_GetUnit()
    #define MHAbilityRemoveEvent_GetAbility()               MHEvent_GetAbility()
    function MHAbilityStartCooldownEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    #define MHAbilityStartCooldownEvent_GetUnit()           MHEvent_GetUnit()
    #define MHAbilityStartCooldownEvent_GetAbility()        MHEvent_GetAbility()
    function MHAbilityEndCooldownEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    #define MHAbilityEndCooldownEvent_GetUnit()             MHEvent_GetUnit()
    #define MHAbilityEndCooldownEvent_GetAbility()          MHEvent_GetAbility()
    function MHAbilityRefreshAuraEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    #define MHAbilityRefreshAuraEvent_GetSource()           MHEvent_GetUnit()
    #define MHAbilityRefreshAuraEvent_GetAbility()          MHEvent_GetAbility()
    function MHAbilityRefreshAuraEvent_GetTarget takes nothing returns unit
        JapiPlaceHolder null
    endfunction
    function MHAbilityRefreshAuraEvent_GetBuff takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
endlibrary
