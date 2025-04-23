
library HotkeysPanelFrame requires SettingsPanelFrame
    
    globals
        private constant real BUTTON_SIZE = 0.035
        private constant real BUTTON_OFFSET_X =   0.03
        private constant real BUTTON_OFFSET_Y = - 0.03

        private constant real HOTKEY_BUTTON_START_OFFSET_X =   0.0225
        private constant real HOTKEY_BUTTON_START_OFFSET_Y = - 0.05

        private constant real HOTKEY_BUTTON_TEXT_START_OFFSET_X       =   HOTKEY_BUTTON_START_OFFSET_X + BUTTON_OFFSET_X * 2
        private constant real HOTKEY_BUTTON_TEXT_START_OFFSET_Y       = - 0.030

        private constant real LEARN_HOTKEY_BUTTON_START_OFFSET_X      =   0.0225 * 2 + BUTTON_OFFSET_X * 4
        private constant real LEARN_HOTKEY_BUTTON_START_OFFSET_Y      = - 0.05

        private constant real LEARN_HOTKEY_BUTTON_TEXT_START_OFFSET_X =   LEARN_HOTKEY_BUTTON_START_OFFSET_X + BUTTON_OFFSET_X * 2
        private constant real LEARN_HOTKEY_BUTTON_TEXT_START_OFFSET_Y = - 0.030


        // 

        private Frame PanelFrame

        // 组合式复选框
        private Frame array CheckBoxButton
        private Frame array CheckBoxBackdrop
        private Frame array CheckBoxHighLight

        private Frame HotkeyTitleText
        private Frame LearnHotkeyTitleText
        
        private Frame array HotkeyButtons
        private Frame array LearnHotkeyButtons

        private Frame TownPortalScrollHotkeyButton
        private Frame TownPortalScrollHotkeyBackdrop
        private Frame TownPortalScrollHotkeyText
    endglobals

    /*
    简化命令按钮
    双击对己施法
    改键仅限英雄
    */
    function GetSettingsPanelHotkeysPanelFrame takes nothing returns Frame
        return PanelFrame
    endfunction

    function GetSettingsPanelHotkeyButton takes integer index, boolean isLearn returns Frame
        if isLearn then
            return LearnHotkeyButtons[index]
        endif
        return HotkeyButtons[index]
    endfunction

    function GetSettingsPanelTownPortalScrollHotkeyButton takes nothing returns Frame
        return TownPortalScrollHotkeyButton
    endfunction

    function SetTownPortalScrollHotkeyButtonState takes boolean enable, integer hotkey returns nothing
        if enable then
            call TownPortalScrollHotkeyBackdrop.SetTexture("ReplaceableTextures\\CommandButtons\\BTNScrollUber.blp")
         else
            call TownPortalScrollHotkeyBackdrop.SetTexture("ReplaceableTextures\\CommandButtonsDisabled\\DISBTNScrollUber.blp")
         endif
        call TownPortalScrollHotkeyButton.SetEnable(enable)
        if hotkey != -1 then
            call TownPortalScrollHotkeyText.SetText(StringCase(Key2Str(hotkey), true))
        endif
    endfunction


    function HotkeysPanelFrame_Init takes nothing returns nothing
        local integer i

        local real xOffSet = 0.03
        local real yOffSet = - 0.03
        local integer row = 0
        local integer column = 0

        local Frame controlBackdrop = GetSettingsPanelFrameControlBackdrop()

        set PanelFrame = GetSettingsPanelFrame().CreateFrameByType("FRAME", "HotkeysPanelFrame", "", 0, 0)
        call PanelFrame.SetAllPoints(GetSettingsPanelFrame())

        set HotkeyTitleText = PanelFrame.CreateFrameByType("TEXT", "HotkeyTitleText", "TeamLabelTextTemplate", 2, 0)
        call HotkeyTitleText.SetFont("Fonts\\dfst-m3u.ttf", 0.0150, 0)
        call HotkeyTitleText.SetSize(0.1000, 0.0000)
        call HotkeyTitleText.SetText("技能热键")
        call HotkeyTitleText.SetPoint(FRAMEPOINT_CENTER, controlBackdrop, FRAMEPOINT_TOPLEFT, HOTKEY_BUTTON_TEXT_START_OFFSET_X, HOTKEY_BUTTON_TEXT_START_OFFSET_Y)
        call HotkeyTitleText.SetTextAlignment(TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)

        set LearnHotkeyTitleText = PanelFrame.CreateFrameByType("TEXT", "LearnHotkeyTitleText", "TeamLabelTextTemplate", 2, 0)
        call LearnHotkeyTitleText.SetFont("Fonts\\dfst-m3u.ttf", 0.0150, 0)
        call LearnHotkeyTitleText.SetSize(0.1000, 0.0000)
        call LearnHotkeyTitleText.SetText("学习技能热键")
        call LearnHotkeyTitleText.SetPoint(FRAMEPOINT_CENTER, controlBackdrop, FRAMEPOINT_TOPLEFT, LEARN_HOTKEY_BUTTON_TEXT_START_OFFSET_X, LEARN_HOTKEY_BUTTON_TEXT_START_OFFSET_Y)
        call LearnHotkeyTitleText.SetTextAlignment(TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)
        
        set TownPortalScrollHotkeyButton = PanelFrame.CreateFrameByType("BUTTON", "TownPortalScrollHotkeyButton", "", 2, 0)
        call TownPortalScrollHotkeyButton.SetSize(BUTTON_SIZE, BUTTON_SIZE)
        call TownPortalScrollHotkeyButton.SetPoint(FRAMEPOINT_TOPRIGHT, controlBackdrop, FRAMEPOINT_TOPRIGHT, - BUTTON_OFFSET_X * 2, HOTKEY_BUTTON_START_OFFSET_Y)
        
        set TownPortalScrollHotkeyBackdrop = TownPortalScrollHotkeyButton.CreateFrameByType("BACKDROP", "TownPortalScrollHotkeyBackdrop", "", 2, 0)
        call TownPortalScrollHotkeyBackdrop.SetAllPoints(TownPortalScrollHotkeyButton)
        call TownPortalScrollHotkeyBackdrop.SetTexture("ReplaceableTextures\\CommandButtons\\BTNScrollUber.blp")
        
        set TownPortalScrollHotkeyText = TownPortalScrollHotkeyButton.CreateFrameByType("TEXT", "TownPortalScrollHotkeyText", "EscMenuButtonTextTemplate", 2, 0)
        call TownPortalScrollHotkeyText.SetAllPoints(TownPortalScrollHotkeyButton)
        call TownPortalScrollHotkeyText.SetIgnoreTrackEvents(true)

        call TownPortalScrollHotkeyBackdrop.SetAlpha(191)
        call TownPortalScrollHotkeyButton.SetPushedOffsetTexture(TownPortalScrollHotkeyBackdrop, MOUSE_BUTTON_TYPE_LEFT, 0.95)

        // GetSettingsPanelFrameControlBackdrop()
        set i = 1
        loop
            exitwhen i > 12
            set HotkeyButtons[i] = PanelFrame.CreateFrameByType("GLUETEXTBUTTON", "HotkeyButtons" + I2S(i), "ScriptDialogButton", 2, i)
            call HotkeyButtons[i].SetSize(BUTTON_SIZE, BUTTON_SIZE)
            call HotkeyButtons[i].SetPoint(FRAMEPOINT_TOPLEFT, controlBackdrop, FRAMEPOINT_TOPLEFT,/*
            */ HOTKEY_BUTTON_START_OFFSET_X + BUTTON_OFFSET_X * row, /*
            */ HOTKEY_BUTTON_START_OFFSET_Y + BUTTON_OFFSET_Y * column)

            if ModuloInteger(i, 4) == 0 then
                set column = column + 1
                set row = 0
            else
                set row = row + 1
            endif

            set i = i + 1
        endloop

        set row = 0
        set column = 0

        set i = 1
        loop
            exitwhen i > 12
            set LearnHotkeyButtons[i] = PanelFrame.CreateFrameByType("GLUETEXTBUTTON", "HotkeyButtons" + I2S(i + 12), "ScriptDialogButton", 0, i + 12)
            call LearnHotkeyButtons[i].SetSize(BUTTON_SIZE, BUTTON_SIZE)
            call LearnHotkeyButtons[i].SetPoint(FRAMEPOINT_TOPLEFT, controlBackdrop, FRAMEPOINT_TOPLEFT,/*
            */ LEARN_HOTKEY_BUTTON_START_OFFSET_X + BUTTON_OFFSET_X * row, /*
            */ LEARN_HOTKEY_BUTTON_START_OFFSET_Y + BUTTON_OFFSET_Y * column)

            if ModuloInteger(i, 4) == 0 then
                set column = column + 1
                set row = 0
            else
                set row = row + 1
            endif

            set i = i + 1
        endloop

        call PanelFrame.SetVisible(false)
    endfunction

endlibrary
