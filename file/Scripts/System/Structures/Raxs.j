
scope Raxs

    //***************************************************************************
    //*
    //*  SentinelRaxs
    //*
    //***************************************************************************
    function SentinelTopRangedRaxDeathAction takes nothing returns nothing
        set IsSentinelTopRangedRaxAlive = false
        call DisableTrigger(SentinelTopRangedRaxDeathTrig)
        call StoreDrCacheData("Rax" + I2S(0)+ I2S(0)+ I2S(1), GetPlayerId(GetOwningPlayer(GetKillingUnit())))
        call RaxDeathGoldBouns(GetKillingUnit(), true)
    endfunction
    function SentinelMidRangedRaxDeathAction takes nothing returns nothing
        set IsSentinelMidRangedRaxAlive = false
        call DisableTrigger(SentinelMidRangedRaxDeathTrig)
        call StoreDrCacheData("Rax" + I2S(0)+ I2S(1)+ I2S(1), GetPlayerId(GetOwningPlayer(GetKillingUnit())))
        call RaxDeathGoldBouns(GetKillingUnit(), true)
    endfunction
    function SentinelBotRangedRaxDeathAction takes nothing returns nothing
        set IsSentinelBotRangedRaxAlive = false
        call DisableTrigger(SentinelBotRangedRaxDeathTrig)
        call StoreDrCacheData("Rax" + I2S(0)+ I2S(2)+ I2S(1), GetPlayerId(GetOwningPlayer(GetKillingUnit())))
        call RaxDeathGoldBouns(GetKillingUnit(), true)
    endfunction
    function SentinelTopMeleeRaxDeathAction takes nothing returns nothing
        set IsSentinelTopMeleeRaxAlive = false
        call DisableTrigger(SentinelTopMeleeRaxDeathTrig)
        call StoreDrCacheData("Rax" + I2S(0)+ I2S(0)+ I2S(0), GetPlayerId(GetOwningPlayer(GetKillingUnit())))
        call RaxDeathGoldBouns(GetKillingUnit(), false)
    endfunction
    function SentinelMidMeleeRaxDeathAction takes nothing returns nothing
        set IsSentinelMidMeleeRaxAlive = false
        call DisableTrigger(SentinelMidMeleeRaxDeathTrig)
        call StoreDrCacheData("Rax" + I2S(0)+ I2S(1)+ I2S(0), GetPlayerId(GetOwningPlayer(GetKillingUnit())))
        call RaxDeathGoldBouns(GetKillingUnit(), false)
    endfunction
    function SentinelBotMeleeRaxDeathAction takes nothing returns nothing
        set IsSentinelBotMeleeRaxAlive = false
        call DisableTrigger(SentinelBotMeleeRaxDeathTrig)
        call StoreDrCacheData("Rax" + I2S(0)+ I2S(2)+ I2S(0), GetPlayerId(GetOwningPlayer(GetKillingUnit())))
        call RaxDeathGoldBouns(GetKillingUnit(), false)
    endfunction

    function CreateSentinelRaxsUnits takes nothing returns nothing
        globals
            unit SentinelTopMeleeRaxUnit
            unit SentinelMidMeleeRaxUnit
            unit SentinelBotMeleeRaxUnit
            unit SentinelTopRangedRaxUnit
            unit SentinelMidRangedRaxUnit
            unit SentinelBotRangedRaxUnit
        endglobals
        set SentinelTopMeleeRaxUnit  = CreateUnit(SentinelPlayers[0], 'eaom', -6080, -4480, 90)
        set SentinelMidMeleeRaxUnit  = CreateUnit(SentinelPlayers[0], 'eaom', -4416, -5312, 45)
        set SentinelBotMeleeRaxUnit  = CreateUnit(SentinelPlayers[0], 'eaom', -4032, -7040, 0 ) 
        set SentinelTopRangedRaxUnit = CreateUnit(SentinelPlayers[0], 'eaoe', -6656, -4480, 90)
        set SentinelMidRangedRaxUnit = CreateUnit(SentinelPlayers[0], 'eaoe', -4864, -4992, 45)
        set SentinelBotRangedRaxUnit = CreateUnit(SentinelPlayers[0], 'eaoe', -4032, -6528, 0 ) 
        
        globals
            trigger SentinelTopRangedRaxDeathTrig = null
            trigger SentinelMidRangedRaxDeathTrig = null
            trigger SentinelBotRangedRaxDeathTrig = null
            trigger SentinelTopMeleeRaxDeathTrig = null
            trigger SentinelMidMeleeRaxDeathTrig = null
            trigger SentinelBotMeleeRaxDeathTrig = null
        endglobals
        set SentinelTopRangedRaxDeathTrig = CreateTrigger()
        call TriggerRegisterUnitEvent(SentinelTopRangedRaxDeathTrig, SentinelTopRangedRaxUnit, EVENT_UNIT_DEATH)
        call TriggerAddAction(SentinelTopRangedRaxDeathTrig, function SentinelTopRangedRaxDeathAction)
        set SentinelMidRangedRaxDeathTrig = CreateTrigger()
        call TriggerRegisterUnitEvent(SentinelMidRangedRaxDeathTrig, SentinelMidRangedRaxUnit, EVENT_UNIT_DEATH)
        call TriggerAddAction(SentinelMidRangedRaxDeathTrig, function SentinelMidRangedRaxDeathAction)
        set SentinelBotRangedRaxDeathTrig = CreateTrigger()
        call TriggerRegisterUnitEvent(SentinelBotRangedRaxDeathTrig, SentinelBotRangedRaxUnit, EVENT_UNIT_DEATH)
        call TriggerAddAction(SentinelBotRangedRaxDeathTrig, function SentinelBotRangedRaxDeathAction)
        set SentinelTopMeleeRaxDeathTrig = CreateTrigger()
        call TriggerRegisterUnitEvent(SentinelTopMeleeRaxDeathTrig, SentinelTopMeleeRaxUnit, EVENT_UNIT_DEATH)
        call TriggerAddAction(SentinelTopMeleeRaxDeathTrig, function SentinelTopMeleeRaxDeathAction)
        set SentinelMidMeleeRaxDeathTrig = CreateTrigger()
        call TriggerRegisterUnitEvent(SentinelMidMeleeRaxDeathTrig, SentinelMidMeleeRaxUnit, EVENT_UNIT_DEATH)
        call TriggerAddAction(SentinelMidMeleeRaxDeathTrig, function SentinelMidMeleeRaxDeathAction)
        set SentinelBotMeleeRaxDeathTrig = CreateTrigger()
        call TriggerRegisterUnitEvent(SentinelBotMeleeRaxDeathTrig, SentinelBotMeleeRaxUnit, EVENT_UNIT_DEATH)
        call TriggerAddAction(SentinelBotMeleeRaxDeathTrig, function SentinelBotMeleeRaxDeathAction)
    endfunction

    //***************************************************************************
    //*
    //*  ScourgeRaxs
    //*
    //***************************************************************************
    function ScourgeTopRangedRaxDeathAction takes nothing returns nothing
        set IsScourgeTopRangedRaxAlive = false
        call DisableTrigger(ScourgeTopRangedRaxDeathTrig)
        call StoreDrCacheData("Rax" + I2S(1)+ I2S(0)+ I2S(1), GetPlayerId(GetOwningPlayer(GetKillingUnit())))
        call RaxDeathGoldBouns(GetKillingUnit(), true)
    endfunction
    function ScourgeMidRangedRaxDeathAction takes nothing returns nothing
        set IsScourgeMidRangedRaxAlive = false
        call DisableTrigger(ScourgeMidRangedRaxDeathTrig)
        call StoreDrCacheData("Rax" + I2S(1)+ I2S(1)+ I2S(1), GetPlayerId(GetOwningPlayer(GetKillingUnit())))
        call RaxDeathGoldBouns(GetKillingUnit(), true)
    endfunction
    function ScourgeBotRangedRaxDeathAction takes nothing returns nothing
        set IsScourgeBotRangedRaxAlive = false
        call DisableTrigger(ScourgeBotRangedRaxDeathTrig)
        call StoreDrCacheData("Rax" + I2S(1)+ I2S(2)+ I2S(1), GetPlayerId(GetOwningPlayer(GetKillingUnit())))
        call RaxDeathGoldBouns(GetKillingUnit(), true)
    endfunction
    function ScourgeTopMeleeRaxDeathAction takes nothing returns nothing
        set IsScourgeTopMeleeRaxAlive = false
        call DisableTrigger(ScourgeTopMeleeRaxDeathTrig)
        call StoreDrCacheData("Rax" + I2S(1)+ I2S(0)+ I2S(0), GetPlayerId(GetOwningPlayer(GetKillingUnit())))
        call RaxDeathGoldBouns(GetKillingUnit(), false)
    endfunction
    function ScourgeMidMeleeRaxDeathAction takes nothing returns nothing
        set IsScourgeMidMeleeRaxAlive = false
        call DisableTrigger(ScourgeMidMeleeRaxDeathTrig)
        call StoreDrCacheData("Rax" + I2S(1)+ I2S(1)+ I2S(0), GetPlayerId(GetOwningPlayer(GetKillingUnit())))
        call RaxDeathGoldBouns(GetKillingUnit(), false)
    endfunction
    function ScourgeBotMeleeRaxDeathAction takes nothing returns nothing
        set IsScourgeBotMeleeRaxAlive = false
        call DisableTrigger(ScourgeBotMeleeRaxDeathTrig)
        call StoreDrCacheData("Rax" + I2S(1)+ I2S(2)+ I2S(0), GetPlayerId(GetOwningPlayer(GetKillingUnit())))
        call RaxDeathGoldBouns(GetKillingUnit(), false)
    endfunction
    function CreateScourgeRaxsUnit takes nothing returns nothing
        globals
            unit ScourgeTopMeleeRaxUnit
            unit ScourgeMidMeleeRaxUnit
            unit ScourgeBotMeleeRaxUnit
            unit ScourgeTopRangedRaxUnit
            unit ScourgeMidRangedRaxUnit
            unit ScourgeBotRangedRaxUnit
        endglobals
        // melee
        set ScourgeTopMeleeRaxUnit = CreateUnit(ScourgePlayers[0],'usep', 3392, 5504, 270)
        set ScourgeMidMeleeRaxUnit = CreateUnit(ScourgePlayers[0],'usep', 4352, 3584, 270)
        set ScourgeBotMeleeRaxUnit = CreateUnit(ScourgePlayers[0],'usep', 6656, 2880, 270)
        // ranged
        set ScourgeTopRangedRaxUnit = CreateUnit(ScourgePlayers[0],'utod', 3392, 6080, 270)
        set ScourgeMidRangedRaxUnit = CreateUnit(ScourgePlayers[0],'utod', 3904, 3904, 270)
        set ScourgeBotRangedRaxUnit = CreateUnit(ScourgePlayers[0],'utod', 6080, 2944, 270)   

        globals
            trigger ScourgeTopRangedRaxDeathTrig = null
            trigger ScourgeMidRangedRaxDeathTrig = null
            trigger ScourgeBotRangedRaxDeathTrig = null
            trigger ScourgeTopMeleeRaxDeathTrig = null
            trigger ScourgeMidMeleeRaxDeathTrig = null
            trigger ScourgeBotMeleeRaxDeathTrig = null
        endglobals
        set ScourgeTopRangedRaxDeathTrig = CreateTrigger()
        call TriggerRegisterUnitEvent(ScourgeTopRangedRaxDeathTrig, ScourgeTopRangedRaxUnit, EVENT_UNIT_DEATH)
        call TriggerAddAction(ScourgeTopRangedRaxDeathTrig, function ScourgeTopRangedRaxDeathAction)
        set ScourgeMidRangedRaxDeathTrig = CreateTrigger()
        call TriggerRegisterUnitEvent(ScourgeMidRangedRaxDeathTrig, ScourgeMidRangedRaxUnit, EVENT_UNIT_DEATH)
        call TriggerAddAction(ScourgeMidRangedRaxDeathTrig, function ScourgeMidRangedRaxDeathAction)
        set ScourgeBotRangedRaxDeathTrig = CreateTrigger()
        call TriggerRegisterUnitEvent(ScourgeBotRangedRaxDeathTrig, ScourgeBotRangedRaxUnit, EVENT_UNIT_DEATH)
        call TriggerAddAction(ScourgeBotRangedRaxDeathTrig, function ScourgeBotRangedRaxDeathAction)
        set ScourgeTopMeleeRaxDeathTrig = CreateTrigger()
        call TriggerRegisterUnitEvent(ScourgeTopMeleeRaxDeathTrig, ScourgeTopMeleeRaxUnit, EVENT_UNIT_DEATH)
        call TriggerAddAction(ScourgeTopMeleeRaxDeathTrig, function ScourgeTopMeleeRaxDeathAction)
        set ScourgeMidMeleeRaxDeathTrig = CreateTrigger()
        call TriggerRegisterUnitEvent(ScourgeMidMeleeRaxDeathTrig, ScourgeMidMeleeRaxUnit, EVENT_UNIT_DEATH)
        call TriggerAddAction(ScourgeMidMeleeRaxDeathTrig, function ScourgeMidMeleeRaxDeathAction)
        set ScourgeBotMeleeRaxDeathTrig = CreateTrigger()
        call TriggerRegisterUnitEvent(ScourgeBotMeleeRaxDeathTrig, ScourgeBotMeleeRaxUnit, EVENT_UNIT_DEATH)
        call TriggerAddAction(ScourgeBotMeleeRaxDeathTrig, function ScourgeBotMeleeRaxDeathAction)
    endfunction

    function Raxs_Init takes nothing returns nothing
        call CreateSentinelRaxsUnits()
        call CreateScourgeRaxsUnit()
    endfunction

endscope
