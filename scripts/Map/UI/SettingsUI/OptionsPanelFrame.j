
library OptionsPanelFrame requires SettingsPanelFrame
    
    globals
        private Frame PanelFrame

        private constant real CHECKBOX_START_OFFSET_X                 =   0.015
        private constant real CHECKBOX_START_OFFSET_Y                 = - 0.015

        private constant real CHECKBOX_OFFSET_X                       = 0.1255
        private constant real CHECKBOX_OFFSET_Y                       = 0.0245
    endglobals

    function GetSettingsPanelOptionsPanelFrame takes nothing returns Frame
        return PanelFrame
    endfunction

    private function SetCheckBoxPoint takes Frame frame, integer row, integer column returns nothing
        local Frame   controlBackdrop = GetSettingsPanelFrameControlBackdrop()
        call frame.SetPoint(FRAMEPOINT_TOPLEFT, controlBackdrop, FRAMEPOINT_TOPLEFT, CHECKBOX_START_OFFSET_X + CHECKBOX_OFFSET_X * (row - 1), CHECKBOX_START_OFFSET_Y - CHECKBOX_OFFSET_Y * (column - 1))
    endfunction

    function OptionsPanelFrame_Init takes nothing returns nothing
        local Frame   frame

        set PanelFrame = GetSettingsPanelFrame().CreateFrameByType("FRAME", "OptionsPanelFrame", "", 0, 0)

        set frame = SettingsPanelCreateCheckBox(PanelFrame, PlayerSettings.AUTO_SELECT_SUMMONED_UNITS)
        call SetCheckBoxPoint(frame, 1, 1)

        set frame = SettingsPanelCreateCheckBox(PanelFrame, PlayerSettings.DOUBLE_TAP_ABILITY_TO_SELF_CAST)
        call SetCheckBoxPoint(frame, 1, 2)
        
        set frame = SettingsPanelCreateCheckBox(PanelFrame, PlayerSettings.TELEPORT_REQUIRES_HOLD_OR_STOP)
        call SetCheckBoxPoint(frame, 1, 3)

        set frame = SettingsPanelCreateCheckBox(PanelFrame, PlayerSettings.SHOW_COMMAND_BUTTON_COOLDOWN)
        call SetCheckBoxPoint(frame, 1, 4)
        

        set frame = SettingsPanelCreateCheckBox(PanelFrame, PlayerSettings.HOLDING_ALT_SHOWS_NEUTRAL_SPAWNBOXES)
        call SetCheckBoxPoint(frame, 2, 1)

        set frame = SettingsPanelCreateCheckBox(PanelFrame, PlayerSettings.HOLDING_ALT_SHOWS_TOWER_ATTACK_RANGE)
        call SetCheckBoxPoint(frame, 2, 2)
    endfunction

endlibrary
