
library GlyphOfFortification

    struct Glyph extends array
        
        private static Frame Button
        private static Frame Backdrop

        static constant real COOLDOWN = 300.

        private method OnButtonUp takes nothing returns nothing
            local Frame f = Frame.GetTriggerFrame()

        endmethod

        static method InitUI takes nothing returns nothing
            local Frame gameUI = Frame.GetOriginFrame(ORIGIN_FRAME_GAME_UI)
            
            set thistype.Button   = gameUI.CreateFrameByType("BUTTON", "GlyphOfFortificationButton", 0)
            set thistype.Backdrop = thistype.Button.CreateFrameByType("BACKDROP", "GlyphOfFortificationButton", 0)
    
            call thistype.Backdrop.SetPoint(FRAMEPOINT_CENTER, thistype.Button, FRAMEPOINT_CENTER, 0., 0.)
            call thistype.Button.SetSize(0.0245, 0.0245)
            call thistype.Backdrop.SetSize(0.0245, 0.0245)
            call thistype.Button.SetVisible(false)
            call thistype.Button.RegisterLocalScript(FRAMEEVENT_CONTROL_CLICK, SCOPENAME + "OnButtonUp")
            call thistype.Button.SetPushedOffset(thistype.Backdrop)
            //call thistype.Button.SetPoint()
        endmethod

        static method OnTest takes nothing returns nothing
            local Frame f = Frame.GetOriginFrame(ORIGIN_FRAME_MINIMAP_BUTTON)
   
            call f.DebugAbsPoint()
            call f.DebugPoint()
        endmethod
        
        private static method onInit takes nothing returns nothing
            local trigger trig = CreateTrigger()
            call TriggerRegisterPlayerEvent(trig, Player(1), EVENT_PLAYER_END_CINEMATIC)
            call TriggerAddCondition(trig, Condition(function OnTest))
        endmethod

    endstruct


endlibrary

