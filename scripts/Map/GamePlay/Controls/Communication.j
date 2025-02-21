
library Communication requires PlayerChatUtils, ItemSystem

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
            exitwhen i > 12
            if itemButton == ItemButton[i] then
                return i
            endif
            set i = i + 1
        endloop
        return 0
    endfunction

    globals
        constant string LEARN_SKILL_SELF_READY         = "我准备学习技能 > $abilityName$（$abilityLevel$级）"
        constant string LEARN_SKILL_SELF_REQUIRE_EXP   = "我还需要|cFFFFFF00$requireExp$|r点经验才能学习 > $abilityName$（$abilityLevel$级）"
        constant string LEARN_SKILL_SELF_REQUIRE_LEVEL = "我还需要升$requireLevel$级才能学习 > $abilityName$（$abilityLevel$级）"

        constant string LEARN_SKILL_ALLY_READY         = "队友$heroName$ > 可以学习技能 > $abilityName$（$abilityLevel$级）"
        constant string LEARN_SKILL_ALLY_REQUIRE_EXP   = "队友$heroName$ > 还需要|cFFFFFF00$requireExp$|r点经验才能学习 > $abilityName$（$abilityLevel$级）"
        constant string LEARN_SKILL_ALLY_REQUIRE_LEVEL = "队友$heroName$ > 还需要升$requireLevel$级才能学习 > $abilityName$（$abilityLevel$级）"
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

    private function GetUnitNameColored takes unit whichUnit returns string
        return PlayerColorHex[GetPlayerId(GetOwningPlayer(whichUnit))] + GetObjectName(GetUnitTypeId(whichUnit)) + "|r"
    endfunction

    // ping学习技能
    private function OnLearnSkillPing takes unit whichUnit, integer skillButton returns nothing
        local integer abilId       = MHUIData_GetCommandButtonOrderId(skillButton)
        local integer abilLevel
        local integer requireLevel
        local integer requireExp
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

    private function GetCommandButtonCharges takes integer commandButton returns integer
        local integer commandButtonSubscriptText = MHUIData_GetCommandButtonSubscriptText(commandButton)
        if MHFrame_IsHidden(MHUIData_GetCommandButtonSubscriptFrame(commandButton)) then
            return 0
        endif
        return S2I(MHFrame_GetText(commandButtonSubscriptText))
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

        call BJDebugMsg("当前id：" + Id2String(id) + " GetCommandButtonCharges:" + I2S(charges)/*
        */ + " cooldown:" + R2S(cooldownRemaining))

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
        constant string ABILITY_SELF_READY            = "$abilityName$（$abilityLevel$级） > 准备就绪"
        constant string ABILITY_SELF_REQUIRE_COOLDOWN = "$abilityName$（$abilityLevel$级） > 冷却中（还剩$cooldown$秒）"
        constant string ABILITY_SELF_REQUIRE_MANA     = "$abilityName$（$abilityLevel$级） > 魔法不足（还需要$manaCost$点）"

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
            set msg = msg + ABILITY_SELF_REQUIRE_COOLDOWN
            set msg = MHString_Replace(msg, "$abilityName$", GetObjectName(abilId))
            set msg = MHString_Replace(msg, "$abilityLevel$", I2S(abilLevel))
            set msg = MHString_Replace(msg, "$cooldown$", I2S(R2I(cooldownRemaining + 1.)))
        elseif manaCost > GetUnitState(whichUnit, UNIT_STATE_MANA) then
            // 魔法不足
            set msg = msg + ABILITY_SELF_REQUIRE_MANA
            set msg = MHString_Replace(msg, "$abilityName$", GetObjectName(abilId))
            set msg = MHString_Replace(msg, "$abilityLevel$", I2S(abilLevel))
            set msg = MHString_Replace(msg, "$manaCost$", I2S(R2I(manaCost * 1. - GetUnitState(whichUnit, UNIT_STATE_MANA))))
        else
            // 准备就绪
            set msg = msg + ABILITY_SELF_READY
            set msg = MHString_Replace(msg, "$abilityName$", GetObjectName(abilId))
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

        call BJDebugMsg("hello!" + I2S(GetHandleId(whichItem)))
        if whichUnit == null or whichItem == null then
            return
        endif

        set itemName          = GetItemNameById(GetItemTypeId(whichItem))
        set cooldownRemaining = MHUIData_GetCommandButtonCooldown(skillButton)
        set manaCost          = MHUIData_GetCommandButtonManaCost(skillButton)
        set charges           = GetCommandButtonCharges(skillButton)
        set msg               = null

        call BJDebugMsg(I2S(GetHandleId(whichItem)) + " : " + itemName)
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
            call OnLearnSkillPing(whichUnit, skillButton)
        elseif abilId == 'Asud' or abilId == 'Asel' then // Asud是触发器添加的
            call OnPurchasePing(whichUnit, skillButton)
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

        if MHMsg_IsKeyDown(OSKEY_ALT) and MHEvent_GetKey() == 1 then
            call OnInventoryPing(MHPlayer_GetSelectUnit(), UnitItemInSlot(MHPlayer_GetSelectUnit(), itemSlot - 1), itemButton)
            call MHEvent_SetKey(-1)
        endif
        /*  MHUIData_GetCommandButtonItem(itemButton)*/ 
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

        set ItemTrig = CreateTrigger()
        call TriggerAddCondition(ItemTrig, Condition(function OnClickItemButton))
        set i = 1
        loop
            exitwhen i > 6
            set ItemButton[i] = MHUI_GetItemBarButton(i)
            call MHFrameEvent_Register(ItemTrig, ItemButton[i], EVENT_ID_FRAME_MOUSE_CLICK)
            set i = i + 1
        endloop
    endfunction

endlibrary

