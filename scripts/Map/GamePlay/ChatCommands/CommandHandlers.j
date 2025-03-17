scope CommandHandlers

    // 封装一层，以便显示改键信息
    private function SetAbilityHotkeyByIdEx takes integer abilId, integer hotkey returns nothing
        call SetAbilityHotkeyById(abilId, hotkey)
        call DisplayTextToPlayer(LocalPlayer, 0, 0, "修改技能" + GetObjectName(abilId) + "快捷键为" + "[|cffffcc00" + Key2Str(hotkey) + "|r]")
    endfunction

    private function SetSkillHotkeyByIndex takes integer skillIndex, integer hotkey returns nothing
        local integer     scepterUpgradeIndex = GetScepterUpgradeIndexById(HeroSkill_BaseId[skillIndex])
        local ToggleSkill toggleSkillIndex    = ToggleSkill.GetIndexById(HeroSkill_BaseId[skillIndex])
        if scepterUpgradeIndex > 0 then
            call SetAbilityHotkeyByIdEx(ScepterUpgrade_BaseId[scepterUpgradeIndex], hotkey)
            call SetAbilityHotkeyByIdEx(ScepterUpgrade_UpgradedId[scepterUpgradeIndex], hotkey)
        else
            call SetAbilityHotkeyByIdEx(HeroSkill_BaseId[skillIndex], hotkey)
        endif
        if toggleSkillIndex > 0 then
            call SetAbilityHotkeyByIdEx(toggleSkillIndex.GetAlternateId(), hotkey)
        endif
    endfunction

    private function SetAbilityHotkeyBySlot takes integer skillIndex returns nothing
        local SubAbility sb
        local integer    i
        local integer    count
        local integer    hotkey
        
        set hotkey = Str2Key(StringCase(GetChatCommandArgAt(2), true))
        if hotkey < 'A' or hotkey > 'Z' then
            call InterfaceErrorForPlayer(GetLocalPlayer(), "错误的快捷键参数，快捷键的取值必须为26英文字母。")
            return
        endif
        call SetSkillHotkeyByIndex(skillIndex, hotkey)

        set count = GetSkillSubAbilityCountByIndex(skillIndex)
        // call BJDebugMsg("skillIndex:" + I2S(skillIndex))
        // call BJDebugMsg("count:     " + I2S(count))
        set i = 1
        loop
            exitwhen i > count
            set sb = GetSkillSubAbilityByIndex(skillIndex, i)

            loop
                set hotkey = Str2Key(StringCase(GetChatCommandArgAt(2 + i), true))
                call SetAbilityHotkeyByIdEx(sb.abilityId, hotkey)
                
                set sb = sb.next
                exitwhen sb == 0
            endloop

            set i = i + 1
        endloop
    endfunction
    
    function ChatCommand_SetAbilityHotkeyBySlot takes nothing returns nothing
        local player  whichPlayer = GetTriggerPlayer()
        local integer skillSlot
        local integer skillIndex
        call BJDebugMsg("call!")
        // 纯异步指令
        if whichPlayer == GetLocalPlayer() then
            set skillSlot = S2I(GetChatCommandArgAt(1))
            if skillSlot <= 0 or skillSlot >= 7 then
                call InterfaceErrorForPlayer(whichPlayer, I2S(skillSlot) + " 不是有效的数值，第一个参数的取值范围为1~6。")
                return
            endif
            set skillIndex = GetPlayerSkillIndexBySolt(whichPlayer, skillSlot)
            if skillIndex == 0 then
                call InterfaceErrorForPlayer(whichPlayer, I2S(skillSlot) + " 号未被选择，请选择后重试。")
                return
            endif
            call SetAbilityHotkeyBySlot(skillIndex)
        endif
    endfunction

    function ChatCommand_SetSkillHotkeyByIndex takes nothing returns nothing

    endfunction

endscope
