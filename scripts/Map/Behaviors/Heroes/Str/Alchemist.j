
scope Alchemist

    globals
        constant integer HERO_INDEX_ALCHEMIST = 39
    endglobals
    //***************************************************************************
    //*
    //*  神杖合成
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_GOBLIN_GREED = GetHeroSKillIndexBySlot(HERO_INDEX_ALCHEMIST, 3)
    endglobals
    // 不包含地精贪婪版本
    private function IsItemNormalAghanimScepter takes item it returns boolean
        local integer id = GetItemTypeId(it)
        if id == ItemRealId[Item_AghanimScepter] /*
        */ or id == ItemRealId[Item_AghanimScepterBasic] then
            return true
        endif
        return false
    endfunction

    function AghanimScepterSynthOnSpellEffect takes nothing returns nothing
        local unit    targetUnit = GetSpellTargetUnit()
        local unit    whichUnit  = GetTriggerUnit()
        local integer i
        local player  targetPlayer
        local integer pid
        local integer goldCost
        local item    it
        //set bj_playerIsCrippled[0] = false
        if IsUnitType(targetUnit, UNIT_TYPE_HERO) and not IsHeroDummy(targetUnit) and not IsUnitAghanimGifted(targetUnit) then

            set targetPlayer = GetOwningPlayer(targetUnit)
            set pid = GetPlayerId(targetPlayer)
            if targetUnit != whichUnit then
                set i = 0
                loop
                exitwhen i > 5
                    // 
                    set it = UnitItemInSlot(targetUnit, i)
                    if IsItemNormalAghanimScepter(it) then
                        set goldCost = GetItemGoldCostById(GetItemTypeId(it))
                        set PlayerExtraNetWorth[pid] = PlayerExtraNetWorth[pid] + goldCost
                        call RemoveItem(it)
                        call DisplayTimedTextToPlayer(targetPlayer, 0, 0, 5, /*
                        */ GetPlayerName(GetOwningPlayer(whichUnit)) + "给予了你阿哈利姆福佑，现在销毁神杖并退还|cfffffa00" + I2S(goldCost)+ "|r 金钱。")
		                //call SetPlayerState(targetPlayer, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(targetPlayer, PLAYER_STATE_RESOURCE_GOLD) + goldCost)
                        
                        call PlayerAddUnitUnreliableGold(targetPlayer, targetUnit, goldCost)
                    endif
                    set i = i + 1
                endloop
                set it = null
                if IsUnitAghanimBlessed(targetUnit) then
                    // 仅退款
                    set goldCost = GetItemGoldCostById(ItemRealId[Item_AghanimBlessing])
                    set PlayerExtraNetWorth[pid] = PlayerExtraNetWorth[pid] + goldCost
                    call DisplayTimedTextToPlayer(targetPlayer, 0, 0, 5, /*
                    */ GetPlayerName(GetOwningPlayer(whichUnit)) + "给予了你阿哈利姆福佑，现在退还之前升级消耗的|cfffffa00" + I2S(goldCost)+ "|r 金钱。")
                    
                    call PlayerAddUnitUnreliableGold(targetPlayer, targetUnit, goldCost)
                endif
            endif

            call UnitAddAghanimGiftable(targetUnit)

            call SilentRemoveItem(GetAbilitySourceItem(GetSpellAbility()))
            // if GetOwningPlayer(targetUnit) != GetOwningPlayer(whichUnit) then
            //     set PlayerExtraNetWorth[GetPlayerId(GetOwningPlayer(whichUnit))] = PlayerExtraNetWorth[GetPlayerId(GetOwningPlayer(whichUnit))] + GetItemGoldCostById(ItemRealId[Item_AghanimScepterBasic])
            // endif
            // PlayerExtraNetWorth = 净资产

            set PlayerItemTotalGoldCostDirty[pid] = true
            set PlayerItemTotalGoldCostDirty[GetPlayerId(GetOwningPlayer(whichUnit))] = true


            //set bj_playerIsCrippled[0] = true
        endif
        set whichUnit  = null
        set targetUnit = null
    endfunction

endscope
