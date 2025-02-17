
scope Enchantress

    //***************************************************************************
    //*
    //*  推进
    //*
    //***************************************************************************
    function ImpetusOnGetScepterUpgrade takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()

        call UnitAddAttackRangeBonus(whichUnit, 190.)

        set whichUnit = null
    endfunction
    function ImpetusOnLostScepterUpgrade takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()

        call UnitReduceAttackRangeBonus(whichUnit, 190.)

        set whichUnit = null
    endfunction

endscope
