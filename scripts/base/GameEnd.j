
scope GameEnd

    function GetPlayerNameEx takes player p returns string
        return PlayersColoerText[GetPlayerId(p)]+ PlayersName[GetPlayerId(p)]+ "|r"
    endfunction
    function GetPlayerGoldBonusString takes player p returns string
        local string str = I2S(PlayerGoldBonus[GetPlayerId(p)])
        local string locString = str
        if p == LocalPlayer then
            set locString = "|c00FF6600" + str + "|r"
        endif
        return locString
    endfunction
    function GetPlayerExpBonusString takes player p returns string
        local string str = I2S(PlayerExpBonus[GetPlayerId(p)])
        local string locString = str
        if p == LocalPlayer then
            set locString = "|c00FF6600" + str + "|r"
        endif
        return locString
    endfunction
    function L5X takes nothing returns nothing
        local integer i = 1
        local multiboarditem mbt
        loop
        exitwhen i > FVV
            if (PlayerOnlineStateString[GetPlayerId((D9V[i]))])!= "Here"then
                set mbt = MultiboardGetItem(GameEndScoresMultiboard, D7V[i], D8V[i])
                call MultiboardSetItemStyle(mbt, true, false)
                call MultiboardSetItemValue(mbt, "|c00555555" +(PlayerOnlineStateString[GetPlayerId((D9V[i]))])+ "|r")
                call MultiboardSetItemWidth(mbt, .07)
                call MultiboardReleaseItem(mbt)
            endif
            set i = i + 1
        endloop
        set mbt = null
    endfunction
    function GetPlayerCurrentGoldString takes player p returns string
        local string str = I2S(GetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD))
        local string locString = str
        if p == LocalPlayer then
            set locString = "|c00FF6600" + str + "|r"
        endif
        return locString
    endfunction
    function GetPlayerConsumablesCountString takes player p returns string
        local string str = I2S(PlayerConsumablesCount[GetPlayerId(p)])
        local string locString = str
        if p == LocalPlayer then
            set locString = "|c00FF6600" + str + "|r"
        endif
        return locString
    endfunction
    function GetPlayerHeroLevelString takes player p returns string
        local string str = I2S(GetUnitLevel(PlayerHeroes[GetPlayerId(p)]))
        local string locString = str
        if p == LocalPlayer then
            set locString = "|c00FF6600" + str + "|r"
        endif
        return locString
    endfunction
    function GetPlayerWardCountString takes player p returns string
        local string str = I2S(PlayerWardCount[GetPlayerId(p)])
        local string locString = str
        if p == LocalPlayer then
            set locString = "|c00FF6600" + str + "|r"
        endif
        return locString
    endfunction
    function GetPlayerKillHeroBonusString takes player p returns string
        local string str = I2S(PlayerKillHeroBonus[GetPlayerId(p)])
        local string locString = str
        if p == LocalPlayer then
            set locString = "|c00FF6600" + str + "|r"
        endif
        return locString
    endfunction
    function GetPlayerHeroDeathLossGoldString takes player p returns string
        local string str = I2S(PlayerHeroDeathLossGold[GetPlayerId(p)])
        local string locString = str
        if p == LocalPlayer then
            set locString = "|c00FF6600" + str + "|r"
        endif
        return locString
    endfunction
    function GetPlayerAssistCountString takes player p returns string
        local string str = I2S(PlayerAssistCount[GetPlayerId(p)])
        local string locString = str
        if p == LocalPlayer then
            set locString = "|c00FF6600" + str + "|r"
        endif
        return locString
    endfunction
    function GetPlayerKillHeroCountString takes player p returns string
        local string str = I2S(PlayerKillHerosCount[GetPlayerId(p)])
        local string locString = str
        if p == LocalPlayer then
            set locString = "|c00FF6600" + str + "|r"
        endif
        return locString
    endfunction
    function GetPlayerHeroDeathCountString takes player p returns string
        local string str = I2S(PlayerHeroDeathCount[GetPlayerId(p)])
        local string locString = str
        if p == LocalPlayer then
            set locString = "|c00FF6600" + str + "|r"
        endif
        return locString
    endfunction
    function GetPlayerCreepLastHitCountString takes player p returns string
        local string str = I2S(PlayerCreepLastHitCount[GetPlayerId(p)])
        local string locString = str
        if p == LocalPlayer then
            set locString = "|c00FF6600" + str + "|r"
        endif
        return locString
    endfunction
    function GetPlayerCreepDenyCountString takes player p returns string
        local string str = I2S(PlayerCreepDenyCount[GetPlayerId(p)])
        local string locString = str
        if p == LocalPlayer then
            set locString = "|c00FF6600" + str + "|r"
        endif
        return locString
    endfunction
    // 中立野怪
    function GetPlayerNeutralCreepLastHitCountString takes player p returns string
        local string str = I2S((LoadInteger(HY,(400 + GetPlayerId(p)), 79)))
        local string locString = str
        if p == LocalPlayer then
            set locString = "|c00FF6600" + str + "|r"
        endif
        return locString
    endfunction
    function GetPlayerDoubleKillCountString takes player p returns string
        local string str = I2S(PlayerDoubleKillCount[GetPlayerId(p)])
        local string locString = str
        if p == LocalPlayer then
            set locString = "|c00FF6600" + str + "|r"
        endif
        return locString
    endfunction
    function GetPlayerTripleKillCountString takes player p returns string
        local string str = I2S(PlayerTripleKillCount[GetPlayerId(p)])
        local string locString = str
        if p == LocalPlayer then
            set locString = "|c00FF6600" + str + "|r"
        endif
        return locString
    endfunction
    function GetPlayerMaxSuccessionKillCountString takes player p returns string
        local string str = I2S(PlayerMaxSuccessionKillCount[GetPlayerId(p)])
        local string locString = str
        if p == LocalPlayer then
            set locString = "|c00FF6600" + str + "|r"
        endif
        return locString
    endfunction
    function GetPlayerKillAndDenyTowerCountString takes player p returns string
        local string killString
        local string denyString
        local string locString
        local integer k = PlayerLastHitTowerCount[GetPlayerId(p)]
        local integer d = PlayerDenyTowerCount[GetPlayerId(p)]
        if k < 1 then
            set k = 0
        endif
        if d < 1 then
            set d = 0
        endif
        set killString = I2S(k)
        set denyString = I2S(d)
        set locString = killString + "/" + denyString
        if p == LocalPlayer then
            set locString = "|c00FF6600" + killString + "|r/" + "|c00FF6600" + denyString + "|r"
        endif
        return locString
    endfunction
    function GetPlayerDeathTimeString takes player p returns string
        local integer time = PlayerDeathTime[GetPlayerId(p)]
        local string locString
        local integer minute
        local integer second
        set minute =(time / 60)-(1 / 2)
        set second = ModuloInteger(time, 60)
        if (second < 10) then
            set locString = I2S(minute)+ ":0" + I2S(second)
        else
            set locString = I2S(minute)+ ":" + I2S(second)
        endif
        if p == LocalPlayer then
            set locString = "|c00FF6600" + locString + "|r"
        endif
        return locString
    endfunction
    function GetPlayerKillDetailsString takes player WUE, player WWE returns string
        local string killString
        local string denyString
        local string locString
        local integer k = LoadInteger(HY, 400 + GetPlayerId(WUE), 450 + GetPlayerId(WWE))
        local integer d = LoadInteger(HY, 400 + GetPlayerId(WUE), 500 + GetPlayerId(WWE))
        if k < 1 then
            set k = 0
        endif
        if d < 1 then
            set d = 0
        endif
        set killString = I2S(k)
        set denyString = I2S(d)
        set locString = killString + "/" + denyString
        if WUE == LocalPlayer then
            set locString = "|c00FF6600" + killString + "|r/" + "|c00FF6600" + denyString + "|r"
        endif
        return locString
    endfunction
    function SetMultiboardItemDatas takes multiboarditem mbt, boolean showValue, boolean showIcon, string itemValue, string itemIcon, real itemWidth returns nothing
        call MultiboardSetItemStyle(mbt, showValue, showIcon )
        if itemIcon != null then
            call MultiboardSetItemIcon(mbt, itemIcon)
        endif
        if itemValue != null then
            call MultiboardSetItemValue(mbt, itemValue)
        endif
        if itemWidth > 0 then
            call MultiboardSetItemWidth(mbt, itemWidth)
        endif
    endfunction

    globals
	    multiboard GameEndScoresMultiboard
    endglobals

    function CreateGameEndMultiboard takes nothing returns nothing
        local integer sentinelCount = SentinelUserCount
        local integer scourgeCount = ScourgeUserCount
        local player array sentinelUserList
        local player array scourgeUserList
        local integer loop_row
        local integer loop_column
        local integer rowCount = 21 + IMaxBJ(sentinelCount, scourgeCount)+ 1
        local integer columnCount = 1 +(sentinelCount + scourgeCount)* 2
        local multiboarditem mbt
        local integer i
        local integer x
        local string e = "|r"
        local string c0 = "|cff99ccff"
        local integer K6O
        local integer K7O
        call DisableTrigger(UpdateMainMultiboardTrig)
        call DestroyMultiboard(MainMultiboard)
        if sentinelCount > 0 and scourgeCount > 0 then
            set rowCount = rowCount + 2
        endif
        set GameEndScoresMultiboard = CreateMultiboard()
        set BJ_Multiboard = GameEndScoresMultiboard
        call MultiboardSetItemsWidth(GameEndScoresMultiboard, 0)
        call MultiboardSetRowCount(GameEndScoresMultiboard, rowCount)
        call MultiboardSetColumnCount(GameEndScoresMultiboard, columnCount)
        call MultiboardSetTitleText(GameEndScoresMultiboard, GetObjectName('n0E3')+ " " + " - " +(GameModeString))
        call MultiboardMinimize(GameEndScoresMultiboard, true)
        call MultiboardSetItemsStyle(GameEndScoresMultiboard, false, false)
        call MultiboardDisplay(GameEndScoresMultiboard, true)
        call MultiboardMinimize(GameEndScoresMultiboard, false)
        call MultiboardSetTitleText(GameEndScoresMultiboard, GetObjectName('n0E3')+ " " + " - " +(GameModeString)+ " - " +("|c00ff0303" + I2S(PlayerKillHerosCount[GetPlayerId(SentinelPlayers[0])])+ "|r/|c0020c000" + I2S(PlayerHeroDeathCount[GetPlayerId(SentinelPlayers[0])])+ "|r"))
        
        set x = 1
        set i = 1
        loop
        exitwhen i > 5
            if IsPlayerPlaying(SentinelPlayers[i]) or GetPlayerSlotState(SentinelPlayers[i]) == PLAYER_SLOT_STATE_LEFT then
                set sentinelUserList[x]= SentinelPlayers[i]
                set x = x + 1
            endif
            set i = i + 1
        endloop
        set x = 1
        set i = 1
        loop
        exitwhen i > 5
            if IsPlayerPlaying(ScourgePlayers[i]) or GetPlayerSlotState(ScourgePlayers[i]) == PLAYER_SLOT_STATE_LEFT then
                set scourgeUserList[x]= ScourgePlayers[i]
                set x = x + 1
            endif
            set i = i + 1
        endloop

        set i = 0
        set loop_column = 0
        loop
        exitwhen i > rowCount
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, i, loop_column)
            call MultiboardSetItemWidth(mbt, .075)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set loop_row = 0
        set loop_column = 0
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
        call MultiboardSetItemStyle(mbt, true, false)
        call MultiboardSetItemValue(mbt, " ")
        call MultiboardReleaseItem(mbt)
        set loop_column = 0
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
        call MultiboardSetItemStyle(mbt, false, false)
        call MultiboardReleaseItem(mbt)
        set loop_column = 0
        set i = 1
        loop
        exitwhen i > sentinelCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerNameEx(sentinelUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > scourgeCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerNameEx(scourgeUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set loop_row = loop_row + 1
        set loop_column = 0
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
        call MultiboardSetItemStyle(mbt, false, false)
        call MultiboardReleaseItem(mbt)
        // 英雄等级
        set i = 1
        loop
        exitwhen i > sentinelCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, true, GetPlayerHeroLevelString(sentinelUserList[i]), GetHeroIconFilePath(PlayerHeroes[GetPlayerId(sentinelUserList[i])]), .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > scourgeCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, true, GetPlayerHeroLevelString(scourgeUserList[i]), GetHeroIconFilePath(PlayerHeroes[GetPlayerId(scourgeUserList[i])]), .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set loop_row = loop_row + 1
        set loop_column = 0
        set loop_row = loop_row + 1
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
        call MultiboardSetItemStyle(mbt, true, false)
        call MultiboardSetItemValue(mbt, c0 + GetObjectName('n0EB')+ e)
        call MultiboardReleaseItem(mbt)
        set loop_column = 0
        set i = 1
        loop
        exitwhen i > sentinelCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, false, true, null, GetItemIcon(UnitItemInSlot(PlayerHeroes[GetPlayerId(sentinelUserList[i])], 0)), .015)
            call MultiboardReleaseItem(mbt)
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, false, true, null, GetItemIcon(UnitItemInSlot(PlayerHeroes[GetPlayerId(sentinelUserList[i])], 1)), .054)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > scourgeCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, false, true, null, GetItemIcon(UnitItemInSlot(PlayerHeroes[GetPlayerId(scourgeUserList[i])], 0)), .015)
            call MultiboardReleaseItem(mbt)
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, false, true, null, GetItemIcon(UnitItemInSlot(PlayerHeroes[GetPlayerId(scourgeUserList[i])], 1)), .054)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set loop_row = loop_row + 1
        set loop_column = 0
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
        call MultiboardSetItemStyle(mbt, true, false)
        call MultiboardSetItemValue(mbt, c0 + " " + e)
        call MultiboardReleaseItem(mbt)
        set i = 1
        loop
        exitwhen i > sentinelCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, false, true, null, GetItemIcon(UnitItemInSlot(PlayerHeroes[GetPlayerId(sentinelUserList[i])], 2)), .015)
            call MultiboardReleaseItem(mbt)
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, false, true, null, GetItemIcon(UnitItemInSlot(PlayerHeroes[GetPlayerId(sentinelUserList[i])], 3)), .054)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > scourgeCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, false, true, null, GetItemIcon(UnitItemInSlot(PlayerHeroes[GetPlayerId(scourgeUserList[i])], 2)), .015)
            call MultiboardReleaseItem(mbt)
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, false, true, null, GetItemIcon(UnitItemInSlot(PlayerHeroes[GetPlayerId(scourgeUserList[i])], 3)), .054)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set loop_row = loop_row + 1
        set loop_column = 0
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
        call MultiboardSetItemStyle(mbt, true, false)
        call MultiboardSetItemValue(mbt, c0 + " " + e)
        call MultiboardReleaseItem(mbt)
        set i = 1
        loop
        exitwhen i > sentinelCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, false, true, null, GetItemIcon(UnitItemInSlot(PlayerHeroes[GetPlayerId(sentinelUserList[i])], 4)), .015)
            call MultiboardReleaseItem(mbt)
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, false, true, null, GetItemIcon(UnitItemInSlot(PlayerHeroes[GetPlayerId(sentinelUserList[i])], 5)), .054)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > scourgeCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, false, true, null, GetItemIcon(UnitItemInSlot(PlayerHeroes[GetPlayerId(scourgeUserList[i])], 4)), .015)
            call MultiboardReleaseItem(mbt)
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, false, true, null, GetItemIcon(UnitItemInSlot(PlayerHeroes[GetPlayerId(sentinelUserList[i])], 5)), .054)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set loop_column = 0
        set loop_row = loop_row + 1
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
        call MultiboardSetItemStyle(mbt, true, false)
        call MultiboardSetItemValue(mbt, c0 + GetObjectName('n0E2')+ e)
        call MultiboardReleaseItem(mbt)
        set loop_column = 0
        set i = 1
        loop
        exitwhen i > sentinelCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerCurrentGoldString(sentinelUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > scourgeCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerCurrentGoldString(scourgeUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set loop_column = 0
        set loop_row = loop_row + 1
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
        call MultiboardSetItemStyle(mbt, true, false)
        call MultiboardSetItemValue(mbt, c0 + GetObjectName('n0E1')+ e)
        call MultiboardReleaseItem(mbt)
        set loop_column = 0
        set i = 1
        loop
        exitwhen i > sentinelCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerKillHeroCountString(sentinelUserList[i])+ "/" + GetPlayerHeroDeathCountString(sentinelUserList[i])+ "/" + GetPlayerAssistCountString(sentinelUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > scourgeCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerKillHeroCountString(scourgeUserList[i])+ "/" + GetPlayerHeroDeathCountString(scourgeUserList[i])+ "/" + GetPlayerAssistCountString(scourgeUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set loop_column = 0
        set loop_row = loop_row + 1
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
        call MultiboardSetItemStyle(mbt, true, false)
        call MultiboardSetItemValue(mbt, c0 + GetObjectName('n0DZ')+ e)
        call MultiboardReleaseItem(mbt)
        set loop_column = 0
        set i = 1
        loop
        exitwhen i > sentinelCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerCreepLastHitCountString(sentinelUserList[i])+ "/" + GetPlayerCreepDenyCountString(sentinelUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > scourgeCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerCreepLastHitCountString(scourgeUserList[i])+ "/" + GetPlayerCreepDenyCountString(scourgeUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set loop_column = 0
        set loop_row = loop_row + 1
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
        call MultiboardSetItemStyle(mbt, true, false)
        call MultiboardSetItemValue(mbt, c0 + GetObjectName('n0JU')+ e)
        call MultiboardReleaseItem(mbt)
        set loop_column = 0
        set i = 1
        loop
        exitwhen i > sentinelCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerGoldBonusString(sentinelUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > scourgeCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerGoldBonusString(scourgeUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set loop_column = 0
        set loop_row = loop_row + 1
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
        call MultiboardSetItemStyle(mbt, true, false)
        call MultiboardSetItemValue(mbt, c0 + GetObjectName('n0KF')+ e)
        call MultiboardReleaseItem(mbt)
        set loop_column = 0
        set i = 1
        loop
        exitwhen i > sentinelCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerExpBonusString(sentinelUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > scourgeCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerExpBonusString(scourgeUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set loop_column = 0
        set loop_row = loop_row + 1
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
        call MultiboardSetItemStyle(mbt, true, false)
        call MultiboardSetItemValue(mbt, c0 + GetObjectName('n0E0')+ e)
        call MultiboardReleaseItem(mbt)
        set loop_column = 0
        set i = 1
        loop
        exitwhen i > sentinelCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerWardCountString(sentinelUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > scourgeCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerWardCountString(scourgeUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set loop_column = 0
        set loop_row = loop_row + 1
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
        call MultiboardSetItemStyle(mbt, true, false)
        call MultiboardSetItemValue(mbt, c0 + GetObjectName('n0DT')+ e)
        call MultiboardReleaseItem(mbt)
        set loop_column = 0
        set i = 1
        loop
        exitwhen i > sentinelCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerKillAndDenyTowerCountString(sentinelUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > scourgeCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerKillAndDenyTowerCountString(scourgeUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set loop_column = 0
        set loop_row = loop_row + 1
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
        call MultiboardSetItemStyle(mbt, true, false)
        call MultiboardSetItemValue(mbt, c0 + GetObjectName('n0DY')+ e)
        call MultiboardReleaseItem(mbt)
        set loop_column = 0
        set i = 1
        loop
        exitwhen i > sentinelCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerNeutralCreepLastHitCountString(sentinelUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > scourgeCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerNeutralCreepLastHitCountString(scourgeUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set loop_column = 0
        set loop_row = loop_row + 1
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
        call MultiboardSetItemStyle(mbt, true, false)
        call MultiboardSetItemValue(mbt, c0 + GetObjectName('n0DU')+ e)
        call MultiboardReleaseItem(mbt)
        set loop_column = 0
        set i = 1
        loop
        exitwhen i > sentinelCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerKillHeroBonusString(sentinelUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > scourgeCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerKillHeroBonusString(scourgeUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set loop_column = 0
        set loop_row = loop_row + 1
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
        call MultiboardSetItemStyle(mbt, true, false)
        call MultiboardSetItemValue(mbt, c0 + GetObjectName('n0DV')+ e)
        call MultiboardReleaseItem(mbt)
        set loop_column = 0
        set i = 1
        loop
        exitwhen i > sentinelCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerDeathTimeString(sentinelUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > scourgeCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerDeathTimeString(scourgeUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set loop_column = 0
        set loop_row = loop_row + 1
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
        call MultiboardSetItemStyle(mbt, true, false)
        call MultiboardSetItemValue(mbt, c0 + GetObjectName('n0DW')+ e)
        call MultiboardReleaseItem(mbt)
        set loop_column = 0
        set i = 1
        loop
        exitwhen i > sentinelCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerHeroDeathLossGoldString(sentinelUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > scourgeCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerHeroDeathLossGoldString(scourgeUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set loop_column = 0
        set loop_row = loop_row + 1
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
        call MultiboardSetItemStyle(mbt, true, false)
        call MultiboardSetItemValue(mbt, c0 + GetObjectName('n0DN')+ e)
        call MultiboardReleaseItem(mbt)
        set loop_column = 0
        set i = 1
        loop
        exitwhen i > sentinelCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerConsumablesCountString(sentinelUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > scourgeCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerConsumablesCountString(scourgeUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set loop_column = 0
        set loop_row = loop_row + 1
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
        call MultiboardSetItemStyle(mbt, true, false)
        call MultiboardSetItemValue(mbt, c0 + GetObjectName('n0D8')+ e)
        call MultiboardReleaseItem(mbt)
        set loop_column = 0
        set i = 1
        loop
        exitwhen i > sentinelCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerDoubleKillCountString(sentinelUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > scourgeCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerDoubleKillCountString(scourgeUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set loop_column = 0
        set loop_row = loop_row + 1
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
        call MultiboardSetItemStyle(mbt, true, false)
        call MultiboardSetItemValue(mbt, c0 + GetObjectName('n0DI')+ e)
        call MultiboardReleaseItem(mbt)
        set loop_column = 0
        set i = 1
        loop
        exitwhen i > sentinelCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerTripleKillCountString(sentinelUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > scourgeCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerTripleKillCountString(scourgeUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set loop_column = 0
        set loop_row = loop_row + 1
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
        call MultiboardSetItemStyle(mbt, true, false)
        call MultiboardSetItemValue(mbt, c0 + GetObjectName('n0DM')+ e)
        call MultiboardReleaseItem(mbt)
        set loop_column = 0
        set i = 1
        loop
        exitwhen i > sentinelCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerMaxSuccessionKillCountString(sentinelUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > scourgeCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, GetPlayerMaxSuccessionKillCountString(scourgeUserList[i]), null, .07)
            call MultiboardReleaseItem(mbt)
            set i = i + 1
        endloop
        if sentinelCount > 0 and scourgeCount > 0 then
            set loop_column = 0
            set K6O = loop_row
            set K7O = loop_column
            set loop_row = loop_row + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call MultiboardSetItemStyle(mbt, true, false)
            call MultiboardSetItemValue(mbt, c0 + GetObjectName('n0DL')+ e)
            call MultiboardReleaseItem(mbt)
            set loop_row = K6O
            set x = 1
            loop
            exitwhen x > sentinelCount
                set loop_column = 0
                set loop_row = K6O
                set i = 1
                loop
                exitwhen i > scourgeCount
                    set loop_column = x +(x -1)
                    set loop_row = loop_row + 1
                    set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
                    call SetMultiboardItemDatas(mbt, false, true, null, GetHeroIconFilePath(PlayerHeroes[GetPlayerId(sentinelUserList[x])]), .01)
                    call MultiboardReleaseItem(mbt)
                    set loop_column = loop_column + 1
                    set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
                    call SetMultiboardItemDatas(mbt, true, true, " " + GetPlayerKillDetailsString(sentinelUserList[x], scourgeUserList[i]), GetHeroIconFilePath(PlayerHeroes[GetPlayerId(scourgeUserList[i])]), .059)
                    call MultiboardReleaseItem(mbt)
                    set i = i + 1
                endloop
                set x = x + 1
            endloop
            set x = sentinelCount + 1
            loop
            exitwhen x >(scourgeCount + sentinelCount)
                set loop_column = 0
                set loop_row = K6O
                set i = 1
                loop
                exitwhen i > sentinelCount
                    set loop_column = x +(x -1)
                    set loop_row = loop_row + 1
                    set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
                    call SetMultiboardItemDatas(mbt, false, true, null, GetHeroIconFilePath(PlayerHeroes[GetPlayerId(scourgeUserList[x -sentinelCount])]), .01)
                    call MultiboardReleaseItem(mbt)
                    set loop_column = loop_column + 1
                    set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
                    call SetMultiboardItemDatas(mbt, true, true, " " + GetPlayerKillDetailsString(scourgeUserList[x -sentinelCount], sentinelUserList[i]), GetHeroIconFilePath(PlayerHeroes[GetPlayerId(sentinelUserList[i])]), .059)
                    call MultiboardReleaseItem(mbt)
                    set i = i + 1
                endloop
                set x = x + 1
            endloop
        endif
        set loop_row = loop_row + 1
        set loop_column = 0
        set loop_row = loop_row + 1
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
        call MultiboardSetItemStyle(mbt, true, false)
        call MultiboardSetItemValue(mbt, c0 + GetObjectName('n0CZ')+ e)
        call MultiboardReleaseItem(mbt)
        set loop_column = 0
        set i = 1
        loop
        exitwhen i > sentinelCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, PlayerOnlineStateString[GetPlayerId(sentinelUserList[i])], null, .07)
            call MultiboardReleaseItem(mbt)
            set FVV = FVV + 1
            set D7V[FVV]= loop_row
            set D8V[FVV]= loop_column
            set D9V[FVV]= sentinelUserList[i]
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > scourgeCount
            set loop_column = loop_column + 1
            set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
            call SetMultiboardItemDatas(mbt, true, false, PlayerOnlineStateString[GetPlayerId(scourgeUserList[i])], null, .07)
            call MultiboardReleaseItem(mbt)
            set FVV = FVV + 1
            set D7V[FVV]= loop_row
            set D8V[FVV]= loop_column
            set D9V[FVV]= scourgeUserList[i]
            set i = i + 1
        endloop
        set loop_column = 0
        set loop_row = loop_row + 1
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column)
        call MultiboardSetItemStyle(mbt, true, false)
        call MultiboardSetItemValue(mbt, c0 + GetObjectName('n0D9')+ e)
        call MultiboardReleaseItem(mbt)
        set mbt = MultiboardGetItem(GameEndScoresMultiboard, loop_row, loop_column + 1)
        call MultiboardSetItemStyle(mbt, true, false)
        call MultiboardSetItemValue(mbt, (VictoryTeamName) )
        call MultiboardSetItemWidth(mbt, .07)
        call MultiboardReleaseItem(mbt)
        call MultiboardMinimize(GameEndScoresMultiboard, true)
        call MultiboardMinimize(GameEndScoresMultiboard, false)
        set mbt = null
    endfunction

    function StoreTeamCache takes string teamIndex returns nothing
        local integer i
        local player p
        local string id
        local integer time = R2I(GetGameTime()-PickModeElapsed)
        local integer minute = time / 60 -1 / 2
        local integer second = ModuloInteger(time, 60)
        local integer pid
        if teamIndex == "1" then
            call StoreMapIdCacheData("w", "0", 31)
        else
            call StoreMapIdCacheData("w", "0", 992)
        endif
        call GetHostPlayer()
        if Mode__AntiHack then
            call PreloadFogClicks()
        endif
        set i = 1
        loop
        exitwhen i > 5
            set p = SentinelPlayers[i]
            set id = I2S(GetPlayerId(p))
            set pid = GetPlayerId(p)
            call StoreInteger(DrCache, id, "1", PlayerKillHerosCount[pid])
            call StoreInteger(DrCache, id, "2", PlayerHeroDeathCount[pid])
            call StoreInteger(DrCache, id, "3", PlayerCreepLastHitCount[pid])
            call StoreInteger(DrCache, id, "4", PlayerCreepDenyCount[pid])
            call StoreInteger(DrCache, id, "5", PlayerAssistCount[pid])
            call StoreInteger(DrCache, id, "6", GetPlayerState((p), PLAYER_STATE_RESOURCE_GOLD))
            call StoreInteger(DrCache, id, "7", LoadInteger(HY, 400 + pid, 79))
            call StoreInteger(DrCache, id, "8_0", GetItemTypeId(UnitItemInSlot(PlayerHeroes[pid], 0)))
            call StoreInteger(DrCache, id, "8_1", GetItemTypeId(UnitItemInSlot(PlayerHeroes[pid], 1)))
            call StoreInteger(DrCache, id, "8_2", GetItemTypeId(UnitItemInSlot(PlayerHeroes[pid], 2)))
            call StoreInteger(DrCache, id, "8_3", GetItemTypeId(UnitItemInSlot(PlayerHeroes[pid], 3)))
            call StoreInteger(DrCache, id, "8_4", GetItemTypeId(UnitItemInSlot(PlayerHeroes[pid], 4)))
            call StoreInteger(DrCache, id, "8_5", GetItemTypeId(UnitItemInSlot(PlayerHeroes[pid], 5)))
            call StoreInteger(DrCache, id, "9", PlayerHeroTypeId[pid])
            call StoreInteger(DrCache, id, "id", i)
            set p = ScourgePlayers[i]
            set pid = GetPlayerId(p)
            set id = I2S(pid)
            call StoreInteger(DrCache, id, "1", PlayerKillHerosCount[pid])
            call StoreInteger(DrCache, id, "2", PlayerHeroDeathCount[pid])
            call StoreInteger(DrCache, id, "3", PlayerCreepLastHitCount[pid])
            call StoreInteger(DrCache, id, "4", PlayerCreepDenyCount[pid])
            call StoreInteger(DrCache, id, "5", PlayerAssistCount[pid])
            call StoreInteger(DrCache, id, "6", GetPlayerState((p), PLAYER_STATE_RESOURCE_GOLD))
            call StoreInteger(DrCache, id, "7", LoadInteger(HY, 400 + pid, 79))
            call StoreInteger(DrCache, id, "8_0", GetItemTypeId(UnitItemInSlot(PlayerHeroes[pid], 0)))
            call StoreInteger(DrCache, id, "8_1", GetItemTypeId(UnitItemInSlot(PlayerHeroes[pid], 1)))
            call StoreInteger(DrCache, id, "8_2", GetItemTypeId(UnitItemInSlot(PlayerHeroes[pid], 2)))
            call StoreInteger(DrCache, id, "8_3", GetItemTypeId(UnitItemInSlot(PlayerHeroes[pid], 3)))
            call StoreInteger(DrCache, id, "8_4", GetItemTypeId(UnitItemInSlot(PlayerHeroes[pid], 4)))
            call StoreInteger(DrCache, id, "8_5", GetItemTypeId(UnitItemInSlot(PlayerHeroes[pid], 5)))
            call StoreInteger(DrCache, id, "9", PlayerHeroTypeId[pid])
            call StoreInteger(DrCache, id, "id", i + 5)
            if LocalPlayer== HostPlayer then
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(SentinelPlayers[i])), "1")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(SentinelPlayers[i])), "2")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(SentinelPlayers[i])), "3")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(SentinelPlayers[i])), "4")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(SentinelPlayers[i])), "5")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(SentinelPlayers[i])), "6")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(SentinelPlayers[i])), "7")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(SentinelPlayers[i])), "8_0")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(SentinelPlayers[i])), "8_1")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(SentinelPlayers[i])), "8_2")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(SentinelPlayers[i])), "8_3")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(SentinelPlayers[i])), "8_4")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(SentinelPlayers[i])), "8_5")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(SentinelPlayers[i])), "9")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(SentinelPlayers[i])), "id")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(ScourgePlayers[i])), "1")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(ScourgePlayers[i])), "2")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(ScourgePlayers[i])), "3")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(ScourgePlayers[i])), "4")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(ScourgePlayers[i])), "5")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(ScourgePlayers[i])), "6")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(ScourgePlayers[i])), "7")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(ScourgePlayers[i])), "8_0")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(ScourgePlayers[i])), "8_1")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(ScourgePlayers[i])), "8_2")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(ScourgePlayers[i])), "8_3")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(ScourgePlayers[i])), "8_4")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(ScourgePlayers[i])), "8_5")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(ScourgePlayers[i])), "9")
                call SyncStoredInteger(DrCache, I2S(GetPlayerId(ScourgePlayers[i])), "id")
            endif
            set i = i + 1
        endloop
        call StoreInteger(DrCache, "Global", "WinnerIndex", WinnerIndex)
        call StoreInteger(DrCache, "Global", "m", minute)
        call StoreInteger(DrCache, "Global", "s", second)
        if LocalPlayer == HostPlayer then
            call SyncStoredInteger(DrCache, "Global", "WinnerIndex")
            call SyncStoredInteger(DrCache, "Global", "m")
            call SyncStoredInteger(DrCache, "Global", "s")
        endif
        set p = null
    endfunction

    function GetUnitVictoryAnimation takes unit u returns string
        local integer unitTypeId = GetUnitTypeId(u)
        local integer i = 1
        loop
        exitwhen i > VictoryAnimationListNumber
            if VictoryAnimationListTypeId[i] == unitTypeId then
                return VictoryAnimationString[i]
            endif
            set i = i + 1
        endloop
        return "stand"
    endfunction
    function SetUnitVictoryAnimation takes unit u returns nothing
        if GetUnitTypeId(u) =='N01I' then
            call SetUnitAnimationByIndex(u, 6)
        else
            call SetUnitAnimation(u, GetUnitVictoryAnimation(u))
        endif
        //call QueueUnitAnimation(u, "stand")
    endfunction
    function SetAllUnitVictoryAnimation takes nothing returns nothing
        local group  g             = AllocationGroup(51)
        local unit   firstUnit     = null
        local player victoryPlayer = null

        if WinnerIndex == 1 then
            set victoryPlayer = SentinelPlayers[0]
        elseif WinnerIndex == 2 then
            set victoryPlayer = ScourgePlayers[0]
        endif

        call GroupEnumUnitsInRange(g, 0, 0, 12000, null)
        loop
            set firstUnit = FirstOfGroup(g)
            exitwhen firstUnit == null
            call GroupRemoveUnit(g, firstUnit)

            if IsUnitAlly(firstUnit, victoryPlayer) and (IsAliveNotStrucNotWard(firstUnit)) and IsNotAncientOrBear(firstUnit) and not IsUnitOwnedByPlayer(firstUnit, NeutralCreepPlayer) then
                call SetUnitVictoryAnimation(firstUnit)
            endif
            
        endloop

        call DeallocateGroup(g)
        set g = null
    endfunction

    function GameEndAction takes nothing returns nothing
        local integer i = 1
        local player p
        set bj_changeLevelShowScores = true
        call DisableTrigger(FrozenThroneDeathTrig)
        call DisableTrigger(WorldTreeDeathTrig)
        if IsGameHaveObserver then
            call DisableTrigger(FXV)
        endif
        call DisableTrigger(EQV)
        call ClearTextMessages()
        call DisplayTimedTextToAllPlayer(bj_FORCE_ALL_PLAYERS, 60, VictoryTeamName + " " + GetObjectName('n054')+ " QQ讨论群1064025490")
        set IsGameEnd = true
        call SuspendTimeOfDay(true)
        call GameEndPauseAllUnit()
        call SetAllUnitVictoryAnimation()
        call DisableTrigger(SpawnAttackCreepTrigger)
        call DisableTrigger(UpdateMainMultiboardTrig)
        call DisableTrigger(AddGoldForIntervalTrig)
        call GameEndStoreChacheData()
    endfunction

endscope
