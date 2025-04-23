
library OptionsPanelFrame requires SettingsPanelFrame
    
    globals
        private Frame PanelFrame


    endglobals

    function GetSettingsPanelOptionsPanelFrame takes nothing returns Frame
        return PanelFrame
    endfunction

    function OptionsPanelFrame_Init takes nothing returns nothing
        
        set PanelFrame = GetSettingsPanelFrame().CreateFrameByType("FRAME", "OptionsPanelFrame", "", 0, 0)
    endfunction

endlibrary
