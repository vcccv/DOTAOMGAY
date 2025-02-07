
scope Broodmother

    //***************************************************************************
    //*
    //*  织网
    //*
    //***************************************************************************
    function SpinWebOnSpellEffect takes nothing returns nothing
        local player  p
        local unit    trigUnit
        local unit    webUnit
        local integer level
        local integer max
        local integer count

        local group   g
        local unit    first

        set trigUnit = GetTriggerUnit()
        set p        = GetOwningPlayer(trigUnit)
        set level    = GetUnitAbilityLevel(trigUnit, GetSpellAbilityId())
        set max      = level * 2
        set count    = GetPlayerTechCount(p, 'o003', false)

        if count > max then
            set g = AllocationGroup(1777)
            call GroupEnumUnitsOfPlayer(g, p, null)
            loop
                set first = FirstOfGroup(g)
                exitwhen first == null
                call GroupRemoveUnit(g, first)
                
                if GetUnitTypeId(first) == 'o003' and UnitAlive(first) then
                    call KillUnit(first)
                    set first = null
                    exitwhen true
                endif
            endloop
            set g = null
        endif
        set webUnit = CreateUnit(p, 'o003', GetSpellTargetX(), GetSpellTargetY(), 0)
        
        call SetUnitAnimation(webUnit, "birth")
        call QueueUnitAnimation(webUnit, "stand")
        call SetUnitVertexColorBJ(webUnit, 100, 100, 100, 85)
        call SetUnitAbilityLevel(webUnit, 'A0BF', level)
        call UnitAddAbility(webUnit, 'Aloc')
        call UnitAddInvulnerableCount(webUnit)
        
        if User.Local != p then
            call UnitAddCantSelectCount(webUnit)
        endif
        set webUnit = null
    endfunction

    function SpinWebOnUpdate takes nothing returns nothing
        local SimpleTick tick       = SimpleTick.GetExpired()
        local unit       sourceUnit = SimpleTickTable[tick].unit['u']
       // local group      lastGroup  = SimpleTickTable[tick].unit['g']
        local group      g          
        local unit       first
        local player     p          = GetOwningPlayer(sourceUnit)
        local real       x          = GetUnitX(sourceUnit)
        local real       y          = GetUnitY(sourceUnit)
        local real       area       = 900.
        local integer    level      = GetUnitAbilityLevel(sourceUnit, 'A0BF')

        if not UnitAlive(sourceUnit) then
           // call DeallocateGroup(lastGroup)
            call tick.Destroy()
            return
        endif

        set g = AllocationGroup(1977)
        call GroupEnumUnitsInRange(g, x, y, area + MAX_UNIT_COLLISION, null)
        loop
            set first = FirstOfGroup(g)
            exitwhen first == null
            call GroupRemoveUnit(g, first)

            if IsUnitInRangeXY(first, x, y, area) and UnitAlive(first)    /*
                */ and not IsUnitWard(first) and not IsUnitCourier(first) /*
                */ and not IsUnitStructure(first) and IsUnitOwnedByPlayer(first, p) then
                if MHBuff_GetLevel(first, 'B01G') == 0 then
                    call UnitAddAreaBuff(sourceUnit, first, 'B01G', level, 0.3 + 0.15, true)
                else
                    call MHBuff_SetRemain(first, 'B01G', 0.3 + 0.15)
                endif
            endif
        endloop

        call DeallocateGroup(g)
    endfunction

    globals
        private key SPIN_WEB_TICK
    endglobals


    private function SpinWebOnDebuffExpired takes nothing returns nothing
        local SimpleTick tick = SimpleTick.GetExpired()

        call UnitAddNoPathingCount(SimpleTickTable[tick].unit['u'])
        call Table[GetHandleId(DETarget)].remove(SPIN_WEB_TICK)
        //call BJDebugMsg("SpinWebOnDebuffExpired")

        call tick.Destroy()
    endfunction

    function BroodmotherSpinWebOnDamaged takes nothing returns nothing
        local SimpleTick tick
        if DEDamage > 0 and MHBuff_GetLevel(DETarget, 'B01G') > 0 then
            set tick = Table[GetHandleId(DETarget)][SPIN_WEB_TICK]
            if tick == 0 then
                set tick = SimpleTick.CreateEx()
                set SimpleTickTable[tick].unit['u'] = DETarget
                set Table[GetHandleId(DETarget)][SPIN_WEB_TICK] = tick
                call UnitSubNoPathingCount(DETarget)
                call UnitModifyPostion(DETarget)
                call KillTreeByCircle(GetUnitX(DETarget), GetUnitY(DETarget), 150.)
                //call BJDebugMsg("受伤了 失去无视地形状态")
            endif
            call tick.Start(6., false, function SpinWebOnDebuffExpired)
        endif
    endfunction

    function BroodmotherSpinWebBuffOnAdd takes nothing returns nothing
        local unit       whichUnit = MHEvent_GetUnit()
        local SimpleTick tick
        
        call UnitRemoveAbility(whichUnit, 'A40E')
        call UnitAddPermanentAbility(whichUnit, 'A021')

        if ( GetUnitLastDamagedTime(whichUnit) + 6. ) < ( GameTimer.GetElapsed() ) then
            call UnitAddNoPathingCount(whichUnit)
           //call BJDebugMsg("没受伤 添加了" + R2S(GetUnitLastDamagedTime(whichUnit)))
        else
            set tick = SimpleTick.CreateEx()
            set SimpleTickTable[tick].unit['u'] = DETarget
            set Table[GetHandleId(DETarget)][SPIN_WEB_TICK] = tick
           //call BJDebugMsg("受伤了 开始计时器:" + R2S(( GetUnitLastDamagedTime(whichUnit) + 6. ) - GameTimer.GetElapsed()))
            call tick.Start(( GetUnitLastDamagedTime(whichUnit) + 6. ) - GameTimer.GetElapsed(), false, function SpinWebOnDebuffExpired)
        endif

        set whichUnit = null
    endfunction

    function BroodmotherSpinWebBuffOnRemove takes nothing returns nothing
        local unit       whichUnit = MHEvent_GetUnit()
        local SimpleTick tick

        call UnitRemoveAbility(whichUnit, 'A021')
        call UnitRemoveAbility(whichUnit, 'B01C')

        set tick = Table[GetHandleId(whichUnit)][SPIN_WEB_TICK]
        if tick == 0 then
            call UnitSubNoPathingCount(whichUnit)
            call UnitModifyPostion(whichUnit)
            call KillTreeByCircle(GetUnitX(whichUnit), GetUnitY(whichUnit), 150.)
            //call BJDebugMsg("失去buff，移除无视地形状态")
        else
            call tick.Destroy()
            call Table[GetHandleId(whichUnit)].remove(SPIN_WEB_TICK)
            //call BJDebugMsg("失去buff，移除计时器")
        endif

        set whichUnit = null
    endfunction

    function SpinWebOnEnter takes nothing returns nothing
        local SimpleTick tick

        set tick = SimpleTick.CreateEx()
        call tick.Start(0.3, true, function SpinWebOnUpdate)

        set SimpleTickTable[tick].unit['u']  = GetTriggerUnit()
    endfunction

    private function OnEnter takes nothing returns nothing
        if GetUnitTypeId(GetTriggerUnit())=='o003' then
            call SpinWebOnEnter()
        endif
    endfunction

    // 蜘蛛网
    function BroodmotherSpinWeb_Init takes nothing returns nothing
        local trigger t = CreateTrigger()
        call YDWETriggerRegisterEnterRectSimpleNull(t, GetWorldBounds())
        call TriggerAddCondition(t, Condition(function OnEnter))
        
        call SetAbilityAddAction('B01G', "BroodmotherSpinWebBuffOnAdd")
        call SetAbilityRemoveAction('B01G', "BroodmotherSpinWebBuffOnRemove")

        call AnyUnitEvent.CreateEvent(ANY_UNIT_EVENT_DAMAGED, function BroodmotherSpinWebOnDamaged)
    endfunction
    
endscope
