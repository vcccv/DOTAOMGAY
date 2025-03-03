
scope DragonKnight

    //***************************************************************************
    //*
    //*  火焰气息
    //*
    //***************************************************************************
    private struct BreatheFire extends array
        
        real    damage
        integer level

        static method OnCollide takes Shockwave sw, unit targ returns boolean
            local integer i
            // 敌对存活非魔免非无敌非守卫非建筑
            if UnitAlive(targ) and IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) and not IsUnitMagicImmune(targ) and not IsUnitInvulnerable(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                call UnitDamageTargetEx(sw.owner, targ, 1, thistype(sw).damage)
                // 待优化 魔法书套耐久光环傻卵操作
                set i = thistype(sw).level
                call UnitAddAbilityToTimed(targ, 'A3KW'-1 + i, 1, 11, 'B387')
                call UnitMakeAbilityPermanent(targ, true, 'A3KS'-1 + i)
                call SetPlayerAbilityAvailable(GetOwningPlayer(targ), 'A3KW'-1 + i, false)
            endif
            return false
        endmethod

        implement ShockwaveStruct
    endstruct

    function BreatheFireOnSpellEffect takes nothing returns nothing
        local unit      whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local unit      targUnit  = GetSpellTargetUnit()
        local real      x = GetUnitX(whichUnit)
        local real      y = GetUnitY(whichUnit)
        local real      tx
        local real      ty
        local real      angle
        local Shockwave sw

        local integer level    = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real    distance = 650. + GetUnitCastRangeBonus(whichUnit)
        local real    damage

        if level == 1 then
            set damage = 90
        elseif level == 2 then
            set damage = 170
        elseif level == 3 then
            set damage = 240
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
        set sw = Shockwave.CreateFromUnit(whichUnit, angle, distance)
        call sw.SetSpeed(1050.)
        call sw.FixTimeScale(0.5)
        set sw.minRadius = 150.
        set sw.maxRadius = 250.
        set sw.model = "Abilities\\Spells\\Other\\BreathOfFire\\BreathOfFireMissile.mdl"
        set BreatheFire(sw).damage = damage
        set BreatheFire(sw).level = level
        call BreatheFire.Launch(sw)

        set whichUnit = null
    endfunction

endscope
