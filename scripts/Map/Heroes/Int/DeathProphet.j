
scope DeathProphet

    //***************************************************************************
    //*
    //*  食腐蝠群
    //*
    //***************************************************************************
    private struct CarrionSwarm extends array

        real damage

        static method OnCollide takes Shockwave sw, unit targ returns boolean
            // 敌对存活非魔免非无敌非守卫非建筑
            if UnitAlive(targ) and IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) and not IsUnitMagicImmune(targ) and not IsUnitInvulnerable(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                call UnitDamageTargetEx(sw.owner, targ, 1, thistype(sw).damage)
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\CarrionSwarm\\CarrionSwarmDamage.mdl", targ, "origin"))
                //call sw.EnableHitAfter(targ, 0.12)
            endif
            return false
        endmethod
        
        implement ShockwaveStruct
    endstruct

    function CarrionSwarmOnSpellEffect takes nothing returns nothing
        local unit      whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local unit      targUnit  = GetSpellTargetUnit()
        local real      x = GetUnitX(whichUnit)
        local real      y = GetUnitY(whichUnit)
        local real      tx
        local real      ty
        local real      angle
        local Shockwave sw

        local integer level    = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real    distance = 810. + GetUnitCastRangeBonus(whichUnit)
        local real    damage

        if level == 1 then
            set damage = 100
        elseif level == 2 then
            set damage = 175
        elseif level == 3 then
            set damage = 250
        else
            set damage = 300
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
        call sw.SetSpeed(1100.)
        set sw.minRadius = 110.
        set sw.maxRadius = 300.
        set sw.model = "Abilities\\Spells\\Undead\\CarrionSwarm\\CarrionSwarmMissile.mdl"
        //call sw.FixTimeScale(0.033 + 1.166)
        set CarrionSwarm(sw).damage = damage
        call CarrionSwarm.Launch(sw)

        set whichUnit = null
    endfunction

endscope
