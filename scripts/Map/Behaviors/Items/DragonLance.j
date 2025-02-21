
scope DragonLance

    //***************************************************************************
    //*
    //*  魔龙之能
    //*
    //***************************************************************************
    globals
        private key DRAGON_REACH
    endglobals
    #define DRAGON_REACH_ATTACK_RANGE_BONUS 140.

    function DragonReachOnAdd takes nothing returns nothing
        local unit    whichUnit = Event.GetTriggerUnit()
        local integer count     
        if whichUnit == null then
            return
        endif

        set count = Table[GetHandleId(whichUnit)].integer[DRAGON_REACH] + 1
        set Table[GetHandleId(whichUnit)].integer[DRAGON_REACH] = count
        if count == 1 then
            call UnitAddAttackRangeRangedAttackerOnlyBonus(whichUnit, DRAGON_REACH_ATTACK_RANGE_BONUS)
        endif

        set whichUnit = null
    endfunction

    function DragonReachOnRemove takes nothing returns nothing
        local unit    whichUnit = Event.GetTriggerUnit()
        local integer count     
        if whichUnit == null then
            return
        endif

        set count = Table[GetHandleId(whichUnit)].integer[DRAGON_REACH] - 1
        set Table[GetHandleId(whichUnit)].integer[DRAGON_REACH] = count
        if count == 0 then
            call UnitSubAttackRangeRangedAttackerOnlyBonus(whichUnit, DRAGON_REACH_ATTACK_RANGE_BONUS)
        endif

        set whichUnit = null
    endfunction

endscope
