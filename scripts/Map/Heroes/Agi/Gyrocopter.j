
scope Gyrocopter

    //***************************************************************************
    //*
    //*  侧面机枪
    //*
    //***************************************************************************
    #define FLAKCANNON_UPGRADE_ABILITY_ID 'A3UR'
    function FlakCannonScepterUpgradeOnUpdate takes nothing returns nothing
        local trigger trig = GetTriggeringTrigger()
        local integer h    = GetHandleId(trig)
        local unit    u    = LoadUnitHandle(HY, h, 0)
        local player  p    
        local real    x
        local real    y
        local group   enumGroup
        local group   targGroup
        local unit    first = null
        local real    area  = 700.

        if UnitAlive(u) and GetUnitAbilityLevel(u, FLAKCANNON_UPGRADE_ABILITY_ID) > 0 and not IsUnitCloaked(u) and not IsUnitHidden(u) and not IsUnitBroken(u) then
            set enumGroup = AllocationGroup(79912)
            set targGroup = AllocationGroup(79913)

            set x = GetUnitX(u)
            set y = GetUnitY(u)
            set p = GetOwningPlayer(u)

            call GroupEnumUnitsInRange(enumGroup, x, y, area + MAX_UNIT_COLLISION, null)
            loop
                set first = FirstOfGroup(enumGroup)
                exitwhen first == null
                call GroupRemoveUnit(enumGroup, first)

                if UnitAlive(first) and IsUnitInRangeXY(first, x, y, area) and IsUnitEnemy(first, p) and not IsUnitWard(first) then
                    call GroupAddUnit(targGroup, first)
                endif

            endloop

            loop
                set first = GroupPickRandomUnit(targGroup)
                exitwhen first == null
                call GroupRemoveUnit(targGroup, first)

                if IsUnitVisible(first, p) and not IsUnitEthereal(first) and not IsUnitInvulnerable(first) then
                    call UnitLaunchAttack(u, first)
                    call StartAbilityCooldownAbsoluteEx(GetUnitAbility(u, FLAKCANNON_UPGRADE_ABILITY_ID), 1.5)
                    exitwhen true
                endif
                
            endloop

            call DeallocateGroup(enumGroup)
            call DeallocateGroup(targGroup)
        endif

        set u    = null
        set trig = null
    endfunction

    function FlakCannonOnGetScepterUpgrade takes nothing returns nothing
        local unit 	  u = TempUnit
        local trigger trig 
        local integer h
        call UnitAddPermanentAbility(u, FLAKCANNON_UPGRADE_ABILITY_ID)
        if not HaveSavedHandle(HY, GetHandleId(u), FLAKCANNON_UPGRADE_ABILITY_ID)then
            set trig = CreateTrigger()
            set h = GetHandleId(trig)
            call TriggerAddCondition(trig, Condition(function FlakCannonScepterUpgradeOnUpdate))
            call TriggerRegisterTimerEvent(trig, 1.5, true)
            call SaveTriggerHandle(HY, GetHandleId(u), FLAKCANNON_UPGRADE_ABILITY_ID, trig)
            call SaveUnitHandle(HY, h, 0, u)
            call SetPlayerAbilityAvailable(GetOwningPlayer(u), FLAKCANNON_UPGRADE_ABILITY_ID, true)
            set trig = null
        endif
        set u = null
    endfunction
    function FlakCannonOnLostScepterUpgrade takes nothing returns nothing
        local unit u = TempUnit
        
        set u = null
    endfunction

endscope
