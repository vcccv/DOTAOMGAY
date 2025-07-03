
library ItemSystem requires Base, TimerUtils, AbilityUtils, UnitStatus

/*

class:
Permanent     = 可用物品，适用于RealId
Artifact      = 可堆叠可用物品，适用于realId
Purchasable   = 拾取物品，适用于PowerUpId
Campaign      = 禁用物品，适用于DisabledId
Miscellaneous = 应该是古早版本狼人嚎叫马甲物品？ Lycan Damage - xxx
PowerUp       = 神符类物品

ItemUserData:
>0 1是有效
-2 是卖出的

*/


    globals
        // 可拾取的物品类型
        integer array ItemPowerUpId
        // 真正起作用的有效物品类型
        integer array ItemRealId
        // 出售的马甲单位类型
        integer array ItemSellDummyId
        // 禁用状态的物品类型
        integer array ItemDisabledId

        string  array ItemsIconFilePath

        // 边路商店指向的物品索引对象
        integer array ItemSideLaneShopId

        integer       MaxItemCount = 0

        private key ITEM_INDEX
        private key ITEM_SELL_DUMMY_INDEX

        // 物品合成

        // 合成配方物品索引1~5
        integer array CombineIndex1
        integer array CombineIndex2
        integer array CombineIndex3
        integer array CombineIndex4
        integer array CombineIndex5
        // 合成对象物品索引
        integer array CombinedIndex
        // 可合成装备最大数量
        integer CombineMaxIndex = 0

    endglobals

    // powerup    = Purchasable
    // realId     = Permanent
    // disabledId = Campaign
    function RegisterItem takes integer powerupId, integer realId, integer sellDummyId, integer disabledId returns integer
        set MaxItemCount = MaxItemCount + 1

        set ItemPowerUpId[MaxItemCount]   = powerupId
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

    function GetItemIndexById takes integer id returns integer
        return Table[ITEM_INDEX].integer[id]
    endfunction

    // 通过物品索引来得到它的快速合成索引
    function GetCombinedIndexByItemIndex takes integer id, boolean fromRecipe returns integer
        local integer i = 0
        // fromRecipe == fromRecipe 双击卷轴快速合成时需要查找 如果不是就意味着是快速购买 则为unitId
        // 如果fromRecipe == false 则找到ITDB(快速合成)匹配的对象，返回合成索引
        // 如果fromRecipe == true  则寻找5个配方是否和id匹配，返回合成索引
        loop
            if (fromRecipe == false and CombinedIndex[i]== LoadInteger(HY,'ITDB', id)) or(fromRecipe and(CombineIndex1[i]== id or CombineIndex2[i]== id or CombineIndex3[i]== id or CombineIndex4[i]== id or CombineIndex5[i]== id)) then
                return i
            endif
            set i = i + 1
        exitwhen i > CombineMaxIndex
        endloop
        return - 1
    endfunction

    // 获取物品索引，只要是被注册的物品就会返回索引 物品为null时返回-2 未注册物品返回-1
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

        return - 1
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
                return - 1
            endif
            return itemIndex
        endif

        return - 1
    endfunction

    function GetItemIndexBySellUnit takes unit whichUnit returns integer
        local integer unitId
        local integer itemIndex
        if whichUnit == null then
            return -2
        endif
        set unitId    = GetUnitTypeId(whichUnit)
        set itemIndex = Table[ITEM_SELL_DUMMY_INDEX].integer[unitId]
        
        if itemIndex > 0 then
            return itemIndex
        endif

        return - 1
    endfunction

    function GetItemIndexByUnitId takes integer unitId returns integer
        local integer itemIndex

        set itemIndex = Table[ITEM_SELL_DUMMY_INDEX].integer[unitId]
        if itemIndex > 0 then
            return itemIndex
        endif

        return - 1
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

        return - 1
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

        return - 1
    endfunction

    globals
        private integer UnitManipulatItemTrigDisableCount = 0
    endglobals

    function DisableUnitManipulatItemTrig takes nothing returns nothing
        set UnitManipulatItemTrigDisableCount = UnitManipulatItemTrigDisableCount + 1
        if UnitManipulatItemTrigDisableCount == 1 then
            call DisableTrigger(UnitManipulatItemTrig)
        endif
    endfunction
    function EnableUnitManipulatItemTrig takes nothing returns nothing
        set UnitManipulatItemTrigDisableCount = UnitManipulatItemTrigDisableCount - 1
        if UnitManipulatItemTrigDisableCount == 0 then
            call EnableTrigger(UnitManipulatItemTrig)
        endif
    endfunction
    
    // RemoveItemNoTrig
    function SilentRemoveItem takes item whichItem returns nothing
        // 可能没删掉
        call DisableUnitManipulatItemTrig()
        if GetWidgetLife(whichItem) <= 0.405 then
            call SetWidgetLife(whichItem, 1.)
            call BJDebugMsg("无法删除物品：" + MHString_FromId(GetItemTypeId(whichItem)) + " 所有者:" + GetPlayerName(GetItemPlayer(whichItem)))
        endif
        call RemoveItem(whichItem)
        call EnableUnitManipulatItemTrig()
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

    // 寻找其他可堆叠目标物品，物品所有者必须是指定玩家，除非是2种眼睛
    function GetStackingItemTarget takes player whichPlayer, unit whichUnit, integer itemIndex, item stackingItemSource returns item
        local integer i
        local item    it
        set i = 0
        loop
        exitwhen i > 5
            set it = UnitItemInSlot(whichUnit, i)
            if it != null and it != stackingItemSource and GetItemIndexEx(it) == itemIndex /*
                */ and (GetItemPlayer(it) == whichPlayer /*
                */ or itemIndex == Item_ObserverWard /*
                */ or itemIndex == Item_SentryWard) then
                set it = null
                return UnitItemInSlot(whichUnit, i)
            endif
            set i = i + 1
        endloop
        set it = null
        return null
    endfunction
    // 寻找其他可堆叠目标物品，物品所有者必须是指定玩家，除非是2种眼睛
    function GetStackingItemTargetByIndex takes player whichPlayer, unit whichUnit, integer itemIndex returns item
        local integer i
        local item    it
        set i = 0
        loop
        exitwhen i > 5
            set it = UnitItemInSlot(whichUnit, i)
            if it != null and GetItemIndexEx(it) == itemIndex /*
                */ and (GetItemPlayer(it) == whichPlayer /*
                */ or itemIndex == Item_ObserverWard /*
                */ or itemIndex == Item_SentryWard) then
                set it = null
                return UnitItemInSlot(whichUnit, i)
            endif
            set i = i + 1
        endloop
        set it = null
        return null
    endfunction

    function GetStackingItemTargetByStackableWard takes unit whichUnit returns item
        local integer i
        local item    it
        local integer itemIndex
        set i = 0
        loop
        exitwhen i > 5
            set it = UnitItemInSlot(whichUnit, i)
            set itemIndex = GetItemIndexEx(it)
            if it != null and ( itemIndex == Item_ObserverWardStackable or itemIndex == Item_SentryWardStackable ) then
                set it = null
                return UnitItemInSlot(whichUnit, i)
            endif
            set i = i + 1
        endloop
        set it = null
        return null
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

    globals
        private integer EnableManipulateMethodCount = 0
    endglobals

    // 允许触发操作物品方法
    function ItemSystem_EnableItemManipulateMethod takes boolean enable returns nothing
        if enable then
            set EnableManipulateMethodCount = EnableManipulateMethodCount + 1
        else
            set EnableManipulateMethodCount = EnableManipulateMethodCount - 1
        endif
    endfunction

    function ItemSystem_IsManipulateMethodEnabled takes nothing returns boolean
        return EnableManipulateMethodCount >= 0
    endfunction

    function ExecutePickupItem takes unit whichUnit, item whichItem returns nothing
        local integer itemIndex = GetItemIndex(whichItem)
        if itemIndex > 0 and GetItemTypeId(whichItem) == ItemRealId[itemIndex] and RealItemPickupMethod[itemIndex] != 0 then
            set Event.INDEX = Event.INDEX + 1
            set Event.TrigUnit[Event.INDEX] = whichUnit
            set Event.ManipulatedItem[Event.INDEX] = whichItem
            call MHGame_ExecuteCodeEx(RealItemPickupMethod[itemIndex])
            set Event.INDEX = Event.INDEX - 1
        endif
    endfunction
    function ExecuteDropItem takes unit whichUnit, item whichItem returns nothing
        local integer itemIndex = GetItemIndex(whichItem)
        if itemIndex > 0 and GetItemTypeId(whichItem) == ItemRealId[itemIndex] and RealItemDropMethod[itemIndex] != 0 then
            set Event.INDEX = Event.INDEX + 1
            set Event.TrigUnit[Event.INDEX] = whichUnit
            set Event.ManipulatedItem[Event.INDEX] = whichItem
            call MHGame_ExecuteCodeEx(RealItemDropMethod[itemIndex])
            set Event.INDEX = Event.INDEX - 1
        endif
    endfunction

    function OnPuckupItem takes nothing returns boolean
        local unit whichUnit = GetTriggerUnit()
        local item whichItem = GetManipulatedItem()

        if ItemSystem_IsManipulateMethodEnabled() and not IsUnitCourier(whichUnit) then
            call ExecutePickupItem(whichUnit, whichItem)
        endif

        set whichItem = null
        set whichUnit = null
        return false
    endfunction

    function OnDropItem takes nothing returns boolean
        local unit whichUnit = GetTriggerUnit()
        local item whichItem = GetManipulatedItem()

        if ItemSystem_IsManipulateMethodEnabled() and not IsUnitCourier(whichUnit) then
            call ExecuteDropItem(whichUnit, whichItem)
        endif

        set whichItem = null
        set whichUnit = null
        return false
    endfunction

    globals
        private trigger PuckupItemTrig
        private trigger DropItemTrig

        private trigger ItemCreateTrig
        private trigger ItemRemoveTrig
    endglobals

    /*
    call TriggerRegisterAnyUnitEvent(UnitManipulatItemTrig, EVENT_PLAYER_UNIT_PICKUP_ITEM)
	call TriggerRegisterAnyUnitEvent(UnitManipulatItemTrig, EVENT_PLAYER_UNIT_DROP_ITEM)
	call TriggerRegisterAnyUnitEvent(UnitManipulatItemTrig, EVENT_PLAYER_UNIT_PAWN_ITEM)
    */
    private function OnCreate takes nothing returns nothing
        local item it = MHEvent_GetItem()
        set it = null
    endfunction
    private function OnRemove takes nothing returns nothing
        local item it = MHEvent_GetItem()
        if GetHandleId(it) > 0 then
            call Table[GetHandleId(it)].flush()
        endif
        set it = null
    endfunction
    // 合成物品时移除物品不走地图内的操作物品事件，因此自己写一个
    function ItemSystem_Init takes nothing returns nothing
        set PuckupItemTrig = CreateTrigger()
        set DropItemTrig = CreateTrigger()

        call TriggerAddCondition(PuckupItemTrig, Condition(function OnPuckupItem))
        call TriggerAddCondition(DropItemTrig, Condition(function OnDropItem))
        call TriggerRegisterAnyUnitEvent(PuckupItemTrig, EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerRegisterAnyUnitEvent(DropItemTrig, EVENT_PLAYER_UNIT_DROP_ITEM)

        set ItemCreateTrig = CreateTrigger()
        set ItemRemoveTrig = CreateTrigger()
        call MHItemCreateEvent_Register(ItemCreateTrig)
        call MHItemRemoveEvent_Register(ItemRemoveTrig)
        call TriggerAddCondition(ItemCreateTrig, Condition(function OnCreate))
        call TriggerAddCondition(ItemRemoveTrig, Condition(function OnRemove))
    endfunction
    
endlibrary
