
library GlyphOfFortification

    struct Glyph extends array
        
        private static Frame Button
        private static Frame Backdrop

        constant static real COOLDOWN = 300.

        private method OnButtonUp takes nothing returns nothing
            local Frame f = Frame.GetTriggerFrame()

        endmethod

        static method InitUI takes nothing returns nothing
            local Frame gameUI = Frame.GetOriginFrame(ORIGIN_FRAME_GAME_UI)

            set thistype.Button   = Frame.CreateFrameByType("BUTTON", "GlyphOfFortificationButton", gameUI, 0)
            set thistype.Backdrop = Frame.CreateFrameByType("BACKDROP", "GlyphOfFortificationButton", thistype.Button, 0)
    
            call thistype.Backdrop.SetPoint(FRAMEPOINT_CENTER, thistype.Button, FRAMEPOINT_CENTER, 0., 0.)
            call thistype.Button.SetSize(0.0245, 0.0245)
            call thistype.Backdrop.SetSize(0.0245, 0.0245)
            call thistype.Button.SetVisible(false)
            call thistype.Button.RegisterLocalScript(FRAMEEVENT_CONTROL_CLICK, SCOPENAME + "OnButtonUp")
            call thistype.Button.SetPushedOffset(thistype.Backdrop)
            //call thistype.Button.SetPoint()
        endmethod
        
        private static method onInit takes nothing returns nothing
            local trigger trig = 
        endmethod

    endstruct


endlibrary

