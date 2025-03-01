
library GlyphFrame requires UISystem
    
    globals
        private Frame GlyphFrame

        private Frame GlyphButton

        private Frame GlyphBackground

        private Frame GlyphCooldownSprite
        private Frame GlyphCooldownString
    endglobals

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
            call GlyphCooldownString.SetText(R2SW(cooldownRemaining, 7, 2))
        else
            call GlyphCooldownString.SetText(I2S(R2I(cooldownRemaining) + 1))
        endif
        call SetGlyphCooldownSpriteProgress(progress)
        call GlyphCooldownSprite.SetVisible(true)
    endfunction

    function IsGlyphFrameVisible takes nothing returns boolean
        return GlyphFrame.IsVisible()
    endfunction

    function EnableShowGlyphButton takes boolean enable returns nothing
        //call GlyphButton.SetEnable(enable)
        if enable then
        //   call GlyphBackground.SetTexture("ReplaceableTextures\\CommandButtons\\BTNScrollUber.blp")
        else
        //   call GlyphBackground.SetTexture("ReplaceableTextures\\CommandButtonsDisabled\\DISBTNScrollUber.blp")
        endif
    endfunction

    function ShowGlyphFrame takes boolean show returns nothing
        call EnableShowGlyphButton(show)
        call GlyphFrame.SetVisible(show)
        call GlyphCooldownSprite.SetVisible(show)
    endfunction

    private function ButtonOnDown takes nothing returns boolean
        call BJDebugMsg(I2S(MHEvent_GetKey()))
        if MHEvent_GetKey() != MOUSE_BUTTON_TYPE_LEFT then
            return false
        endif
        call GlyphBackground.SetSize(0.02166, 0.02166)
        return false
    endfunction
    private function ButtonOnUp takes nothing returns boolean
        if MHEvent_GetKey() != MOUSE_BUTTON_TYPE_LEFT then
            return false
        endif
        call GlyphBackground.SetSize(0.0228, 0.0228)
        return false
    endfunction
    private function ButtonOnClick takes nothing returns boolean
        if MHEvent_GetKey() != MOUSE_BUTTON_TYPE_LEFT then
            return false
        endif
        call BJDebugMsg("点了")
        call MHGame_ExecuteFunc("GlyphButtonOnClick")
        return false
    endfunction

    function GlyphFrame_Init takes nothing returns nothing
        local trigger trig
        local Frame gameUI     = Frame.GetPtrInstance(MHUI_GetGameUI())
        local Frame commandBar = Frame.GetPtrInstance(MHUI_GetConsoleUI())
        //
        set GlyphFrame          = commandBar.CreateSimpleFrame("GlyphFrame", 0)
        set GlyphCooldownSprite = gameUI.CreateFrame("GlyphCooldownSprite", 0, 0)
        call GlyphFrame.SetAbsPoint(FRAMEPOINT_TOPLEFT, 0.154, 0.028)
        //
        set GlyphCooldownString       = Frame.GetFrameByName("GlyphCooldownString", 0)

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
        
        set trig = CreateTrigger()
        call TriggerAddCondition(trig, Condition(function ButtonOnDown))
        call MHFrameEvent_Register(trig, GlyphButton.GetPtr(), EVENT_ID_FRAME_MOUSE_DOWN)

        set trig = CreateTrigger()
        call TriggerAddCondition(trig, Condition(function ButtonOnUp))
        call MHFrameEvent_Register(trig, GlyphButton.GetPtr(), EVENT_ID_FRAME_MOUSE_UP)

        set trig = CreateTrigger()
        call TriggerAddCondition(trig, Condition(function ButtonOnClick))
        call MHFrameEvent_Register(trig, GlyphButton.GetPtr(), EVENT_ID_FRAME_MOUSE_CLICK)
    endfunction

endlibrary
