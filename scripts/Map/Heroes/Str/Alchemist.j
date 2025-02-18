
scope Alchemist

    globals
        constant integer HERO_INDEX_ALCHEMIST = 39
    endglobals
    //***************************************************************************
    //*
    //*  神杖合成
    //*
    //***************************************************************************
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
        local boolean needAdd = true
        local item    it
        //set bj_playerIsCrippled[0] = false
        if IsUnitType(targetUnit, UNIT_TYPE_HERO) and not IsHeroDummy(targetUnit) and GetUnitAbilityLevel(targetUnit, 'A3E7') == 0 then

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
                        set PlayersExtraNetWorth[pid] = PlayersExtraNetWorth[pid] + goldCost
                        call RemoveItem(it)
                        call DisplayTimedTextToPlayer(targetPlayer, 0, 0, 5, /*
                        */ GetPlayerName(GetOwningPlayer(whichUnit)) + "给予了你阿哈利姆福佑，现在销毁神杖并退还|cfffffa00" + I2S(goldCost)+ "|r 金钱。")
		                call SetPlayerState(targetPlayer, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(targetPlayer, PLAYER_STATE_RESOURCE_GOLD) + goldCost)
                    endif
                    set i = i + 1
                endloop
                set it = null
                if GetUnitAbilityLevel(targetUnit, 'A3E8') > 0 then
                    // 仅退款
                    set needAdd = false
                    set goldCost = GetItemGoldCostById(ItemRealId[Item_AghanimBlessing])
                    set PlayersExtraNetWorth[pid] = PlayersExtraNetWorth[pid] + goldCost
                    call DisplayTimedTextToPlayer(targetPlayer, 0, 0, 5, /*
                    */ GetPlayerName(GetOwningPlayer(whichUnit)) + "给予了你阿哈利姆福佑，现在退还之前升级消耗的|cfffffa00" + I2S(goldCost)+ "|r 金钱。")
                    call SetPlayerState(targetPlayer, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(targetPlayer, PLAYER_STATE_RESOURCE_GOLD) + goldCost)
                endif
            endif

            call SilentRemoveItem(GetAbilitySourceItem(GetSpellAbility()))
            // if GetOwningPlayer(targetUnit) != GetOwningPlayer(whichUnit) then
            //     set PlayersExtraNetWorth[GetPlayerId(GetOwningPlayer(whichUnit))] = PlayersExtraNetWorth[GetPlayerId(GetOwningPlayer(whichUnit))] + GetItemGoldCostById(ItemRealId[Item_AghanimScepterBasic])
            // endif
            // PlayersExtraNetWorth = 净资产

            set ItemTotalGoldCostDirty[pid] = true
            set ItemTotalGoldCostDirty[GetPlayerId(GetOwningPlayer(whichUnit))] = true

            if needAdd then
                call UnitRemoveAbility(targetUnit, 'A3E8')
                call UnitAddPermanentAbility(targetUnit, 'A3E7')
                call SetHeroStr(targetUnit, GetHeroStr(targetUnit, false) + 10, true)
                call SetHeroInt(targetUnit, GetHeroInt(targetUnit, false) + 10, true)
                call SetHeroAgi(targetUnit, GetHeroAgi(targetUnit, false) + 10, true)
                call UnitAddPermanentAbility(targetUnit, 'A3I2')
                call UnitAddPermanentAbility(targetUnit, 'A3I3')
                call UnitAddScepterUpgrade(targetUnit)
            endif
            //set bj_playerIsCrippled[0] = true
        endif
        set whichUnit  = null
        set targetUnit = null
    endfunction

endscope
