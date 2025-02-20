
scope Necrolyte

    //***************************************************************************
    //*
    //*  竭心光环
    //*
    //***************************************************************************
    function HeartstopperAuraOnUpdate takes nothing returns nothing
        local integer h         = GetHandleId(GetExpiredTimer())
        local unit    whichUnit = LoadUnitHandle(HY, h, 'A01N')
        local group   g
        local real    x
        local real    y
        local real    area      = 1200
        local unit    first
        local integer level
        local real    hp
        local real    max
        if UnitAlive(whichUnit) and not IsUnitBroken(whichUnit) then
            set g = AllocationGroup(366)
            set level = GetUnitAbilityLevel(whichUnit,'P302')+ 1

            set x = GetUnitX(whichUnit)
            set y = GetUnitY(whichUnit)
            call GroupEnumUnitsInRange(g, x, y, area + MAX_UNIT_COLLISION, null)

            loop
                set first = FirstOfGroup(g)
                exitwhen first == null
                call GroupRemoveUnit(g, first)

                if UnitAlive(first) and IsUnitInRangeXY(first, x, y, area) and IsUnitEnemy(whichUnit, GetOwningPlayer(first)) /*
                    */ and IsAliveNotStrucNotWard(first) and IsNotAncientOrBear(first) then
                    set hp  = GetWidgetLife(first) - 1.
                    set max = GetUnitState(first, UNIT_STATE_MAX_LIFE)
                    call UnitDamageTargetEx(whichUnit, first, 11, .003 * ( level * 1. ) * max / 2)
                endif

            endloop
            call DeallocateGroup(g)
        endif
        set g = null
        set whichUnit = null
    endfunction
    function HeartstopperAuraOnLearn takes nothing returns nothing
        local timer t = CreateTimer()
        call TimerStart(t, .5, true, function HeartstopperAuraOnUpdate)
        call SaveUnitHandle(HY, GetHandleId(t), 'A01N', GetTriggerUnit())
        set t = null
    endfunction

endscope
