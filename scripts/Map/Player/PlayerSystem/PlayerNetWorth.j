
library PlayerNetWorthLib requires PlayerSystem, PlayerStatus, Base

    globals
        private trigger NetWorthUpdateTrig
        integer array PlayerLastItemTotalGoldCost
        boolean array PlayerItemTotalGoldCostDirty
    endglobals

    private function SetCircleUnitNetWorthTextTag takes integer networth, unit circleUnit returns nothing
        local texttag tt
        local integer h
        local integer hu = GetHandleId(circleUnit)
        local integer id = GetPlayerId(GetOwningPlayer(circleUnit))
        if HaveSavedHandle(HY, hu, 'netw') then
            set tt = LoadTextTagHandle(HY, hu, 'netw')
        else
            set tt = CreateTextTag()
            call SetTextTagPosUnit(tt, circleUnit, 0)
            call SetTextTagVelocity(tt, 0, 0)
            call SetTextTagPermanent(tt, true)
            call SaveTextTagHandle(HY, hu, 'netw', tt)
        endif
        call SetTextTagText(tt, I2S(networth), .025)
        call SetTextTagVisibility(tt, IsUnitAlly(circleUnit, LocalPlayer) or IsObserverPlayerEx(LocalPlayer))
        // 能否买活
        if GetBuybackGoldCostByLevel(GetHeroLevel(PlayerHeroes[id]))* 50 + 50 > GetPlayerState(GetOwningPlayer(circleUnit), PLAYER_STATE_RESOURCE_GOLD) or UF[id]or W4[id]=='h0D4' then
            call SetTextTagColor(tt, 255, 75, 0, 255)
        else
            call SetTextTagColor(tt, 255, 220, 0, 255)
        endif
        set tt = null
    endfunction

    private function OnUpdate takes nothing returns nothing
        local integer i = 1
        local integer pid
        local player p
        local integer gold
        loop
            set gold = 0
            set p = SentinelPlayers[i]
            if IsPlayerUser(p) then
                set pid = GetPlayerId(p)
                if PlayerItemTotalGoldCostDirty[pid] then // PlayerItemTotalGoldCostDirty
                    if PlayerHeroes[pid]!= null then
                        set gold = gold + GetUnitAllItemsGoldCost(PlayerHeroes[pid])
                        set gold = gold + GetUnitAllItemsGoldCost(CirclesUnit[pid])
                    endif
                    if HaveSavedHandle(HY, GetHandleId(p), 333) then // 小鸡的装备
                        set gold = gold + GetUnitAllItemsGoldCost(LoadUnitHandle(HY, GetHandleId(p), 333))
                    endif
                    set gold = gold + PlayerExtraNetWorth[pid] // A杖资产
                    set PlayerItemTotalGoldCostDirty[pid] = false
                    set PlayerLastItemTotalGoldCost[pid] = gold
                else
                    set gold = PlayerLastItemTotalGoldCost[pid] // PlayerLastItemTotalGoldCost
                endif
                set RI[pid] = gold + GetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD)
                call SetCircleUnitNetWorthTextTag(RI[pid], CirclesUnit[pid])
            endif
            set gold = 0
            set p = ScourgePlayers[i]
            if IsPlayerUser(p) then
                set pid = GetPlayerId(p)
                if PlayerItemTotalGoldCostDirty[pid] then
                    if PlayerHeroes[pid]!= null then
                        set gold = gold + GetUnitAllItemsGoldCost(PlayerHeroes[pid])
                        set gold = gold + GetUnitAllItemsGoldCost(CirclesUnit[pid])
                    endif
                    if HaveSavedHandle(HY, GetHandleId(p), 333) then
                        set gold = gold + GetUnitAllItemsGoldCost(LoadUnitHandle(HY, GetHandleId(p), 333))
                    endif
                    set gold = gold + PlayerExtraNetWorth[pid]
                    set PlayerItemTotalGoldCostDirty[pid] = false
                    set PlayerLastItemTotalGoldCost[pid] = gold
                else
                    set gold = PlayerLastItemTotalGoldCost[pid]
                endif
                set RI[pid] = gold + GetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD)
                call SetCircleUnitNetWorthTextTag(RI[pid], CirclesUnit[pid])
            endif
            set i = i + 1
        exitwhen i > 5
        endloop
    endfunction

    // TextTag
    function PlayerNetWorth_Init takes nothing returns nothing 
        set NetWorthUpdateTrig = CreateTrigger()
        call TriggerRegisterTimerEvent(NetWorthUpdateTrig, 1., true)
        call TriggerAddCondition(NetWorthUpdateTrig, Condition(function OnUpdate))
    endfunction

endlibrary
