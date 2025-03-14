
scope Morphling

    globals
        constant integer HERO_INDEX_MORPHLING = 4
    endglobals
    //***************************************************************************
    //*
    //*  波浪形态
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_WAVE_FORM = GetHeroSKillIndexBySlot(HERO_INDEX_MORPHLING, 1)
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

    //***************************************************************************
    //*
    //*  敏捷转换
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_MORPH = GetHeroSKillIndexBySlot(HERO_INDEX_MORPHLING, 3)
    endglobals
    function Z9R takes unit trigUnit, integer VVI, real VEI returns nothing
        local integer agi = GetHeroAgi(trigUnit, false)
        local integer str = GetHeroStr(trigUnit, false)
        local real mp = GetUnitState(trigUnit, UNIT_STATE_MANA)
        if VVI == 0 then
            if mp >= VEI and agi -LoadInteger(OtherHashTable, GetHandleId(trigUnit), 31)> 2 and IsUnitDeath(trigUnit) == false and agi > PC then
                call SetUnitState(trigUnit, UNIT_STATE_MANA, mp -VEI)
                call SetHeroAgi(trigUnit, agi -2, true)
                call SetHeroStr(trigUnit, str + 2, true)
            endif
        elseif VVI == 1 then
            if mp >= VEI and str -LoadInteger(OtherHashTable, GetHandleId(trigUnit), 30)-LoadInteger(OtherHashTable, GetHandleId(trigUnit),'ARML')> 4 and IsUnitDeath(trigUnit) == false and str > PC then
                call SetUnitState(trigUnit, UNIT_STATE_MANA, mp -VEI)
                call SetHeroAgi(trigUnit, agi + 2, true)
                call SetHeroStr(trigUnit, str -2, true)
            endif
        endif
    endfunction
    function VXI takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit trigUnit =(LoadUnitHandle(HY, h, 14))
        local integer level = GetUnitAbilityLevel(trigUnit,'A0KX')
        call Z9R(trigUnit, 1, 30. / level)
        set t = null
        set trigUnit = null
        return false
    endfunction
    function VOI takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit trigUnit =(LoadUnitHandle(HY, h, 14))
        local integer level = GetUnitAbilityLevel(trigUnit,'A0KX')
        call Z9R(trigUnit, 0, 30. / level)
        set t = null
        set trigUnit = null
        return false
    endfunction
    function VRI takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit u = GetTriggerUnit()
        local trigger VII =(LoadTriggerHandle(HY, h, 226))
        local integer level = GetUnitAbilityLevel(u,'A0KX')
        local integer lastorder =(LoadInteger(HY, h, 227))
        local real VEI = 1. / level
        if VEI == .25 then
            set VEI = .2
        endif
        if GetIssuedOrderId() == 852549 then
            if VII != null then
                call FlushChildHashtable(HY,(GetHandleId(VII)))
                call DestroyTrigger(VII)
            endif
            set VII = CreateTrigger()
            call TriggerRegisterTimerEvent(VII, VEI, true)
            call TriggerAddCondition(VII, Condition(function VXI))
            call SaveUnitHandle(HY,(GetHandleId(VII)), 14,(u))
            call SaveTriggerHandle(HY, h, 226,(VII))
            call SaveInteger(HY, h, 227,(GetIssuedOrderId()))
            call UnitAddAbility(u,'A22L')
            call UnitRemoveAbility(u,'A22T')
        elseif GetIssuedOrderId() == 852546 then
            if VII != null then
                call FlushChildHashtable(HY,(GetHandleId(VII)))
                call DestroyTrigger(VII)
            endif
            set VII = CreateTrigger()
            call TriggerRegisterTimerEvent(VII, VEI, true)
            call TriggerAddCondition(VII, Condition(function VOI))
            call SaveUnitHandle(HY,(GetHandleId(VII)), 14,(u))
            call SaveTriggerHandle(HY, h, 226,(VII))
            call SaveInteger(HY, h, 227,(GetIssuedOrderId()))
            call UnitAddAbility(u,'A22T')
            call UnitRemoveAbility(u,'A22L')
        elseif GetIssuedOrderId()== 852550 then
            if VII != null then
                call FlushChildHashtable(HY,(GetHandleId(VII)))
                call DestroyTrigger(VII)
            endif
            call SaveTriggerHandle(HY, h, 226,(null))
            call SaveInteger(HY, h, 227,(GetIssuedOrderId()))
            call UnitRemoveAbility(u,'A22L')
            call UnitRemoveAbility(u,'A22T')
        elseif GetIssuedOrderId()== 852547 then
            if VII != null then
                call FlushChildHashtable(HY,(GetHandleId(VII)))
                call DestroyTrigger(VII)
            endif
            call SaveTriggerHandle(HY, h, 226,(null))
            call SaveInteger(HY, h, 227,(GetIssuedOrderId()))
            call UnitRemoveAbility(u,'A22L')
            call UnitRemoveAbility(u,'A22T')
        elseif GetIssuedOrderId()== 852548 then
            if IssueImmediateOrderById(u, 852549) == false then
                call IssueImmediateOrderById(u, 852550)
            endif
        elseif GetIssuedOrderId()== 852545 then
            if IssueImmediateOrderById(u, 852546) == false then
                call IssueImmediateOrderById(u, 852547)
            endif
        endif
        set t = null
        set u = null
        set VII = null
        return false
    endfunction
    function MorphOnLearn takes nothing returns nothing
        local unit trigUnit = GetTriggerUnit()
        local trigger t
        local integer h
        local integer level = GetUnitAbilityLevel(trigUnit,'A0KX')
        if level == 1 then
            set t = CreateTrigger()
            set h = GetHandleId(t)
            call UnitAddPermanentAbility(trigUnit, 'A0KW')
            call TriggerRegisterUnitEvent(t, trigUnit, EVENT_UNIT_ISSUED_ORDER)
            call TriggerAddCondition(t, Condition(function VRI))
            call SaveTriggerHandle(HY, h, 226,(null))
            set t = null
        else
            call SetUnitAbilityLevel(trigUnit, 'A0KW', level)
        endif
        set trigUnit = null
        set t = null
    endfunction

    //***************************************************************************
    //*
    //*  复制
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_REPLICATE = GetHeroSKillIndexBySlot(HERO_INDEX_MORPHLING, 4)
    endglobals
    
    function Z1R takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local unit targetUnit =(LoadUnitHandle(HY, h, 17))
        local integer count =(LoadInteger(HY, h, 34))-1
        local texttag tt
        call SaveInteger(HY, h, 34,(count))
        if GetTriggerEvalCount(t) == 1 then
            call RemoveSavedHandle(HY, h,'0ILU')
        endif
        if GetTriggerEventId() == EVENT_UNIT_DEATH then
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        else
            set tt = CreateTextTag()
            call SetTextTagText(tt, I2S(count), .03)
            call SetTextTagPosUnit(tt, whichUnit, 0)
            call SetTextTagColorBJ(tt, 0, 29, 255, 15)
            call SetTextTagVelocity(tt, 0, .035)
            call SetTextTagFadepoint(tt, 3)
            call SetTextTagLifespan(tt, .9)
            call SetTextTagPermanent(tt, false)
            call SetTextTagVisibility(tt, GetOwningPlayer(whichUnit) == LocalPlayer)
            set tt = CreateTextTag()
            call SetTextTagText(tt, I2S(count), .03)
            call SetTextTagPosUnit(tt, targetUnit, 0)
            call SetTextTagColorBJ(tt, 0, 29, 255, 15)
            call SetTextTagVelocity(tt, 0, .035)
            call SetTextTagFadepoint(tt, 3)
            call SetTextTagLifespan(tt, .9)
            call SetTextTagPermanent(tt, false)
            call SetTextTagVisibility(tt, GetOwningPlayer(whichUnit) == LocalPlayer)
        endif
        set t = null
        set tt = null
        set whichUnit = null
        set targetUnit = null
        return false
    endfunction
    function Z2R takes nothing returns nothing
        local trigger t = GetTriggeringTrigger()
        local unit trigUnit =(LoadUnitHandle(HY,(GetHandleId(t)), 14))
        local unit Z3R =(LoadUnitHandle(HY,(GetHandleId(trigUnit)), 229))
        call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl", GetUnitX(Z3R), GetUnitY(Z3R)))
        call RemoveUnit(Z3R)
        //call UnitRemoveAbility(trigUnit,('A0GC'))

        call ToggleSkill.SetState(trigUnit, 'A0G8', false)

        call FlushChildHashtable(HY,(GetHandleId(t)))
        call DestroyTrigger((t))
        set trigUnit = null
        set Z3R = null
        set t = null
    endfunction
    function Z4R takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer h = GetHandleId(t)
        local unit KKX = LoadUnitHandle(HY, h, 0)
        local unit Z5R = LoadUnitHandle(HY, h, 1)
        local real x = GetUnitX(Z5R)
        local real y = GetUnitY(Z5R)
        if IsUnitDeath(KKX) == false and IsUnitDeath(Z5R) == false then
            call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl", x, y))
            call SetUnitPosition(Z5R, GetUnitX(KKX), GetUnitY(KKX))
            call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl", GetUnitX(KKX), GetUnitY(KKX)))
            call SetUnitPosition(KKX, x, y)
            call PanCameraToTimedForPlayer(GetOwningPlayer(KKX), x, y, 0)
        endif
        call PauseTimer(t)
        call FlushChildHashtable(HY, h)
        call DestroyTimer(t)
        set KKX = null
        set Z5R = null
        set t = null
    endfunction
    function Z6R takes unit KKX, unit Z5R returns nothing
        local timer t = CreateTimer()
        local integer h = GetHandleId(t)
        call TimerStart(t, 0, false, function Z4R)
        call SaveUnitHandle(HY, h, 0, KKX)
        call SaveUnitHandle(HY, h, 1, Z5R)
        set t = null
    endfunction
    function ENE takes nothing returns nothing
        call Z6R(GetTriggerUnit(), LoadUnitHandle(HY, GetHandleId(GetTriggerUnit()), 229))
    endfunction
    function Z7R takes nothing returns boolean
        return GetUnitAbilityLevel(GetSummonedUnit(),('B030'))> 0 and GetWidgetLife(GetSummonedUnit())> 0
    endfunction
    function Z8R takes nothing returns nothing
        local unit u
        local integer h
        local unit targetUnit
        local unit Z3R = GetSummonedUnit()
        local trigger t
        set u = GetSummoningUnit()
        if IsUnitDummy(u) and HaveSavedHandle(HY, GetHandleId(u), 0) then
            set u = LoadUnitHandle(HY, GetHandleId(u), 0)
        endif
        set h = GetHandleId(u)
        set targetUnit = LoadUnitHandle(HY, h, 228)
        // call SetPlayerAbilityAvailableEx(GetOwningPlayer(u),'A0G8', false)
        // if GetUnitAbilityLevel(u,'A0G8')> 0 then
        //     call UnitAddPermanentAbility(u,'A0GC')
        // endif

        call BJDebugMsg("targetUnit:" + GetUnitName(targetUnit))
        call ToggleSkill.SetState(targetUnit, 'A0G8', true)

        call SetUnitColor(Z3R, GetPlayerColor(GetOwningPlayer(targetUnit)))
        call SaveUnitHandle(HY, h, 229, Z3R)
        set t = CreateTrigger()
        call TriggerRegisterUnitEvent(t, u, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, Z3R, EVENT_UNIT_DEATH)
        call TriggerAddAction(t, function Z2R)
        call SaveUnitHandle(HY, GetHandleId(t), 14, u)
        set t = CreateTrigger()
        call TriggerRegisterUnitEvent(t, u, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(t, Z3R, EVENT_UNIT_DEATH)
        call TriggerRegisterTimerEvent(t, 1, true)
        call TriggerAddCondition(t, Condition(function Z1R))
        call SaveUnitHandle(HY, GetHandleId(t), 2, u)
        call SaveUnitHandle(HY, GetHandleId(t), 17, Z3R)
        call SaveInteger(HY, GetHandleId(t), 34, GetUnitAbilityLevel(u,'A0G8')* 15+ 15-1)
        set u = null
        set targetUnit = null
        set Z3R = null
        set t = null
    endfunction
    function ReplicateOnSpellEffect takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local unit t = GetSpellTargetUnit()
        if IsUnitDummy(u) and HaveSavedHandle(HY, GetHandleId(u), 0) then
            set u = LoadUnitHandle(HY, GetHandleId(u), 0)
        endif
        call SaveUnitHandle(HY,(GetHandleId(u)), 228,(t))
        if IsUnitIllusion(t) then
            call SaveUnitHandle(HY, GetHandleId(u),'0ILU', LoadUnitHandle(HY, GetHandleId(t),'0ILU'))
        else
            call SaveUnitHandle(HY, GetHandleId(u),'0ILU', t)
        endif
        set u = null
        set t = null
    endfunction
    function ReplicateOnInitializer takes nothing returns nothing
        local trigger t
        set t = CreateTrigger()
        call TriggerRegisterAnyUnitEvent(t, EVENT_PLAYER_UNIT_SUMMON)
        call TriggerAddCondition(t, Condition(function Z7R))
        call TriggerAddAction(t, function Z8R)
        set t = null
    endfunction
endscope
