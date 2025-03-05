
library GlyphFrame requires UISystem, AbilityUtils
    
    globals
        private Frame GlyphFrame

        private Frame GlyphButton

        private Frame GlyphBackground

        private Frame GlyphCooldownSprite
        private Frame GlyphCooldownText

        private SimpleToolTip ToolTip
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

    function IsGlyphFrameVisible takes nothing returns boolean
        return GlyphFrame.IsVisible()
    endfunction


    function ShowGlyphFrame takes boolean show returns nothing
        //call EnableShowGlyphButton(show)
        call GlyphFrame.SetVisible(show)
        call GlyphCooldownSprite.SetVisible(show)
    endfunction

    private function ButtonOnClick takes nothing returns boolean
        if MHEvent_GetKey() != MOUSE_BUTTON_TYPE_LEFT then
            return false
        endif
        call MHGame_ExecuteFunc("GlyphButtonOnClick")
        return false
    endfunction

    function SetGlyphButtonTooltip takes integer abilId returns nothing
        set ToolTip = SimpleToolTip.RegisterToolTip(GlyphButton)
        set ToolTip.TipName  = GetAbilityTooltipById(abilId, 1)
        set ToolTip.UberTip  = GetAbilityUberTooltipById(abilId, 1)
        set ToolTip.Cooldown = GetAbilityCooldownById(abilId, 1)
    endfunction

    function GlyphFrame_Init takes nothing returns nothing
        local trigger trig
        local Frame gameUI = Frame.GetPtrInstance(MHUI_GetGameUI())
        local Frame parent = Frame.GetPtrInstance(MHUI_GetConsoleUI())
        //
        set GlyphFrame          = parent.CreateSimpleFrame("GlyphFrame", 0)
        set GlyphCooldownSprite = gameUI.CreateFrame("GlyphCooldownSprite", 0, 0)
        call GlyphFrame.SetAbsPoint(FRAMEPOINT_TOPLEFT, 0.154, 0.028)
        //
        set GlyphCooldownText         = Frame.GetFrameByName("GlyphCooldownText", 0)

        set GlyphButton               = Frame.GetFrameByName("GlyphButton", 0)
        set GlyphBackground           = Frame.GetFrameByName("GlyphBackground", 0)

        if GetPlayerId(GetLocalPlayer()) <= 5 then
            call GlyphBackground.SetTexture("ReplaceableTextures\\CommandButtons\\BTNGlyph.blp")
        else
            call GlyphBackground.SetTexture("ReplaceableTextures\\CommandButtons\\BTNGlyphScourge.blp")
        endif

        call GlyphCooldownSprite.SetAllPoints(GlyphFrame)
        call GlyphCooldownSprite.SetSpriteAnimate(0, 0)
        call GlyphCooldownSprite.SetAnimateOffset(0.5)



        call GlyphButton.SetPushedOffsetTexture(GlyphBackground, MOUSE_BUTTON_TYPE_LEFT, 0.95)

        set trig = CreateTrigger()
        call TriggerAddCondition(trig, Condition(function ButtonOnClick))
        call MHFrameEvent_Register(trig, GlyphButton.GetPtr(), EVENT_ID_FRAME_MOUSE_CLICK)
    endfunction

endlibrary
