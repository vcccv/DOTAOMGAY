
library TownPortalScrollFrame requires UISystem, AbilityUtils
    
    globals
        private Frame TownPortalScrollFrame          = 0

        private Frame TownPortalScrollButton         = 0
        private Frame TownPortalScrollBackground     = 0

        private Frame TownPortalScrollChargesString  = 0

        private Frame TownPortalScrollCooldownSprite = 0
        private Frame TownPortalScrollCooldownText   = 0
        
        private SimpleToolTip ToolTip                = 0
    endglobals

    function GetTownPortalScrollButton takes nothing returns Frame
        return TownPortalScrollButton
    endfunction

    function TownPortalScrollFrameUpdateToolTip takes ability whichAbility returns nothing
        // if Frame.GetUnderCursor() != TownPortalScrollButton then
        //     return
        // endif
        
        set ToolTip.TipName  = GetAbilityTooltip(whichAbility)
        set ToolTip.UberTip  = GetAbilityUberTooltip(whichAbility)
        set ToolTip.ManaCost = GetAbilityManaCost(whichAbility)
        set ToolTip.Cooldown = GetAbilityCooldown(whichAbility)
    endfunction

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
            call TownPortalScrollCooldownText.SetText(R2SW(cooldownRemaining, 7, 2))
        else
            call TownPortalScrollCooldownText.SetText(I2S(R2I(cooldownRemaining) + 1))
        endif
        call SetTownPortalScrollCooldownSpriteProgress(progress)
        call TownPortalScrollCooldownSprite.SetVisible(progress != 1.)
    endfunction

    function SetTownPortalScrollCharges takes integer charges returns nothing
        call TownPortalScrollChargesString.SetText(I2S(charges))
    endfunction

    function IsTownPortalScrollFrameVisible takes nothing returns boolean
        return TownPortalScrollFrame.IsVisible()
    endfunction
    
    function SetTownPortalScrollButtonRequireManaState takes boolean state returns nothing
        if state then
            call TownPortalScrollBackground.SetTextColor(0xFF4040FF)
        else
            call TownPortalScrollBackground.SetTextColor(0xFFFFFFFF)
        endif
    endfunction

    function EnableShowTownPortalScrollButton takes boolean enable returns nothing
        call TownPortalScrollButton.SetEnableEx(enable)
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

    function TownPortalScrollFrame_Init takes nothing returns nothing
        local Frame gameUI     = Frame.GetPtrInstance(MHUI_GetGameUI())
        local Frame commandBar = Frame.GetPtrInstance(MHUI_GetCommandBar())
        //
        set TownPortalScrollFrame          = commandBar.CreateSimpleFrame("TownPortalScrollFrame", 0)
        set TownPortalScrollCooldownSprite = gameUI.CreateFrame("TownPortalScrollCooldownSprite", 0, 0)
        call TownPortalScrollFrame.SetAbsPoint(FRAMEPOINT_CENTER, 0.6, 0.1315)
        //
        set TownPortalScrollCooldownText  = Frame.GetFrameByName("TownPortalScrollCooldownText", 0)
        set TownPortalScrollButton        = Frame.GetFrameByName("TownPortalScrollButton", 0)
        
        set TownPortalScrollChargesString = Frame.GetFrameByName("TownPortalScrollChargesString", 0)
        set TownPortalScrollBackground    = Frame.GetFrameByName("TownPortalScrollBackground", 0)

        call TownPortalScrollBackground.SetTexture("ReplaceableTextures\\CommandButtons\\BTNScrollUber.blp")

        call TownPortalScrollCooldownSprite.SetAllPoints(TownPortalScrollFrame)
        call TownPortalScrollCooldownSprite.SetSpriteAnimate(0, 0)
        call TownPortalScrollCooldownSprite.SetAnimateOffset(0.5)
        call TownPortalScrollCooldownSprite.SetVisible(false)

        set ToolTip = SimpleToolTip.RegisterToolTip(TownPortalScrollButton)
        
        call TownPortalScrollButton.SetPushedOffsetTexture(TownPortalScrollBackground, MOUSE_BUTTON_TYPE_LEFT, 0.95)
        //
        call ShowTownPortalScrollFrame(false)
    endfunction

endlibrary
