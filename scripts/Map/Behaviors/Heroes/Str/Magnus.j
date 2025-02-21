
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
        
        real    damage
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
    function SkewerOnMoveUpdate takes nothing returns boolean
        local trigger  t         = GetTriggeringTrigger()
        local integer  h         = GetHandleId(t)
        local unit     whichUnit = (LoadUnitHandle(HY, h, 2))
        local integer  level     = (LoadInteger(HY, h, 5))
        local real     tx        = (LoadReal(HY, h, 47))
        local real     ty        = (LoadReal(HY, h, 48))
        local real     a         = (LoadReal(HY, h, 13))
        local real     ux        = (LoadReal(HY, h, 6))
        local real     uy        = (LoadReal(HY, h, 7))
        local real     targetX   = CoordinateX75(ux + 19 * Cos(a))
        local real     targetY   = CoordinateY75(uy + 19 * Sin(a))
        local group    g
        local group    targGroup = LoadGroupHandle(HY, h, 0)
        local integer  maxCount  = (LoadInteger(HY, h, 12))
        local unit     first
        local real     area      = 150.
        local integer  i
        local integer  max

        call SetUnitX(whichUnit, targetX)
        call SetUnitY(whichUnit, targetY)
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

        call GroupEnumUnitsInRange(g, targetX, targetY, area + MAX_UNIT_COLLISION, null)
        loop
            set first = FirstOfGroup(g)
            exitwhen first == null
            call GroupRemoveUnit(g, first)
            
            if IsUnitInRangeXY(first, targetX, targetY, area) and first != Roshan and UnitAlive(first) and not IsUnitInGroup(first, targGroup) and IsUnitEnemy(whichUnit, GetOwningPlayer(first)) and IsHeroUnitId(GetUnitTypeId(first)) then
                call GroupAddUnit(targGroup, first)
                call UnitIncStunCount(first)
                call UnitIncNoPathingCount(first)
            endif

        endloop

        set i   = 1
        set max = MHGroup_GetSize(targGroup)
        loop
            exitwhen i > max
            set first = MHGroup_GetUnit(targGroup, i)
            if UnitAlive(first) then
                call SetUnitPosition(first, targetX, targetY)
            endif
            set i = i + 1
        endloop

        call DeallocateGroup(g)

        if ModuloInteger(GetTriggerEvalCount(t), 3) == 0 then
            call KillTreeByCircle(targetX, targetY, 200)
        endif
        if GetTriggerEventId() == EVENT_WIDGET_DEATH or GetTriggerEvalCount(t)> maxCount then
            call DestroyEffect((LoadEffectHandle(HY, h, 175)))
            call SetUnitAnimationByIndex(whichUnit, 0)
            call SetUnitTimeScale(whichUnit, 1.)
            
            call UnitDecStunCount(whichUnit)
            call UnitDecNoPathingCount(whichUnit)

            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)

            set i   = 1
            set max = MHGroup_GetSize(targGroup)
            loop
                exitwhen i > max
                set first = MHGroup_GetUnit(targGroup, i)
                call UnitDecStunCount(first)
                call UnitDecNoPathingCount(first)
                call UnitDamageTargetEx(whichUnit, first, 1, 70 * level)
                call UnitAddAbilityToTimed(first, 'A1Q5', 1, 2.5, 'B0CX')
                call KillTreeByCircle(GetUnitX(first), GetUnitY(first), 300.)
                set i = i + 1
            endloop

            call DeallocateGroup(targGroup)
            call KillTreeByCircle(targetX, targetY, 375.)
        endif
        set t = null
        set whichUnit = null
        set first = null
        set g = null
        set targGroup = null
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

        call UnitAddStunCountSafe(whichUnit)
        call UnitIncNoPathingCount(whichUnit)

        call SetUnitAnimationByIndex(whichUnit, 3)
        call SetUnitTimeScale(whichUnit, 1.5)
        call TriggerRegisterTimerEvent(t, .02, true)
        call TriggerRegisterDeathEvent(t, whichUnit)
        call TriggerAddCondition(t, Condition(function SkewerOnMoveUpdate))
        call SaveUnitHandle(HY, h, 2,(whichUnit))
        call SaveInteger(HY, h, 5,(level))
        call SaveReal(HY, h, 47,((tx)* 1.))
        call SaveReal(HY, h, 48,((ty)* 1.))
        call SaveGroupHandle(HY, h, 0, AllocationGroup(359))
        call SaveReal(HY, h, 6,((sx)* 1.))
        call SaveReal(HY, h, 7,((sy)* 1.))
        call SaveReal(HY, h, 13,((Atan2(ty -sy, tx -sx))* 1.))
        call SaveInteger(HY, h, 12,(R2I(GetDistanceBetween(sx, sy, tx, ty)/ 19.))) // dota2每次30
        call SaveEffectHandle(HY, h, 175,(AddSpecialEffectTarget("war3mapImported\\SkewerTuskGlow_1.mdx", whichUnit, "head")))
        set t = null
        set whichUnit = null
    endfunction

    //***************************************************************************
    //*
    //*  两级反转
    //*
    //***************************************************************************
    function WKI takes nothing returns boolean
        local real x
        local real y
        if (IsUnitEnemy(GetTriggerUnit(), GetOwningPlayer(GetFilterUnit())) and(IsAliveNotStrucNotWard(GetFilterUnit()))) and GetFilterUnit()!= Roshan then
            set x = L8V + GetRandomReal(20, 70)* Cos(GetUnitFacing(GetTriggerUnit())* bj_DEGTORAD)
            set y = L9V + GetRandomReal(20, 70)* Sin(GetUnitFacing(GetTriggerUnit())* bj_DEGTORAD)
            call SetUnitPosition(GetFilterUnit(), x, y)
        endif
        return false
    endfunction
    function ReversePolarityOnSpellEffect takes nothing returns nothing
        local unit      u         = GetRealSpellUnit(GetTriggerUnit())
        local real      x         = GetUnitX(u)
        local real      y         = GetUnitY(u)
        local group     g         = AllocationGroup(357)
        local unit      d         = CreateUnit(GetOwningPlayer(u),'e00E', x, y, 0)
        local integer   level     = GetUnitAbilityLevel(u, GetSpellAbilityId())
        local boolean   isUpgrade = GetSpellAbilityId() == 'A447'
        local real      angle     = GetUnitFacing(u) * bj_DEGTORAD
        local unit      first
        local real      area      = 410.
        local real      distance  = 1000.
        local real      tx
        local real      ty
        local Shockwave sw

        set tx = GetUnitX(u) + 100 * Cos(angle)
        set ty = GetUnitY(u) + 100 * Sin(angle)

        call GroupEnumUnitsInRange(g, x, y, area + MAX_UNIT_COLLISION, null)
        loop
            set first = FirstOfGroup(g)
            exitwhen first == null
            call GroupRemoveUnit(g, first)

            if IsUnitInRangeXY(first, x, y, area) and IsUnitEnemy(u, GetOwningPlayer(first)) and(IsAliveNotStrucNotWard(first)) and first!= Roshan then
                set x = tx + GetRandomReal(20, 70)* Cos(angle)
                set y = ty + GetRandomReal(20, 70)* Sin(angle)
                call SetUnitPosition(first, x, y)
            endif
            
        endloop
        call DeallocateGroup(g)

        call UnitAddPermanentAbility(d,'A06F')
        call SetUnitAbilityLevel(d,'A06F', level)
        call IssueImmediateOrderById(d, 852127)

        if isUpgrade then
            set sw = Shockwave.CreateByDistance(u, x, y, angle, distance)
            call sw.SetSpeed(1050.)
            set sw.minRadius = 150.
            set sw.maxRadius = 150.
            set sw.model     = "Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl"
            set MShockWave(sw).isUpgrade = false
            set MShockWave(sw).damage = 175
            call MShockWave.Launch(sw)

            set sw = Shockwave.CreateByDistance(u, x, y, angle + 15.* bj_DEGTORAD, distance)
            call sw.SetSpeed(1050.)
            set sw.minRadius = 150.
            set sw.maxRadius = 150.
            set sw.model     = "Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl"
            set MShockWave(sw).isUpgrade = false
            set MShockWave(sw).damage = 175
            call MShockWave.Launch(sw)

            set sw = Shockwave.CreateByDistance(u, x, y, angle - 15.* bj_DEGTORAD, distance)
            call sw.SetSpeed(1050.)
            set sw.minRadius = 150.
            set sw.maxRadius = 150.
            set sw.model     = "Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl"
            set MShockWave(sw).isUpgrade = false
            set MShockWave(sw).damage = 175
            call MShockWave.Launch(sw)
        endif

        set u = null
        set g = null
        set d = null
    endfunction

endscope
