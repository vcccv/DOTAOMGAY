
scope Towers

    function IsLevel1TowerUnit takes unit tower returns boolean
        return GetUnitTypeId(tower)=='e00R' or GetUnitTypeId(tower)=='u00M'
    endfunction

    globals
        effect array TowerAttackRangeIndicatorEffect
        integer TowerAttackRangeIndicatorMaxNumber = 0
    endglobals
    
    function CreateTowerAttackRangeIndicator takes unit u returns nothing
        local effect eff = AddSpecialEffect("tower_range.mdx", GetUnitX(u), GetUnitY(u))
        set TowerAttackRangeIndicatorEffect[TowerAttackRangeIndicatorMaxNumber] = eff
        
        call SaveInteger(ExtraHT, GetHandleId(u), HTKEY_TOWER_ATTACK_RANGE_EFFECT, TowerAttackRangeIndicatorMaxNumber)
        call EXSetEffectSize(TowerAttackRangeIndicatorEffect[TowerAttackRangeIndicatorMaxNumber], 0.01)

        set TowerAttackRangeIndicatorMaxNumber = TowerAttackRangeIndicatorMaxNumber + 1
        set eff = null
    endfunction
    function DestroyTowerRangeIndicator takes unit tower returns nothing
        local integer indicatorIndex = LoadInteger(ExtraHT, GetHandleId(tower), HTKEY_TOWER_ATTACK_RANGE_EFFECT )
        call DestroyEffect(TowerAttackRangeIndicatorEffect[indicatorIndex])
        set TowerAttackRangeIndicatorEffect[indicatorIndex] = null
    endfunction

    function SetTowerRangeIndicatorState takes boolean b returns nothing
        local integer i = 0
        local real    size
        if b then
            set size = 1.
        else
            set size = 0.01
        endif
        loop
            if TowerAttackRangeIndicatorEffect[i] != null then
                call EXSetEffectSize(TowerAttackRangeIndicatorEffect[i], size)
            endif
            set i = i + 1
        exitwhen i > TowerAttackRangeIndicatorMaxNumber
        endloop
    endfunction

    globals
        integer array PlayerDenyTowerCount
        integer array PlayerLastHitTowerCount
    endglobals

    function TowerDeathDisplayText takes unit tower, unit killingUnit returns nothing
        local player p = GetOwningPlayer(killingUnit)
        local integer pid = GetPlayerId(p)
        if IsUnitAlly(tower, p) then
            set PlayerDenyTowerCount[pid]= PlayerDenyTowerCount[pid]+ 1
            call DisplayTimedTextToAllPlayer(AllPlayerForce, DisplayTextDuration[LocalPlayerId], PlayersColoerText[pid]+ PlayersName[pid]+ "|r " + GetObjectName('n04P')+ ".")
        else
            set PlayerLastHitTowerCount[pid]= PlayerLastHitTowerCount[pid]+ 1
            call DisplayTimedTextToAllPlayer(AllPlayerForce, DisplayTextDuration[LocalPlayerId], PlayersColoerText[pid]+ PlayersName[pid]+ "|r " + GetObjectName('n0EN')+ ".")
        endif
        if IsLevel1TowerUnit(tower) then
            if GetOwningPlayer(tower) == SentinelPlayers[0] then
                call DisplayTimedTextToAllPlayer(SentinelForce, DisplayTextDuration[LocalPlayerId], "我方的防御符文冷却时间已刷新")
            else
                call DisplayTimedTextToAllPlayer(ScourgeForce, DisplayTextDuration[LocalPlayerId], "我方的防御符文冷却时间已刷新")
            endif
        endif
    endfunction
    function TowerDeathGoldBonus takes unit whichUnit, integer level returns nothing
        local integer goldBonus
        set goldBonus = 120 + 40 * level
        call UnitAddAbility(GetDyingUnit(),'A3C9') // - 9999 视野
        if IsUnitAlly(GetDyingUnit(), GetOwningPlayer(whichUnit)) then
            set goldBonus = goldBonus / 2
        endif
        if GetOwningPlayer(GetDyingUnit()) == ScourgePlayers[0] then
            call AddReliableGoldToTeam(0, goldBonus)
        else
            call AddReliableGoldToTeam(1, goldBonus)
        endif
    endfunction

    //***************************************************************************
    //*
    //*  SentinelTowers
    //*
    //***************************************************************************
    function SentinelTowersDeathAction takes nothing returns nothing
        local unit    u           = GetDyingUnit()
        local unit    killingUnit = GetKillingUnit()
        local player  pk          = GetOwningPlayer(killingUnit)
        local integer pid         = GetPlayerId(pk)
        call TowerDeathDisplayText(u, killingUnit)
        call DestroyTowerRangeIndicator(u)
        if u == SentinleTopTowerLevel1 or u == SentinleMidTowerLevel1 or u == SentinleBotTowerLevel1 then
            call TowerDeathGoldBonus(killingUnit, 1)
            if IsUnitAlly(u, pk) == false then
                call ResetGlyphCooldownToTeam(0)
            endif
            if u == SentinleTopTowerLevel1 then
                call StoreDrCacheData("Tower010", pid)
                call UnitRemoveAbility(SentinleTopTowerLevel2,'Avul')
            elseif u == SentinleMidTowerLevel1 then
                call StoreDrCacheData("Tower011", pid)
                call UnitRemoveAbility(SentinleMidTowerLevel2,'Avul')
            else
                call StoreDrCacheData("Tower012", pid)
                call UnitRemoveAbility(SentinleBotTowerLevel2,'Avul')
            endif
        elseif u == SentinleTopTowerLevel2 or u == SentinleMidTowerLevel2 or u == SentinleBotTowerLevel2 then
            call TowerDeathGoldBonus(killingUnit, 2)
            if u == SentinleTopTowerLevel2 then
                call StoreDrCacheData("Tower020", pid)
                call UnitRemoveAbility(SentinleTopTowerLevel3,'Avul')
            elseif u == SentinleMidTowerLevel2 then
                call StoreDrCacheData("Tower021", pid)
                call UnitRemoveAbility(SentinleMidTowerLevel3,'Avul')
            else
                call StoreDrCacheData("Tower022", pid)
                call UnitRemoveAbility(SentinleBotTowerLevel3,'Avul')
            endif
        elseif u == SentinleTopTowerLevel3 or u == SentinleMidTowerLevel3 or u == SentinleBotTowerLevel3 then
            call TowerDeathGoldBonus(killingUnit, 3)
            call UnitRemoveAbility(SentinleLeftTowerLevel4,'Avul')
            call UnitRemoveAbility(SentinleRightTowerLevel4,'Avul')
            call UnitRemoveAbility(SentinelAncientOfWind1,'Avul')
            call UnitRemoveAbility(SentinelAncientOfWind2,'Avul')
            call UnitRemoveAbility(SentinelHuntersHall1,'Avul')
            call UnitRemoveAbility(SentinelHuntersHall2,'Avul')
            call UnitRemoveAbility(SentinelMoonWell1, 'Avul')
            call UnitRemoveAbility(SentinelMoonWell2, 'Avul')
            call UnitRemoveAbility(SentinelMoonWell3, 'Avul')
            call UnitRemoveAbility(SentinelMoonWell4, 'Avul')
            call UnitRemoveAbility(SentinelMoonWell5, 'Avul')
            call UnitRemoveAbility(SentinelMoonWell6, 'Avul')
            call UnitRemoveAbility(SentinelMoonWell7, 'Avul')
            call UnitRemoveAbility(SentinelMoonWell8, 'Avul')
            call UnitRemoveAbility(SentinelMoonWell9, 'Avul')
            call UnitRemoveAbility(SentinelMoonWell10,'Avul')
            call UnitRemoveAbility(SentinelMoonWell11,'Avul')
            if u == SentinleTopTowerLevel3 then
                call StoreDrCacheData("Tower030", pid)
                call UnitRemoveAbility(SentinelTopMeleeRaxUnit,'Avul')
                call UnitRemoveAbility(SentinelTopRangedRaxUnit,'Avul')
            elseif u == SentinleMidTowerLevel3 then
                call StoreDrCacheData("Tower031", pid)
                call UnitRemoveAbility(SentinelMidMeleeRaxUnit,'Avul')
                call UnitRemoveAbility(SentinelMidRangedRaxUnit,'Avul')
            else
                call StoreDrCacheData("Tower032", pid)
                call UnitRemoveAbility(SentinelBotMeleeRaxUnit,'Avul')
                call UnitRemoveAbility(SentinelBotRangedRaxUnit,'Avul')
            endif
        elseif u == SentinleLeftTowerLevel4 or u == SentinleRightTowerLevel4 then
            call StoreDrCacheData("Tower041", pid)
            call TowerDeathGoldBonus(killingUnit, 4)
            if (u == SentinleLeftTowerLevel4 and UnitIsDead(SentinleRightTowerLevel4)) or(u == SentinleRightTowerLevel4 and UnitIsDead(SentinleLeftTowerLevel4)) then
                call UnitRemoveAbility(WorldTree,'Avul')
            endif
        endif
        set u = null
        set killingUnit = null
    endfunction
    function SentinelTowersDeathCondition takes nothing returns boolean
        return(GetUnitTypeId(GetDyingUnit())=='e00R') /*
        */or(GetUnitTypeId(GetDyingUnit())=='e011') /*
        */or(GetUnitTypeId(GetDyingUnit())=='e00S') /*
        */or(GetUnitTypeId(GetDyingUnit())=='e019')
    endfunction
    function CreateSentinelTowers takes nothing returns nothing
        globals
            unit SentinleTopTowerLevel1   = null
            unit SentinleMidTowerLevel1   = null
            unit SentinleBotTowerLevel1   = null
            unit SentinleTopTowerLevel2   = null
            unit SentinleMidTowerLevel2   = null
            unit SentinleBotTowerLevel2   = null
            unit SentinleTopTowerLevel3   = null
            unit SentinleMidTowerLevel3   = null
            unit SentinleBotTowerLevel3   = null
            unit SentinleLeftTowerLevel4  = null
            unit SentinleRightTowerLevel4 = null
        endglobals
        // level 1
        set SentinleTopTowerLevel1 = CreateUnit(SentinelPlayers[0], 'e00R', -6112.,  1568., 90.)
        set SentinleMidTowerLevel1 = CreateUnit(SentinelPlayers[0], 'e00R', -1504., -1824., 45.)
        set SentinleBotTowerLevel1 = CreateUnit(SentinelPlayers[0], 'e00R',  4960., -6752., 0. )
        // level 2
        set SentinleTopTowerLevel2 = CreateUnit(SentinelPlayers[0], 'e011', -6112., -1184., 90.)
        set SentinleMidTowerLevel2 = CreateUnit(SentinelPlayers[0], 'e011', -3488., -3296., 45.)
        set SentinleBotTowerLevel2 = CreateUnit(SentinelPlayers[0], 'e011', -608. , -6688., 0. )
        // level 3
        set SentinleTopTowerLevel3 = CreateUnit(SentinelPlayers[0], 'e00S', -6368, -4256, 90)
        set SentinleMidTowerLevel3 = CreateUnit(SentinelPlayers[0], 'e00S', -4448, -4960, 45)
        set SentinleBotTowerLevel3 = CreateUnit(SentinelPlayers[0], 'e00S', -3744, -6816, 0 )
        // level 4
        set SentinleLeftTowerLevel4  = CreateUnit(SentinelPlayers[0], 'e019', -5536, -5664, 45)
        set SentinleRightTowerLevel4 = CreateUnit(SentinelPlayers[0], 'e019', -5216, -6048, 45)

        call CreateTowerAttackRangeIndicator(SentinleTopTowerLevel1)
        call CreateTowerAttackRangeIndicator(SentinleMidTowerLevel1)
        call CreateTowerAttackRangeIndicator(SentinleBotTowerLevel1)
        call CreateTowerAttackRangeIndicator(SentinleTopTowerLevel2)
        call CreateTowerAttackRangeIndicator(SentinleMidTowerLevel2)
        call CreateTowerAttackRangeIndicator(SentinleBotTowerLevel2)
        call CreateTowerAttackRangeIndicator(SentinleTopTowerLevel3)
        call CreateTowerAttackRangeIndicator(SentinleMidTowerLevel3)
        call CreateTowerAttackRangeIndicator(SentinleBotTowerLevel3)
        call CreateTowerAttackRangeIndicator(SentinleLeftTowerLevel4)
        call CreateTowerAttackRangeIndicator(SentinleRightTowerLevel4)
        
        
        globals
            trigger SentinelTowersDeathTrig = null
        endglobals
        set SentinelTowersDeathTrig = CreateTrigger()
        call TriggerRegisterPlayerUnitEventBJ(SentinelTowersDeathTrig, EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(SentinelTowersDeathTrig, Condition(function SentinelTowersDeathCondition))
        call TriggerAddAction(SentinelTowersDeathTrig, function SentinelTowersDeathAction)
    endfunction

    //***************************************************************************
    //*
    //*  ScourgeTowers
    //*
    //***************************************************************************
    function ScourgeTowersDeathAction takes nothing returns nothing
        local unit    u             = GetDyingUnit()
        local unit    killingUnit   = GetKillingUnit()
        local player  killingPlayer = GetOwningPlayer(killingUnit)
        local integer pid           = GetPlayerId(killingPlayer)
        call TowerDeathDisplayText(u, killingUnit)
        call DestroyTowerRangeIndicator(u)
        if u == ScourgeTopTowerLevel1 or u == ScourgeMidTowerLevel1 or u == ScourgeBotTowerLevel1 then
            call TowerDeathGoldBonus(killingUnit, 1)
            if not IsUnitAlly(u, killingPlayer) then
                call ResetGlyphCooldownToTeam(1)
            endif
            if u == ScourgeTopTowerLevel1 then
                call StoreDrCacheData("Tower110", pid)
                call UnitRemoveAbility(ScourgeTopTowerLevel2, 'Avul')
            elseif u == ScourgeMidTowerLevel1 then
                call StoreDrCacheData("Tower111", pid)
                call UnitRemoveAbility(ScourgeMidTowerLevel2, 'Avul')
            else
                call StoreDrCacheData("Tower112", pid)
                call UnitRemoveAbility(ScourgeBotTowerLevel2, 'Avul')
            endif
        elseif u == ScourgeTopTowerLevel2 or u == ScourgeMidTowerLevel2 or u == ScourgeBotTowerLevel2 then
            call TowerDeathGoldBonus(killingUnit, 2)
            if u == ScourgeTopTowerLevel2 then
                call StoreDrCacheData("Tower120", pid)
                call UnitRemoveAbility(ScourgeTopTowerLevel3, 'Avul')
            elseif u == ScourgeMidTowerLevel2 then
                call StoreDrCacheData("Tower121", pid)
                call UnitRemoveAbility(ScourgeMidTowerLevel3, 'Avul')
            else
                call StoreDrCacheData("Tower122", pid)
                call UnitRemoveAbility(ScourgeBotTowerLevel3, 'Avul')
            endif
        elseif u == ScourgeTopTowerLevel3 or u == ScourgeMidTowerLevel3 or u == ScourgeBotTowerLevel3 then
            call TowerDeathGoldBonus(killingUnit, 3)
            call UnitRemoveAbility(ScourgeLeftTowerLevel4 , 'Avul')
            call UnitRemoveAbility(ScourgeRightTowerLevel4, 'Avul')
            call UnitRemoveAbility(ScourgeSacrificialPit1 , 'Avul')
            call UnitRemoveAbility(ScourgeSacrificialPit2 , 'Avul')
            call UnitRemoveAbility(ScourgeBoneyard1,  'Avul')
            call UnitRemoveAbility(ScourgeBoneyard2,  'Avul')
            call UnitRemoveAbility(ScourgeZiggurat1,  'Avul')
            call UnitRemoveAbility(ScourgeZiggurat2,  'Avul')
            call UnitRemoveAbility(ScourgeZiggurat3,  'Avul')
            call UnitRemoveAbility(ScourgeZiggurat4,  'Avul')
            call UnitRemoveAbility(ScourgeZiggurat5,  'Avul')
            call UnitRemoveAbility(ScourgeZiggurat6,  'Avul')
            call UnitRemoveAbility(ScourgeZiggurat7,  'Avul')
            call UnitRemoveAbility(ScourgeZiggurat8,  'Avul')
            call UnitRemoveAbility(ScourgeZiggurat9,  'Avul')
            call UnitRemoveAbility(ScourgeZiggurat10, 'Avul')
            call UnitRemoveAbility(ScourgeZiggurat11, 'Avul')
            if u == ScourgeTopTowerLevel3 then
                call StoreDrCacheData("Tower130", pid)
                call UnitRemoveAbility(ScourgeTopMeleeRaxUnit,  'Avul')
                call UnitRemoveAbility(ScourgeTopRangedRaxUnit, 'Avul')
            elseif u == ScourgeMidTowerLevel3 then
                call StoreDrCacheData("Tower131", pid)
                call UnitRemoveAbility(ScourgeMidMeleeRaxUnit,  'Avul')
                call UnitRemoveAbility(ScourgeMidRangedRaxUnit, 'Avul')
            else
                call StoreDrCacheData("Tower132", pid)
                call UnitRemoveAbility(ScourgeBotMeleeRaxUnit,  'Avul')
                call UnitRemoveAbility(ScourgeBotRangedRaxUnit, 'Avul')
            endif
        elseif u == ScourgeLeftTowerLevel4 or u == ScourgeRightTowerLevel4 then
            call StoreDrCacheData("Tower141", pid)
            call TowerDeathGoldBonus(killingUnit, 4)
            if (u == ScourgeLeftTowerLevel4 and UnitIsDead(ScourgeRightTowerLevel4)) or(u == ScourgeRightTowerLevel4 and UnitIsDead(ScourgeLeftTowerLevel4)) then
                call UnitRemoveAbility(FrozenThrone, 'Avul')
            endif
        endif
        set u = null
        set killingUnit = null
    endfunction
    function ScourgeTowersDeathCondition takes nothing returns boolean
        return(GetUnitTypeId(GetDyingUnit())=='u00M')/*
        */ or(GetUnitTypeId(GetDyingUnit())=='u00D')/*
        */ or(GetUnitTypeId(GetDyingUnit())=='u00N')/*
        */ or(GetUnitTypeId(GetDyingUnit())=='u00T')
    endfunction

    function CreateScourgeTowers takes nothing returns nothing
        globals
            unit ScourgeTopTowerLevel1   = null
            unit ScourgeMidTowerLevel1   = null
            unit ScourgeBotTowerLevel1   = null
            unit ScourgeTopTowerLevel2   = null
            unit ScourgeMidTowerLevel2   = null
            unit ScourgeBotTowerLevel2   = null
            unit ScourgeTopTowerLevel3   = null
            unit ScourgeMidTowerLevel3   = null
            unit ScourgeBotTowerLevel3   = null
            unit ScourgeLeftTowerLevel4  = null
            unit ScourgeRightTowerLevel4 = null
        endglobals
        // level 1
        set ScourgeTopTowerLevel1 = CreateUnit(ScourgePlayers[0], 'u00M', -4704,  5920, 90)
        set ScourgeMidTowerLevel1 = CreateUnit(ScourgePlayers[0], 'u00M',  1056, -96  , 45)
        set ScourgeBotTowerLevel1 = CreateUnit(ScourgePlayers[0], 'u00M',  6048, -2080, 0.)
        // level 2
        set ScourgeTopTowerLevel2 = CreateUnit(ScourgePlayers[0], 'u00D',  -32, 5920, 90)
        set ScourgeMidTowerLevel2 = CreateUnit(ScourgePlayers[0], 'u00D', 2528, 1824, 45)
        set ScourgeBotTowerLevel2 = CreateUnit(ScourgePlayers[0], 'u00D', 6272, -160, 0.)
        // level 3
        set ScourgeTopTowerLevel3 = CreateUnit(ScourgePlayers[0], 'u00N', 2976, 5792, 90)
        set ScourgeMidTowerLevel3 = CreateUnit(ScourgePlayers[0], 'u00N', 3936, 3488, 45)
        set ScourgeBotTowerLevel3 = CreateUnit(ScourgePlayers[0], 'u00N', 6368, 2528, 0.)
        // level 4
        set ScourgeLeftTowerLevel4  = CreateUnit(ScourgePlayers[0], 'u00T', 4832, 4832, 45)
        set ScourgeRightTowerLevel4 = CreateUnit(ScourgePlayers[0], 'u00T', 5152, 4512, 45)

        call CreateTowerAttackRangeIndicator(ScourgeTopTowerLevel1)
        call CreateTowerAttackRangeIndicator(ScourgeMidTowerLevel1)
        call CreateTowerAttackRangeIndicator(ScourgeBotTowerLevel1)
        call CreateTowerAttackRangeIndicator(ScourgeTopTowerLevel2)
        call CreateTowerAttackRangeIndicator(ScourgeMidTowerLevel2)
        call CreateTowerAttackRangeIndicator(ScourgeBotTowerLevel2)
        call CreateTowerAttackRangeIndicator(ScourgeTopTowerLevel3)
        call CreateTowerAttackRangeIndicator(ScourgeMidTowerLevel3)
        call CreateTowerAttackRangeIndicator(ScourgeBotTowerLevel3)
        call CreateTowerAttackRangeIndicator(ScourgeLeftTowerLevel4)
        call CreateTowerAttackRangeIndicator(ScourgeRightTowerLevel4)

        globals
            trigger ScourgeTowersDeathTrig = null
        endglobals
        set ScourgeTowersDeathTrig = CreateTrigger()
        call TriggerRegisterPlayerUnitEventBJ(ScourgeTowersDeathTrig, EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(ScourgeTowersDeathTrig, Condition(function ScourgeTowersDeathCondition))
        call TriggerAddAction(ScourgeTowersDeathTrig, function ScourgeTowersDeathAction)
    endfunction

    function Towers_Init takes nothing returns nothing
        call CreateSentinelTowers()
        call CreateScourgeTowers()
    endfunction

endscope
