
scope ChaosKotoBeast

    //***************************************************************************
    //*
    //*  酸液
    //*
    //***************************************************************************
    function SpitDeBuffEnd takes nothing returns nothing
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit    u = LoadUnitHandle(HY, h, 0)
        if GetTriggerEventId() == EVENT_WIDGET_DEATH or GetTriggerEvalCount(t) == 60 or GetUnitAbilityLevel(u,'A3K6') == 0 then
            call SetHeroStr(u, GetHeroStr(u, false)+ LoadInteger(HY, h, 0), true)
            call SetHeroAgi(u, GetHeroAgi(u, false)+ LoadInteger(HY, h, 1), true)
            call SetHeroInt(u, GetHeroInt(u, false)+ LoadInteger(HY, h, 2), true)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        endif
        set u = null
        set t = null
    endfunction
    function SpitOnHit takes unit sourceUnit, unit whichUnit, integer level returns nothing
        local trigger t
        local integer stolen = 0
        local integer curstat = 0
        local integer reducedStr
        local integer reducedAgi
        local integer reducedInt
        local integer h
        if IsUnitType(whichUnit, UNIT_TYPE_HERO) then
            set t = CreateTrigger()
            set h = GetHandleId(t)
            call TriggerRegisterTimerEvent(t, .2, true)
            call TriggerRegisterDeathEvent(t, whichUnit)
            set reducedStr = IMinBJ(GetHeroStr(whichUnit, false)-1, level * 2)
            set reducedAgi = IMinBJ(GetHeroAgi(whichUnit, false)-1, level * 2)
            set reducedInt = IMinBJ(GetHeroInt(whichUnit, false)-1, level * 2)
            call SetHeroStr(whichUnit, GetHeroStr(whichUnit, false)-reducedStr, true)
            call SetHeroAgi(whichUnit, GetHeroAgi(whichUnit, false)-reducedAgi, true)
            call SetHeroInt(whichUnit, GetHeroInt(whichUnit, false)-reducedInt, true)
            call TriggerAddCondition(t, Condition(function SpitDeBuffEnd))
            call UnitAddAbilityToTimed(whichUnit,'A3K6', 1, 12,'B3K6')
            call SaveUnitHandle(HY, h, 0, whichUnit)
            call SaveInteger(HY, h, 0, reducedStr)
            call SaveInteger(HY, h, 1, reducedAgi)
            call SaveInteger(HY, h, 2, reducedInt)
            set t = null
        endif
        call UnitDamageTargetEx(sourceUnit, whichUnit, 3, 50 + 25 * level)
        set t = null
    endfunction

    private struct Spit extends array
        
        integer level

        static method OnCollide takes Shockwave sw, unit targ returns boolean
            // 敌对存活非魔免非无敌非守卫非建筑
            if UnitAlive(targ) and IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) and not IsUnitMagicImmune(targ) and not IsUnitInvulnerable(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                call SpitOnHit(sw.owner, targ, thistype(sw).level)
            endif
            return false
        endmethod
        
        implement ShockwaveStruct
    endstruct

    function SpitOnSpellEffect takes nothing returns nothing
        local unit      whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local unit      targUnit  = GetSpellTargetUnit()
        local real      x = GetUnitX(whichUnit)
        local real      y = GetUnitY(whichUnit)
        local real      tx
        local real      ty
        local real      angle
        local Shockwave sw

        local integer level    = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real    distance = 700. + GetUnitCastRangeBonus(whichUnit)
        local real    damage

        set damage = 50. + 25. * level

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
        set sw.minRadius = 175.
        set sw.maxRadius = 250.
        set sw.model = "effects\\DeathFumesBreath.mdx"
        set Spit(sw).level = level
        call Spit.Launch(sw)

        set whichUnit = null
    endfunction

endscope
