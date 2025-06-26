
scope UrnOfShadows

    // 50 * 8 = 400
    function UrnOfShadowsBuffOnAdd takes nothing returns nothing
        local unit       whichUnit    = Event.GetTriggerUnit()
        call UnitAddLifeRegen(whichUnit,   50.)
        set whichUnit    = null
    endfunction

    function UrnOfShadowsBuffOnRemove takes nothing returns nothing
        local unit       whichUnit    = Event.GetTriggerUnit()
        call UnitAddLifeRegen(whichUnit, - 50.)
        set whichUnit    = null
    endfunction

endscope
