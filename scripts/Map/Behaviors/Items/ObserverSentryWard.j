
scope ObserverSentryWard

    globals
        key OBSERVER_WARD_STACK
        key SENTRY_WARD_STACK
    endglobals

    private function GetWardCharges takes item whichItem returns integer
        if GetItemUserData(whichItem) == 0 then
            return 1
        endif
        return GetItemCharges(whichItem)
    endfunction

    function AddObserverWardStack takes item wardStackable, integer observerStack returns nothing
        local integer h     = GetHandleId(wardStackable)
        local integer stack = Table[h].integer[OBSERVER_WARD_STACK] + observerStack
        set Table[h].integer[OBSERVER_WARD_STACK] = stack
        // 如果堆叠目标是观察守卫形态，则更新物品堆叠
        if GetItemTypeId(wardStackable) == ItemRealId[Item_ObserverWardStackable] then
            call SetItemCharges(wardStackable, stack)
        endif
    endfunction

    function AddSentryWardStack takes item wardStackable, integer sentryStack returns nothing
        local integer h     = GetHandleId(wardStackable)
        local integer stack = Table[h].integer[SENTRY_WARD_STACK] + sentryStack
        set Table[h].integer[SENTRY_WARD_STACK] = stack
        // 如果堆叠目标是岗哨守卫形态，则更新物品堆叠
        if GetItemTypeId(wardStackable) == ItemRealId[Item_SentryWardStackable] then
            call SetItemCharges(wardStackable, stack)
        endif
    endfunction

    function ItemObserverWardOnPickup takes nothing returns nothing
        local unit       whichUnit = Event.GetTriggerUnit()
        local item       whichItem = Event.GetManipulatedItem()
        local item       wardItem
        local integer    observerStack
        local integer    sentryStack

        set wardItem = GetItemOfTypeFromUnit(whichUnit, ItemRealId[Item_ObserverWardStackable])
        if wardItem != null then
            call AddObserverWardStack(wardItem, GetWardCharges(whichItem))
            call SilentRemoveItem(whichItem)
        endif

        set wardItem = GetItemOfTypeFromUnit(whichUnit, ItemRealId[Item_SentryWardStackable])
        if wardItem != null then
            call AddObserverWardStack(wardItem, GetWardCharges(whichItem))
            call SilentRemoveItem(whichItem)
        endif

        // 如果没堆叠版本，但是有岗哨守卫，则创建堆叠版本(侦察守卫)
        set wardItem = GetItemOfTypeFromUnit(whichUnit, ItemRealId[Item_SentryWard])
        if wardItem != null then
            set observerStack = GetWardCharges(whichItem)
            set sentryStack   = GetWardCharges(wardItem)
            set TempPlayer = GetItemPlayer(whichItem)
            call RemoveItem(whichItem)
            call RemoveItem(wardItem)
            set TempItem = UnitAddItemById(whichUnit, ItemRealId[Item_ObserverWardStackable])
            call SetItemPlayer(TempItem, TempPlayer, false)
            call SetItemUserData(TempItem, 1)

            call AddObserverWardStack(TempItem, observerStack)
            call AddSentryWardStack(TempItem, sentryStack)
        endif

        set whichItem = null
        set whichUnit = null
    endfunction

    function ItemSentryWardOnPickup takes nothing returns nothing
        local unit       whichUnit = Event.GetTriggerUnit()
        local item       whichItem = Event.GetManipulatedItem()
        local item       wardItem
        local integer    observerStack
        local integer    sentryStack

        set wardItem = GetItemOfTypeFromUnit(whichUnit, ItemRealId[Item_ObserverWardStackable])
        if wardItem != null then
            call AddSentryWardStack(wardItem, GetWardCharges(whichItem))
            call SilentRemoveItem(whichItem)
        endif

        set wardItem = GetItemOfTypeFromUnit(whichUnit, ItemRealId[Item_SentryWardStackable])
        if wardItem != null then
            call AddSentryWardStack(wardItem, GetWardCharges(whichItem))
            call SilentRemoveItem(whichItem)
        endif

        // 如果没堆叠版本，但是有侦察守卫，则创建堆叠版本(侦察守卫)
        set wardItem = GetItemOfTypeFromUnit(whichUnit, ItemRealId[Item_ObserverWard])
        if wardItem != null then
            set observerStack = GetWardCharges(whichItem)
            set sentryStack   = GetWardCharges(wardItem)
            set TempPlayer = GetItemPlayer(whichItem)
            call RemoveItem(whichItem)
            call RemoveItem(wardItem)
            set TempItem = UnitAddItemById(whichUnit, ItemRealId[Item_ObserverWardStackable])
            call SetItemPlayer(TempItem, TempPlayer, false)
            call SetItemUserData(TempItem, 1)

            call BJDebugMsg("observerStack:" + I2S(observerStack))
            call BJDebugMsg("sentryStack:" + I2S(sentryStack))
            call AddObserverWardStack(TempItem, observerStack)
            call AddSentryWardStack(TempItem, sentryStack)
        endif

        set whichItem = null
        set whichUnit = null
    endfunction

    private function SwitchWardItemStateOnExpried takes nothing returns nothing
        local SimpleTick tick      = SimpleTick.GetExpired()
        local unit       whichUnit = SimpleTickTable[tick].unit['u']
        local item       whichItem = SimpleTickTable[tick].item['i']

        if GetItemTypeId(whichItem) != 0 then

        endif

        set whichUnit = null
        set whichItem = null
    endfunction

    private function SwitchWardItemState takes unit whichUnit, item whichItem returns nothing
        local SimpleTick tick = SimpleTick.CreateEx()
        set SimpleTickTable[tick].unit['u'] = whichUnit
        set SimpleTickTable[tick].item['i'] = whichItem
        call tick.Start(0., false, function SwitchWardItemStateOnExpried)
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
            // 对自己使用时
            if GetSpellTargetItem() == GetAbilitySourceItem(GetSpellAbility()) then
                call SwitchWardItemState(whichUnit, GetSpellTargetItem())
            elseif GetSpellTargetUnit() == null then
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
