
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

    /*
function ShockWaveActions takes nothing returns nothing
	local unit target = Wave_U
	local unit u = Player__Hero[GetPlayerId(GetOwningPlayer(Wave_Sou))]
	local integer lv = Wave_LV
	if not IsUnitType(target, UNIT_TYPE_MAGIC_IMMUNE) then
		call UnitDamageTargetEx(u, target, 1, 37.5 * lv)
		call UnitAddAbilityToTimed(target,'A3Y9', 1, 2.,'a3Y9')
	endif
	set target = null
	set u = null
endfunction

function a_shockwave takes nothing returns nothing
	local timer t = GetExpiredTimer()
	local integer h = GetHandleId(t)
	local real sx = LoadReal(HY, h, 2)
	local real sy = LoadReal(HY, h, 3)
	local real tx = LoadReal(HY, h, 0)
	local real ty = LoadReal(HY, h, 1)
	local real a = bj_RADTODEG * Atan2(ty -sy, tx -sx)
	local real x = sx + 1200. * Cos(a * bj_DEGTORAD)
	local real y = sy + 1200. * Sin(a * bj_DEGTORAD)
	local unit u = LoadUnitHandle(HY, h, 0)
	local unit d = CreateUnit(GetOwningPlayer(u),'e00E', x, y, 0)
	local real range = SquareRoot((sx -GetUnitX(d))*(sx -GetUnitX(d))+(sy -GetUnitY(d))*(sy -GetUnitY(d)))
	if range > 1200 then
		set range = 1200.
	endif
	call UAII(range, 150., 150., 0, 1575., "ShockWaveActions", d, sx, sy, GetUnitAbilityLevel(u,'A02S')+ GetUnitAbilityLevel(u,'A3Y8'))
	set u = null
	set d = null
	//call P8E()
	call FlushChildHashtable(HY, h)
	call DestroyTimer(t)
	set t = null
endfunction

function amengmaw takes nothing returns nothing
	local integer h = TimerStartSingle(1200. / 1525., function a_shockwave)
	call TIRUP(1200., 150., 150., 75. * GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId()), 1575.)
	call SetUnitVertexColor(IR, 255, 100, 0, 255)
	call SaveUnitHandle(HY, h, 0, GetTriggerUnit())
	call SaveReal(HY, h, 0, GetSpellTargetX())
	call SaveReal(HY, h, 1, GetSpellTargetY())
	call SaveReal(HY, h, 2, GetUnitX(GetTriggerUnit()))
	call SaveReal(HY, h, 3, GetUnitY(GetTriggerUnit()))
endfunction

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
