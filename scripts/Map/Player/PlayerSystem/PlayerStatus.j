
library PlayerStatus requires PlayerSystem

    // 是ob玩家
    function IsObserverPlayerEx takes player p returns boolean
        return GameHasObservers and(ObserverPlayer1 == p or ObserverPlayer2 == p)
    endfunction
    // 近卫
    function IsPlayerSentinel takes player p returns boolean
        return(p == SentinelPlayers[0]) or(p == SentinelPlayers[1]) or(p == SentinelPlayers[2]) or(p == SentinelPlayers[3]) or(p == SentinelPlayers[4]) or(p == SentinelPlayers[5])
    endfunction
    // 天灾
    function IsPlayerScourge takes player p returns boolean
        return(p == ScourgePlayers[0]) or(p == ScourgePlayers[1]) or(p == ScourgePlayers[2]) or(p == ScourgePlayers[3]) or(p == ScourgePlayers[4]) or(p == ScourgePlayers[5])
    endfunction
    // 有效玩家，近卫或天灾 不管是否在线和有人
    function IsPlayerValid takes player p returns boolean
        return p == SentinelPlayers[1]or p == SentinelPlayers[2]or p == SentinelPlayers[3]or p == SentinelPlayers[4]or p == SentinelPlayers[5]or p == ScourgePlayers[1]or p == ScourgePlayers[2]or p == ScourgePlayers[3]or p == ScourgePlayers[4]or p == ScourgePlayers[5]
    endfunction
    // 用户玩家
    function IsPlayerUser takes player p returns boolean
        return((GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING or GetPlayerSlotState(p) == PLAYER_SLOT_STATE_LEFT) and GetPlayerController(p) == MAP_CONTROL_USER) or(LOD_DEBUGMODE and p != SentinelPlayers[0]and p != ScourgePlayers[0])
    endfunction
    // 离线玩家
    function IsPlayerOffline takes player p returns boolean
        return GetPlayerSlotState(p) == PLAYER_SLOT_STATE_LEFT and GetPlayerController(p) == MAP_CONTROL_USER
    endfunction
    // 在线玩家
    function IsPlayerPlaying takes player p returns boolean
        return GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController(p) == MAP_CONTROL_USER
    endfunction

endlibrary

