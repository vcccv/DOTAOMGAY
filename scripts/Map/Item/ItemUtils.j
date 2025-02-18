
library ItemUtils
    
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

endlibrary
