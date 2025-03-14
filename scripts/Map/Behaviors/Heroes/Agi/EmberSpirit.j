
scope EmberSpirit

    globals
        constant integer HERO_INDEX_EMBER_SPIRIT = 54
    endglobals
    //***************************************************************************
    //*
    //*  无影拳
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_SLEIGHT_OF_FIST = GetHeroSKillIndexBySlot(HERO_INDEX_CHAOS_KOTO_BEAST, 2)
    endglobals
    function KUA takes nothing returns nothing
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = LoadUnitHandle(HY, h, 0)
        local unit targetUnit = LoadUnitHandle(HY, h, 1)
        local group g = LoadGroupHandle(HY, h, 2)
        local group gg = LoadGroupHandle(HY, h, 3)
        if GetTriggerEventId() == EVENT_UNIT_DAMAGED then
            if GetEventDamageSource() == whichUnit and SpellDamageCount < 1 then
                call GroupAddUnit(g, targetUnit)
                call GroupRemoveUnit(gg, targetUnit)
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
            endif
        else
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        endif
        set whichUnit = null
        set targetUnit = null
        set t = null
    endfunction
    function KYA takes unit whichUnit, unit targetUnit, integer level returns nothing
        local real a = GetRandomReal(0, 360)
        local real x = GetUnitX(targetUnit)+ 50 * Cos(a * bj_DEGTORAD)
        local real y = GetUnitY(targetUnit)+ 50 * Sin(a * bj_DEGTORAD)
        local trigger t = null
        local integer h
        call SetUnitPosition(whichUnit, x, y)
        call SetUnitFacing(whichUnit, bj_RADTODEG * Atan2(GetUnitY(targetUnit)-GetUnitY(whichUnit), GetUnitX(targetUnit)-GetUnitX(whichUnit)))
        call SetUnitAnimation(whichUnit, "Attack")
        call DestroyEffect(AddSpecialEffectTarget("war3mapImported\\Fire_Blink_2.mdx", whichUnit, "chest"))
        call KMA(whichUnit)
        if IsUnitType(targetUnit, UNIT_TYPE_HERO) or IsUnitIllusion(targetUnit) then
            call KTA(whichUnit, level)
            call UnitRemoveAbility(whichUnit,'A2JF')
            if Mode__BalanceOff == false then
                if (GetUnitAbilityLevel(whichUnit,'A1J2')> 0) then
                    call SetUnitAbilityLevel(whichUnit,'A1J2', 2)
                elseif (GetUnitAbilityLevel(whichUnit,'A1IT')> 0) then
                    call SetUnitAbilityLevel(whichUnit,'A1IT', 2)
                elseif (GetUnitAbilityLevel(whichUnit,'A1J1')> 0) then
                    call SetUnitAbilityLevel(whichUnit,'A1J1', 2)
                elseif (GetUnitAbilityLevel(whichUnit,'A1J0')> 0) then
                    call SetUnitAbilityLevel(whichUnit,'A1J0', 2)
                endif
            endif
        else
            // 对小兵50%伤害
            call UnitAddPermanentAbility(whichUnit,'A2JF')
            call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A2JF', false)
        endif

        if IssueTargetOrderById(whichUnit, 851983, targetUnit) then
            set t = CreateTrigger()
            call TriggerRegisterUnitEvent(t, targetUnit, EVENT_UNIT_DAMAGED)
            call TriggerRegisterTimerEvent(t, .2, false)
            call TriggerAddCondition(t, Condition(function KUA))
            set h = GetHandleId(t)
            call SaveUnitHandle(HY, h, 0, whichUnit)
            call SaveUnitHandle(HY, h, 1, targetUnit)
            call SaveGroupHandle(HY, h, 2, LoadGroupHandle(HY, GetHandleId(GetTriggeringTrigger()), 187))
            call SaveGroupHandle(HY, h, 3, LoadGroupHandle(HY, GetHandleId(GetTriggeringTrigger()), 22))
            set t = null
        else
            call GroupAddUnit(LoadGroupHandle(HY, GetHandleId(GetTriggeringTrigger()), 187), targetUnit)
            call GroupRemoveUnit(LoadGroupHandle(HY, GetHandleId(GetTriggeringTrigger()), 22), targetUnit)
        endif
    endfunction
    // 移除所有缠绕效果
    function KZA takes unit u returns nothing
        call UnitDispelDisableMoveBuff(u)
    endfunction
    function SleightOfFistUpdateAttack takes nothing returns boolean
        local trigger     t = GetTriggeringTrigger()
        local integer     h = GetHandleId(t)
        local unit        u = LoadUnitHandle(HY, h, 2)
        local real        x = LoadReal(HY, h, 6)
        local real        y = LoadReal(HY, h, 7)
        local group       targGroup = LoadGroupHandle(HY, h, 187)
        local group       g = LoadGroupHandle(HY, h, 22)
        local unit        target = null
        local boolean     b = false
        local fogmodifier fm = LoadFogModifierHandle(HY, h, 42)
        local trigger     tt
        loop
        exitwhen FirstOfGroup(g) == null or b
            set target = FirstOfGroup(g)
            call GroupRemoveUnit(g, target)
            if IsUnitDeath(target) then
                call GroupRemoveUnit(g, target)
            elseif IsUnitInGroup(target, targGroup) and target != null then
                set target = null
                set b = false
            else
                set b = true
            endif
        endloop
        call KZA(u)
        if b == false or(LoadInteger(HY, GetHandleId(u), 4319)) == 1 or IsUnitDeath(u) then
            call SaveInteger(HY, GetHandleId(u), 4318, 2)
            call KLA(u)
            call UnitRemoveAbility(u,'QF90')
            call UnitRemoveAbility(u,'QF91')
            call UnitRemoveAbility(u,'QF92')
            call UnitRemoveAbility(u,'QF93')
            call UnitRemoveAbility(u,'QF94')
            call UnitRemoveAbility(u,'QF95')
            call UnitRemoveAbility(u,'A2JF')
            call KMA(u)
            call KZA(u)
            call KKA(u)
            //	call UnitAddAbility(u,'A2H2')
            //	call UnitRemoveAbility(u,'A2H2')
            call SetPlayerAbilityAvailable(GetOwningPlayer(u),'A1UL', true)
            //	call RAX(u, LoadInteger(HY, h, 25))
            call YDWEUnitTransform( u, LoadInteger(ExtraHT, GetHandleId(u), HTKEY_UNIT_ORIGIN_TYPEID ) )
            call SetUnitCurrentScaleEx(u, GetUnitCurrentScale(u))
            //call FixUnitSkillsBug(u)
            if (LoadInteger(HY, GetHandleId(u), 4319) == 1) == false then
                call SetUnitX(u, LoadReal(HY, h, 189))
                call SetUnitY(u, LoadReal(HY, h, 190))
            endif
            call ResetUnitVertexColor(u)
            call SetUnitVertexColorEx(u,-1,-1,-1, 255)
            call UnitDecNoPathingCount(u)
            call UnitDecInvulnerableCount(u)
            if GetUnitAbilityLevel(u,'A0MQ')+ GetUnitAbilityLevel(u,'A1B6')> 0 then
                call SetPlayerAbilityAvailable(GetOwningPlayer(u),'A0MQ', true)
                call SetPlayerAbilityAvailable(GetOwningPlayer(u),'A1B6', true)
            endif
            call SetUnitTimeScale(u, 1)
            call DeallocateGroup(targGroup)
            call DeallocateGroup(g)
            call RemoveUnit((LoadUnitHandle(HY, h, 19)))
            call FogModifierStop(fm)
            call DestroyFogModifier(fm)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        else
            call GroupAddUnit(targGroup, target)
            call KYA(u, target, LoadInteger(HY, h, 0) )
        endif
        set fm = null
        set t = null
        set u = null
        set target = null
        set g = null
        set tt = null
        set targGroup = null
        return false
    endfunction
    function SleightOfFistDelay takes nothing returns nothing
        local timer       t = GetExpiredTimer()
        local integer     h = GetHandleId(t)
        local unit        u = LoadUnitHandle(HY, h, 0)
        local real        x = LoadReal(HY, h, 1)
        local real        y = LoadReal(HY, h, 2)
        local integer     lv = LoadInteger(HY, h, 0)
        local trigger     tt = CreateTrigger()
        local integer     th = GetHandleId(tt)
        local fogmodifier fm = CreateFogModifierRadius(GetOwningPlayer(u), FOG_OF_WAR_VISIBLE, x, y, 600, true, true)
        local unit        dummyCaster = CreateUnit(GetOwningPlayer(u),'h0E7', GetUnitX(u), GetUnitY(u), GetUnitFacing(u))
        local group       g  = AllocationGroup(465)
        local group       targGroup  = AllocationGroup(466)
        local integer     id = O5X(GetUnitTypeId(u))
        local real        modelScale
        local unit        first
        local real        area = 150 + 100 * lv
        local player      p    = GetOwningPlayer(u)
        
        call FlushChildHashtable(HY, h)
        call DestroyTimer(t)

        call UnitRemoveAbility(u,'B01N')
        call UnitRemoveAbility(u,'Aetl')
        call SetUnitVertexColor(dummyCaster, 255, 255, 255, 100)
        call FogModifierStart(fm)
        call SaveInteger(HY, GetHandleId(u), 4318, 1)

        call GroupEnumUnitsInRange(g, x, y, area, null)
        loop
            set first = FirstOfGroup(g)
            exitwhen first == null
            call GroupRemoveUnit(g, first)
            if IsAliveNotStrucNotWard(first) and IsUnitInRangeXY(first, x, y, area) and IsUnitVisibleToPlayer(first, p) and IsUnitEnemy(first, p) then
                call GroupAddUnit(targGroup, first)
            endif
        endloop

        call DeallocateGroup(g)

        call KZA(u)
        call KKA(u)
        if GetUnitAbilityLevel(u,'A0MQ')+ GetUnitAbilityLevel(u,'A1B6')> 0 then
            call SetPlayerAbilityAvailable(GetOwningPlayer(u),'A0MQ', false)
            call SetPlayerAbilityAvailable(GetOwningPlayer(u),'A1B6', false)
        endif
        call SetPlayerAbilityAvailable(GetOwningPlayer(u),'A1UL', false)
        
        //call YDWEUnitTransform(u,'N0MH')

        // 获取火猫的模型缩放后
        set modelScale = SetUnitCurrentScaleEx(u, GetUnitCurrentScale(u))
        call SetUnitScale(dummyCaster, modelScale, modelScale, modelScale)
        //call MHUnit_SetModel(dummyCaster, MHUnit_GetDefDataStr(GetUnitTypeId(u), UNIT_DEF_DATA_MODEL), false)

        //call FixUnitSkillsBug(u)
        call SetUnitVertexColorEx(u, -1, -1, -1, 125)
        call UnitIncNoPathingCount(u)
        call UnitIncInvulnerableCount(u)
        call SetUnitTimeScale(u, 3)
        call TriggerRegisterTimerEvent(tt, .2, true)
        call TriggerAddCondition(tt, Condition(function SleightOfFistUpdateAttack))
        call SaveUnitHandle(HY, th, 2, u)
        call SaveInteger(HY, th, 0, lv)
        call SaveReal(HY, th, 6, x * 1.)
        call SaveReal(HY, th, 7, y * 1.)
        call SaveReal(HY, th, 189, GetUnitX(u)* 1.)
        call SaveReal(HY, th, 190, GetUnitY(u)* 1.)
        call SaveGroupHandle(HY, th, 187, AllocationGroup(466))
        call SaveGroupHandle(HY, th, 22, targGroup)
        call SaveFogModifierHandle(HY, th, 42, fm)
        call SaveUnitHandle(HY, th, 19, dummyCaster)
        call KSA(u)
        call TriggerEvaluate(tt)
        set u = null
        set t = null
        set fm = null
        set dummyCaster = null
        set g = null
        set tt = null
    endfunction
    function SleightOfFistOnSpellEffect takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local real x = GetSpellTargetX()
        local real y = GetSpellTargetY()
        local integer level = GetUnitAbilityLevel(u,'A2H0')+ GetUnitAbilityLevel(u,'QB0L')
        local timer t = CreateTimer()
        local integer h = GetHandleId(t)
        call SaveUnitHandle(HY, h, 0, u)
        call SaveReal(HY, h, 1, x)
        call SaveReal(HY, h, 2, y)
        call SaveInteger(HY, h, 0, level)
        call TimerStart(t, 0, false, function SleightOfFistDelay)
        set t = null
        set u = null
    endfunction

    //***************************************************************************
    //*
    //*  火之余烬
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_FIRE_REMNANT         = GetHeroSKillIndexBySlot(HERO_INDEX_EMBER_SPIRIT, 4)
        constant integer ACTIVATE_FIRE_REMNANT_ABILITY_ID = 'A2JL'
        constant key FIRE_REMNANT_KEY

	    integer array FireRemnantDummyAbilitys
    endglobals

    function FireRemnantOnUpdateChagres takes nothing returns boolean
        local trigger t                = GetTriggeringTrigger()
        local integer h                = GetHandleId(t)
        local unit    whichUnit        = (LoadUnitHandle(HY, h, 2))
        local integer fireRemnantCount = GetUnitAbilityCharges(whichUnit, HeroSkill_BaseId[SKILL_INDEX_FIRE_REMNANT])
        local integer cooldownCount    = (LoadInteger(HY, h, 34))
        if fireRemnantCount < 3 then
            set cooldownCount = cooldownCount -1
            call SaveInteger(HY, h, 34, (cooldownCount))
            if cooldownCount == 0 then
                if fireRemnantCount == 0 then
                    call UnitEnableAbility(whichUnit, HeroSkill_BaseId[SKILL_INDEX_FIRE_REMNANT], false)
                endif
                set fireRemnantCount = fireRemnantCount + 1
                call SetUnitAbilityCharges(whichUnit, HeroSkill_BaseId[SKILL_INDEX_FIRE_REMNANT], fireRemnantCount)
                set cooldownCount = 35
                call SaveInteger(HY, h, 34,(cooldownCount))
            endif
        endif
        set t = null
        set whichUnit = null
        return false
    endfunction
    // function P4X takes nothing returns nothing
    //     set FireRemnantDummyAbilitys[0]='A2JO'
    //     set FireRemnantDummyAbilitys[1]='A2JQ'
    //     set FireRemnantDummyAbilitys[2]='A2JP'
    //     set FireRemnantDummyAbilitys[3]='A2JR'
    // endfunction
    // function LPA takes nothing returns nothing
    //     local unit whichUnit = GetTriggerUnit()
    //     local trigger t = CreateTrigger()
    //     local integer h = GetHandleId(t)
    //     call SaveInteger(HY,(GetHandleId(whichUnit)), 747, 3)
    //     call UnitAddPermanentAbility(whichUnit, FireRemnantDummyAbilitys[3])
    //     call TriggerRegisterTimerEvent(t, 1, true)
    //     call TriggerAddCondition(t, Condition(function FireRemnantOnUpdateChagres))
    //     call SaveUnitHandle(HY, h, 2,(whichUnit))
    //     call SaveInteger(HY, h, 34, 30)
    //     set whichUnit = null
    //     set t = null
    // endfunction
    
    function FireRemnantOnAdd takes nothing returns nothing
        local unit    whichUnit = Event.GetTriggerUnit()
        local trigger trig
        local integer h
        if not IsUnitType(whichUnit, UNIT_TYPE_HERO) then
            set whichUnit = null
            return
        endif

        set trig = CreateTrigger()
        set h    = GetHandleId(trig)
        call TriggerRegisterTimerEvent(trig, 1, true)
        call TriggerAddCondition(trig, Condition(function FireRemnantOnUpdateChagres))
        call SaveUnitHandle(HY, h, 2,(whichUnit))
        call SaveInteger(HY, h, 34, 35)
        set Table[GetHandleId(whichUnit)].trigger[FIRE_REMNANT_KEY] = trig
        set trig = null
        
        call UnitAddPermanentAbility(whichUnit, ACTIVATE_FIRE_REMNANT_ABILITY_ID)
        call SetUnitAbilityCharges(whichUnit, HeroSkill_BaseId[SKILL_INDEX_FIRE_REMNANT], 3)

        set whichUnit = null
    endfunction
    function FireRemnantOnRemove takes nothing returns nothing
        local unit    whichUnit = Event.GetTriggerUnit()
        local trigger trig
        if not IsUnitType(whichUnit, UNIT_TYPE_HERO) then
            set whichUnit = null
            return
        endif

        set trig = Table[GetHandleId(whichUnit)].trigger[FIRE_REMNANT_KEY]
        call FlushChildHashtable(HY, GetHandleId(trig))
        call DestroyTrigger(trig)
        set trig = null

        call UnitRemoveAbility(whichUnit, ACTIVATE_FIRE_REMNANT_ABILITY_ID)
        set whichUnit = null
    endfunction

    function K4A takes nothing returns boolean
        local unit whichUnit =(LoadUnitHandle(HY,(GetHandleId(GetTriggeringTrigger())), 2))
        local integer h = GetHandleId(whichUnit)
        local integer i = 0
        local real ECX =(GetGameTime())
        local integer K5A =(LoadInteger(HY, h, 749))
        local real x
        local real y
        local real t
        loop
        exitwhen i > K5A
            set t =(LoadReal(HY, h,( 10000+ i)))
            if t + 10> ECX then
                set x =(LoadReal(HY, h,( 11000+ i)))
                set y =(LoadReal(HY, h,( 12000+ i)))
            endif
            set i = i + 1
        endloop
        set whichUnit = null
        return false
    endfunction
    function LEA takes nothing returns nothing
        local unit whichUnit = GetTriggerUnit()
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        call TriggerRegisterTimerEvent(t, .5, true)
        call TriggerAddCondition(t, Condition(function K4A))
        call SaveUnitHandle(HY, h, 2,(whichUnit))
        set whichUnit = null
        set t = null
    endfunction

    function FireRemnantOnLearn takes nothing returns nothing
        // call UnitAddPermanentAbility(GetTriggerUnit(),'A2JL')
        call SetUnitAbilityLevel(GetTriggerUnit(),'A2JL', GetUnitAbilityLevel(GetTriggerUnit(),'A2JK'))
        // if GetUnitAbilityLevel(GetTriggerUnit(),'A2JK') == 1 then
        //     call LPA()
        //     call LEA()
        // endif
    endfunction
    
    function LBA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local unit L3R =(LoadUnitHandle(HY, h, 19))
        local real GRR = GetUnitX(L3R)
        local real GIR = GetUnitY(L3R)
        local real tx =(LoadReal(HY, h, 47))
        local real ty =(LoadReal(HY, h, 48))
        local real a = AngleBetweenXY(GRR, GIR, tx, ty)* bj_DEGTORAD
        local real targetX
        local real targetY
        local real d = GetDistanceBetween(GRR, GIR, tx, ty)
        local real VEI = GetHeroMoveSpeed(whichUnit)* 2.5 * .02
        if GetTriggerEventId() == EVENT_WIDGET_DEATH then
            call LRA(whichUnit, L3R)
            
            call DestroyTextTag(LoadTextTagHandle(HY, GetHandleId(L3R), 'time'))
            
            call DestroyEffect((LoadEffectHandle(HY, h, 175)))
            call DestroyEffect((LoadEffectHandle(HY, h, 176)))
            call DestroyEffect((LoadEffectHandle(HY, h, 177)))
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        elseif d < 2 then
            call FireRemnantTimeText(L3R , 45 - GetTriggerEvalCount(t) * .02)
            call SetUnitAnimationByIndex(L3R, 1)
        else
            if d < VEI then
                set targetX = tx
                set targetY = ty
            else
                set targetX = GRR + VEI * Cos(a)
                set targetY = GIR + VEI * Sin(a)
            endif
            call SetUnitX(L3R, targetX)
            call SetUnitY(L3R, targetY)
        endif
        set t = null
        set whichUnit = null
        set L3R = null
        return false
    endfunction
    function LCA takes nothing returns nothing
        local unit whichUnit = GetTriggerUnit()
        local real a = AngleBetweenXY(GetUnitX(whichUnit), GetUnitY(whichUnit), GetSpellTargetX(), GetSpellTargetY())* bj_DEGTORAD
        local integer h = GetHandleId(whichUnit)
        local integer LAA =(LoadInteger(HY, h, 746))
        local integer level = GetUnitAbilityLevel(whichUnit,'A2JK')
        local unit d = CreateUnit(GetOwningPlayer(whichUnit),'h0E8', GetUnitX(whichUnit), GetUnitY(whichUnit), a * bj_RADTODEG)
        local trigger t
        local integer i = 1
        set LAA = LAA + 1
        call SaveUnitHandle(HY, h,( 1450+ LAA),(d))
        call SaveInteger(HY, h, 746,(LAA))
        set t = CreateTrigger()
        set h = GetHandleId(t)
        call SetUnitVertexColor(d, 255, 255, 255, 75)
        call SetUnitTimeScale(d, 2)
        call SetUnitAnimationByIndex(d, 0)
        call TriggerRegisterTimerEvent(t, .02, true)
        call TriggerAddCondition(t, Condition(function LBA))
        call TriggerRegisterDeathEvent(t, d)
        call UnitApplyTimedLife(d,'BTLF', 45)
        
        call SaveTextTagHandle(HY, GetHandleId(d), 'time', CreateTextTag())
        
        call SaveEffectHandle(HY, h, 175,(AddSpecialEffectTarget("war3mapImported\\Phoenix_Missile_smaller.mdx", d, "hand right alternate")))
        call SaveEffectHandle(HY, h, 176,(AddSpecialEffectTarget("war3mapImported\\Phoenix_Missile_smaller.mdx", d, "hand left alternate")))
        call SaveEffectHandle(HY, h, 177,(AddSpecialEffectTarget("war3mapImported\\FlameDash_Ground.mdx", d, "origin")))
        call SaveUnitHandle(HY, h, 2,(whichUnit))
        call SaveUnitHandle(HY, h, 19,(d))
        call SaveReal(HY, h, 47, CoordinateX50((GetSpellTargetX())* 1.))
        call SaveReal(HY, h, 48, CoordinateY50((GetSpellTargetY())* 1.))
        set whichUnit = null
        set t = null
        set d = null
    endfunction
    function FireRemnantOnSpellEffect takes nothing returns nothing
        local unit    whichUnit = GetTriggerUnit()
        local integer count     = GetUnitAbilityCharges(whichUnit, HeroSkill_BaseId[SKILL_INDEX_FIRE_REMNANT])
        if count > 0 then
            call LCA()
            set count = count - 1
            call SetUnitAbilityCharges(whichUnit, HeroSkill_BaseId[SKILL_INDEX_FIRE_REMNANT], count)
            if count == 0 then
                call UnitDisableAbility(whichUnit, HeroSkill_BaseId[SKILL_INDEX_FIRE_REMNANT], false)
            endif
            // call UnitRemoveAbility(whichUnit, FireRemnantDummyAbilitys[fireRemnantCount])
            // set fireRemnantCount = fireRemnantCount -1
            // call SaveInteger(HY,(GetHandleId(whichUnit)), 747,(fireRemnantCount))
            // call UnitAddPermanentAbility(whichUnit, FireRemnantDummyAbilitys[fireRemnantCount])
        else
            call InterfaceErrorForPlayer(GetOwningPlayer(GetTriggerUnit()), "充能点数不足")
        endif
        set whichUnit = null
    endfunction
    function LDA takes nothing returns boolean
        return GetUnitTypeId(GetFilterUnit())=='h0E8'
    endfunction
    function LFA takes nothing returns nothing
        local real GIX = GetDistanceBetween(GetUnitX(GetEnumUnit()), GetUnitY(GetEnumUnit()), QHV, QJV)
        if GIX > QKV and IsUnitDeath(GetEnumUnit()) == false then
            set QLV = GetEnumUnit()
            set QKV = GIX
        endif
    endfunction
    function LGA takes unit whichUnit, real x, real y returns unit
        local group g = AllocationGroup(469)
        set QLV = null
        set QKV =-1
        set QHV = x
        set QJV = y
        call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(whichUnit), Condition(function LDA))
        call ForGroup(g, function LFA)
        call DeallocateGroup(g)
        set g = null
        return QLV
    endfunction
    function LHA takes unit u1, unit u2 returns real
        local real LJA = GetUnitDistanceEx(u1, u2)
        local real time = LJA / 1300.
        if time > .4 then
            return LJA / .4
        endif
        return 1300.
    endfunction
    function LKA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local real XVA =(LoadReal(HY, h, 47))
        local real XEA =(LoadReal(HY, h, 48))
        local unit L3R =(LoadUnitHandle(HY, h, 19))
        local real GRR = GetUnitX(whichUnit)
        local real GIR = GetUnitY(whichUnit)
        local real tx =(LoadReal(HY, h, 6))
        local real ty =(LoadReal(HY, h, 7))
        local real a
        local real targetX
        local real targetY
        local real d
        local real speed =(LoadReal(HY, h, 44))
        local real VEI = speed * .02
        local group g
        local integer count =(LoadInteger(HY, h, 34))
        if L3R != null then
            set tx = GetUnitX(L3R)
            set ty = GetUnitY(L3R)
            call SaveReal(HY, h, 6,((tx)* 1.))
            call SaveReal(HY, h, 7,((ty)* 1.))
        endif
        set a = AngleBetweenXY(GRR, GIR, tx, ty)* bj_DEGTORAD
        set d = GetDistanceBetween(GRR, GIR, tx, ty)
        if GetTriggerEventId() == EVENT_WIDGET_DEATH then
            call SaveInteger(HY, GetHandleId(whichUnit), 4319, 2)
            call ResetUnitVertexColor(whichUnit)
            call SetUnitVertexColorEx(whichUnit,-1,-1,-1, 255)
            call SetUnitTimeScale(whichUnit, 1)
            call SetUnitAnimationByIndex(whichUnit, 0)
            
            call UnitDecNoPathingCount(whichUnit)
            call UnitDecInvulnerableCount(whichUnit)
            // call SetUnitPathing(whichUnit, true)
            // call SetUnitInvulnerable(whichUnit, false)
            call UnitRemoveAbility(whichUnit,'A04R')
            call DestroyEffect((LoadEffectHandle(HY, h, 175)))
            call DestroyEffect((LoadEffectHandle(HY, h, 176)))
            call DestroyEffect((LoadEffectHandle(HY, h, 177)))
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        elseif d < VEI then
            call SetUnitX(whichUnit, tx)
            call SetUnitY(whichUnit,(ty))
            call KillTreeByCircle(tx, ty, 100)
            call SaveBoolean(OtherHashTable, GetHandleId(whichUnit), 99, true)
            call LOA(whichUnit, L3R, tx, ty)
            set L3R = LGA(whichUnit, XVA, XEA)
            if L3R == null then
                call SaveInteger(HY, GetHandleId(whichUnit), 4319, 2)
                call ResetUnitVertexColor(whichUnit)
                call SetUnitVertexColorEx(whichUnit,-1,-1,-1, 255)
                call SetUnitTimeScale(whichUnit, 1)
                call SetUnitAnimationByIndex(whichUnit, 1)

                call UnitDecNoPathingCount(whichUnit)
                call UnitDecInvulnerableCount(whichUnit)
                // call SetUnitPathing(whichUnit, true)
                // call SetUnitInvulnerable(whichUnit, false)

                call UnitRemoveAbility(whichUnit,'A04R')
                call DestroyEffect((LoadEffectHandle(HY, h, 175)))
                call DestroyEffect((LoadEffectHandle(HY, h, 176)))
                call DestroyEffect((LoadEffectHandle(HY, h, 177)))
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
            else
                call SaveInteger(HY, h, 34,(count + 1))
                call SaveUnitHandle(HY, h, 19,(L3R))
                call SaveReal(HY, h, 44,((LHA(whichUnit, L3R))* 1.))
                call SaveReal(HY, h, 6,((GetUnitX(L3R))* 1.))
                call SaveReal(HY, h, 7,((GetUnitY(L3R))* 1.))
            endif
        else
            call SetUnitAnimationByIndex(whichUnit, 0)
            //call SetUnitPathing(whichUnit, false)
            set targetX = GRR + VEI * Cos(a)
            set targetY = GIR + VEI * Sin(a)
            if IsUnitType(whichUnit, UNIT_TYPE_HERO) then
                call SaveBoolean(OtherHashTable, GetHandleId(whichUnit), 99, true)
            endif
            call SetUnitX(whichUnit,(targetX))
            call SetUnitY(whichUnit, targetY)
            call SaveBoolean(OtherHashTable, GetHandleId(whichUnit), 99, true)
            call KillTreeByCircle(targetX, targetY, 100)
            call SetUnitFacing(whichUnit, a * bj_RADTODEG)
        endif
        call K8A(whichUnit, count, GetUnitX(whichUnit), GetUnitY(whichUnit))
        set t = null
        set whichUnit = null
        set L3R = null
        set g = null
        return false
    endfunction
    function LLA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        call SetUnitState(whichUnit, UNIT_STATE_MANA, GetUnitState(whichUnit, UNIT_STATE_MANA) + 100)
        call FlushChildHashtable(HY, h)
        call DestroyTrigger(t)
        set t = null
        set whichUnit = null
        return false
    endfunction
    function ActivateFireRemnantOnSpellEffect takes nothing returns nothing
        local unit whichUnit = GetTriggerUnit()
        local trigger t
        local integer h = GetHandleId(whichUnit)
        local integer LAA =(LoadInteger(HY, h, 746))
        local unit L3R
        if LAA > 0 and LoadInteger(HY, GetHandleId(whichUnit), 4319) != 1 then
            set t = CreateTrigger()
            set h = GetHandleId(t)
            call SetUnitVertexColorEx(whichUnit, 255, 0, 0, 75)
            call SetUnitTimeScale(whichUnit, 2)
            call SetUnitAnimationByIndex(whichUnit, 0)

            call UnitIncNoPathingCount(whichUnit)
            call UnitIncInvulnerableCount(whichUnit)

            call UnitAddPermanentAbility(whichUnit,'A04R')
            
            call SaveInteger(HY, GetHandleId(whichUnit), 4319, 1)
            call TriggerRegisterTimerEvent(t, .02, true)
            call TriggerAddCondition(t, Condition(function LKA))
            call TriggerRegisterDeathEvent(t, whichUnit)
            call SaveEffectHandle(HY, h, 175,(AddSpecialEffectTarget("war3mapImported\\Phoenix_Missile_smaller.mdx", whichUnit, "hand right alternate")))
            call SaveEffectHandle(HY, h, 176,(AddSpecialEffectTarget("war3mapImported\\Phoenix_Missile_smaller.mdx", whichUnit, "hand left alternate")))
            call SaveEffectHandle(HY, h, 177,(AddSpecialEffectTarget("war3mapImported\\FlameDash_Ground.mdx", whichUnit, "origin")))
            call SaveUnitHandle(HY, h, 2,(whichUnit))
            call SaveReal(HY, h, 47,((GetSpellTargetX())* 1.))
            call SaveReal(HY, h, 48,((GetSpellTargetY())* 1.))
            set L3R = LGA(whichUnit, GetSpellTargetX(), GetSpellTargetY())
            call SaveUnitHandle(HY, h, 19,(L3R))
            call SaveReal(HY, h, 44,((LHA(whichUnit, L3R))* 1.))
            call SaveReal(HY, h, 6,((GetUnitX(L3R))* 1.))
            call SaveReal(HY, h, 7,((GetUnitY(L3R))* 1.))
            call SaveInteger(HY, h, 34, 1)
        else
            set t = CreateTrigger()
            set h = GetHandleId(t)
            call TriggerRegisterTimerEvent(t, .0, false)
            call TriggerAddCondition(t, Condition(function LLA))
            call SaveUnitHandle(HY, h, 2,(whichUnit))
        endif
        set t = null
        set whichUnit = null
        set L3R = null
    endfunction

endscope
