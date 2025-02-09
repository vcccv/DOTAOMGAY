
scope HeartOfTarrasque

    //***************************************************************************
    //*
    //*  恐鳌之心
    //*
    //***************************************************************************
    globals
        private AnyUnitEvent OnDamagedEvent     = 0
        private AnyUnitEvent OnEndCooldownEvent = 0
        private key COUNT
    endglobals

    private function OnDamaged takes nothing returns nothing
        local integer    i          = 0
        local item       whichItem         
        local integer    itemIndex
        local SimpleTick tick
        local boolean    isEnabled
        if Table[GetHandleId(DETarget)][COUNT] <= 0 then
            return
        endif

        set isEnabled = IsTriggerEnabled(UnitManipulatItemTrig)
        call DisableTrigger(UnitManipulatItemTrig)
        if IsUnitHeroLevel(DETarget) and ( IsUnitHeroLevel(DESource) or DESource == Roshan ) then
            loop
                set whichItem = UnitItemInSlot(DETarget, i)
                set itemIndex = GetItemIndex(whichItem)
                if ( itemIndex == Item_HeartOfTarrasque ) then
                    set TempPlayer = GetItemPlayer(whichItem)
                    call RemoveItem(whichItem)
                    set TempItem = CreateItemToUnitSlotByIndex(DETarget, RealItem[Item_DisabledHeartOfTarrasque], i)
                    call SetItemPlayer(TempItem, TempPlayer, false)
                    call SetItemUserData(TempItem, 1)
                    if IsUnitMeleeAttacker(DETarget) then
                        call StartAbilityCooldownAbsoluteEx(MHItem_GetAbility(TempItem, 1), 4.)
                    else
                        call StartAbilityCooldownAbsoluteEx(MHItem_GetAbility(TempItem, 1), 6.)
                    endif
                elseif ( itemIndex == Item_DisabledHeartOfTarrasque ) then
                    if IsUnitMeleeAttacker(DETarget) then
                        call StartAbilityCooldownAbsoluteEx(MHItem_GetAbility(whichItem, 1), 4.)
                    else
                        call StartAbilityCooldownAbsoluteEx(MHItem_GetAbility(whichItem, 1), 6.)
                    endif
                endif
                set i = i + 1
            exitwhen i > 5
            endloop
        endif

        if isEnabled then
            call EnableTrigger(UnitManipulatItemTrig)
        endif

        set whichItem = null
    endfunction

    private function OnEndCooldown takes nothing returns nothing
        local integer    i         = 0
        local item       whichItem         
        local integer    itemIndex
        local SimpleTick tick
        local unit       whichUnit = Event.GetTriggerUnit()
        local integer    id        = Event.GetTriggerAbilityId()
        local boolean    isEnabled

        if Table[GetHandleId(whichUnit)][COUNT] <= 0 or not IsUnitHeroLevel(whichUnit) or id != 'A473' then
            set whichUnit = null
            return
        endif

        set isEnabled = IsTriggerEnabled(UnitManipulatItemTrig)
        call DisableTrigger(UnitManipulatItemTrig)
        loop
            set whichItem = UnitItemInSlot(whichUnit, i)
            set itemIndex = GetItemIndex(whichItem)
            if ( itemIndex == Item_DisabledHeartOfTarrasque ) then
                set TempPlayer = GetItemPlayer(whichItem)
                call RemoveItem(whichItem)
                call DisableStartCooldownTrigger()
                set TempItem = CreateItemToUnitSlotByIndex(whichUnit, RealItem[Item_HeartOfTarrasque], i)
                call EnableStartCooldownTrigger()
                call SetItemPlayer(TempItem, TempPlayer, false)
                call SetItemUserData(TempItem, 1)
            endif
            set i = i + 1
        exitwhen i > 5
        endloop
        if isEnabled then
            call EnableTrigger(UnitManipulatItemTrig)
        endif
   
        set whichItem = null
        set whichUnit = null
    endfunction

    function ItemHeartOfTarrasqueOnPickup takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        set Table[GetHandleId(whichUnit)][COUNT] = Table[GetHandleId(whichUnit)][COUNT] + 1
        set whichUnit = null

        set HeartOfTarrasqueCount = HeartOfTarrasqueCount + 1
        if HeartOfTarrasqueCount == 1 then
            set OnDamagedEvent = AnyUnitEvent.CreateEvent(ANY_UNIT_EVENT_DAMAGED, function OnDamaged)
            set OnEndCooldownEvent = AnyUnitEvent.CreateEvent(ANY_UNIT_EVENT_ABILITY_END_COOLDOWN, function OnEndCooldown)
        endif
    endfunction

    function ItemHeartOfTarrasqueOnDrop takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        set Table[GetHandleId(whichUnit)][COUNT] = Table[GetHandleId(whichUnit)][COUNT] - 1
        set whichUnit = null

        set HeartOfTarrasqueCount = HeartOfTarrasqueCount - 1
        if HeartOfTarrasqueCount == 0 then
            call OnDamagedEvent.Destroy()
            call OnEndCooldownEvent.Destroy()
        endif
    endfunction

endscope
