library TownPortalScrollHandler requires Communication, TownPortalScrollFrame, UnitAbility
    
    globals
        constant integer TOWN_PORTAL_SCROLL_ABILITY_ID = 'A1R5'
        private key CHARGES
    endglobals

    function GetUnitTownPortalScrollCooldown takes unit whichUnit returns real
        return GetUnitAbilityCooldown(whichUnit, TOWN_PORTAL_SCROLL_ABILITY_ID)
    endfunction
    function SetUnitTownPortalScrollCooldown takes unit whichUnit, real cooldown returns nothing
        call SetUnitAbilityCooldown(whichUnit, TOWN_PORTAL_SCROLL_ABILITY_ID, cooldown)
    endfunction

    function SetUnitTownPortalScrollLevel takes unit whichUnit, integer level returns nothing
        call SetUnitAbilityLevel(whichUnit, TOWN_PORTAL_SCROLL_ABILITY_ID, level)
    endfunction

    function GetUnitTownPortalScrollCharges takes unit whichUnit returns integer
        return Table[GetHandleId(whichUnit)].integer[CHARGES]
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

    function UnitAddTownPortalScrollAbility takes unit whichUnit returns nothing
        local integer pid = GetPlayerId(GetOwningPlayer(whichUnit))

        // 英雄，或熊灵
        if IsHeroUnitId(GetUnitTypeId(whichUnit)) or IsUnitSpiritBear(whichUnit) then
            if UnitAddPermanentAbility(whichUnit, TOWN_PORTAL_SCROLL_ABILITY_ID) then
                call MHAbility_FlagOperator(whichUnit, TOWN_PORTAL_SCROLL_ABILITY_ID, FLAG_OPERATOR_ADD, 0x20)
                call MHAbility_SetCastpoint(whichUnit, TOWN_PORTAL_SCROLL_ABILITY_ID, 0.)
                call MHAbility_SetBackswing(whichUnit, TOWN_PORTAL_SCROLL_ABILITY_ID, 0.)
                // 开局先禁用
                call UnitDisableAbility(whichUnit, TOWN_PORTAL_SCROLL_ABILITY_ID, true, false)
            endif
        endif
    endfunction

    // 没有安全判定的版本，用于给ItemHolder添加
    function UnitAddTownPortalScrollAbilityUnSafe takes unit whichUnit returns nothing
        local integer pid = GetPlayerId(GetOwningPlayer(whichUnit))

        if UnitAddPermanentAbility(whichUnit, TOWN_PORTAL_SCROLL_ABILITY_ID) then
            call MHAbility_FlagOperator(whichUnit, TOWN_PORTAL_SCROLL_ABILITY_ID, FLAG_OPERATOR_ADD, 0x20)
            call MHAbility_SetCastpoint(whichUnit, TOWN_PORTAL_SCROLL_ABILITY_ID, 0.)
            call MHAbility_SetBackswing(whichUnit, TOWN_PORTAL_SCROLL_ABILITY_ID, 0.)
            // 开局先禁用
            call UnitDisableAbility(whichUnit, TOWN_PORTAL_SCROLL_ABILITY_ID, true, false)
        endif
    endfunction

    private function GetSelfCastX takes unit trigUnit returns real
        local real x
        if IsPlayerSentinel(GetOwningPlayer(trigUnit)) then
            set x = GetRectCenterX(gg_rct_SentinelRevivalPoint)
        else
            set x = GetRectCenterX(gg_rct_ScourgeRevivalPoint)
        endif
        return x
    endfunction
    private function GetSelfCastY takes unit trigUnit returns real
        local real y
        if IsPlayerSentinel(GetOwningPlayer(trigUnit)) then
            set y = GetRectCenterY(gg_rct_SentinelRevivalPoint)
        else
            set y = GetRectCenterY(gg_rct_ScourgeRevivalPoint)
        endif
        return y
    endfunction

    function TownPortalScroll_SelfCast takes unit selectedUnit returns nothing
        local real    x
        local real    y
        local integer flag
        if selectedUnit == null then
            return
        endif

        if GetPlayerAlliance(GetOwningPlayer(selectedUnit), GetLocalPlayer(), ALLIANCE_SHARED_CONTROL) then
            set x = GetSelfCastX(selectedUnit)
            set y = GetSelfCastX(selectedUnit)
            set flag = LOCAL_ORDER_FLAG_ALONE + LOCAL_ORDER_FLAG_ITEM
            if MHMsg_IsKeyDown(OSKEY_SHIFT) then
                set flag = flag + LOCAL_ORDER_FLAG_QUEUE
            endif
            if GetUnitAbilityLevel(selectedUnit, TOWN_PORTAL_SCROLL_ABILITY_ID) == 1then
                call MHMsg_SendSelectorOrder(x, y, ORDER_massteleport, flag)
            else
                call MHMsg_SendIndicatorOrder(null, x, y, ORDER_massteleport, flag)
            endif
        endif
    endfunction

    function TownPortalScrollButtonOnClickASync takes nothing returns nothing
        local unit    selectedUnit      = MHPlayer_GetSelectUnit()
        local integer charges

        if selectedUnit == null then
            return
        endif

        set charges = GetUnitTownPortalScrollCharges(selectedUnit)
        if MHMsg_IsKeyDown(OSKEY_ALT) then
            call Communication_OnPingTownPortalScroll(selectedUnit, GetUnitAbility(selectedUnit, TOWN_PORTAL_SCROLL_ABILITY_ID), charges)
        elseif MHUIData_GetTargetModeAbility() == TOWN_PORTAL_SCROLL_ABILITY_ID and MHMsg_IsIndicatorOn(INDICATOR_TYPE_TARGET_MODE) then
            call TownPortalScroll_SelfCast(selectedUnit)
        elseif charges > 0 then
            call MHUI_PlayNativeSound("InterfaceClick")
            if GetUnitAbilityLevel(selectedUnit, TOWN_PORTAL_SCROLL_ABILITY_ID) == 1 then
                // ABILITY_CAST_TYPE_POINT + ABILITY_CAST_TYPE_ALONE
                call MHMsg_CallTargetMode(TOWN_PORTAL_SCROLL_ABILITY_ID, ORDER_massteleport, 0x100002)
            else
                // ABILITY_CAST_TYPE_POINT + ABILITY_CAST_TYPE_TARGET + ABILITY_CAST_TYPE_ALONE
                call MHMsg_CallTargetMode(TOWN_PORTAL_SCROLL_ABILITY_ID, ORDER_massteleport, 0x100006)
            endif
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
            call TownPortalScrollFrameUpdateToolTip(townPortalAbility)
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

    function TownPortalScrollHandler_Init takes nothing returns nothing
        call GetTownPortalScrollButton().RegisterEventByCode(EVENT_ID_FRAME_MOUSE_CLICK, function TownPortalScrollButtonOnClickASync, false)
    endfunction

endlibrary
