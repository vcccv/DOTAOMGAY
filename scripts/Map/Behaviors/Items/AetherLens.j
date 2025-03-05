
scope AetherLens

    #define AETHER_LENS_CAST_RANGE_BONUS 150.
    globals
        private key KEY
    endglobals

    function ItemAetherLensOnPickup takes nothing returns nothing
        local unit       whichUnit = Event.GetTriggerUnit()
        local item       whichItem = Event.GetManipulatedItem()
        local integer    count     = Table[GetHandleId(whichUnit)].integer[KEY] + 1

        set Table[GetHandleId(whichUnit)].integer[KEY] = count
        if count == 1 then
            call UnitAddCastRangeBonus(whichUnit, AETHER_LENS_CAST_RANGE_BONUS)
        endif
        call UnitAddSpellDamageAmplificationBonus(whichUnit, 0.05)

        set whichUnit = null
        set whichItem = null
    endfunction

    function ItemAetherLensOnDrop takes nothing returns nothing
        local unit       whichUnit = Event.GetTriggerUnit()
        local item       whichItem = Event.GetManipulatedItem()
        local integer    count     = Table[GetHandleId(whichUnit)].integer[KEY] - 1

        set Table[GetHandleId(whichUnit)].integer[KEY] = count
        if count == 0 then
            call UnitAddCastRangeBonus(whichUnit, - AETHER_LENS_CAST_RANGE_BONUS)
        endif
        call UnitSubSpellDamageAmplificationBonus(whichUnit, 0.05)

        set whichUnit = null
        set whichItem = null
    endfunction

endscope
