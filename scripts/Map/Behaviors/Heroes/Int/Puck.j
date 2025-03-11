
scope Puck

    globals
        constant integer HERO_INDEX_PUCK = 44
    endglobals
    //***************************************************************************
    //*
    //*  幻象法球
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_ILLUSORY_ORB  = GetHeroSKillIndexBySlot(HERO_INDEX_PUCK, 1)
        constant integer ETHEREAL_JAUNT_ABILITY_ID = 'A0SA'

        private TableArray IllusoryOrbTable
    endglobals

    private struct IllusoryOrb extends array

        unit MissileUnit

        static method OnRemove takes Shockwave sw returns boolean
            local integer count
            local integer h     = GetHandleId(sw.owner)
            local integer i

            set i = 1
            set count = IllusoryOrbTable[0].integer[h] - 1
            set IllusoryOrbTable[0].integer[h] = count
            loop
                // 前移
                set IllusoryOrbTable[i].integer[h] = IllusoryOrbTable[i + 1].integer[h]
                //call BJDebugMsg(" " + I2S((i+1)) + " -> " + I2S(i))
                exitwhen i > count
                set i = i + 1
            endloop
            call IllusoryOrbTable[i].integer.remove(h)
            //call BJDebugMsg(" remove: " + I2S(i))
            call UnitDisableAbility(sw.owner, ETHEREAL_JAUNT_ABILITY_ID, false)

            call SetUnitScale(thistype(sw).MissileUnit, 2.5, 2.5, 2.5)
            call KillUnit(thistype(sw).MissileUnit)
            set thistype(sw).MissileUnit = null
            return true
        endmethod
    
        static method OnCollide takes Shockwave sw, unit targ returns boolean
            // 敌对存活非魔免非无敌非守卫非建筑
            if UnitAlive(targ) and IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) and not IsUnitMagicImmune(targ) and not IsUnitInvulnerable(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                call UnitDamageTargetEx(sw.owner, targ, 1, sw.damage)
            endif
            return false
        endmethod
        
        static method OnPeriod takes Shockwave sw returns boolean
            call SetUnitX(thistype(sw).MissileUnit, sw.x)
            call SetUnitY(thistype(sw).MissileUnit, sw.y)
            return false
        endmethod
        
        implement ShockwaveStruct
    endstruct

    function IllusoryOryOnInitializer takes nothing returns nothing
        set IllusoryOrbTable = TableArray[JASS_MAX_ARRAY_SIZE]
        call ResgiterAbilityMethodSimple(HeroSkill_BaseId[SKILL_INDEX_ILLUSORY_ORB], "IllusoryOryOnAdd", "IllusoryOryOnRemove")
    endfunction
    function IllusoryOryOnAdd takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        if UnitAddPermanentAbility(whichUnit, ETHEREAL_JAUNT_ABILITY_ID) then
            call UnitDisableAbility(whichUnit, ETHEREAL_JAUNT_ABILITY_ID, false)
        endif
        set whichUnit = null
    endfunction
    function IllusoryOryOnRemove takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        call UnitRemoveAbility(whichUnit, ETHEREAL_JAUNT_ABILITY_ID)
        set whichUnit = null
    endfunction
    
    function EtherealJauntOnSpellEffect takes nothing returns nothing
        local unit      whichUnit = GetTriggerUnit()
        local integer   h         = GetHandleId(whichUnit)
        local Shockwave sw
        if IllusoryOrbTable[1].integer[h] == 0 then
            call InterfaceErrorForPlayer(GetOwningPlayer(GetTriggerUnit()), GetObjectName('n037'))
        else
            set sw = IllusoryOrbTable[1].integer[h]
            call SetUnitPositionEx(whichUnit, (sw.x), (sw.y))
            call ShowUnit(whichUnit, false)
            call ShowUnit(whichUnit, true)
            call SelectUnitAddForPlayer(whichUnit, GetOwningPlayer(whichUnit))
            call IllusoryOrb.Terminate(sw)
            //call BJDebugMsg("终止了：" + I2S(sw))
        endif
        set whichUnit = null
    endfunction

    function IllusoryOrbOnSpellEffect takes nothing returns nothing
        local unit    whichUnit    = GetRealSpellUnit(GetTriggerUnit())
        local integer h
        local integer count
        local real    sx           = GetUnitX(whichUnit)
        local real    sy           = GetUnitY(whichUnit)
        local real    tx           = GetSpellTargetX()
        local real    ty           = GetSpellTargetY()
        local real    angle        = RadianBetweenXY(sx, sy, tx, ty)
        local integer level        = GetUnitAbilityLevel(whichUnit,'A0S9')
        local unit    dummyCaster  = CreateUnit(GetOwningPlayer(whichUnit),'h06O', sx, sy, angle * bj_RADTODEG)
        local real    distance     = 1800. + GetUnitCastRangeBonus(whichUnit)
        local Shockwave sw

        call PlaySoundAtPosition(MoonWellWhatSound, sx, sy)

        call UnitEnableAbility(whichUnit, ETHEREAL_JAUNT_ABILITY_ID, false)

        set sw = Shockwave.Create(whichUnit, sx, sy, angle, distance)
        call sw.SetSpeed(650.)
        set sw.minRadius  = 225.
        set sw.maxRadius  = 225.
        set sw.damage     = level * 70
        set IllusoryOrb(sw).MissileUnit = dummyCaster
        call IllusoryOrb.Launch(sw)

        set h = GetHandleId(whichUnit)
        set count = IllusoryOrbTable[0].integer[h] + 1
        set IllusoryOrbTable[0].integer[h] = count
        set IllusoryOrbTable[count].integer[h] = sw
        
        set whichUnit   = null
        set dummyCaster = null
    endfunction

    //***************************************************************************
    //*
    //*  相位转移
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_PHASE_SHIFT = GetHeroSKillIndexBySlot(HERO_INDEX_PUCK, 3)
    endglobals
    function T_R takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit trigUnit =(LoadUnitHandle(HY, h, 14))
        local integer level
        local integer S4R
        local integer d
        if (GetTriggerEventId() == EVENT_UNIT_ISSUED_ORDER and GetIssuedOrderId()!= 852514) or GetTriggerEventId() == EVENT_UNIT_ISSUED_POINT_ORDER or GetTriggerEventId() == EVENT_UNIT_ISSUED_TARGET_ORDER or GetTriggerEventId() == EVENT_WIDGET_DEATH then
            call UnitDecInvulnerableCount(trigUnit)
            call UnitRemoveAbility(trigUnit,'A04R')
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        else
            set level =(LoadInteger(HY, h, 5))
            set d = 3 * level
            if level == 4 then
                set d = d + 1
            endif
            set S4R =(LoadInteger(HY, h, 28))+ 1
            call SaveInteger(HY, h, 28,(S4R))
            // 如果受到强制位移>125则会中断相位转移
            if S4R > d or GetDistanceBetween(GetUnitX(trigUnit), GetUnitY(trigUnit),(LoadReal(HY, h, 6)),(LoadReal(HY, h, 7)))> 125 then
                call UnitDecInvulnerableCount(trigUnit)
                call UnitRemoveAbility(trigUnit, 'A04R')
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
            endif
        endif
        set t = null
        set trigUnit = null
        return false
    endfunction
    function T0R takes nothing returns nothing
        local timer t = GetExpiredTimer()
        call UnitAddAbility(LoadUnitHandle(ObjectHashTable, GetHandleId(t), 0),'A04R')
        call DestroyTimerAndFlushHT_P(t)
        set t = null
    endfunction
    function PhaseShiftOnSpellEffect takes nothing returns nothing
        local timer time = CreateTimer()
        local unit trigUnit = GetTriggerUnit()
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        call SaveUnitHandle(ObjectHashTable, GetHandleId(time), 0, trigUnit)
        call TimerStart(time, 0, false, function T0R)

        call UnitIncInvulnerableCount(trigUnit)
        call SaveUnitHandle(HY, h, 14,(trigUnit))
        call SaveInteger(HY, h, 5,(GetUnitAbilityLevel(trigUnit,'A0SB')))
        call SaveInteger(HY, h, 28, 0)
        call SaveReal(HY, h, 6,((GetUnitX(trigUnit))* 1.))
        call SaveReal(HY, h, 7,((GetUnitY(trigUnit))* 1.))
        call TriggerRegisterTimerEvent(t, .25, true)
        call TriggerRegisterUnitEvent(t, trigUnit, EVENT_UNIT_ISSUED_ORDER)
        call TriggerRegisterUnitEvent(t, trigUnit, EVENT_UNIT_ISSUED_POINT_ORDER)
        call TriggerRegisterUnitEvent(t, trigUnit, EVENT_UNIT_ISSUED_TARGET_ORDER)
        call TriggerRegisterDeathEvent(t, trigUnit)
        call TriggerAddCondition(t, Condition(function T_R))
        set t = null
        set trigUnit = null
        set time = null
    endfunction
    function T2R takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit trigUnit =(LoadUnitHandle(HY, h, 14))
        call IssueImmediateOrderById(trigUnit, 852516)
        call FlushChildHashtable(HY, h)
        call DestroyTrigger(t)
        set t = null
        set trigUnit = null
        return false
    endfunction
    function T3R takes nothing returns nothing
        local unit trigUnit = GetTriggerUnit()
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        call SaveUnitHandle(HY, h, 14,(trigUnit))
        call TriggerRegisterTimerEvent(t, 0, false)
        call TriggerAddCondition(t, Condition(function T2R))
        set t = null
        set trigUnit = null
    endfunction
    function T4R takes nothing returns boolean
        if GetIssuedOrderId()== 852514 and not IsUnitIllusion(GetTriggerUnit()) then
            call PhaseShiftOnSpellEffect()
        elseif GetIssuedOrderId()== 852515 then
            call T3R()
        endif
        return false
    endfunction
    function PhaseShiftOnInit takes nothing returns nothing
        local trigger t = CreateTrigger()
        call TriggerRegisterUserUnitEvent(t, EVENT_PLAYER_UNIT_ISSUED_ORDER)
        call TriggerAddCondition(t, Condition(function T4R))
        set t = null
    endfunction

endscope
