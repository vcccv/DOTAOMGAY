
scope AntiBackdoor

    globals
        group AntiBackdoorStructuresGroup = null
    endglobals

    function AddUnitToAntiBackdoorGroup takes unit u returns nothing
        local integer h = GetHandleId(u)
        call GroupAddUnit(AntiBackdoorStructuresGroup, u)
        if GetOwningPlayer(u) == SentinelPlayers[0] then
            call SaveRectHandle(P, h, 'ABDr'+ 0, Rect(-8160.,-8192.,-3712.,-4352.))
            call SaveRectHandle(P, h, 'ABDr'+ 1, Rect(-8192.,-4960.,-4640.,-3552.))
            call SaveRectHandle(P, h, 'ABDr'+ 2, Rect(-4000.,-7744.,-3072.,-5152.))
            call SaveRectHandle(P, h, 'ABDr'+ 3, Rect(-3328.,-7200.,-2464.,-6368.))
            call SaveRectHandle(P, h, 'ABDr'+ 4, Rect(-4288.,-4544.,-3424.,-3712.))
            call SaveRectHandle(P, h, 'ABDr'+ 5, Rect(-6784.,-3616.,-5920.,-2784.))
        else 
            call SaveRectHandle(P, h, 'ABDr'+ 0, Rect(2304., 4064., 8032., 7776.))
            call SaveRectHandle(P, h, 'ABDr'+ 1, Rect(4640., 1952., 8000., 4384.))
            call SaveRectHandle(P, h, 'ABDr'+ 2, Rect(3136., 2816., 5216., 4960.))
            call SaveRectHandle(P, h, 'ABDr'+ 3, Rect(5984., 1152., 6848., 1984.))
            call SaveRectHandle(P, h, 'ABDr'+ 4, Rect(1472., 5440., 2336., 6272.))
            call SaveRectHandle(P, h, 'ABDr'+ 5, Rect(2656., 2336., 3520., 3168.))
        endif
    endfunction

    function AntiBackdoorReduceDamage takes unit u, unit damageSource, real damageValue returns nothing
        local real ratio = .25
        if Mode__AntiBackdoor then
            set ratio = 1.
        endif
        call SetWidgetLife(u, GetWidgetLife(u) + ratio * damageValue)
    endfunction

    function StructuresAntiBackdoorAction takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local integer h = GetHandleId(u)
        if GetTriggerEventId() == EVENT_UNIT_DAMAGED then
            if GetUnitAbilityLevel(u,'A17R') == 0 then // 塔防状态？
                // 处于防偷塔状态 敌人攻击
                if LoadBoolean(P, h, 'isBD') and IsUnitEnemy(u, GetOwningPlayer(GetEventDamageSource())) then
                    call AntiBackdoorReduceDamage(u, GetEventDamageSource(), GetEventDamage())
                else // 非防偷塔状态 或者友军攻击 记录已经受到的合法伤害
                    call SaveReal(P, h, 'DMGR', LoadReal(P, h, 'DMGR') + GetEventDamage())
                endif
            endif
        else
            call FlushChildHashtable(P, h)
            call GroupRemoveUnit(AntiBackdoorStructuresGroup, u)
        endif
        set u = null
    endfunction

    globals
        constant real STRUCTURE_MAX_REGENERATION = 90
    endglobals
    function AntiBackdoorRegenerationEnumAction takes nothing returns nothing
        local unit u = GetEnumUnit()
        local integer h = GetHandleId(u)
        local real life
        local real realLife
        if h == 0 or UnitIsDead(u) or GetUnitState(u, UNIT_STATE_MAX_LIFE) == GetWidgetLife(u) then
            return
        endif
        set life = GetWidgetLife(u)
        set realLife = GetUnitState(u, UNIT_STATE_MAX_LIFE) - LoadReal(P, h,'DMGR') // 最大生命值减去合法伤害 = 最终回复的血量
        if life <= realLife then
            if life + STRUCTURE_MAX_REGENERATION <= realLife then
                call SetWidgetLife(u, life + STRUCTURE_MAX_REGENERATION)
            else
                call SetWidgetLife(u, realLife)
            endif
        endif
        set u = null
    endfunction
    function AntiBackdoorRegenerationLoopAction takes nothing returns nothing
        call ForGroup(AntiBackdoorStructuresGroup, function AntiBackdoorRegenerationEnumAction)
    endfunction

    function UpdateStructureBackdoorState takes unit u returns nothing
        local integer h
        local rect    r
        local group   g
        local unit    firstUnit = null
        local boolean b         = false
        local player  p         = SentinelPlayers[0]
        local integer i         = 0
        if UnitIsDead(u) then
            return
        endif
        set h = GetHandleId(u)
        set g = AllocationGroup(45)
        if IsUnitOwnedByPlayer(u, SentinelPlayers[0]) then
            set p = ScourgePlayers[0]
        endif
        loop
            set r = LoadRectHandle(P, h, 'ABDr'+ i)
            call GroupEnumUnitsInRect(g, r, null)
            loop
                set firstUnit = FirstOfGroup(g)
            exitwhen firstUnit == null
                call GroupRemoveUnit(g, firstUnit)
                if GetUnitTypeId(firstUnit)!='hFFD' then
                    set b = IsUnitOwnedByPlayer(firstUnit, p)
                    exitwhen b
                endif
            endloop
            set i = i + 1
        exitwhen b or HaveSavedHandle(P, h, 'ABDr'+ i) == false
        endloop
        call SaveBoolean(P, h, 'isBD', b == false)
        call DeallocateGroup(g)
        set firstUnit = null
        set g = null
        set r = null
    endfunction    
    function CheckBackdoorLoopAction takes nothing returns nothing
        local unit u
        local group g = AllocationGroup(46)
        call GroupAddGroup(AntiBackdoorStructuresGroup, g)
        loop
            set u = FirstOfGroup(g)
        exitwhen u == null
            call UpdateStructureBackdoorState(u)
            call GroupRemoveUnit(g, u)
        endloop
        call DeallocateGroup(g)
        set g = null
        set u = null
    endfunction

    function AntiBackdoor_Init takes nothing returns nothing
        local trigger t = null
        set t = CreateTrigger()
        call TriggerAddCondition(t, Condition(function StructuresAntiBackdoorAction))
        call TriggerRegisterUnitEvent(t, SentinleTopTowerLevel2, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, SentinleTopTowerLevel2, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, SentinleMidTowerLevel2, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, SentinleMidTowerLevel2, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, SentinleBotTowerLevel2, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, SentinleBotTowerLevel2, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, SentinleTopTowerLevel3, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, SentinleTopTowerLevel3, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, SentinleMidTowerLevel3, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, SentinleMidTowerLevel3, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, SentinleBotTowerLevel3, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, SentinleBotTowerLevel3, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, SentinleLeftTowerLevel4, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, SentinleLeftTowerLevel4, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, SentinleRightTowerLevel4, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, SentinleRightTowerLevel4, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, SentinelTopMeleeRaxUnit, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, SentinelTopMeleeRaxUnit, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, SentinelMidMeleeRaxUnit, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, SentinelMidMeleeRaxUnit, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, SentinelBotMeleeRaxUnit, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, SentinelBotMeleeRaxUnit, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, SentinelTopRangedRaxUnit, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, SentinelTopRangedRaxUnit, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, SentinelMidRangedRaxUnit, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, SentinelMidRangedRaxUnit, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, SentinelBotRangedRaxUnit, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, SentinelBotRangedRaxUnit, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, ScourgeTopTowerLevel2, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, ScourgeTopTowerLevel2, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, ScourgeMidTowerLevel2, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, ScourgeMidTowerLevel2, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, ScourgeBotTowerLevel2, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, ScourgeBotTowerLevel2, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, ScourgeTopTowerLevel3, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, ScourgeTopTowerLevel3, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, ScourgeMidTowerLevel3, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, ScourgeMidTowerLevel3, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, ScourgeBotTowerLevel3, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, ScourgeBotTowerLevel3, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, ScourgeLeftTowerLevel4, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, ScourgeLeftTowerLevel4, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, ScourgeRightTowerLevel4, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, ScourgeRightTowerLevel4, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, ScourgeTopMeleeRaxUnit, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, ScourgeTopMeleeRaxUnit, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, ScourgeMidMeleeRaxUnit, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, ScourgeMidMeleeRaxUnit, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, ScourgeBotMeleeRaxUnit, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, ScourgeBotMeleeRaxUnit, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, ScourgeTopRangedRaxUnit, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, ScourgeTopRangedRaxUnit, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, ScourgeMidRangedRaxUnit, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, ScourgeMidRangedRaxUnit, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, ScourgeBotRangedRaxUnit, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, ScourgeBotRangedRaxUnit, EVENT_UNIT_DEATH)

        set AntiBackdoorStructuresGroup = CreateGroup()

        set t = CreateTrigger()
        call TriggerRegisterTimerEvent(t, 1, true)
        call TriggerAddCondition(t, Condition(function AntiBackdoorRegenerationLoopAction))

        // 防偷塔判定
        set t = CreateTrigger()
        call TriggerRegisterTimerEvent(t, 5, true)
        call TriggerAddCondition(t, Condition(function CheckBackdoorLoopAction))
    endfunction

endscope