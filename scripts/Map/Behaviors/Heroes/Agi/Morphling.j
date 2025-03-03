
scope Morphling

    //***************************************************************************
    //*
    //*  波浪形态
    //*
    //***************************************************************************
    globals
        private constant key WAVEFORM_COUNT
    endglobals
    private struct MorphlingWave extends array
        
        real    damage
        integer data

        static method OnRemove takes Shockwave sw returns boolean
            local real x = CoordinateX50(sw.x)
            local real y = CoordinateY50(sw.y)
            if not IsUnitType(sw.owner, UNIT_TYPE_HERO) then
                return false
            endif
            if IsUnitType(sw.owner, UNIT_TYPE_HERO) then
                //set Table[GetHandleId(sw.owner)][WAVEFORM_COUNT] = Table[GetHandleId(sw.owner)][WAVEFORM_COUNT] - 1
                //if Table[GetHandleId(sw.owner)][WAVEFORM_COUNT] == 0 then
                    call UnitDecCantSelectCount(sw.owner)
                    call UnitDecHideByColorCount(sw.owner)
                    call UnitDecNoPathingCount(sw.owner)
                    call UnitDecInvulnerableCount(sw.owner)
                //endif
            endif

            set x = MHUnit_ModifyPositionX(sw.owner, x, y)
            set y = MHUnit_ModifyPositionY(sw.owner, x, y)
            call SetUnitX(sw.owner, x)
            call SetUnitY(sw.owner, y)
            return false
        endmethod

        static method OnCollide takes Shockwave sw, unit targ returns boolean
            // 敌对存活非魔免非无敌非守卫非建筑
            if UnitAlive(targ) and IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) and not IsUnitMagicImmune(targ) and not IsUnitInvulnerable(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                call UnitDamageTargetEx(sw.owner, targ, 1, thistype(sw).damage)
            endif
            return false
        endmethod

        static method OnPeriod takes Shockwave sw returns boolean
            local real x = CoordinateX50(sw.x)
            local real y = CoordinateY50(sw.y)
            call SetUnitX(sw.owner, x)
            call SetUnitY(sw.owner, y)
            if thistype(sw).data == 1 then
                call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl", x, y))
                set thistype(sw).data = 0
            endif
            set thistype(sw).data = thistype(sw).data + 1
            // 比如存在被生命移除击杀的可能性
            if not IsUnitType(sw.owner, UNIT_TYPE_HERO) and not UnitAlive(sw.owner) then
                return true
            endif
            return false
        endmethod

        implement ShockwaveStruct
    endstruct

    // 可以攻击，但不能被移动，如果被强制位移或击杀，则终止?
    function WaveformOnSpellEffect takes nothing returns nothing
        local unit      whichUnit = GetTriggerUnit()
        local unit      targUnit  = GetSpellTargetUnit()
        local real      x         = GetUnitX(whichUnit)
        local real      y         = GetUnitY(whichUnit)
        local real      tx
        local real      ty
        local real      angle
        local Shockwave sw

        local integer   level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real      distance
        local real      damage

        if targUnit == null then
            set tx = GetSpellTargetX()
            set ty = GetSpellTargetY()
            set angle = RadianBetweenXY(x, y, tx, ty)
        else
            set tx = GetUnitX(targUnit)
            set ty = GetUnitY(targUnit)
            set targUnit = null
        endif
        set distance = GetDistanceBetween(x, y, tx, ty)
        set sw = Shockwave.CreateFromUnit(whichUnit, angle, distance)
        call sw.SetSpeed(1250.)
        set sw.minRadius = 200.
        set sw.maxRadius = 200.
        set MorphlingWave(sw).damage = 25. + 75. * level
        call MorphlingWave.Launch(sw)

        if IsUnitType(whichUnit, UNIT_TYPE_HERO) then         
            //set Table[GetHandleId(whichUnit)][WAVEFORM_COUNT] = Table[GetHandleId(whichUnit)][WAVEFORM_COUNT] + 1
            //if Table[GetHandleId(whichUnit)][WAVEFORM_COUNT] == 1 then
                call UnitIncInvulnerableCount(whichUnit)
                call UnitIncNoPathingCount(whichUnit)
                call UnitIncCantSelectCount(whichUnit)
                call UnitIncHideByColorCount(whichUnit)
            //endif
            
            call ShowUnit(whichUnit, false)
            call ShowUnit(whichUnit, true)
            call SelectUnitAddForPlayer(whichUnit, GetOwningPlayer(whichUnit))
        endif

        set whichUnit = null
    endfunction

endscope
