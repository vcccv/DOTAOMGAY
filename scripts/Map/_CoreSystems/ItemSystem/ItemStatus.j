
library ItemStatus requires ItemSystem

    //***************************************************************************
    //*
    //*  Item Status
    //*
    //***************************************************************************

    function IsItemAghanimScepter takes item it returns boolean
        local integer id = GetItemTypeId(it)
        if id == ItemRealId[Item_AghanimScepter] /*
        */ or id == ItemRealId[Item_AghanimScepterBasic] /*
        */ or id == ItemRealId[Item_AghanimScepterGiftable] then
            return true
        endif
        return false
    endfunction
    
    // 是消耗物品 perishable
    function IsItemPerishableByIndex takes integer itemIndex returns boolean
        return itemIndex == Item_FlyingCourier              /*
        */  or itemIndex == Item_Cheese                     /*
        */  or itemIndex == Item_DustOfAppearance           /*
        */  or itemIndex == Item_ClarityPotion              /*
        */  or itemIndex == Item_HealingSalve               /*
        */  or itemIndex == Item_AncientTangoOfEssifation   /*
        */  or itemIndex == Item_ObserverWard               /*
        */  or itemIndex == Item_SentryWard                 /*
        */  or itemIndex == Item_TownPortalScroll           /*
        */  or itemIndex == Item_GhostPotion                /*
        */  or itemIndex == Item_WandOfIllusions            /*
        */  or itemIndex == Item_SmokeOfDeceit
    endfunction

    // 可充能的永久性物品(非消耗品)? 但也包含了肉山盾 或许是不可堆叠消耗品
    function IsItemChargedByIndex takes integer itemIndex returns boolean
        return itemIndex == Item_UrnOfShadows               /*
        */  or itemIndex == Item_AncientJanggoOfEndurance   /*
        */  or itemIndex == Item_DiffusalBladeLevel1        /*
        */  or itemIndex == Item_DiffusalBladeLevel2        /*
        */  or itemIndex == Item_Bloodstone                 /*
        */  or itemIndex == Item_AegisOfTheImmortal         /*
        */  or itemIndex == Item_MagicStick                 /*
        */  or itemIndex == Item_MagicWand                  /*
        */  or itemIndex == Item_BladeOfTheReaper
    endfunction

    // 会死亡丢弃 DeathDrop
    function IsItemDeathDrop takes item whichItem returns boolean
        local integer itemIndex = GetItemIndexEx(whichItem)
        return itemIndex == Item_DivineRapier_Original          /*
        */  or itemIndex == Item_DivineRapier_Free              /*
        */  or itemIndex == Item_GemOfTrueSight                 /*
        */  or itemIndex == Item_GemOfTrueSight_CourierEdition
    endfunction

    // 获取消耗品默认使用次数
    function GetPerishableItemChargesByIndex takes integer itemIndex returns integer
        if Item_AncientTangoOfEssifation == itemIndex then
            return 4
        endif
        if Item_SentryWard == itemIndex              /*
            */ or itemIndex == Item_DustOfAppearance /*
            */ or itemIndex == Item_GhostPotion      /*
            */ or itemIndex == Item_WandOfIllusions then
            return 2
        endif
        return 1
    endfunction

    // 拾取事件中要删除的物品
    function H8X takes item whichItem returns boolean
        return GetItemType(whichItem) == ITEM_TYPE_POWERUP       /*
        */  or GetItemType(whichItem) == ITEM_TYPE_PURCHASABLE   /*
        */  or GetItemType(whichItem) == ITEM_TYPE_MISCELLANEOUS
    endfunction

    // 神符魔瓶物品
    function IsItemRuneMagicalBottleByIndex takes integer itemIndex returns boolean
        return itemIndex == Item_MagicalBottle_Illusion     /*
        */ or  itemIndex == Item_MagicalBottle_Haste        /*
        */ or  itemIndex == Item_MagicalBottle_DoubleDamage /*
        */ or  itemIndex == Item_MagicalBottle_Regeneration /*
        */ or  itemIndex == Item_MagicalBottle_Invisibility /*
        */ or  itemIndex == Item_MagicalBottle_Bounty
    endfunction

    function IsItemCourierEditionByIndex takes integer itemIndex returns boolean
        return itemIndex == Item_HelmOfTheDominator_CourierEdition          /*
        */  or itemIndex == Item_ArmletOfMordiggian_Activated_CourierEdition   /*
        */  or itemIndex == Item_ArmletOfMordiggian_Deactivated_CourierEdition /*
        */  or itemIndex == Item_ShivaGuard_CourierEdition                  /*
        */  or itemIndex == Item_HelmOfTheDominator                         /*
        */  or itemIndex == Item_ArmletOfMordiggian_Activated                  /*
        */  or itemIndex == Item_ArmletOfMordiggian_Deactivated                /*
        */  or itemIndex == Item_ShivaGuard                                 /*
        */  or itemIndex == Item_GemOfTrueSight                             /*
        */  or itemIndex == Item_GemOfTrueSight_CourierEdition              /*
        */  or itemIndex == Item_HandOfMidas                                /*
        */  or itemIndex == Item_HandOfMidas_CourierEdition
    endfunction
    function IsItemGemOfTrueSightByIndex takes integer itemIndex returns boolean
        return itemIndex == Item_GemOfTrueSight                 /*
        */  or itemIndex == Item_GemOfTrueSight_CourierEdition
    endfunction
    
endlibrary
