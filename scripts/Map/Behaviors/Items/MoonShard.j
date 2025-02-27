
scope MoonShard

    globals
        // consumed
        constant integer MOON_SHARD_CONSUMED_ABILITY_ID = 'A398'
        constant integer MOON_SHARD_CONSUMED_BUFF_ID    = 'B398'
    endglobals

    function Item_MoonShard_OnSpellEffect takes nothing returns nothing
        local unit    spellUnit  = GetTriggerUnit()
        local unit    targetUnit = GetSpellTargetUnit()
        local integer pid        = GetPlayerId(GetOwningPlayer(targetUnit))
        local integer goldCost

        set goldCost = GetItemGoldCostById(ItemRealId[Item_MoonShard])
        set PlayerExtraNetWorth[pid] = PlayerExtraNetWorth[pid] + goldCost
        set PlayerItemTotalGoldCostDirty[pid] = true
        set PlayerItemTotalGoldCostDirty[GetPlayerId(GetOwningPlayer(spellUnit))] = true
    
        call UnitAddPermanentAbility(targetUnit, MOON_SHARD_CONSUMED_ABILITY_ID)
        call DestroyEffect(AddSpecialEffectTarget("effects\\Eclipse.mdx", targetUnit, "origin"))
        
        set spellUnit = null
        set targetUnit = null
    endfunction

endscope
