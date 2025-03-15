
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
    
    //快捷键整数转字符串
    function Key2Str takes integer key returns string
        local string s = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        local integer i = key - 65
        if key > 64 and key < 91 then
            return SubString(s, i , i + 1)
         endif
          return null
    endfunction
    
    //快捷键字符串转整数
    function Str2Key takes string key returns integer
        local string s = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        local integer i = 65
        local integer b = 0
        set key = StringCase(key , true)
        loop
        exitwhen i > 90
            if key == SubString(s, b , b + 1) then
                return i
            endif
            set i = i + 1
            set b = b + 1
        endloop
          return 0
    endfunction

    function GetSkillHotkeyByIndex takes integer skillIndex returns integer
        local integer id           = HeroSkill_BaseId[skillIndex]
        local integer passiveIndex = GetPassiveSkillIndexByLearnedId(id)
        if passiveIndex > 0 and PassiveSkill_Learned[passiveIndex]> 0 then
            set id = PassiveSkill_Learned[passiveIndex]
        endif
        return GetAbilityHotkeyById(id)
    endfunction

    private function CheckAbility takes player whichPlayer, integer id, integer hotkey1, string skillName returns nothing
        local SubAbility sb
        local SubAbility sb2
        local integer    hotkey2

        local integer    j
        local integer    i
        local integer    k

        local integer    baseSlot = GetPlayerId(whichPlayer) * MAX_SKILL_SLOTS
        local integer    currentSlot
        local integer    subAbilityCount
        local string     skillName2
        local string     message = ""

        // 先匹配自身
        set currentSlot = 1
        loop
            if PlayerSkillIndices[baseSlot + currentSlot] > 0 then
                set hotkey2 = GetSkillHotkeyByIndex(PlayerSkillIndices[baseSlot + currentSlot])
                if hotkey2 == hotkey1 then
                    set message = message + "\n    " + GetObjectName(HeroSkill_BaseId[PlayerSkillIndices[baseSlot + currentSlot]]) + "[" + Key2Str(hotkey2) + "]"
                endif
                // 对比完了正常技能后，对比子技能
                set subAbilityCount = GetSkillSubAbilityCountByIndex(PlayerSkillIndices[baseSlot + currentSlot])
                call BJDebugMsg("subAbilityCount:" + I2S(subAbilityCount))
                if subAbilityCount > 0 then
                    set i = 1
                    loop
                        exitwhen i > subAbilityCount
                        set sb = GetSkillSubAbilityByIndex(PlayerSkillIndices[baseSlot + currentSlot], i)
                        set skillName2 = GetObjectName(HeroSkill_BaseId[PlayerSkillIndices[baseSlot + currentSlot]]) + "[" + Key2Str(hotkey2) + "]"
                        loop
                            set hotkey2 = GetAbilityHotkeyById(sb.abilityId)
                            if hotkey2 == hotkey1 then
                                set message = message + "\n    " + skillName2 + " 第" + I2S(i + 1) + "号技能：" + GetObjectName(sb.abilityId) + "[" + Key2Str(hotkey2) + "]"
                                
                                //call DisplayLoDErrorForPlayer(whichPlayer, true, "快捷键冲突 : " + /*
                                //*/ skillName + "/" + /*
                                //*/ GetObjectName(sb.abilityId) + "[" + Key2Str(hotkey2) + "]")
                            endif
                            set sb = sb.next
                            exitwhen sb == 0
                        endloop
                        set i = i + 1
                    endloop
                endif
            endif
            set currentSlot = currentSlot + 1
        exitwhen (currentSlot > 4 + ExtraSkillsCount)
        endloop
        if StringLength(message) > 0 then
            call DisplayLoDErrorForPlayer(whichPlayer, true, skillName + "快捷键冲突 : " + message)
        endif
    endfunction

    private function ThrowSkillHotkeyWarning takes player whichPlayer, integer skillIndex returns nothing
        local integer hotkey1
        local integer subAbilityCount
        local integer i
        local string     skillName
        local SubAbility sb
        set hotkey1 = GetSkillHotkeyByIndex(skillIndex)
        if hotkey1 > 0 then
            set skillName = GetObjectName(HeroSkill_BaseId[skillIndex]) + "[" + Key2Str(hotkey1) + "]"
            call CheckAbility(whichPlayer, HeroSkill_BaseId[skillIndex], hotkey1, skillName)
        else
            set skillName = GetObjectName(HeroSkill_BaseId[skillIndex])
        endif
        
        // 检查自身是否拥有子技能 如果有子技能，则去继续匹配
        set subAbilityCount = GetSkillSubAbilityCountByIndex(skillIndex)
        if subAbilityCount > 0 then
            set i = 1
            loop
                exitwhen i > subAbilityCount
                set sb = GetSkillSubAbilityByIndex(skillIndex, i)
                loop
                    set hotkey1 = GetAbilityHotkeyById(sb.abilityId)
                    if hotkey1 > 0 then
                        call CheckAbility(whichPlayer, sb.abilityId, hotkey1, /*
                        */ skillName + " 第" + I2S(i + 1) + "号技能：" + GetObjectName(sb.abilityId) + "[" + Key2Str(hotkey1) + "]")
                    endif
                    set i = i + 1
                    set sb = sb.next
                    exitwhen sb == 0
                endloop
            endloop
        endif
        // set hotkey

        // if  then
        // endif

        //if GetSkillSubAbilityCountByIndex(skillIndex) > 0 then
        //    GetSkillSubAbilityByIndex(skillIndex, 1)
        //endif
        // call DisplayLoDErrorForPlayer(whichPlayer, throwMessage, "快捷键冲突 : " + GetObjectName(HeroSkill_BaseId[PlayerSkillIndices[baseSlot + xx]]))
    endfunction
    
    function SetShowSkillDatas takes integer showSkillId, integer skillIndex returns nothing
        local integer k
        local integer tempAbilityId = HeroSkill_BaseId[skillIndex]
        local integer hotkey
        set k = GetPassiveSkillIndexByLearnedId(tempAbilityId)
        if k > 0 and PassiveSkill_Learned[k]> 0 then
            set tempAbilityId = PassiveSkill_Learned[k]
        endif
        set hotkey = GetAbilityHotkeyById(tempAbilityId)
        if PassiveSkill_Learned[k]> 0 then
            call SetAbilityIconById(showSkillId, GetAbilityIconById(PassiveSkill_Show[k]))
        else
            call SetAbilityIconById(showSkillId, GetAbilityIconById(tempAbilityId))
        endif
        if hotkey == 0 then
            call SetAbilityTooltipById(showSkillId, 1, GetObjectName(tempAbilityId))
        else
            call SetAbilityTooltipById(showSkillId, 1, GetObjectName(tempAbilityId) + "[|cffffcc00" + Key2Str(hotkey) + "|r]")
        endif
        call SetAbilityExtendedTooltipyId(showSkillId, 1, GetAbilityResearchExtendedTooltipyId(tempAbilityId))
    endfunction
    
    function PlayerPickHero takes unit u, integer playerId, unit QKX returns nothing//酒馆英雄添加技能时
        local integer heroIndex = (GetUnitPointValue(u)* 4)-4
        local integer xx = 0
        local integer teamId
        local integer TXE = heroIndex + 1
        local integer TOE = heroIndex + 2
        local integer QMX = heroIndex + 3
        local integer QPX = heroIndex + 4
        local integer tempAbilityId = 0
        local integer array QSX
        local boolean QTX = true
        local integer unitTypeId = GetUnitTypeId(u)
        local player whichPlayer = Player(playerId)
        set QSX[1] = heroIndex + 1
        set QSX[2] = heroIndex + 2
        set QSX[3] = heroIndex + 3
        set QSX[4] = heroIndex + 4
        set PlayerNowPackedHeroIndex[playerId] = GetUnitPointValue(u)
        call RemoveUnit(u)
        call SetPlayerState( whichPlayer , PLAYER_STATE_RESOURCE_GOLD, GetPlayerState( whichPlayer , PLAYER_STATE_RESOURCE_GOLD) + 250 )
        if Mode__SingleDraft or Mode__MirrorDraft then
            set QTX = LoadBoolean(HY, GetHandleId( whichPlayer ), unitTypeId)
            if not QTX then
                call DisplayLoDWarningForPlayer(whichPlayer, true, "这些是你友军的技能，你无法选择他们。你的技能在 " + QHX(playerId) + "|c006699CC 酒馆|r")
            endif
        endif
        call FlushChildHashtable(HY, GetHandleId(KP[playerId]))
        call RemoveUnit(KP[playerId])
        set KP[playerId] = CreateUnit( whichPlayer ,'hfoo', GetRectMaxX(bj_mapInitialPlayableArea), GetRectMinY(bj_mapInitialPlayableArea), .0)
        call SaveUnitHandle(HY, GetHandleId(KP[playerId]), 0, QKX)
        if LOD_DEBUGMODE then
            call DisplayTimedTextToPlayer(LocalPlayer, .0, .0, 20., "Hero Number: " + I2S(GetUnitPointValue(u)))
            call DisplayTimedTextToPlayer(LocalPlayer, .0, .0, 20., "Skill #1 number: " + I2S(TXE))
            call DisplayTimedTextToPlayer(LocalPlayer, .0, .0, 20., "Skill #2 number: " + I2S(TOE))
            call DisplayTimedTextToPlayer(LocalPlayer, .0, .0, 20., "Skill #3 number: " + I2S(QMX))
            call DisplayTimedTextToPlayer(LocalPlayer, .0, .0, 20., "Skill #4 number: " + I2S(QPX))
        endif
        if IsPlayerSentinel( whichPlayer ) then
            set teamId = 1
        else
            set teamId = 2
        endif
        set xx = 1
        loop
            if HeroSkill_Disabled[heroIndex + xx] == false then
                set tempAbilityId = HeroSkill_BaseId[heroIndex + xx]
                // set tempAbilityId = QGX(tempAbilityId)
            
                call SetAbilityStringByMode(KP[playerId], tempAbilityId) 	//根据模式更改技能文本
    
                if GetLocalPlayer() == Player(playerId) then
                    call SetShowSkillDatas('ZT00'+ xx -1, heroIndex + xx)
                endif
                
                call UnitAddAbility(KP[playerId], 'ZT00'+ xx -1)
    
                //call UnitAddAbility(KP[playerId], tempAbilityId)
                // if not HeroSkill_IsPassive[heroIndex + xx] and HeroSkill_SpecialId[heroIndex + xx] != 0 then
                // 	// 预读神杖技能
                // 	call UnitAddAbility(KP[playerId], HeroSkill_SpecialId[heroIndex + xx])
                // 	call UnitRemoveAbility(KP[playerId], HeroSkill_SpecialId[heroIndex + xx])
                // 	//call SingleDebug( "预读 " + I2S(xx) + " 号神杖升级技能 " + GetObjectName( HeroSkill_SpecialId[heroIndex + xx] ) )
                // endif
                //if not Mode__RearmCombos then
                //endif
                call SetUnitAbilityLevel(KP[playerId], tempAbilityId, 4)
                if CheckSkillOrderIdByIndex(heroIndex + xx, -1, "melee only", null) then
                    call UnitAddAbility(KP[playerId],'Z020'+ xx -1)
                elseif CheckSkillOrderIdByIndex(heroIndex + xx, -1, "range only", null) then
                    call UnitAddAbility(KP[playerId],'Z024'+ xx -1)
                elseif CheckSkillOrderIdByIndex(heroIndex + xx, -1, "melee morph", null) then
                    call UnitAddAbility(KP[playerId],'Z030'+ xx -1)
                elseif CheckSkillOrderIdByIndex(heroIndex + xx, -1, "range morph", null) then
                    call UnitAddAbility(KP[playerId],'Z034'+ xx -1)
                endif
                if QTX then
                    if ( not IsPlayerSkillPickedByIndex( whichPlayer , QSX[xx]) ) then
                        if Mode__OneSkill then
                            if XP[teamId * OP + QSX[xx]] == 0 then
                                call UnitAddAbility(KP[playerId],'Z000'+ xx -1)
                            else
                                call UnitAddAbility(KP[playerId],'Z010'+ xx -1)
                            endif
                        else
                            call UnitAddAbility(KP[playerId],'Z000'+ xx -1)
                        endif
                    else
                        call UnitAddAbility(KP[playerId],'Z004'+ xx -1)
                    endif
                else
                    call UnitAddAbility(KP[playerId],'Z01A'+ xx -1)
                endif
            else
                if QTX then
                    call UnitRemoveAbility(KP[playerId],'Z000'-1 + xx)
                    call UnitAddAbility(KP[playerId],'Z014'-1 + xx)
                endif
            endif
            set xx = xx + 1
        exitwhen xx > 4
        endloop
        call ClearSelectionForPlayer( whichPlayer )
        call SelectUnitAddForPlayer(KP[playerId],  whichPlayer )
    endfunction
    
    function OMR takes integer pid, integer slot, integer T0V returns nothing
        local multiboarditem mi
        local string s = HeroSkill_Icon[T0V]
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
                if T0V == 0 then
                    set s = HeroSkill_Icon[0]
                else
                    set s = "ReplaceableTextures\\CommandButtons\\BTNQuestion.blp"
                endif
            endif
        elseif IsPlayerScourge(Player(pid)) and Mode__SeeSkills == false then
            if IsPlayerSentinel(LocalPlayer) then
                if T0V == 0 then
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
        local integer heroIndex                 = 0
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
            call DisplayLoDErrorForPlayer(whichPlayer, throwMessage, "你已经准备好了")
            return false
        endif
        if HeroSkill_Disabled[skillIndex] then
            call DisplayLoDErrorForPlayer(whichPlayer, throwMessage, "该技能无法被选择 :(")
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
                call DisplayLoDErrorForPlayer(whichPlayer, throwMessage, "一个玩家已经选择了这个技能: " + PlayerColorHex[XP[teamId * OP + skillIndex]] + PlayersName[XP[teamId * OP + skillIndex]] + "|r")
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
            call DisplayLoDErrorForPlayer(whichPlayer, throwMessage, "你必须选择一个小技能（非最终技能）。")
            return false
        endif
        if emptySlot == 0 and not(isUltimate) then
            call DisplayLoDErrorForPlayer(whichPlayer, throwMessage, "你必须选择一个最终技能。")
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
            set u = LoadUnitHandle(HY,'0REA','000U')
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
            call DisplayLoDWarningForPlayerEx(whichPlayer, throwMessage, "注意：该技能是多图标技能。建议用命令改键来修改额外技能快捷键。")
        endif
        if skillIndex == (35 -1)* 4 + 3 then
            if IsPlayerSentinel(whichPlayer) then
                if OQR(GetPlayerId(SentinelPlayers[1])) or OQR(GetPlayerId(SentinelPlayers[2])) or OQR(GetPlayerId(SentinelPlayers[3])) or OQR(GetPlayerId(SentinelPlayers[4])) or OQR(GetPlayerId(SentinelPlayers[5])) then
                    call DisplayLoDErrorForPlayer(whichPlayer, throwMessage, "你的队友已经选择了这个技能，不能再选择一个了。")
                    return false
                endif
            else
                if OQR(GetPlayerId(ScourgePlayers[1])) or OQR(GetPlayerId(ScourgePlayers[2])) or OQR(GetPlayerId(ScourgePlayers[3])) or OQR(GetPlayerId(ScourgePlayers[4])) or OQR(GetPlayerId(ScourgePlayers[5])) then
                    call DisplayLoDErrorForPlayer(whichPlayer, throwMessage, "你的队友已经选择了这个技能，不能再选择一个了。")
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
                            set heroIndex = (PlayerSkillIndices[baseSlot + xx]-1) / 4
                            if (heroIndex == targetSkillHeroIndex) then
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
                    call DisplayLoDErrorForPlayer(whichPlayer, throwMessage, "不兼容 : " + GetObjectName(HeroSkill_BaseId[PlayerSkillIndices[baseSlot + noStackSlot]]) + "/" + GetObjectName(HeroSkill_BaseId[PlayerSkillIndices[baseSlot + skillLimit1Slot]]) + "/" + GetObjectName(HeroSkill_BaseId[PlayerSkillIndices[baseSlot + skillLimit2Slot]]) + " (" + notStackMessage + ")")
                elseif skillLimit1Slot != 0 then
                    call DisplayLoDErrorForPlayer(whichPlayer, throwMessage, "不兼容 : " + GetObjectName(HeroSkill_BaseId[PlayerSkillIndices[baseSlot + noStackSlot]]) + "/" + GetObjectName(HeroSkill_BaseId[PlayerSkillIndices[baseSlot + skillLimit1Slot]]) + " (" + notStackMessage + ")")
                else
                    call DisplayLoDErrorForPlayer(whichPlayer, throwMessage, "不兼容 : " + GetObjectName(HeroSkill_BaseId[PlayerSkillIndices[baseSlot + noStackSlot]]) + " (" + notStackMessage + ")")
                endif
            else
                call DisplayLoDErrorForPlayer(whichPlayer, throwMessage, "不兼容 : " + GetObjectName(HeroSkill_BaseId[PlayerSkillIndices[baseSlot + noStackSlot]]))
            endif
            return false
        endif
        if isPlayerReachedSkillLimit then
            if not isTeamReachedSkillLimit then
                if maxCountLimit == 2 then
                    call DisplayLoDErrorForPlayer(whichPlayer, throwMessage, "不能选择该技能，你已经有2个控制技能了！")
                else
                    call DisplayLoDErrorForPlayer(whichPlayer, throwMessage, "不能选择该技能，你已经有1个控制技能了！")
                endif
            else
                call DisplayLoDErrorForPlayer(whichPlayer, throwMessage, "不能选择该技能，你的队伍已经选择7个控制技能了！")
            endif
            return false
        endif

        if throwMessage /*and GetAbilityHotkeyById(HeroSkill_BaseId[skillIndex]) > 0*/ then
            
            call ThrowSkillHotkeyWarning(whichPlayer, skillIndex)


        endif

        // if HaveSavedString(AbilityDataHashTable, HeroSkill_BaseId[skillIndex], HotKeyStringHash) then
        //     set xx = 1
        //     loop
        //         if PlayerSkillIndices[baseSlot + xx]> 0 and HaveSavedString(AbilityDataHashTable, HeroSkill_BaseId[PlayerSkillIndices[baseSlot + xx]], HotKeyStringHash) then
        //             if LoadStr(AbilityDataHashTable, HeroSkill_BaseId[skillIndex], HotKeyStringHash) == LoadStr(AbilityDataHashTable, HeroSkill_BaseId[PlayerSkillIndices[baseSlot + xx]], HotKeyStringHash) then
        //                 call DisplayLoDErrorForPlayer(whichPlayer, throwMessage, "快捷键冲突 : " + GetObjectName(HeroSkill_BaseId[PlayerSkillIndices[baseSlot + xx]]))
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
            call DisplayLoDWarningForPlayer(whichPlayer, throwMessage, "注意：该技能是近战限定技能.")
        elseif isRangeOnly then
            set PP[playerIndex] = 2
            call DisplayLoDWarningForPlayer(whichPlayer, throwMessage, "注意：该技能是远程限定技能.")
        endif
        if isMeleeMorph then
            call DisplayLoDWarningForPlayer(whichPlayer, throwMessage, "注意：该技能是近战变身技能.")
        elseif isRangeMorph then
            call DisplayLoDWarningForPlayer(whichPlayer, throwMessage, "注意：该技能是远程变身技能.")
        endif
        if ( not Mode__BalanceOff and HeroSkill_BalanceOffDisabledTips[skillIndex] != null ) then
            call DisplayLoDWarningForPlayer(whichPlayer, throwMessage, "平衡改动(BO)：" + HeroSkill_BalanceOffDisabledTips[skillIndex]) // BalanceOff
        endif
        if ( not Mode__RearmCombos and HeroSkill_RearmCombosDisabledTips[skillIndex] != null ) then
            call DisplayLoDWarningForPlayer(whichPlayer, throwMessage, "平衡改动(RC)：" + HeroSkill_RearmCombosDisabledTips[skillIndex]) // RearmCombos
        endif
        if HeroSkill_Tips[skillIndex] != null then
            call DisplayLoDWarningForPlayer(whichPlayer, throwMessage, "注意：" + HeroSkill_Tips[skillIndex])
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
            call UnitRemoveAbility(KP[pid],('Z000'-1) + slot)
            call UnitAddAbility(KP[pid],('Z004'-1) + slot)
            if Mode__OneSkill then
                set xx = 1
                loop
                    if IsPlayerSentinel(Player(pid)) then
                        set RFR = GetPlayerId(SentinelPlayers[xx])
                    else
                        set RFR = GetPlayerId(ScourgePlayers[xx])
                    endif
                    if GetUnitAbilityLevel(KP[RFR], HeroSkill_BaseId[index])> 0 and pid != RFR and GetUnitAbilityLevel(KP[RFR],'Z000'-1 + slot)> 0 then
                        call UnitRemoveAbility(KP[RFR],('Z000'-1) + slot)
                        call UnitAddAbility(KP[RFR],('Z010'-1) + slot)
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
