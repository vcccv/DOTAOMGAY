
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
                if ( itemIndex == Item_KelenDagger ) then
                // call BJDebugMsg("坏了")
                    set TempPlayer = GetItemPlayer(whichItem)
                   // call BJDebugMsg("破损了当前冷却时间是：" + R2S(GetUnitAbilityCooldownRemaining(DETarget, 'AIbk')))
                    call RemoveItem(whichItem)
                    set TempItem = CreateItemToUnitSlotByIndex(DETarget, RealItem[Item_DisabledKelenDagger], i)
                    call StartUnitAbilityCooldownAbsolute(DETarget, 'A445')
                   // call BJDebugMsg("破损了破的冷却时间是：" + R2S(GetUnitAbilityCooldownRemaining(DETarget, 'A445')))
                    call SetItemPlayer(TempItem, TempPlayer, false)
                    call SetItemUserData(TempItem, 1)
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
        if Table[GetHandleId(whichUnit)][COUNT] <= 0 or not IsUnitHeroLevel(whichUnit) or id != 'A445' then
            set whichUnit = null
            return
        endif

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

    function ItemKelenDaggerOnPickup takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        set Table[GetHandleId(whichUnit)][COUNT] = Table[GetHandleId(whichUnit)][COUNT] + 1
        set whichUnit = null

        set KelenDaggerCount = KelenDaggerCount + 1
        if KelenDaggerCount == 1 then
            set OnDamagedEvent = AnyUnitEvent.CreateEvent(ANY_UNIT_EVENT_DAMAGED, function OnDamaged)
            set OnEndCooldownEvent = AnyUnitEvent.CreateEvent(ANY_UNIT_EVENT_ABILITY_END_COOLDOWN, function OnEndCooldown)
        endif
    endfunction

    function ItemKelenDaggerOnDrop takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        set Table[GetHandleId(whichUnit)][COUNT] = Table[GetHandleId(whichUnit)][COUNT] - 1
        set whichUnit = null

        set KelenDaggerCount = KelenDaggerCount - 1
        if KelenDaggerCount == 0 then
            call OnDamagedEvent.Destroy()
            call OnEndCooldownEvent.Destroy()
        endif
    endfunction

endscope
