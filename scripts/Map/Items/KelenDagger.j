
scope KelenDagger

    //***************************************************************************
    //*
    //*  科勒的匕首
    //*
    //***************************************************************************
    function ItemKelenDaggerOnSpellChannel takes nothing returns nothing
        local unit    whichUnit = GetTriggerUnit()
        local integer level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real    value     = MHAbility_GetLevelDefDataReal(GetSpellAbilityId(), level, ABILITY_LEVEL_DEF_DATA_DATA_A)
        call MHAbility_SetAbilityCustomLevelDataReal(GetSpellAbility(), level, ABILITY_LEVEL_DEF_DATA_DATA_A, value + GetUnitCastRangeBonus(whichUnit))
        set whichUnit = null
    endfunction
    
    globals
        private AnyUnitEvent ItemKelenDaggerOnDamaged = 0
    endglobals

    function ItemKelenDaggerOnPickup takes nothing returns nothing
        set KelenDaggerCount = KelenDaggerCount + 1
        if KelenDaggerCount == 1 then
            
        endif
        
        call BJDebugMsg("我拿了KelenDaggerCount：" + I2S(KelenDaggerCount))
    endfunction

    function ItemKelenDaggerOnDrop takes nothing returns nothing
        set KelenDaggerCount = KelenDaggerCount - 1
        if KelenDaggerCount == 0 then
            call ItemKelenDaggerOnDamaged.Destroy()
        endif
        call BJDebugMsg("我丢了KelenDaggerCount：" + I2S(KelenDaggerCount))
    endfunction

endscope
