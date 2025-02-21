
library TownPortalScrollFrame requires UISystem
    
    globals
        private Frame TownPortalScrollFrame
        private Frame TownPortalScrollButton
        private Frame TownPortalScrollBackground
        private Frame TownPortalScrollCooldownSprite
        private Frame TownPortalScrollCooldownString
    endglobals

    function TownPortalScrollButtonOnClick takes nothing returns nothing
        call BJDebugMsg("click!")
    endfunction

    function TownPortalScrollFrame_Init takes nothing returns nothing
        local Frame gameUI     = Frame.GetPtrInstance(MHUI_GetGameUI())
        local Frame commandBar = Frame.GetPtrInstance(MHUI_GetCommandBar())

        set TownPortalScrollFrame = commandBar.CreateSimpleFrame("TownPortalScrollFrame", 0)
        set TownPortalScrollCooldownSprite = gameUI.CreateFrame("TownPortalScrollCooldownSprite", 0, 0)

        set TownPortalScrollCooldownString   = Frame.GetFrameByName("TownPortalScrollCooldownString", 0)
        set TownPortalScrollButton           = Frame.GetFrameByName("TownPortalScrollButton", 0)
        set TownPortalScrollBackground       = TownPortalScrollButton.GetSimpleButtonTexture(SIMPLEBUTTON_STATE_ENABLE)

        call TownPortalScrollCooldownSprite.SetAllPoints(TownPortalScrollFrame)
        call TownPortalScrollCooldownSprite.SetSpriteAnimate(0, 0)
        call TownPortalScrollCooldownSprite.SetAnimateOffset(0.5)

        call TownPortalScrollFrame.SetAbsPoint(FRAMEPOINT_CENTER, 0.6, 0.1315)

        call TownPortalScrollButton.RegisterLocalScript(FRAMEEVENT_CONTROL_CLICK, "TownPortalScrollButtonOnClick")
        call TownPortalScrollButton.RegisterLocalScript(FRAMEEVENT_MOUSE_UP  , "TownPortalScrollButtonOnUp")
        call TownPortalScrollButton.RegisterLocalScript(FRAMEEVENT_MOUSE_DOWN, "TownPortalScrollButtonOnDown")
    endfunction

endlibrary
