
scope OgreMagi

    //***************************************************************************
    //*
    //*  多重施法
    //*
    //***************************************************************************
    #define UNREFINED_FIREBLAST_ABILITY_ID 'A2KQ'

    function MultiCastOnGetScepterUpgrade takes nothing returns nothing
        local unit       whichUnit = Event.GetTriggerUnit()

        call BJDebugMsg("MultiCastOnGetScepterUpgrade")
        if not UnitAddPermanentAbility(whichUnit, UNREFINED_FIREBLAST_ABILITY_ID) then
            call UnitDisableAbility(whichUnit, UNREFINED_FIREBLAST_ABILITY_ID, false, false)
            call UnitHideAbility(whichUnit, UNREFINED_FIREBLAST_ABILITY_ID, false)
            call BJDebugMsg(I2S(MHAbility_GetDisableCount(whichUnit, UNREFINED_FIREBLAST_ABILITY_ID)) + " 禁用计数器")
        endif

        set whichUnit = null
    endfunction
    function MultiCastOnLostScepterUpgrade takes nothing returns nothing
        local unit       whichUnit = Event.GetTriggerUnit()

        call UnitDisableAbility(whichUnit, UNREFINED_FIREBLAST_ABILITY_ID, true, false)
        call UnitHideAbility(whichUnit, UNREFINED_FIREBLAST_ABILITY_ID, true)
        call BJDebugMsg(I2S(MHAbility_GetDisableCount(whichUnit, UNREFINED_FIREBLAST_ABILITY_ID)) + " 禁用计数器")

        set whichUnit = null
    endfunction

endscope
