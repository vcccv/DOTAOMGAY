
scope ChaosKotoBeast

    globals
        constant integer HERO_INDEX_CHAOS_KOTO_BEAST = 94
    endglobals
    //***************************************************************************
    //*
    //*  酸液
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_SPIT = GetHeroSKillIndexBySlot(HERO_INDEX_CHAOS_KOTO_BEAST, 1)
    endglobals
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
        local real      x         = GetUnitX(whichUnit)
        local real      y         = GetUnitY(whichUnit)
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
        set sw = Shockwave.CreateFromUnit(whichUnit, angle, distance)
        call sw.SetSpeed(1500.)
        set sw.minRadius = 175.
        set sw.maxRadius = 250.
        set sw.model = "effects\\DeathFumesBreath.mdx"
        set Spit(sw).level = level
        call Spit.Launch(sw)

        set whichUnit = null
    endfunction
    //***************************************************************************
    //*
    //*  消化
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_KOTO_DIGEST      = GetHeroSKillIndexBySlot(HERO_INDEX_CHAOS_KOTO_BEAST, 3)
        constant integer KOTO_DIGEST_THROW_ABILITY_ID = 'A32D'
        constant key KOTO_DIGEST_CHAGRES
    endglobals

    function CHR takes nothing returns nothing
        local unit whichUnit = TempUnit
        local unit targetUnit = MissileHitTargetUnit
        local integer level = GetUnitAbilityLevel(whichUnit,'A32E')
        local real CJR = level * 40 + 40
        call UnitDamageTargetEx(whichUnit, targetUnit, 1, CJR)
        call CNX(targetUnit,'A32F', 1, 4,'B32F')
        set whichUnit = null
        set targetUnit = null
    endfunction
    function CKR takes nothing returns nothing
        local trigger t = LaunchMissileByUnitDummy(GetTriggerUnit(), GetSpellTargetUnit(),'hKOD', "CHR", 1000, true)
        set t = null
    endfunction
    function DigestThrowOnSpellEffect takes nothing returns nothing
        local unit    whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local integer count     = Table[GetHandleId(whichUnit)].integer[KOTO_DIGEST_CHAGRES]

        if count > 0 then
            set count = count - 1
            set Table[GetHandleId(whichUnit)].integer[KOTO_DIGEST_CHAGRES] = count
            call SetUnitAbilityCharges(whichUnit, KOTO_DIGEST_THROW_ABILITY_ID, count)
            if count == 0 then
                call UnitDisableAbility(whichUnit, KOTO_DIGEST_THROW_ABILITY_ID, false)
            endif
        endif

        if not UnitHasSpellShield(GetSpellTargetUnit()) then
            call CKR()
        endif
        set whichUnit = null
        // call SaveInteger(ObjectHashTable, GetHandleId(GetTriggerUnit()), KOTO_DIGEST_THROW_ABILITY_ID, i)
        // if i < 1 then
        //     call SaveBoolean(ObjectHashTable, GetHandleId(GetTriggerUnit()), KOTO_DIGEST_THROW_ABILITY_ID, false)
        //     call SetPlayerAbilityAvailable(GetOwningPlayer(GetTriggerUnit()), KOTO_DIGEST_THROW_ABILITY_ID, false)
        //endif
    endfunction
    function DigestThrowOnSpellCast takes nothing returns nothing
        local unit    whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local integer count     = Table[GetHandleId(whichUnit)].integer[KOTO_DIGEST_CHAGRES]
        if count <= 0 then
            call EXStopUnit(whichUnit)
            call InterfaceErrorForPlayer(GetOwningPlayer(whichUnit), "没有树木可使用")
            // call SaveBoolean(ObjectHashTable, GetHandleId(u), KOTO_DIGEST_THROW_ABILITY_ID, false)
            // call SetPlayerAbilityAvailable(GetOwningPlayer(u), KOTO_DIGEST_THROW_ABILITY_ID, false)
        endif
        set whichUnit = null
    endfunction

    // 间接的给哨兵技能
    function KotoDigestOnLearn takes nothing returns nothing
        call UnitAddPermanentAbility(GetTriggerUnit(),'A32E')
        call SetUnitAbilityLevel(GetTriggerUnit(),'A32E', GetUnitAbilityLevel(GetTriggerUnit(),'A32Y'))
    endfunction
    
    function CLR takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local destructable d = LoadDestructableHandle(HY, GetHandleId(t), 0)
        local unit u = CreateUnit(Player(15),'e00E', GetDestructableX(d), GetDestructableY(d), 0)
        call UnitAddAbility(u,'A1FD')
        call IssueTargetOrderById(u, 852146, d)
        call FlushChildHashtable(HY, GetHandleId(t))
        call PauseTimer(t)
        call DestroyTimer(t)
        set u = null
        set t = null
    endfunction
    function CMR takes destructable d returns nothing
        local timer t = CreateTimer()
        call TimerStart(t, .3, false, function CLR)
        call SaveDestructableHandle(HY, GetHandleId(t), 0, d)
        set t = null
    endfunction
    function KotoDigestOnSpellEffect takes nothing returns nothing
        local unit    whichUnit = GetTriggerUnit()
        local integer level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local integer count     = Table[GetHandleId(whichUnit)].integer[KOTO_DIGEST_CHAGRES]

        if count == 0 then
            call UnitEnableAbility(whichUnit, KOTO_DIGEST_THROW_ABILITY_ID, false)
        endif
        set count = count + 1
        set Table[GetHandleId(whichUnit)].integer[KOTO_DIGEST_CHAGRES] = count

        call SetUnitAbilityCharges(whichUnit, KOTO_DIGEST_THROW_ABILITY_ID, count)
        // call UnitAddPermanentAbility(whichUnit, KOTO_DIGEST_THROW_ABILITY_ID)
        // call SaveBoolean(ObjectHashTable, GetHandleId(whichUnit), KOTO_DIGEST_THROW_ABILITY_ID, true)
        // call SetPlayerAbilityAvailable(GetOwningPlayer(whichUnit), KOTO_DIGEST_THROW_ABILITY_ID, true)
        // call SaveInteger(ObjectHashTable, GetHandleId(whichUnit), KOTO_DIGEST_THROW_ABILITY_ID, LoadInteger(ObjectHashTable, GetHandleId(whichUnit), KOTO_DIGEST_THROW_ABILITY_ID) + 1)
        call CMR(GetSpellTargetDestructable())
        set whichUnit = null
    endfunction
    function KotoDigestOnAdd takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        if not IsUnitType(whichUnit, UNIT_TYPE_HERO) then
            set whichUnit = null
            return
        endif
        if UnitAddPermanentAbility(whichUnit, KOTO_DIGEST_THROW_ABILITY_ID) then
            call SetUnitAbilityCharges(whichUnit, KOTO_DIGEST_THROW_ABILITY_ID, Table[GetHandleId(whichUnit)].integer[KOTO_DIGEST_CHAGRES])
            if Table[GetHandleId(whichUnit)].integer[KOTO_DIGEST_CHAGRES] == 0 then
                call UnitDisableAbility(whichUnit, KOTO_DIGEST_THROW_ABILITY_ID, false)
            endif
        endif
        set whichUnit = null
    endfunction
    function KotoDigestOnRemove takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        if not IsUnitType(whichUnit, UNIT_TYPE_HERO) then
            set whichUnit = null
            return
        endif
        call UnitRemoveAbility(whichUnit, KOTO_DIGEST_THROW_ABILITY_ID)
        set whichUnit = null
    endfunction

endscope
