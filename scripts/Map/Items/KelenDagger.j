
scope KelenDagger

    //***************************************************************************
    //*
    //*  科勒的匕首
    //*
    //***************************************************************************
    function ItemKelenDaggerOnSpellChannel takes nothing returns nothing
        local unit    whichUnit = GetTriggerUnit()
        local integer level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real    value     = MHAbility_GetLevelDefDataReal(GetSpellAbilityId(), level, ABILITY_LEVEL_DEF_DATA_DATA_A)
        call MHAbility_SetAbilityCustomLevelDataReal(GetSpellAbility(), level, ABILITY_LEVEL_DEF_DATA_DATA_A, value + GetUnitCastRangeBonus(whichUnit))
        set whichUnit = null
    endfunction
    
    globals
        private AnyUnitEvent OnDamagedEvent     = 0
        private AnyUnitEvent OnEndCooldownEvent = 0
        private key KEY
    endglobals
    
    function IsUnitKelenDaggerDisabled takes unit whichUnit returns boolean
        return Table[GetHandleId(whichUnit)].real[KEY] > GameTimer.GetElapsed()
    endfunction

    function GetUnitKelenDaggerCooldownRemaining takes unit whichUnit returns real
        return RMaxBJ(Table[GetHandleId(whichUnit)].real[KEY] - GameTimer.GetElapsed(), 0.)
    endfunction
    function UpdateUnitKelenDaggerDamagedCooldown takes unit whichUnit returns nothing
        set Table[GetHandleId(whichUnit)].real[KEY] = GameTimer.GetElapsed() + 3.
    endfunction

    private function OnDamaged takes nothing returns nothing
        local integer    i          = 0
        local item       whichItem
        local integer    itemIndex
        local SimpleTick tick
        local boolean    isEnabled
        local real       cooldown

        if Table[GetHandleId(DETarget)].integer[KEY] <= 0 then
            return
        endif

        set cooldown = GetUnitKelenDaggerCooldownRemaining(DETarget)

        set isEnabled = IsTriggerEnabled(UnitManipulatItemTrig)
        call DisableTrigger(UnitManipulatItemTrig)
        if IsUnitHeroLevel(DETarget) and ( IsUnitHeroLevel(DESource) or DESource == Roshan ) then
            loop
                set whichItem = UnitItemInSlot(DETarget, i)
                set itemIndex = GetItemIndex(whichItem)
                if ( itemIndex == Item_KelenDagger ) then
                    set TempPlayer = GetItemPlayer(whichItem)
                    call RemoveItem(whichItem)
                    set TempItem = CreateItemToUnitSlotByIndex(DETarget, RealItem[Item_DisabledKelenDagger], i)
                    call SetItemPlayer(TempItem, TempPlayer, false)
                    call SetItemUserData(TempItem, 1)
                    call StartAbilityCooldownAbsoluteEx(MHItem_GetAbility(TempItem, 1), cooldown)
                elseif ( itemIndex == Item_DisabledKelenDagger ) then
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

    private function OnEndCooldown takes nothing returns nothing
        local integer    i         = 0
        local item       whichItem         
        local integer    itemIndex
        local SimpleTick tick
        local unit       whichUnit = Event.GetTriggerUnit()
        local integer    id        = Event.GetTriggerAbilityId()
        local boolean    isEnabled

       // call BJDebugMsg("触发冷却结束")
        if Table[GetHandleId(whichUnit)].integer[KEY] <= 0 or not IsUnitHeroLevel(whichUnit) or id != 'A445' then
            set whichUnit = null
            return
        endif

        set Table[GetHandleId(whichUnit)].real[KEY] = 0.

        set isEnabled = IsTriggerEnabled(UnitManipulatItemTrig)
        call DisableTrigger(UnitManipulatItemTrig)
        loop
            set whichItem = UnitItemInSlot(whichUnit, i)
            set itemIndex = GetItemIndex(whichItem)
            if ( itemIndex == Item_DisabledKelenDagger ) then
                set TempPlayer = GetItemPlayer(whichItem)
                call RemoveItem(whichItem)
                call DisableStartCooldownTrigger()
                set TempItem = CreateItemToUnitSlotByIndex(whichUnit, RealItem[Item_KelenDagger], i)
                call EnableStartCooldownTrigger()
               // call BJDebugMsg("恢复了，现在冷却时间是：" + R2S(GetUnitAbilityCooldownRemaining(whichUnit, 'AIbk')))
                // 
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
        local real       cooldownRemaining = GetUnitKelenDaggerCooldownRemaining(whichUnit)
        local integer    slot              = GetUnitItemSlot(whichUnit, whichItem)
        
        // 处于禁用状态
        if cooldownRemaining > 0. then
            if ( itemIndex == Item_KelenDagger ) then
                // 换成禁用版本
                set TempPlayer = GetItemPlayer(whichItem)
                call RemoveItem(whichItem)
                set TempItem = CreateItemToUnitSlotByIndex(whichUnit, RealItem[Item_DisabledKelenDagger], slot)
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

    function ItemKelenDaggerOnPickup takes nothing returns nothing
        local unit       whichUnit = Event.GetTriggerUnit()
        local item       whichItem = Event.GetManipulatedItem()
        local SimpleTick tick      = SimpleTick.CreateEx()

        call tick.Start(0., false, function PickupDelayOnExpired)
        set SimpleTickTable[tick].unit['u'] = whichUnit
        set SimpleTickTable[tick].item['i'] = whichItem

        set Table[GetHandleId(whichUnit)].integer[KEY] = Table[GetHandleId(whichUnit)].integer[KEY] + 1
        set KelenDaggerCount = KelenDaggerCount + 1
        if KelenDaggerCount == 1 then
            set OnDamagedEvent = AnyUnitEvent.CreateEvent(ANY_UNIT_EVENT_DAMAGED, function OnDamaged)
            set OnEndCooldownEvent = AnyUnitEvent.CreateEvent(ANY_UNIT_EVENT_ABILITY_END_COOLDOWN, function OnEndCooldown)
        endif
        //call BJDebugMsg("+1 KelenDaggerCount：" + I2S(KelenDaggerCount))
        set whichItem = null
        set whichUnit = null
    endfunction

    function ItemKelenDaggerOnDrop takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        set Table[GetHandleId(whichUnit)].integer[KEY] = Table[GetHandleId(whichUnit)].integer[KEY] - 1
        set whichUnit = null

        set KelenDaggerCount = KelenDaggerCount - 1
        if KelenDaggerCount == 0 then
            call OnDamagedEvent.Destroy()
            call OnEndCooldownEvent.Destroy()
        endif
        //call BJDebugMsg("-1 KelenDaggerCount：" + I2S(KelenDaggerCount))
    endfunction

endscope
