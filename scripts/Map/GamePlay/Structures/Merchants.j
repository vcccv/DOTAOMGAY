
scope Merchants

    function IsMerchantUnit takes unit u returns boolean
        local integer i = GetUnitTypeId(u)
        return i =='hC95' or i =='n12B' or i =='n01K' or i =='nC38' or i =='n00V' or i =='n00W' or i =='n002' or i =='n00X' or i =='n009' or i =='n0HE' or i =='nC35' or i =='u00Q' or i =='uC74' or i =='u010' or i =='u00Z'or i =='n999'
    endfunction
    function SelectedMerchantsUnitAction takes nothing returns boolean
        local unit    u  = GetTriggerUnit()
        local integer id = GetUnitTypeId(u)
        local boolean b  = GetOwningPlayer(u) == Player(15) and IsMerchantUnit(u) and LocalPlayer == GetTriggerPlayer()
        local string  s  = ""
        if GetTriggerEventId() == EVENT_PLAYER_UNIT_DESELECTED then
            if b then
                call ResetUnitAnimation(u)
            endif
        else
            //if Mode__AntiHack then
                //call CheckFogClicks(u)
            //endif
            if b then
                if id =='hC95' or id =='n12B' or id =='n00X' or id =='n009' or id =='nC35' or id =='u00Q' or id =='u010' or id =='u00Z' then
                    set s = "stand work"
                elseif id =='n01K' then
                    set s = "stand third"
                elseif id =='nC38' then
                    call SetUnitAnimationByIndex(u, 3)
                elseif id =='n00V' then
                    set s = "spell attack"
                elseif id =='n00W' then
                    set s = "spell"
                elseif id =='n002' then
                    call SetUnitAnimationByIndex(u, 3)
                elseif id =='n0HE' then
                    set s = "stand victory"
                elseif id =='uC74' then
                    set s = "stand work gold"
                elseif id =='n999' then
                    set s = "spell attack"
                endif
                if s != "" then
                    call SetUnitAnimation(u, s)
                    call QueueUnitAnimation(u, s)
                endif
            endif
        endif
        set u = null
        return false
    endfunction

    //***************************************************************************
    //*
    //*  SentinelMerchants
    //*
    //***************************************************************************
    function CreateSentinelMerchants takes nothing returns nothing
        globals
            unit SentinelPigKing              = null
            unit SentinelBlackMarket1         = null
            unit SentinelBlackMarket2         = null
            unit SentinelCacheOfTheQuelThelan = null
            unit SentinelWeaponsDealer        = null
            unit SentinelGrylaTheAccessorizer = null
            unit SentinelAncientOfWonders     = null
            unit SentinelArcaneSanctum        = null
            unit SentinelAncientWeaponry      = null
            unit SentinelSupportiveVestments  = null
            unit SentinelEnchantedArtifacts   = null
            unit SentinelGatewayRelics        = null
            unit SentinelProtectorate         = null
        endglobals
        set SentinelBlackMarket1         = CreateUnit(NEUTRAL_PASSIVE_PLAYER, 'n12B', -6360, -6892, 45 )
        set SentinelBlackMarket2         = CreateUnit(NEUTRAL_PASSIVE_PLAYER, 'n12B', -6837, -5824, 90 )
        set SentinelPigKing 	         = CreateUnit(NEUTRAL_PASSIVE_PLAYER, 'n999', -6360, -7080, 90 )
        set SentinelCacheOfTheQuelThelan = CreateUnit(NEUTRAL_PASSIVE_PLAYER, 'hC95', -6880, -7136, 270)
        set SentinelWeaponsDealer        = CreateUnit(NEUTRAL_PASSIVE_PLAYER, 'n01K', -7264, -6688, 270)
        set SentinelGrylaTheAccessorizer = CreateUnit(NEUTRAL_PASSIVE_PLAYER, 'nC38', -7264, -6880, 270)
        set SentinelAncientOfWonders     = CreateUnit(NEUTRAL_PASSIVE_PLAYER, 'e025', -6624, -7136, 270)
        set SentinelArcaneSanctum 		 = CreateUnit(NEUTRAL_PASSIVE_PLAYER, 'n00V', -6876, -6368, 270)
        set SentinelAncientWeaponry      = CreateUnit(NEUTRAL_PASSIVE_PLAYER, 'n00W', -7264, -6432, 270)
        set SentinelSupportiveVestments  = CreateUnit(NEUTRAL_PASSIVE_PLAYER, 'n002', -6752, -6368, 270)
        set SentinelEnchantedArtifacts   = CreateUnit(NEUTRAL_PASSIVE_PLAYER, 'n00X', -7136, -6368, 270)
        set SentinelGatewayRelics 		 = CreateUnit(NEUTRAL_PASSIVE_PLAYER, 'n009', -6614, -6432, 270)
        set SentinelProtectorate 		 = CreateUnit(NEUTRAL_PASSIVE_PLAYER, 'n0HE', -7008, -6368, 270)
        
        call SetUnitColor(SentinelPigKing,              PLAYER_COLOR_LIGHT_GRAY)
        call SetUnitColor(SentinelCacheOfTheQuelThelan, PLAYER_COLOR_RED       )
        call SetUnitColor(SentinelAncientOfWonders,     PLAYER_COLOR_RED       )
        call SetUnitColor(SentinelGrylaTheAccessorizer, PLAYER_COLOR_BLACK     )
        call SetUnitColor(SentinelWeaponsDealer,        PLAYER_COLOR_BLACK     )
        call SetUnitColor(SentinelArcaneSanctum,        PLAYER_COLOR_BLACK     )
        call SetUnitColor(SentinelAncientWeaponry,      PLAYER_COLOR_BLACK     )
        call SetUnitColor(SentinelSupportiveVestments,  PLAYER_COLOR_BLACK     )
        call SetUnitColor(SentinelEnchantedArtifacts,   PLAYER_COLOR_BLACK     )
        call SetUnitColor(SentinelGatewayRelics,        PLAYER_COLOR_BLACK     )
    endfunction

    //***************************************************************************
    //*
    //*  ScourgeMerchants
    //*
    //***************************************************************************
    function CreateScourgeMerchants takes nothing returns nothing
        globals
            unit ScourgePigKing
            unit ScourgeBlackMarket1
            unit ScourgeBlackMarket2
            unit ScourgeDemonicArtifacts
            unit ScourgeWeaponsDealer
            unit ScourgeGrylaTheAccessorizer
            unit ScourgeTombOfRelics
            unit ScourgeArcaneSanctum
            unit ScourgeAncientWeaponry
            unit ScourgeSupportiveVestments
            unit ScourgeEnchantedArtifacts
            unit ScourgeGatewayRelics
            unit ScourgeProtectorate
        endglobals
        set ScourgeBlackMarket1         = CreateUnit(NEUTRAL_PASSIVE_PLAYER,'n12B', 5521, 6187, 180)
        set ScourgeBlackMarket2         = CreateUnit(NEUTRAL_PASSIVE_PLAYER,'n12B', 6500, 5600, -45)
        set ScourgePigKing              = CreateUnit(NEUTRAL_PASSIVE_PLAYER,'n999', 6250, 5600, -45)
        set ScourgeDemonicArtifacts     = CreateUnit(NEUTRAL_PASSIVE_PLAYER,'nC35', 6816, 5984, 270)
        set ScourgeWeaponsDealer        = CreateUnit(NEUTRAL_PASSIVE_PLAYER,'n01K', 6304, 6368, 270)
        set ScourgeGrylaTheAccessorizer = CreateUnit(NEUTRAL_PASSIVE_PLAYER,'nC38', 6496, 6368, 270)
        set ScourgeTombOfRelics         = CreateUnit(NEUTRAL_PASSIVE_PLAYER,'u00Q', 6760, 5664, 270)
        set ScourgeArcaneSanctum        = CreateUnit(NEUTRAL_PASSIVE_PLAYER,'n00V', 5920, 6176, 0  )
        set ScourgeAncientWeaponry      = CreateUnit(NEUTRAL_PASSIVE_PLAYER,'n00W', 6112, 6432, 0  )
        set ScourgeSupportiveVestments  = CreateUnit(NEUTRAL_PASSIVE_PLAYER,'n002', 5920, 6048, 0  )
        set ScourgeEnchantedArtifacts   = CreateUnit(NEUTRAL_PASSIVE_PLAYER,'n00X', 5984, 6432, 0  )
        set ScourgeGatewayRelics        = CreateUnit(NEUTRAL_PASSIVE_PLAYER,'n009', 5984, 5920, 0  )
        set ScourgeProtectorate         = CreateUnit(NEUTRAL_PASSIVE_PLAYER,'n0HE', 5920, 6304, 0  )
        call SetUnitColor(ScourgePigKing,              PLAYER_COLOR_LIGHT_GRAY)
        call SetUnitColor(ScourgeDemonicArtifacts,     PLAYER_COLOR_GREEN     )
        call SetUnitColor(ScourgeGrylaTheAccessorizer, PLAYER_COLOR_BLACK     )
        call SetUnitColor(ScourgeWeaponsDealer,        PLAYER_COLOR_BLACK     ) 
        call SetUnitColor(ScourgeArcaneSanctum,        PLAYER_COLOR_BLACK     )
        call SetUnitColor(ScourgeAncientWeaponry,      PLAYER_COLOR_BLACK     )
        call SetUnitColor(ScourgeSupportiveVestments,  PLAYER_COLOR_BLACK     )
        call SetUnitColor(ScourgeEnchantedArtifacts,   PLAYER_COLOR_BLACK     )
        call SetUnitColor(ScourgeGatewayRelics,        PLAYER_COLOR_BLACK     )
    endfunction

    function Merchants_Init takes nothing returns nothing
        local trigger t = null

        call CreateSentinelMerchants()
        call CreateScourgeMerchants()

        set t = CreateTrigger()
        call TriggerRegisterAnyUnitEvent(t, EVENT_PLAYER_UNIT_DESELECTED)
        call TriggerRegisterAnyUnitEvent(t, EVENT_PLAYER_UNIT_SELECTED  )
        call TriggerAddCondition(t, Condition(function SelectedMerchantsUnitAction))
    endfunction

endscope
