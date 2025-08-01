
scope HeartOfTarrasque

    //***************************************************************************
    //*
    //*  恐鳌之心
    //*
    //***************************************************************************
    globals
        private AnyUnitEvent OnDamagedEvent     = 0
        private AnyUnitEvent OnEndCooldownEvent = 0
        key HEART_OF_TARRASQUE_COOLDOWN_KEY
    endglobals

    function IsUnitHeartOfTarrasqueDisabled takes unit whichUnit returns boolean
        return Table[GetHandleId(whichUnit)].real[HEART_OF_TARRASQUE_COOLDOWN_KEY] > GameTimer.GetElapsed()
    endfunction

    function GetUnitHeartOfTarrasqueCooldownRemaining takes unit whichUnit returns real
        return RMaxBJ(Table[GetHandleId(whichUnit)].real[HEART_OF_TARRASQUE_COOLDOWN_KEY] - GameTimer.GetElapsed(), 0.)
    endfunction
    function UpdateUnitHeartOfTarrasqueDamagedCooldown takes unit whichUnit returns nothing
        local real cooldown
        if IsUnitMeleeAttacker(whichUnit) then
            set cooldown = 4.
        else
            set cooldown = 6.
        endif
        set Table[GetHandleId(whichUnit)].real[HEART_OF_TARRASQUE_COOLDOWN_KEY] = GameTimer.GetElapsed() + cooldown
    endfunction

    private function OnDamaged takes nothing returns nothing
        local integer    i          = 0
        local item       whichItem         
        local integer    itemIndex
        local SimpleTick tick
        local real       cooldown
        if Table[GetHandleId(DETarget)].integer[HEART_OF_TARRASQUE_COOLDOWN_KEY] <= 0 then
            return
        endif

        set cooldown = GetUnitHeartOfTarrasqueCooldownRemaining(DETarget)

        call ItemSystem_EnableItemManipulateMethod(false)
        if IsUnitHeroLevel(DETarget) and ( IsUnitHeroLevel(DESource) or DESource == Roshan ) then
            loop
                set whichItem = UnitItemInSlot(DETarget, i)
                set itemIndex = GetItemIndex(whichItem)
                if ( itemIndex == Item_HeartOfTarrasque ) then
                    set TempPlayer = GetItemPlayer(whichItem)
                    call RemoveItem(whichItem)
                    set TempItem = CreateItemToUnitSlotByIndex(DETarget, ItemRealId[Item_DisabledHeartOfTarrasque], i)
                    call SetItemPlayer(TempItem, TempPlayer, false)
                    call SetItemUserData(TempItem, 1)
                    call StartAbilityCooldownAbsoluteEx(MHItem_GetAbility(TempItem, 1), cooldown)
                elseif ( itemIndex == Item_DisabledHeartOfTarrasque ) then
                    call StartAbilityCooldownAbsoluteEx(MHItem_GetAbility(whichItem, 1), cooldown)
                endif
                set i = i + 1
            exitwhen i > 5
            endloop
        endif

        call ItemSystem_EnableItemManipulateMethod(true)

        set whichItem = null
    endfunction

    private function OnEndCooldown takes nothing returns nothing
        local integer    i         = 0
        local item       whichItem         
        local integer    itemIndex
        local SimpleTick tick
        local unit       whichUnit = Event.GetTriggerUnit()
        local integer    id        = Event.GetTriggerAbilityId()

        if Table[GetHandleId(whichUnit)].integer[HEART_OF_TARRASQUE_COOLDOWN_KEY] <= 0 or not IsUnitHeroLevel(whichUnit) or id != 'A473' then
            set whichUnit = null
            return
        endif

        set Table[GetHandleId(whichUnit)].real[HEART_OF_TARRASQUE_COOLDOWN_KEY] = 0.

        if not IsUnitAlive(whichUnit) then
            set whichUnit = null
            return
        endif

        call ItemSystem_EnableItemManipulateMethod(false)
        loop
            set whichItem = UnitItemInSlot(whichUnit, i)
            set itemIndex = GetItemIndex(whichItem)
            if ( itemIndex == Item_DisabledHeartOfTarrasque ) then
                set TempPlayer = GetItemPlayer(whichItem)
                call RemoveItem(whichItem)
                call DisableStartCooldownTrigger()
                set TempItem = CreateItemToUnitSlotByIndex(whichUnit, ItemRealId[Item_HeartOfTarrasque], i)
                call EnableStartCooldownTrigger()
                call SetItemPlayer(TempItem, TempPlayer, false)
                call SetItemUserData(TempItem, 1)
            endif
            set i = i + 1
        exitwhen i > 5
        endloop
        call ItemSystem_EnableItemManipulateMethod(true)
   
        set whichItem = null
        set whichUnit = null
    endfunction

    private function PickupDelayOnExpired takes nothing returns nothing
        local SimpleTick tick              = SimpleTick.GetExpired()
        local unit       whichUnit         = SimpleTickTable[tick].unit['u']
        local item       whichItem         = SimpleTickTable[tick].item['i']
        local integer    itemIndex         = GetItemIndex(whichItem)
        local real       cooldownRemaining = GetUnitHeartOfTarrasqueCooldownRemaining(whichUnit)
        local integer    slot              = GetUnitItemSlot(whichUnit, whichItem)
        
        // 处于禁用状态
        if cooldownRemaining > 0. then
            if ( itemIndex == Item_HeartOfTarrasque ) then
                // 换成禁用版本
                set TempPlayer = GetItemPlayer(whichItem)
                call RemoveItem(whichItem)
                set TempItem = CreateItemToUnitSlotByIndex(whichUnit, ItemRealId[Item_DisabledHeartOfTarrasque], slot)
                call SetItemPlayer(TempItem, TempPlayer, false)
                call SetItemUserData(TempItem, 1)
                call StartAbilityCooldownAbsoluteEx(MHItem_GetAbility(TempItem, 1), cooldownRemaining)
            else
                // 更新冷却时间
                call StartAbilityCooldownAbsoluteEx(MHItem_GetAbility(whichItem, 1), cooldownRemaining)
            endif
        endif

        call tick.Destroy()
        set whichItem = null
        set whichUnit = null
    endfunction

    function ItemHeartOfTarrasqueOnPickup takes nothing returns nothing
        local unit       whichUnit = Event.GetTriggerUnit()
        local item       whichItem = Event.GetManipulatedItem()
        local SimpleTick tick      = SimpleTick.CreateEx()
        if IsUnitIllusion(whichUnit) then
            set whichItem = null
            set whichUnit = null
            return
        endif
        call tick.Start(0., false, function PickupDelayOnExpired)
        set SimpleTickTable[tick].unit['u'] = whichUnit
        set SimpleTickTable[tick].item['i'] = whichItem
        
        set Table[GetHandleId(whichUnit)].integer[HEART_OF_TARRASQUE_COOLDOWN_KEY] = Table[GetHandleId(whichUnit)].integer[HEART_OF_TARRASQUE_COOLDOWN_KEY] + 1
        set HeartOfTarrasqueCount = HeartOfTarrasqueCount + 1
        if HeartOfTarrasqueCount == 1 then
            set OnDamagedEvent = AnyUnitEvent.CreateEventByCode(ANY_UNIT_EVENT_DAMAGED, function OnDamaged)
            set OnEndCooldownEvent = AnyUnitEvent.CreateEventByCode(ANY_UNIT_EVENT_ABILITY_END_COOLDOWN, function OnEndCooldown)
        endif
        set whichItem = null
        set whichUnit = null
    endfunction

    function ItemHeartOfTarrasqueOnDrop takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        if IsUnitIllusion(whichUnit) then
            set whichUnit = null
            return
        endif
        set Table[GetHandleId(whichUnit)].integer[HEART_OF_TARRASQUE_COOLDOWN_KEY] = Table[GetHandleId(whichUnit)].integer[HEART_OF_TARRASQUE_COOLDOWN_KEY] - 1
        set whichUnit = null

        set HeartOfTarrasqueCount = HeartOfTarrasqueCount - 1
        if HeartOfTarrasqueCount == 0 then
            call OnDamagedEvent.Destroy()
            call OnEndCooldownEvent.Destroy()
        endif
    endfunction

endscope
