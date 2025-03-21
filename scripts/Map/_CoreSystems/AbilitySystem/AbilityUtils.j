
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
    
    function GetAbilityTooltip takes ability whichAbility returns string
        return MHAbility_GetAbilityCustomLevelDataStr(whichAbility, GetAbilityLevel(whichAbility), ABILITY_LEVEL_DEF_DATA_TIP)
    endfunction
    function GetAbilityUberTooltip takes ability whichAbility returns string
        return MHAbility_GetAbilityCustomLevelDataStr(whichAbility, GetAbilityLevel(whichAbility), ABILITY_LEVEL_DEF_DATA_UBERTIP)
    endfunction
    function GetAbilityManaCost takes ability whichAbility returns integer
        return MHAbility_GetAbilityCustomLevelDataInt(whichAbility, GetAbilityLevel(whichAbility), ABILITY_LEVEL_DEF_DATA_MANA_COST)
    endfunction
    function GetAbilityCooldown takes ability whichAbility returns real
        return MHAbility_GetAbilityCustomLevelDataReal(whichAbility, GetAbilityLevel(whichAbility), ABILITY_LEVEL_DEF_DATA_COOLDOWN)
    endfunction



    function SetAbilityIconById takes integer abilId, string art returns nothing
        if StringLength(art) > 0 and MHString_Find(art, ".blp", 0) == - 1 then
            set art = art + ".blp"
        endif
        call MHAbility_SetDefDataStr(abilId, ABILITY_DEF_DATA_ART, art)
    endfunction
    function SetAbilityTooltipById takes integer abilId, integer level, string tooltip returns nothing
        call MHAbility_SetLevelDefDataStr(abilId, level, ABILITY_LEVEL_DEF_DATA_TIP, tooltip)
    endfunction
    function SetAbilityExtendedTooltipyId takes integer abilId, integer level, string extendedTooltip returns nothing
        call MHAbility_SetLevelDefDataStr(abilId, level, ABILITY_LEVEL_DEF_DATA_UBERTIP, extendedTooltip)
    endfunction



    function GetAbilityHotkeyById takes integer abilId returns integer
        return MHAbility_GetDefDataInt(abilId, ABILITY_DEF_DATA_HOTKEY)
    endfunction
    
    function GetAbilityIconById takes integer abilId returns string
        local string s = MHAbility_GetDefDataStr(abilId, ABILITY_DEF_DATA_ART)
        if StringLength(s) > 0 and MHString_Find(s, ".blp", 0) == - 1 then
            return s + ".blp"
        endif
        return s
    endfunction
    function GetAbilityResearchExtendedTooltipyId takes integer abilId returns string
        return MHAbility_GetDefDataStr(abilId, ABILITY_DEF_DATA_RESEARCH_UBERTIP)
    endfunction
    
    function GetAbilityTooltipById takes integer abilId, integer level returns string
        return MHAbility_GetLevelDefDataStr(abilId, level, ABILITY_LEVEL_DEF_DATA_TIP)
    endfunction
    function GetAbilityExtendedTooltipById takes integer abilId, integer level returns string
        return MHAbility_GetLevelDefDataStr(abilId, level, ABILITY_LEVEL_DEF_DATA_UBERTIP)
    endfunction
    function GetAbilityCooldownById takes integer abilId, integer level returns real
        return MHAbility_GetLevelDefDataReal(abilId, level, ABILITY_LEVEL_DEF_DATA_COOLDOWN)
    endfunction

    function GetAbilityStringFieldById takes integer abilId, integer whichField returns string
        return MHAbility_GetDefDataStr(abilId, whichField)
    endfunction
    function SetAbilityStringFieldById takes integer abilId, integer whichField, string value returns nothing
        call MHAbility_SetDefDataStr(abilId, whichField, value)
    endfunction
    function GetAbilityIntegerFieldById takes integer abilId, integer whichField returns integer
        return MHAbility_GetDefDataInt(abilId, whichField)
    endfunction
    function SetAbilityIntegerFieldById takes integer abilId, integer whichField, integer value returns nothing
        call MHAbility_SetDefDataInt(abilId, whichField, value)
    endfunction

    function GetAbilityStringLevelField takes ability whichAbility, integer level, integer filed returns string
        return MHAbility_GetAbilityCustomLevelDataStr(whichAbility, level, filed)
    endfunction
    function SetAbilityStringLevelField takes ability whichAbility, integer level, integer filed, string value returns nothing
        call MHAbility_SetAbilityCustomLevelDataStr(whichAbility, level, filed, value)
    endfunction
    function GetAbilityRealLevelField takes ability whichAbility, integer level, integer filed returns real
        return MHAbility_GetAbilityCustomLevelDataReal(whichAbility, level, filed)
    endfunction
    function SetAbilityRealLevelField takes ability whichAbility, integer level, integer filed, real value returns nothing
        call MHAbility_SetAbilityCustomLevelDataReal(whichAbility, level, filed, value)
    endfunction

    function GetAbilityStringLevelFieldById takes integer abilId, integer level, integer filed returns string
        return MHAbility_GetLevelDefDataStr(abilId, level, filed)
    endfunction
    function SetAbilityStringLevelFieldById takes integer abilId, integer level, integer filed, string value returns nothing
        call MHAbility_SetLevelDefDataStr(abilId, level, filed, value)
    endfunction
    function GetAbilityRealLevelFieldById takes integer abilId, integer level, integer filed returns real
        return MHAbility_GetLevelDefDataReal(abilId, level, filed)
    endfunction
    function SetAbilityRealLevelFieldById takes integer abilId, integer level, integer filed, real value returns nothing
        call MHAbility_SetLevelDefDataReal(abilId, level, filed, value)
    endfunction
    function GetAbilityIntegerLevelFieldById takes integer abilId, integer level, integer filed returns integer
        return MHAbility_GetLevelDefDataInt(abilId, level, filed)
    endfunction
    function SetAbilityIntegerLevelFieldById takes integer abilId, integer level, integer filed, integer value returns nothing
        call MHAbility_SetLevelDefDataInt(abilId, level, filed, value)
    endfunction

    function SetAbilityHotkeyById takes integer abilId, integer hotkey returns boolean
        local string  value
        local integer oldHotkey
        local integer maxLevel
        local integer pos
        local integer i
        local boolean success = false

        if hotkey < 'A' or hotkey > 'Z' then
            return false
        endif

        set maxLevel = GetAbilityIntegerFieldById(abilId, ABILITY_DEF_DATA_MAX_LEVEL)

        // 仅替换指定格式的快捷键 [|cffffcc00?|r]
        set oldHotkey = GetAbilityIntegerFieldById(abilId, ABILITY_DEF_DATA_HOTKEY)
        if oldHotkey != 0 and oldHotkey != hotkey then
            if maxLevel == 1 then
                set value = GetAbilityStringLevelFieldById(abilId, 1, ABILITY_LEVEL_DEF_DATA_TIP)
                set value = MHString_Replace(value, ("[|cffffcc00" + Key2Str(oldHotkey) + "|r]"), "[|cffffcc00" + Key2Str(hotkey) + "|r]")
                call SetAbilityStringLevelFieldById(abilId, 1, ABILITY_LEVEL_DEF_DATA_TIP, value)
            else
                set i = 1
                loop
                    exitwhen i > maxLevel
                    set value = GetAbilityStringLevelFieldById(abilId, i, ABILITY_LEVEL_DEF_DATA_TIP)
                    set value = MHString_Replace(value, ("[|cffffcc00" + Key2Str(oldHotkey) + "|r]"), "[|cffffcc00" + Key2Str(hotkey) + "|r]")
                    call SetAbilityStringLevelFieldById(abilId, i, ABILITY_LEVEL_DEF_DATA_TIP, value)
                    set i = i + 1
                endloop
            endif
            call SetAbilityIntegerFieldById(abilId, ABILITY_DEF_DATA_HOTKEY, hotkey)
            set success = true
        endif

        set oldHotkey = GetAbilityIntegerFieldById(abilId, ABILITY_DEF_DATA_RESEARCH_HOTKEY)
        if oldHotkey != 0 and oldHotkey != hotkey then
            // 学习提示
            set value = GetAbilityStringFieldById(abilId, ABILITY_DEF_DATA_RESEARCH_TIP)
            set value = MHString_Replace(value, ("[|cffffcc00" + Key2Str(oldHotkey) + "|r]"), "[|cffffcc00" + Key2Str(hotkey) + "|r]")
            call SetAbilityStringFieldById(abilId, ABILITY_DEF_DATA_RESEARCH_TIP, value)
            call SetAbilityIntegerFieldById(abilId, ABILITY_DEF_DATA_RESEARCH_HOTKEY, hotkey)
            set success = true
        endif

        return success
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
        // call BJDebugMsg(Id2String(GetAbilityBaseId(whichAbility)))
        if GetAbilityBaseId(whichAbility) == 'ANcl' then
            call MHAbility_SetAbilityCustomLevelDataReal(whichAbility, GetAbilityLevel(whichAbility), ABILITY_LEVEL_DEF_DATA_DATA_A, duration)
        endif
    endfunction

endlibrary
