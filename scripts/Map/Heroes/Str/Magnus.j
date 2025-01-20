
scope Magnus

    //***************************************************************************
    //*
    //*  震荡波
    //*
    //***************************************************************************
    private struct MShockWaveR extends array
        
        real damage

        static method OnCollide takes Shockwave sw, unit targ returns boolean
            // 敌对存活非魔免非无敌非守卫非建筑
            if UnitAlive(targ) and IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) and not IsUnitMagicImmune(targ) and not IsUnitInvulnerable(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                if not IsHeroUnitId(GetUnitTypeId(targ)) then
                    call UnitDamageTargetEx(sw.owner, targ, 1, thistype(sw).damage * 0.5)
                else
                    call UnitDamageTargetEx(sw.owner, targ, 1, thistype(sw).damage)
                endif
                call UnitAddAbilityToTimed(targ,'A3Y9', 1, 0.4,'a3Y9')
            endif
            return false
        endmethod
        
        implement ShockwaveStruct
    endstruct

    
    private struct MShockWave extends array
        
        real damage
        boolean isUpgrade

        static method OnRemove takes Shockwave sw returns boolean
            set thistype(sw).isUpgrade = false
            return true
        endmethod

        static method OnFinish takes Shockwave sw returns boolean
            local Shockwave new
            if not thistype(sw).isUpgrade then
                return true
            endif
            
            set new = Shockwave.CreateByDistance(sw.owner, sw.x, sw.y, sw.angle + 180. * bj_DEGTORAD, sw.distance)
            call new.SetSpeed(sw.speed)
            call new.SetColor(255, 100, 0, 255)
            set new.minRadius = sw.minRadius
            set new.maxRadius = sw.maxRadius
            set new.model     = sw.model
            set MShockWaveR(new).damage = thistype(sw).damage
            call MShockWaveR.Launch(new)
            return true
        endmethod

        static method OnCollide takes Shockwave sw, unit targ returns boolean
            // 敌对存活非魔免非无敌非守卫非建筑
            if UnitAlive(targ) and IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) and not IsUnitMagicImmune(targ) and not IsUnitInvulnerable(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                call UnitDamageTargetEx(sw.owner, targ, 1, thistype(sw).damage)
            endif
            return false
        endmethod
        
        implement ShockwaveStruct
    endstruct

    function MagnusShockWaveOnSpellEffect takes nothing returns nothing
        local unit      whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local unit      targUnit  = GetSpellTargetUnit()
        local real      x = GetUnitX(whichUnit)
        local real      y = GetUnitY(whichUnit)
        local real      tx
        local real      ty
        local real      angle
        local Shockwave sw

        local integer level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real    distance  = 1000. + GetUnitCastRangeBonus(whichUnit)
        local boolean isUpgrade = GetSpellAbilityId() == 'A3Y8'

        if isUpgrade then
            set distance = distance + 200.
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
        call sw.SetSpeed(1050.)
        set sw.minRadius = 150.
        set sw.maxRadius = 150.
        set sw.model     = "Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl"
        set MShockWave(sw).isUpgrade = isUpgrade
        set MShockWave(sw).damage = level * 75.
        call MShockWave.Launch(sw)
    endfunction

    //***************************************************************************
    //*
    //*  獠牙冲刺
    //*
    //***************************************************************************

endscope
