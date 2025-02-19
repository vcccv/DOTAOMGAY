
scope OgreMagi

    //***************************************************************************
    //*
    //*  多重施法
    //*
    //***************************************************************************
    #define UNREFINED_FIREBLAST_ABILITY_ID 'A2KQ'

    function MultiCastOnGetScepterUpgrade takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()

        if not UnitAddPermanentAbility(whichUnit, UNREFINED_FIREBLAST_ABILITY_ID) then
            call UnitDisableAbility(whichUnit, UNREFINED_FIREBLAST_ABILITY_ID, false, true)
        endif

        set whichUnit = null
    endfunction
    function MultiCastOnLostScepterUpgrade takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()

        call UnitDisableAbility(whichUnit, UNREFINED_FIREBLAST_ABILITY_ID, true, true)

        set whichUnit = null
    endfunction

endscope
