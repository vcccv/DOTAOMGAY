
scope Rax

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
    

endscope
