
scope TranquilBoots

    //***************************************************************************
    //*
    //*  静谧之鞋
    //*
    //***************************************************************************
    globals
        private AnyUnitEvent OnEndCooldownEvent = 0
        private key KEY
    endglobals

    function IsUnitTranquilBootsDisabled takes unit whichUnit returns boolean
        return Table[GetHandleId(whichUnit)].real[KEY] > GameTimer.GetElapsed()
    endfunction

    function GetUnitTranquilBootsCooldownRemaining takes unit whichUnit returns real
        return RMaxBJ(Table[GetHandleId(whichUnit)].real[KEY] - GameTimer.GetElapsed(), 0.)
    endfunction
    function UpdateUnitTranquilBootsDamagedCooldown takes unit whichUnit returns nothing
        set Table[GetHandleId(whichUnit)].real[KEY] = GameTimer.GetElapsed() + 13.
    endfunction

    private function UnitDisableTranquilBoots takes unit whichUnit returns nothing
        local integer    i          = 0
        local item       whichItem         
        local integer    itemIndex
        local SimpleTick tick
        local boolean    isEnabled
        local real       cooldown

        set cooldown = GetUnitTranquilBootsCooldownRemaining(whichUnit)

        set isEnabled = IsTriggerEnabled(UnitManipulatItemTrig)
        call DisableTrigger(UnitManipulatItemTrig)
        if IsUnitHeroLevel(whichUnit) and ( IsUnitHeroLevel(DESource) or DESource == Roshan ) then
            loop
                set whichItem = UnitItemInSlot(whichUnit, i)
                set itemIndex = GetItemIndex(whichItem)
                if ( itemIndex == Item_TranquilBoots ) then
                    set TempPlayer = GetItemPlayer(whichItem)
                    call RemoveItem(whichItem)
                    set TempItem = CreateItemToUnitSlotByIndex(whichUnit, RealItem[Item_DisabledTranquilBoots], i)
                    call SetItemPlayer(TempItem, TempPlayer, false)
                    call SetItemUserData(TempItem, 1)
                    call StartAbilityCooldownAbsoluteEx(MHItem_GetAbility(TempItem, 1), cooldown)
                elseif ( itemIndex == Item_DisabledTranquilBoots ) then
                    call StartAbilityCooldownAbsoluteEx(MHItem_GetAbility(whichItem, 1), cooldown)
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

    function TranquilBootsOnDamaged takes nothing returns nothing
        if Event.IsAttackDamage() then
            // 被攻击就中断
            call UpdateUnitTranquilBootsDamagedCooldown(DETarget)
            if Table[GetHandleId(DETarget)].integer[KEY] > 0 then
                call UnitDisableTranquilBoots(DETarget)
            endif
            // 攻击英雄时才会中断(不是英雄级单位)
            if IsHeroUnitId(GetUnitTypeId(DETarget)) and IsPlayerValid(GetOwningPlayer(DETarget)) then
                call UpdateUnitTranquilBootsDamagedCooldown(DESource)
                if Table[GetHandleId(DESource)].integer[KEY] > 0 then
                    call UnitDisableTranquilBoots(DESource)
                endif
            endif
        endif
    endfunction
    
    private function OnEndCooldown takes nothing returns nothing
        local integer    i         = 0
        local item       whichItem         
        local integer    itemIndex
        local SimpleTick tick
        local unit       whichUnit = Event.GetTriggerUnit()
        local integer    id        = Event.GetTriggerAbilityId()
        local boolean    isEnabled

        if Table[GetHandleId(whichUnit)].integer[KEY] <= 0 or not IsUnitHeroLevel(whichUnit) or id != 'A474' then
            set whichUnit = null
            return
        endif

        set Table[GetHandleId(whichUnit)].real[KEY] = 0.

        set isEnabled = IsTriggerEnabled(UnitManipulatItemTrig)
        call DisableTrigger(UnitManipulatItemTrig)
        loop
            set whichItem = UnitItemInSlot(whichUnit, i)
            set itemIndex = GetItemIndex(whichItem)
            if ( itemIndex == Item_DisabledTranquilBoots ) then
                set TempPlayer = GetItemPlayer(whichItem)
                call RemoveItem(whichItem)
                call DisableStartCooldownTrigger()
                set TempItem = CreateItemToUnitSlotByIndex(whichUnit, RealItem[Item_TranquilBoots], i)
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

    private function PickupDelayOnExpired takes nothing returns nothing
        local SimpleTick tick              = SimpleTick.GetExpired()
        local unit       whichUnit         = SimpleTickTable[tick].unit['u']
        local item       whichItem         = SimpleTickTable[tick].item['i']
        local integer    itemIndex         = GetItemIndex(whichItem)
        local real       cooldownRemaining = GetUnitTranquilBootsCooldownRemaining(whichUnit)
        local integer    slot              = GetUnitItemSlot(whichUnit, whichItem)
        
        // 处于禁用状态
        if cooldownRemaining > 0. then
            if ( itemIndex == Item_TranquilBoots ) then
                // 换成禁用版本
                set TempPlayer = GetItemPlayer(whichItem)
                call RemoveItem(whichItem)
                set TempItem = CreateItemToUnitSlotByIndex(whichUnit, RealItem[Item_DisabledTranquilBoots], slot)
                call SetItemPlayer(TempItem, TempPlayer, false)
                call SetItemUserData(TempItem, 1)
                call StartAbilityCooldownAbsoluteEx(MHItem_GetAbility(TempItem, 1), cooldownRemaining)
            else
                // 更新冷却时间
                call StartAbilityCooldownAbsoluteEx(MHItem_GetAbility(whichItem, 1), cooldownRemaining)
            endif
        else
            // 如果不在禁用，拿的是禁用就变成启用版本
            if ( itemIndex == Item_DisabledTranquilBoots ) then
                set TempPlayer = GetItemPlayer(whichItem)
                call RemoveItem(whichItem)
                call DisableStartCooldownTrigger()
                set TempItem = CreateItemToUnitSlotByIndex(whichUnit, RealItem[Item_TranquilBoots], slot)
                call EnableStartCooldownTrigger()
                call SetItemPlayer(TempItem, TempPlayer, false)
                call SetItemUserData(TempItem, 1)
            endif
        endif

        call tick.Destroy()
        set whichItem = null
        set whichUnit = null
    endfunction

    function ItemTranquilBootsOnPickup takes nothing returns nothing
        local unit       whichUnit = Event.GetTriggerUnit()
        local item       whichItem = Event.GetManipulatedItem()
        local SimpleTick tick      = SimpleTick.CreateEx()

        call tick.Start(0., false, function PickupDelayOnExpired)
        set SimpleTickTable[tick].unit['u'] = whichUnit
        set SimpleTickTable[tick].item['i'] = whichItem

        set Table[GetHandleId(whichUnit)].integer[KEY] = Table[GetHandleId(whichUnit)].integer[KEY] + 1
        set TranquilBootsCount = TranquilBootsCount + 1
        if TranquilBootsCount == 1 then
            set OnEndCooldownEvent = AnyUnitEvent.CreateEvent(ANY_UNIT_EVENT_ABILITY_END_COOLDOWN, function OnEndCooldown)
        endif
        //call BJDebugMsg("+ 1now TranquilBootsCount:" + I2S(TranquilBootsCount))

        set whichUnit = null
        set whichItem = null
    endfunction

    function ItemTranquilBootsOnDrop takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        set Table[GetHandleId(whichUnit)].integer[KEY] = Table[GetHandleId(whichUnit)].integer[KEY] - 1
        set whichUnit = null

        set TranquilBootsCount = TranquilBootsCount - 1
        if TranquilBootsCount == 0 then
            call OnEndCooldownEvent.Destroy()
        endif
        //call BJDebugMsg("- 1now TranquilBootsCount:" + I2S(TranquilBootsCount))
    endfunction

endscope
