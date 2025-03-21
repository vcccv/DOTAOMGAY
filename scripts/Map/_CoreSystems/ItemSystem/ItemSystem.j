
library ItemSystem requires Base, TimerUtils, AbilityUtils

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

        /*
        在此之前，我需要你先了解到我的地图内的物品系统，物品对象是由多个魔兽的item对象集合而成的，分别为可拾取时，单位身上时，出售时，禁用时(捡起别人的物品就会禁用)，因此这里使用ItemIndex也就是物品索引来表达一个物品对象。

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
        endglobals
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

        接下来是关于物品定义，也就是注册，注意这里卷轴=配方=Recipe。
        // 以太之镜卷轴
        set Recipe_AetherLens = RegisterItem('I0V3', 'I0V4', 'n12W', 'I0V5')
        // 以太之镜
        set Item_AetherLens   = RegisterItem('I0UE', 'I0UF',     0, 'I0UG')
        call RegisterItemMethodSimple(Item_AetherLens, "ItemAetherLensOnPickup", "ItemAetherLensOnDrop")

        
        现在你了解了我的物品系统，接下来来看我的合成系统，我需要你帮我优化合成系统的一些变量名，使其更清晰易懂。
        注意：我使用的是vjass，对于多维数组的使用是会有限制的，不要试图改变我的实现，而是给我提供更合适的命名。

        // 合成材料的物品索引 1~5个，即最多5个合成材料。
        integer array CombineIndex1
        integer array CombineIndex2
        integer array CombineIndex3
        integer array CombineIndex4
        integer array CombineIndex5

        // 合成对象物品索引(即上面的合成材料满足条件后就会被合成为这一个物品)
        integer array CombinedIndex

        // 可合成装备最大数量
        integer CombineMaxIndex = 0

        // 这是物品合成的注册
        set CombineMaxIndex = CombineMaxIndex + 1
        set CombineIndex1[CombineMaxIndex] = X6V
        set CombineIndex2[CombineMaxIndex] = I6V
        set CombinedIndex[CombineMaxIndex] = it_fj 
        
        set CombineMaxIndex = CombineMaxIndex + 1
        set CombineIndex1[CombineMaxIndex] = X2V
        set CombineIndex2[CombineMaxIndex] = OWV
        set CombineIndex3[CombineMaxIndex] = Recipe_AetherLens
        set CombinedIndex[CombineMaxIndex] = Item_AetherLens

        我认为关于合成系统的变量名不合适，有没有更合理的命名
        */
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

    // RemoveItemNoTrig
    function SilentRemoveItem takes item whichItem returns nothing
        local boolean isEnabled = IsTriggerEnabled(UnitManipulatItemTrig)
        // 可能没删掉
        call DisableTrigger(UnitManipulatItemTrig)
        if GetWidgetLife(whichItem) <= 0.405 then
            call SetWidgetLife(whichItem, 1.)
            call BJDebugMsg("删不掉啊 怎么回事呢 怎么回事呢")
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
        private boolean EnableManipulateMethod = true
    endglobals

    // 允许触发操作物品方法
    function ItemSystem_EnableItemManipulateMethod takes boolean enable returns nothing
        set EnableManipulateMethod = enable
    endfunction

    function ItemSystem_IsManipulateMethodEnabled takes nothing returns boolean
        return EnableManipulateMethod
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
    endglobals

    /*
    call TriggerRegisterAnyUnitEvent(UnitManipulatItemTrig, EVENT_PLAYER_UNIT_PICKUP_ITEM)
	call TriggerRegisterAnyUnitEvent(UnitManipulatItemTrig, EVENT_PLAYER_UNIT_DROP_ITEM)
	call TriggerRegisterAnyUnitEvent(UnitManipulatItemTrig, EVENT_PLAYER_UNIT_PAWN_ITEM)
    */

    // 合成物品时移除物品不走地图内的操作物品事件，因此自己写一个
    function ItemSystem_Init takes nothing returns nothing
        set PuckupItemTrig = CreateTrigger()
        set DropItemTrig = CreateTrigger()

        call TriggerAddCondition(PuckupItemTrig, Condition(function OnPuckupItem))
        call TriggerAddCondition(DropItemTrig, Condition(function OnDropItem))
        call TriggerRegisterAnyUnitEvent(PuckupItemTrig, EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerRegisterAnyUnitEvent(DropItemTrig, EVENT_PLAYER_UNIT_DROP_ITEM)
    endfunction
    
endlibrary
