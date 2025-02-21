
scope OctarineCore

    //***************************************************************************
    //*
    //*  玲珑心
    //*
    //***************************************************************************
    function DelayUnitUpdateAbilityCooldownOnExpired takes nothing returns nothing
        local SimpleTick tick = SimpleTick.GetExpired()

        call UnitUpdateAbilityCooldown(SimpleTickTable[tick].unit['u'])

        call tick.Destroy()
    endfunction
    function ItemOctarineCoreOnPickup takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        
        if not IsUnitHeroLevel(whichUnit) then
            set whichUnit = null
            return
        endif

        call UnitUpdateAbilityCooldown(whichUnit)

        set whichUnit = null
    endfunction
    function ItemOctarineCoreOnDrop takes nothing returns nothing
        local unit       whichUnit = Event.GetTriggerUnit()
        local SimpleTick tick
        
        if not IsUnitHeroLevel(whichUnit) then
            set whichUnit = null
            return
        endif

        set tick = SimpleTick.CreateEx()
        call tick.Start(0., false, function DelayUnitUpdateAbilityCooldownOnExpired)
        set SimpleTickTable[tick].unit['u'] = whichUnit
        call UnitUpdateAbilityCooldown(whichUnit)

        set whichUnit = null
    endfunction

endscope
