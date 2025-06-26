
scope RuneRegeneration

    function RuneRegenerationBuffOnAdd takes nothing returns nothing
        local unit       whichUnit    = Event.GetTriggerUnit()
        call UnitAddLifeRegen(whichUnit,   100.    )
        call UnitAddManaRegen(whichUnit,   66.66666)
        
        set whichUnit    = null
    endfunction

    function RuneRegenerationBuffOnRemove takes nothing returns nothing
        local unit       whichUnit    = Event.GetTriggerUnit()
        call UnitAddLifeRegen(whichUnit, - 100.    )
        call UnitAddManaRegen(whichUnit, - 66.66666)
        set whichUnit    = null
    endfunction

endscope
