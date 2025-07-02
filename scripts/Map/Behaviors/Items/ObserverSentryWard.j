
library ObserverSentryWard requires ItemUtils, EventSystem, ItemSystem

    globals
        key OBSERVER_WARD_STACK
        key SENTRY_WARD_STACK
    endglobals

    private function GetWardCharges takes item whichItem returns integer
        return GetItemCharges(whichItem)
    endfunction

    function GetObserverWardStack takes item wardItem returns integer
        return Table[GetHandleId(wardItem)].integer[OBSERVER_WARD_STACK]
    endfunction
    function GetSentryWardStack takes item wardItem returns integer
        return Table[GetHandleId(wardItem)].integer[SENTRY_WARD_STACK]
    endfunction

    function AddObserverWardStack takes item wardStackable, integer observerStack, boolean updateCharges returns nothing
        local integer h     = GetHandleId(wardStackable)
        local integer stack = Table[h].integer[OBSERVER_WARD_STACK] + observerStack
        set Table[h].integer[OBSERVER_WARD_STACK] = stack
        // 如果堆叠目标是观察守卫形态，则更新物品堆叠
        if updateCharges and GetItemTypeId(wardStackable) == ItemRealId[Item_ObserverWardStackable] then
            call SetItemCharges(wardStackable, stack)
        endif
    endfunction

    function AddSentryWardStack takes item wardStackable, integer sentryStack, boolean updateCharges returns nothing
        local integer h     = GetHandleId(wardStackable)
        local integer stack = Table[h].integer[SENTRY_WARD_STACK] + sentryStack
        set Table[h].integer[SENTRY_WARD_STACK] = stack
        // 如果堆叠目标是岗哨守卫形态，则更新物品堆叠
        if updateCharges and GetItemTypeId(wardStackable) == ItemRealId[Item_SentryWardStackable] then
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
            call AddObserverWardStack(wardItem, GetWardCharges(whichItem), true)
            call SilentRemoveItem(whichItem)
        endif

        set wardItem = GetItemOfTypeFromUnit(whichUnit, ItemRealId[Item_SentryWardStackable])
        if wardItem != null then
            call AddObserverWardStack(wardItem, GetWardCharges(whichItem), true)
            call SilentRemoveItem(whichItem)
        endif

        // 如果没堆叠版本，但是有岗哨守卫，则创建堆叠版本(侦察守卫)
        set wardItem = GetItemOfTypeFromUnit(whichUnit, ItemRealId[Item_SentryWard])
        if wardItem != null then
            set observerStack = GetWardCharges(whichItem)
            set sentryStack   = GetWardCharges(wardItem)
            set TempPlayer = GetItemPlayer(whichItem)
            call SilentRemoveItem(whichItem)
            call SilentRemoveItem(wardItem)
            set TempItem = UnitAddItemById(whichUnit, ItemRealId[Item_ObserverWardStackable])
            call SetItemPlayer(TempItem, TempPlayer, false)
            call SetItemUserData(TempItem, 1)

            call AddObserverWardStack(TempItem, observerStack, true)
            call AddSentryWardStack(TempItem, sentryStack, true)
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

        //call BJDebugMsg("ItemSentryWardOnPickup:" + GetItemName(whichItem) + I2S(GetItemCharges(whichItem)) + " handle:" + I2S(GetHandleId(whichItem)))
        set wardItem = GetItemOfTypeFromUnit(whichUnit, ItemRealId[Item_ObserverWardStackable])
        if wardItem != null then
            call AddSentryWardStack(wardItem, GetWardCharges(whichItem), true)
            call SilentRemoveItem(whichItem)
        endif

        set wardItem = GetItemOfTypeFromUnit(whichUnit, ItemRealId[Item_SentryWardStackable])
        if wardItem != null then
            call AddSentryWardStack(wardItem, GetWardCharges(whichItem), true)
            call SilentRemoveItem(whichItem)
        endif

        // 如果没堆叠版本，但是有侦察守卫，则创建堆叠版本(侦察守卫)
        set wardItem = GetItemOfTypeFromUnit(whichUnit, ItemRealId[Item_ObserverWard])
        if wardItem != null then
            set observerStack = GetWardCharges(wardItem)
            set sentryStack   = GetWardCharges(whichItem)
            set TempPlayer = GetItemPlayer(whichItem)
            call SilentRemoveItem(whichItem)
            call SilentRemoveItem(wardItem)
            set TempItem = UnitAddItemById(whichUnit, ItemRealId[Item_ObserverWardStackable])
            call SetItemPlayer(TempItem, TempPlayer, false)
            call SetItemUserData(TempItem, 1)

            //call BJDebugMsg("observerStack:" + I2S(observerStack))
            //call BJDebugMsg("sentryStack:" + I2S(sentryStack))
            call AddObserverWardStack(TempItem, observerStack, true)
            call AddSentryWardStack(TempItem, sentryStack, true)
        endif

        set whichItem = null
        set whichUnit = null
    endfunction

    private function UpdateWardItem takes unit whichUnit, item wardItem returns nothing
        local integer    observerStack = GetObserverWardStack(wardItem)
        local integer    sentryStack   = GetSentryWardStack(wardItem)

        call DisableUnitManipulatItemTrig()
        if observerStack == 0 then
            call SilentRemoveItem(wardItem)
            set TempItem = CreateItem(ItemRealId[Item_SentryWard], GetUnitX(whichUnit), GetUnitY(whichUnit))
            call SetItemPlayer(TempItem, TempPlayer, false)
            call SetItemUserData(TempItem, 1)
            call SetItemCharges(TempItem, sentryStack)
            call UnitAddItem(whichUnit, TempItem)
        elseif sentryStack == 0 then
            call SilentRemoveItem(wardItem)
            set TempItem = CreateItem(ItemRealId[Item_ObserverWard], GetUnitX(whichUnit), GetUnitY(whichUnit))
            call SetItemPlayer(TempItem, TempPlayer, false)
            call SetItemUserData(TempItem, 1)
            call SetItemCharges(TempItem, observerStack)
            call UnitAddItem(whichUnit, TempItem)
        //else
        //    // 更新堆叠
        //    if GetItemTypeId(wardItem) == ItemRealId[Item_ObserverWardStackable] then
        //        call SetItemCharges(wardItem, observerStack)
        //    elseif GetItemTypeId(wardItem) == ItemRealId[Item_SentryWardStackable] then
        //        call SetItemCharges(wardItem, sentryStack)
        //    endif
        endif
        call EnableUnitManipulatItemTrig()
    endfunction

    private function SwitchWardItemStateOnExpried takes nothing returns nothing
        local SimpleTick tick      = SimpleTick.GetExpired()
        local unit       whichUnit = SimpleTickTable[tick].unit['u']
        local item       whichItem = SimpleTickTable[tick].item['i']
        local integer    itemTypeId
        local integer    observerStack
        local integer    sentryStack

        if GetItemTypeId(whichItem) != 0 then
            set itemTypeId = GetItemTypeId(whichItem)
            
            if itemTypeId == ItemRealId[Item_ObserverWardStackable] then

                set observerStack = Table[GetHandleId(whichItem)].integer[OBSERVER_WARD_STACK]
                set sentryStack   = Table[GetHandleId(whichItem)].integer[SENTRY_WARD_STACK]
                set TempPlayer = GetItemPlayer(whichItem)
                call SilentRemoveItem(whichItem)
                set TempItem = UnitAddItemById(whichUnit, ItemRealId[Item_SentryWardStackable])
                call SetItemPlayer(TempItem, TempPlayer, false)
                call SetItemUserData(TempItem, 1)
                call AddObserverWardStack(TempItem, observerStack, true)
                call AddSentryWardStack(TempItem, sentryStack, true)
                // 还要进入冷却时间
                call StartUnitAbilityCooldown(whichUnit, 'AA01')

            elseif itemTypeId == ItemRealId[Item_SentryWardStackable] then

                set observerStack = Table[GetHandleId(whichItem)].integer[OBSERVER_WARD_STACK]
                set sentryStack   = Table[GetHandleId(whichItem)].integer[SENTRY_WARD_STACK]
                set TempPlayer = GetItemPlayer(whichItem)
                call SilentRemoveItem(whichItem)
                set TempItem = UnitAddItemById(whichUnit, ItemRealId[Item_ObserverWardStackable])
                call SetItemPlayer(TempItem, TempPlayer, false)
                call SetItemUserData(TempItem, 1)
                call AddObserverWardStack(TempItem, observerStack, true)
                call AddSentryWardStack(TempItem, sentryStack, true)
                // 还要进入冷却时间
                call StartUnitAbilityCooldown(whichUnit, 'AA00')

            endif
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
        call DisableUnitManipulatItemTrig()
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
        call EnableUnitManipulatItemTrig()
        set it = null
    endfunction
    function ItemWardOnSpellEffect takes nothing returns nothing
        local integer id = GetSpellAbilityId()
        local unit target
        local unit ward
        local unit whichUnit
        local real x
        local real y
        local item it
        local item sourceItem
        local integer unitTypeId
        //local integer FCO
        local integer itemIndex
        local real    duration = 0

        // 注意，OnSpellEffect事件中，Item的Charges尚未扣除(-1)。

        if id =='A02X' or id =='AIsw' or id == 'AA00' or id == 'AA01' then
            if id =='A02X' or id == 'AA00' then
                set unitTypeId = 'o004'
                //set FCO ='A33D'
                set duration = 420
                set itemIndex = Item_ObserverWard
            elseif id =='AIsw' or id == 'AA01' then
                set unitTypeId = 'oeye'
                //set FCO ='A33E'
                set duration = 240
                set itemIndex = Item_SentryWard
            endif

            set whichUnit = GetTriggerUnit()
            set x = GetSpellTargetX()
            set y = GetSpellTargetY()

            set sourceItem = GetAbilitySourceItem(GetSpellAbility())
            if (id == 'AA00' or id == 'AA01') and (GetSpellTargetItem() == sourceItem) then
                // 对自己使用时
                call SwitchWardItemState(GetTriggerUnit(), GetSpellTargetItem())
            elseif GetSpellTargetUnit() == null then
                if IsPointInRegion(RoshanAllowedAttackRect, x, y) then
                    // 如果是堆叠版本，直接保持原有堆叠数量即可
                    if (id == 'AA00' or id == 'AA01') then
                        call SetItemCharges(sourceItem, GetItemCharges(sourceItem) + 1)
                    else
                        call HeroReimburseWard(whichUnit, unitTypeId)
                    endif
                else
                    set ward = CreateUnit(GetOwningPlayer(whichUnit), unitTypeId, x, y, 0)
                    call SetUnitPathing(ward, false)
                    call SetUnitPosition(ward, x, y)
                    call UnitAddAbility(ward,'A0XB')
                    call UnitApplyTimedLife(ward,'BTFL', duration)
                    set ward = null

                    // 堆叠版本使用完毕后不会消失，因此更新堆叠后再更新物品，在更新物品里处理用完后的逻辑
                    
                    if (id == 'AA00') then
                        call AddObserverWardStack(sourceItem, -1, false)
                        call UpdateWardItem(whichUnit, sourceItem)
                    elseif (id == 'AA01') then
                        call AddSentryWardStack(sourceItem, -1, false)
                        call UpdateWardItem(whichUnit, sourceItem)
                    endif
                endif
            else
                set target = GetSpellTargetUnit()
                set it = GetItemOfTypeFromUnit(target, itemIndex)
                if it != null then
                    call SetItemCharges(it, GetItemCharges(it) + 1)
                elseif GetItemOfTypeFromUnit(target, Item_ObserverWardStackable) != null then
                    // 如果有堆叠版本，则先添加堆叠数量
                    call AddObserverWardStack(GetItemOfTypeFromUnit(target, Item_ObserverWardStackable), 1, true)

                    if (id == 'AA00') then
                        call AddObserverWardStack(sourceItem, -1, false)
                        call UpdateWardItem(whichUnit, sourceItem)
                    elseif (id == 'AA01') then
                        call AddSentryWardStack(sourceItem, -1, false)
                        call UpdateWardItem(whichUnit, sourceItem)
                    endif
                elseif GetItemOfTypeFromUnit(target, Item_SentryWardStackable) != null then
                    call AddSentryWardStack(GetItemOfTypeFromUnit(target, Item_SentryWardStackable), 1, true)

                    if (id == 'AA00') then
                        call AddObserverWardStack(sourceItem, -1, false)
                        call UpdateWardItem(whichUnit, sourceItem)
                    elseif (id == 'AA01') then
                        call AddSentryWardStack(sourceItem, -1, false)
                        call UpdateWardItem(whichUnit, sourceItem)
                    endif
                elseif GetUnitEmptyInventorySlotCount(target)> 0 then
                    set it = CreateItem(ItemRealId[itemIndex], 0, 0)
                    call SetItemCharges(it, 1)
                    call UnitAddItem(target, it)
                else
                    call DisplayTimedTextToPlayer(GetOwningPlayer(whichUnit), 0, 0, 5, "目标背包已满")
                    call HeroReimburseWard(whichUnit, unitTypeId)
                endif
                set it = null
            endif
        endif

        set sourceItem = null
        set whichUnit  = null
        set ward       = null
        set target     = null
    endfunction

endlibrary
