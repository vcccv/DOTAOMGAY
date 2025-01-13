
scope TwinHeadDragon

    function MacropyreOnLoopAction takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit 	  whichUnit = LoadUnitHandle(HY, h, 2)
        local integer level = LoadInteger(HY, h, 5)
        local real    a = LoadReal(HY, h, 137)
        local real    x = LoadReal(HY, h, 6)
        local real    y = LoadReal(HY, h, 7)
        local integer id = GetPlayerId(GetOwningPlayer(whichUnit))
        local integer count = GetTriggerEvalCount(t)
        local real    tx = x + 150* count * Cos(a)
        local real    ty = y + 150* count * Sin(a)
        local real    maxDistance = LoadReal(HY, h, 1)
        call IssuePointOrderById(MacropyreCasters[id], 852488, tx, ty)
        if ( count * 150. >= maxDistance ) then
            call FlushChildHashtable(HY, h)
            call CleanCurrentTrigger(t)
            call SetUnitAnimation(whichUnit, "stand")
        endif
        set t = null
        set whichUnit = null
        return false
    endfunction
    function MacropyreOnSpellEffect takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit 	  whichUnit = GetTriggerUnit()
        local real    x = GetSpellTargetX()
        local real    y = GetSpellTargetY()
        local real    a = Atan2(y -GetUnitY(whichUnit), x -GetUnitX(whichUnit))
        local integer level = GetUnitAbilityLevel(whichUnit,'A0O5')
        local integer upgradeId ='A0OE'
        local real    maxDistance = 900. + GetUnitCastRangeBonus(whichUnit)
        call SaveBoolean(HY, h, 0, false)
        if level == 0 then
            set level = GetUnitAbilityLevel(whichUnit,'A1B1')
            set upgradeId ='A1B2'
            call SaveBoolean(HY, h, 0, true)
            set maxDistance = 1800. + GetUnitCastRangeBonus(whichUnit)
        endif
        call SetUnitAnimation(whichUnit, "spell")
        set MacropyreCasters[GetPlayerId(GetOwningPlayer(whichUnit))]= CreateUnit(GetOwningPlayer(whichUnit),'e00E', x, y, 0)
        call UnitAddPermanentAbility(MacropyreCasters[GetPlayerId(GetOwningPlayer(whichUnit))], upgradeId)
        call SetUnitAbilityLevel(MacropyreCasters[GetPlayerId(GetOwningPlayer(whichUnit))], upgradeId, level)
        call SaveInteger(HY, h, 5, level)
        call SaveReal(HY, h, 6, GetUnitX(whichUnit))
        call SaveReal(HY, h, 7, GetUnitY(whichUnit))
        call SaveReal(HY, h, 137, a * 1.)
        call SaveUnitHandle(HY, h, 2, whichUnit)
        call SaveReal(HY, h, 1, maxDistance)
        if upgradeId =='A0OE' then
            call TriggerRegisterTimerEvent(t, .1, true)
        else
            call TriggerRegisterTimerEvent(t, .05, true)
        endif
        call TriggerAddCondition(t, Condition(function MacropyreOnLoopAction))
        set t = null
        set whichUnit = null
    endfunction

endscope
