
scope Creeps

    //***************************************************************************
    //*
    //*  震荡波
    //*
    //***************************************************************************
    private struct CShockWave extends array
        
        real    damage

        static method OnCollide takes Shockwave sw, unit targ returns boolean
            // 敌对存活非魔免非无敌非守卫非建筑
            if UnitAlive(targ) and IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) and not IsUnitMagicImmune(targ) and not IsUnitInvulnerable(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                call UnitDamageTargetEx(sw.owner, targ, 1, thistype(sw).damage)
            endif
            return false
        endmethod
        
        implement ShockwaveStruct
    endstruct

    // 野怪萨特震荡波
    function CreepShockwaveOnSpellEffect takes nothing returns nothing
        local unit      whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local unit      targUnit  = GetSpellTargetUnit()
        local real      x = GetUnitX(whichUnit)
        local real      y = GetUnitY(whichUnit)
        local real      tx
        local real      ty
        local real      angle
        local Shockwave sw

        local integer   level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real      distance  = 800. + GetUnitCastRangeBonus(whichUnit)

        call BJDebugMsg("GetAbilityOrder('A1OV'):" + GetAbilityOrder('A1OV'))
        call BJDebugMsg("GetAbilityOrder('A0O5'):" + GetAbilityOrder('A0O5'))
        if targUnit == null then
            set tx = GetSpellTargetX()
            set ty = GetSpellTargetY()
            set angle = RadianBetweenXY(x, y, tx, ty)
        else
            set tx = GetUnitX(targUnit)
            set ty = GetUnitY(targUnit)
            if targUnit == whichUnit then
                set angle = GetUnitFacing(whichUnit) * bj_DEGTORAD
            else
                set angle = RadianBetweenXY(x, y, tx, ty)
            endif
            set targUnit = null
        endif

        set sw = Shockwave.CreateByDistance(whichUnit, x, y, angle, distance)
        call sw.SetSpeed(1050.)
        set sw.minRadius = 180.
        set sw.maxRadius = 200.
        set sw.model     = "Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl"
        set CShockWave(sw).damage = 125
        call CShockWave.Launch(sw)
    endfunction

endscope
