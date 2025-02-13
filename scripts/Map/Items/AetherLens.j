
scope AetherLens

    #define AETHER_LENS_CAST_RANGE_BONUS 150.
    globals
        private key KEY
    endglobals

    function AetherLensOnPick takes unit whichUnit returns nothing
        local player p = GetOwningPlayer(whichUnit)
        if not LoadBoolean(HY, GetHandleId(p),'A3O3') then
            call SaveBoolean(HY, GetHandleId(p),'A3O3', true)
            call MHUnit_AddSpellRange(whichUnit, GetUnitCastRangeBonus(whichUnit) + AETHER_LENS_CAST_RANGE_BONUS)	
            //call BJDebugMsg("我说我加了施法射程你耳聋吗？现在是：" + R2S(GetUnitCastRangeBonus(whichUnit)))
        endif
    endfunction
    function AetherLensOnDrop takes unit whichUnit returns nothing
        local player p = GetOwningPlayer(whichUnit)
        if LoadBoolean(HY, GetHandleId(p),'A3O3') then
            call RemoveSavedBoolean(HY, GetHandleId(p),'A3O3')
            call MHUnit_AddSpellRange(whichUnit, GetUnitCastRangeBonus(whichUnit) - AETHER_LENS_CAST_RANGE_BONUS)
            //call BJDebugMsg("一点施法射程不要也罢，现在是：" + R2S(GetUnitCastRangeBonus(whichUnit)))
        endif
    endfunction

    function ItemAetherLensOnPickup takes nothing returns nothing
        local unit       whichUnit = Event.GetTriggerUnit()
        local item       whichItem = Event.GetManipulatedItem()
        local integer    count     = Table[GetHandleId(whichUnit)].integer[KEY]

        set Table[GetHandleId(whichUnit)].integer[KEY] = count + 1
        if count == 1 then
            call MHUnit_AddSpellRange(whichUnit, GetUnitCastRangeBonus(whichUnit) + AETHER_LENS_CAST_RANGE_BONUS)	
        endif
        call UnitAddSpellDamageAmplificationBonus(whichUnit, 0.05)

        set whichUnit = null
        set whichItem = null
    endfunction

    function ItemAetherLensOnDrop takes nothing returns nothing
        local unit       whichUnit = Event.GetTriggerUnit()
        local item       whichItem = Event.GetManipulatedItem()
        local integer    count     = Table[GetHandleId(whichUnit)].integer[KEY]

        set Table[GetHandleId(whichUnit)].integer[KEY] = count - 1
        if count == 0 then
            call MHUnit_AddSpellRange(whichUnit, GetUnitCastRangeBonus(whichUnit) - AETHER_LENS_CAST_RANGE_BONUS)	
        endif
        call UnitReduceSpellDamageAmplificationBonus(whichUnit, 0.05)

        set whichUnit = null
        set whichItem = null
    endfunction

endscope
