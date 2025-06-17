
// 包含了HotkeySystem和HideCommandButton
library UnitInfoUpdate requires PlayerSettingsLib, AbilityUtils

    globals
        private real UPDATE_TIME_OUT = 1.

        private integer array SkillBarButton
        private integer array ItemButton

        private integer array SkillBarCooldownText
        private integer array ItemBarCooldownText

        private key BASE_COMMAND_ORDER

        private integer array BaseCommandOriginalButtonX
        private integer array BaseCommandOriginalButtonY
        private integer array BaseCommandButtonDataList
        private integer MaxBaseCommandButtonData = 0

        private constant integer MAX_HIDE_BASE_COMMAND_BUTTON_COUNT = 4

        private boolean IsReplayMode = false
    endglobals

    private function IsBaseCommandOrder takes integer order returns boolean
        return Table[BASE_COMMAND_ORDER].boolean[order]
    endfunction
    private function SaveBaseCommandOrder takes integer order returns nothing
        set Table[BASE_COMMAND_ORDER].boolean[order] = true
    endfunction
    
    // CCommandButton + 0x190 = CCommandButtonData
    private function HaveSavedBaseCommandOrderButtonData takes integer order returns boolean
        return Table[BASE_COMMAND_ORDER].integer.has(order)
    endfunction
    private function SaveBaseCommandOrderButtonData takes integer order, integer commandButtonData returns integer
        if commandButtonData == 0 then
            return 0
        endif
        set MaxBaseCommandButtonData = MaxBaseCommandButtonData + 1
        set BaseCommandButtonDataList[MaxBaseCommandButtonData] = commandButtonData
        set Table[BASE_COMMAND_ORDER].integer[order] = commandButtonData
        return commandButtonData
    endfunction

    private function GetBaseCommandOrderButtonData takes nothing returns nothing
        local integer i
        local integer orderId

        if MaxBaseCommandButtonData >= MAX_HIDE_BASE_COMMAND_BUTTON_COUNT then
            return
        endif

        set i = 1
        loop
            exitwhen i > 12
            set orderId = MHUIData_GetCommandButtonOrderId(SkillBarButton[i])
            if IsBaseCommandOrder(orderId) and orderId !=  ORDER_attack and not HaveSavedBaseCommandOrderButtonData(orderId) then
                call SaveBaseCommandOrderButtonData(orderId, ReadRealMemory(SkillBarButton[i] + 0x190))
            endif
            
            set i = i + 1
        endloop
    endfunction

    private function HideCommandButton takes integer i, boolean hideState returns nothing
        if BaseCommandButtonDataList[i] == 0 then
            return
        endif

        if hideState then
            set BaseCommandOriginalButtonX[i] = ReadRealMemory(BaseCommandButtonDataList[i] + 0x59C)
            set BaseCommandOriginalButtonY[i] = ReadRealMemory(BaseCommandButtonDataList[i] + 0x5A0)
            call WriteRealMemory(BaseCommandButtonDataList[i] + 0x59C, 0  )
            call WriteRealMemory(BaseCommandButtonDataList[i] + 0x5A0, -11)
        else
            call WriteRealMemory(BaseCommandButtonDataList[i] + 0x59C, BaseCommandOriginalButtonX[i])
            call WriteRealMemory(BaseCommandButtonDataList[i] + 0x5A0, BaseCommandOriginalButtonY[i])
        endif
    endfunction

    globals
        private boolean prevHide = false
    endglobals

    private function UpdateCommandBarHideState takes nothing returns nothing
        local integer i
        local boolean hideSetting = PlayerSettings[User.LocalId].IsSettingEnable(PlayerSettings.HIDE_COMMAND_BUTTON)

        call GetBaseCommandOrderButtonData()

        if hideSetting != prevHide then
            set i = 1
            loop
                exitwhen i > MAX_HIDE_BASE_COMMAND_BUTTON_COUNT
    
                if BaseCommandButtonDataList[i] != 0 then
                    call HideCommandButton(i, hideSetting)
                endif
    
                set i = i + 1
            endloop

            set prevHide = hideSetting
            call MHUnit_UpdateInfoBar(MHPlayer_GetSelectUnit())
        endif
    
    endfunction

    private function SetCommandButtonHotkey takes integer commandButton, integer hotkey returns nothing
        local integer commandButtonData
        if commandButton == 0 then
            return
        endif

        set commandButtonData = ReadRealMemory(commandButton + 0x190)
        if commandButtonData == 0 then
            return
        endif

        call WriteRealMemory(commandButtonData + 0x5AC, hotkey)
    endfunction
    private function SetUnitHotekeyById takes integer unitId, integer hotkey returns nothing
        call MHUnit_SetDefDataInt(unitId, UNIT_DEF_DATA_HOTKEY, hotkey)
    endfunction

    private function UpdateCommandBarHotkey takes nothing returns nothing
        local integer i
        local integer abilId
        local integer orderId

        if not PlayerSettings[User.LocalId].IsSettingEnable(PlayerSettings.ENABLE_HOTKEY_SYSTEM) then
            return
        endif

        if PlayerSettings[User.LocalId].IsSettingEnable(PlayerSettings.CHANGE_KEY_ONLY_HERO) and not IsUnitType(MHPlayer_GetSelectUnit(), UNIT_TYPE_HERO) then
            return
        endif

        set i = 1
        loop
            exitwhen i > 12
            
            set abilId  = MHUIData_GetCommandButtonAbility(SkillBarButton[i])
            set orderId = MHUIData_GetCommandButtonOrderId(SkillBarButton[i])
            // 学习技能
            if abilId == 'AHer' and orderId != 0 then
                call SetAbilityResearchHotkeyById(orderId, PlayerSettings.GetLearnHotkey(i))
            elseif abilId == 'Asel' then
                // 购买单位 对于买物品时的表现
                call SetUnitHotekeyById(orderId, PlayerSettings.GetHotkey(i))
                //call SetCommandButtonHotkey(SkillBarButton[i], PlayerSettings.GetHotkey(i))
            elseif orderId != 0 and not IsBaseCommandOrder(orderId) then
                // 是否需要判断技能有效性?
                call SetAbilityHotkeyByIdSimple(abilId, PlayerSettings.GetHotkey(i))
            endif
            
            set i = i + 1
        endloop

        call MHUnit_UpdateInfoBar(MHPlayer_GetSelectUnit())
    endfunction

    public function OnTickExpired takes nothing returns nothing
        if MHPlayer_GetSelectUnit() == null then
            return
        endif

        call UpdateCommandBarHotkey()
        call UpdateCommandBarHideState()
    endfunction

    globals
        private boolean CooldownPrevShow = true
    endglobals

    // 技能栏加物品栏冷却时间
    function UnitInfoUpdate_OnUpdate takes nothing returns nothing
        local integer i
        local boolean showSetting
        if IsReplayMode then
            return
        endif

        set showSetting = PlayerSettings[User.LocalId].IsSettingEnable(PlayerSettings.SHOW_COMMAND_BUTTON_COOLDOWN)
        if showSetting != CooldownPrevShow then
            set i = 1
            loop
                exitwhen i > 12
                call MHFrame_Hide(SkillBarCooldownText[i], not showSetting)
                set i = i + 1
            endloop

            set i = 1
            loop
                exitwhen i > 6
                call MHFrame_Hide(ItemBarCooldownText[i], not showSetting)
                set i = i + 1
            endloop

            set CooldownPrevShow = showSetting
        endif

        if not CooldownPrevShow then
            return
        endif

        set i = 1
        loop
            exitwhen i > 12
            if not MHFrame_IsHidden(SkillBarCooldownText[i]) then
                call MHFrame_SetText(SkillBarCooldownText[i], I2S(R2I(MHUIData_GetCommandButtonCooldown(SkillBarButton[i])) + 1))
            endif
            set i = i + 1
        endloop
        
        set i = 1
        loop
            exitwhen i > 6
            if not MHFrame_IsHidden(ItemBarCooldownText[i]) then
                call MHFrame_SetText(ItemBarCooldownText[i], I2S(R2I(MHUIData_GetCommandButtonCooldown(ItemButton[i])) + 1))
            endif
            set i = i + 1
        endloop
    endfunction
    // 
    private function OnSelection takes nothing returns boolean
        local unit selectedUnitSync  = GetTriggerUnit()
        local unit selectedUnitASync = MHPlayer_GetSelectUnit()

        // 如果不是秒切 就尝试更新快捷键
        if selectedUnitSync == selectedUnitASync then
            call UpdateCommandBarHotkey()
        endif

        set selectedUnitSync  = null
        set selectedUnitASync = null
        return false
    endfunction

    function HotkeysSystem_Init takes nothing returns nothing
        local trigger    trig = CreateTrigger()
        local integer    i

        local integer framePtr

        call SimpleTick.CreateEx().Start(UPDATE_TIME_OUT, true, function OnTickExpired)

        set IsReplayMode = MHGame_IsReplay()

        // 移动
        call SaveBaseCommandOrder(ORDER_move)
        // 停止
        call SaveBaseCommandOrder(ORDER_stop)
        // 保持原位
        call SaveBaseCommandOrder(ORDER_holdposition)
        // 攻击
        call SaveBaseCommandOrder(ORDER_attack)
        // 巡逻
        call SaveBaseCommandOrder(ORDER_patrol)
        
        set i = 1
        loop
            exitwhen i > 12
            set SkillBarButton[i] = MHUI_GetSkillBarButton(i)

            set framePtr = MHUIData_GetCommandButtonCooldownFrame(SkillBarButton[i])
            
            set SkillBarCooldownText[i] = MHFrame_CreateEx("TEXT", "SkillBarCooldownText" + I2S(i), "", framePtr, 10, i)
            call MHFrame_SetTextShadowOff(SkillBarCooldownText[i], 0.0016, 0.0016)
            call MHFrame_SetFont(SkillBarCooldownText[i], "Fonts\\arheigb_bd.ttf", 0.016, 0)
            call MHFrame_SetTextAlign(SkillBarCooldownText[i], TEXT_VERTEX_ALIGN_CENTER, TEXT_HORIZON_ALIGN_CENTER)
            call MHFrame_SetAllPoints(SkillBarCooldownText[i], framePtr)
            call MHFrame_Hide(framePtr, true)

            set i = i + 1
        endloop

        set i = 1
        loop
            exitwhen i > 6
            set ItemButton[i] = MHUI_GetItemBarButton(i)

            set framePtr = MHUIData_GetCommandButtonCooldownFrame(ItemButton[i])
            
            set ItemBarCooldownText[i] = MHFrame_CreateEx("TEXT", "ItemBarCooldownText" + I2S(i), "", framePtr, 10, i)
            call MHFrame_SetTextShadowOff(ItemBarCooldownText[i], 0.0016, 0.0016)
            call MHFrame_SetFont(ItemBarCooldownText[i], "Fonts\\arheigb_bd.ttf", 0.016, 0)
            call MHFrame_SetTextAlign(ItemBarCooldownText[i], TEXT_VERTEX_ALIGN_CENTER, TEXT_HORIZON_ALIGN_CENTER)
            call MHFrame_SetAllPoints(ItemBarCooldownText[i], framePtr)
            call MHFrame_Hide(framePtr, true)
            
            set i = i + 1
        endloop

        set i = 1
        loop
            exitwhen i > 15
            call TriggerRegisterPlayerSelectionEventBJ(trig, Player(i), true)
            set i = i + 1
        endloop

        call TriggerAddCondition(trig, Condition(function OnSelection))
    endfunction

endlibrary
