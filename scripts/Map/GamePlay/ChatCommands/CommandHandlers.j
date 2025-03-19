scope CommandHandlers

    // 封装一层，以便显示改键信息
    private function SetAbilityHotkeyByIdEx takes integer abilId, integer hotkey returns boolean
        if SetAbilityHotkeyById(abilId, hotkey) then
            call DisplayTextToPlayer(LocalPlayer, 0, 0, "|cff6699CC修改技能|r|cffffa500\"" + GetObjectName(abilId) + "\"|r|cff6699CC的快捷键为|r" + "[|cffffcc00" + Key2Str(hotkey) + "|r]")
            return true
        else
            call PlayInterfaceErrorSound()
            call DisplayTextToPlayer(LocalPlayer, 0, 0, "|cffff0303修改技能|r" + GetObjectName(abilId) + "[|cffffcc00" + Key2Str(hotkey) + "|r]\"" +  "|r|cffff0303的快捷键失败。错误的快捷键参数，或是重复的快捷键。|r") 
        endif
        return false
    endfunction

    private function SetSkillHotkeyByIndex takes integer skillIndex, integer hotkey returns nothing
        local integer     scepterUpgradeIndex = GetScepterUpgradeIndexById(HeroSkill_BaseId[skillIndex])
        local ToggleSkill toggleSkillIndex    = ToggleSkill.GetIndexById(HeroSkill_BaseId[skillIndex])
        local boolean     success             = false
        if scepterUpgradeIndex > 0 then
            set success = SetAbilityHotkeyByIdEx(ScepterUpgrade_BaseId[scepterUpgradeIndex], hotkey)
            set success = SetAbilityHotkeyByIdEx(ScepterUpgrade_UpgradedId[scepterUpgradeIndex], hotkey) or success
        else
            set success = SetAbilityHotkeyByIdEx(HeroSkill_BaseId[skillIndex], hotkey)
        endif
        // 重新检查快捷键冲突
        if success then
            call CheckAbilityHotkeyConflictsById(HeroSkill_BaseId[skillIndex])
            if toggleSkillIndex > 0 then
                call SetAbilityHotkeyByIdEx(toggleSkillIndex.GetAlternateId(), hotkey)
            endif
        endif
    endfunction

    private function SetAbilityHotkeyBySlot takes integer skillIndex returns nothing
        local SubAbility sb
        local integer    i
        local integer    count
        local integer    hotkey
        local string     arg
        
        set arg = GetChatCommandArgAt(2)
        if arg != "#" then
            set hotkey = Str2Key(StringCase(arg, true))
            if hotkey < 'A' or hotkey > 'Z' then
                call InterfaceErrorForPlayer(GetLocalPlayer(), "错误的快捷键参数，快捷键的取值必须为26英文字母。")
            else
                call SetSkillHotkeyByIndex(skillIndex, hotkey)
            endif
        endif

        if GetChatCommandArgsCount() <= 2 then
            return
        endif

        set count = GetSkillSubAbilityCountByIndex(skillIndex)
        set i = 1
        loop
            exitwhen i > count
            set sb  = GetSkillSubAbilityByIndex(skillIndex, i)
            set arg = GetChatCommandArgAt(2 + i)

            if arg != "#" then
                set hotkey = Str2Key(StringCase(arg, true))
                call DisplayTextToPlayer(LocalPlayer, 0, 0, " ")

                if hotkey < 'A' or hotkey > 'Z' then
                    call InterfaceErrorForPlayer(GetLocalPlayer(), "错误的快捷键参数，快捷键的取值必须为26英文字母。")
                else
                    loop
                        call SetAbilityHotkeyByIdEx(sb.abilityId, hotkey)
                        
                        set sb = sb.next
                        exitwhen sb == 0
                    endloop
                endif
            endif

            set i = i + 1
        endloop
    endfunction
    
    function ChatCommand_SetAbilityHotkeyBySlot takes nothing returns nothing
        local player  whichPlayer = GetTriggerPlayer()
        local integer skillSlot
        local integer skillIndex
        
        // 纯异步指令
        if whichPlayer == GetLocalPlayer() then
            set skillSlot = S2I(GetChatCommandArgAt(1))
            if skillSlot < 1 or skillSlot > 6 then
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

    // 根据命令按钮面板插槽来改变快捷键
    function ChatCommand_SetSkillHotkeyByIndex takes nothing returns nothing
        local player  whichPlayer = GetTriggerPlayer()
        local integer skillSlot
        local integer skillIndex
        local integer skillButton
        local integer id

        local integer hotkey
        local string  arg
        local integer x
        local integer y

        // 纯异步指令
        if whichPlayer == GetLocalPlayer() then
            set skillSlot = S2I(GetChatCommandArgAt(1))
            if skillSlot < 1 or skillSlot > 12 then
                call InterfaceErrorForPlayer(whichPlayer, I2S(skillSlot) + " 不是有效的数值，第一个参数的取值范围为1~12。")
                return
            endif

            set x = 2 - ((skillSlot-1) / 4)
            set y = ModuloInteger((skillSlot-1), 4)

            set skillButton = MHUI_GetSkillBarButtonEx(y, x)
            set id          = MHUIData_GetCommandButtonAbility(skillButton)
            if id == 0 then
                call InterfaceErrorForPlayer(whichPlayer, "|cffffcc00没有该技能，技能按钮的位置为\n9 10 11 12\n5   6   7   8\n1   2   3   4\n|r")
                return
            endif
            set skillIndex  = GetSkillIndexById(id)
            // 如果有SkillIndex，则按hkey的规格进行改键
            if skillIndex != 0 then
                call SetAbilityHotkeyBySlot(skillIndex)
            else
                // 否则只是单纯改键
                set arg = GetChatCommandArgAt(2)
                if arg != "#" then
                    set hotkey = Str2Key(StringCase(arg, true))
                    if hotkey < 'A' or hotkey > 'Z' then
                        call InterfaceErrorForPlayer(GetLocalPlayer(), "错误的快捷键参数，快捷键的取值必须为26英文字母。")
                    else
                        call SetAbilityHotkeyByIdEx(id, hotkey)
                    endif
                endif

            endif
        endif
    endfunction

endscope
