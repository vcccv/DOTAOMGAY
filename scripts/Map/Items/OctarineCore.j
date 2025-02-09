
scope OctarineCore

    //***************************************************************************
    //*
    //*  玲珑心
    //*
    //***************************************************************************
    function ItemOctarineCoreOnPickup takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
         
        if not IsUnitHeroLevel(whichUnit) then
            set whichUnit = null
        endif

        call UpdateUnitAbilityCooldown(whichUnit)

        set whichUnit = null
    endfunction
    function DelayUpdateUnitAbilityCooldownOnExpired takes nothing returns nothing
        local SimpleTick tick = SimpleTick.GetExpired()

        call UpdateUnitAbilityCooldown(SimpleTickTable[tick].unit['u'])

        call tick.Destroy()
    endfunction
    function ItemOctarineCoreOnDrop takes nothing returns nothing
        local unit       whichUnit = Event.GetTriggerUnit()
        local SimpleTick tick
        
        if not IsUnitHeroLevel(whichUnit) then
            set whichUnit = null
        endif

        set tick = SimpleTick.CreateEx()
        call tick.Start(0., false, function DelayUpdateUnitAbilityCooldownOnExpired)
        set SimpleTickTable[tick].unit['u'] = whichUnit
        call UpdateUnitAbilityCooldown(whichUnit)

        set whichUnit = null
    endfunction

endscope
