
scope Oracle

    globals
        constant integer HERO_INDEX_ORACLE = 112
    endglobals
    //***************************************************************************
    //*
    //*  气运之末
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_FORTUNE_END = GetHeroSKillIndexBySlot(HERO_INDEX_ORACLE, 1)
        
        constant integer FORTUNE_END_TARGET_BUFF_ID = 'B0GT'
        key ORACLE_FORTUNE_END_KEY
    endglobals
    
    function Q_R takes nothing returns nothing

    endfunction

    function FortuneEndBuffOnAdd takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        
        call UnitIncRootCount(whichUnit)

        set whichUnit = null
    endfunction
    function FortuneEndBuffOnRemove takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        
        call UnitDecRootCount(whichUnit)

        set whichUnit = null
    endfunction

    function FortuneEndOnInitializer takes nothing returns nothing
        call ResgiterAbilityMethodSimple(FORTUNE_END_TARGET_BUFF_ID, "FortuneEndBuffOnAdd", "FortuneEndBuffOnRemove")
    endfunction

    function FortuneEndOnMissileHit takes nothing returns nothing
        local unit    whichUnit  = TempUnit
        local unit    targetUnit = MissileHitTargetUnit
        local real    time       = Table[GetHandleId(whichUnit)].real[ORACLE_FORTUNE_END_KEY]
        local unit    dummyCast
        local real    area
        local real    tx
        local real    ty
        local integer level = Table[GetHandleId(whichUnit)].integer[ORACLE_FORTUNE_END_KEY]
        local real    damage = 40 + 60 * level
        local boolean isAlly = IsUnitAlly(whichUnit, GetOwningPlayer(targetUnit))
        
        init_group_variable()

        set tx   = GetUnitX(targetUnit)
        set ty   = GetUnitY(targetUnit)
        set area = 350.

        set dummyCast = CreateUnit(GetOwningPlayer(whichUnit), 'o00Z', GetUnitX(targetUnit), GetUnitY(targetUnit), 0)
        call UnitApplyTimedLife(dummyCast,'BTLF', .5)
        call UnitAddAbility(dummyCast, 'A594')
        call MHAbility_SetLevelDefDataReal('A594', 1, ABILITY_LEVEL_DEF_DATA_NORMAL_DUR, time)
        call MHAbility_SetLevelDefDataReal('A594', 1, ABILITY_LEVEL_DEF_DATA_HERO_DUR  , time)
        //call SetUnitOwner(dummyCast, GetOwningPlayer(targetUnit), true)

        if not UnitHasSpellShield(targetUnit) then

            start_group_enum(tx, ty, area)

            if IsUnitInRangeXY(first, tx, ty, area) and IsAliveNotStrucNotWard(first) then

                //call IssueTargetOrderById(dummyCast, 852111, first)
                if IsUnitEnemy(first, GetOwningPlayer(whichUnit)) then
                    call UnitDispelBuffs(first, false)
                    call ARX("war3mapImported\\FortunesEndTarget.mdx", first, "origin", 3)
                    call UnitRemoveAbility(first, 'A2T4')
                    call UnitDamageTargetEx(whichUnit, first, 1, damage)

                    call UnitAddBuffByPolarity(whichUnit, first, FORTUNE_END_TARGET_BUFF_ID, level, time, true, BUFF_LEVEL1)
                elseif isAlly then
                    call UnitDispelBuffs(first, false)
                    call ARX("war3mapImported\\FortunesEndTarget.mdx", first, "origin", 3)
                endif
                
            endif

            end_group_enum()

        else
            call UnitRemoveSpellShield(targetUnit)
        endif
        
        //call SetUnitOwner(dummyCast, GetOwningPlayer(whichUnit), true)

        if GetUnitAbilityLevel(targetUnit, 'A3E9') == 1 and not IsUnitMagicImmune(targetUnit) and not LoadBoolean(HY, GetHandleId(GetTriggeringTrigger()), 0) then 
            call SaveUnitHandle(OtherHashTable2, 'A3E9', 0, targetUnit) 
            call SaveUnitHandle(OtherHashTable2, 'A3E9', 1, whichUnit) 
            call SaveReal(OtherHashTable2, 'A3E9', 0, time) 
            call SaveInteger(OtherHashTable2, 'A3E9', 0, level) 
            call ExecuteFunc("FortuneEndMissileEchoShellBack") 
        endif 
        
        set dummyCast = LoadUnitHandle(HY, GetHandleId(GetTriggeringTrigger()), 45) 
        call S9V(dummyCast, time) 
        call SetUnitTimeScale(dummyCast, .8) 

        set dummyCast = null
        set whichUnit  = null
        set targetUnit  = null
    endfunction

    function FortuneEndMissileEchoShellBackSetUnitTimeScaleExpired takes nothing returns nothing
        local timer trg = GetExpiredTimer() 
        call SetUnitTimeScale(LoadUnitHandle(HY, GetHandleId(trg), 0), .1) 
        call FlushChildHashtable(HY, GetHandleId(trg)) 
        call DestroyTimer(trg) 
        set trg = null 
    endfunction

    function FortuneEndMissileEchoShellBack takes nothing returns nothing
        local unit    whichUnit  = LoadUnitHandle(OtherHashTable2, 'A3E9', 0) 
        local unit    targetUnit = LoadUnitHandle(OtherHashTable2, 'A3E9', 1) 
        local real    time       = LoadReal(OtherHashTable2, 'A3E9', 0) 
        local integer level      = LoadInteger(OtherHashTable2, 'A3E9', 0)
        local real    sx
        local real    sy
        local real    tx
        local real    ty
        local real    angle

        local unit    missileDummyUnit
        local trigger trig
        local timer   tt
        

        set sx    = GetUnitX(whichUnit)
        set sy    = GetUnitY(whichUnit)
        set tx    = GetUnitX(targetUnit)
        set ty    = GetUnitY(targetUnit)
        set angle = RadianBetweenXY(sx, sy, tx, ty)

        set sx = sx + MHUnit_GetData(whichUnit, UNIT_DATA_LAUNCH_X) * Cos(angle)
        set sx = sx + MHUnit_GetData(whichUnit, UNIT_DATA_LAUNCH_Y) * Sin(angle)
        set missileDummyUnit = CreateUnit(GetOwningPlayer(whichUnit), 'h0BQ', sx, sy, GetUnitFacing(whichUnit))
        set trig = LaunchMissileDummyByUnit(whichUnit, targetUnit, missileDummyUnit, "FortuneEndOnMissileHit", 1200, true, false)
        call SetUnitTimeScale(missileDummyUnit, 4) 

        set Table[GetHandleId(whichUnit)].integer[ORACLE_FORTUNE_END_KEY] = level
        set Table[GetHandleId(whichUnit)].real[ORACLE_FORTUNE_END_KEY]    = time

        call SaveBoolean(HY, GetHandleId(trig), 0, true) 

        call FlushChildHashtable(OtherHashTable2, 'A3E9') 
        
        set tt = CreateTimer() 
        call TimerStart(tt, .1, false, function FortuneEndMissileEchoShellBackSetUnitTimeScaleExpired) 
        call SaveUnitHandle(HY, GetHandleId(tt), 0, missileDummyUnit) 
        set tt = null 

        set whichUnit  = null
        set targetUnit = null
        set trig       = null
    endfunction
    
    function FortuneEndMissileLaunch takes nothing returns nothing
        local unit    whichUnit  = GetTriggerUnit()
        local unit    targetUnit = (LoadUnitHandle(HY,(GetHandleId(whichUnit)), 796))
        // 最大3最小0.75
        local real    time       = RMaxBJ(RMinBJ((GetGameTime())-(LoadReal(HY,(GetHandleId(whichUnit)), 358)), 3), 0.75)
        local integer level      = GetUnitAbilityLevel(whichUnit,'A2QT')
        
        if targetUnit != null then
            set Table[GetHandleId(whichUnit)].real[ORACLE_FORTUNE_END_KEY] = time
            call LaunchMissileDummyByUnit(whichUnit, targetUnit, Table[GetHandleId(whichUnit)].unit[ORACLE_FORTUNE_END_KEY], "FortuneEndOnMissileHit", 1200, true, false)
        endif
        
        set whichUnit = null
        set targetUnit = null
    endfunction

    // 这到底啥用？？
    function Q3R takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 14))
        local unit targetUnit =(LoadUnitHandle(HY, h, 17))
        if GetTriggerEventId() == EVENT_WIDGET_DEATH then
            call SaveReal(HY,(GetHandleId(whichUnit)), 356,((GetUnitX(targetUnit))* 1.))
            call SaveReal(HY,(GetHandleId(whichUnit)), 357,((GetUnitY(targetUnit))* 1.))
        elseif GetTriggerEvalCount(t) > 200 then 
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        elseif GetTriggerEvalCount(t) == 10 then 
            call SetUnitTimeScale(Table[GetHandleId(whichUnit)].unit[ORACLE_FORTUNE_END_KEY], .1) 
        endif
        set t = null
        set whichUnit = null
        set targetUnit = null
        return false
    endfunction
    function Q4R takes nothing returns nothing
        local trigger t          = CreateTrigger()
        local integer h          = GetHandleId(t)
        local unit    whichUnit  = GetTriggerUnit()
        local unit    targetUnit
        local unit    missileDummyUnit
        local real    sx
        local real    sy
        local real    tx
        local real    ty
        local real    angle

        set targetUnit = GetSpellTargetUnit()
        set sx         = GetUnitX(whichUnit)
        set sy         = GetUnitY(whichUnit)
        set tx         = GetUnitX(targetUnit)
        set ty         = GetUnitY(targetUnit)
        set angle      = RadianBetweenXY(sx, sy, tx, ty)

        set sx = sx + MHUnit_GetData(whichUnit, UNIT_DATA_LAUNCH_X) * Cos(angle)
        set sx = sx + MHUnit_GetData(whichUnit, UNIT_DATA_LAUNCH_Y) * Sin(angle)
        set missileDummyUnit = CreateUnit(GetOwningPlayer(whichUnit), 'h0BQ', sx, sy, GetUnitFacing(whichUnit))
        set Table[GetHandleId(whichUnit)].unit[ORACLE_FORTUNE_END_KEY] = missileDummyUnit
        call SetUnitTimeScale(missileDummyUnit, 1.5)

        set Table[GetHandleId(whichUnit)].integer[ORACLE_FORTUNE_END_KEY] = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())

        call SaveReal(HY,(GetHandleId(whichUnit)), 358,(((GetGameTime()))* 1.))
        call SaveUnitHandle(HY,(GetHandleId(whichUnit)), 796,(targetUnit))
        call DestroyEffect(AddSpecialEffect("war3mapImported\\CleanseTargetArea.mdx", tx, ty))
        call SaveUnitHandle(HY, h, 14,(whichUnit))
        call SaveUnitHandle(HY, h, 17,(targetUnit))
        call TriggerRegisterTimerEvent(t, 0.05, true)
        call TriggerRegisterDeathEvent(t, targetUnit)
        call TriggerAddCondition(t, Condition(function Q3R))
        set targetUnit = null
        set t = null
        set whichUnit = null
        set missileDummyUnit = null
    endfunction
    function FortuneEndOnSpellEffect takes nothing returns nothing
        if not UnitHasSpellShield(GetSpellTargetUnit()) then
            call SaveBoolean(HY,(GetHandleId(GetTriggerUnit())), 360,(true))
        endif
    endfunction
    function FortuneEndOnEndCast takes nothing returns nothing
        if LoadBoolean(HY, GetHandleId(GetTriggerUnit()), 360) then
            call FortuneEndMissileLaunch()
        endif
    endfunction
    function FortuneEndOnSpellCast takes nothing returns nothing
        call SaveBoolean(HY,(GetHandleId(GetTriggerUnit())), 360,(false))
        call Q4R()
    endfunction

    //***************************************************************************
    //*
    //*  命运赦令
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_FATE_EDICT = GetHeroSKillIndexBySlot(HERO_INDEX_ORACLE, 2)

        constant integer FATE_EDICT_TARGET_BUFF_ID = 'B3KE'
    endglobals

    function FateEdictOnInitializer takes nothing returns nothing
        call ResgiterAbilityMethodSimple(FATE_EDICT_TARGET_BUFF_ID, "FateEdictBuffOnAdd", "FateEdictBuffOnRemove")
    endfunction
    
    function FateEdictBuffOnAdd takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        
        call UnitIncDisableAttackCount(whichUnit)

        set whichUnit = null
    endfunction

    function FateEdictBuffOnRemove takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        
        call UnitDecDisableAttackCount(whichUnit)

        set whichUnit = null
    endfunction
    
    function Q5R takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit targetUnit =(LoadUnitHandle(HY, h, 17))
        local integer level = LoadInteger(HY, h, 5)
        local integer c = LoadInteger(HY, h, 0)
        if GetTriggerEventId() == EVENT_UNIT_DAMAGED then
            if LoadBoolean(HY, h, 0) == false then
                call SaveBoolean(HY, h, 0, true)
                call UnitDamageTargetEx(GetEventDamageSource(), GetTriggerUnit(), 3, GetEventDamage()* .5)
                call SaveBoolean(HY, h, 0, false)
            endif
        elseif GetTriggerEventId() == EVENT_WIDGET_DEATH then
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            call UnitRemoveAbility(targetUnit,'A2T4')
            call UnitRemoveAbility(targetUnit,'A3KE')
            call UnitRemoveAbility(targetUnit,'B3KE')
            //call UnitRemoveAbility(targetUnit,'A3KD')
            call RemoveSavedHandle(HY, GetHandleId(targetUnit),'A2T5')
        elseif c >(level + 2)* 10 or GetUnitAbilityLevel(targetUnit,'A2T4') == 0 then
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            call UnitRemoveAbility(targetUnit,'A2T4')
            call UnitRemoveAbility(targetUnit,'A3KE')
            call UnitRemoveAbility(targetUnit,'B3KE')
            //call UnitRemoveAbility(targetUnit,'A3KD')
            call RemoveSavedHandle(HY, GetHandleId(targetUnit),'A2T5')
        else
            set c = c + 1
            call SaveInteger(HY, h, 0, c)
        endif
        set t = null
        set targetUnit = null
        return false
    endfunction
    function Q6R takes nothing returns nothing
        local unit whichUnit = GetTriggerUnit()
        local unit targetUnit = GetSpellTargetUnit()
        local integer level = GetUnitAbilityLevel(whichUnit,'A2T5')
        local trigger t
        local integer h
        if HaveSavedHandle(HY, GetHandleId(targetUnit),'A2T5') then
            set t = LoadTriggerHandle(HY, GetHandleId(targetUnit),'A2T5')
            set h = GetHandleId(t)
        else
            set t = CreateTrigger()
            set h = GetHandleId(t)
            call SaveTriggerHandle(HY, GetHandleId(targetUnit),'A2T5', t)
            call TriggerRegisterTimerEvent(t, .1, true)
            call TriggerRegisterUnitEvent(t, targetUnit, EVENT_UNIT_DAMAGED)
            call TriggerRegisterDeathEvent(t, targetUnit)
            call TriggerAddCondition(t, Condition(function Q5R))
            call SaveUnitHandle(HY, h, 17,(targetUnit))
            call SetPlayerAbilityAvailable(GetOwningPlayer(targetUnit),'A2T4', false)
        endif
        call UnitAddPermanentAbility(targetUnit,'A3KE')
        //call UnitAddPermanentAbility(targetUnit,'A3KD')
        call UnitAddPermanentAbility(targetUnit,'A2T4')
        call SaveInteger(HY, h, 0, 0)
        call SaveInteger(HY, h, 5, level)
        set whichUnit = null
        set targetUnit = null
        set t = null
    endfunction
    function FateEdictOnSpellEffect takes nothing returns nothing
        if IsUnitAlly(GetSpellTargetUnit(), GetOwningPlayer(GetTriggerUnit())) or not UnitHasSpellShield(GetSpellTargetUnit()) then
            call Q6R()
        endif
    endfunction

endscope

