// by Asphodelus



library MHUnit
    function MHUnit_CreateBuilding takes player p, integer uid, real x, real y, boolean auto_build, boolean can_assist returns unit
        local integer yjsp = 114514
        return null
    endfunction
    function MHUnit_CreateIllusion takes player p, unit u, real x, real y returns unit
        local integer yjsp = 114514
        return null
    endfunction
    function MHUnit_AddAbility takes unit u, integer aid, boolean check_duplicate returns ability
        local integer yjsp = 114514
        return null
    endfunction
    function MHUnit_RemoveAbility takes unit u, integer aid, boolean check_duplicate returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHUnit_GetAbility takes unit u, integer aid, boolean search_base returns ability
        local integer yjsp = 114514
        return null
    endfunction
    function MHUnit_GetAbilityCount takes unit u returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUnit_GetAbilityByIndex takes unit u, integer index returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUnit_GetData takes unit u, integer flag returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHUnit_SetData takes unit u, integer flag, real value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_GetAtkDataInt takes unit u, integer flag returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUnit_GetAtkDataReal takes unit u, integer flag returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHUnit_SetAtkDataInt takes unit u, integer flag, integer value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_SetAtkDataReal takes unit u, integer flag, real value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_GetDefDataInt takes integer uid, integer flag returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUnit_GetDefDataReal takes integer uid, integer flag returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHUnit_GetDefDataBool takes integer uid, integer flag returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHUnit_GetDefDataStr takes integer uid, integer flag returns string
        local integer yjsp = 114514
        return null
    endfunction
    function MHUnit_SetDefDataInt takes integer uid, integer flag, integer value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_SetDefDataReal takes integer uid, integer flag, real value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_SetDefDataBool takes integer uid, integer flag, boolean value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_SetDefDataStr takes integer uid, integer flag, string value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_GetLevelDefDataInt takes integer uid, integer flag, integer level returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUnit_GetLevelDefDataStr takes integer uid, integer flag, integer level returns string
        local integer yjsp = 114514
        return null
    endfunction
    function MHUnit_SetLevelDefDataInt takes integer uid, integer flag, integer level, integer value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_SetLevelDefDataStr takes integer uid, integer flag, integer level, string value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_GetAttackTargetUnit takes unit u returns unit
        local integer yjsp = 114514
        return null
    endfunction
    function MHUnit_GetAttackTargetItem takes unit u returns item
        local integer yjsp = 114514
        return null
    endfunction
    function MHUnit_GetAttackTargetDest takes unit u returns destructable
        local integer yjsp = 114514
        return null
    endfunction
    function MHUnit_GetAttackTargetX takes unit u returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHUnit_GetAttackTargetY takes unit u returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHUnit_GetAttackTimerRemain takes unit u returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHUnit_SetAttackTimerRemain takes unit u, real value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_GetAttackPointTimerRemain takes unit u returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHUnit_SetAttackPointTimerRemain takes unit u, real value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_GetBackswingTimerRemain takes unit u returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHUnit_SetBackswingTimerRemain takes unit u, real value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_ApplyTimedLife takes unit u, integer bid, real dur returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHUnit_CancelTimedLife takes unit u returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_GetTimedLifeRemain takes unit u returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHUnit_SetTimedLifeRemain takes unit u, real value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_IsInvulnerable takes unit u returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHUnit_GetAsTarget takes unit u returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUnit_GetAsTargetType takes unit u returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUnit_SetAsTargetType takes unit u, integer as_target_type returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_CheckTargetAllow takes unit u, widget target, integer target_allow returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHUnit_GetFlag1 takes unit u returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUnit_SetFlag1 takes unit u, integer value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_IsFlag1 takes unit u, integer flag returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHUnit_Flag1Operator takes unit u, integer op, integer flag returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_GetFlag2 takes unit u returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUnit_SetFlag2 takes unit u, integer value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_IsFlag2 takes unit u, integer flag returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHUnit_Flag2Operator takes unit u, integer op, integer flag returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_GetFlag3 takes unit u returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUnit_SetFlag3 takes unit u, integer value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_GetFlagType takes unit u returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUnit_SetFlagType takes unit u, integer value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_IsFlagType takes unit u, integer flag returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHUnit_FlagTypeOperator takes unit u, integer op, integer flag returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_Revive takes unit u, real x, real y returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHUnit_Stun takes unit u, boolean is_stun returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_GetStunCount takes unit u returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUnit_SetEthereal takes unit u, boolean is_add returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_GetEtherealCount takes unit u returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUnit_SetInvisible takes unit u, boolean is_add, real gradient_time returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_GetInvisionCount takes unit u returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUnit_DisableAutoAttack takes unit u, boolean is_disable returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_GetDisableAutoAttackCount takes unit u returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUnit_GetState takes unit u returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUnit_IsState takes unit u, integer state returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHUnit_DisableMove takes unit u, boolean is_disable returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_GetMoveType takes unit u returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUnit_SetMoveType takes unit u, integer value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_SetPathType takes unit u, integer value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_SetCollisionType takes unit u, integer to_other, integer from_other returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_SetIllusionDamageDeal takes unit u, real value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_SetIllusionDamageReceive takes unit u, real value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_SetModel takes unit u, string model_path, boolean flag returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_SetTeamColor takes unit u, playercolor color returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_SetTeamGlow takes unit u, playercolor glow returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_GetAnimationProgress takes unit u returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHUnit_SetAnimationProgress takes unit u, real progress returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_Morph takes unit u, integer uid returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_LaunchAttack takes unit source, integer weapons_on, widget target returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_SetFacing takes unit u, real deg, boolean is_instant returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_Silence takes unit u, boolean is_silence returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_DisableAbility takes unit u, boolean is_disable, boolean is_hide, boolean disable_magic, boolean disable_physical returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_RestoreLife takes unit u, real value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_UpdateInfoBar takes unit u returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_GetTrainId takes unit u, integer index returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUnit_GetProgressSpeed takes unit u returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHUnit_SetProgressSpeed takes unit u, real speed returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_GetProgress takes unit u returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHUnit_SetProgress takes unit u, real progress returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_SetProgressEx takes unit u, real elapsed, real total returns nothing
        local integer yjsp = 114514
        return
    endfunction
endlibrary



library MHUnitHook
    function MHUnit_DisableOrder takes unit u, player p returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_EnableOrder takes unit u, player p returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_IsDisableOrder takes unit u, player p returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHUnit_DisableControl takes unit u returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_EnableControl takes unit u returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_IsDisableControl takes unit u returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHUnit_SetMoveSpeedLimit takes unit u, real limit returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_GetMoveSpeedLimit takes unit u returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHUnit_ResetMoveSpeedLimit takes unit u returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_EnableViewSkill takes unit u, player p returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_DisableViewSkill takes unit u, player p returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_IsEnableViewSkill takes unit u, player p returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHUnit_SetInfoName takes unit u, string name returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_GetInfoName takes unit u returns string
        local integer yjsp = 114514
        return null
    endfunction
    function MHUnit_RestoreInfoName takes unit u returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_SetInfoClass takes unit u, string class returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnit_GetInfoClass takes unit u returns string
        local integer yjsp = 114514
        return null
    endfunction
    function MHUnit_RestoreInfoClass takes unit u returns nothing
        local integer yjsp = 114514
        return
    endfunction
endlibrary



// #include "event.j"
library MHUnitEvent
    function MHUnitRemoveEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    // #define MHUnitRemoveEvent_GetUnit()                 MHEvent_GetUnit()
    function MHUnitAttackLaunchEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    // #define MHUnitAttackLaunchEvent_GetSource()         MHEvent_GetUnit()
    function MHUnitAttackLaunchEvent_GetTargetUnit takes nothing returns unit
        local integer yjsp = 114514
        return null
    endfunction
    function MHUnitAttackLaunchEvent_GetTargetItem takes nothing returns item
        local integer yjsp = 114514
        return null
    endfunction
    function MHUnitAttackLaunchEvent_GetTargetDest takes nothing returns destructable
        local integer yjsp = 114514
        return null
    endfunction
    function MHUnitAttackLaunchEvent_SetTarget takes widget target returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnitAttackLaunchEvent_GetWeapsOn takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUnitAttackLaunchEvent_SetWeapsOn takes integer weapons_on returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnitAttackLaunchEvent_Disable takes boolean is_disable returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnitRestoreLifeEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    // #define MHUnitRestoreLifeEvent_GetUnit()            MHEvent_GetUnit()
    function MHUnitRestoreLifeEvent_GetValue takes nothing returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHUnitRestoreLifeEvent_SetValue takes real value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnitRestoreManaEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    // #define MHUnitRestoreManaEvent_GetUnit()            MHEvent_GetUnit()
    function MHUnitRestoreManaEvent_GetValue takes nothing returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHUnitRestoreManaEvent_SetValue takes real value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnitDispelEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    // #define MHUnitDispelEvent_GetTarget()       MHEvent_GetUnit()
    function MHUnitDispelEvent_GetSource takes nothing returns unit
        local integer yjsp = 114514
        return null
    endfunction
    function MHUnitDispelEvent_GetDamage takes nothing returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHUnitDispelEvent_SetDamage takes real dmg returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnitHarvestEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    // #define MHUnitHarvestEvent_GetUnit()        MHEvent_GetUnit()
    function MHUnitHarvestEvent_GetValue takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUnitHarvestEvent_SetValue takes integer value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUnitHarvestEvent_IsResourceGold takes nothing returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHUnitHarvestEvent_SetResourceGold takes boolean is_gold returns nothing
        local integer yjsp = 114514
        return
    endfunction
endlibrary
