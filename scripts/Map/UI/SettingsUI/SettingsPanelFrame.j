
library SettingsPanelFrame requires UISystem, SimpleToolTipLib
   
    globals
        private constant real PANEL_BUTTON_WIDTH  = 0.075
        private constant real PANEL_BUTTON_HEIGHT = 0.035

        private constant real PANEL_CONTROL_BACKDROP_OFFSET_LEFT   =   0.035
        private constant real PANEL_CONTROL_BACKDROP_OFFSET_RIGHT  = - 0.035
        private constant real PANEL_CONTROL_BACKDROP_OFFSET_TOP    = - PANEL_BUTTON_HEIGHT * 2
        private constant real PANEL_CONTROL_BACKDROP_OFFSET_BOTTOM =   0.035

        private Frame PenalSimpleButton

        private Frame PanelFrame
        private Frame PanelBackdrop
        private Frame PanelReturnButton
        
        private Frame HotkeysPanelButton
        private Frame HotkeysPanelButtonBackdrop
        private Frame HotkeysPanelButtonHighlight
        private Frame HotkeysPanelButtonText

        private Frame OptionsPanelButton
        private Frame OptionsPanelButtonBackdrop
        private Frame OptionsPanelButtonHighlight
        private Frame OptionsPanelButtonText

        // 里面的背景
        private Frame PanelControlBackdrop

        private constant real CHECKBOX_TEXT_OFFSET_X                  = 0.000

        // 组合式复选框
        private Frame array CheckBox
        private Frame array CheckBoxHighLight
        private Frame array CheckBoxText

        private Frame array CheckBoxToolTipFrame
        private Frame array CheckBoxToolTipText
        private Frame array CheckBoxToolTipExtendedText
        
        private integer array CheckBoxIndex
    endglobals

    function GetSettingsPanelCheckBoxIndex takes Frame checkBox returns integer
        return CheckBoxIndex[checkBox]
    endfunction
    
    function GetSettingsPanelCheckBoxByIndex takes integer index returns Frame
        return CheckBox[index]
    endfunction
    function GetSettingsPanelCheckBoxHighLightByIndex takes integer index returns Frame
        return CheckBoxHighLight[index]
    endfunction
    
    function SettingsPanelCheckBoxSetActivatByIndex takes integer index, boolean activation returns nothing
        if CheckBoxHighLight[index] <= 0 then
            return
        endif
        call CheckBoxHighLight[index].SetVisible(activation)
    endfunction
    function IsSettingsPanelCheckBoxActivatedByIndex takes integer index returns boolean
        if CheckBoxHighLight[index] <= 0 then
            return false
        endif
        return CheckBoxHighLight[index].IsVisible()
    endfunction

    function SettingsPanelCheckBoxSetEnableByIndex takes integer index, boolean enable returns nothing
        if CheckBox[index] <= 0 then
            return
        endif
        call CheckBox[index].SetEnable(enable)
    endfunction
    function SettingsPanelCheckBoxSetTextByIndex takes integer index, string value returns nothing
        if CheckBoxText[index] <= 0 then
            return
        endif
        call CheckBoxText[index].SetText(value)
    endfunction

    private function CheckBoxOnEnterASync takes nothing returns nothing
        local Frame   frame = Frame.GetTriggerFrame()
        local integer index = CheckBoxIndex[frame]
        local real    height = 0.005 * 3

        call CheckBoxToolTipFrame[index].SetVisible(true)

        // 更新高度
        set height = height + CheckBoxToolTipText[index].GetHeight()
        set height = height + CheckBoxToolTipExtendedText[index].GetHeight()
        call CheckBoxToolTipFrame[index].SetHeight(height)
    endfunction

    private function CheckBoxOnLeaveASync takes nothing returns nothing
        local Frame   frame = Frame.GetTriggerFrame()
        local integer index = CheckBoxIndex[frame]
        call CheckBoxToolTipFrame[index].SetVisible(false)
    endfunction

    private function CreateCheckBoxTooltipFrame takes integer index returns nothing
        if CheckBoxToolTipFrame[index] != 0 then
            return
        endif
        set CheckBoxToolTipFrame[index] = PanelFrame.CreateFrame("SettingsPanelTooltipFrame", 10, index)
        call CheckBoxToolTipFrame[index].SetPoint(FRAMEPOINT_BOTTOMLEFT, CheckBox[index], FRAMEPOINT_TOPRIGHT, 0., 0.)
        call CheckBoxToolTipFrame[index].SetVisible(false)

        set CheckBoxToolTipText[index]         = Frame.GetFrameByName("SettingsPanelTooltipText", index)
        set CheckBoxToolTipExtendedText[index] = Frame.GetFrameByName("SettingsPanelTooltipExtendedText", index)

        call CheckBox[index].RegisterEventByCode(EVENT_ID_FRAME_MOUSE_ENTER, function CheckBoxOnEnterASync, false)
        call CheckBox[index].RegisterEventByCode(EVENT_ID_FRAME_MOUSE_LEAVE, function CheckBoxOnLeaveASync, false)
    endfunction
    
    function SettingsPanelCheckBoxSetTooltipByIndex takes integer index, string tip, string ubertip returns nothing
        local Frame frame
        local real  height = 0.005 * 3

        call CreateCheckBoxTooltipFrame(index)
        if CheckBoxToolTipFrame[index] <= 0 then
            return
        endif
        
        call CheckBoxToolTipText[index].SetText(tip)
        call CheckBoxToolTipExtendedText[index].SetText(ubertip)

        set height = height + CheckBoxToolTipText[index].GetHeight()
        set height = height + CheckBoxToolTipExtendedText[index].GetHeight()
        call CheckBoxToolTipFrame[index].SetHeight(height)
    endfunction

    function SettingsPanelCreateCheckBox takes Frame parent, integer index returns Frame
        set CheckBox[index]          = parent.CreateFrameByType("GLUECHECKBOX", "", "SettingsCheckBox", 0, index)
        set CheckBoxHighLight[index] = CheckBox[index].CreateFrameByType("HIGHLIGHT", "", "SettingsCheckBoxHighLight", 0, index)
        set CheckBoxText[index]      = CheckBox[index].CreateFrameByType("TEXT", "", "EscMenuMainPanelDialogTextTemplate", 0, index)
        call CheckBoxHighLight[index].SetVisible(false)
        call CheckBoxText[index].SetPoint(FRAMEPOINT_LEFT, CheckBox[index], FRAMEPOINT_RIGHT, CHECKBOX_TEXT_OFFSET_X, 0.)
        set CheckBoxIndex[CheckBox[index]] = index

        return CheckBox[index]
    endfunction

    function GetSettingsPanelSimpleButton takes nothing returns Frame
        return PenalSimpleButton
    endfunction

    function GetSettingsPanelFrame takes nothing returns Frame
        return PanelFrame
    endfunction

    function GetSettingsPanelFrameControlBackdrop takes nothing returns Frame
        return PanelControlBackdrop
    endfunction

    function GetSettingsPanelFrameReturnButton takes nothing returns Frame
        return PanelReturnButton
    endfunction

    // 1 == 热键
    // 2 == 选项
    function GetSettinsPanelButtonByIndex takes integer index returns Frame
        if index == 1 then
            return HotkeysPanelButton
        else
            return OptionsPanelButton
        endif
        return 0
    endfunction

    function ShowSettinsPanelButtonHighLightByIndex takes integer index, boolean isShow returns nothing
        if index == 1 then
            call HotkeysPanelButtonHighlight.SetVisible(isShow)
        else
            call OptionsPanelButtonHighlight.SetVisible(isShow)
        endif
    endfunction

    function SettingsPanelFrame_Init takes nothing returns nothing
        set PenalSimpleButton = Frame.GetFrameByName("UpperButtonBarFrame", 0).CreateSimpleFrame("SettingsBarButton", 0)
        
        set PanelFrame = Frame.GetOriginFrame(ORIGIN_FRAME_GAME_UI, 0).CreateFrame("SettingsPanelFrame", 0, 0)
        
        set PanelBackdrop = PanelFrame.CreateFrameByType("BACKDROP", "SettingsPanelBackdrop", "EscMenuBackdrop", -1, 0)
        call PanelBackdrop.SetAllPoints(PanelFrame)
        
        call PanelFrame.SetSize(0.475, 0.3750)
        call PanelFrame.SetAbsPoint(FRAMEPOINT_CENTER, 0.4, 0.355)

        set PanelReturnButton = Frame.GetFrameByName("SettingsPanelReturnButton", 0)
        call PanelReturnButton.SetLevel(9)
        ////call PanelReturnButton.ClearAllPoints()
        //call PanelReturnButton.SetSize(PANEL_BUTTON_WIDTH, PANEL_BUTTON_HEIGHT)
        ////call PanelReturnButton.SetPoint(FRAMEPOINT_TOPRIGHT, PanelFrame, FRAMEPOINT_TOPRIGHT, - 0.035, - 0.035)
        //call PanelReturnButton.SetText("退出")
        //call BJDebugMsg("PanelReturnButton:" + I2S(PanelReturnButton.GetPtr()))
        
        set PanelControlBackdrop = PanelFrame.CreateFrameByType("BACKDROP", "PanelControlBackdrop", "EscMenuControlBackdropTemplate", 0, 0)
        call PanelControlBackdrop.SetPoint(FRAMEPOINT_TOPLEFT , PanelFrame, FRAMEPOINT_TOPLEFT , PANEL_CONTROL_BACKDROP_OFFSET_LEFT , PANEL_CONTROL_BACKDROP_OFFSET_TOP)
        call PanelControlBackdrop.SetPoint(FRAMEPOINT_TOPRIGHT, PanelFrame, FRAMEPOINT_TOPRIGHT, PANEL_CONTROL_BACKDROP_OFFSET_RIGHT, PANEL_CONTROL_BACKDROP_OFFSET_TOP)

        call PanelControlBackdrop.SetPoint(FRAMEPOINT_BOTTOMLEFT , PanelFrame, FRAMEPOINT_BOTTOMLEFT , PANEL_CONTROL_BACKDROP_OFFSET_LEFT , PANEL_CONTROL_BACKDROP_OFFSET_BOTTOM)
        call PanelControlBackdrop.SetPoint(FRAMEPOINT_BOTTOMRIGHT, PanelFrame, FRAMEPOINT_BOTTOMRIGHT, PANEL_CONTROL_BACKDROP_OFFSET_RIGHT, PANEL_CONTROL_BACKDROP_OFFSET_BOTTOM)

        // Hotkeys
        set HotkeysPanelButton = PanelFrame.CreateFrameByType("BUTTON", "HotkeysPanelButton", "", 1, 0)
        call HotkeysPanelButton.SetPoint(FRAMEPOINT_TOPLEFT, PanelFrame, FRAMEPOINT_TOPLEFT, 0.035, - 0.035)
        call HotkeysPanelButton.SetSize(PANEL_BUTTON_WIDTH, PANEL_BUTTON_HEIGHT)

        set HotkeysPanelButtonBackdrop  = HotkeysPanelButton.CreateFrameByType("BACKDROP", "HotkeysPanelButtonBackdrop", "QuestButtonBaseTemplate", 1, 0)
        call HotkeysPanelButtonBackdrop.SetSize(PANEL_BUTTON_WIDTH, PANEL_BUTTON_HEIGHT)
        call HotkeysPanelButtonBackdrop.SetPoint(FRAMEPOINT_CENTER, HotkeysPanelButton, FRAMEPOINT_CENTER, 0., 0.)

        set HotkeysPanelButtonHighlight = HotkeysPanelButton.CreateFrameByType("HIGHLIGHT", "HotkeysPanelButtonHighlight", "QuestButtonMouseOverHighlightTemplate", 1, 0)
        call HotkeysPanelButtonHighlight.SetPoint(FRAMEPOINT_CENTER, HotkeysPanelButton, FRAMEPOINT_CENTER, 0., 0.)
        call HotkeysPanelButtonHighlight.SetSize(PANEL_BUTTON_WIDTH, PANEL_BUTTON_HEIGHT)

        set HotkeysPanelButtonText = HotkeysPanelButton.CreateFrameByType("TEXT", "HotkeysPanelButtonText", "TeamLabelTextTemplate", 2, 0)
        call HotkeysPanelButtonText.SetAllPoints(HotkeysPanelButton)
        call HotkeysPanelButtonText.SetTextAlignment(TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)
        call HotkeysPanelButtonText.SetIgnoreTrackEvents(true)
        call HotkeysPanelButtonText.SetText("热键")

        call HotkeysPanelButtonHighlight.SetVisible(false)
        
        // Options
        set OptionsPanelButton = PanelFrame.CreateFrameByType("BUTTON", "OptionsPanelButton", "", 1, 0)
        call OptionsPanelButton.SetPoint(FRAMEPOINT_TOPLEFT, HotkeysPanelButton, FRAMEPOINT_TOPRIGHT, 0., 0.)
        call OptionsPanelButton.SetSize(PANEL_BUTTON_WIDTH, PANEL_BUTTON_HEIGHT)

        set OptionsPanelButtonBackdrop  = OptionsPanelButton.CreateFrameByType("BACKDROP", "OptionsPanelButtonBackdrop", "QuestButtonBaseTemplate", 1, 0)
        call OptionsPanelButtonBackdrop.SetSize(PANEL_BUTTON_WIDTH, PANEL_BUTTON_HEIGHT)
        call OptionsPanelButtonBackdrop.SetPoint(FRAMEPOINT_CENTER, OptionsPanelButton, FRAMEPOINT_CENTER, 0., 0.)

        set OptionsPanelButtonHighlight = OptionsPanelButton.CreateFrameByType("HIGHLIGHT", "OptionsPanelButtonHighlight", "QuestButtonMouseOverHighlightTemplate", 1, 0)
        call OptionsPanelButtonHighlight.SetPoint(FRAMEPOINT_CENTER, OptionsPanelButton, FRAMEPOINT_CENTER, 0., 0.)
        call OptionsPanelButtonHighlight.SetSize(PANEL_BUTTON_WIDTH, PANEL_BUTTON_HEIGHT)

        set OptionsPanelButtonText = OptionsPanelButton.CreateFrameByType("TEXT", "OptionsPanelButtonText", "TeamLabelTextTemplate", 2, 0)
        call OptionsPanelButtonText.SetAllPoints(OptionsPanelButton)
        call OptionsPanelButtonText.SetTextAlignment(TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)
        call OptionsPanelButtonText.SetIgnoreTrackEvents(true)
        call OptionsPanelButtonText.SetText("选项")

        call OptionsPanelButtonHighlight.SetVisible(false)

        call PanelFrame.SetVisible(false)
        call PanelFrame.SetVisible(true)
        
        call PanelFrame.SetVisible(false)
    endfunction
    
endlibrary
