
scope ObserverSentryWard

    function ItemObserverWardOnPickup takes nothing returns nothing
        
    endfunction

    function ItemSentryWardOnPickup takes nothing returns nothing
        
    endfunction

    function HeroReimburseWard takes unit whichUnit, integer unitTypeId returns nothing
        local integer itemTypeId
        local item it
        if unitTypeId =='o004' then
            set itemTypeId = ItemRealId[Item_ObserverWard]
        else
            set itemTypeId = ItemRealId[Item_SentryWard]
        endif
        call DisableTrigger(UnitManipulatItemTrig)
        set it = GetItemOfTypeFromUnit(whichUnit, itemTypeId)
        if it == null then
            set TempPlayer = GetOwningPlayer(whichUnit)
            set TempItem = CreateItem(itemTypeId, 0, 0)
            call UnitAddItem(whichUnit, TempItem)
            call SetItemPlayer(TempItem, TempPlayer, false)
            call SetItemUserData(TempItem, 1)
        else
            call SetItemCharges(it, GetItemCharges(it) + 1)
        endif
        call EnableTrigger(UnitManipulatItemTrig)
        set it = null
    endfunction
    function ItemWardOnSpellEffect takes nothing returns nothing
        local integer id = GetSpellAbilityId()
        local unit ward
        local unit whichUnit
        local real x
        local real y
        local item it
        local integer unitTypeId
        local integer FCO
        local integer itemIndex
        local real    duration = 0

        if id =='A02X' or id =='AIsw' then
            if id =='A02X' then
                set unitTypeId = 'o004'
                set FCO ='A33D'
                set duration = 420
                set itemIndex = Item_ObserverWard
            else
                set unitTypeId = 'oeye'
                set FCO ='A33E'
                set duration = 240
                set itemIndex = Item_SentryWard
            endif
            set whichUnit = GetTriggerUnit()
            set x = GetSpellTargetX()
            set y = GetSpellTargetY()
            if GetSpellTargetUnit() == null then
                if IsPointInRegion(FLV, x, y) then
                    call HeroReimburseWard(whichUnit, unitTypeId)
                else
                    set ward = CreateUnit(GetOwningPlayer(whichUnit), unitTypeId, x, y, 0)
                    call SetUnitPathing(ward, false)
                    call SetUnitPosition(ward, x, y)
                    call UnitAddAbility(ward,'A0XB')
                    call UnitApplyTimedLife(ward,'BTFL', duration)
                    set ward = null
                endif
            else
                set ward = GetSpellTargetUnit()
                set it = GetItemOfTypeFromUnit(ward, itemIndex)
                if it != null then
                    call SetItemCharges(it, GetItemCharges(it) + 1)
                elseif GetUnitEmptyInventorySlotCount(ward)> 0 then
                    set it = CreateItem(ItemRealId[itemIndex], 0, 0)
                    call SetItemCharges(it, 1)
                    call UnitAddItem(ward, it)
                else
                    call DisplayTimedTextToPlayer(GetOwningPlayer(whichUnit), 0, 0, 5, "目标背包已满")
                    call HeroReimburseWard(whichUnit, unitTypeId)
                endif
                set it = null
            endif
        endif
        set whichUnit = null
        set ward = null
    endfunction

endscope
