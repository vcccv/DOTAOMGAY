
// 继续堆屎
library AbilityUtils requires Table, Base
    
    function GetAbilityId takes ability whichAbility returns integer
        return MHAbility_GetId(whichAbility)
    endfunction

    function GetAbilityBaseIdById takes integer abilId returns integer
        return MHAbility_GetDefDataInt(abilId, ABILITY_DEF_DATA_BASE_ID)
    endfunction

    function GetAbilityBaseId takes ability whichAbility returns integer
        return MHAbility_GetDefDataInt(GetAbilityId(whichAbility), ABILITY_DEF_DATA_BASE_ID)
    endfunction

    function GetAbilityReqLevelById takes integer abilId returns integer
        return MHAbility_GetDefDataInt(abilId, ABILITY_DEF_DATA_REQ_LEVEL)
    endfunction

    function IsUnitAbilityDisabled takes unit whichUnit, integer abilId returns boolean
        return MHAbility_GetDisableCount(whichUnit, abilId) > 0
    endfunction

    function IsUnitAbilityHidden takes unit whichUnit, integer abilId returns boolean
        return MHAbility_GetHideCount(whichUnit, abilId) > 0
    endfunction

    function IsUnitAbilityPassive takes unit whichUnit, integer abilId returns boolean
        local integer baseId = MHAbility_GetBaseId(whichUnit, abilId)
        if baseId == 0 then
            return false
        endif
        return MHGame_CheckInherit(baseId, 'APas')
    endfunction

    function IsAbilityPassiveById takes integer abilId returns boolean
        local integer baseId = GetAbilityBaseIdById(abilId)
        if baseId == 0 then
            return false
        endif
        return MHGame_CheckInherit(baseId, 'APas')
    endfunction

    function GetAbilitySourceItem takes ability whichAbility returns item
        return MHAbility_GetAbilitySourceItem(whichAbility)
    endfunction
    
    function IsAbilityFormItem takes ability whichAbility returns boolean
        return GetAbilitySourceItem(whichAbility) != null
    endfunction

    function GetAbilityMaxLevelById takes integer abilId returns integer
        return MHAbility_GetDefDataInt(abilId, ABILITY_DEF_DATA_MAX_LEVEL)
    endfunction

    // SpellEffect事件限定
    function SetAbilityCooldownInSpellEffect takes ability whichAbility, real cooldown returns nothing
        
    endfunction

    // SpellEffect事件限定, ANcl的dataA
    function SetAbilityANclCastDurationInSpellEffect takes ability whichAbility, real duration returns nothing
        call BJDebugMsg(Id2String(GetAbilityBaseId(whichAbility)))
        if GetAbilityBaseId(whichAbility) == 'ANcl' then
            call MHAbility_SetAbilityCustomLevelDataReal(whichAbility, GetAbilityLevel(whichAbility), ABILITY_LEVEL_DEF_DATA_DATA_A, duration)
        endif
    endfunction

endlibrary
