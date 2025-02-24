library TownPortalScrollHandler requires Communication, TownPortalScrollFrame, UnitAbility
    
    globals
        constant integer TOWN_PORTAL_SCROLL_ABILITY_ID = 'A1R5'
        private key CHARGES
    endglobals

    // PlayerTownPortalScrollCharges[GetPlayerId(GetOwningPlayer(whichUnit))]
    function GetUnitTownPortalScrollCharges takes unit whichUnit returns integer
        return Table[GetHandleId(whichUnit)].integer[CHARGES]
    endfunction

    function SetUnitTownPortalScrollLevel takes unit whichUnit, integer level returns nothing
        call SetUnitAbilityLevel(whichUnit, TOWN_PORTAL_SCROLL_ABILITY_ID, level)
    endfunction

    function SetUnitTownPortalScrollCharges takes unit whichUnit, integer charges returns nothing
        local integer oldCharges = GetUnitTownPortalScrollCharges(whichUnit)

        if oldCharges > 0 and charges == 0 then
            call UnitDisableAbility(whichUnit, TOWN_PORTAL_SCROLL_ABILITY_ID, true, false)
        elseif oldCharges == 0 and charges > 0 then
            call UnitDisableAbility(whichUnit, TOWN_PORTAL_SCROLL_ABILITY_ID, false, false)
        endif
        
        set Table[GetHandleId(whichUnit)].integer[CHARGES] = charges
    endfunction

    function UnitAddTownPortalScrollCharges takes unit whichUnit, integer charges returns nothing
        call SetUnitTownPortalScrollCharges(whichUnit, GetUnitTownPortalScrollCharges(whichUnit) + charges)
    endfunction
    function UnitSubTownPortalScrollCharges takes unit whichUnit, integer charges returns nothing
        call SetUnitTownPortalScrollCharges(whichUnit, GetUnitTownPortalScrollCharges(whichUnit) - charges)
    endfunction

    function UnitAddTownPortalScrollAbility takes unit whichUnit, integer charges returns nothing
        local integer pid = GetPlayerId(GetOwningPlayer(whichUnit))

        // 英雄，或熊灵
        set PlayerTownPortalScrollCharges[pid] = charges
        if IsHeroUnitId(GetUnitTypeId(whichUnit)) or IsUnitSpiritBear(whichUnit) then
            if UnitAddPermanentAbility(whichUnit, TOWN_PORTAL_SCROLL_ABILITY_ID) then
                call MHAbility_FlagOperator(whichUnit, TOWN_PORTAL_SCROLL_ABILITY_ID, FLAG_OPERATOR_ADD, 0x20)
                call MHAbility_SetCastpoint(whichUnit, TOWN_PORTAL_SCROLL_ABILITY_ID, 0.)
                call MHAbility_SetBackswing(whichUnit, TOWN_PORTAL_SCROLL_ABILITY_ID, 0.)
            endif
            // 如果没有就禁用
            if charges == 0 then
                call UnitDisableAbility(whichUnit, TOWN_PORTAL_SCROLL_ABILITY_ID, true, false)
            endif
            set Table[GetHandleId(whichUnit)].integer[CHARGES] = charges
        endif
    endfunction

    function TownPortalScrollButtonOnClick takes nothing returns nothing
        local unit    selectedUnit      = MHPlayer_GetSelectUnit()
        local integer charges

        if selectedUnit == null then
            return
        endif

        set charges = GetUnitTownPortalScrollCharges(selectedUnit)
        if MHMsg_IsKeyDown(OSKEY_ALT) then
            call Communication_OnPingTownPortalScroll(selectedUnit, GetUnitAbility(selectedUnit, TOWN_PORTAL_SCROLL_ABILITY_ID), charges)
        elseif charges > 0 then
            call MHMsg_CallTargetMode(TOWN_PORTAL_SCROLL_ABILITY_ID, ORDER_tornado, ABILITY_CAST_TYPE_POINT + ABILITY_CAST_TYPE_ALONE)
        endif
        set selectedUnit = null
    endfunction
    
    function TownPortalScroll_Update takes nothing returns nothing
        local unit    selectedUnit      = MHPlayer_GetSelectUnit()
        local ability townPortalAbility = null
        local integer charges
        
        if GetUnitAbilityLevel(selectedUnit, TOWN_PORTAL_SCROLL_ABILITY_ID) > 0 then
            if not IsTownPortalScrollFrameVisible() then
                call ShowTownPortalScrollFrame(true)
            endif

            set townPortalAbility = GetUnitAbility(selectedUnit, TOWN_PORTAL_SCROLL_ABILITY_ID)
            call SetTownPortalScrollCooldownRemaining(GetAbilityCooldown(townPortalAbility), GetAbilityCooldownRemaining(townPortalAbility))
            set charges = GetUnitTownPortalScrollCharges(selectedUnit)
            call SetTownPortalScrollCharges(charges)
            call EnableShowTownPortalScrollButton(charges > 0)
            set townPortalAbility = null
        elseif IsTownPortalScrollFrameVisible() then
            call ShowTownPortalScrollFrame(false)
        endif

        set selectedUnit = null
    endfunction

endlibrary
