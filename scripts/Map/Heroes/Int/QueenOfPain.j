
scope QueenOfPain

    //***************************************************************************
    //*
    //*  闪烁
    //*
    //***************************************************************************
    function QopBlinkOnSpellChannel takes nothing returns nothing
        local unit    whichUnit = GetTriggerUnit()
        local integer level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real    value     = MHAbility_GetLevelDefDataReal(GetSpellAbilityId(), level, ABILITY_LEVEL_DEF_DATA_DATA_A)
        call MHAbility_SetAbilityCustomLevelDataReal(GetSpellAbility(), level, ABILITY_LEVEL_DEF_DATA_DATA_A, value + GetUnitCastRangeBonus(whichUnit))
        set whichUnit = null
    endfunction

    //***************************************************************************
    //*
    //*  超声冲击波
    //*
    //***************************************************************************
    private struct SonicWave extends array
        
        real damage

        static method OnCollide takes Shockwave sw, unit targ returns boolean
            // 敌对存活非无敌非守卫非建筑
            if UnitAlive(targ) and IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) and not IsUnitInvulnerable(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                call UnitDamageTargetEx(sw.owner, targ, 7, thistype(sw).damage)
            endif
            return false
        endmethod
        
        implement ShockwaveStruct

    endstruct

    function SonicWaveOnSpellEffect takes nothing returns nothing
        local unit      whichUnit = GetRealSpellUnit(GetTriggerUnit())
        //local unit      targUnit  = GetSpellTargetUnit()
        local real      x = GetUnitX(whichUnit)
        local real      y = GetUnitY(whichUnit)
        local real      tx
        local real      ty
        local real      angle
        local Shockwave sw

        local integer level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real    distance  = 900. + GetUnitCastRangeBonus(whichUnit)
        local real    damage    = 200. + 90. * level
        local boolean isUpgrade = GetSpellAbilityId() == 'A28S'

        if isUpgrade then
            set damage = 325
            if GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId()) == 3 then
                set damage = 555
            elseif GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId()) == 2 then
                set damage = 440
            endif
        endif

        set tx = GetSpellTargetX()
        set ty = GetSpellTargetY()
        if x == tx and y == ty then
            set angle = GetUnitFacing(whichUnit) * bj_DEGTORAD
        else
            set angle = RadianBetweenXY(x, y, tx, ty)
        endif
  
        set sw = Shockwave.CreateByDistance(whichUnit, x, y, angle, distance)
        call sw.SetSpeed(1200.)
        set sw.minRadius = 100.
        set sw.maxRadius = 450.
        set sw.model = "effects\\SonicBreathStream.mdx"
        set SonicWave(sw).damage = damage
        call SonicWave.Launch(sw)

        set whichUnit = null
    endfunction

endscope
