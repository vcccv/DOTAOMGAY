
library SkillDraft requires SkillSystem
    
    function QHX takes integer i returns string
        if i == 1 then
            return "|c000042FFblue"
        elseif i == 2 then
            return "|c001ce6b9teal"
        elseif i == 3 then
            return "|c00540081purple"
        elseif i == 4 then
            return "|c00fffc01yellow"
        elseif i == 5 then
            return "|c00ff8000orange"
        elseif i == 7 then
            return "|c00e55bb0pink"
        elseif i == 8 then
            return "|c00959697gray"
        elseif i == 9 then
            return "|c007ebff1lightblue"
        elseif i == 10 then
            return "|c00106246darkgreen"
        elseif i == 11 then
            return "|c004e2a04brown"
        endif
        return ""
    endfunction
    
    function SetAbilityStringByMode takes unit u, integer id returns nothing
        if id == 'QP24' then
            if Mode__BalanceOff then
                call UnitAddAbility(u, id)
                call MHAbility_SetLevelDefDataStr('QP24', 1, ABILITY_LEVEL_DEF_DATA_UBERTIP, "有25%的概率连续施展两次法术|n|n输入|c00ff0505-mc|r 以查看自身能触发狗运的技能|n|n|c00fffc01神杖升级：让你另一个脑袋施放火焰爆轰。")
                call MHAbility_SetLevelDefDataStr('QP24', 2, ABILITY_LEVEL_DEF_DATA_UBERTIP, "有40%的概率连续施展两次法术；有20%的概率连续施展三次法术|n|n输入|c00ff0505-mc|r 以查看自身能触发狗运的技能|n|n|c00fffc01神杖升级：让你另一个脑袋施放火焰爆轰。")
                call MHAbility_SetLevelDefDataStr('QP24', 3, ABILITY_LEVEL_DEF_DATA_UBERTIP, "有50%的概率连续施展两次法术；有25%的概率连续施展三次法术；有12%的概率连续施展四次法术|n|n输入|c00ff0505-mc|r 以查看自身能触发狗运的技能|n|n|c00fffc01神杖升级：让你另一个脑袋施放火焰爆轰。")
                call MHAbility_SetDefDataStr('A088', ABILITY_DEF_DATA_RESEARCH_UBERTIP, "狗运让菊花能更快更有效地使用技能。|n|n|cffffcc00等级 1|r - 25%概率x2|n|cffffcc00等级 2|r - 40%概率x2，20%概率x3|n|cffffcc00等级 3|r - 50%概率x2，25%概率x3，12%概率x4|n|n输入|c00ff0505-mc|r 以查看自身能触发狗运的技能|n|n|c00fffc01神杖升级：让你另一个脑袋施放火焰爆轰。")
            endif
        endif
    endfunction

    // 异步函数 内有多层嵌套循环 小心字节码上限
    // 根据技能id检查是否有快捷键冲突的技能，并对玩家弹出提示
    function CheckAbilityHotkeyConflictsById takes integer abilityId returns nothing
        local SubAbility sb
        local SubAbility tempsb
        local integer    hotkey
        local integer    tempHotkey
        local integer    i

        local integer    baseSlot        = GetPlayerId(GetLocalPlayer()) * MAX_SKILL_SLOTS
        local integer    currentSlot

        local integer    tempId

        local integer    subAbilityCount
        local string     skillName
        local string     conflictTip

        local string     message = ""

        set hotkey = GetAbilityHotkeyById(abilityId)
        // 检查自身是否是子技能，如果是则有不同的头部提示
        set sb = SubAbility.GetIndexById(abilityId)
        if sb != 0 then
            set skillName = GetObjectName(HeroSkill_BaseId[sb.ownerIndex]) + " 第" + I2S(sb.index + 1) + "号技能 - " + GetObjectName(abilityId) + "[" + Key2Str(hotkey) + "]"
        else
            set skillName = GetObjectName(abilityId) + "[" + Key2Str(hotkey) + "]"
        endif

        // 先匹配自身
        set currentSlot = 1
        loop
            if PlayerSkillIndices[baseSlot + currentSlot] > 0 then
                set tempId     = HeroSkill_BaseId[PlayerSkillIndices[baseSlot + currentSlot]]
                set tempHotkey = GetAbilityHotkeyById(tempId)

                // 和目标同id时不计算
                if tempHotkey == hotkey and tempId != abilityId then
                    set message = message + "\n         " + GetObjectName(tempId) + "[" + Key2Str(tempHotkey) + "]"
                endif

                // 对比完了正常技能后，对比子技能
                set subAbilityCount = GetSkillSubAbilityCountByIndex(PlayerSkillIndices[baseSlot + currentSlot])
                if subAbilityCount > 0 then
                    set i = 1
                    loop
                        exitwhen i > subAbilityCount
                        set tempsb = GetSkillSubAbilityByIndex(PlayerSkillIndices[baseSlot + currentSlot], i)
                        // 同来源时同索引不计算 和目标同id时不计算
                        if not ( tempsb.ownerIndex == sb.ownerIndex and tempsb.index == sb.ownerIndex ) and sb.abilityId != abilityId then
                            set conflictTip = GetObjectName(tempId) + "[" + Key2Str(tempHotkey) + "]"
                            loop
                                set tempHotkey = GetAbilityHotkeyById(tempsb.abilityId)
                                if tempHotkey == hotkey then
                                    set message = message + "\n             " + conflictTip + " 第" + I2S(i + 1) + "号技能 - " + GetObjectName(tempsb.abilityId) + "[" + Key2Str(tempHotkey) + "]"
                                endif

                                set tempsb = tempsb.next
                                exitwhen tempsb == 0
                            endloop
                        endif
                        set i = i + 1
                    endloop
                endif

            endif
            set currentSlot = currentSlot + 1
        exitwhen (currentSlot > 4 + ExtraSkillsCount)
        endloop

        if StringLength(message) > 0 then
            set message = skillName + "快捷键冲突 : " + message
            call PlayInterfaceErrorSoundForPlayer(GetLocalPlayer(), true)
            call DisplayLoDTipForPlayer(GetLocalPlayer(), true, message)
        endif
    endfunction

    // 异步函数 内有多层嵌套循环 小心字节码上限
    // 根据SkillIndex检查是否有快捷键冲突的技能，并对玩家弹出提示
    function CheckAbilityHotkeyConflictsByIndex takes integer skillIndex returns nothing
        local integer    hotkey
        local integer    subAbilityCount
        local integer    i
        local string     skillName
        local SubAbility sb
        local integer    abilityId
        
        set abilityId = HeroSkill_BaseId[skillIndex]

        set hotkey = GetAbilityHotkeyById(abilityId)
        if hotkey != 0 then
            call CheckAbilityHotkeyConflictsById(abilityId)
        endif

        // 检查自身是否拥有子技能 如果有子技能，则去继续匹配
        set subAbilityCount = GetSkillSubAbilityCountByIndex(skillIndex)
        if subAbilityCount > 0 then
            set i = 1
            loop
                exitwhen i > subAbilityCount
                set sb = GetSkillSubAbilityByIndex(skillIndex, i)
                loop
                    set hotkey = GetAbilityHotkeyById(sb.abilityId)
                    if hotkey > 0 then
                        call CheckAbilityHotkeyConflictsById(sb.abilityId)
                    endif
                    set sb = sb.next
                    exitwhen sb == 0
                endloop
                
                set i = i + 1
            endloop
        endif
    endfunction
    
    private function SetShowSkillDatas takes integer skillSlot, integer skillIndex returns nothing
        local integer k
        local integer tempAbilityId = HeroSkill_BaseId[skillIndex]
        local integer hotkey
        local integer showSkillId
        
        set showSkillId = 'ZT00' + skillSlot -1
        set k = GetPassiveSkillIndexByLearnedId(tempAbilityId)

        set hotkey = GetAbilityIntegerFieldById(tempAbilityId, ABILITY_DEF_DATA_RESEARCH_HOTKEY)
        if PassiveSkill_Show[k] > 0 then
            call SetAbilityIconById(showSkillId, GetAbilityIconById(PassiveSkill_Show[k]))
        else
            call SetAbilityIconById(showSkillId, GetAbilityIconById(tempAbilityId))
        endif
        call SetAbilityStringFieldById(showSkillId, ABILITY_DEF_DATA_NAME, GetObjectName(tempAbilityId))
        if hotkey == 0 then
            call SetAbilityTooltipById(showSkillId, 1, GetObjectName(tempAbilityId))
        else
            call SetAbilityTooltipById(showSkillId, 1, GetObjectName(tempAbilityId) + "[|cffffcc00" + Key2Str(hotkey) + "|r]")
        endif
        call SetAbilityExtendedTooltipyId(showSkillId, 1, GetAbilityResearchExtendedTooltipyId(tempAbilityId))

        set showSkillId = 'ZT10' + skillSlot -1
        if hotkey == 0 then
            call SetAbilityTooltipById(showSkillId, 1, GetObjectName(tempAbilityId) + " - 额外信息")
        else
            call SetAbilityTooltipById(showSkillId, 1, GetObjectName(tempAbilityId) + "[|cffffcc00" + Key2Str(hotkey) + "|r]" + " - 额外信息")
        endif
        call SetAbilityStringFieldById(showSkillId, ABILITY_DEF_DATA_NAME, GetObjectName(tempAbilityId) + " - 额外信息")
    endfunction

    private function SetSkillExtraTipByIndex takes player whichPlayer, integer skillSlot, integer skillIndex returns boolean
        local integer showSkillId
        local string  value   = ""
        local boolean success = false
        set showSkillId = 'ZT10' + skillSlot -1

        if CheckSkillOrderIdByIndex(skillIndex, -1, "melee only", null) then

            if whichPlayer == GetLocalPlayer() then
                call SetAbilityIconById(showSkillId, "ReplaceableTextures\\PassiveButtons\\PASBTNCleavingAttack.blp")
                
                set value = "|c00FF8080近战限定|r\n"
                set value = value + "选择这个技能的话你将无法选择|c0080FF80远程限定|r和|c00FFFF00远程变身|r类技能。|n|n|c00FF0000你将只能选择近战英雄模型。|r"
                
                call SetAbilityExtendedTooltipyId(showSkillId, 1, value)
            endif
            
            set success = true
        elseif CheckSkillOrderIdByIndex(skillIndex, -1, "range only", null) then

            if whichPlayer == GetLocalPlayer() then
                call SetAbilityIconById(showSkillId, "ReplaceableTextures\\PassiveButtons\\PASBTNImpalingBolt.blp")
                
                set value = "|c00FF8080远程限定|r\n"
                set value = value + "选择这个技能的话你将无法选择|c00FF8080近战限定|r和|c00FF8000近战变身|r类技能。|n|n|c00FF0000你将只能选择远程英雄模型。|r"
                
                call SetAbilityExtendedTooltipyId(showSkillId, 1, value)
            endif

            set success = true
        elseif CheckSkillOrderIdByIndex(skillIndex, -1, "melee morph", null) then

            if whichPlayer == GetLocalPlayer() then
                call SetAbilityIconById(showSkillId, "ReplaceableTextures\\PassiveButtons\\PASBTNBash.blp")
            
                set value = "|c00FF8000近战变身|r\n"
                set value = value + "选择这个技能的话你将无法选择|c0080FF80远程限定|r和|c00FFFF00远程变身|r类技能。"
                
                call SetAbilityExtendedTooltipyId(showSkillId, 1, value)
            endif

            set success = true
        elseif CheckSkillOrderIdByIndex(skillIndex, -1, "range morph", null) then

            if whichPlayer == GetLocalPlayer() then
                call SetAbilityIconById(showSkillId, "ReplaceableTextures\\PassiveButtons\\PASBTNFlakCannons.blp")
            
                set value = "|c00FF8000远程变身|r\n"
                set value = value + "选择这个技能的话你将无法选择|c00FF8080近战限定|r和|c00FF8000近战变身|r类技能。"
                
                call SetAbilityExtendedTooltipyId(showSkillId, 1, value)
            endif

            set success = true
        endif

        if ( not Mode__BalanceOff and HeroSkill_BalanceOffDisabledTips[skillIndex] != null ) then
            if whichPlayer == GetLocalPlayer() then
                if value != "" then
                    set value = value + "\n\n"
                endif
                set value = value + "平衡改动(BO)：" + HeroSkill_BalanceOffDisabledTips[skillIndex]
                call SetAbilityExtendedTooltipyId(showSkillId, 1, value)
            endif
            
            set success = true
        endif
        if ( not Mode__RearmCombos and HeroSkill_RearmCombosDisabledTips[skillIndex] != null ) then
            if whichPlayer == GetLocalPlayer() then
                if value != "" then
                    set value = value + "\n\n"
                endif
                set value = value + "平衡改动(RC)：" + HeroSkill_RearmCombosDisabledTips[skillIndex]
                call SetAbilityExtendedTooltipyId(showSkillId, 1, value)
            endif
            
            set success = true
        endif
        if HeroSkill_Tips[skillIndex] != null then
            if whichPlayer == GetLocalPlayer() then
                if value != "" then
                    set value = value + "\n\n"
                endif
                set value = value + "注意：" + HeroSkill_Tips[skillIndex]
                call SetAbilityExtendedTooltipyId(showSkillId, 1, value)
            endif

            set success = true
        endif

        return success
    endfunction

    function SetSkillSubAbilityExtraTip takes player whichPlayer, integer skillSlot, integer skillIndex returns boolean
        local SubAbility sb
        local string     value
        local integer    abilityId
        local integer    subAbilityCount
        local integer    i
        local integer    hotkey

        set sb = GetSkillSubAbilityCountByIndex(skillIndex)
        if sb == 0 then
            return false
        endif

        if whichPlayer == GetLocalPlayer() then
            set abilityId = 'ZT10' + skillSlot -1

            set value = GetAbilityExtendedTooltipById(abilityId, 1)
            if value == "" then
                set value = "子技能："
            else
                set value = value + "\n\n子技能："
            endif

            set subAbilityCount = GetSkillSubAbilityCountByIndex(skillIndex)
            if subAbilityCount > 0 then
                set i = 1
                loop
                    exitwhen i > subAbilityCount
                    set sb = GetSkillSubAbilityByIndex(skillIndex, i)
                    loop
                        set hotkey = GetAbilityHotkeyById(sb.abilityId)
                        if hotkey != 0 then
                            set value = value + "\n第" + I2S(sb.index + 1) + "号子技能 - " + GetObjectName(sb.abilityId) + "[|cffffcc00" + Key2Str(hotkey) + "|r]"
                        else
                            set value = value + "\n第" + I2S(sb.index + 1) + "号子技能 - " + GetObjectName(sb.abilityId)
                        endif
                        set sb = sb.next
                        exitwhen sb == 0
                    endloop
                    
                    set i = i + 1
                endloop
            endif
            
            call SetAbilityExtendedTooltipyId(abilityId, 1, value)
        endif

        return true
    endfunction
    
    globals
        private integer array TempSkillIndices
    endglobals

    function PlayerPickHero takes unit heroUnit, integer playerId, unit tavernUnit returns nothing//酒馆英雄添加技能时
        local integer    startIndex = (GetUnitPointValue(heroUnit)* 4)-4
        local integer    currentSlot = 0
        local integer    teamId
        local integer    skillIndex1 = startIndex + 1
        local integer    skillIndex2 = startIndex + 2
        local integer    skillIndex3 = startIndex + 3
        local integer    skillIndex4 = startIndex + 4
        local integer    tempAbilityId = 0
        // 玩家是否拥有这个英雄
        local boolean    hasHero = true
        local integer    unitTypeId = GetUnitTypeId(heroUnit)
        local player     whichPlayer = Player(playerId)
        local SubAbility sb
        set TempSkillIndices[1] = startIndex + 1
        set TempSkillIndices[2] = startIndex + 2
        set TempSkillIndices[3] = startIndex + 3
        set TempSkillIndices[4] = startIndex + 4
        set PlayerNowPackedHeroIndex[playerId] = GetUnitPointValue(heroUnit)
        call RemoveUnit(heroUnit)
        call SetPlayerState( whichPlayer , PLAYER_STATE_RESOURCE_GOLD, GetPlayerState( whichPlayer , PLAYER_STATE_RESOURCE_GOLD) + 250 )
        
        if Mode__SingleDraft or Mode__MirrorDraft then
            set hasHero = LoadBoolean(HY, GetHandleId(whichPlayer), unitTypeId)
            if not hasHero then
                call DisplayLoDTipForPlayer(whichPlayer, true, "这些是你友军的技能，你无法选择他们。你的技能在 " + QHX(playerId) + "|c006699CC 酒馆|r")
            endif
        endif

        call FlushChildHashtable(HY, GetHandleId(PickSkillDummyUnit[playerId]))
        call RemoveUnit(PickSkillDummyUnit[playerId])
        set PickSkillDummyUnit[playerId] = CreateUnit(whichPlayer , 'hfoo', GetRectMaxX(bj_mapInitialPlayableArea), GetRectMinY(bj_mapInitialPlayableArea), .0)
        call SaveUnitHandle(HY, GetHandleId(PickSkillDummyUnit[playerId]), 0, tavernUnit)
        if LOD_DEBUGMODE then
            call DisplayTimedTextToPlayer(LocalPlayer, .0, .0, 20., "Hero Number: " + I2S(GetUnitPointValue(heroUnit)))
            call DisplayTimedTextToPlayer(LocalPlayer, .0, .0, 20., "Skill #1 number: " + I2S(skillIndex1))
            call DisplayTimedTextToPlayer(LocalPlayer, .0, .0, 20., "Skill #2 number: " + I2S(skillIndex2))
            call DisplayTimedTextToPlayer(LocalPlayer, .0, .0, 20., "Skill #3 number: " + I2S(skillIndex3))
            call DisplayTimedTextToPlayer(LocalPlayer, .0, .0, 20., "Skill #4 number: " + I2S(skillIndex4))
        endif
        if IsPlayerSentinel( whichPlayer ) then
            set teamId = 1
        else
            set teamId = 2
        endif
        set currentSlot = 1
        loop
            if not HeroSkill_Disabled[startIndex + currentSlot] then
                set tempAbilityId = HeroSkill_BaseId[startIndex + currentSlot]
                // set tempAbilityId = QGX(tempAbilityId)
            
                call SetAbilityStringByMode(PickSkillDummyUnit[playerId], tempAbilityId) 	//根据模式更改技能文本
                if GetLocalPlayer() == Player(playerId) then
                    call SetShowSkillDatas(currentSlot, startIndex + currentSlot)
                    call SetAbilityIconById('ZT10' + currentSlot -1, "ReplaceableTextures\\CommandButtons\\BTNManual2.blp")
                    call SetAbilityExtendedTooltipyId('ZT10' + currentSlot -1, 1, "")
                endif


                call UnitAddAbility(PickSkillDummyUnit[playerId], 'ZT00' + currentSlot -1)
                if SetSkillExtraTipByIndex(whichPlayer, currentSlot, startIndex + currentSlot) then
                    call UnitAddAbility(PickSkillDummyUnit[playerId], 'ZT10' + currentSlot -1)
                endif
                
                if SetSkillSubAbilityExtraTip(whichPlayer, currentSlot, startIndex + currentSlot) then
                    call UnitAddAbility(PickSkillDummyUnit[playerId], 'ZT10' + currentSlot -1)
                endif
                
                if hasHero then
                    if ( not IsPlayerSkillPickedByIndex( whichPlayer , TempSkillIndices[currentSlot]) ) then
                        if Mode__OneSkill then
                            if XP[teamId * OP + TempSkillIndices[currentSlot]] == 0 then
                                call UnitAddAbility(PickSkillDummyUnit[playerId], 'Z000' + currentSlot -1)
                            else
                                call UnitAddAbility(PickSkillDummyUnit[playerId], 'Z010' + currentSlot -1)
                            endif
                        else
                            call UnitAddAbility(PickSkillDummyUnit[playerId], 'Z000' + currentSlot -1)
                        endif
                    else
                        call UnitAddAbility(PickSkillDummyUnit[playerId], 'Z004' + currentSlot -1)
                    endif
                else
                    call UnitAddAbility(PickSkillDummyUnit[playerId], 'Z01A' + currentSlot -1)
                endif
            else
                if hasHero then
                    call UnitRemoveAbility(PickSkillDummyUnit[playerId], 'Z000'-1 + currentSlot)
                    call UnitAddAbility(PickSkillDummyUnit[playerId], 'Z014'-1 + currentSlot)
                endif
            endif
            set currentSlot = currentSlot + 1
        exitwhen currentSlot > 4
        endloop
        call ClearSelectionForPlayer( whichPlayer )
        call SelectUnitAddForPlayer(PickSkillDummyUnit[playerId],  whichPlayer )
    endfunction
    
    function OMR takes integer pid, integer slot, integer skillIndex returns nothing
        local multiboarditem mi
        local string s = HeroSkill_Icon[skillIndex]
        if LOD_DEBUGMODE then
            if IsPlayerScourge(Player(pid)) then
                set mi = MultiboardGetItem(JP,(pid + 2)-1, slot -1)
            else
                set mi = MultiboardGetItem(JP,(pid + 1)-1, slot -1)
            endif
        else
            set mi = MultiboardGetItem(JP, D2V[pid]-1, slot -1)
        endif
        if IsPlayerSentinel(Player(pid)) and Mode__SeeSkills == false then
            if IsPlayerScourge(LocalPlayer) then
                if skillIndex == 0 then
                    set s = HeroSkill_Icon[0]
                else
                    set s = "ReplaceableTextures\\CommandButtons\\BTNQuestion.blp"
                endif
            endif
        elseif IsPlayerScourge(Player(pid)) and Mode__SeeSkills == false then
            if IsPlayerSentinel(LocalPlayer) then
                if skillIndex == 0 then
                    set s = HeroSkill_Icon[0]
                else
                    set s = "ReplaceableTextures\\CommandButtons\\BTNQuestion.blp"
                endif
            endif
        endif
        call MultiboardSetItemIcon(mi, s)
        call MultiboardReleaseItem(mi)
        set mi = null
    endfunction
  
    function OQR takes integer pid returns boolean
        local integer id = 34 * 4 + 3
        local integer d = pid * MAX_SKILL_SLOTS
        if PlayerSkillIndices[d + 1] == id or PlayerSkillIndices[d + 2] == id or PlayerSkillIndices[d + 3] == id or PlayerSkillIndices[d + 4] == id or(ExtraSkillsCount >= 1 and PlayerSkillIndices[d + 5] == id) or(ExtraSkillsCount >= 2 and PlayerSkillIndices[d + 6] == id) then
            return true
        endif
        return false
    endfunction
    function OUR takes integer XQX returns boolean
        local integer i = 1
        loop
            if HeroListTypeId[XQX] == MeleeHeroList[i] then
                return true
            endif
            set i = i + 1
        exitwhen i > MeleeHeroMax
        endloop
        return false
    endfunction
    function SkillDraftOnPlayerPickSkill takes integer skillIndex, integer playerIndex, boolean throwMessage returns boolean
        local boolean isUltimate                = I2R(skillIndex / 4) == I2R(skillIndex) / 4.
        local boolean isPlayerReadying          = true
        // 不兼容的技能槽位
        local integer noStackSlot               = 0

        // 因为技能限制不能已经选择的同英雄槽位
        local integer skillLimit1Slot           = 0
        local integer skillLimit2Slot           = 0

        local integer xx                        = 0
        local integer teamId                    = 0
        local integer emptySlot                 = 0
        local integer ultimateEmptySlot         = 0
        local string  notStackMessage           = ""
        local integer targetSkillHeroIndex      = 0
        local integer startIndex                 = 0
        local boolean isPlayerReachedSkillLimit = false
        local boolean isTeamReachedSkillLimit   = false
        local player  whichPlayer               = Player(playerIndex)
        local boolean isMeleeMorph
        local boolean isRangeMorph
        local boolean isMeleeOnly
        local boolean isRangeOnly
        
        local integer baseSlot                 = playerIndex * MAX_SKILL_SLOTS
        // 控制技能的计数限制
        local integer maxCountLimit
        local unit    u
        if PlayerSkillIndices[baseSlot + 1] == skillIndex or PlayerSkillIndices[baseSlot + 2] == skillIndex or PlayerSkillIndices[baseSlot + 3] == skillIndex or PlayerSkillIndices[baseSlot + 4] == skillIndex or PlayerSkillIndices[baseSlot + 5] == skillIndex or PlayerSkillIndices[baseSlot + 6] == skillIndex then
            return false
        endif
        // 卡尔技能 虽然是在第四位，但却不是奥义
        if skillIndex == (116 -1)* 4 + 4 or skillIndex == (115 -1)* 4 + 4 or skillIndex == (114 -1)* 4 + 4 then
            set isUltimate = false
        endif

        if FP[playerIndex] then
            call DisplayLoDWarningForPlayer(whichPlayer, throwMessage, "你已经准备好了")
            return false
        endif
        if HeroSkill_Disabled[skillIndex] then
            call DisplayLoDWarningForPlayer(whichPlayer, throwMessage, "该技能无法被选择 :(")
            return false
        endif
        if Mode__DeathMatch or MainModeName =="ar" then
            if HeroSkill_IsDisabledInDeathMatch[skillIndex] then
                return false
            endif
        endif
        if Mode__OneSkill then
            if IsPlayerSentinel(whichPlayer) then
                set teamId = 1
            else
                set teamId = 2
            endif
            if XP[teamId * OP + skillIndex] != 0 then
                call DisplayLoDWarningForPlayer(whichPlayer, throwMessage, "一个玩家已经选择了这个技能: " + PlayerColorHex[XP[teamId * OP + skillIndex]] + PlayersName[XP[teamId * OP + skillIndex]] + "|r")
                return false
            endif
        endif
        set xx = 1
        loop
            if isUltimate then
                if xx == 4 or xx == 6 then
                    if PlayerSkillIndices[baseSlot + xx] == 0 then
                        set ultimateEmptySlot = xx
                        exitwhen true
                    endif
                endif
            else
                if not(xx == 4 or xx == 6) then
                    if PlayerSkillIndices[baseSlot + xx] == 0 then
                        set emptySlot = xx
                        exitwhen true
                    endif
                endif
            endif
            set xx = xx + 1
        exitwhen xx > 4 + ExtraSkillsCount
        endloop
        if ultimateEmptySlot == 0 and isUltimate then
            call DisplayLoDWarningForPlayer(whichPlayer, throwMessage, "你必须选择一个小技能（非最终技能）。")
            return false
        endif
        if emptySlot == 0 and not(isUltimate) then
            call DisplayLoDWarningForPlayer(whichPlayer, throwMessage, "你必须选择一个最终技能。")
            return false
        endif
        if Mode__RandomExtraAbilities then
            if PlayerSkillIndices[baseSlot + 5] == 0 and ExtraSkillsCount >= 1 then
                set emptySlot = 5
            endif
            if PlayerSkillIndices[baseSlot + 6] == 0 and ExtraSkillsCount >= 2 then
                set ultimateEmptySlot = 6
            endif
        endif
        set isMeleeOnly  = CheckSkillOrderIdByIndex(skillIndex, -1, "melee only", null)
        set isMeleeMorph = CheckSkillOrderIdByIndex(skillIndex, -1, "melee morph", null)
        set isRangeOnly  = CheckSkillOrderIdByIndex(skillIndex, -1, "range only", null)
        set isRangeMorph = CheckSkillOrderIdByIndex(skillIndex, -1, "range morph", null)
        if playerIndex == 0 then
            set u = LoadUnitHandle(HY, '0REA', '000U')
            if u != null then
                if OUR(GetUnitUserData(u)) then
                    if isRangeOnly then
                        set u = null
                        return false
                    endif
                else
                    if isMeleeOnly then
                        set u = null
                        return false
                    endif
                endif
            endif
        endif
        if isMeleeOnly or isMeleeMorph then
            set xx = 1
            loop
                if CheckSkillOrderIdByIndex(PlayerSkillIndices[baseSlot + xx], -1, "range only", null) or CheckSkillOrderIdByIndex(PlayerSkillIndices[baseSlot + xx], -1, "range morph", null) then
                    set noStackSlot = xx
                    if isMeleeMorph then
                        set notStackMessage = "你不能选择一个近战变身技能"
                    else
                        set notStackMessage = "你不能选择一个近战限定技能"
                    endif
                exitwhen true
                endif
                set xx = xx + 1
            exitwhen xx > 4 + ExtraSkillsCount
            endloop
            set xx = 1
            loop
                if CheckSkillOrderIdByIndex(PlayerSkillIndices[baseSlot + xx], skillIndex, null, "melee only") then
                    set noStackSlot = xx
                    set notStackMessage = "buggy/orderids"
                exitwhen true
                endif
                set xx = xx + 1
            exitwhen xx > 4 + ExtraSkillsCount
            endloop
        elseif isRangeOnly or isRangeMorph then
            set xx = 1
            loop
                if CheckSkillOrderIdByIndex(PlayerSkillIndices[baseSlot + xx], -1, "melee only", null) or CheckSkillOrderIdByIndex(PlayerSkillIndices[baseSlot + xx], -1, "melee morph", null) then
                    set noStackSlot = xx
                    if isRangeMorph then
                        set notStackMessage = "你不能选择一个远程变身技能"
                    else
                        set notStackMessage = "你不能选择一个远程限定技能"
                    endif
                exitwhen true
                endif
                set xx = xx + 1
            exitwhen xx > 4 + ExtraSkillsCount
            endloop
            set xx = 1
            loop
                if CheckSkillOrderIdByIndex(PlayerSkillIndices[baseSlot + xx], skillIndex, null, "range only") then
                    set noStackSlot = xx
                    set notStackMessage = "buggy/orderids"
                exitwhen true
                endif
                set xx = xx + 1
            exitwhen xx > 4 + ExtraSkillsCount
            endloop
        else
            set xx = 1
            loop
                if CheckSkillOrderIdByIndex(PlayerSkillIndices[baseSlot + xx], skillIndex, null, null) then
                    set noStackSlot = xx
                    set notStackMessage = "buggy/orderids"
                exitwhen true
                endif
                set xx = xx + 1
            exitwhen xx > 4 + ExtraSkillsCount
            endloop
        endif
        if HeroSkill_HasMultipleAbilities[skillIndex]and(Mode__FiveSkills or Mode__SixSkills) then
            call DisplayLoDTipForPlayerEx(whichPlayer, throwMessage, "注意：该技能是多图标技能。建议用命令改键来修改额外技能快捷键。")
        endif
        if skillIndex == (35 -1)* 4 + 3 then
            if IsPlayerSentinel(whichPlayer) then
                if OQR(GetPlayerId(SentinelPlayers[1])) or OQR(GetPlayerId(SentinelPlayers[2])) or OQR(GetPlayerId(SentinelPlayers[3])) or OQR(GetPlayerId(SentinelPlayers[4])) or OQR(GetPlayerId(SentinelPlayers[5])) then
                    call DisplayLoDWarningForPlayer(whichPlayer, throwMessage, "你的队友已经选择了这个技能，不能再选择一个了。")
                    return false
                endif
            else
                if OQR(GetPlayerId(ScourgePlayers[1])) or OQR(GetPlayerId(ScourgePlayers[2])) or OQR(GetPlayerId(ScourgePlayers[3])) or OQR(GetPlayerId(ScourgePlayers[4])) or OQR(GetPlayerId(ScourgePlayers[5])) then
                    call DisplayLoDWarningForPlayer(whichPlayer, throwMessage, "你的队友已经选择了这个技能，不能再选择一个了。")
                    return false
                endif
            endif
        endif
        if not Mode__BalanceOff then
            set maxCountLimit = 1
        else
            set maxCountLimit = 2
        endif
        // 是允许限制的技能
        if IsControlSkillByIndex(skillIndex) then
            set isPlayerReachedSkillLimit = GetControlSkillCountByPlayerId(playerIndex) >= maxCountLimit
            if not isPlayerReachedSkillLimit then
                if IsPlayerSentinel(whichPlayer) then
                    set isPlayerReachedSkillLimit = (GetControlSkillCountByPlayerId(GetPlayerId(SentinelPlayers[1])) + GetControlSkillCountByPlayerId(GetPlayerId(SentinelPlayers[2])) + GetControlSkillCountByPlayerId(GetPlayerId(SentinelPlayers[3])) + GetControlSkillCountByPlayerId(GetPlayerId(SentinelPlayers[4])) + GetControlSkillCountByPlayerId(GetPlayerId(SentinelPlayers[5])))>= 7
                else
                    set isPlayerReachedSkillLimit = (GetControlSkillCountByPlayerId(GetPlayerId(ScourgePlayers[1])) + GetControlSkillCountByPlayerId(GetPlayerId(ScourgePlayers[2])) + GetControlSkillCountByPlayerId(GetPlayerId(ScourgePlayers[3])) + GetControlSkillCountByPlayerId(GetPlayerId(ScourgePlayers[4])) + GetControlSkillCountByPlayerId(GetPlayerId(ScourgePlayers[5])))>= 7
                endif
                set isTeamReachedSkillLimit = isPlayerReachedSkillLimit
            endif
        endif
        if noStackSlot == 0 then
            if (Mode__LimitSkills) then
                if not isPlayerReachedSkillLimit then
                    set skillLimit1Slot = 0
                    set skillLimit2Slot = 0
                    set targetSkillHeroIndex = (skillIndex -1) / 4
                    set xx = 1
                    loop
                        if PlayerSkillIndices[baseSlot + xx] != 0 then
                            set startIndex = (PlayerSkillIndices[baseSlot + xx]-1) / 4
                            if (startIndex == targetSkillHeroIndex) then
                                if skillLimit1Slot == 0 then
                                    set skillLimit1Slot = xx
                                elseif Mode__LimitSkills3 then
                                    if skillLimit2Slot == 0 then
                                        set skillLimit2Slot = xx
                                    else
                                        set noStackSlot = xx
                                        set notStackMessage = "同一个英雄的技能不能超过3个"
                                        exitwhen true
                                    endif
                                else
                                    set noStackSlot = xx
                                    set notStackMessage = "同一个英雄的技能不能超过2个"
                                exitwhen true
                                endif
                            endif
                        endif
                        set xx = xx + 1
                    exitwhen(xx > 4 + ExtraSkillsCount) or(xx > 4 and Mode__RandomExtraAbilities)
                    endloop
                endif
            endif
        endif
        if noStackSlot != 0 then
            if notStackMessage != "" then
                if skillLimit2Slot != 0 then
                    call DisplayLoDWarningForPlayer(whichPlayer, throwMessage, "不兼容 : " + GetObjectName(HeroSkill_BaseId[PlayerSkillIndices[baseSlot + noStackSlot]]) + "/" + GetObjectName(HeroSkill_BaseId[PlayerSkillIndices[baseSlot + skillLimit1Slot]]) + "/" + GetObjectName(HeroSkill_BaseId[PlayerSkillIndices[baseSlot + skillLimit2Slot]]) + " (" + notStackMessage + ")")
                elseif skillLimit1Slot != 0 then
                    call DisplayLoDWarningForPlayer(whichPlayer, throwMessage, "不兼容 : " + GetObjectName(HeroSkill_BaseId[PlayerSkillIndices[baseSlot + noStackSlot]]) + "/" + GetObjectName(HeroSkill_BaseId[PlayerSkillIndices[baseSlot + skillLimit1Slot]]) + " (" + notStackMessage + ")")
                else
                    call DisplayLoDWarningForPlayer(whichPlayer, throwMessage, "不兼容 : " + GetObjectName(HeroSkill_BaseId[PlayerSkillIndices[baseSlot + noStackSlot]]) + " (" + notStackMessage + ")")
                endif
            else
                call DisplayLoDWarningForPlayer(whichPlayer, throwMessage, "不兼容 : " + GetObjectName(HeroSkill_BaseId[PlayerSkillIndices[baseSlot + noStackSlot]]))
            endif
            return false
        endif
        if isPlayerReachedSkillLimit then
            if not isTeamReachedSkillLimit then
                if maxCountLimit == 2 then
                    call DisplayLoDWarningForPlayer(whichPlayer, throwMessage, "不能选择该技能，你已经有2个控制技能了！")
                else
                    call DisplayLoDWarningForPlayer(whichPlayer, throwMessage, "不能选择该技能，你已经有1个控制技能了！")
                endif
            else
                call DisplayLoDWarningForPlayer(whichPlayer, throwMessage, "不能选择该技能，你的队伍已经选择7个控制技能了！")
            endif
            return false
        endif

        if throwMessage /*and GetAbilityHotkeyById(HeroSkill_BaseId[skillIndex]) > 0*/ then
            
            if whichPlayer == GetLocalPlayer() then
                // 异步检查快捷键并抛出错误 小心嵌套循环
                call CheckAbilityHotkeyConflictsByIndex(skillIndex)
            endif
            
        endif

        // if HaveSavedString(AbilityDataHashTable, HeroSkill_BaseId[skillIndex], HotKeyStringHash) then
        //     set xx = 1
        //     loop
        //         if PlayerSkillIndices[baseSlot + xx]> 0 and HaveSavedString(AbilityDataHashTable, HeroSkill_BaseId[PlayerSkillIndices[baseSlot + xx]], HotKeyStringHash) then
        //             if LoadStr(AbilityDataHashTable, HeroSkill_BaseId[skillIndex], HotKeyStringHash) == LoadStr(AbilityDataHashTable, HeroSkill_BaseId[PlayerSkillIndices[baseSlot + xx]], HotKeyStringHash) then
        //                 call DisplayLoDWarningForPlayer(whichPlayer, throwMessage, "快捷键冲突 : " + GetObjectName(HeroSkill_BaseId[PlayerSkillIndices[baseSlot + xx]]))
        //             endif
        //         endif
        //         set xx = xx + 1
        //     exitwhen(xx > 4 + ExtraSkillsCount)
        //     endloop
        // endif
        if isUltimate then
            set PlayerSkillIndices[baseSlot + ultimateEmptySlot] = skillIndex
            call OMR(playerIndex, ultimateEmptySlot, skillIndex)
        else
            set PlayerSkillIndices[baseSlot + emptySlot] = skillIndex
            call OMR(playerIndex, emptySlot, skillIndex)
        endif
        if Mode__OneSkill then
            if XP[teamId * OP + skillIndex] == 0 then
                set XP[teamId * OP + skillIndex] = playerIndex
            endif
        endif
        set xx = 1
        loop
            if PlayerSkillIndices[baseSlot + xx] == 0 then
                set isPlayerReadying = false
            exitwhen true
            endif
            set xx = xx + 1
        exitwhen xx > 4 + ExtraSkillsCount
        endloop
        set FP[playerIndex] = isPlayerReadying
        if isMeleeOnly then
            set PP[playerIndex] = 1
            call DisplayLoDTipForPlayer(whichPlayer, throwMessage, "注意：该技能是近战限定技能.")
        elseif isRangeOnly then
            set PP[playerIndex] = 2
            call DisplayLoDTipForPlayer(whichPlayer, throwMessage, "注意：该技能是远程限定技能.")
        endif
        if isMeleeMorph then
            call DisplayLoDTipForPlayer(whichPlayer, throwMessage, "注意：该技能是近战变身技能.")
        elseif isRangeMorph then
            call DisplayLoDTipForPlayer(whichPlayer, throwMessage, "注意：该技能是远程变身技能.")
        endif
        if ( not Mode__BalanceOff and HeroSkill_BalanceOffDisabledTips[skillIndex] != null ) then
            call DisplayLoDTipForPlayer(whichPlayer, throwMessage, "平衡改动(BO)：" + HeroSkill_BalanceOffDisabledTips[skillIndex]) // BalanceOff
        endif
        if ( not Mode__RearmCombos and HeroSkill_RearmCombosDisabledTips[skillIndex] != null ) then
            call DisplayLoDTipForPlayer(whichPlayer, throwMessage, "平衡改动(RC)：" + HeroSkill_RearmCombosDisabledTips[skillIndex]) // RearmCombos
        endif
        if HeroSkill_Tips[skillIndex] != null then
            call DisplayLoDTipForPlayer(whichPlayer, throwMessage, "注意：" + HeroSkill_Tips[skillIndex])
        endif
        return true
    endfunction
    
    function RDR takes nothing returns nothing
        local integer pid = GetPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))
        local integer index = (PlayerNowPackedHeroIndex[pid]* 4)-4
        local integer slot
        local integer xx
        local integer RFR
        if not((GetSpellAbilityId()>='Z000' and GetSpellAbilityId()<='Z003') or(GetSpellAbilityId()>='Z010' and GetSpellAbilityId()<='Z013')) then
            return
        endif
        if GetSpellAbilityId()=='Z000' or GetSpellAbilityId()=='Z010' then
            set index = index + 1
            set slot = 1
        elseif GetSpellAbilityId()=='Z001' or GetSpellAbilityId()=='Z011' then
            set index = index + 2
            set slot = 2
        elseif GetSpellAbilityId()=='Z002' or GetSpellAbilityId()=='Z012' then
            set index = index + 3
            set slot = 3
        elseif GetSpellAbilityId()=='Z003' or GetSpellAbilityId()=='Z013' then
            set index = index + 4
            set slot = 4
        else
            return
        endif
        if not SkillDraftOnPlayerPickSkill(index, pid, true) then
            return
        endif
        if IsPlayerSkillPickedByIndex(Player(pid), index) then
            call UnitRemoveAbility(PickSkillDummyUnit[pid],('Z000'-1) + slot)
            call UnitAddAbility(PickSkillDummyUnit[pid],('Z004'-1) + slot)
            if Mode__OneSkill then
                set xx = 1
                loop
                    if IsPlayerSentinel(Player(pid)) then
                        set RFR = GetPlayerId(SentinelPlayers[xx])
                    else
                        set RFR = GetPlayerId(ScourgePlayers[xx])
                    endif
                    if GetUnitAbilityLevel(PickSkillDummyUnit[RFR], HeroSkill_BaseId[index])> 0 and pid != RFR and GetUnitAbilityLevel(PickSkillDummyUnit[RFR], 'Z000'-1 + slot)> 0 then
                        call UnitRemoveAbility(PickSkillDummyUnit[RFR],('Z000'-1) + slot)
                        call UnitAddAbility(PickSkillDummyUnit[RFR],('Z010'-1) + slot)
                    endif
                    set xx = xx + 1
                exitwhen xx > 5
                endloop
            endif
        endif
        if FP[pid] then
            call ExecuteFunc("SQO")
        endif
    endfunction
endlibrary
