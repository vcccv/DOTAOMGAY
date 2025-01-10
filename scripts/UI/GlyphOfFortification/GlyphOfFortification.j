
library GlyphOfFortification

    struct Glyph extends array
        
        private static Frame Button
        private static Frame Backdrop
        private static Frame Sprite

        static constant real COOLDOWN = 300.

        private timer t

        private static method OnButtonUp takes nothing returns boolean
            local Frame f = Frame.GetTriggerFrame()

            if MHMsg_IsKeyDown(OSKEY_ALT) then
                call PlayerChat.SendChatToAll("冷却中", CHAT_CHANNEL_ALLY)
                return false
            endif
            
            return false
        endmethod

        // minmapButton父级为MiniMapButtonBar(SimpleFrame), 锚点为ConsoleUI
        static method InitUI takes nothing returns nothing
            local Frame minimapSignalButton = Frame.GetOriginFrame(ORIGIN_FRAME_MINIMAP_BUTTON, 0)
            local Frame minimapButtonBar    = minimapSignalButton.GetParent()
            local Frame relativeFrame       = Frame.GetOriginFrame(ORIGIN_FRAME_SIMPLE_UI_PARENT, 0)

            set thistype.Button   = minimapButtonBar.CreateSimpleFrame("GlyphButton", 0)
            set thistype.Backdrop = thistype.Button.GetSimpleButtonTexture(SIMPLEBUTTON_STATE_ENABLE)
            //set thistype.Sprite   = Frame.GetOriginFrame(ORIGIN_FRAME_GAME_UI, 0).CreateFrameByType("SPRITE", "", "", 0)

            call thistype.Button.SetSize(0.0245, 0.0245)
            call thistype.Backdrop.SetSize(0.0245, 0.0245)
            call thistype.Button.SetPoint(FRAMEPOINT_TOPLEFT, relativeFrame, FRAMEPOINT_BOTTOMLEFT, 0.154, 0.028)

            if User.LocalId < 5 then
                call thistype.Backdrop.SetTexture("ReplaceableTextures\\CommandButtons\\BTNGlyph.blp", 0, false)
            else
                call thistype.Backdrop.SetTexture("ReplaceableTextures\\CommandButtons\\BTNGlyphScourge.blp", 0, false)
            endif

            //call thistype.Button.SetVisible(false)
            call thistype.Button.RegisterLocalScript(FRAMEEVENT_CONTROL_CLICK, thistype.OnButtonUp.name)
        endmethod

        static method OnTest takes nothing returns nothing
            local Frame f = Frame.GetOriginFrame(ORIGIN_FRAME_MINIMAP_BUTTON, 0)
   
            call BJDebugMsg(MHMath_ToHex(MHFrame_GetParent(MHUIData_GetCommandButtonCooldownFrame(MHUI_GetSkillBarButton(1)))))
            call BJDebugMsg(MHMath_ToHex(MHUIData_GetCommandButtonCooldownFrame(MHUI_GetSkillBarButton(1))))
            call BJDebugMsg(MHMath_ToHex((MHUI_GetSkillBarButton(1))))
            //call f.DebugAbsPoint()
            //call f.DebugPoint()
//
            //set f = Frame.GetOriginFrame(ORIGIN_FRAME_MINIMAP_BUTTON, 1)
            //call f.DebugPoint()
//
            //set f = Frame.GetOriginFrame(ORIGIN_FRAME_MINIMAP_BUTTON, 2)
            //call f.DebugPoint()
//
            //set f = Frame.GetOriginFrame(ORIGIN_FRAME_MINIMAP_BUTTON, 3)
            //call f.DebugPoint()
//
            //set f = Frame.GetOriginFrame(ORIGIN_FRAME_MINIMAP_BUTTON, 4)
            //call f.DebugPoint()

            //call BJDebugMsg("ORIGIN_FRAME_MINIMAP:" + MHMath_ToHex(Frame.GetOriginFrame(ORIGIN_FRAME_MINIMAP, 0).GetPtr()))
        endmethod
        
        private static method onInit takes nothing returns nothing
            local trigger trig = CreateTrigger()
            call TriggerRegisterPlayerEvent(trig, Player(1), EVENT_PLAYER_END_CINEMATIC)
            call TriggerAddCondition(trig, Condition(function thistype.OnTest))
        endmethod

    endstruct


endlibrary

