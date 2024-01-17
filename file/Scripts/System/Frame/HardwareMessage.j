
scope HardwareMessage

    // 按下ESC按键
    // 直接异步清理消息 更顺滑
    function EnterKey_PushOther takes nothing returns nothing
        local integer key = DzGetTriggerKey()
        // 回车
        if key == 13 then
            if UpdateLogIsShow then
                // 退出更新日志
                call DzClickFrame(UIButton__UpdateLogOK)
            elseif ChangingHotkey then
                // 退出选择热键
                call CancelChangeHotKey()
            endif
        elseif key == 27 then
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
        elseif key == 115 then
            // 如果按下F4 的同时还按着Alt 说明玩家要直接退游戏 隐藏一下防止露馅
            if DzIsKeyDown(18) then
                call DzFrameShow( EscMenuMapOptionsPanel, false )
                call DzFrameShow( UIFrame__OrderSetup, false )
                set IsSetupUIEnable = false
                set bMenuGameplayPanelIsEnable = false
            endif
        elseif key == 121 then
            // 按F10
            set bMenuMainPanelIsEnable = true
        endif
    endfunction

    // 按键按下
    function EnterKey_PushKey takes nothing returns nothing
        local integer key = DzGetTriggerKey()
        local integer x = 0
        local integer abilityId
        if not KeyIsDown[key] then
            set KeyIsDown[key] = true
            // 如果在菜单界面
            if bMenuMainPanelIsEnable and key == 'C' and not IsSetupUIEnable then
                call ClickMapSetupButton__Script()
                return
            elseif key == 'J' then
                if DzIsKeyDown(18) then
                    call Click_UI_Glyph_A()
                endif
            elseif ChangingHotkey then
                call LocalChangeHotKeyActions(key)
            endif
            if IsEnableDoubleClickSystem then
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
        local boolean b = DzIsKeyDown(18)
        local unit selectUnit = GetPlayerSelectedUnit()
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
        // 模拟错误提示
        if InterfaceErrorHideTime > 0. and InterfaceErrorHideTime < GetGameTime( ) then
            set InterfaceErrorTextAlpha = R2I( 255 - 255 * ( ( GetGameTime( ) - InterfaceErrorHideTime ) / 3 ) )
            if InterfaceErrorTextAlpha <= 0 then
                call DzFrameSetAlpha( UIText__TargetingError, 255 )
                call DzFrameShow( UIFrame__TargetingError , false )
                set InterfaceErrorHideTime = 0
                set InterfaceErrorTextAlpha = 0
            else
                call DzFrameSetAlpha( UIText__TargetingError, InterfaceErrorTextAlpha )
            endif
        endif
    endfunction

    // 鼠标左键点击
    function MouseLeftClick takes nothing returns nothing
        if DownAlt then
            if CommandBarButtonIndex == - 1 then
                return
            endif
            call SetStartLocPrioCount(CommandBarButtonIndex / 3 , ModuloInteger(CommandBarButtonIndex, 3))
            if DzIsKeyDown(18) and tip_string != null and tip_string != "" then
                if GetChat_times() then
                    call DzSyncData("t", tip_string)
                endif
            endif
            set tip_string = null
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
