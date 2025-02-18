
library ItemUtils
    
    function GetItemGoldCostById takes integer itemId returns integer
        return MHItem_GetDefDataInt(itemId, ITEM_DEF_DATA_GOLD_COST)
    endfunction

endlibrary
