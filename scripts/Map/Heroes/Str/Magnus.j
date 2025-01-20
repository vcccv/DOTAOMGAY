
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
    
    function WPI takes nothing returns boolean
        return(IsUnitEnemy(U2, GetOwningPlayer(GetFilterUnit())) and IsUnitIdType(GetUnitTypeId(GetFilterUnit()), UNIT_TYPE_HERO) and IsUnitInGroup(GetFilterUnit(), LB) == false and CT != GetFilterUnit() and GXX(GetFilterUnit()) )!= null 
    endfunction
    function WQI takes nothing returns nothing
        call SetUnitPosition(GetEnumUnit(), ZI, VA)
        call SaveBoolean(OtherHashTable, GetHandleId(GetEnumUnit()), 99, true)
        call SetUnitPathing(GetEnumUnit(), false)
    endfunction
    function WSI takes nothing returns nothing
        local unit u = GetEnumUnit()
        local location l
        local real x
        local real y
        if IsPointInRegion(TerrainCliffRegion, GetUnitX(u), GetUnitY(u)) then
            set l = DEX(GetUnitX(u), GetUnitY(u))
            set x = CoordinateX75(GetLocationX(l))
            set y = CoordinateY75(GetLocationY(l))
            call SaveBoolean(OtherHashTable, GetHandleId(u), 99, true)
            call SetUnitX(u, x)
            call SetUnitY(u, y)
            call RemoveLocation(l)
            set l = null
        endif
        call SetUnitPathing(u, true)
        call WMI(WI, u, YI)
        call KillTreeByCircle(GetUnitX(u), GetUnitY(u), 300)
        set u = null
    endfunction

    function SkewerOnMoveUpdate takes nothing returns boolean
        local trigger  t         = GetTriggeringTrigger()
        local integer  h         = GetHandleId(t)
        local unit     whichUnit = (LoadUnitHandle(HY, h, 2))
        local integer  level     = (LoadInteger(HY, h, 5))
        local real     tx        = (LoadReal(HY, h, 47))
        local real     ty        = (LoadReal(HY, h, 48))
        local real     a         = (LoadReal(HY, h, 13))
        local real     GRR       = (LoadReal(HY, h, 6))
        local real     GIR       = (LoadReal(HY, h, 7))
        local real     targetX       = CoordinateX75(GRR + 19 * Cos(a))
        local real     targetY       = CoordinateY75(GIR + 19 * Sin(a))
        local group    g
        local group    gg        = LoadGroupHandle(HY, h, 0)
        local integer  WUI       =(LoadInteger(HY, h, 12))
        local location l
        if IsUnitType(whichUnit, UNIT_TYPE_HERO) then
            call SaveBoolean(OtherHashTable, GetHandleId(whichUnit), 99, true)
        endif
        call SetUnitPosition(whichUnit, targetX, targetY)
        call SetUnitFacing(whichUnit, a * bj_RADTODEG)
        call SaveReal(HY, h, 6,((targetX)* 1.))
        call SaveReal(HY, h, 7,((targetY)* 1.))
        if ModuloInteger(GetTriggerEvalCount(t), 4) == 0 then
            call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl", targetX, targetY))
        endif
        if GetTriggerEvalCount(t) == 2 then
            call SetUnitAnimationByIndex(whichUnit, 3)
        endif
        set g = AllocationGroup(358)
        set U2 = whichUnit
        set LB = gg
        call GroupEnumUnitsInRange(g, targetX, targetY, 150+ 25, Condition(function WPI))
        if FirstOfGroup(g)!= null then
            call GroupAddGroup(g, gg)
        endif
        call DeallocateGroup(g)
        set ZI = targetX
        set VA = targetY
        call ForGroup(gg, function WQI)
        if ModuloInteger(GetTriggerEvalCount(t), 3) == 0 then
            call KillTreeByCircle(targetX, targetY, 200)
        endif
        if GetTriggerEventId() == EVENT_WIDGET_DEATH or GetTriggerEvalCount(t)> WUI then
            call DestroyEffect((LoadEffectHandle(HY, h, 175)))
            call SetUnitAnimationByIndex(whichUnit, 0)
            call SetUnitTimeScale(whichUnit, 1.)
            call SetUnitPathing(whichUnit, true)
            call FlushChildHashtable(HY, h)
            call CleanCurrentTrigger(t)
            set YI = level
            set WI = whichUnit
            call IssueTargetOrderById(whichUnit, 851983, FirstOfGroup(gg))
            call ForGroup(gg, function WSI)
            call KillTreeByCircle(targetX, targetY, 375)
            if IsPointInRegion(TerrainCliffRegion, GetUnitX(whichUnit), GetUnitY(whichUnit)) then
                set l = DEX(GetUnitX(whichUnit), GetUnitY(whichUnit))
                if IsUnitType(whichUnit, UNIT_TYPE_HERO) then
                    call SaveBoolean(OtherHashTable, GetHandleId(whichUnit), 99, true)
                endif
                call SetUnitX(whichUnit, CoordinateX75(GetLocationX(l)))
                call SetUnitY(whichUnit, CoordinateY75(GetLocationY(l)))
                call RemoveLocation(l)
                set l = null
            endif
        endif
        set t = null
        set whichUnit = null
        call DeallocateGroup(gg)
        call DeallocateGroup(g)
        set g = null
        set gg = null
        return false
    endfunction

    function SkewerOnSpellEffect takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local real tx = CoordinateX75(GetSpellTargetX())
        local real ty = CoordinateY75(GetSpellTargetY())
        local unit whichUnit = GetTriggerUnit()
        local real sx = GetUnitX(whichUnit)
        local real sy = GetUnitY(whichUnit)
        local integer level = GetUnitAbilityLevel(whichUnit,'A1RD')
        local real a = AngleBetweenXY(sx, sy, tx, ty)* bj_DEGTORAD
        local real distance = level * 150. + 625. + GetUnitCastRangeBonus(whichUnit) 
        if GetDistanceBetween(sx, sy, tx, ty)> distance then
            set tx = CoordinateX75(sx + distance * Cos(a))
            set ty = CoordinateY75(sy + distance * Sin(a))
        endif
        call SetUnitPathing(whichUnit, false)
        call SetUnitAnimationByIndex(whichUnit, 3)
        call SetUnitTimeScale(whichUnit, 1.5)
        call TriggerRegisterTimerEvent(t, .02, true)
        call TriggerRegisterDeathEvent(t, whichUnit)
        call TriggerAddCondition(t, Condition(function SkewerOnMoveUpdate))
        call SaveUnitHandle(HY, h, 2,(whichUnit))
        call SaveInteger(HY, h, 5,(level))
        call SaveUnitHandle(HY, h, 393,(null))
        call SaveUnitHandle(HY, h, 394,(null))
        call SaveUnitHandle(HY, h, 395,(null))
        call SaveUnitHandle(HY, h, 396,(null))
        call SaveUnitHandle(HY, h, 397,(null))
        call SaveReal(HY, h, 47,((tx)* 1.))
        call SaveReal(HY, h, 48,((ty)* 1.))
        call SaveGroupHandle(HY, h, 0, AllocationGroup(359))
        call SaveReal(HY, h, 6,((sx)* 1.))
        call SaveReal(HY, h, 7,((sy)* 1.))
        call SaveReal(HY, h, 13,((Atan2(ty -sy, tx -sx))* 1.))
        call SaveInteger(HY, h, 12,(R2I(GetDistanceBetween(sx, sy, tx, ty)/ 19.)))
        call SaveEffectHandle(HY, h, 175,(AddSpecialEffectTarget("war3mapImported\\SkewerTuskGlow_1.mdx", whichUnit, "head")))
        set t = null
        set whichUnit = null
    endfunction

endscope
