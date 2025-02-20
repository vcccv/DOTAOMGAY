
scope NagaSiren

    //***************************************************************************
    //*
    //*  镜像
    //*
    //***************************************************************************
    function MirrorImageOnSpellEffect takes nothing returns nothing
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

        set max		     = 3
        set damageDealt  = 0.25 + level * 0.05
        set damageTaken  = 7.00 - level * 1.
        set buffId       = 'Bngi'
        set dur			 = 30.
        set delay		 = 0.3
        set missileSpeed = 1000
        set rng		     = 128.
        set area		 = 1000.
        set specialArt   = "war3mapImported\\NagaSirenMirrorImage_4.mdx"
        set missileArt   = "Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageMissile.mdl"
        if not IsUnitType(whichUnit, UNIT_TYPE_MELEE_ATTACKER) then
            set damageDealt = 0.20 + level * 0.05
            set damageTaken = 7.50 - level * 1.
            call SetUnitAbilityLevelCooldown(whichUnit, GetSpellAbility(), level, 50.)
        else
            call SetUnitAbilityLevelCooldown(whichUnit, GetSpellAbility(), level, 40.)
        endif

        call UnitMirrorImage(whichUnit, max, damageDealt, damageTaken, buffId, dur, delay, specialArt, missileArt, missileSpeed, rng, area)
        set whichUnit = null
    endfunction

endscope
