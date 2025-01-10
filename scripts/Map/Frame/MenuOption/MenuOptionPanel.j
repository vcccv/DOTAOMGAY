
#include "CheckBox.j"
scope MenuOptionPanel

    function ShowSetupPanel takes boolean show returns nothing

        set IsSetupUIEnable = show
        call DzFrameShow(EscMenuMapOptionsPanel, show)
        call DzFrameShow(OriginFrame_MainPanel, not show)

    endfunction

    function ClickOrderSetupSaveButton takes nothing returns nothing
        local string s = ""
        local integer i = 0
        local string dummy
        loop
            if IsMenuOptionCheckBoxEnabled[i] then
                set dummy = "N"
            else
                set dummy = "O"
            endif
            set s = s + dummy
            exitwhen i == 23
            set i = i + 1
        endloop

        call ShowSetupPanel(false)
        call CancelChangeHotKey()
        call DzClickFrame(DzFrameFindByName("PreviousButton", 0))
        call DzFrameSetParent(UIFrame__ToolTip, GameUI)

        call DzAPI_Map_SaveServerValue(LocalPlayer, "setup", s)
        //call DisplayTimedTextToPlayer(LocalPlayer, 0, 0, 10, "|CFFFF8000[设置]|R |c006699CC复选框|r 已成功保存") 
        
        set i = 0
        set s = null
        loop
            if LocalCommandButtonHotkey[i] == 0 then
                set dummy = "0"
            else
                set dummy = Key2Str(LocalCommandButtonHotkey[i])
            endif
            set s = s + dummy
            exitwhen i == 23
            set i = i + 1
        endloop
        call DzAPI_Map_SaveServerValue(LocalPlayer, "hotkey", s)
        
        call DisplayTimedTextToPlayer(LocalPlayer, 0, 0, 10, "|CFFFF8000[设置]|R |c006699CC设置数据|r |cFF00FF00已上传|r") 

    endfunction

    // 点击 地图设置 按钮
    function ClickMapSetupButton__Script takes nothing returns nothing
        call DzClickFrame(DzFrameFindByName("EndGameButton", 0))
        call DzFrameShow(EscMenuMapSetupBackdrop , true)
        call DzFrameShow(DzFrameFindByName("EndGamePanel", 0) , false)
        call ShowSetupPanel(true)

        call DzFrameSetParent(UIFrame__ToolTip, DzFrameFindByName("MapOptionsPanel", 0))
    endfunction

    // 点击地图选项返回按钮
    function ClickMapSetupReturnButton takes nothing returns nothing
        // 隐藏地图设置界面
        call CancelChangeHotKey()
        call ShowSetupPanel(false)
        if DzGetTriggerKey() != OSKEY_ESCAPE then
            call DzClickFrame(DzFrameFindByName("PreviousButton", 0))
        endif

        call DzFrameSetParent(UIFrame__ToolTip, GameUI)
    endfunction

    function ClickMapSetupResetButton takes nothing returns nothing
        call ResetHotkey()
    endfunction

    // 隐藏按钮的父级
    function Click_OKButton_Script takes nothing returns nothing
        set UpdateLogIsShow = false
        call DzFrameShow(UIFrame__UpdateLog , false)
        if UIFrame__DebugLog != 0 then
            call DzFrameShow(UIFrame__DebugLog , false)
        endif
        //call DzFrameShow(DzFrameGetParent(DzGetTriggerUIEventFrame()) , false)
    endfunction

    function Click_MenuMainButton_Script takes nothing returns nothing
        set bMenuMainPanelIsEnable = true
    endfunction

    function Click_MenuMainReturnButton_Script takes nothing returns nothing
        set bMenuMainPanelIsEnable = false
    endfunction

    function MenuOptionPanel_Init takes nothing returns nothing
        local integer frame
        // 地图设置
        set OriginFrame_MainPanel = DzFrameFindByName("MainPanel", 0) // 主菜单
        set OriginFrame_MainPanel_ReturnButton = DzFrameFindByName("ReturnButton", 0) // 主菜单返回按钮
        // EscMenuMapOptionsPanel做为父级UI,初始隐藏,隐藏EscMenuMapOptionsPanel时,子级UI会一起被隐藏

        set EscMenuMapOptionsPanel = DzCreateFrame("EscMenuMapOptionsPanel" , DzFrameFindByName("EscMenuMainPanel", 0), 0)
        call DzFrameSetAbsolutePoint(EscMenuMapOptionsPanel, FRAMEPOINT_CENTER, 0.4, 0.3)

        set frame = DzCreateFrameByTagName("TEXT", null, EscMenuMapOptionsPanel, "SetupPanelTitleText", 0)
        call DzFrameSetPoint(frame, FRAMEPOINT_CENTER, EscMenuMapOptionsPanel, 4, 0.14, 0.185)
        call DzFrameSetText(frame, "使用技能按键")
        set frame = DzCreateFrameByTagName("TEXT", null, EscMenuMapOptionsPanel, "SetupPanelTitleText", 0)
        call DzFrameSetPoint(frame, FRAMEPOINT_CENTER, EscMenuMapOptionsPanel, 4, 0.14, 0.065)
        call DzFrameSetText(frame, "学习技能按键")

        call DzFrameShow(EscMenuMapOptionsPanel, false)
        call DzFrameShow(EscMenuMapOptionsPanel, true )
        call DzFrameShow(EscMenuMapOptionsPanel, false)
        call DzFrameSetPriority(EscMenuMapOptionsPanel, 2)
        // 设置优先级 防止被背景挡住
        call DzFrameSetPriority(DzFrameFindByName("MapOptionsPanel", 0) ,  1)

        set EscMenuMapSetupBackdrop = DzCreateFrame("EscMenuMapSetupBackdrop", EscMenuMapOptionsPanel, 0)
        call DzFrameSetAbsolutePoint(EscMenuMapSetupBackdrop, FRAMEPOINT_CENTER, 0.4, 0.363)
        call DzFrameShow(EscMenuMapSetupBackdrop, false)

        set UIFrame__OrderSetup = DzCreateFrameByTagName("FRAME", null, EscMenuMapOptionsPanel, null, 0)

        globals
            integer     MapSetupReturnButton = 0
            integer     MapSetupResetButton  = 0
            integer     MapSetupOKButton     = 0
        endglobals

        set MapSetupReturnButton = DzFrameFindByName("MapSetupReturnButton", 0)
        set MapSetupResetButton  = DzFrameFindByName("MapSetupResetButton" , 0)
        set MapSetupOKButton     = DzFrameFindByName("MapSetupOKButton"    , 0)

        // 设置按钮 点击后会弹出EscMenuMapOptionsPanel
        set UIFrame__Button[0] = DzCreateFrame("MapSetupButton", DzFrameFindByName("InsideMainPanel", 0), 0)
        // 点击 地图设置(C)
        call DzFrameSetScriptByCode(UIFrame__Button[0], FRAMEEVENT_CONTROL_CLICK, function ClickMapSetupButton__Script, false)
        // 点击 菜单按钮
        call DzFrameSetScriptByCode(DzSimpleFrameFindByName("UpperButtonBarMenuButton", 0), FRAMEEVENT_CONTROL_CLICK, function Click_MenuMainButton_Script, false)
        
        call DzFrameSetScriptByCode(MapSetupReturnButton, FRAMEEVENT_CONTROL_CLICK, function ClickMapSetupReturnButton, false)
        call DzFrameSetScriptByCode(MapSetupResetButton , FRAMEEVENT_CONTROL_CLICK, function ClickMapSetupResetButton , false)
        call DzFrameSetScriptByCode(MapSetupOKButton    , FRAMEEVENT_CONTROL_CLICK, function ClickOrderSetupSaveButton, false)

        // 捕捉点击菜单的返回按钮
        call DzFrameSetScriptByCode(OriginFrame_MainPanel_ReturnButton, FRAMEEVENT_CONTROL_CLICK, function Click_MenuMainReturnButton_Script, false)

        call HotkeySystem_Init()
    endfunction


endscope
