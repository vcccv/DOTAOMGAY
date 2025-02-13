
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

        integer array RealItemPickupCode
        integer array RealItemDropCode

        // 按索引记录物品的存在计数
        integer array ItemCount

        private key ITEM_INDEX
        private key ITEM_SELL_DUMMY_INDEX
    endglobals

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

    //***************************************************************************
    //*
    //*  Item Status
    //*
    //***************************************************************************

    function IsItemAghanimScepter takes item it returns boolean
        local integer i = GetItemIndexEx(it)
        local integer id = GetItemTypeId(it)
        if id == ItemRealId[Item_AghanimScepter]or id == ItemRealId[Item_AghanimScepterBasic]or id == ItemRealId[Item_AghanimScepterGiftable] then
            return true
        endif
        return false
    endfunction
    // 消耗物品 perishable
    function IsItemPerishableByIndex takes integer itemIndex returns boolean
        return itemIndex == NXV or itemIndex == R6V or itemIndex == Item_DustOfAppearance or itemIndex == RYV or itemIndex == R_V or itemIndex == Item_AncientTangoOfEssifation or itemIndex == R2V or itemIndex == Item_SentryWard or itemIndex == R4V or itemIndex == RZV or itemIndex == R9V or itemIndex == IVV or itemIndex == it_jys
    endfunction
    // 充能物品 Charged
    function IsItemChargedByIndex takes integer itemIndex returns boolean
        return(itemIndex) == NUV or itemIndex == RRV or(itemIndex) == IUV or(itemIndex) == IWV or itemIndex == NIV or itemIndex == AIV or(itemIndex) == Item_MagicStick or(itemIndex) == Item_MagicWand or itemIndex == RAV
    endfunction

    // 会死亡丢弃 DeathDrop
    function IsItemDeathDrop takes item whichItem returns boolean
        local integer itemIndex = GetItemIndexEx(whichItem)
        return itemIndex == ASV or itemIndex == ATV or itemIndex == ITem_GemOfTrueSight or itemIndex == ITem_GemOfTrueSight_CourierEdition
    endfunction

    // 获取物品图标
    function GetItemIcon takes item whichItem returns string
        if whichItem == null then
            return "UI\\Widgets\\Console\\Undead\\undead-inventory-slotfiller.blp"
        endif
        return ItemsIconFilePath[GetItemIndexEx(whichItem)]
    endfunction

    // 获取消耗品默认使用次数
    function GetPerishableItemChargesByIndex takes integer itemIndex returns integer
        if Item_AncientTangoOfEssifation == itemIndex then
            return 4
        endif
        if Item_SentryWard == itemIndex or Item_DustOfAppearance == itemIndex then
            return 2
        endif
        return 1
    endfunction
    
    //***************************************************************************
    //*
    //*  Method
    //*
    //***************************************************************************
    function SetItemPuckupMethodByIndex takes integer itemIndex, string func returns nothing
        set RealItemPickupCode[itemIndex] = C2I(MHGame_GetCode(func))
        call ThrowWarning(RealItemPickupCode[itemIndex] == 0, "ItemSystem", "SetItemPuckupMethodByIndex", "itemIndex", itemIndex, "func == 0")
    endfunction
    function SetItemDropMethodByIndex takes integer itemIndex, string func returns nothing
        set RealItemDropCode[itemIndex] = C2I(MHGame_GetCode(func))
        call ThrowWarning(RealItemDropCode[itemIndex] == 0, "ItemSystem", "SetItemDropMethodByIndex", "itemIndex", itemIndex, "func == 0")
    endfunction
    
    function SetItemMethodByIndexSimple takes integer itemIndex, string puckupFunc, string dropFunc returns nothing
        call SetItemPuckupMethodByIndex(itemIndex, puckupFunc)
        call SetItemDropMethodByIndex(itemIndex, dropFunc)
    endfunction

    function ItemSystem_OnPickup takes unit whichUnit, item whichItem returns nothing
        local integer itemIndex = GetItemIndex(whichItem)
        if itemIndex > 0 and GetItemTypeId(whichItem) == ItemRealId[itemIndex] and RealItemPickupCode[itemIndex] != 0 then
            set Event.INDEX = Event.INDEX + 1
            set Event.TrigUnit[Event.INDEX] = whichUnit
            set Event.ManipulatedItem[Event.INDEX] = whichItem
            call MHGame_ExecuteCodeEx(RealItemPickupCode[itemIndex])
            set Event.INDEX = Event.INDEX - 1
        endif
    endfunction
    function ItemSystem_OnDrop takes unit whichUnit, item whichItem returns nothing
        local integer itemIndex = GetItemIndex(whichItem)
        if itemIndex > 0 and GetItemTypeId(whichItem) == ItemRealId[itemIndex] and RealItemDropCode[itemIndex] != 0 then
            set Event.INDEX = Event.INDEX + 1
            set Event.TrigUnit[Event.INDEX] = whichUnit
            set Event.ManipulatedItem[Event.INDEX] = whichItem
            call MHGame_ExecuteCodeEx(RealItemDropCode[itemIndex])
            set Event.INDEX = Event.INDEX - 1
        endif
    endfunction
    
endlibrary

