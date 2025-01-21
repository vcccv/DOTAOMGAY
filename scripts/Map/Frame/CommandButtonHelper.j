
scope CommandButtonHelper

    // 学习技能
    function SendLearnState takes integer abilId returns nothing
        local unit    u         = MHPlayer_GetSelectUnit()
        local integer level     = GetUnitAbilityLevel(u, abilId) + 1
        local string  name  = GetObjectName(abilId) + " [" + I2S(level) + "]"
 
        local integer reqLevel  = MHAbility_GetDefDataInt(abilId, ABILITY_DEF_DATA_REQ_LEVEL)
        local integer levelSkip = MHAbility_GetDefDataInt(abilId, ABILITY_DEF_DATA_REQ_LEVEL)
        local integer needLevel = 0
        local integer needExp   = 0

        local string  data      = null

        if IsUnitOwnedByPlayer(u, GetLocalPlayer()) then
            // 自己的单位
            set data = "我准备学习技能 > " + name
        else
            // 对队友建议
            set data = GetPlayerName(GetOwningPlayer(u)) + " > 应该学习 > " + name
        endif

        set u = null

        //call MHSyncEvent_FastSync("COMMAND_BUTTON_STATE", data)
    endfunction

    // 购买单位
    function SendMercenaryState takes integer unitId, integer commandbutton returns nothing
        local integer goldCost  = MHUIData_GetCommandButtonGoldCost(commandbutton)
        local integer woodCost  = MHUIData_GetCommandButtonLumberCost(commandbutton)
        local integer foodCost  = MHUIData_GetCommandButtonFoodCost(commandbutton)
        local real    cooldown  = MHUIData_GetCommandButtonCooldown(commandbutton)
        local string  unitName  = GetObjectName(unitId)
        local string  unitState = null
        local string  data      = null

        set data = "我准备雇佣 > " + unitName

        //call MHSyncEvent_FastSync("COMMAND_BUTTON_STATE", data)
    endfunction

    // 购买物品
    function SendShopState takes integer itemId, integer commandbutton returns nothing
        local integer goldCost  = MHUIData_GetCommandButtonGoldCost(commandbutton)
        local integer woodCost  = MHUIData_GetCommandButtonLumberCost(commandbutton)
        local real    cooldown  = MHUIData_GetCommandButtonCooldown(commandbutton)
        local string  itemName  = GetObjectName(itemId)
        local string  unitState = null
        local string  data      = null

        set data = "我准备购买 > " + itemName

        //call MHSyncEvent_FastSync("COMMAND_BUTTON_STATE", data)
    endfunction

    // 
    function SendAbilityState takes item it, integer abilId returns nothing
        local unit    u        = MHPlayer_GetSelectUnit()
        local integer level   

        local real    cooldown
        local integer manaCost

        local integer maxLevel
        local integer needMana
        local string  data  
        local string  name
        if it == null then
            set name = GetObjectName(abilId)
        else
            set name = GetObjectName(GetItemTypeId(it))
            set name = MHString_Sub(name, 0, MHString_Find(name, "|n", 0))
        endif

        if abilId != 0 then
            set level    = GetUnitAbilityLevel(u, abilId)
            set cooldown = MHAbility_GetCooldown(u, abilId)
            set manaCost = MHAbility_GetLevelDefDataInt(abilId, level, ABILITY_LEVEL_DEF_DATA_MANA_COST)
            set maxLevel = MHAbility_GetDefDataInt(abilId, ABILITY_DEF_DATA_MAX_LEVEL)
            set needMana = R2I(GetUnitState(u, UNIT_STATE_MANA)) - manaCost
            set data     = null


            if it != null and GetItemCharges(it) > 1 then
                set name = name + " [" + I2S(GetItemCharges(it)) + "]" 
            else
                set name = name + " [" + I2S(level) + "]" 
            endif

            // abilState
            if cooldown > 0. then
                set data = "冷却中 ( " + I2S(R2I(cooldown)) + " )"
            elseif needMana < 0 then
                set data = "魔法不足 ( 还需要" + I2S(IAbsBJ(needMana)) + "点 )"
            else
                set data = "已准备就绪"
            endif
        else
            set data = "已准备就绪"
        endif
        if IsUnitOwnedByPlayer(u, GetLocalPlayer()) then
            // 自己的单位
            set data = name + " > " + data
        else
            // 对队友建议
            set data = GetPlayerName(GetOwningPlayer(u)) + " > " + GetUnitName(u) + " > " + name + " > " + data
        endif        
        
        set u = null

        if GetChat_times() then
            call DzSyncData("t", data)
        endif
        //call MHSyncEvent_FastSync("COMMAND_BUTTON_STATE", data)
    endfunction

    // 0 ~ 5
    function onClickItemCommandButton takes integer index returns nothing
        local unit    u        = MHPlayer_GetSelectUnit()
        local item    it       = UnitItemInSlot(u, index)
        local integer abilCode = MHItem_GetAbilityId(it, 1)
        local string  name

        if abilCode != 0 then
            call SendAbilityState(it, abilCode)
        endif

        set u  = null
        set it = null
    endfunction

    function onClickCommandButton takes nothing returns nothing
        local integer abilId
        local integer orderId
        local integer commandButton

        if not MHMsg_IsKeyDown(OSKEY_ALT) or MHEvent_GetKey() == 4 then
            return
        endif

        call MHEvent_SetKey(-1)

        //set commandButton = MHEvent_GetFrame()
        //set abilId  = MHUIData_GetCommandButtonAbility(commandButton)
        //set orderId = MHUIData_GetCommandButtonOrderId(commandButton)
        //
        //if orderId >=852008 and orderId <=852013 then
        //    //call BJDebugMsg("commandbutton" + I2S(commandButton))
        //    //call BJDebugMsg("abilId:" + I2S(abilId))
        //    //call BJDebugMsg("orderId" + I2S(orderId))
        //endif
        
    endfunction

    globals
	    integer CommandButtonSkillFousc = - 1
        integer CommandButtonItemFousc  = - 1
        integer array ItemBarButton
    endglobals

    // 鼠标进入命令按钮
    function EntherCommandButtonCallback takes nothing returns nothing
        set CommandButtonSkillFousc = (DzGetTriggerUIEventFrame() - FirstCommandBarButton) / ButtonInterval
    endfunction
    function EntherItemCommandButtonCallback takes nothing returns nothing
        local integer frame = DzGetTriggerUIEventFrame()
        local integer i = 0
        loop
            exitwhen i > 5
            if ItemBarButton[i] == frame then
                set CommandButtonItemFousc = i
                return
            endif
            set i = i + 1
        endloop
    endfunction
    // 鼠标离开命令按钮
    function LeaveCommandButtonCallback takes nothing returns nothing
        set CommandButtonSkillFousc = - 1
    endfunction

    function CommandButtonHelper_Init takes nothing returns nothing
        local integer x
        local integer y
        local integer frame
        local trigger trig = CreateTrigger()
        //call MHMsgClickButtonEvent_Register(trig)
        call TriggerAddCondition(trig, Condition(function onClickCommandButton))

        // 鼠标进入和离开右下角技能栏
        set x = 0
        set y = 0
        loop
            exitwhen x > 3
            set y = 0
            loop
                exitwhen y > 2
                set frame = DzFrameGetCommandBarButton(y, x)
                call DzFrameSetScriptByCode(frame, FRAMEEVENT_MOUSE_ENTER, function EntherCommandButtonCallback, false)
                call DzFrameSetScriptByCode(frame, FRAMEEVENT_MOUSE_LEAVE, function LeaveCommandButtonCallback, false)
                set y = y + 1
            endloop
            set x = x + 1
        endloop

        set x = 0
        loop
            exitwhen x > 5
            set ItemBarButton[x] = DzFrameGetItemBarButton(x)
            call DzFrameSetScriptByCode(ItemBarButton[x], FRAMEEVENT_MOUSE_ENTER, function EntherItemCommandButtonCallback, false)
            set x = x + 1
        endloop
        
    endfunction

endscope
