
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
            call UnitDisableAbility(whichUnit, SECOND_CHAKRAM_ABILITY_ID, false, false)
            call UnitHideAbility(whichUnit, SECOND_CHAKRAM_ABILITY_ID, false)
        endif

        set whichUnit = null
    endfunction
    function ChakramOnLostScepterUpgrade takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()

        call UnitDisableAbility(whichUnit, SECOND_CHAKRAM_ABILITY_ID, true, false)
        call UnitHideAbility(whichUnit, SECOND_CHAKRAM_ABILITY_ID, true)

        set whichUnit = null
    endfunction
    
endscope
