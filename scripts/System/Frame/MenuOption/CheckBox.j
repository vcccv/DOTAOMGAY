
scope MenuOptionCheckBox

    globals
        integer         array           OptionCheckBoxsHighLight    //复选框高亮
        integer         array           OptionCheckBoxs             //复选框
        integer         array           OptionCheckBoxsText         //复选框文本
        boolean         array           IsMenuOptionCheckBoxEnabled //复选框是否勾选

        
        boolean         array           Setup_SkillInfo
        boolean         array           Setup_ItemInfo
        boolean         array           IsOptionDefaultEnabled
        
        key         OPTION_CHECKBOX_INDEX
    endglobals

    function Setup_SyncData takes nothing returns boolean
        local string s = DzGetTriggerSyncData()
        local integer data = S2I(s)
        local player p = DzGetTriggerSyncPlayer()
        local integer id = GetPlayerId(p)
        local boolean b
        if data == 1 then
            call Q_X(p, false)
        elseif data == 2 then
            call ShowAbilityCd_Actions(p, false)
        elseif data == 3 then
            call SetCharges(p)
        elseif data == 4 then //-si
            set IsPlayersEnableItemInfo[id] = ( IsPlayersEnableSkillInfo[id] and Setup_ItemInfo[id] ) //-ii
            set IsPlayersEnableSkillInfo[id] = not IsPlayersEnableSkillInfo[id] // -si
            set Setup_SkillInfo[id] = IsPlayersEnableSkillInfo[id]
            if LocalPlayer == p then
                call GetSetupText("多面板显示技能", IsPlayersEnableSkillInfo[id])
            endif
        elseif data == 5 then //-ii
            set IsPlayersEnableSkillInfo[id] = ( IsPlayersEnableItemInfo[id] and Setup_SkillInfo[id] ) //-si
            set IsPlayersEnableItemInfo[id] = not IsPlayersEnableItemInfo[id] //-ii
            set Setup_ItemInfo[id] = IsPlayersEnableItemInfo[id]
            if LocalPlayer == p then
                call GetSetupText("多面板显示物品", IsPlayersEnableItemInfo[id])
            endif
        elseif data == 7 then //自动选择召唤物
            if F_V[id] then
                set F_V[id]= false
                call DisplayTimedTextToPlayer(p, 0, 0, 5, GetObjectName('n0JZ'))
            else
                set F_V[id]= true
                call DisplayTimedTextToPlayer(p, 0, 0, 5, GetObjectName('n0K0'))
            endif
        elseif data == 8 then //自动装置神符
            if LocalPlayer == p then
                call GetSetupText("自动装置神符", XI[id])
            endif
            set XI[id]= not XI[id]
        elseif data == 9 then //拒绝队友帮助技能
            set b = not LoadBoolean(HY, GetHandleId(p),  139)
            call SaveBoolean(HY, GetHandleId(p),  139, b)
            if LocalPlayer == p then
                call GetSetupText(GetObjectName('n08O'), b)
            endif
        elseif data == 10 then
            call MUChangeMessengerShare(p) //共享信使 默认关闭
        elseif data == 11 then //特殊音效
            if T3[id] then
                if LocalPlayer == p then
                    call GetSetupText(GetObjectName('n08T'), T3[id])
                endif
            else
            set T3[id] = not T3[id]
            endif
        elseif data == 12 then
            if IsPlayerInForce(p, AllPlayerForce) then
                call ForceRemovePlayer(AllPlayerForce, p)
                if LocalPlayer == p then
                    call GetSetupText(GetObjectName('n08U'), true)
                endif
            else
                call ForceAddPlayer(AllPlayerForce, p)
                if LocalPlayer == p then
                    call GetSetupText(GetObjectName('n08U'), false)
                endif
            endif
        elseif data == 14 then
            set ZR[id]= not ZR[id]
            if LocalPlayer == p then
                call GetSetupText("震动视角", ZR[id])
            endif
        elseif data == 15 then
            set EnableMapSetup__ShowDamageTextTag[id] = not EnableMapSetup__ShowDamageTextTag[id]
            if LocalPlayer == p then
                call GetSetupText("显示伤害值", EnableMapSetup__ShowDamageTextTag[id])
            endif
        elseif data == 17 then
            if LocalPlayer == p then
                call GetSetupText("快速清理", DisplayTextDuration[id]== 10.)
            endif
            if DisplayTextDuration[id]== 1. then
                set DisplayTextDuration[id]= 10.
            else
                set DisplayTextDuration[id]= 1.
            endif
        elseif data == 18 then
            set b = LoadBoolean(OtherHashTable, GetHandleId(p),'UIds')
            if LocalPlayer == p then
                call GetSetupText("信使复活窗口", b)
            endif
            call SaveBoolean(OtherHashTable, GetHandleId(p),'UIds', not b)
        elseif data == 19 then
            set F4V[id] = not F4V[id]
            call GetSetupText("复活计时器窗口", F4V[id])
        endif
        set p = null
        return false
    endfunction
    
    function ClickOptionCheckBoxAction takes integer id returns nothing
        if id == 4 then     // -ii 与si冲突
            call DzFrameSetEnable(OptionCheckBoxs[5], not IsMenuOptionCheckBoxEnabled[id])
            call DzSyncData("setup", "4")
        elseif id == 5 then // -si 与-ii冲突
            call DzFrameSetEnable(OptionCheckBoxs[4], not IsMenuOptionCheckBoxEnabled[id])
            call DzSyncData("setup", "5")
        elseif id == 16 then
            call SetupDoubleClickSpellByCheckBox(IsMenuOptionCheckBoxEnabled[id])
        elseif id == 20 then
            set IsTabEnableMultiboard = IsMenuOptionCheckBoxEnabled[id]
            call GetSetupText("Tab键开启多面板", IsMenuOptionCheckBoxEnabled[id])
        elseif id == 21 then
            call DzEnableWideScreen(IsMenuOptionCheckBoxEnabled[id])
            call GetSetupText("宽屏模式", IsMenuOptionCheckBoxEnabled[id])
        elseif id == 22 then
            call DzFrameSetEnable(OptionCheckBoxs[23], IsMenuOptionCheckBoxEnabled[id])
            set UseChangeHotKeySystem = IsMenuOptionCheckBoxEnabled[id]
            call GetSetupText("改键系统", IsMenuOptionCheckBoxEnabled[id])
        elseif id == 23 then
            set ChangeHotkeyHeroOnly = IsMenuOptionCheckBoxEnabled[id]
            call GetSetupText("改键仅限英雄", IsMenuOptionCheckBoxEnabled[id])
        else // 这一类都是需要同步的
            call DzSyncData("setup", I2S(id))
        endif
        call DzFrameShow(OptionCheckBoxsHighLight[id], IsMenuOptionCheckBoxEnabled[id])
    endfunction
    
    function GetLocalPlayerSetup takes nothing returns nothing
        local string s
        local integer i = 0
        set ServerValue = DzAPI_Map_GetServerValue(LocalPlayer, "setup")
        set s = SubString(ServerValue, 0 , 1)
        if ServerValue == null or (s != "N" and s != "O") then
            return
        endif
        loop
            set s = SubString(ServerValue, i , i + 1)
            set IsMenuOptionCheckBoxEnabled[i] = s == "N"
            if IsOptionDefaultEnabled[i] != IsMenuOptionCheckBoxEnabled[i] then
                call ClickOptionCheckBoxAction(i)
            endif
            exitwhen i == 23
            set i = i + 1
        endloop
        set ServerValue = DzAPI_Map_GetServerValue(LocalPlayer, "hotkey")
        if ServerValue == null then
            return
        endif
        set i = 0
        loop
            set s = SubString(ServerValue, i , i + 1)
            if s != "0" then
                call DzFrameSetText(HotKeyEditBoxs[i + 1], s)
            endif
            exitwhen i == 22
            set i = i + 1
        endloop
    endfunction

    function ClickOptionCheckBoxCallback takes nothing returns nothing
        local integer index = GetFrameIndex(DzGetTriggerUIEventFrame(), OPTION_CHECKBOX_INDEX)
        set IsMenuOptionCheckBoxEnabled[index] = not IsMenuOptionCheckBoxEnabled[index]
        call ClickOptionCheckBoxAction(index)
        //call BJDebugMsg("Click" + I2S(index) + " " + I2S(DzGetTriggerUIEventFrame()))
    endfunction

    // 创建复选框 id为序号,xy的值是UI的绝对位置,b为是否初始勾选
    function CreateOptionCheckBox takes integer id, string tip, boolean b returns string
        local real x
        local real y
        if id > 10 then
            set x = CheckBox_WidthInitialValue  + CheckBox_WidthSpacing
            set y = CheckBox_HeightInitialValue - CheckBox_HeightSpacing * (id - 11)
        else
            set x = CheckBox_WidthInitialValue
            set y = CheckBox_HeightInitialValue - CheckBox_HeightSpacing * id
        endif
        set IsMenuOptionCheckBoxEnabled[id] = b
        set IsOptionDefaultEnabled[id]      = b

        set OptionCheckBoxs[id] = DzCreateFrameByTagName("GLUECHECKBOX", null, UIFrame__OrderSetup, "Setup_CheckBox", id)
        call DzFrameSetAbsolutePoint(OptionCheckBoxs[id], FRAMEPOINT_CENTER, x, y)
        call SetFrameIndex(OptionCheckBoxs[id], OPTION_CHECKBOX_INDEX, id)
        call DzFrameSetScriptByCode(OptionCheckBoxs[id], FRAME_CHECKBOX_CHECKED  , function ClickOptionCheckBoxCallback, false)
        call DzFrameSetScriptByCode(OptionCheckBoxs[id], FRAME_CHECKBOX_UNCHECKED, function ClickOptionCheckBoxCallback, false)

        set OptionCheckBoxsText[id] = DzCreateFrameByTagName("TEXT", "null", OptionCheckBoxs[id], "CheckBox_Text", id)
        call DzFrameSetPoint(OptionCheckBoxsText[id], FRAMEPOINT_LEFT, OptionCheckBoxs[id], 5, 0.005, 0.0)
        call DzFrameSetText(OptionCheckBoxsText[id], tip)

        set OptionCheckBoxsHighLight[id] = DzCreateFrameByTagName("HIGHLIGHT", "name", OptionCheckBoxs[id], "Setup_CheckBox_Highlight", id)
        call DzFrameSetAllPoints(OptionCheckBoxsHighLight[id], OptionCheckBoxs[id])

        if not b then
            call DzFrameShow(OptionCheckBoxsHighLight[id], false)
        endif

        return tip
    endfunction

    function CreateMenuOptionCheckBoxs takes nothing returns nothing
        // 创建复选框
        call CreateOptionCheckBox(0, "右键反补", false) //null
        call SetFrameToolTip(OptionCheckBoxs[0], "右键反补", "?")

        call CreateOptionCheckBox(1, "隐藏被动", false)  //-sp
        call SetFrameToolTip(OptionCheckBoxs[1], "隐藏被动", "隐藏大部分被动技能，不包括有冷却时间的技能。")

        call CreateOptionCheckBox(2, "隐藏有冷却被动", false) //-spcd
        call SetFrameToolTip(OptionCheckBoxs[2], "隐藏有冷却被动", "隐藏有冷却的被动技能，不包括|CFFFF8000重生|r和|CFFFF8000连击|r。")
        
        call CreateOptionCheckBox(3, "多面板显示充能", true) //-charges
        call SetFrameToolTip(OptionCheckBoxs[3], "多面板显示充能", "在右上角多面板显示一些技能的充能和冷却情况。")
       
        call CreateOptionCheckBox(4, "多面板显示技能", false) //-si
        call SetFrameToolTip(OptionCheckBoxs[4], "多面板显示技能", "在右上角多面板显示选择的技能，与显示物品冲突。")
        
        call CreateOptionCheckBox(5, "多面板显示物品", false) //-ii
        call SetFrameToolTip(OptionCheckBoxs[5], "多面板显示物品", "在右上角多面板显示选择的技能，与显示技能冲突。")
        
        call CreateOptionCheckBox(6, "自动攻击", false) //null
        call SetFrameToolTip(OptionCheckBoxs[6], "自动攻击", "?")
        
        call CreateOptionCheckBox(7, "自动选择召唤物", true) //-disableselection/-ds 和 -enableselection/-es
        call SetFrameToolTip(OptionCheckBoxs[7], "自动选择召唤物", "开启后使用召唤类技能(包括镜像)将会自动选取被召唤单位。")
        
        call CreateOptionCheckBox(8, "自动装置神符", true) //-orp
        call SetFrameToolTip(OptionCheckBoxs[8], "自动装置神符", "右键点击|cffff0000神符|r时|c0000FF00会|r把神符装入瓶中")
        
        call CreateOptionCheckBox(9, "禁用帮助技能", false) //-disablehelp 和 -enablehelp
        call SetFrameToolTip(OptionCheckBoxs[9], "禁用帮助技能", "禁止友军对你使用帮助技能，例如|CFFFF8000忠诚考验|r和|CFFFF8000X标记|r。")
        
        call CreateOptionCheckBox(10, "共享信使", false) // 无指令,能量圈中使用
        call SetFrameToolTip(OptionCheckBoxs[10], "共享信使", "将你的信使更改为队伍公用，不必向友军开启共享单位。")
        
        call CreateOptionCheckBox(11, "关闭特殊音效", true) //-mute
        call SetFrameToolTip(OptionCheckBoxs[11], "特殊音效", "关闭后不会播放大部分音效，例如击杀，连杀音效。")
        
        call CreateOptionCheckBox(12, "隐藏系统信息", false) //-showmsg 和 -hidemsg
        call SetFrameToolTip(OptionCheckBoxs[12], "隐藏系统信息", "开启后不再显示系统信息，例如击杀消息，重要提示等。")
        
        call CreateOptionCheckBox(13, "镜头置中", false) //null
        
        call CreateOptionCheckBox(14, "震动视角", false) //-shaking
        call SetFrameToolTip(OptionCheckBoxs[14], "震动视角", "目前只有在单人模式下才可使用，挨打会让屏幕震动。")
        
        call CreateOptionCheckBox(15, "显示伤害值", false) //-sddon 和 -sddoff
        call SetFrameToolTip(OptionCheckBoxs[15], "显示伤害值", "目前只有在单人模式下才可使用，一般用于测试。")
        
        call CreateOptionCheckBox(16, "双击对己施法", false) // -dch
        call SetFrameToolTip(OptionCheckBoxs[16], "双击对己施法", "开启后双击技能快捷键将对自己释放技能。需要注意必须是游戏内的快捷键，平台修改的快捷键地图并不会知道。")
        
        call CreateOptionCheckBox(17, "快速清理阵亡消息", false) //-fc
        call SetFrameToolTip(OptionCheckBoxs[17], "快速清理阵亡消息", "开启后，死亡信息持续显示1秒，关闭则10秒。")
        
        call CreateOptionCheckBox(18, "开启信使阵亡窗口", true) //-ui
        call SetFrameToolTip(OptionCheckBoxs[18], "开启信使阵亡窗口", "开启将显示信使阵亡窗口，关闭则会显示信使当前活动情况。")
        
        call CreateOptionCheckBox(19, "等待复活计时窗口", true) //-deathon/-don 和 -doff/-deathoff
        call SetFrameToolTip(OptionCheckBoxs[19], "等待复活计时窗口", "死后的复活计时窗口。")
        
        call CreateOptionCheckBox(20, "Tab键开启多面板", false) //无指令
        call SetFrameToolTip(OptionCheckBoxs[20], "Tab键开启多面板", "开启后按住Tab键会显示多面板，松开则取消显示。")
        
        call CreateOptionCheckBox(21, "宽屏模式", false) //无指令
        call SetFrameToolTip(OptionCheckBoxs[21], "宽屏模式", "顾名思义。")
        
        call CreateOptionCheckBox(22, "改键系统", false) //无指令
        call SetFrameToolTip(OptionCheckBoxs[22], "改键系统", "如果你有同时使用平台改键的话，那么我建议你两边设置都相同。此系统有略微延迟，学习技能后重新选择单位可能有所改善。不建议喜欢使用原生按键的玩家开启此项。")
        
        call CreateOptionCheckBox(23, "改键仅限英雄", true) //无指令
        call SetFrameToolTip(OptionCheckBoxs[23], "改键仅限英雄", "开启后仅会更改英雄单位的快捷键。")
        
        call DzFrameSetAbsolutePoint(OptionCheckBoxs[22], FRAMEPOINT_CENTER, 0.4, 0.424)
        
        call DzFrameSetAbsolutePoint(OptionCheckBoxs[23], FRAMEPOINT_CENTER, 0.4, 0.4)
        // 一些不可用的
        call DzFrameSetEnable(OptionCheckBoxs[0], false)
        call DzFrameSetEnable(OptionCheckBoxs[6], false)
        call DzFrameSetEnable(OptionCheckBoxs[13], false)
        call DzFrameSetEnable(OptionCheckBoxs[23], false)
    endfunction

    function CreateMenuOptionSyncTrig takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call DzTriggerRegisterSyncData(trig, "setup", false)
        call TriggerAddCondition(trig, Condition( function Setup_SyncData))
    endfunction

    function MenuOptionCheckBox_Init takes nothing returns nothing
        call CreateMenuOptionCheckBoxs()
        call CreateMenuOptionSyncTrig()
    endfunction

endscope

