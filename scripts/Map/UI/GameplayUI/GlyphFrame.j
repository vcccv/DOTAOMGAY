
library GlyphFrame requires UISystem, AbilityUtils
    
    globals
        private Frame GlyphFrame          = 0

        private Frame GlyphButton         = 0
        private Frame GlyphBackground     = 0

        private Frame GlyphCooldownSprite = 0
        private Frame GlyphCooldownText   = 0

        private SimpleToolTip ToolTip     = 0
    endglobals

    function GetGlyphButton takes nothing returns Frame
        return GlyphButton
    endfunction

    function SetGlyphCooldownSpriteProgress takes real progress returns nothing
        call GlyphCooldownSprite.SetAnimateOffset(progress)
    endfunction

    function SetGlyphCooldownRemaining takes real cooldown, real cooldownRemaining returns nothing
        local real progress
        if cooldownRemaining == 0. then
            set progress = 1.
        else
            set progress = 1 - ( cooldownRemaining / cooldown )
        endif
        if cooldownRemaining < 1. then
            call GlyphCooldownText.SetText(R2SW(cooldownRemaining, 7, 2))
        else
            call GlyphCooldownText.SetText(I2S(R2I(cooldownRemaining) + 1))
        endif
        call SetGlyphCooldownSpriteProgress(progress)
        call GlyphCooldownSprite.SetVisible(progress != 1.)
    endfunction

    function SetGlyphButtonTooltip takes integer abilId returns nothing
        set ToolTip = SimpleToolTip.RegisterToolTip(GlyphButton)
        set ToolTip.TipName  = GetAbilityTooltipById(abilId, 1)
        set ToolTip.UberTip  = GetAbilityExtendedTooltipById(abilId, 1)
        set ToolTip.Cooldown = GetAbilityCooldownById(abilId, 1)
    endfunction

    function GlyphFrame_Init takes nothing returns nothing
        local Frame gameUI = Frame.GetPtrInstance(MHUI_GetGameUI())
        local Frame parent = Frame.GetPtrInstance(MHUI_GetConsoleUI())
        //
        set GlyphFrame          = parent.CreateSimpleFrame("GlyphFrame", 0)
        set GlyphCooldownSprite = gameUI.CreateFrame("GlyphCooldownSprite", 0, 0)
        call GlyphFrame.SetAbsPoint(FRAMEPOINT_TOPLEFT, 0.154, 0.028)
        //
        set GlyphCooldownText = Frame.GetFrameByName("GlyphCooldownText", 0)

        set GlyphButton       = Frame.GetFrameByName("GlyphButton", 0)
        set GlyphBackground   = Frame.GetFrameByName("GlyphBackground", 0)

        if GetPlayerId(GetLocalPlayer()) <= 5 then
            call GlyphBackground.SetTexture("ReplaceableTextures\\CommandButtons\\BTNGlyph.blp")
        else
            call GlyphBackground.SetTexture("ReplaceableTextures\\CommandButtons\\BTNGlyphScourge.blp")
        endif

        call GlyphCooldownSprite.SetAllPoints(GlyphFrame)
        call GlyphCooldownSprite.SetSpriteAnimate(0, 0)
        call GlyphCooldownSprite.SetAnimateOffset(0.5)

        call GlyphButton.SetPushedOffsetTexture(GlyphBackground, MOUSE_BUTTON_TYPE_LEFT, 0.95)
    endfunction

endlibrary
