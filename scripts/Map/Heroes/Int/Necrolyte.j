
scope Necrolyte

    //***************************************************************************
    //*
    //*  竭心光环
    //*
    //***************************************************************************
    function YZI takes nothing returns nothing
        local unit targetUnit = GetEnumUnit()
        local real hp  = GetWidgetLife(targetUnit)-1
        local real Y_I = GetUnitState(targetUnit, UNIT_STATE_MAX_LIFE)
        local real damageValue = .003 * level * Y_I / 2
        call UnitDamageTargetEx(MNV, targetUnit, 11, damageValue)
        set targetUnit = null
    endfunction
    
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
        if UnitAlive(whichUnit) and not IsUnitBreak(whichiUnit) then
            set g = AllocationGroup(366)
            set level = GetUnitAbilityLevel(whichUnit,'P302')+ 1

            set x = GetUnitX(whichUnit)
            set y = GetUnitY(whichUnit)
            call GroupEnumUnitsInRange(g, x, y, area + MAX_UNIT_COLLISION, Condition(function Y0I))

            loop
                set first = FirstOfGroup(g)
                exitwhen first == null
                call GroupRemoveUnit(g)

                if UnitAlive(first) and IsUnitInRange(first, x, y, area) and IsUnitEnemy(whichUnit, GetOwningPlayer(first)) /*
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
