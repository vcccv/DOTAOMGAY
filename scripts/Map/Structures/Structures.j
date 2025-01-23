
globals
    constant playercolor PLAYER_COLOR_BLACK = ConvertPlayerColor(12)
endglobals

scope Structures

    #include "Merchants.j"
    #include "AntiBackdoor.j"
    #include "Towers.j"
    #include "Raxs.j"
    globals
	    string VictoryTeamName = ""
    endglobals
    //***************************************************************************
    //*
    //*  SentinelUnits
    //*
    //***************************************************************************
    function WorldTreeDeathAction takes nothing returns nothing
        local trigger t = CreateTrigger()
        call PanCameraToTimed(GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()), 0)
        call TriggerRegisterTimerEvent(t, 2.5, false)
        call TriggerAddCondition(t, Condition(function CreateGameEndMultiboard))
        set WinnerIndex = 2
        set VictoryTeamName = "|c0020c000" + GetObjectName('n03O')+ "|r"
        call GameEndAction()
        call StoreTeamCache("2")
        set t = null
    endfunction
    function CreateSentinelUnits takes nothing returns nothing
        globals
            unit SentinelFountainOfLifeUnit
            unit WorldTree
        endglobals

        local trigger t

        set SentinelFountainOfLifeUnit = CreateUnit(SentinelPlayers[0],'nfoh',-7168,-7168, 270)
        call CreateUnit(SentinelPlayers[0],'o00G',-7168,-7168, 270)

        set WorldTree = CreateUnit(SentinelPlayers[0],'etol',-5568,-6016, 270)
        set WorldTreeDeathTrig = CreateTrigger()
        call TriggerRegisterUnitEvent(WorldTreeDeathTrig, WorldTree, EVENT_UNIT_DEATH)
        call TriggerAddAction(WorldTreeDeathTrig, function WorldTreeDeathAction)

        globals
            unit SentinelMoonWell1
            unit SentinelMoonWell2
            unit SentinelMoonWell3
            unit SentinelMoonWell4
            unit SentinelMoonWell5
            unit SentinelMoonWell6
            unit SentinelMoonWell7
            unit SentinelMoonWell8
            unit SentinelMoonWell9
            unit SentinelMoonWell10
            unit SentinelMoonWell11
            unit SentinelAncientOfWind1
            unit SentinelAncientOfWind2
            unit SentinelHuntersHall1
            unit SentinelHuntersHall2
        endglobals
        set SentinelMoonWell1  = CreateUnit(SentinelPlayers[0],'emow',-5856,-5472, 270)
        set SentinelMoonWell2  = CreateUnit(SentinelPlayers[0],'emow',-6624,-5088, 270)
        set SentinelMoonWell3  = CreateUnit(SentinelPlayers[0],'emow',-5344, -3936, 270)
        set SentinelMoonWell4  = CreateUnit(SentinelPlayers[0],'emow',-5088,-4576, 270)
        set SentinelMoonWell5  = CreateUnit(SentinelPlayers[0],'emow', -3936,-5344, 270)
        set SentinelMoonWell6  = CreateUnit(SentinelPlayers[0],'emow',-5088,-5536, 270)
        set SentinelMoonWell7  = CreateUnit(SentinelPlayers[0],'emow',-4896,-6240, 270)
        set SentinelMoonWell8  = CreateUnit(SentinelPlayers[0],'emow', -3808,-5856, 270)
        set SentinelMoonWell9  = CreateUnit(SentinelPlayers[0],'emow',-4512,-7072, 270)
        set SentinelMoonWell10 = CreateUnit(SentinelPlayers[0],'emow',-5472,-4704, 270)
        set SentinelMoonWell11 = CreateUnit(SentinelPlayers[0],'emow',-4512,-5856, 270)
        set SentinelAncientOfWind1 = CreateUnit(SentinelPlayers[0],'eaow',-6080,-5120, 270)
        set SentinelAncientOfWind2 = CreateUnit(SentinelPlayers[0],'eaow',-4544,-6528, 270)
        set SentinelHuntersHall1 = CreateUnit(SentinelPlayers[0],'edob',-6400,-5696, 270)
        set SentinelHuntersHall2 = CreateUnit(SentinelPlayers[0],'edob',-5248,-6848, 270)
        call UnitAddAbility(WorldTree,'Avul')
        call UnitAddAbility(SentinleTopTowerLevel2,'Avul')
        call UnitAddAbility(SentinleMidTowerLevel2,'Avul')
        call UnitAddAbility(SentinleBotTowerLevel2,'Avul')
        call UnitAddAbility(SentinleTopTowerLevel3,'Avul')
        call UnitAddAbility(SentinleMidTowerLevel3,'Avul')
        call UnitAddAbility(SentinleBotTowerLevel3,'Avul')
        call UnitAddAbility(SentinleLeftTowerLevel4,'Avul')
        call UnitAddAbility(SentinleRightTowerLevel4,'Avul')
        call UnitAddAbility(SentinelTopMeleeRaxUnit,'Avul')
        call UnitAddAbility(SentinelMidMeleeRaxUnit,'Avul')
        call UnitAddAbility(SentinelBotMeleeRaxUnit,'Avul')
        call UnitAddAbility(SentinelTopRangedRaxUnit,'Avul')
        call UnitAddAbility(SentinelMidRangedRaxUnit,'Avul')
        call UnitAddAbility(SentinelBotRangedRaxUnit,'Avul')
        call UnitAddAbility(SentinelAncientOfWind1,'Avul')
        call UnitAddAbility(SentinelAncientOfWind2,'Avul')
        call UnitAddAbility(SentinelHuntersHall1,'Avul')
        call UnitAddAbility(SentinelHuntersHall2,'Avul')
        call UnitAddAbility(SentinelMoonWell1, 'Avul')
        call UnitAddAbility(SentinelMoonWell2, 'Avul')
        call UnitAddAbility(SentinelMoonWell3, 'Avul')
        call UnitAddAbility(SentinelMoonWell4, 'Avul')
        call UnitAddAbility(SentinelMoonWell5, 'Avul')
        call UnitAddAbility(SentinelMoonWell6, 'Avul')
        call UnitAddAbility(SentinelMoonWell7, 'Avul')
        call UnitAddAbility(SentinelMoonWell8, 'Avul')
        call UnitAddAbility(SentinelMoonWell9, 'Avul')
        call UnitAddAbility(SentinelMoonWell10,'Avul')
        call UnitAddAbility(SentinelMoonWell11,'Avul')

        globals
            unit SentinelCircle1
            unit SentinelCircle2
            unit SentinelCircle3
            unit SentinelCircle4
            unit SentinelCircle5
        endglobals
        set SentinelCircle1 = CreateUnit(Player(1),'ncop',-7424,-7176, 270)
        call SetCircleIndex(SentinelCircle1, 1)
        call HidePlayerBreak(SentinelCircle1)
        set SentinelCircle2 = CreateUnit(Player(2),'ncop',-7424,-6998, 270)
        call SetCircleIndex(SentinelCircle2, 2)
        call HidePlayerBreak(SentinelCircle2)
        set SentinelCircle3 = CreateUnit(Player(3),'ncop',-7424,-6820, 270)
        call SetCircleIndex(SentinelCircle3, 3)
        call HidePlayerBreak(SentinelCircle3)
        set SentinelCircle4 = CreateUnit(Player(4),'ncop',-7424,-6592, 270)
        call SetCircleIndex(SentinelCircle4, 4)
        call HidePlayerBreak(SentinelCircle4)
        set SentinelCircle5 = CreateUnit(Player(5),'ncop',-7424,-6400, 270)
        call SetCircleIndex(SentinelCircle5, 5)
        call HidePlayerBreak(SentinelCircle5)

        set t = CreateTrigger()
        call TriggerRegisterUnitEvent(t, WorldTree, EVENT_UNIT_DAMAGED)
        call TriggerAddCondition(t, Condition(function WorldTreeStoreLifeCache))

    endfunction

    //***************************************************************************
    //*
    //*  ScourgeUnits
    //*
    //***************************************************************************
    function FrozenThroneFadeOutLoopAction takes nothing returns boolean
        call SetUnitVertexColorBJ(FrozenThrone, 100, 100, 100, GetTriggerEvalCount(GetTriggeringTrigger()))
        if GetTriggerEvalCount(GetTriggeringTrigger()) == 100  then
            call ShowUnit(FrozenThrone, false)
            call AddTriggerToDestroyQueue(GetTriggeringTrigger())
        endif
        return false
    endfunction
    function FrozenThroneDeathAction takes nothing returns nothing
        local trigger t = CreateTrigger()
        call PanCameraToTimed(GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()), 0)
        call TriggerRegisterTimerEvent(t, 1.5, false)
        call TriggerAddCondition(t, Condition(function CreateGameEndMultiboard))
        set WinnerIndex = 1
        set VictoryTeamName = "|c00ff0303" + GetObjectName('n03N')+ "|r"
        call GameEndAction()
        call StoreTeamCache("1")
        call AddSpecialEffect("war3mapImported\\FrozenThronesDeath2.mdx", GetUnitX(FrozenThrone) +150, GetUnitY(FrozenThrone)+ 100 )
        set t = CreateTrigger()
        call TriggerRegisterTimerEvent(t, .02, true)
        call TriggerAddCondition(t, Condition(function FrozenThroneFadeOutLoopAction))
        set t = null
    endfunction
    function CreateScourgeUnits takes nothing returns nothing
        local trigger t

        globals
            unit ScourgeFountainOfLifeUnit
            unit FrozenThrone
        endglobals
        set ScourgeFountainOfLifeUnit = CreateUnit(ScourgePlayers[0],'ndfl', 6784, 6368, 270)
        call CreateUnit(ScourgePlayers[0],'o00G', 6784, 6368, 270)

        set FrozenThrone = CreateUnit(ScourgePlayers[0],'unpl', 5248, 4918, 220)
        set FrozenThroneDeathTrig = CreateTrigger()
        call TriggerRegisterUnitEvent(FrozenThroneDeathTrig, FrozenThrone, EVENT_UNIT_DEATH)
        call TriggerAddAction(FrozenThroneDeathTrig, function FrozenThroneDeathAction)
       
        globals
            unit ScourgeZiggurat1
            unit ScourgeZiggurat2
            unit ScourgeZiggurat3
            unit ScourgeZiggurat4
            unit ScourgeZiggurat5
            unit ScourgeZiggurat6
            unit ScourgeZiggurat7
            unit ScourgeZiggurat8
            unit ScourgeZiggurat9
            unit ScourgeZiggurat10
            unit ScourgeZiggurat11
            unit ScourgeSacrificialPit1
            unit ScourgeSacrificialPit2
            unit ScourgeBoneyard1
            unit ScourgeBoneyard2
        endglobals
        set ScourgeZiggurat1  = CreateUnit(ScourgePlayers[0], 'uzig', 2656, 4704, 270)
        set ScourgeZiggurat2  = CreateUnit(ScourgePlayers[0], 'uzig', 3168, 4064, 270)
        set ScourgeZiggurat3  = CreateUnit(ScourgePlayers[0], 'uzig', 3488, 4832, 270)
        set ScourgeZiggurat4  = CreateUnit(ScourgePlayers[0], 'uzig', 4128, 6240, 270)
        set ScourgeZiggurat5  = CreateUnit(ScourgePlayers[0], 'uzig', 4064, 5280, 270)
        set ScourgeZiggurat6  = CreateUnit(ScourgePlayers[0], 'uzig', 4384, 4256, 270)
        set ScourgeZiggurat7  = CreateUnit(ScourgePlayers[0], 'uzig', 5728, 4000, 270)
        set ScourgeZiggurat8  = CreateUnit(ScourgePlayers[0], 'uzig', 5536, 2464, 270)
        set ScourgeZiggurat9  = CreateUnit(ScourgePlayers[0], 'uzig', 5024, 3744, 270)
        set ScourgeZiggurat10 = CreateUnit(ScourgePlayers[0], 'uzig', 6880, 3936, 270)
        set ScourgeZiggurat11 = CreateUnit(ScourgePlayers[0], 'uzig', 4640, 2848, 270)
        set ScourgeSacrificialPit1 = CreateUnit(ScourgePlayers[0], 'usap', 3968, 5888, 270)
        set ScourgeSacrificialPit2 = CreateUnit(ScourgePlayers[0], 'usap', 6400, 3584, 270)
        set ScourgeBoneyard1 = CreateUnit(ScourgePlayers[0], 'ubon', 4992, 5952, 270)
        set ScourgeBoneyard2 = CreateUnit(ScourgePlayers[0], 'ubon', 6464, 4608, 270)
        call UnitAddAbility(FrozenThrone,'Avul')
        call UnitAddAbility(ScourgeTopTowerLevel2,'Avul')
        call UnitAddAbility(ScourgeMidTowerLevel2,'Avul')
        call UnitAddAbility(ScourgeBotTowerLevel2,'Avul')
        call UnitAddAbility(ScourgeTopTowerLevel3,'Avul')
        call UnitAddAbility(ScourgeMidTowerLevel3,'Avul')
        call UnitAddAbility(ScourgeBotTowerLevel3,'Avul')
        call UnitAddAbility(ScourgeLeftTowerLevel4,'Avul')
        call UnitAddAbility(ScourgeRightTowerLevel4,'Avul')
        call UnitAddAbility(ScourgeTopMeleeRaxUnit,'Avul')
        call UnitAddAbility(ScourgeMidMeleeRaxUnit,'Avul')
        call UnitAddAbility(ScourgeBotMeleeRaxUnit,'Avul')
        call UnitAddAbility(ScourgeTopRangedRaxUnit,'Avul')
        call UnitAddAbility(ScourgeMidRangedRaxUnit,'Avul')
        call UnitAddAbility(ScourgeBotRangedRaxUnit,'Avul')
        call UnitAddAbility(ScourgeSacrificialPit1,'Avul')
        call UnitAddAbility(ScourgeSacrificialPit2,'Avul')
        call UnitAddAbility(ScourgeBoneyard1,'Avul')
        call UnitAddAbility(ScourgeBoneyard2,'Avul')
        call UnitAddAbility(ScourgeZiggurat1,'Avul')
        call UnitAddAbility(ScourgeZiggurat2,'Avul')
        call UnitAddAbility(ScourgeZiggurat3,'Avul')
        call UnitAddAbility(ScourgeZiggurat4,'Avul')
        call UnitAddAbility(ScourgeZiggurat5,'Avul')
        call UnitAddAbility(ScourgeZiggurat6,'Avul')
        call UnitAddAbility(ScourgeZiggurat7,'Avul')
        call UnitAddAbility(ScourgeZiggurat8,'Avul')
        call UnitAddAbility(ScourgeZiggurat9,'Avul')
        call UnitAddAbility(ScourgeZiggurat10,'Avul')
        call UnitAddAbility(ScourgeZiggurat11,'Avul')

        globals
            unit ScourgeCircle1
            unit ScourgeCircle2
            unit ScourgeCircle3
            unit ScourgeCircle4
            unit ScourgeCircle5
        endglobals
        set ScourgeCircle1 = CreateUnit(Player(7),'ncop', 7040, 6400, 270)
        call SetCircleIndex(ScourgeCircle1, 7)
        call HidePlayerBreak(ScourgeCircle1)
        set ScourgeCircle2 = CreateUnit(Player(8),'ncop', 7040, 6208, 270)
        call SetCircleIndex(ScourgeCircle2, 8)
        call HidePlayerBreak(ScourgeCircle2)
        set ScourgeCircle3 = CreateUnit(Player(9),'ncop', 7040, 6016, 270)
        call SetCircleIndex(ScourgeCircle3, 9)
        call HidePlayerBreak(ScourgeCircle3)
        set ScourgeCircle4 = CreateUnit(Player(10),'ncop', 7040, 5824, 270)
        call SetCircleIndex(ScourgeCircle4, 10)
        call HidePlayerBreak(ScourgeCircle4)
        set ScourgeCircle5 = CreateUnit(Player(11),'ncop', 7040 -64, 5632, 270)
        call SetCircleIndex(ScourgeCircle5, 11)
        call HidePlayerBreak(ScourgeCircle5)
        set t = CreateTrigger()
        call TriggerRegisterUnitEvent(t, FrozenThrone, EVENT_UNIT_DAMAGED)
        call TriggerAddCondition(t, Condition(function FrozenThroneStoreLifeCache))
    endfunction

    //***************************************************************************
    //*
    //*  Damaged
    //*
    //***************************************************************************
    globals
	    trigger StructuresDamagedTrig = null
    endglobals
    function StructuresDamagedAction takes nothing returns nothing
        local real   damageValue  = GetEventDamage()
        local player sourcePlayer = GetOwningPlayer(GetEventDamageSource())
        local unit   u            = GetTriggerUnit()
        if IsUnitEnemy(u, GetOwningPlayer(GetEventDamageSource())) then
            if GetUnitAbilityLevel(u,'A17R') == 1 then
                call SetUnitToReduceDamage(u, damageValue)
            else
                if IsUnitIllusion(GetEventDamageSource()) then
                    call SetUnitToReduceDamage(u, .25 * damageValue)
                    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", u, "origin"))
                    set damageValue = damageValue * .75
                endif
            endif
        endif
        set u = null
    endfunction
    function CreateStructuresDamagedTrig takes nothing returns nothing
        set StructuresDamagedTrig = CreateTrigger()
        call TriggerAddAction(StructuresDamagedTrig, function StructuresDamagedAction)
        // Sentinle
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, SentinleTopTowerLevel1,   EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, SentinleMidTowerLevel1,   EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, SentinleBotTowerLevel1,   EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, SentinleTopTowerLevel2,   EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, SentinleMidTowerLevel2,   EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, SentinleBotTowerLevel2,   EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, SentinleTopTowerLevel3,   EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, SentinleMidTowerLevel3,   EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, SentinleBotTowerLevel3,   EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, SentinleLeftTowerLevel4,  EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, SentinleRightTowerLevel4, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, SentinelTopMeleeRaxUnit,  EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, SentinelMidMeleeRaxUnit,  EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, SentinelBotMeleeRaxUnit,  EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, SentinelTopRangedRaxUnit, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, SentinelMidRangedRaxUnit, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, SentinelBotRangedRaxUnit, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, WorldTree, EVENT_UNIT_DAMAGED)
        // Scourge
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, ScourgeTopTowerLevel1,   EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, ScourgeMidTowerLevel1,   EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, ScourgeBotTowerLevel1,   EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, ScourgeTopTowerLevel2,   EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, ScourgeMidTowerLevel2,   EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, ScourgeBotTowerLevel2,   EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, ScourgeTopTowerLevel3,   EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, ScourgeMidTowerLevel3,   EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, ScourgeBotTowerLevel3,   EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, ScourgeLeftTowerLevel4,  EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, ScourgeRightTowerLevel4, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, ScourgeTopMeleeRaxUnit,  EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, ScourgeMidMeleeRaxUnit,  EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, ScourgeBotMeleeRaxUnit,  EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, ScourgeTopRangedRaxUnit, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, ScourgeMidRangedRaxUnit, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, ScourgeBotRangedRaxUnit, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(StructuresDamagedTrig, FrozenThrone, EVENT_UNIT_DAMAGED)
    endfunction

    function Structures_Init takes nothing returns nothing
        call SetPlayerAbilityAvailableEx(NEUTRAL_PASSIVE_PLAYER, 'Aro1', false)
        // 创建近卫和天灾的建筑 包括商店
        call Towers_Init()
        call Merchants_Init()
        call Raxs_Init()
        call CreateSentinelUnits()
        call CreateScourgeUnits()
        call AntiBackdoor_Init()
        call CreateStructuresDamagedTrig()
    endfunction

endscope
