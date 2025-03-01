
library TownPortalScrollFrame requires UISystem
    
    globals
        private Frame TownPortalScrollFrame

        private Frame TownPortalScrollButton
        private Frame TownPortalScrollBackground

        private Frame TownPortalScrollChargesString

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
        call TownPortalScrollChargesString.SetText(I2S(charges))
    endfunction

    function IsTownPortalScrollFrameVisible takes nothing returns boolean
        return TownPortalScrollFrame.IsVisible()
    endfunction

    function EnableShowTownPortalScrollButton takes boolean enable returns nothing
        // call TownPortalScrollButton.SetEnable(enable)
        // call TownPortalScrollButton.SetEnable(enable)
        set IsTownPortalScrollButtonEnabled = enable
        if enable then
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
        if MHEvent_GetKey() != MOUSE_BUTTON_TYPE_LEFT then
            return false
        endif
        call TownPortalScrollBackground.SetSize(0.02527, 0.02527)
        return false
    endfunction
    private function ButtonOnUp takes nothing returns boolean
        if MHEvent_GetKey() != MOUSE_BUTTON_TYPE_LEFT then
            return false
        endif
        call TownPortalScrollBackground.SetSize(0.0266, 0.0266)
        return false
    endfunction
    private function ButtonOnClick takes nothing returns boolean
        if MHEvent_GetKey() != MOUSE_BUTTON_TYPE_LEFT then
            return false
        endif
        call MHGame_ExecuteFunc("TownPortalScrollButtonOnClick")
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
        
        set TownPortalScrollChargesString        = Frame.GetFrameByName("TownPortalScrollChargesString", 0)
        set TownPortalScrollBackground           = Frame.GetFrameByName("TownPortalScrollBackground", 0)

        call TownPortalScrollBackground.SetTexture("ReplaceableTextures\\CommandButtons\\BTNScrollUber.blp")

        call TownPortalScrollCooldownSprite.SetAllPoints(TownPortalScrollFrame)
        call TownPortalScrollCooldownSprite.SetSpriteAnimate(0, 0)
        call TownPortalScrollCooldownSprite.SetAnimateOffset(0.5)
        
        set trig = CreateTrigger()
        call TriggerAddCondition(trig, Condition(function ButtonOnDown))
        call MHFrameEvent_Register(trig, TownPortalScrollButton.GetPtr(), EVENT_ID_FRAME_MOUSE_DOWN)

        set trig = CreateTrigger()
        call TriggerAddCondition(trig, Condition(function ButtonOnUp))
        call MHFrameEvent_Register(trig, TownPortalScrollButton.GetPtr(), EVENT_ID_FRAME_MOUSE_UP)

        set trig = CreateTrigger()
        call TriggerAddCondition(trig, Condition(function ButtonOnClick))
        call MHFrameEvent_Register(trig, TownPortalScrollButton.GetPtr(), EVENT_ID_FRAME_MOUSE_CLICK)
        //
        call ShowTownPortalScrollFrame(false)
    endfunction

endlibrary
