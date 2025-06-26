
scope Bottle

    // 50 * 8 = 400
    function BottleRegenBuffOnAdd takes nothing returns nothing
        local unit       whichUnit    = Event.GetTriggerUnit()
        
        call UnitAddLifeRegen(whichUnit, 36.66666)
        call UnitAddManaRegen(whichUnit, 23.33333)
        set whichUnit    = null
    endfunction

    function BottleRegenBuffOnRemove takes nothing returns nothing
        local unit       whichUnit    = Event.GetTriggerUnit()

        call UnitAddLifeRegen(whichUnit, - 36.66666)
        call UnitAddManaRegen(whichUnit, - 23.33333)
        set whichUnit    = null
    endfunction

    function ItemBottleRegenOnSpellEffect takes nothing returns nothing
        local unit whichUnit  = GetTriggerUnit()

        call UnitAddBuffByPolarity(whichUnit, whichUnit, 'B04A', 1, 3., true, BUFF_LEVEL1)

        set whichUnit = null
    endfunction

endscope
