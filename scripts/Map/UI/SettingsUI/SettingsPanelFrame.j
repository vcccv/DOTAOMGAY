
library SettingsPanelFrame requires UISystem
   
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
    endglobals

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

        // call PanelFrame.SetVisible(false)
        call PanelFrame.SetVisible(false)
        call PanelFrame.SetVisible(true)
    endfunction
    
endlibrary
