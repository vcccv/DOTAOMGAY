library GlyphHandler requires Communication, UnitAbility, GlyphFrame

    globals
        constant integer GLYPH_ABILITY_ID = 'A141'
    endglobals

    function GlyphButtonOnClickSync takes nothing returns nothing
        local player whichPlayer = Frame.GetTriggerPlayer()
        call IssueImmediateOrderById(CirclesUnit[GetPlayerId(whichPlayer)], 852244)
    endfunction
    function GlyphButtonOnClickASync takes nothing returns integer
        local integer id = GetPlayerId(GetLocalPlayer())
        if GetUnitAbilityCooldownRemaining(CirclesUnit[id], GLYPH_ABILITY_ID) > 0. then
			call SendErrorMessage(GetLocalizedString("魔法尚未恢复。"))
            return 0
        endif
        return 1
    endfunction

    function GlyphButtonHandler_Init takes nothing returns nothing
        call GetGlyphButton().RegisterEventByCode(EVENT_ID_FRAME_MOUSE_CLICK, function GlyphButtonOnClickASync, false)
        call GetGlyphButton().RegisterEventByCode(EVENT_ID_FRAME_MOUSE_CLICK, function GlyphButtonOnClickSync , true)

        call SetGlyphButtonTooltip(GLYPH_ABILITY_ID)
    endfunction

    function Glyph_Update takes nothing returns nothing
        local integer id = GetPlayerId(GetLocalPlayer())
        call SetGlyphCooldownRemaining(GetUnitAbilityCooldown(CirclesUnit[id], GLYPH_ABILITY_ID), GetUnitAbilityCooldownRemaining(CirclesUnit[id], GLYPH_ABILITY_ID))
    endfunction

endlibrary
