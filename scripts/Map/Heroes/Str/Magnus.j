
scope Magnus

    //***************************************************************************
    //*
    //*  震荡波
    //*
    //***************************************************************************
    private struct MShockWave
        
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

    function MagnusShockWaveOnSpellEffect takes nothing returns nothing
        local unit      whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local unit      targUnit  = GetSpellTargetUnit()
        local real      x = GetUnitX(whichUnit)
        local real      y = GetUnitY(whichUnit)
        local real      tx
        local real      ty
        local real      angle
        local Shockwave sw

        local integer level    = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real    distance = 1000. + GetUnitCastRangeBonus(whichUnit)

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
        set sw.model = "Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl"
        //call sw.FixTimeScale(0.033 + 1.166)
        set MShockWave(sw).damage = level * 75.
        call MShockWave.Launch(sw)
    endfunction

    /*
function MagnataurShockWaveOnSpellEffect takes nothing returns nothing
	local unit d = CreateUnit(GetOwningPlayer(GetTriggerUnit()),'e00E', GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()), GetUnitFacing(GetTriggerUnit()))
	call UnitAddAbility(d,'A3IH')
	call SetUnitAbilityLevel(d,'A3IH', GetUnitAbilityLevel(GetTriggerUnit(),'A02S'))
	if GetSpellTargetUnit() == GetTriggerUnit() then
		call B1R(d, "carrionswarm", GetUnitX(GetTriggerUnit())+ 1 * Cos(bj_DEGTORAD * GetUnitFacing(GetTriggerUnit())), GetUnitY(GetTriggerUnit())+ 1 * Sin(bj_DEGTORAD * GetUnitFacing(GetTriggerUnit())))
	else
		call B1R(d, "carrionswarm", GetSpellTargetX(), GetSpellTargetY())
	endif
	set d = null
endfunction
    */

endscope
