library GlyphHandler requires Communication, UnitAbility, GlyphFrame

    globals
        constant integer GLYPH_ABILITY_ID = 'A141'
    endglobals

    function GlyphButtonOnClick takes nothing returns nothing
        
    endfunction
    function Glyph_Update takes nothing returns nothing
        local integer id = GetPlayerId(GetLocalPlayer())
        call SetGlyphCooldownRemaining(GetUnitAbilityCooldown(CirclesUnit[id], GLYPH_ABILITY_ID), GetUnitAbilityCooldownRemaining(CirclesUnit[id], GLYPH_ABILITY_ID))
    endfunction

endlibrary
