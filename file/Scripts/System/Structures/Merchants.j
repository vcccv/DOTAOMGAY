
scope Merchants

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
        set ScourgeBlackMarket1 = CreateUnit(NEUTRAL_PASSIVE_PLAYER,'n12B', 5521, 6187, 180)
        set ScourgeBlackMarket2 = CreateUnit(NEUTRAL_PASSIVE_PLAYER,'n12B', 6500, 5600,-45)
        set ScourgePigKing      = CreateUnit(NEUTRAL_PASSIVE_PLAYER,'n999', 6250, 5600,-45)
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
        call CreateSentinelMerchants()
        call CreateScourgeMerchants()
    endfunction

endscope
