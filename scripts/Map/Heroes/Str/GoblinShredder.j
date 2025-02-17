
scope GoblinShredder

    //***************************************************************************
    //*
    //*  锯齿飞轮
    //*
    //***************************************************************************
    #define SECOND_CHAKRAM_ABILITY_ID 'A43Q'

    function ChakramOnGetScepterUpgrade takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()

        if not UnitAddPermanentAbility(whichUnit, SECOND_CHAKRAM_ABILITY_ID) then
            call UnitDisableAbility(whichUnit, SECOND_CHAKRAM_ABILITY_ID, false, true)
        endif

        set whichUnit = null
    endfunction
    function ChakramOnLostScepterUpgrade takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()

        call UnitDisableAbility(whichUnit, SECOND_CHAKRAM_ABILITY_ID, true, true)

        set whichUnit = null
    endfunction
    
endscope
