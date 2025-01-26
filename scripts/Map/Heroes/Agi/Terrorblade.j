
scope Terrorblade

    //***************************************************************************
    //*
    //*  魔法镜像
    //*
    //***************************************************************************
    function ConjureImageOnSpellEffect takes nothing returns nothing
        local unit    whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local integer level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real    angle     = GetUnitFacing(whichUnit) * bj_DEGTORAD
        local real    vel       = GetUnitCollisionSize(whichUnit) * 0.5 + 64.
        local real    x         = GetUnitX(whichUnit) + vel * Cos(angle)
        local real    y         = GetUnitY(whichUnit) + vel * Sin(angle)
        local unit    illusionUnit
        local real    damageDealt
        local real    damageTaken
        local real    duration

        set damageDealt = 0.2 + 0.1 * level
        set damageTaken = 3.0
        set duration    = 32.
        if not IsUnitType(whichUnit, UNIT_TYPE_RANGED_ATTACKER) then
            set damageDealt = 0.1 + 0.1 * level
            set damageTaken = 3.5
            call MHAbility_SetAbilityCustomLevelDataReal(GetSpellAbility(), level, ABILITY_LEVEL_DEF_DATA_COOLDOWN, 18.)
        else
            call MHAbility_SetAbilityCustomLevelDataReal(GetSpellAbility(), level, ABILITY_LEVEL_DEF_DATA_COOLDOWN, 16.)
        endif
        set illusionUnit = CreateIllusion(GetOwningPlayer(whichUnit), whichUnit, damageDealt, damageTaken, x, y, 'BTci', duration)
        call SetUnitVertexColor(illusionUnit, 150, 150, 150, 200) 

        set illusionUnit = null
        set whichUnit = null
    endfunction
    
endscope
