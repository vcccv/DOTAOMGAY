
library ItemSystem requires Base, TimerUtils, AbilityUtils

    globals
        integer array ItemPowerupId
        integer array ItemRealId
        
        integer array ItemSellDummyId

        integer array ItemDisabledId

        string  array ItemsIconFilePath
        // SideLaneShop
        integer array ItemSideLaneShopId

        integer       MaxItemCount = 0

        // 按索引记录物品的存在计数
        integer array ItemCount

        private key ITEM_INDEX
        private key ITEM_SELL_DUMMY_INDEX
    endglobals

    // powerup    = Purchasable
    // realId     = Permanent
    // disabledId = Campaign
    function RegisterItem takes integer powerupId, integer realId, integer sellDummyId, integer disabledId returns integer
        set MaxItemCount = MaxItemCount + 1

        set ItemPowerupId[MaxItemCount]   = powerupId
        set ItemRealId[MaxItemCount]      = realId
        set ItemSellDummyId[MaxItemCount] = sellDummyId
        set ItemDisabledId[MaxItemCount]  = disabledId
        call SaveBoolean(SightDataHashTable, ItemSellDummyId[MaxItemCount], 0, true)

        // 如果有多个物品对象使用的id相同 则只取第一个
        if not Table[ITEM_INDEX].integer.has(powerupId) then
            set Table[ITEM_INDEX].integer[powerupId]  = MaxItemCount
        endif
        if not Table[ITEM_INDEX].integer.has(realId) then
            set Table[ITEM_INDEX].integer[realId]     = MaxItemCount
        endif
        if not Table[ITEM_INDEX].integer.has(disabledId) then
            set Table[ITEM_INDEX].integer[disabledId] = MaxItemCount
        endif
        if not Table[ITEM_SELL_DUMMY_INDEX].integer.has(sellDummyId) then
            set Table[ITEM_SELL_DUMMY_INDEX].integer[sellDummyId] = MaxItemCount
        endif

        if realId > 0 then
            set ItemsIconFilePath[MaxItemCount] = MHItem_GetDefDataStr(realId, ITEM_DEF_DATA_ART)// GetAbilitySoundById(realId, SOUND_TYPE_EFFECT_LOOPED)
        endif
        return MaxItemCount
    endfunction

    function GetItemIndexById takes integer itemId returns integer
        return Table[ITEM_INDEX].integer[itemId]
    endfunction

    function GetItemIndexEx takes item whichItem returns integer
        local integer itemId
        local integer itemIndex
        if whichItem == null then
            return -2
        endif
        set itemId    = GetItemTypeId(whichItem)
        set itemIndex = GetItemIndexById(itemId)
  
        if itemIndex > 0 then
            return itemIndex
        endif

        return -1
    endfunction
    
    // 获取物品的索引 不包含禁用状态，是禁用状态时会返回-1
    function GetItemIndex takes item whichItem returns integer
        local integer itemId
        local integer itemIndex
        if whichItem == null then
            return -2
        endif
        set itemId    = GetItemTypeId(whichItem)
        set itemIndex = GetItemIndexById(itemId)
        
        if itemIndex > 0 then
            if ItemDisabledId[itemIndex] == itemId then
                return -1
            endif
            return itemIndex
        endif

        return -1
    endfunction

    function GetItemIndexBySellUnit takes unit whichUnit returns integer
        local integer unitId
        local integer itemIndex
        local integer i = 0
        if whichUnit == null then
            return -2
        endif
        set unitId    = GetUnitTypeId(whichUnit)
        set itemIndex = Table[ITEM_SELL_DUMMY_INDEX].integer[unitId]
        
        if itemIndex > 0 then
            return itemIndex
        endif

        return -1
    endfunction

    // 获取禁用物品的索引
    function GetDisabledItemIndex takes item whichItem returns integer
        local integer itemId
        local integer itemIndex
        if whichItem == null then
            return -2
        endif
        set itemId    = GetItemTypeId(whichItem)
        set itemIndex = GetItemIndexById(itemId)

        if ItemDisabledId[itemIndex] == itemId then
            return itemIndex
        endif

        return -1
    endfunction
    // 获取禁用物品的有效物品id
    function GetDisabledItemRealId takes item whichItem returns integer
        local integer itemId
        local integer itemIndex
        local integer i = 1
        if whichItem == null then
            return -2
        endif
        set itemId    = GetItemTypeId(whichItem)
        set itemIndex = GetItemIndexById(itemId)

        if ItemDisabledId[itemIndex] == itemId then
            return ItemRealId[itemIndex]
        endif

        return -1
    endfunction

    // RemoveItemNoTrig
    function SilentRemoveItem takes item whichItem returns nothing
        local boolean isEnabled = IsTriggerEnabled(UnitManipulatItemTrig)
        // 可能没删掉
        call DisableTrigger(UnitManipulatItemTrig)
        if GetWidgetLife(whichItem) <= 0.405 then
            call SetWidgetLife(whichItem, 1.)
            call BJDebugMsg("删不掉啊")
        endif
        call RemoveItem(whichItem)
        if isEnabled then
            call EnableTrigger(UnitManipulatItemTrig)
        endif
    endfunction
    // 获取剩余格子 GetUnitEmptyInventorySlotCount
    function GetUnitEmptyInventorySlotCount takes unit whichUnit returns integer
        local integer i = 0
        local integer n = 0
        local integer size = UnitInventorySize(whichUnit)-1
        loop
        exitwhen i > size
            if UnitItemInSlot(whichUnit, i) == null then
                set n = n + 1
            endif
            set i = i + 1
        endloop
        return n
    endfunction

    // 获取物品图标
    function GetItemIcon takes item whichItem returns string
        if whichItem == null then
            return "UI\\Widgets\\Console\\Undead\\undead-inventory-slotfiller.blp"
        endif
        return ItemsIconFilePath[GetItemIndexEx(whichItem)]
    endfunction
    
    //***************************************************************************
    //*
    //*  Method
    //*
    //***************************************************************************
    globals
        private integer array RealItemPickupMethod
        private integer array RealItemDropMethod
    endglobals

    function RegisterItemPuckupMethodByIndex takes integer itemIndex, string func returns nothing
        set RealItemPickupMethod[itemIndex] = C2I(MHGame_GetCode(func))
        call ThrowWarning(RealItemPickupMethod[itemIndex] == 0, "ItemSystem", "RegisterItemPuckupMethodByIndex", "itemIndex", itemIndex, "func == 0")
    endfunction
    function RegisterItemDropMethodByIndex takes integer itemIndex, string func returns nothing
        set RealItemDropMethod[itemIndex] = C2I(MHGame_GetCode(func))
        call ThrowWarning(RealItemDropMethod[itemIndex] == 0, "ItemSystem", "RegisterItemDropMethodByIndex", "itemIndex", itemIndex, "func == 0")
    endfunction
    
    function RegisterItemMethodSimple takes integer itemIndex, string puckupFunc, string dropFunc returns nothing
        call RegisterItemPuckupMethodByIndex(itemIndex, puckupFunc)
        call RegisterItemDropMethodByIndex(itemIndex, dropFunc)
    endfunction

    function ItemSystem_OnPickup takes unit whichUnit, item whichItem returns nothing
        local integer itemIndex = GetItemIndex(whichItem)
        if itemIndex > 0 and GetItemTypeId(whichItem) == ItemRealId[itemIndex] and RealItemPickupMethod[itemIndex] != 0 then
            set Event.INDEX = Event.INDEX + 1
            set Event.TrigUnit[Event.INDEX] = whichUnit
            set Event.ManipulatedItem[Event.INDEX] = whichItem
            call MHGame_ExecuteCodeEx(RealItemPickupMethod[itemIndex])
            set Event.INDEX = Event.INDEX - 1
        endif
    endfunction
    function ItemSystem_OnDrop takes unit whichUnit, item whichItem returns nothing
        local integer itemIndex = GetItemIndex(whichItem)
        if itemIndex > 0 and GetItemTypeId(whichItem) == ItemRealId[itemIndex] and RealItemDropMethod[itemIndex] != 0 then
            set Event.INDEX = Event.INDEX + 1
            set Event.TrigUnit[Event.INDEX] = whichUnit
            set Event.ManipulatedItem[Event.INDEX] = whichItem
            call MHGame_ExecuteCodeEx(RealItemDropMethod[itemIndex])
            set Event.INDEX = Event.INDEX - 1
        endif
    endfunction
    
endlibrary

