
scope Tidehunter

    //***************************************************************************
    //*
    //*  巨浪
    //*
    //***************************************************************************
    private struct GushWave extends array
        
        real    damage
        integer level

        static method OnCollide takes Shockwave sw, unit targ returns boolean
            local integer i
            // 敌对存活非魔免非无敌非守卫非建筑
            if UnitAlive(targ) and IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) and not IsUnitMagicImmune(targ) and not IsUnitInvulnerable(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                call DestroyEffect(AddSpecialEffectTarget("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl", targ, "origin"))
                call UnitDamageTargetEx(sw.owner, targ, 1, thistype(sw).damage)
                call UnitAddAbilityToTimed(targ,'A3JR', thistype(sw).level, 4, 0)
                call UnitAddAbilityToTimed(targ,'A3JS', 1, 4,'B3JS')
            endif
            return false
        endmethod

        implement ShockwaveStruct
    endstruct

    function GushMissileOnHit takes nothing returns nothing
        local unit whichUnit = TempUnit
        local unit targetUnit = MissileHitTargetUnit
        local integer level = GetUnitAbilityLevel(whichUnit,'A046')
        call DestroyEffect(AddSpecialEffectTarget("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl", targetUnit, "chest"))
        call UnitAddAbilityToTimed(targetUnit,'A3JR', level, 4, 0)
        call UnitAddAbilityToTimed(targetUnit,'A3JS', 1, 4,'B3JS')
        call UnitDamageTargetEx(whichUnit, targetUnit, 1, 60. + level * 50.)
        set whichUnit = null
        set targetUnit = null
    endfunction
    function GushOnSpellEffect takes nothing returns nothing
        local unit      whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local unit      targUnit  = GetSpellTargetUnit()
        local real      x         = GetUnitX(whichUnit)
        local real      y         = GetUnitY(whichUnit)
        local real      tx
        local real      ty
        local real      angle
        local Shockwave sw

        local integer level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local boolean isUpgrade = GetSpellAbilityId() == 'A3OH'
        local real    distance  = 1200. + GetUnitCastRangeBonus(whichUnit)
        local real    damage

        if not isUpgrade then
            if not UnitHasSpellShield(targUnit) then
                call LaunchMissileByUnitDummy(whichUnit, targUnit, 'h0EN', "GushMissileOnHit", 4000, false)
            endif
        else
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
            call sw.SetSpeed(1500.)
            call sw.SetModelScale(2.0)
            set sw.modelScale = 2.0
            set sw.minRadius  = 240.
            set sw.maxRadius  = 240.
            set sw.model = "war3mapImported\\GushAoE.mdl"
            set GushWave(sw).damage = 60 + 50 * level
            set GushWave(sw).level = level
            call GushWave.Launch(sw)
        endif

        set whichUnit = null
    endfunction

endscope
