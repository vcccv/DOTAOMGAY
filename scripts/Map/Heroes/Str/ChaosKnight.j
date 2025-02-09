
scope ChaosKnight

    //***************************************************************************
    //*
    //*  混沌之军
    //*
    //***************************************************************************

    function PhantasmOnSpellEffect takes nothing returns nothing
        local unit 	  whichUnit 	= GetTriggerUnit()
        local integer level			= GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local integer max
        local real    damageDealt
        local real    damageTaken
        local integer buffId
        local real 	  dur
        local real 	  delay
        local string  specialArt
        local string  missileArt
        local real 	  missileSpeed
        local real 	  rng
        local real 	  area

        set max		     = level + GetRandomInt(0, 1)
        set damageDealt  = 1.0
        set damageTaken  = 2.25
        set buffId       = 'Bcki'
        set dur			 = 34.
        set delay		 = 0.5
        set missileSpeed = 1000
        set rng		     = 128.
        set area		 = 1000.
        set specialArt   = "war3mapImported\\MirrorImageCKCaster_7.mdx"
        set missileArt   = "Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageMissile.mdl"
        if not IsUnitType(whichUnit, UNIT_TYPE_MELEE_ATTACKER) then
            set damageDealt = 0.80
            set damageTaken = 2.50
            call SetUnitAbilityLevelCooldown(whichUnit, GetSpellAbility(), level, 100.)
        else
            call SetUnitAbilityLevelCooldown(whichUnit, GetSpellAbility(), level, 80.)
        endif

        call UnitMirrorImage(whichUnit, max, damageDealt, damageTaken, buffId, dur, delay, specialArt, missileArt, missileSpeed, rng, area)
        //if UnitHasSpellShield() then
        //	call DLO()
        //endif
        set whichUnit = null
    endfunction

endscope
