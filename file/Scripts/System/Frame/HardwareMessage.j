
scope HardwareMessage

    // 按下ESC按键
    function EnterKey_PushOther takes nothing returns nothing
        local integer key = DzGetTriggerKey()
        // 回车
        if key == OSKEY_RETURN then
            if UpdateLogIsShow then
                // 退出更新日志
                call DzClickFrame(UIButton__UpdateLogOK)
            elseif ChangingHotkey then
                // 退出选择热键
                call CancelChangeHotKey()
            endif
        elseif key == OSKEY_ESCAPE then
            // 按下ESC
            if ChangingHotkey then
                call CancelChangeHotKey()
            endif
            if IsSetupUIEnable then
                call ClickMapSetupReturnButton()
            endif
            if bMenuMainPanelIsEnable then
                // 退出菜单
                set bMenuMainPanelIsEnable = false
            elseif UpdateLogIsShow then
                // 退出更新日志
                call DzClickFrame(UIButton__UpdateLogOK)
            endif
        elseif key == OSKEY_F4 then
            // 如果按下F4 的同时还按着Alt 说明玩家要直接退游戏 隐藏一下防止露馅
            if MHMsg_IsKeyDown(OSKEY_ALT) then
                call DzFrameShow( EscMenuMapOptionsPanel, false )
                call DzFrameShow( UIFrame__OrderSetup, false )
                set IsSetupUIEnable = false
                set bMenuGameplayPanelIsEnable = false
            endif
        elseif key == OSKEY_F10 then
            // 按F10
            set bMenuMainPanelIsEnable = true
        endif
    endfunction

    // 按键按下
    function EnterKey_PushKey takes nothing returns nothing
        local integer key = DzGetTriggerKey()
        local integer x = 0
        local integer abilityId
        if MHUI_IsChatEditBarOn() then
            return
        endif
        if not KeyIsDown[key] then
            set KeyIsDown[key] = true
            // 如果在菜单界面
            if bMenuMainPanelIsEnable and key == 'C' and not IsSetupUIEnable then
                call ClickMapSetupButton__Script()
                return
            elseif key == 'J' then
                if MHMsg_IsKeyDown(OSKEY_ALT) then
                    call Click_UI_Glyph_A()
                endif
            elseif ChangingHotkey then
                call LocalChangeHotKeyActions(key)
            elseif key == OSKEY_M and not MHMsg_IsKeyDown(OSKEY_ALT) and not MHMsg_IsKeyDown(OSKEY_CONTROL) and GetUnitAbilityLevel(GetPlayerSelectedUnit(), 'Amov') > 0 then
                call MHMsg_CallTargetMode(0, 851986, 0x6)
            elseif key == OSKEY_P and not MHMsg_IsKeyDown(OSKEY_ALT) and not MHMsg_IsKeyDown(OSKEY_CONTROL) and GetUnitAbilityLevel(GetPlayerSelectedUnit(), 'Amov') > 0 then
                call MHMsg_CallTargetMode(0, 851990, 0x6)
            elseif key == OSKEY_S and not MHMsg_IsKeyDown(OSKEY_ALT) and not MHMsg_IsKeyDown(OSKEY_CONTROL) and GetUnitAbilityLevel(GetPlayerSelectedUnit(), 'Aatk') > 0 then
                if MHMsg_IsKeyDown(OSKEY_SHIFT) then
                    call MHMsg_SendImmediateOrder(851972, 0x1)
                else
                    call MHMsg_SendImmediateOrder(851972, 0x0)
                endif
            elseif key == OSKEY_H and not MHMsg_IsKeyDown(OSKEY_ALT) and not MHMsg_IsKeyDown(OSKEY_CONTROL) and GetUnitAbilityLevel(GetPlayerSelectedUnit(), 'Aatk') > 0 and GetUnitAbilityLevel(GetPlayerSelectedUnit(), 'Amov') > 0 then
                if MHMsg_IsKeyDown(OSKEY_SHIFT) then
                    call MHMsg_SendImmediateOrder(851993, 0x1)
                else
                    call MHMsg_SendImmediateOrder(851993, 0x0)
                endif
            elseif IsEnableDoubleClickSystem then
                if KeyCanDoubleClickSpell[key] > 0 then
                    // 因为取消按键在右下角
                    call GetLocalAbilityId(3, 2)
                    if MessageAbilityOrder == 851979 then
                        if DoubleClickKey == key then
                            if (DoubleClickKeyTime != 0. ) then
                                call DoubleClickSkill()
                                return
                            else
                                set DoubleClickKeyTime = GetGameTime()
                            endif
                        else
                            set DoubleClickKeyTime = 0.
                        endif
                    endif
                    set abilityId = GetLocalAbilityId(0, 0)
                    if LoadBoolean(LocalHashTable, abilityId, KEY_USE_DOUBLECLICK_SPELL) then
                        if LoadInteger(LocalHashTable, abilityId, HotKeyStringHash) == key then
                            set DoubleClickKey = key
                            set DoubleClickKeyTime = GetGameTime()
                            return
                        endif
                    else
                        loop
                            exitwhen x > 3
                            set abilityId = GetLocalAbilityId(x, 2)
                            if LoadBoolean(LocalHashTable, abilityId, KEY_USE_DOUBLECLICK_SPELL) then
                                if LoadInteger(LocalHashTable, abilityId, HotKeyStringHash) == key then
                                    set DoubleClickKey = key
                                    set DoubleClickKeyTime = GetGameTime()
                                    return
                                endif
                            endif
                            set abilityId = GetLocalAbilityId(x, 1)
                            if LoadBoolean(LocalHashTable, abilityId, KEY_USE_DOUBLECLICK_SPELL) then
                                if LoadInteger(LocalHashTable, abilityId, HotKeyStringHash) == key then
                                    set DoubleClickKey = key
                                    set DoubleClickKeyTime = GetGameTime()
                                    return
                                endif
                            endif
                            set x = x + 1
                        endloop
                    endif
                endif
            endif
        endif
    endfunction

    // 按键弹起
    function EnterKey_PoolKey takes nothing returns nothing
        local integer key = DzGetTriggerKey()
        if MHUI_IsChatEditBarOn() then
            return
        endif
        if KeyIsDown[key] then
            set KeyIsDown[key] = false
        endif
    endfunction

    function tab0 takes nothing returns nothing
        if IsTabEnableMultiboard then
            call MultiboardMinimize(BJ_Multiboard, true)
        endif
    endfunction
    function tab1 takes nothing returns nothing
        if IsTabEnableMultiboard then
            if IsMultiboardMinimized(BJ_Multiboard) then
                call MultiboardMinimize(BJ_Multiboard, false)
            endif
        endif
    endfunction

    
    // 每帧回调函数
    function cUpdateCallback takes nothing returns nothing
        local boolean b = MHMsg_IsKeyDown(OSKEY_ALT)
        local unit selectUnit = MHPlayer_GetSelectUnit()
        // 改键
        if UseChangeHotKeySystem then
            set UpdateCallbackCount = UpdateCallbackCount + 1
            if LocalPlayerSelectHandle != GetHandleId(selectUnit) then
                set LocalPlayerSelectHandle = GetHandleId(selectUnit)
                // 判断是否 需要对非英雄单位改键
                if selectUnit != null and ( not ChangeHotkeyHeroOnly or IsUnitType(selectUnit, UNIT_TYPE_HERO) ) then
                    call RefreshUnitAbilityHotKey(selectUnit)
                endif
            elseif UpdateCallbackCount > 60 and selectUnit != null then
                set UpdateCallbackCount = 0
                if selectUnit != null and ( not ChangeHotkeyHeroOnly or IsUnitType(selectUnit, UNIT_TYPE_HERO) ) then
                    call RefreshUnitAbilityHotKey(selectUnit)
                endif
            endif
        endif
        set selectUnit = null
        if ResetSetupButtons then
            call EnableSetupButtons(true)
            set ResetSetupButtons = false
        endif
        if b != DownAlt then
            call AHC(b)
        endif
    endfunction

    // 鼠标左键点击
    function MouseLeftClick takes nothing returns nothing
        if DownAlt then
            if CommandButtonSkillFousc >= 0 then
                call SetStartLocPrioCount(CommandButtonSkillFousc / 3 , ModuloInteger(CommandButtonSkillFousc, 3))
                if MHMsg_IsKeyDown(OSKEY_ALT) and tip_string != null and tip_string != "" then
                    if GetChat_times() then
                        call DzSyncData("t", tip_string)
                    endif
                endif
                set tip_string = null
            endif
          
            if CommandButtonItemFousc >= 0 then
                call onClickItemCommandButton(CommandButtonItemFousc)
            endif
        endif
    endfunction

    function HardwareMessage_Init takes nothing returns nothing
        local integer i
        set i = 65
        // A - Z 键代码 因为技能快捷键现在仅支持A - Z
        loop
            exitwhen i > 90
            call DzTriggerRegisterKeyEventByCode(null, i, 1, false, function EnterKey_PushKey)
            call DzTriggerRegisterKeyEventByCode(null, i, 0, false, function EnterKey_PoolKey)
            set i = i + 1
        endloop
        // 按下回车 13
        call DzTriggerRegisterKeyEventByCode(null, OSKEY_RETURN, 1, false, function EnterKey_PushOther)
        // 按下ESC 27
        call DzTriggerRegisterKeyEventByCode(null, OSKEY_ESCAPE, 1, false, function EnterKey_PushOther)
        // 按下F4 115 
        call DzTriggerRegisterKeyEventByCode(null, OSKEY_F4    , 1, false, function EnterKey_PushOther)
        // 按下F10 121 
        call DzTriggerRegisterKeyEventByCode(null, OSKEY_F10   , 1, false, function EnterKey_PushOther)
        // 按下J 74
        // call DzTriggerRegisterKeyEventByCode(null, 74, 1, false, function EnterKey_PushOther)
        // 左键松开
        call DzTriggerRegisterMouseEventByCode(null, 1, 0, false, function MouseLeftClick)
        // Tab键松开与按下
        call DzTriggerRegisterKeyEventByCode(null, OSKEY_TAB, 0, false, function tab0)
        call DzTriggerRegisterKeyEventByCode(null, OSKEY_TAB, 1, false, function tab1)
    endfunction
    
endscope
