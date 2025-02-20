
library CommandButtonHelper requires PlayerChatUtils, ItemSystem

    globals
        private trigger SkillTrig
        private integer array SkillButton
    endglobals

    private function GetSkillButtonIndex takes integer skillButton returns integer
        local integer i = 1
        loop
            exitwhen i > 12
            if skillButton == SkillButton[i] then
                return i
            endif
            set i = i + 1
        endloop
        return 0
    endfunction

    globals
        constant string LEARN_SKILL_SELF_READY         = "我准备学习技能 > $abilityName$ [$abilityLevel$]"
        constant string LEARN_SKILL_SELF_REQUIRE_EXP   = "我还需要 |c00FFFF00$requireExp$|r 点经验才能学习 > $abilityName$ [$abilityLevel$]"
        constant string LEARN_SKILL_SELF_REQUIRE_LEVEL = "我还需要 |c00FFFF00$requireLevel$|r 级才能学习 > $abilityName$ [$abilityLevel$]"
   
        constant string LEARN_SKILL_ALLY_READY         = "$playerName$ ($heroName$) > 可以学习技能 > $abilityName$ [$abilityLevel$]"
        constant string LEARN_SKILL_ALLY_REQUIRE_EXP   = "$playerName$ ($heroName$) > 还需要 |c00FFFF00$requireExp$|r 点经验才能学习 > $abilityName$ [$abilityLevel$]"
        constant string LEARN_SKILL_ALLY_REQUIRE_LEVEL = "$playerName$ ($heroName$) > 还需要 |c00FFFF00$requireLevel$|r 级才能学习 > $abilityName$ [$abilityLevel$]"
    endglobals

    private function GetAbiiltyLevelSkip takes integer abilId returns integer
        local integer levelSkip = MHAbility_GetDefDataInt(abilId, ABILITY_DEF_DATA_LEVEL_SKIP) // MHSlk_ReadInt(SLK_TABLE_ABILITY, abilId, "levelSkip")
        if levelSkip <= 0 then
            return 2
        endif
        return levelSkip
    endfunction

    private function GetAbilityRequireLevel takes integer abilId returns integer
        local integer requireLevel = MHAbility_GetDefDataInt(abilId, ABILITY_DEF_DATA_REQ_LEVEL) // MHSlk_ReadInt(SLK_TABLE_ABILITY, abilId, "reqLevel")
        if requireLevel <= 0 then
            return 1
        endif
        return requireLevel
    endfunction

    // 计算这个技能要求的的等级 等级要求 + 下一级等级 * 跳级
    private function GetAbilityRequireLevelByLevel takes integer abilId, integer abilLevel returns integer
        return ( abilLevel - 1 ) * GetAbiiltyLevelSkip(abilId) + GetAbilityRequireLevel(abilId)
    endfunction

    // ping学习技能
    private function OnLearnSkillPing takes unit whichUnit, integer skillButton returns nothing
        local integer abilId       = MHUIData_GetCommandButtonOrderId(skillButton)
        local integer abilLevel
        local integer requireLevel
        local integer requireExp
        local integer playerId
        local string  msg          = null
        // 目标是敌人
        if IsUnitEnemy(whichUnit, GetLocalPlayer()) then
            return
        endif

        set abilLevel    = GetUnitAbilityLevel(whichUnit, abilId) + 1
        set requireLevel = GetAbilityRequireLevelByLevel(abilId, abilLevel) - GetHeroLevel(whichUnit)
        call BJDebugMsg("LevelSkip:" + I2S(GetAbiiltyLevelSkip(abilId))/*
        */ + " RequireLevel:" + I2S(GetAbilityRequireLevel(abilId))/*
        */ + " heroLevel:" + I2S(GetHeroLevel(whichUnit)))

        // ping自己
        if IsUnitOwnedByPlayer(whichUnit, GetLocalPlayer()) then
            if requireLevel <= 0 and GetHeroSkillPoints(whichUnit) > 0 then
                set msg = LEARN_SKILL_SELF_READY
                set msg = MHString_Replace(msg, "$abilityName$", GetObjectName(abilId))
                set msg = MHString_Replace(msg, "$abilityLevel$", I2S(abilLevel))
            elseif requireLevel <= 1 then
                set requireExp = MHHero_GetNeededExp(whichUnit, GetHeroLevel(whichUnit)) // ?
                set msg = LEARN_SKILL_SELF_REQUIRE_EXP
                set msg = MHString_Replace(msg, "$abilityName$", GetObjectName(abilId))
                set msg = MHString_Replace(msg, "$abilityLevel$", I2S(abilLevel))
                set msg = MHString_Replace(msg, "$requireExp$", I2S(requireExp))
            else
                set msg = LEARN_SKILL_SELF_REQUIRE_LEVEL
                set msg = MHString_Replace(msg, "$abilityName$", GetObjectName(abilId))
                set msg = MHString_Replace(msg, "$abilityLevel$", I2S(abilLevel))
                set msg = MHString_Replace(msg, "$requireLevel$", I2S(IMaxBJ(requireLevel, 1)))
            endif
        else
            // ping友军时
            set playerId = GetPlayerId(GetOwningPlayer(whichUnit))
            if requireLevel <= 0 and GetHeroSkillPoints(whichUnit) > 0 then
                set msg = LEARN_SKILL_ALLY_READY
                set msg = MHString_Replace(msg, "$playerName$", PlayerColoerHex[playerId] + PlayersName[playerId])
                set msg = MHString_Replace(msg, "$heroName$", GetObjectName(GetUnitTypeId(whichUnit)) + "|r")
                
                set msg = MHString_Replace(msg, "$abilityName$", GetObjectName(abilId))
                set msg = MHString_Replace(msg, "$abilityLevel$", I2S(abilLevel))
            elseif requireLevel <= 1 then
                set requireExp = MHHero_GetNeededExp(whichUnit, GetHeroLevel(whichUnit)) // ?
                set msg = LEARN_SKILL_ALLY_REQUIRE_EXP
                set msg = MHString_Replace(msg, "$playerName$", PlayerColoerHex[playerId] + PlayersName[playerId])
                set msg = MHString_Replace(msg, "$heroName$", GetObjectName(GetUnitTypeId(whichUnit)) + "|r")
                
                set msg = MHString_Replace(msg, "$abilityName$", GetObjectName(abilId))
                set msg = MHString_Replace(msg, "$abilityLevel$", I2S(abilLevel))
                set msg = MHString_Replace(msg, "$requireExp$", I2S(requireExp))
            else
                set msg = LEARN_SKILL_ALLY_REQUIRE_LEVEL
                set msg = MHString_Replace(msg, "$playerName$", PlayerColoerHex[playerId] + PlayersName[playerId])
                set msg = MHString_Replace(msg, "$heroName$", GetObjectName(GetUnitTypeId(whichUnit)) + "|r")
                
                set msg = MHString_Replace(msg, "$abilityName$", GetObjectName(abilId))
                set msg = MHString_Replace(msg, "$abilityLevel$", I2S(abilLevel))
                set msg = MHString_Replace(msg, "$requireLevel$", I2S(IMaxBJ(requireLevel, 1)))
            endif
        endif
        
        if msg != null then
            call PlayerChat.SendChatToAlliedPlayers(msg)
        endif
    endfunction

    private function OnPurchaseItemPing takes unit whichUnit, integer skillButton returns nothing
        local integer unitId            = MHUIData_GetCommandButtonOrderId(skillButton)
        local real    cooldownRemaining = MHUIData_GetCommandButtonCooldown(skillButton)
        local integer charges           = GetCommandButtonCharges(skillButton)


        call BJDebugMsg("当前unitId：" + Id2String(unitId) + " GetCommandButtonCharges:" + I2S()/*
        */ + " cooldown:" + R2S(cooldownRemaining))
    endfunction

    private function GetCommandButtonCharges takes integer commandButton returns integer
        return S2I(MHFrame_GetText(MHUIData_GetCommandButtonSubscriptText(commandButton)))
    endfunction

    private function OnAbilitiesPing takes integer skillButton returns nothing
        local unit    whichUnit = MHPlayer_GetSelectUnit()
        local integer abilId 
        local integer orderId
        local string  msg

        if whichUnit == null then
            return
        endif
        set abilId  = MHUIData_GetCommandButtonAbility(skillButton)
        set orderId = MHUIData_GetCommandButtonOrderId(skillButton)
        // MHUIData_GetCommandButtonCooldown
        call BJDebugMsg("当前abilId：" + Id2String(abilId) + " GetCommandButtonCharges:" + I2S(GetCommandButtonCharges(skillButton))/*
        */ + " cooldown:" + R2S(MHUIData_GetCommandButtonCooldown(skillButton)))
        if abilId == 'AHer' then
            call OnLearnSkillPing(whichUnit, skillButton)
        elseif abilId == 'Asud' or abilId == 'Asel' then // Asud是触发器添加的
            call OnPurchaseItemPing(whichUnit, skillButton)
        endif

        set whichUnit = null
    endfunction

    private function OnClickSkillButton takes nothing returns boolean
        local integer skillButton = MHEvent_GetFrame()

        if MHMsg_IsKeyDown(OSKEY_ALT) and MHEvent_GetKey() == 1 then
    
            call BJDebugMsg("当前按的：" + I2S(skillButton) + " index:" + I2S(GetSkillButtonIndex(skillButton)))
            call OnAbilitiesPing(skillButton)
            call MHEvent_SetKey(-1)

        endif

        return false
    endfunction

    function CommandButtonHelper_Init takes nothing returns nothing
        local integer slot
        local integer x
        local integer y
        local integer i

        set SkillTrig = CreateTrigger()
        call TriggerAddCondition(SkillTrig, Condition(function OnClickSkillButton))
        set i = 1
        loop
            exitwhen i > 12
            set SkillButton[i] = MHUI_GetSkillBarButton(i)
            call MHFrameEvent_Register(SkillTrig, SkillButton[i], EVENT_ID_FRAME_MOUSE_CLICK)
            set i = i + 1
        endloop
    endfunction

endlibrary

