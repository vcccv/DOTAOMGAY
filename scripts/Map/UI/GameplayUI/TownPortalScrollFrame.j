
library TownPortalScrollFrame requires UISystem
    
    globals
        private Frame TownPortalScrollFrame
        private Frame TownPortalScrollButton
        private Frame TownPortalScrollBackground
        //private Frame TownPortalScrollPushedBackground
        //private Frame TownPortalScrollDisabledBackground
        private Frame TownPortalScrollNumberOverlayTexture

        private Frame TownPortalScrollNumberOverlayString
        private Frame TownPortalScrollCooldownSprite
        private Frame TownPortalScrollCooldownString
        private boolean IsTownPortalScrollButtonEnabled = true
    endglobals

    function SetTownPortalScrollCooldownSpriteProgress takes real progress returns nothing
        call TownPortalScrollCooldownSprite.SetAnimateOffset(progress)
    endfunction

    function SetTownPortalScrollCooldownRemaining takes real cooldown, real cooldownRemaining returns nothing
        local real progress
        if cooldownRemaining == 0. then
            set progress = 1.
        else
            set progress = 1 - ( cooldownRemaining / cooldown )
        endif
        if cooldownRemaining < 1. then
            call TownPortalScrollCooldownString.SetText(R2SW(cooldownRemaining, 7, 2))
        else
            call TownPortalScrollCooldownString.SetText(I2S(R2I(cooldownRemaining) + 1))
        endif
        call SetTownPortalScrollCooldownSpriteProgress(progress)
        call TownPortalScrollCooldownSprite.SetVisible(true)
    endfunction

    function SetTownPortalScrollCharges takes integer charges returns nothing
        call TownPortalScrollNumberOverlayString.SetText(I2S(charges))
    endfunction

    function IsTownPortalScrollFrameVisible takes nothing returns boolean
        return TownPortalScrollFrame.IsVisible()
    endfunction

    function EnableShowTownPortalScrollButton takes boolean enable returns nothing
        set IsTownPortalScrollButtonEnabled = enable
        if IsTownPortalScrollButtonEnabled then
            call TownPortalScrollBackground.SetTexture("ReplaceableTextures\\CommandButtons\\BTNScrollUber.blp")
        else
            call TownPortalScrollBackground.SetTexture("ReplaceableTextures\\CommandButtonsDisabled\\DISBTNScrollUber.blp")
        endif
    endfunction

    function ShowTownPortalScrollFrame takes boolean show returns nothing
        call EnableShowTownPortalScrollButton(show)
        call TownPortalScrollFrame.SetVisible(show)
        call TownPortalScrollCooldownSprite.SetVisible(show)
    endfunction

    private function ButtonOnDown takes nothing returns boolean
        call TownPortalScrollBackground.SetSize(0.02527, 0.02527)
        return false
    endfunction
    private function ButtonOnUp takes nothing returns boolean
        call TownPortalScrollBackground.SetSize(0.0266, 0.0266)
        if Frame.GetUnderCursor() == TownPortalScrollButton then
            call MHGame_ExecuteFunc("TownPortalScrollButtonOnClick")
        endif
        return false
    endfunction

    function TownPortalScrollFrame_Init takes nothing returns nothing
        local trigger trig
        local Frame gameUI     = Frame.GetPtrInstance(MHUI_GetGameUI())
        local Frame commandBar = Frame.GetPtrInstance(MHUI_GetCommandBar())
        //
        set TownPortalScrollFrame          = commandBar.CreateSimpleFrame("TownPortalScrollFrame", 0)
        set TownPortalScrollCooldownSprite = gameUI.CreateFrame("TownPortalScrollCooldownSprite", 0, 0)
        call TownPortalScrollFrame.SetAbsPoint(FRAMEPOINT_CENTER, 0.6, 0.1315)
        //
        set TownPortalScrollCooldownString       = Frame.GetFrameByName("TownPortalScrollCooldownString", 0)
        set TownPortalScrollButton               = Frame.GetFrameByName("TownPortalScrollButton", 0)
        set TownPortalScrollNumberOverlayString  = Frame.GetFrameByName("TownPortalScrollNumberOverlayString", 0)
        set TownPortalScrollNumberOverlayTexture = Frame.GetFrameByName("TownPortalScrollNumberOverlayTexture", 0)
        set TownPortalScrollBackground           = TownPortalScrollButton.GetSimpleButtonTexture(SIMPLEBUTTON_STATE_ENABLE)
        
        // set TownPortalScrollPushedBackground    = TownPortalScrollButton.GetSimpleButtonTexture(SIMPLEBUTTON_STATE_PUSHED)
        // set TownPortalScrollDisabledBackground  = TownPortalScrollButton.GetSimpleButtonTexture(SIMPLEBUTTON_STATE_DISABLE)
        //
        // call TownPortalScrollBackground.SetTexture("ReplaceableTextures\\CommandButtons\\BTNScrollUber.blp")
        // call TownPortalScrollPushedBackground.SetTexture("ReplaceableTextures\\CommandButtons\\BTNScrollUber.blp")
        // call TownPortalScrollDisabledBackground.SetTexture("ReplaceableTextures\\CommandButtonsDisabled\\DISBTNScrollUber.blp")
        call TownPortalScrollNumberOverlayTexture.ClearAllPoints()
        call TownPortalScrollNumberOverlayTexture.SetPoint(FRAMEPOINT_BOTTOMRIGHT, TownPortalScrollBackground, FRAMEPOINT_BOTTOMRIGHT, 0., - 0.0006)

        call TownPortalScrollCooldownSprite.SetAllPoints(TownPortalScrollFrame)
        call TownPortalScrollCooldownSprite.SetSpriteAnimate(0, 0)
        call TownPortalScrollCooldownSprite.SetAnimateOffset(0.5)
        //
        // call TownPortalScrollButton.RegisterLocalScript(FRAMEEVENT_CONTROL_CLICK, "TownPortalScrollButtonOnClick")

        set trig = CreateTrigger()
        call TriggerAddCondition(trig, Condition(function ButtonOnDown))
        call MHFrameEvent_Register(trig, TownPortalScrollButton.GetPtr(), EVENT_ID_FRAME_MOUSE_DOWN)

        set trig = CreateTrigger()
        call TriggerAddCondition(trig, Condition(function ButtonOnUp))
        call MHFrameEvent_Register(trig, TownPortalScrollButton.GetPtr(), EVENT_ID_FRAME_MOUSE_UP)
        //
        call ShowTownPortalScrollFrame(false)
    endfunction

endlibrary
