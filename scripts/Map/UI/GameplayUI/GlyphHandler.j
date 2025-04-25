library GlyphHandler requires Communication, UnitAbility, GlyphFrame

    globals
        constant integer GLYPH_ABILITY_ID = 'A141'
    endglobals

    function GlyphButtonOnClickSync takes nothing returns nothing
        local player whichPlayer = Frame.GetTriggerPlayer()
        call IssueImmediateOrderById(CirclesUnit[GetPlayerId(whichPlayer)], 852244)
    endfunction

    private function OnKeyDownSynced takes nothing returns nothing
        local player whichPlayer = DzGetTriggerSyncPlayer()
        call IssueImmediateOrderById(CirclesUnit[GetPlayerId(whichPlayer)], 852244)
    endfunction

    private function GetHotkey takes nothing returns integer
        return PlayerSettings.GetGlyphHotkey()
    endfunction

    function GlyphHandler_OnKeyDownASync takes integer pressedKey returns boolean
        local integer id = GetPlayerId(GetLocalPlayer())

        if pressedKey != GetHotkey() or GetHotkey() == - 1 then
            return false
        endif

        if GetUnitAbilityCooldownRemaining(CirclesUnit[id], GLYPH_ABILITY_ID) > 0. then
			call SendErrorMessage("防御符文冷却中。")
            return false
        endif

        call DzSyncData("GLYPH", "1")

        return true
    endfunction

    function GlyphButtonOnClickASync takes nothing returns integer
        local integer id = GetPlayerId(GetLocalPlayer())
        if MHMsg_IsKeyDown(OSKEY_ALT) then
            call Communication_OnGlyphPing(GetUnitAbilityCooldownRemaining(CirclesUnit[id], GLYPH_ABILITY_ID))
            return 0
        endif
        if GetUnitAbilityCooldownRemaining(CirclesUnit[id], GLYPH_ABILITY_ID) > 0. then
			call SendErrorMessage("防御符文冷却中。")
            return 0
        endif
        return 1
    endfunction

    function GlyphButtonHandler_Init takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerAddCondition(trig, Condition(function OnKeyDownSynced))
        call DzTriggerRegisterSyncData(trig, "GLYPH", false)

        call GetGlyphButton().RegisterEventByCode(EVENT_ID_FRAME_MOUSE_CLICK, function GlyphButtonOnClickASync, false)
        call GetGlyphButton().RegisterEventByCode(EVENT_ID_FRAME_MOUSE_CLICK, function GlyphButtonOnClickSync , true)

        call SetGlyphButtonTooltip(GLYPH_ABILITY_ID)
    endfunction

    function Glyph_Update takes nothing returns nothing
        local integer id = GetPlayerId(GetLocalPlayer())
        call SetGlyphCooldownRemaining(GetUnitAbilityCooldown(CirclesUnit[id], GLYPH_ABILITY_ID), GetUnitAbilityCooldownRemaining(CirclesUnit[id], GLYPH_ABILITY_ID))
    endfunction

endlibrary
