

scope Invisible

    globals
        constant integer INVISIBLE_ABILITY_ID = 'Apiv'
        //integer          InvisibleCount  = 0
        key              INVISIBLE_TIMER
        key              INVISIBLE_TRIG
        key              WIND_WALK_BUFF_ID

        key              WIND_WALK_COUNT
        key              WIND_WALK_ATTACK_DAMAGE
        key              WIND_WALK_ATTACK_BUFF_ID
        key              WIND_WALK_AUTO_ATTACK
        
        key              UNIT_IS_IN_WINDWALK
    endglobals

    /*
    local integer h = GetHandleId(whichUnit)
        local integer count = LoadInteger(ExtraHT, h, INVISIBLE_COUNT) - 1
        
        call SaveInteger(ExtraHT, h, INVISIBLE_COUNT, count)
        */

    function UnitRemoveWindWalk takes unit whichUnit returns nothing
        local timer t = LoadTimerHandle(ExtraHT, GetHandleId(whichUnit), INVISIBLE_TIMER)
        local integer h = GetHandleId(whichUnit)
        local integer count = LoadInteger(ExtraHT, h, WIND_WALK_COUNT)
        local trigger trig 
        local integer autoAttackCount = LoadInteger(ExtraHT, h, WIND_WALK_AUTO_ATTACK)
        //set InvisibleCount = InvisibleCount - 1
        if t != null then
            call RemoveSavedHandle(ExtraHT, GetHandleId(whichUnit), INVISIBLE_TIMER)
            call FlushChildHashtable(HY, GetHandleId(t))
            call PauseTimer(t)
            call DestroyTimer(t)
            set t = null
        else
            set count = count - 1
        endif
        call SaveInteger(ExtraHT, h, WIND_WALK_COUNT, count)
        if count == 0 then
            set h = GetHandleId(whichUnit)
            set trig = LoadTriggerHandle(ExtraHT, h, INVISIBLE_TRIG)
            call CleanCurrentTrigger(trig)
            call FlushChildHashtable(HY, GetHandleId(trig))
            set trig = null
            call RemoveSavedHandle(ExtraHT, h, INVISIBLE_TRIG)
            call RemoveSavedBoolean(ExtraHT, h, UNIT_IS_IN_WINDWALK)
            call UnitRemoveAbility(whichUnit, INVISIBLE_ABILITY_ID)
            return
        endif
        call UnitAddAbility(whichUnit, INVISIBLE_ABILITY_ID)
        if HaveSavedHandle(ExtraHT, h, INVISIBLE_TIMER) and autoAttackCount > 0 then
            call YDWESetUnitAbilityDataReal(whichUnit, INVISIBLE_ABILITY_ID, 1, ABILITY_DATA_DATA_A, 1)
        else
            call YDWESetUnitAbilityDataReal(whichUnit, INVISIBLE_ABILITY_ID, 1, ABILITY_DATA_DATA_A, 0)
        endif
        call YDWESetUnitAbilityDataReal(whichUnit, INVISIBLE_ABILITY_ID, 1, ABILITY_DATA_DUR, 0.)
        call YDWESetUnitAbilityDataReal(whichUnit, INVISIBLE_ABILITY_ID, 1, ABILITY_DATA_HERODUR, 0.)
        call UnitRemoveAbility(whichUnit, INVISIBLE_ABILITY_ID)
        call UnitAddPermanentAbility(whichUnit, INVISIBLE_ABILITY_ID)
    endfunction

    function UnitIsInWindWalk takes unit whichUnit returns boolean
        return LoadBoolean(ExtraHT, GetHandleId(whichUnit), UNIT_IS_IN_WINDWALK)
    endfunction

    private function IssueImmediateOrderByIdToTimedActions takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer h = GetHandleId(t)
        local unit u = LoadUnitHandle(HY, h, 0)
        if GetUnitCurrentOrder(u) == 0 /* and LoadInteger(ExtraHT, GetHandleId(u), LAST_ISSUED_ORDER)*/ then
            call IssueImmediateOrderById(u, LoadInteger(HY, h, 0))
        endif
        call FlushChildHashtable(HY, h)
        call DestroyTimer(t)
        set u = null
        set t = null
    endfunction
    private function IssueImmediateOrderByIdToTimed takes unit u, integer id, real timeout returns nothing
        local timer t = CreateTimer()
        call SaveUnitHandle(HY, GetHandleId(t), 0, u)
        call SaveInteger(HY, GetHandleId(t), 0, id)
        call TimerStart(t, timeout, false, function IssueImmediateOrderByIdToTimedActions)
        set t = null
    endfunction

    function WindWalkStopActions takes nothing returns nothing
        local unit u = GetTriggerUnit()
        if GetUnitCurrentOrder(u) == 0 then
            call IssueImmediateOrderByIdToTimed(u, 851993, 0.)
        endif
        set u = null
    endfunction

    function UnitAddWindWalk takes unit whichUnit returns nothing
        local integer h = GetHandleId(whichUnit)
        local integer count = LoadInteger(ExtraHT, h, WIND_WALK_COUNT) + 1
        local trigger trig 
        //set InvisibleCount = InvisibleCount + 1
        if count == 1 and not HaveSavedHandle(ExtraHT, h, INVISIBLE_TRIG) then
            set trig = CreateTrigger()
            call TriggerRegisterUnitEvent(trig, whichUnit, EVENT_UNIT_ACQUIRED_TARGET)
            call TriggerAddCondition(trig, Condition( function WindWalkStopActions))
            call SaveTriggerHandle(ExtraHT, h, INVISIBLE_TRIG, trig)
            set trig = null
        endif
        call SaveInteger(ExtraHT, h, WIND_WALK_COUNT, count)
        //call BJDebugMsg("WIND_WALK_COUNT " + I2S(count))
        if GetUnitAbilityLevel(whichUnit, INVISIBLE_ABILITY_ID) == 0 then
            call UnitAddAbility(whichUnit, INVISIBLE_ABILITY_ID)
        endif
        call YDWESetUnitAbilityDataReal(whichUnit, INVISIBLE_ABILITY_ID, 1, ABILITY_DATA_DUR, 0.)
        call YDWESetUnitAbilityDataReal(whichUnit, INVISIBLE_ABILITY_ID, 1, ABILITY_DATA_HERODUR, 0.)
        call UnitRemoveAbility(whichUnit, INVISIBLE_ABILITY_ID)
        call UnitAddPermanentAbility(whichUnit, INVISIBLE_ABILITY_ID)
        //call BJDebugMsg("单位永久隐身等级" + I2S(GetUnitAbilityLevel(whichUnit, INVISIBLE_ABILITY_ID)))
    endfunction

    function UnitStartWindWalkWaitActions takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer h = GetHandleId(t)
        local custombuff b = LoadInteger(HY, h, 0)

        if b.dataC == 1 then
            set b.dataD = 1
            call SetUnitPhaseMove(b.target, true)
        endif

        call UnitAddWindWalk(b.target)
        call AddAttackLaunchingTrigCount(b.target)

        call RemoveSavedHandle(ExtraHT, GetHandleId(b.target), INVISIBLE_TIMER)

        call FlushChildHashtable(HY, h)
        call DestroyTimer(t)
        set t = null
    endfunction

    // 持续时间为渐隐时间
    function UnitStartWindWalk takes custombuff b returns nothing
        local timer t
        local integer h
        local integer autoAttackCount = 0
        set t = LoadTimerHandle(ExtraHT, GetHandleId(b.target), INVISIBLE_TIMER)
        if t == null then
            set t = CreateTimer()
            set h = GetHandleId(t)
            call SaveInteger(HY, h, 0, b)
            call SaveTimerHandle(ExtraHT, GetHandleId(b.target), INVISIBLE_TIMER, t)
        endif
        call TimerStart(t, b.dataB, false, function UnitStartWindWalkWaitActions)
        set t = null
        if b.dataE == 1 then
            set h = GetHandleId(b.target)
            set autoAttackCount = LoadInteger(ExtraHT, h, WIND_WALK_AUTO_ATTACK)
            call SaveInteger(ExtraHT, h, WIND_WALK_AUTO_ATTACK, autoAttackCount + 1) 
        endif
        if GetUnitAbilityLevel(b.target, INVISIBLE_ABILITY_ID) == 0 then
            call UnitAddAbility(b.target, INVISIBLE_ABILITY_ID)
        endif
        if autoAttackCount > 0 then
            call YDWESetUnitAbilityDataReal(b.target, INVISIBLE_ABILITY_ID, 1, ABILITY_DATA_DATA_A, 1)
        else
            call YDWESetUnitAbilityDataReal(b.target, INVISIBLE_ABILITY_ID, 1, ABILITY_DATA_DATA_A, 0)
        endif
        call YDWESetUnitAbilityDataReal(b.target, INVISIBLE_ABILITY_ID, 1, ABILITY_DATA_DUR, b.dataB)
        call YDWESetUnitAbilityDataReal(b.target, INVISIBLE_ABILITY_ID, 1, ABILITY_DATA_HERODUR, b.dataB)
        call UnitRemoveAbility(b.target, INVISIBLE_ABILITY_ID)
        call UnitAddPermanentAbility(b.target, INVISIBLE_ABILITY_ID)
    endfunction

    function WindWalk__RemoveBuff__Actions takes nothing returns nothing
        local custombuff b = GetTriggerBuff()
        local integer h = GetHandleId(b.target)
        local integer autoAttackCount = LoadInteger(ExtraHT, h, WIND_WALK_AUTO_ATTACK)
        if b.dataE == 1 then
            call SaveInteger(ExtraHT, h, WIND_WALK_AUTO_ATTACK, autoAttackCount - 1) 
        endif
        if b.dataD == 1 then
            call SetUnitPhaseMove(b.target, false)
        endif
        call UnitRemoveWindWalk(b.target)
    endfunction

    function WindWalk__AddBuff__Actions takes nothing returns nothing
        local custombuff b = GetTriggerBuff()
        call UnitStartWindWalk(b)
    endfunction

    function UnitWindWalkAttackAcionts takes unit whichUnit, boolean isAttack returns nothing
        local integer id = LoadInteger(ExtraHT, GetHandleId(whichUnit), WIND_WALK_BUFF_ID)
        local custombuff b = GetUnitCustomBuff(whichUnit, id)
        if isAttack then
            if b.dataA > 0. then
                call SaveReal(ExtraHT, GetHandleId(whichUnit), WIND_WALK_ATTACK_DAMAGE, b.dataA)
            endif
            call SaveInteger(ExtraHT, GetHandleId(whichUnit), WIND_WALK_ATTACK_BUFF_ID, b.bid)
        endif
        call b.remove()
    endfunction

    // 疾风步, 会顶替掉其他疾风步 A = 伤害 B = 渐隐时间 C = 相位移动 E = 自动攻击 F = 移动速度加成
    function UnitSpellEffectWindWalk takes unit whichUnit, real dataA, real dataB, real dur, integer level, integer abId, integer buffId, integer phaseMove, integer autoAttack, real addSpeed returns nothing
        local integer h = GetHandleId(whichUnit)
        local integer oldBuffId = LoadInteger(ExtraHT, h, WIND_WALK_BUFF_ID)
        local custombuff b = GetUnitCustomBuff(whichUnit, oldBuffId)
        call UnitRemoveAbilityToTimed(whichUnit, 'BOwk', 0.)
        if b > 0 then
            call b.remove()
        endif
        set b = b.create(whichUnit, whichUnit)
        set b.aid = abId
        set b.bid = buffId
        set b.dataA = dataA
        set b.dataB = dataB
        set b.dataC = phaseMove
        set b.dataE = autoAttack
        set b.dataF = addSpeed
        set b.dur = dur
        set b.overlayDur = true
        set b.level = level
        set b.basicDispel = false
        set b.removeActions = "WindWalk__RemoveBuff__Actions"
        set b.addActions = "WindWalk__AddBuff__Actions"
        call b.add_buff()
        // 修正耐久光环BUFF带来的移动速度加成
        if b.dataF > 0. then
            //call BJDebugMsg(R2S(b.dataF))
            call YDWESetUnitAbilityDataReal(whichUnit, b.aid, 1, ABILITY_DATA_DATA_A, b.dataF)
            call YDWESetUnitAbilityDataReal(whichUnit, b.aid, b.level, ABILITY_DATA_DATA_A, b.dataF)
            call UnitRemoveAbility(whichUnit, b.aid)
            call UnitRemoveAbility(whichUnit, b.bid)
            call UnitAddPermanentAbilitySetLevel(whichUnit, b.aid, b.level)
        endif
        
        call SaveInteger(ExtraHT, h, WIND_WALK_BUFF_ID, buffId)
        call SaveBoolean(ExtraHT, h, UNIT_IS_IN_WINDWALK, true)
    endfunction
    // 隐身要有计数

endscope
    