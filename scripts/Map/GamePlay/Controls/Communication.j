library Communication requires PlayerChatUtils, ItemSystem, UnitAbility

    globals
        private trigger SkillTrig
        private trigger ItemTrig

        private integer array ItemButton
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

    private function GetItemButtonIndex takes integer itemButton returns integer
        local integer i = 1
        loop
            exitwhen i > 6
            if itemButton == ItemButton[i] then
                return i
            endif
            set i = i + 1
        endloop
        return 0
    endfunction

    private function GetCommandButtonCharges takes integer commandButton returns integer
        local integer pCommandButtonData = ReadRealMemory(commandButton + 0x190)
        if pCommandButtonData == 0 then
            return 0
        endif
        // local integer commandButtonSubscriptText = MHUIData_GetCommandButtonSubscriptText(commandButton)
        // if MHFrame_IsHidden(MHUIData_GetCommandButtonSubscriptFrame(commandButton)) then
        //     return 0
        // endif
        return ReadRealMemory(pCommandButtonData + 0x5C0) //(MHFrame_GetText(commandButtonSubscriptText))
    endfunction

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

    private function GetUnitNameColored takes unit whichUnit returns string
        return PlayerColorHex[GetPlayerId(GetOwningPlayer(whichUnit))] + GetObjectName(GetUnitTypeId(whichUnit)) + "|r"
    endfunction


    globals
        constant string LEARN_SKILL_SELF_READY         = "我准备学习技能 > $abilityName$（$abilityLevel$级）"
        constant string LEARN_SKILL_SELF_REQUIRE_EXP   = "我还需要|cFFFFFF00$requireExp$|r点经验才能学习 > $abilityName$（$abilityLevel$级）"
        constant string LEARN_SKILL_SELF_REQUIRE_LEVEL = "我还需要升$requireLevel$级才能学习 > $abilityName$（$abilityLevel$级）"

        constant string LEARN_SKILL_ALLY_READY         = "队友$heroName$ > 可以学习技能 > $abilityName$（$abilityLevel$级）"
        constant string LEARN_SKILL_ALLY_REQUIRE_EXP   = "队友$heroName$ > 还需要|cFFFFFF00$requireExp$|r点经验才能学习 > $abilityName$（$abilityLevel$级）"
        constant string LEARN_SKILL_ALLY_REQUIRE_LEVEL = "队友$heroName$ > 还需要升$requireLevel$级才能学习 > $abilityName$（$abilityLevel$级）"
    endglobals

    // ping学习技能
    private function OnLearnSkillPing takes unit whichUnit, integer skillButton returns nothing
        local integer abilId       = MHUIData_GetCommandButtonOrderId(skillButton)
        local integer abilLevel
        local integer requireLevel
        local integer requireExp
        local string  msg          = null
        local integer skillPoints
        // 目标是敌人
        if IsUnitEnemy(whichUnit, GetLocalPlayer()) then
            return
        endif

        set abilLevel    = GetUnitAbilityLevel(whichUnit, abilId) + 1
        set requireLevel = GetAbilityRequireLevelByLevel(abilId, abilLevel) - GetHeroLevel(whichUnit)
        //call BJDebugMsg("LevelSkip:" + I2S(GetAbiiltyLevelSkip(abilId))/*
        //*/ + " RequireLevel:" + I2S(GetAbilityRequireLevel(abilId))/*
        //*/ + " heroLevel:" + I2S(GetHeroLevel(whichUnit)))
        // call BJDebugMsg("abilId:" + Id2String(abilId))

        // ping自己
        if IsUnitOwnedByPlayer(whichUnit, GetLocalPlayer()) then
            set skillPoints = GetHeroSkillPoints(whichUnit)
            if requireLevel <= 0 and skillPoints > 0 then
                set msg = LEARN_SKILL_SELF_READY
                set msg = MHString_Replace(msg, "$abilityName$", GetObjectName(abilId))
                set msg = MHString_Replace(msg, "$abilityLevel$", I2S(abilLevel))
            elseif requireLevel <= 1 then
                set requireExp = MHHero_GetNeededExp(whichUnit, GetHeroLevel(whichUnit))
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
            if requireLevel <= 0 and GetHeroSkillPoints(whichUnit) > 0 then
                set msg = LEARN_SKILL_ALLY_READY
                set msg = MHString_Replace(msg, "$heroName$", GetUnitNameColored(whichUnit))
                
                set msg = MHString_Replace(msg, "$abilityName$", GetObjectName(abilId))
                set msg = MHString_Replace(msg, "$abilityLevel$", I2S(abilLevel))
            elseif requireLevel <= 1 then
                set requireExp = MHHero_GetNeededExp(whichUnit, GetHeroLevel(whichUnit)) // ?
                set msg = LEARN_SKILL_ALLY_REQUIRE_EXP
                set msg = MHString_Replace(msg, "$heroName$", GetUnitNameColored(whichUnit))
                
                set msg = MHString_Replace(msg, "$abilityName$", GetObjectName(abilId))
                set msg = MHString_Replace(msg, "$abilityLevel$", I2S(abilLevel))
                set msg = MHString_Replace(msg, "$requireExp$", I2S(requireExp))
            else
                set msg = LEARN_SKILL_ALLY_REQUIRE_LEVEL
                set msg = MHString_Replace(msg, "$heroName$", GetUnitNameColored(whichUnit))
                
                set msg = MHString_Replace(msg, "$abilityName$", GetObjectName(abilId))
                set msg = MHString_Replace(msg, "$abilityLevel$", I2S(abilLevel))
                set msg = MHString_Replace(msg, "$requireLevel$", I2S(IMaxBJ(requireLevel, 1)))
            endif
        endif
        
        if msg != null then
            call PlayerChat.SendChatToAlliedPlayers(msg)
        endif
    endfunction

    globals
        constant string PURCHASE_COOLDOWN          = "（$cooldown$秒后可以购买）"
        constant string PURCHASE_SELF_READY        = "我准备出 > $itemName$"
        constant string PURCHASE_ALLY_PING         = "我觉得需要出 > $itemName$"

        constant string PURCHASE_SELF_REQUIRE_GOLD = "我打算购买物品 > $itemName$ (|cFFFFFF00$goldCost$|r) > 还需要$requireGold$黄金"
    endglobals

    // 去掉|n后面的内容
    private function GetItemNameById takes integer itemId returns string
        local string  name = GetObjectName(itemId)
        local integer pos  = MHString_Find(name, "|n", 0)
        return MHString_Sub(name, 0, pos)
    endfunction

    private function GetTimeString takes real time returns string
        local integer m     = R2I(time / 60)
        local integer s     = R2I(time - (60 * m))
        local real    minis = time - (60 * m) - s
        local string  ms
        local string  ss
        set ms = I2S(m)
        if m < 10 then
            set ms = "0" + ms
        endif
        set ss = I2S(s)
        if s < 10 then
            set ss = "0"+ss
        endif
        return ms + ":" + ss
    endfunction

    // 库存 > 1 时显示
    private function OnPurchasePing takes unit whichUnit, integer skillButton returns nothing
        local integer id                = MHUIData_GetCommandButtonOrderId(skillButton)
        local real    cooldownRemaining = MHUIData_GetCommandButtonCooldown(skillButton)
        local integer charges           = GetCommandButtonCharges(skillButton)
        local string  itemName
        local string  msg               = null

        // call BJDebugMsg("当前id：" + Id2String(id) + " GetCommandButtonCharges:" + I2S(charges)/*
        // */ + " cooldown:" + R2S(cooldownRemaining))

        set itemName = GetItemNameById(id)
        if cooldownRemaining > 0. and charges == 0 then
            // 带冷却的物品时
            if MHMsg_IsKeyDown(OSKEY_CONTROL) then
                set msg = PURCHASE_ALLY_PING + MHString_Replace(PURCHASE_COOLDOWN, "$cooldown$", GetTimeString(cooldownRemaining))
                set msg = MHString_Replace(msg, "$itemName$", itemName)
            else
                set msg = PURCHASE_SELF_READY + MHString_Replace(PURCHASE_COOLDOWN, "$cooldown$", GetTimeString(cooldownRemaining))
                set msg = MHString_Replace(msg, "$itemName$", itemName)
            endif
        else
            // 给队友建议
            if MHMsg_IsKeyDown(OSKEY_CONTROL) then
                set msg = PURCHASE_ALLY_PING
                set msg = MHString_Replace(msg, "$itemName$", itemName)
            else
                set msg = PURCHASE_SELF_READY
                set msg = MHString_Replace(msg, "$itemName$", itemName)
            endif
        endif

        if msg != null then
            call PlayerChat.SendChatToAlliedPlayers(msg)
        endif
    endfunction

    globals
        constant string SKILL_POINTS_SELF_REDAY        = "我还有$skillPoints$技能点未使用"
        constant string SKILL_POINTS_SELF_REQUIRE_EXP  = "我没有技能点了，|cFFFFFF00$requireExp$|r点经验才能升到下一级"

        constant string SKILL_POINTS_ALLY_REDAY        = "队友$heroName$ > 还有$skillPoints$技能点未使用"
        constant string SKILL_POINTS_ALLY_REQUIRE_EXP  = "队友$heroName$ > 没有技能点了，|cFFFFFF00$requireExp$|r点经验才能升到下一级"
    endglobals

    private function OnSkillPointsPing takes unit whichUnit returns nothing
        local string  msg               = null
        local integer skillPoints
        set skillPoints = GetHeroSkillPoints(whichUnit)
        if IsUnitOwnedByPlayer(whichUnit, GetLocalPlayer()) then
            if skillPoints > 0 then
                set msg = SKILL_POINTS_SELF_REDAY
                set msg = MHString_Replace(msg, "$skillPoints$", I2S(skillPoints))
            else
                set msg = SKILL_POINTS_SELF_REQUIRE_EXP
                set msg = MHString_Replace(msg, "$requireExp$", I2S(MHHero_GetNeededExp(whichUnit, GetHeroLevel(whichUnit))))
            endif
        else
            if skillPoints > 0 then
                set msg = SKILL_POINTS_ALLY_REDAY
                set msg = MHString_Replace(msg, "$heroName$", GetUnitNameColored(whichUnit))
                set msg = MHString_Replace(msg, "$skillPoints$", I2S(skillPoints))
            else
                set msg = SKILL_POINTS_ALLY_REQUIRE_EXP
                set msg = MHString_Replace(msg, "$heroName$", GetUnitNameColored(whichUnit))
                set msg = MHString_Replace(msg, "$requireExp$", I2S(MHHero_GetNeededExp(whichUnit, GetHeroLevel(whichUnit))))
            endif
        endif
        if msg != null then
            call PlayerChat.SendChatToAlliedPlayers(msg)
        endif
    endfunction
    
    globals
        constant string LEVEL_ABILITY_SELF_DISABLED         = "$abilityName$（$abilityLevel$级） > 已被禁用"
        constant string LEVEL_ABILITY_SELF_READY            = "$abilityName$（$abilityLevel$级） > 准备就绪"
        constant string LEVEL_ABILITY_SELF_REQUIRE_COOLDOWN = "$abilityName$（$abilityLevel$级） > 冷却中（还剩$cooldown$秒）"
        constant string LEVEL_ABILITY_SELF_REQUIRE_MANA     = "$abilityName$（$abilityLevel$级） > 魔法不足（还需要$manaCost$点）"

        constant string ABILITY_SELF_DISABLED               = "$abilityName$ > 已被禁用"
        constant string ABILITY_SELF_READY                  = "$abilityName$ > 准备就绪"
        constant string ABILITY_SELF_REQUIRE_COOLDOWN       = "$abilityName$ > 冷却中（还剩$cooldown$秒）"
        constant string ABILITY_SELF_REQUIRE_MANA           = "$abilityName$ > 魔法不足（还需要$manaCost$点）"

        constant string ABILITY_ALLY_PING             = "队友$heroName$ > "
        constant string ABILITY_CHARGES               = " > 能量点数：$charges$"
    endglobals

    private function OnAbilitiesPing takes unit whichUnit, integer skillButton returns nothing
        local integer abilId            = MHUIData_GetCommandButtonAbility(skillButton)
        local integer abilLevel         = GetUnitAbilityLevel(whichUnit, abilId)
        local real    cooldownRemaining = MHUIData_GetCommandButtonCooldown(skillButton)
        local integer manaCost          = MHUIData_GetCommandButtonManaCost(skillButton)
        local integer charges           = GetCommandButtonCharges(skillButton)
        local string  msg               = null

        // ping队友时在前面加上
        if not IsUnitOwnedByPlayer(whichUnit, GetLocalPlayer()) then
            set msg = MHString_Replace(ABILITY_ALLY_PING, "$heroName$", GetUnitNameColored(whichUnit))
        endif

        if cooldownRemaining > 0. then
            // 冷却中
            if GetAbilityIntegerFieldById(abilId, ABILITY_DEF_DATA_MAX_LEVEL) > 1 then
                set msg = msg + LEVEL_ABILITY_SELF_REQUIRE_COOLDOWN
            else
                set msg = msg + ABILITY_SELF_REQUIRE_COOLDOWN
            endif
            set msg = MHString_Replace(msg, "$abilityName$", GetAbilityStringFieldById(abilId, ABILITY_DEF_DATA_NAME))
            set msg = MHString_Replace(msg, "$abilityLevel$", I2S(abilLevel))
            set msg = MHString_Replace(msg, "$cooldown$", I2S(R2I(cooldownRemaining + 1.)))
        elseif manaCost > GetUnitState(whichUnit, UNIT_STATE_MANA) then
            // 魔法不足
            if GetAbilityIntegerFieldById(abilId, ABILITY_DEF_DATA_MAX_LEVEL) > 1 then
                set msg = msg + LEVEL_ABILITY_SELF_REQUIRE_MANA
            else
                set msg = msg + ABILITY_SELF_REQUIRE_MANA
            endif
            set msg = MHString_Replace(msg, "$abilityName$", GetAbilityStringFieldById(abilId, ABILITY_DEF_DATA_NAME))
            set msg = MHString_Replace(msg, "$abilityLevel$", I2S(abilLevel))
            set msg = MHString_Replace(msg, "$manaCost$", I2S(R2I(manaCost * 1. - GetUnitState(whichUnit, UNIT_STATE_MANA))))
        elseif IsUnitAbilityDisabled(whichUnit, abilId) then
            // 被禁用了
            if GetAbilityIntegerFieldById(abilId, ABILITY_DEF_DATA_MAX_LEVEL) > 1 then
                set msg = msg + LEVEL_ABILITY_SELF_DISABLED
            else
                set msg = msg + ABILITY_SELF_DISABLED
            endif
            set msg = MHString_Replace(msg, "$abilityName$", GetAbilityStringFieldById(abilId, ABILITY_DEF_DATA_NAME))
            set msg = MHString_Replace(msg, "$abilityLevel$", I2S(abilLevel))
        else
            // 准备就绪
            if GetAbilityIntegerFieldById(abilId, ABILITY_DEF_DATA_MAX_LEVEL) > 1 then
                set msg = msg + LEVEL_ABILITY_SELF_READY
            else
                set msg = msg + ABILITY_SELF_READY
            endif
            set msg = MHString_Replace(msg, "$abilityName$", GetAbilityStringFieldById(abilId, ABILITY_DEF_DATA_NAME))
            set msg = MHString_Replace(msg, "$abilityLevel$", I2S(abilLevel))
        endif

        // 技能充能
        if charges > 0 then
            set msg = msg + MHString_Replace(ABILITY_CHARGES, "$charges$", I2S(charges))
        endif

        if msg != null then
            call PlayerChat.SendChatToAlliedPlayers(msg)
        endif
    endfunction
    
    globals
        constant string TOWN_PORTAL_SCROLL_SELF_DISABLED = "我没带$itemName$"
        constant string TOWN_PORTAL_SCROLL_ALLY_DISABLED = "没带$itemName$"
        
        constant string ITEM_SELF_READY            = "$itemName$ > 准备就绪"
        constant string ITEM_SELF_REQUIRE_COOLDOWN = "$itemName$ > 冷却中（还剩$cooldown$秒）"
        constant string ITEM_SELF_REQUIRE_MANA     = "$itemName$ > 魔法不足（还需要$manaCost$点）"

        constant string ITEM_ALLY_PING             = "队友$heroName$ > "
        constant string ITEM_ENEMY_PING            = "敌人$heroName$身上有 > $itemName$"
        constant string ITEM_CHARGES               = " > 能量点数：$charges$"
    endglobals
    // Inventory INVENTORY
    private function OnInventoryPing takes unit whichUnit, item whichItem, integer skillButton returns nothing
        local integer abilId            
        local real    cooldownRemaining
        local integer manaCost         
        local integer charges          
        local string  itemName
        local string  msg              

        if whichUnit == null or whichItem == null then
            return
        endif

        if MHUnit_GetShopTarget(whichUnit, GetLocalPlayer()) != null then
            set whichUnit = MHUnit_GetShopTarget(whichUnit, GetLocalPlayer())
        endif

        set itemName          = GetItemNameById(GetItemTypeId(whichItem))
        set cooldownRemaining = MHUIData_GetCommandButtonCooldown(skillButton)
        set manaCost          = MHUIData_GetCommandButtonManaCost(skillButton)
        set charges           = GetCommandButtonCharges(skillButton)
        set msg               = null

        // call BJDebugMsg(I2S(GetHandleId(whichItem)) + " : " + itemName)
        if IsUnitAlly(whichUnit, GetLocalPlayer()) then
            // ping队友时在前面加上
            if not IsUnitOwnedByPlayer(whichUnit, GetLocalPlayer()) then
                set msg = MHString_Replace(ITEM_ALLY_PING, "$heroName$", GetUnitNameColored(whichUnit))
            endif

            if cooldownRemaining > 0. then
                // 冷却中
                set msg = msg + ITEM_SELF_REQUIRE_COOLDOWN
                set msg = MHString_Replace(msg, "$itemName$", itemName)
                set msg = MHString_Replace(msg, "$cooldown$", I2S(R2I(cooldownRemaining + 1.)))
            elseif manaCost > GetUnitState(whichUnit, UNIT_STATE_MANA) then
                // 魔法不足
                set msg = msg + ITEM_SELF_REQUIRE_MANA
                set msg = MHString_Replace(msg, "$itemName$", itemName)
                set msg = MHString_Replace(msg, "$manaCost$", I2S(R2I(manaCost * 1. - GetUnitState(whichUnit, UNIT_STATE_MANA))))
            else
                // 准备就绪
                set msg = msg + ITEM_SELF_READY
                set msg = MHString_Replace(msg, "$itemName$", itemName)
            endif
        else
            // ping敌人时
            set msg = msg + ITEM_ENEMY_PING
            set msg = MHString_Replace(msg, "$heroName$", GetUnitNameColored(whichUnit))
            set msg = MHString_Replace(msg, "$itemName$", itemName)
        endif

        // 技能充能
        if charges > 0 then
            set msg = msg + MHString_Replace(ITEM_CHARGES, "$charges$", I2S(charges))
        endif

        if msg != null then
            call PlayerChat.SendChatToAlliedPlayers(msg)
        endif
    endfunction

    public function OnTownPortalScrollPing takes unit whichUnit, ability whichAbility, integer charges returns nothing
        local integer abilId            
        local real    cooldownRemaining
        local integer manaCost
        local string  itemName
        local string  msg              

        if whichUnit == null or whichAbility == null then
            return
        endif

        set abilId            = GetAbilityId(whichAbility)
        set cooldownRemaining = GetAbilityCooldownRemaining(whichAbility)
        set manaCost          = GetAbilityManaCost(whichAbility)
        set msg               = null

        if IsUnitAlly(whichUnit, GetLocalPlayer()) then
            // ping队友时在前面加上
            if not IsUnitOwnedByPlayer(whichUnit, GetLocalPlayer()) then
                set msg = MHString_Replace(ITEM_ALLY_PING, "$heroName$", GetUnitNameColored(whichUnit))
            endif

            if cooldownRemaining > 0. then
                // 冷却中
                set msg = msg + ITEM_SELF_REQUIRE_COOLDOWN
                set msg = MHString_Replace(msg, "$itemName$", GetObjectName(abilId))
                set msg = MHString_Replace(msg, "$cooldown$", I2S(R2I(cooldownRemaining + 1.)))
            elseif manaCost > GetUnitState(whichUnit, UNIT_STATE_MANA) then
                // 魔法不足
                set msg = msg + ITEM_SELF_REQUIRE_MANA
                set msg = MHString_Replace(msg, "$itemName$", GetObjectName(abilId))
                set msg = MHString_Replace(msg, "$manaCost$", I2S(R2I(manaCost * 1. - GetUnitState(whichUnit, UNIT_STATE_MANA))))
            elseif IsUnitAbilityDisabled(whichUnit, abilId) then
                if IsUnitOwnedByPlayer(whichUnit, GetLocalPlayer()) then
                    set msg = msg + TOWN_PORTAL_SCROLL_SELF_DISABLED
                    set msg = MHString_Replace(msg, "$itemName$", GetObjectName(abilId))
                else
                    set msg = msg + TOWN_PORTAL_SCROLL_ALLY_DISABLED
                    set msg = MHString_Replace(msg, "$itemName$", GetObjectName(abilId))
                endif
            else
                // 准备就绪
                set msg = msg + ITEM_SELF_READY
                set msg = MHString_Replace(msg, "$itemName$", GetObjectName(abilId))
            endif
        else
            // ping敌人时
            set msg = msg + ITEM_ENEMY_PING
            set msg = MHString_Replace(msg, "$heroName$", GetUnitNameColored(whichUnit))
            set msg = MHString_Replace(msg, "$itemName$", GetObjectName(abilId))
        endif

        // 技能充能
        if charges > 0 then
            set msg = msg + MHString_Replace(ITEM_CHARGES, "$charges$", I2S(charges))
        endif

        if msg != null then
            call PlayerChat.SendChatToAlliedPlayers(msg)
        endif
    endfunction
    
    globals
        constant string GLYPH_READY               = "防御符文 > 准备就绪"
        constant string GLYPH_REQUIRE_COOLDOWN    = "防御符文 > 冷却中（还剩$cooldown$秒）"
    endglobals

    public function OnGlyphPing takes real cooldownRemaining returns nothing
        local string  msg     
        if cooldownRemaining == 0. then
            set msg = GLYPH_READY
        else
            set msg = GLYPH_REQUIRE_COOLDOWN
            set msg = MHString_Replace(msg, "$cooldown$", I2S(R2I(cooldownRemaining + 1.)))
        endif

        if msg != null then
            call PlayerChat.SendChatToAlliedPlayers(msg)
        endif
    endfunction

    private function OnSkillButtonPing takes integer skillButton returns nothing
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
        
        if abilId == 'AHer' then
            if orderId == ORDER_skillmenu then
                call OnSkillPointsPing(whichUnit)
            else
                call OnLearnSkillPing(whichUnit, skillButton)
            endif
        elseif abilId == 'Asud' or abilId == 'Asel' then // Asud是触发器添加的
            call OnPurchasePing(whichUnit, skillButton)
        elseif abilId == 'Aatk' then
            // 代办 显示缴械信息和攻击力
        else
            call OnAbilitiesPing(whichUnit, skillButton)
        endif

        set whichUnit = null
    endfunction

    private function OnClickSkillButton takes nothing returns boolean
        local integer skillButton = MHEvent_GetFrame()

        if MHMsg_IsKeyDown(OSKEY_ALT) and MHEvent_GetKey() == 1 then
    
            call OnSkillButtonPing(skillButton)
            call MHEvent_SetKey(-1)

        endif

        return false
    endfunction
    

    private function OnClickItemButton takes nothing returns boolean
        local integer itemButton = MHEvent_GetFrame()
        local integer itemSlot   = GetItemButtonIndex(itemButton)

        // call BJDebugMsg("MHUIData_GetCommandButtonItem(itemButton):" + I2S(GetHandleId(MHUIData_GetCommandButtonItem(itemButton))))
        // call BJDebugMsg("name:" + GetItemName(MHUIData_GetCommandButtonItem(itemButton)))
        if MHMsg_IsKeyDown(OSKEY_ALT) and MHEvent_GetKey() == 1 then
            //call OnInventoryPing(MHPlayer_GetSelectUnit(), UnitItemInSlot(MHPlayer_GetSelectUnit(), itemSlot), itemButton)
            call OnInventoryPing(MHPlayer_GetSelectUnit(), MHUIData_GetCommandButtonItem(itemButton), itemButton)
            call MHEvent_SetKey(-1)
        endif
        /*  MHUIData_GetCommandButtonItem(itemButton)*/ 
        return false
    endfunction

    function Communication_Init takes nothing returns nothing
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
            //call MHUIData_GetCommandButtonSubscriptText(SkillButton[i])
            call MHFrameEvent_Register(SkillTrig, SkillButton[i], EVENT_ID_FRAME_MOUSE_CLICK)

            call MHFrame_SetFont(MHDrawCooldown_GetText(i), "Fonts\\arheigb_bd.ttf", 0.016, 0)
            call MHFrame_SetTextShadowOff(MHDrawCooldown_GetText(i), 0.0016, - 0.0016)
            set i = i + 1
        endloop

        set ItemTrig = CreateTrigger()
        call TriggerAddCondition(ItemTrig, Condition(function OnClickItemButton))
        set i = 1
        loop
            exitwhen i > 6
            set ItemButton[i] = MHUI_GetItemBarButton(i)
            
            call MHFrame_SetFont(MHDrawCooldown_GetText(i + 12), "Fonts\\arheigb_bd.ttf", 0.013, 0)
            call MHFrame_SetTextShadowOff(MHDrawCooldown_GetText(i + 12), 0.0013, - 0.0013)

            //call MHUIData_GetCommandButtonSubscriptText(ItemButton[i])
            call MHFrameEvent_Register(ItemTrig, ItemButton[i], EVENT_ID_FRAME_MOUSE_CLICK)
            set i = i + 1
        endloop
    endfunction

endlibrary
