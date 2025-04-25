
library HotkeysPanelFrame requires SettingsPanelFrame
    
    globals
        private constant real BUTTON_SIZE     = 0.035
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

        private constant real CHECKBOX_START_OFFSET_X                 = 0.0255
        private constant real CHECKBOX_START_OFFSET_Y                 = 0.0875

        private constant real CHECKBOX_OFFSET_X                       = 0.1255
        private constant real CHECKBOX_OFFSET_Y                       = 0.0245

        private Frame PanelFrame

        private Frame HotkeyTitleText
        private Frame LearnHotkeyTitleText
        
        private Frame array HotkeyButtons
        private Frame array LearnHotkeyButtons

        private Frame TownPortalScrollHotkeyButton
        private Frame TownPortalScrollHotkeyBackdrop
        private Frame TownPortalScrollHotkeyText

        private Frame GlyphHotkeyButton
        private Frame GlyphHotkeyBackdrop
        private Frame GlyphHotkeyText
    endglobals

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

    function SetSettingsPanelTownPortalScrollHotkeyButtonState takes boolean enable returns nothing
        if enable then
            call TownPortalScrollHotkeyBackdrop.SetTexture("ReplaceableTextures\\CommandButtons\\BTNScrollUber.blp")
        else
            call TownPortalScrollHotkeyBackdrop.SetTexture("ReplaceableTextures\\CommandButtonsDisabled\\DISBTNScrollUber.blp")
        endif
        call TownPortalScrollHotkeyButton.SetEnable(enable)
    endfunction
    function SetSettingsPanelTownPortalScrollHotkeyButtonHotkey takes integer hotkey returns nothing
        call TownPortalScrollHotkeyText.SetText(StringCase(Key2Str(hotkey), true))
    endfunction

    function GetSettingsPanelGlyphHotkeyButton takes nothing returns Frame
        return GlyphHotkeyButton
    endfunction
    function SetSettingsPanelGlyphHotkeyButtonState takes boolean enable returns nothing
        if enable then
            if GetPlayerId(GetLocalPlayer()) <= 5 then
                call GlyphHotkeyBackdrop.SetTexture("ReplaceableTextures\\CommandButtons\\BTNGlyph.blp")
            else
                call GlyphHotkeyBackdrop.SetTexture("ReplaceableTextures\\CommandButtons\\BTNGlyphScourge.blp")
            endif
        else
            if GetPlayerId(GetLocalPlayer()) <= 5 then
                call GlyphHotkeyBackdrop.SetTexture("ReplaceableTextures\\CommandButtonsDisabled\\DISBTNGlyph.blp")
            else
                call GlyphHotkeyBackdrop.SetTexture("ReplaceableTextures\\CommandButtonsDisabled\\DISBTNGlyphScourge.blp")
            endif
        endif
        call GlyphHotkeyButton.SetEnable(enable)
    endfunction
    function SetSettingsPanelGlyphHotkeyButtonHotkey takes integer hotkey returns nothing
        call GlyphHotkeyText.SetText(StringCase(Key2Str(hotkey), true))
    endfunction

    function HotkeysPanelFrame_Init takes nothing returns nothing
        local integer i

        local real    xOffSet = 0.03
        local real    yOffSet = - 0.03
        local integer row     = 0
        local integer column  = 0

        local Frame   controlBackdrop = GetSettingsPanelFrameControlBackdrop()
        local Frame   frame

        set PanelFrame = GetSettingsPanelFrame().CreateFrameByType("FRAME", "HotkeysPanelFrame", "", 0, 0)
        call PanelFrame.SetAllPoints(GetSettingsPanelFrame())

        set HotkeyTitleText = PanelFrame.CreateFrameByType("TEXT", "HotkeyTitleText", "TeamLabelTextTemplate", 2, 0)
        call HotkeyTitleText.SetFont("Fonts\\dfst-m3u.ttf", 0.0150, 0)
        call HotkeyTitleText.SetSize(0.1000, 0.0000)
        call HotkeyTitleText.SetText("热键")
        call HotkeyTitleText.SetPoint(FRAMEPOINT_CENTER, controlBackdrop, FRAMEPOINT_TOPLEFT, HOTKEY_BUTTON_TEXT_START_OFFSET_X, HOTKEY_BUTTON_TEXT_START_OFFSET_Y)
        call HotkeyTitleText.SetTextAlignment(TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)

        set LearnHotkeyTitleText = PanelFrame.CreateFrameByType("TEXT", "LearnHotkeyTitleText", "TeamLabelTextTemplate", 2, 0)
        call LearnHotkeyTitleText.SetFont("Fonts\\dfst-m3u.ttf", 0.0150, 0)
        call LearnHotkeyTitleText.SetSize(0.1000, 0.0000)
        call LearnHotkeyTitleText.SetText("学习技能热键")
        call LearnHotkeyTitleText.SetPoint(FRAMEPOINT_CENTER, controlBackdrop, FRAMEPOINT_TOPLEFT, LEARN_HOTKEY_BUTTON_TEXT_START_OFFSET_X, LEARN_HOTKEY_BUTTON_TEXT_START_OFFSET_Y)
        call LearnHotkeyTitleText.SetTextAlignment(TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)
        
        // 回城卷轴
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

        // 防御符文
        set GlyphHotkeyButton = PanelFrame.CreateFrameByType("BUTTON", "GlyphHotkeyButton", "", 2, 0)
        call GlyphHotkeyButton.SetSize(BUTTON_SIZE, BUTTON_SIZE)
        call GlyphHotkeyButton.SetPoint(FRAMEPOINT_TOPRIGHT, controlBackdrop, FRAMEPOINT_TOPRIGHT, - BUTTON_OFFSET_X * 2, HOTKEY_BUTTON_START_OFFSET_Y + BUTTON_OFFSET_Y * 1.5)

        set GlyphHotkeyBackdrop = GlyphHotkeyButton.CreateFrameByType("BACKDROP", "GlyphHotkeyBackdrop", "", 2, 0)
        call GlyphHotkeyBackdrop.SetAllPoints(GlyphHotkeyButton)
        call GlyphHotkeyBackdrop.SetTexture("ReplaceableTextures\\CommandButtons\\BTNGlyph.blp")

        set GlyphHotkeyText = GlyphHotkeyButton.CreateFrameByType("TEXT", "GlyphHotkeyText", "EscMenuButtonTextTemplate", 2, 0)
        call GlyphHotkeyText.SetAllPoints(GlyphHotkeyButton)
        call GlyphHotkeyText.SetIgnoreTrackEvents(true)

        call GlyphHotkeyBackdrop.SetAlpha(191)
        call GlyphHotkeyButton.SetPushedOffsetTexture(GlyphHotkeyBackdrop, MOUSE_BUTTON_TYPE_LEFT, 0.95)

        // GetSettingsPanelFrameControlBackdrop()
        set i = 1
        loop
            exitwhen i > 12
            set HotkeyButtons[i] = PanelFrame.CreateFrameByType("GLUETEXTBUTTON", "HotkeyButtons" + I2S(i), "ScriptDialogButton", 2, i)
            call HotkeyButtons[i].SetSize(BUTTON_SIZE, BUTTON_SIZE)
            call HotkeyButtons[i].SetPoint(FRAMEPOINT_TOPLEFT, controlBackdrop, FRAMEPOINT_TOPLEFT,/*
            */ HOTKEY_BUTTON_START_OFFSET_X + BUTTON_OFFSET_X * row, /*
            */ HOTKEY_BUTTON_START_OFFSET_Y + BUTTON_OFFSET_Y * column)

            if ModuloInteger(i, 3) == 0 then
                set row = row + 1
                set column = 0
            else
                set column = column + 1
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

            if ModuloInteger(i, 3) == 0 then
                set row = row + 1
                set column = 0
            else
                set column = column + 1
            endif

            set i = i + 1
        endloop

        /*
        启用改键系统
        简化命令按钮
        双击对己施法
        改键仅限英雄
        */
        
        // 复选框

        set frame = SettingsPanelCreateCheckBox(PanelFrame, PlayerSettings.ENABLE_HOTKEY_SYSTEM)
        call frame.SetPoint(FRAMEPOINT_BOTTOMLEFT, controlBackdrop, FRAMEPOINT_BOTTOMLEFT, CHECKBOX_START_OFFSET_X, CHECKBOX_START_OFFSET_Y)

        set frame = SettingsPanelCreateCheckBox(PanelFrame, PlayerSettings.HIDE_COMMAND_BUTTON)
        call frame.SetPoint(FRAMEPOINT_BOTTOMLEFT, controlBackdrop, FRAMEPOINT_BOTTOMLEFT, /*
        */ CHECKBOX_START_OFFSET_X, CHECKBOX_START_OFFSET_Y - CHECKBOX_OFFSET_Y)

        //set frame = SettingsPanelCreateCheckBox(PanelFrame, PlayerSettings.DOUBLE_TAP_ABILITY_TO_SELF_CAST)
        //call frame.SetPoint(FRAMEPOINT_BOTTOMLEFT, controlBackdrop, FRAMEPOINT_BOTTOMLEFT, /*
        //*/ CHECKBOX_START_OFFSET_X, CHECKBOX_START_OFFSET_Y - CHECKBOX_OFFSET_Y * 2)

        set frame = SettingsPanelCreateCheckBox(PanelFrame, PlayerSettings.CHANGE_KEY_ONLY_HERO)
        call frame.SetPoint(FRAMEPOINT_BOTTOMLEFT, controlBackdrop, FRAMEPOINT_BOTTOMLEFT, /*
        */ CHECKBOX_START_OFFSET_X + CHECKBOX_OFFSET_X, CHECKBOX_START_OFFSET_Y)

        set frame = SettingsPanelCreateCheckBox(PanelFrame, PlayerSettings.SHOW_COMMAND_BUTTON_HOTKEY)
        call frame.SetPoint(FRAMEPOINT_BOTTOMLEFT, controlBackdrop, FRAMEPOINT_BOTTOMLEFT, /*
        */ CHECKBOX_START_OFFSET_X + CHECKBOX_OFFSET_X, CHECKBOX_START_OFFSET_Y - CHECKBOX_OFFSET_Y)
        

        call PanelFrame.SetVisible(false)
    endfunction

endlibrary
