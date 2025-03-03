
scope Gyrocopter

    globals
        constant integer HERO_INDEX_GRYOCOPTER = 48
    endglobals

    //***************************************************************************
    //*
    //*  侧面机枪
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_FLAKCANNON        = GetHeroSKillIndexBySlot(HERO_INDEX_GRYOCOPTER, 3)
        constant integer FLAKCANNON_UPGRADE_ABILITY_ID = 'A3UR'
    endglobals

    function FlakCannonScepterUpgradeOnUpdate takes nothing returns nothing
        local SimpleTick tick      = SimpleTick.GetExpired()
        local unit       whichUnit = SimpleTickTable[tick].unit['u']
        local player     p    
        local real       x
        local real       y
        local group      enumGroup
        local group      targGroup
        local unit       first     = null
        local real       area      = 700.

        // 自己非隐身非破坏非隐藏
        if UnitAlive(whichUnit) and IsUnitScepterUpgraded(whichUnit) /*
            */ and not IsUnitCloaked(whichUnit) /*
            */ and not IsUnitHidden(whichUnit) and not IsUnitBroken(whichUnit) then

            set enumGroup = AllocationGroup(79912)
            set targGroup = AllocationGroup(79913)

            set x = GetUnitX(whichUnit)
            set y = GetUnitY(whichUnit)
            set p = GetOwningPlayer(whichUnit)

            call GroupEnumUnitsInRange(enumGroup, x, y, area + MAX_UNIT_COLLISION, null)
            loop
                set first = FirstOfGroup(enumGroup)
                exitwhen first == null
                call GroupRemoveUnit(enumGroup, first)

                // 敌对 存活 非守卫
                if UnitAlive(first) and IsUnitInRangeXY(first, x, y, area) and IsUnitEnemy(first, p)/*
                    */ and not IsUnitWard(first) and not IsUnitCourier(first) then
                    call GroupAddUnit(targGroup, first)
                endif

            endloop

            loop
                set first = GroupPickRandomUnit(targGroup)
                exitwhen first == null
                call GroupRemoveUnit(targGroup, first)

                // 可见，非虚无，非无敌
                if IsUnitVisibleToPlayer(first, p) and not IsUnitEthereal(first) and not IsUnitInvulnerable(first) then
                    call UnitLaunchAttack(whichUnit, first)
                    call StartAbilityCooldownAbsoluteEx(GetUnitAbility(whichUnit, FLAKCANNON_UPGRADE_ABILITY_ID), 1.5)
                    exitwhen true
                endif
                
            endloop

            call DeallocateGroup(enumGroup)
            call DeallocateGroup(targGroup)
        endif

        set whichUnit = null
    endfunction

    function FlakCannonUpgradeAbilityOnAdd takes nothing returns nothing
        local unit       whichUnit    = Event.GetTriggerUnit()
        local ability    whichAbility = Event.GetTriggerAbility()
        local SimpleTick tick

        set tick = SimpleTick.CreateEx()
        call tick.Start(1.5, true, function FlakCannonScepterUpgradeOnUpdate)
        set SimpleTickTable[tick].unit['u'] = whichUnit
        // 父key unit 子key ability
        set Table[GetHandleId(whichAbility)].integer[GetHandleId(whichUnit)] = tick

        set whichAbility = null
        set whichUnit    = null
    endfunction

    function FlakCannonUpgradeAbilityOnRemove takes nothing returns nothing
        local unit       whichUnit    = Event.GetTriggerUnit()
        local ability    whichAbility = Event.GetTriggerAbility()
        local SimpleTick tick         = Table[GetHandleId(whichAbility)].integer[GetHandleId(whichUnit)]

        call tick.Destroy()

        call Table[GetHandleId(whichAbility)].integer.remove(GetHandleId(whichUnit))

        set whichAbility = null
        set whichUnit    = null
    endfunction

    function FlakcannonOnInitializer takes nothing returns nothing
        call ResgiterAbilityMethodSimple(FLAKCANNON_UPGRADE_ABILITY_ID, "FlakCannonUpgradeAbilityOnAdd", "FlakCannonUpgradeAbilityOnRemove")
    endfunction

    function FlakCannonOnGetScepterUpgrade takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        if not UnitAddPermanentAbility(whichUnit, FLAKCANNON_UPGRADE_ABILITY_ID) then
            call UnitDisableAbility(whichUnit, FLAKCANNON_UPGRADE_ABILITY_ID, false, true)
        endif
        set whichUnit = null
    endfunction
    function FlakCannonOnLostScepterUpgrade takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        call UnitDisableAbility(whichUnit, FLAKCANNON_UPGRADE_ABILITY_ID, true, true)
        set whichUnit = null
    endfunction

endscope
