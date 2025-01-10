
library GlyphOfFortification

    struct Glyph extends array
        
        private static Frame Button
        private static Frame Backdrop

        static constant real COOLDOWN = 300.

        private method OnButtonUp takes nothing returns nothing
            local Frame f = Frame.GetTriggerFrame()

        endmethod

        static method InitUI takes nothing returns nothing
            //local Frame gameUI = Frame.GetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
            local Frame minimapButtonBar = Frame.GetOriginFrame(ORIGIN_FRAME_MINIMAP_BUTTON, 0).GetParent()
            call DzLoadToc("UI\\path.toc")
            set thistype.Button   = minimapButtonBar.CreateFrame("GlyphButton", 0, 0)
            set thistype.Backdrop = Frame.GetFrameByName("GlyphTexture", 0)
    
            call thistype.Backdrop.SetPoint(FRAMEPOINT_CENTER, thistype.Button, FRAMEPOINT_CENTER, 0., 0.)
            call thistype.Button.SetSize(0.0245, 0.0245)
            call thistype.Backdrop.SetSize(0.0245, 0.0245)
            //call thistype.Button.SetVisible(false)
            call thistype.Button.RegisterLocalScript(FRAMEEVENT_CONTROL_CLICK, SCOPE_PRIVATE + "OnButtonUp")
            call thistype.Button.SetPushedOffset(thistype.Backdrop)
            
            call BJDebugMsg("thistype.Button:" + I2S(thistype.Button) + " ptr:" + I2S(thistype.Button.GetPtr()))
            call BJDebugMsg("thistype.Backdrop:" + I2S(thistype.Backdrop) + " ptr:" + I2S(thistype.Backdrop.GetPtr()))

            call BJDebugMsg("minimapButtonBar:" + I2S(minimapButtonBar) + " ptr:" + I2S(minimapButtonBar.GetPtr()))
            //call thistype.Button.SetAbsPoint(FRAMEPOINT_CENTER, 0.4, 0.3)

            call thistype.Button.SetPoint(FRAMEPOINT_TOPLEFT, minimapButtonBar, FRAMEPOINT_BOTTOMLEFT, 0.154, 0.122)
            call thistype.Backdrop.SetTexture("ReplaceableTextures\\CommandButtons\\BTNGlyph.blp", 0, false)

            call BJDebugMsg("InitUI")
        endmethod

        static method OnTest takes nothing returns nothing
            local Frame f = Frame.GetOriginFrame(ORIGIN_FRAME_MINIMAP_BUTTON, 0)
   
            //call f.DebugAbsPoint()
            call f.DebugPoint()

            set f = Frame.GetOriginFrame(ORIGIN_FRAME_MINIMAP_BUTTON, 1)
            call f.DebugPoint()

            set f = Frame.GetOriginFrame(ORIGIN_FRAME_MINIMAP_BUTTON, 4)
            call f.DebugPoint()

            call BJDebugMsg("ORIGIN_FRAME_MINIMAP:" + MHMath_ToHex(Frame.GetOriginFrame(ORIGIN_FRAME_MINIMAP, 0).GetPtr()))
        endmethod
        
        private static method onInit takes nothing returns nothing
            local trigger trig = CreateTrigger()
            call TriggerRegisterPlayerEvent(trig, Player(1), EVENT_PLAYER_END_CINEMATIC)
            call TriggerAddCondition(trig, Condition(function thistype.OnTest))
        endmethod

    endstruct


endlibrary

