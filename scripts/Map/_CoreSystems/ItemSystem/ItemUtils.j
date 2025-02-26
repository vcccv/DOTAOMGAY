
library ItemUtils
    
    // unit

    // 使物品没有碰撞
    function SetItemCollisionType takes item whichItem, boolean flag returns nothing
        // call MHItem_SetCollisionType()
    endfunction

    // 获取物品在物品栏的格数（指定物品类型）
    // Translates 0-based slot indices to 1-based slot indices.
    function GetInventoryIndexOfItemType takes unit whichUnit, integer itemId returns integer
        local integer index
        local item indexItem

        set index = 0
        loop
            set indexItem = UnitItemInSlot(whichUnit, index)
            if(indexItem != null) and(GetItemTypeId(indexItem) == itemId) then
                return index + 1
            endif

            set index = index + 1
            exitwhen index >= 5
        endloop

        set indexItem = null
        return 0
    endfunction

    // 获取英雄携带的物品（指定物品类型）
    function GetItemOfTypeFromUnit takes unit whichUnit, integer itemId returns item
        local integer index
        local item    indexItem
        set index = 0
        loop
            set indexItem = UnitItemInSlot(whichUnit, index)
            if indexItem != null and GetItemTypeId(indexItem) == itemId then
                set indexItem = null
                return UnitItemInSlot(whichUnit, index)
            endif
            set index = index + 1
            exitwhen index > bj_MAX_INVENTORY
        endloop
        set indexItem = null
        return null
    endfunction

    // 查询英雄是否已有物品（指定物品类型）
    function UnitHasItemOfType takes unit whichUnit, integer itemId returns boolean
        return GetInventoryIndexOfItemType(whichUnit, itemId) > 0
    endfunction

    function GetItemGoldCostById takes integer itemId returns integer
        return MHItem_GetDefDataInt(itemId, ITEM_DEF_DATA_GOLD_COST)
    endfunction

    // 获取单位身上所有物品价值总和
    function GetUnitAllItemsGoldCost takes unit whichUnit returns integer
        local integer i = 0
        local integer cost = 0
        local item whichItem
        loop
            set whichItem = UnitItemInSlot(whichUnit, i)
            if whichItem != null then
                set cost = cost + GetItemGoldCostById(GetItemTypeId(whichItem))
            endif
            set i = i + 1
        exitwhen i > 5
        endloop
        set whichItem = null
        return cost
    endfunction

    // 获取单位身上指定id物品数量 对丢弃物品事件做了适配
    function GetUnitItemCountById takes unit whichUnit, integer id returns integer
        local integer i = 0
        local integer n = 0
        local integer c = UnitInventorySize(whichUnit)-1
        loop
            if GetItemTypeId(UnitItemInSlot(whichUnit, i)) == id then
                if GetTriggerEventId() == EVENT_PLAYER_UNIT_DROP_ITEM or GetTriggerEventId() == EVENT_PLAYER_UNIT_PAWN_ITEM then
                    if UnitItemInSlot(whichUnit, i) != GetManipulatedItem() then
                        set n = n + 1
                    endif
                else
                    set n = n + 1
                endif
            endif
            set i = i + 1
        exitwhen i > c
        endloop
        return n
    endfunction

endlibrary
