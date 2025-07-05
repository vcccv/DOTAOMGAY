
scope Mirana

    globals
        constant integer HERO_INDEX_MIRANA    = 40
    endglobals

    //***************************************************************************
    //*
    //*  群星坠落
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_STARFALL = GetHeroSKillIndexBySlot(HERO_INDEX_MIRANA, 1)
        constant integer STARFALL_UPGRADE_ABILITY_ID = 'A3UF'
    endglobals
    private function DelayDamageOnExpired takes nothing returns nothing
        local SimpleTick tick        = SimpleTick.GetExpired()
        local unit       whichUnit   = SimpleTickTable[tick].unit['u']
        local group      targetGroup = SimpleTickTable[tick].group['g']
        local real       damageValue = SimpleTickTable[tick].real['d']
        local unit       first

        loop
            set first = FirstOfGroup(targetGroup)
            exitwhen first == null
            call GroupRemoveUnit(targetGroup, first)

            if UnitAlive(first) then
                call UnitDamageTargetEx(whichUnit, first, 1, damageValue)
            endif

        endloop

        call DeallocateGroup(targetGroup)
        call tick.Destroy()

        set whichUnit = null
    endfunction

    private function ExtraStartfallOnExpired takes nothing returns nothing
        local SimpleTick tick        = SimpleTick.GetExpired()
        local unit       whichUnit   = SimpleTickTable[tick].unit['u']
        local unit       targetUnit  = SimpleTickTable[tick].unit['t']
        local real       damageValue = SimpleTickTable[tick].real['d']
        local unit       first
        local real       minDistance = 99999.
        local real       distance
        local group      g
        local real       area = 425.
        local real       x
        local real       y

        if tick.data == 1 then
            if targetUnit == null or not UnitAlive(targetUnit) then
                set x = GetUnitX(whichUnit)
                set y = GetUnitY(whichUnit)
                set g = AllocationGroup(218)
                loop
                    set first = FirstOfGroup(g)
                    exitwhen first == null
                    call GroupRemoveUnit(g, first)

                    if IsUnitInRangeXY(first, x, y, area) and UnitAlive(first) /*
                        */ and IsUnitEnemy(whichUnit, GetOwningPlayer(first)) /*
                        */ and not IsUnitStructure(first) and not IsUnitWard(first) /*
                        */ and IsUnitVisibleToPlayer(first, GetOwningPlayer(first)) then
        
                        set distance = GetDistanceBetween(GetUnitX(first), GetUnitY(first), x, y)
                        if distance < minDistance then
                            set targetUnit  = first
                            set minDistance = distance
                        endif
                        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl", first, "origin"))
        
                    endif

                endloop
                call DeallocateGroup(g)
            endif

            call DestroyEffect(SimpleTickTable[tick].effect['e'])
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl", targetUnit, "origin"))
            set SimpleTickTable[tick].unit['t'] = targetUnit
            set tick.data = 2
            call tick.Start(0.5, false, function ExtraStartfallOnExpired)
        elseif tick.data == 2 then
            call UnitDamageTargetEx(whichUnit, targetUnit, 1, damageValue)
            call tick.Destroy()
        endif

        set targetUnit = null
        set whichUnit  = null
    endfunction

    function StarfallOnEffectStart takes unit whichUnit returns nothing
        local trigger t     = CreateTrigger()
        local integer h     = GetHandleId(t)
        local integer level = GetUnitAbilityLevel(whichUnit, 'A0KV') + GetUnitAbilityLevel(whichUnit, 'A3UG')
        local real    minDistance = 99999.
        local real    distance
        local unit    closestUnit = null
        local unit    first 
        local group   g     
        local group   targetGroup
        local real    area
        local real    x
        local real    y
        local real    damageValue
        local SimpleTick delayTick
        local SimpleTick extraStartfallTick

        set damageValue = level * 75.

        set g           = AllocationGroup(218)
        set targetGroup = AllocationGroup(219)
        set x           = GetUnitX(whichUnit)
        set y           = GetUnitY(whichUnit)
        set area        = 650.
        call GroupEnumUnitsInRange(g, x, y, area + MAX_UNIT_COLLISION, null)
        loop
            set first = FirstOfGroup(g)
            exitwhen first == null
            call GroupRemoveUnit(g, first)

            if IsUnitInRangeXY(first, x, y, area) and UnitAlive(first) /*
                */ and IsUnitEnemy(whichUnit, GetOwningPlayer(first)) /*
                */ and not IsUnitStructure(first) and not IsUnitWard(first) /*
                */ and IsUnitVisibleToPlayer(first, GetOwningPlayer(whichUnit)) then

                if IsUnitInRangeXY(first, x, y, 425.) then
                    set distance = GetDistanceBetween(GetUnitX(first), GetUnitY(first), x, y)
                    if distance < minDistance then
                        set closestUnit = first
                        set minDistance = distance
                    endif
                endif
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl", first, "origin"))
                call GroupAddUnit(targetGroup, first)

            endif
            
        endloop
        call DeallocateGroup(g)

        set delayTick = SimpleTick.CreateEx()
        call delayTick.Start(0.5, false, function DelayDamageOnExpired)
        set SimpleTickTable[delayTick].real['d']  = damageValue
        set SimpleTickTable[delayTick].unit['u']  = whichUnit
        set SimpleTickTable[delayTick].group['g'] = targetGroup

        set extraStartfallTick = SimpleTick.Create(1)
        call extraStartfallTick.Start(1., false, function ExtraStartfallOnExpired)
        set SimpleTickTable[extraStartfallTick].unit['u'] = whichUnit
        set SimpleTickTable[extraStartfallTick].unit['t'] = closestUnit
        set SimpleTickTable[extraStartfallTick].real['d'] = damageValue * 0.75
        set SimpleTickTable[extraStartfallTick].effect['e'] = AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl", whichUnit, "origin")

        set t = null
        set g = null
        set closestUnit = null
        set whichUnit = null
    endfunction
    function StarfallOnSpellEffect takes nothing returns nothing
        call StarfallOnEffectStart(GetTriggerUnit())
    endfunction

    function StarfallUpgradedOnUpdate takes nothing returns nothing
        local SimpleTick tick      = SimpleTick.GetExpired()
        local unit       whichUnit = SimpleTickTable[tick].unit['u']
        local group      g
        local unit       first
        local real       x
        local real       y
        local real       area
        local integer    count
        
        if UnitAlive(whichUnit) and IsUnitScepterUpgraded(whichUnit) /*
            */ and GetUnitAbilityCooldownRemaining(whichUnit, STARFALL_UPGRADE_ABILITY_ID) == 0. /*
            */ and ( ( GetUnitAbilityLevel(whichUnit,'A0KV') + GetUnitAbilityLevel(whichUnit,'A3UG') ) > 0 ) /*
            */ and not IsUnitBroken(whichUnit) then

            set g     = AllocationGroup(220)
            set x     = GetUnitX(whichUnit)
            set y     = GetUnitY(whichUnit)
            set area  = 650.
            set count = 0

            call GroupEnumUnitsInRange(g, x, y, area + MAX_UNIT_COLLISION, null)
            loop
                set first = FirstOfGroup(g)
                exitwhen first == null
                call GroupRemoveUnit(g, first)

                if IsUnitInRangeXY(first, x, y, area) and UnitAlive(first) /*
                    */ and IsUnitEnemy(whichUnit, GetOwningPlayer(first)) /*
                    */ and not IsUnitStructure(first) and not IsUnitWard(first) /*
                    */ and IsUnitVisibleToPlayer(first, GetOwningPlayer(whichUnit)) then

                    set count = count + 1
                    
                endif
                
            endloop

            if count > 0 then
                call StartUnitAbilityCooldown(whichUnit, STARFALL_UPGRADE_ABILITY_ID)
                call StarfallOnEffectStart(whichUnit)
            endif

            call DeallocateGroup(g)
        endif

        set whichUnit = null
    endfunction

    function StarfallUpgradeAbilityOnAdd takes nothing returns nothing
        local unit       whichUnit    = Event.GetTriggerUnit()
        local ability    whichAbility = Event.GetTriggerAbility()
        local SimpleTick tick

        set tick = SimpleTick.CreateEx()
        call tick.Start(1., true, function StarfallUpgradedOnUpdate)
        set SimpleTickTable[tick].unit['u'] = whichUnit
        // 父key unit 子key ability
        set Table[GetHandleId(whichAbility)].integer[GetHandleId(whichUnit)] = tick

        set whichAbility = null
        set whichUnit    = null
    endfunction

    function StarfallUpgradeAbilityOnRemove takes nothing returns nothing
        local unit       whichUnit    = Event.GetTriggerUnit()
        local ability    whichAbility = Event.GetTriggerAbility()
        local SimpleTick tick         = Table[GetHandleId(whichAbility)].integer[GetHandleId(whichUnit)]

        call tick.Destroy()

        call Table[GetHandleId(whichAbility)].integer.remove(GetHandleId(whichUnit))

        set whichAbility = null
        set whichUnit    = null
    endfunction

    function StarfallOnGetScepterUpgrade takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        if not UnitAddPermanentAbility(whichUnit, STARFALL_UPGRADE_ABILITY_ID) then
            call UnitEnableAbility(whichUnit, STARFALL_UPGRADE_ABILITY_ID, true)
        endif
        set whichUnit = null
    endfunction
    function StarfallOnLostScepterUpgrade takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        call UnitDisableAbility(whichUnit, STARFALL_UPGRADE_ABILITY_ID, true)
        set whichUnit = null
    endfunction


    //***************************************************************************
    //*
    //*  跳跃
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_LEAP = GetHeroSKillIndexBySlot(HERO_INDEX_MIRANA, 3)
    endglobals
    function ZAR takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer h = GetHandleId(t)
        local unit trigUnit = LoadUnitHandle(HY, h, 14)
        local real ZNR = LoadReal(HY, h, 212)
        local real ZBR = LoadReal(HY, h, 213)
        local real a = LoadReal(HY, h, 13)
        local real targetX = GetUnitX(trigUnit) + 30 * Cos(a * bj_DEGTORAD)
        local real targetY = GetUnitY(trigUnit) + 30 * Sin(a * bj_DEGTORAD)
        local real ZCR = 200
        local real ZDR =(1 -ZNR / ZBR)* ZCR * 2
        if ZDR > ZCR then
            set ZDR = ZCR * 2 -ZDR
        endif
        if IsUnitModelFlying(trigUnit) == false then
            call SetUnitFlyHeight(trigUnit, GetUnitDefaultFlyHeight(trigUnit) + RMaxBJ(ZDR, 0), 0)
        endif
        if IsUnitType(trigUnit, UNIT_TYPE_HERO) then
            call SaveBoolean(OtherHashTable, GetHandleId(trigUnit), 99, true)
        endif
        call SetUnitX(trigUnit, CoordinateX50(targetX))
        call SetUnitY(trigUnit, CoordinateY50(targetY))
        call EXSetUnitFacing(trigUnit, a)
        call SaveReal(HY, h, 212,(ZNR -20)* 1.)
        if ZDR < 1 and ZNR -ZBR != 0 then
            call SaveBoolean(HY, GetHandleId(trigUnit), 214, false)
            call EXSetUnitFacing(trigUnit, a)
            call SetUnitAnimation(trigUnit, "stand")
            call UnitDecNoPathingCount(trigUnit)
            //call ZER(trigUnit) 也许想让单位恢复动作
            if IsUnitModelFlying(trigUnit) == false then
                call SetUnitFlyHeight(trigUnit, GetUnitDefaultFlyHeight(trigUnit), 0)
            endif
            call PauseTimer(t)
            call FlushChildHashtable(HY, h)
            call DestroyTimer(t)
        endif
        set t = null
        set trigUnit = null
    endfunction
    function MiranaLeapOnSpellEffect takes nothing returns nothing
        local unit trigUnit = GetTriggerUnit()
        local integer level = GetUnitAbilityLevel(trigUnit,('A0LN'))
        local real distance = 350 + 50 * level
        local real a = GetUnitFacing(trigUnit)
        local real sx = GetUnitX(trigUnit)
        local real sy = GetUnitY(trigUnit)
        local real tx = CoordinateX50(sx + distance * Cos(a * bj_DEGTORAD))
        local real ty = CoordinateY50(sy + distance * Sin(a * bj_DEGTORAD))
        local timer t = CreateTimer()
        local integer h = GetHandleId(t)
        local trigger ZFR = LoadTriggerHandle(HY, GetHandleId(trigUnit), 204)
        set distance = SquareRoot((sx -tx)*(sx -tx) +(sy -ty)*(sy -ty))
        call ShowUnit(trigUnit, false)
        call ShowUnit(trigUnit, true)
        if LocalPlayer== GetOwningPlayer(trigUnit) then
            call ClearSelection()
            call SelectUnit(trigUnit, true)
        endif
        if distance > 100 then
            call UnitAddPermanentAbility(trigUnit,'Amrf')
            call UnitRemoveAbility(trigUnit,'Amrf')
            call UnitIncNoPathingCount(trigUnit)
            call DisableTrigger(ZFR)
            call IssueImmediateOrderById(trigUnit, 851972)
            call EnableTrigger(ZFR)
            call SaveReal(HY, h, 212, distance * 1.)
            call SaveReal(HY, h, 213, distance * 1.)
            call SaveReal(HY, h, 13, a * 1.)
            call SaveUnitHandle(HY, h, 14, trigUnit)
            call TimerStart(t, .025, true, function ZAR)
            call SaveBoolean(HY, GetHandleId(trigUnit), 214, true)
            call SaveBoolean(HY, GetHandleId(trigUnit), 208, false)
            call ZVR(trigUnit, level)
        endif
        set trigUnit = null
        set t = null
        set ZFR = null
    endfunction

endscope
