library UnitUtils
    
    function UnitAddPermanentAbility takes unit whichUnit, integer ab returns boolean
        return UnitAddAbility(whichUnit, ab) and UnitMakeAbilityPermanent(whichUnit, true, ab)
    endfunction

    function UnitAddPermanentAbilitySetLevel takes unit whichUnit, integer id, integer level returns nothing
        if GetUnitAbilityLevel(whichUnit, id) == 0 then
            call UnitAddPermanentAbility(whichUnit, id)
        endif
        call SetUnitAbilityLevel(whichUnit, id, level)
    endfunction

    function StartUnitAbilityCooldown takes unit whichUnit, integer abilId returns boolean
        local integer level = GetUnitAbilityLevel(whichUnit, abilId)
        local real cooldown = MHAbility_GetCustomLevelDataReal(whichUnit, abilId, level, ABILITY_LEVEL_DEF_DATA_COOLDOWN)
        if level == 0 then
            return false
        endif
        call MHAbility_SetCooldown(whichUnit, abilId, cooldown)
        return true 
    endfunction

    function GetUnitCollisionSize takes unit whichUnit returns real
        return MHUnit_GetDefDataReal(GetUnitTypeId(whichUnit), UNIT_DEF_DATA_COLLISION)
    endfunction
    
    function UnitDodgeMissile takes unit whichUnit returns nothing
        local boolean b
        set b = IsUnitSelected(whichUnit, User.Local)
        call ShowUnit(whichUnit, false)
        call ShowUnit(whichUnit, true)
        if b then
            call SelectUnit(whichUnit, true)
        endif
    endfunction
    
endlibrary
