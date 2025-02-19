
scope Lina

    //***************************************************************************
    //*
    //*  龙破斩
    //*
    //***************************************************************************
    private struct DragonSlave extends array
        
        real damage

        static method OnCollide takes Shockwave sw, unit targ returns boolean
            // 敌对存活非魔免非无敌非守卫非建筑
            if UnitAlive(targ) and IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) and not IsUnitMagicImmune(targ) and not IsUnitInvulnerable(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                call UnitDamageTargetEx(sw.owner, targ, 1, thistype(sw).damage)
            endif
            return false
        endmethod
        
        implement ShockwaveStruct
    endstruct

    function DragonSlaveOnSpellEffect takes nothing returns nothing
        local unit      whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local unit      targUnit  = GetSpellTargetUnit()
        local real      x = GetUnitX(whichUnit)
        local real      y = GetUnitY(whichUnit)
        local real      tx
        local real      ty
        local real      angle
        local Shockwave sw

        local integer level    = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real    distance = 1075. + GetUnitCastRangeBonus(whichUnit)
        local real    damage

        if level == 1 then
            set damage = 110
        elseif level == 2 then
            set damage = 180
        elseif level == 3 then
            set damage = 275
        else
            set damage = 320
        endif

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
        call sw.SetSpeed(1200.)
        set sw.minRadius = 275.
        set sw.maxRadius = 200.
        set sw.model = "units\\human\\phoenix\\phoenix.mdl"
        set DragonSlave(sw).damage = damage
        call DragonSlave.Launch(sw)

        set whichUnit = null
    endfunction

endscope
