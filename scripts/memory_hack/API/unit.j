#pragma once
// by Asphodelus
#include "../memory_hack_constant.j"



library AMHUnit
    function MHUnit_EnumInRange takes real x, real y, real range, string callback returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_EnumInRangeEx takes real x, real y, real range, code callback returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_EnumInScreen takes string callback returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_EnumInScreenEx takes code callback returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetEnumUnit takes nothing returns unit
        JapiPlaceHolder null
    endfunction
    function MHUnit_CreateBuilding takes player p, integer uid, real x, real y, boolean auto_build, boolean can_assist returns unit
        JapiPlaceHolder null
    endfunction
    function MHUnit_CreateIllusion takes player p, unit u, real x, real y returns unit
        JapiPlaceHolder null
    endfunction
    function MHUnit_AddAbility takes unit u, integer aid, boolean check_duplicate returns ability
        JapiPlaceHolder null
    endfunction
    function MHUnit_RemoveAbility takes unit u, integer aid, boolean check_duplicate returns boolean
        JapiPlaceHolder false
    endfunction
    function MHUnit_GetAbility takes unit u, integer aid, boolean search_base returns ability
        JapiPlaceHolder null
    endfunction
    function MHUnit_GetAbilityCount takes unit u returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUnit_GetAbilityByIndex takes unit u, integer index returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUnit_EnumAbility takes unit u, code callback returns boolean
        JapiPlaceHolder false
    endfunction
    function MHUnit_GetEnumAbility takes nothing returns ability
        JapiPlaceHolder null
    endfunction
    function MHUnit_GetEnumAbilityId takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUnit_GetData takes unit u, integer flag returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUnit_SetData takes unit u, integer flag, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetAtkDataInt takes unit u, integer flag returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUnit_GetAtkDataReal takes unit u, integer flag returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUnit_SetAtkDataInt takes unit u, integer flag, integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_SetAtkDataReal takes unit u, integer flag, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetDefDataInt takes integer uid, integer flag returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUnit_GetDefDataReal takes integer uid, integer flag returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUnit_GetDefDataBool takes integer uid, integer flag returns boolean
        JapiPlaceHolder false
    endfunction
    function MHUnit_GetDefDataStr takes integer uid, integer flag returns string
        JapiPlaceHolder null
    endfunction
    function MHUnit_SetDefDataInt takes integer uid, integer flag, integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_SetDefDataReal takes integer uid, integer flag, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_SetDefDataBool takes integer uid, integer flag, boolean value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_SetDefDataStr takes integer uid, integer flag, string value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetLevelDefDataInt takes integer uid, integer flag, integer level returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUnit_GetLevelDefDataStr takes integer uid, integer flag, integer level returns string
        JapiPlaceHolder null
    endfunction
    function MHUnit_SetLevelDefDataInt takes integer uid, integer flag, integer level, integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_SetLevelDefDataStr takes integer uid, integer flag, integer level, string value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetAttackTargetUnit takes unit u returns unit
        JapiPlaceHolder null
    endfunction
    function MHUnit_GetAttackTargetItem takes unit u returns item
        JapiPlaceHolder null
    endfunction
    function MHUnit_GetAttackTargetDest takes unit u returns destructable
        JapiPlaceHolder null
    endfunction
    function MHUnit_GetAttackTargetX takes unit u returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUnit_GetAttackTargetY takes unit u returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUnit_GetAttackTimerRemain takes unit u returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUnit_SetAttackTimerRemain takes unit u, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetAttackPointTimerRemain takes unit u returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUnit_SetAttackPointTimerRemain takes unit u, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetBackswingTimerRemain takes unit u returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUnit_SetBackswingTimerRemain takes unit u, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_ApplyTimedLife takes unit u, integer bid, real dur returns boolean
        JapiPlaceHolder false
    endfunction
    function MHUnit_CancelTimedLife takes unit u returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetTimedLifeRemain takes unit u returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUnit_SetTimedLifeRemain takes unit u, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_IsInvulnerable takes unit u returns boolean
        JapiPlaceHolder false
    endfunction
    function MHUnit_GetAsTarget takes unit u returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUnit_GetAsTargetType takes unit u returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUnit_SetAsTargetType takes unit u, integer as_target_type returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_CheckTargetAllow takes unit u, widget target, integer target_allow returns boolean
        JapiPlaceHolder false
    endfunction
    function MHUnit_GetFlag1 takes unit u returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUnit_SetFlag1 takes unit u, integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_IsFlag1 takes unit u, integer flag returns boolean
        JapiPlaceHolder false
    endfunction
    function MHUnit_Flag1Operator takes unit u, integer op, integer flag returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetFlag2 takes unit u returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUnit_SetFlag2 takes unit u, integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_IsFlag2 takes unit u, integer flag returns boolean
        JapiPlaceHolder false
    endfunction
    function MHUnit_Flag2Operator takes unit u, integer op, integer flag returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetFlag3 takes unit u returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUnit_SetFlag3 takes unit u, integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetFlagType takes unit u returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUnit_SetFlagType takes unit u, integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_IsFlagType takes unit u, integer flag returns boolean
        JapiPlaceHolder false
    endfunction
    function MHUnit_FlagTypeOperator takes unit u, integer op, integer flag returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_Kill takes unit victim, unit killer returns boolean
        JapiPlaceHolder false
    endfunction
    function MHUnit_Revive takes unit u, real x, real y returns boolean
        JapiPlaceHolder false
    endfunction
    function MHUnit_GetKiller takes unit victim returns unit
        JapiPlaceHolder null
    endfunction
    function MHUnit_Stun takes unit u, boolean is_stun returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetStunCount takes unit u returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUnit_SetEthereal takes unit u, boolean is_add returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetEtherealCount takes unit u returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUnit_SetInvisible takes unit u, boolean is_add, real gradient_time returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetInvisionCount takes unit u returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUnit_DisableAutoAttack takes unit u, boolean is_disable returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetDisableAutoAttackCount takes unit u returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUnit_GetState takes unit u returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUnit_IsState takes unit u, integer state returns boolean
        JapiPlaceHolder false
    endfunction
    function MHUnit_DisableMove takes unit u, boolean is_disable returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetMoveType takes unit u returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUnit_SetMoveType takes unit u, integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_SetPathType takes unit u, integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_SetCollisionType takes unit u, integer to_other, integer from_other returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_CheckPosition takes unit u, real x, real y returns boolean
        JapiPlaceHolder false
    endfunction
    function MHUnit_ModifyPositionX takes unit u, real x, real y returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUnit_ModifyPositionY takes unit u, real x, real y returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUnit_GetIllusionDamageDeal takes unit u returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUnit_SetIllusionDamageDeal takes unit u, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetIllusionDamageReceive takes unit u returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUnit_SetIllusionDamageReceive takes unit u, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_SetColor takes unit u, integer color returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_ResetColor takes unit u, integer color returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_SetModel takes unit u, string model_path, boolean flag returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_SetTeamColor takes unit u, playercolor color returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_SetTeamGlow takes unit u, playercolor glow returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetAnimationProgress takes unit u returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUnit_SetAnimationProgress takes unit u, real progress returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_Morph takes unit u, integer uid returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_LaunchAttack takes unit source, integer weapons_on, widget target returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_SetFacing takes unit u, real deg, boolean is_instant returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_Silence takes unit u, boolean is_silence returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetSilenceCount takes unit u returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUnit_DisableAbility takes unit u, boolean is_disable, boolean is_hide, boolean disable_magic, boolean disable_physical returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_RestoreLife takes unit u, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_RestoreMana takes unit u, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_UpdateInfoBar takes unit u returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetTrainId takes unit u, integer index returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUnit_CancelTrain takes unit u, integer index returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetShopTarget takes unit u, player p returns unit
        JapiPlaceHolder null
    endfunction
    function MHUnit_GetProgressSpeed takes unit u returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUnit_SetProgressSpeed takes unit u, real speed returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetProgress takes unit u returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUnit_SetProgress takes unit u, real progress returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_SetProgressEx takes unit u, real elapsed, real total returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_BindToUnit takes unit u, unit target, string attach returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_BindToItem takes unit u, item target, string attach returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_BindToDest takes unit u, destructable target, string attach returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_BindToEffect takes unit u, effect target, string attach returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_UnbindFromObject takes unit u returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetHPBar takes unit u returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUnit_GetOrderPlayer takes unit u returns player
        JapiPlaceHolder null
    endfunction
endlibrary



library AMHUnitHook
    function MHUnit_DisableOrder takes unit u, player p returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_EnableOrder takes unit u, player p returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_IsDisableOrder takes unit u, player p returns boolean
        JapiPlaceHolder false
    endfunction
    function MHUnit_DisableControl takes unit u returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_EnableControl takes unit u returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_IsDisableControl takes unit u returns boolean
        JapiPlaceHolder false
    endfunction
    function MHUnit_SetAttackSpeedLimit takes unit u, real limit returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetAttackSpeedLimit takes unit u returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUnit_ResetAttackSpeedLimit takes unit u returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_SetMoveSpeedLimit takes unit u, real limit returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetMoveSpeedLimit takes unit u returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUnit_ResetMoveSpeedLimit takes unit u returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_AddSpellRange takes unit u, real limit returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetSpellRange takes unit u returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUnit_ResetSpellRange takes unit u returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_EnableViewSkill takes unit u, player p returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_DisableViewSkill takes unit u, player p returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_IsEnableViewSkill takes unit u, player p returns boolean
        JapiPlaceHolder false
    endfunction
    function MHUnit_SetInfoName takes unit u, string name returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetInfoName takes unit u returns string
        JapiPlaceHolder null
    endfunction
    function MHUnit_RestoreInfoName takes unit u returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_SetInfoClass takes unit u, string class returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_GetInfoClass takes unit u returns string
        JapiPlaceHolder null
    endfunction
    function MHUnit_RestoreInfoClass takes unit u returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnit_DisablePreSelectUI takes unit u, boolean is_disable returns nothing
        JapiPlaceHolder
    endfunction
endlibrary



#include "event.j"
library AMHUnitEvent
    function MHUnitCreateEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnitRemoveEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnitAttackLaunchEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnitAttackLaunchEvent_GetTargetUnit takes nothing returns unit
        JapiPlaceHolder null
    endfunction
    function MHUnitAttackLaunchEvent_GetTargetItem takes nothing returns item
        JapiPlaceHolder null
    endfunction
    function MHUnitAttackLaunchEvent_GetTargetDest takes nothing returns destructable
        JapiPlaceHolder null
    endfunction
    function MHUnitAttackLaunchEvent_SetTarget takes widget target returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnitAttackLaunchEvent_GetWeapsOn takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUnitAttackLaunchEvent_SetWeapsOn takes integer weapons_on returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnitAttackLaunchEvent_Disable takes boolean is_disable returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnitRestoreLifeEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnitRestoreLifeEvent_GetValue takes nothing returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUnitRestoreLifeEvent_SetValue takes real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnitRestoreManaEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnitRestoreManaEvent_GetValue takes nothing returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUnitRestoreManaEvent_SetValue takes real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnitDispelEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnitDispelEvent_GetSource takes nothing returns unit
        JapiPlaceHolder null
    endfunction
    function MHUnitDispelEvent_GetDamage takes nothing returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUnitDispelEvent_SetDamage takes real dmg returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnitHarvestEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnitHarvestEvent_GetValue takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUnitHarvestEvent_SetValue takes integer value returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnitHarvestEvent_IsResourceGold takes nothing returns boolean
        JapiPlaceHolder false
    endfunction
    function MHUnitHarvestEvent_SetResourceGold takes boolean is_gold returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnitSearchTargetEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHUnitSearchTargetEvent_GetTarget takes nothing returns unit
        JapiPlaceHolder null
    endfunction
    function MHUnitSearchTargetEvent_SetTarget takes unit target returns nothing
        JapiPlaceHolder
    endfunction
endlibrary
