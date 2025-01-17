
scope Clockwerk

    //***************************************************************************
    //*
    //*  发射钩爪
    //*
    //***************************************************************************
    function KBR takes unit whichUnit, unit targetUnit returns nothing
        local unit dummyCaster = CreateUnit(GetOwningPlayer(whichUnit),'e00E', GetUnitX(targetUnit), GetUnitY(targetUnit), 0)
        local integer level = GetUnitAbilityLevel(whichUnit,'A0Z8')
        if level == 0 then
            set level = GetUnitAbilityLevel(whichUnit,'A1CV')
        endif
        call UnitAddPermanentAbility(dummyCaster,'A0Z9')
        call SetUnitAbilityLevel(dummyCaster,'A0Z9', level)
        call IssueTargetOrderById(dummyCaster, 852095, targetUnit)
        set dummyCaster = null
    endfunction
    function KCR takes nothing returns nothing
        if IsUnitInGroup(GetEnumUnit(), DK) == false then
            call GroupAddUnit(DK, GetEnumUnit())
            call KBR(U2, GetEnumUnit())
        endif
    endfunction
    function KDR takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit trigUnit = LoadUnitHandle(HY, h, 14)
        local unit targetUnit = LoadUnitHandle(HY, h, 17)
        local integer KFR = LoadInteger(HY, h, 18)
        local integer count = GetTriggerEvalCount(t)
        local unit KGR
        local group KHR = LoadGroupHandle(HY, h, 16)
        local group g
        local real KJR = 200
        if targetUnit == null then
            set KGR = LoadUnitHandle(HY, h, 700 + KFR + 1 -count)
            call RemoveUnit(KGR)
        else
            set KGR = LoadUnitHandle(HY, h, 700 + count)
            if IsUnitType(trigUnit, UNIT_TYPE_HERO) then
                call SaveBoolean(OtherHashTable, GetHandleId(trigUnit), 99, true)
            endif
            call SetUnitX(trigUnit, GetUnitX(KGR))
            call SetUnitY(trigUnit, GetUnitY(KGR))
            call RemoveUnit(KGR)
            if count == KFR then
                set KJR = 225
            endif
            set g = AllocationGroup(150)
            set U2 = trigUnit
            set DK = KHR
            call GroupEnumUnitsInRange(g, GetUnitX(trigUnit), GetUnitY(trigUnit), KJR, Condition(function DMX))
            call ForGroup(g, function KCR)
            call DeallocateGroup(g)
        endif
        if count ==(KFR) then
            if targetUnit != null then
                call PauseUnit(targetUnit, false)
            endif
            call A3X(GetUnitX(trigUnit), GetUnitY(trigUnit), 100)
            call DeallocateGroup(KHR)
            call FlushChildHashtable(HY, h)
            call CleanCurrentTrigger(t)
        endif
        set t = null
        set trigUnit = null
        set targetUnit = null
        set KGR = null
        set KHR = null
        set g = null
        return false
    endfunction
    function KKR takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit trigUnit = LoadUnitHandle(HY, h, 14)
        local real a = LoadReal(HY, h, 13)
        local integer KLR = LoadInteger(HY, h, 12)
        local integer count = GetTriggerEvalCount(t)
        local real x = GetUnitX(trigUnit)+ count * 50 * Cos(a * bj_DEGTORAD)
        local real y = GetUnitY(trigUnit)+ count * 50 * Sin(a * bj_DEGTORAD)
        local boolean KMR = LoadBoolean(HY, h, 15)
        local unit KPR
        local integer level = LoadInteger(HY, h, 0)
        local trigger KQR = LoadTriggerHandle(HY, h, 11)
        local integer KSR = GetHandleId(KQR)
        local group g = AllocationGroup(151)
        local unit targetUnit = null
        local integer ID ='u00V'
        local real KJR = 125
        if count == 1 then
            set KJR = 100 
        endif
        set U2 = trigUnit
        call GroupEnumUnitsInRange(g, x, y, KJR, Condition(function DNX))
        call GroupRemoveUnit(g, trigUnit)
        set targetUnit = GroupPickRandomUnit(g)
        call DeallocateGroup(g)
        if targetUnit != null or count == KLR or count ==(KLR -1) or count ==(KLR -2) then
            set ID ='u00U'
        endif
        set KPR = CreateUnit(GetOwningPlayer(trigUnit), ID, x, y, a)
        call SaveUnitHandle(HY, KSR, 700 + count, KPR)
        if targetUnit != null then
            if GetOwningPlayer(targetUnit) == NeutralCreepPlayer or LoadInteger(HY, GetHandleId(targetUnit), 4259) == 1 then
                set targetUnit = null
            endif
            call FlushChildHashtable(HY, h)
            call CleanCurrentTrigger(t)
            if targetUnit != null and IsUnitAlly(targetUnit, GetOwningPlayer(trigUnit)) == false then
                call PauseUnit(targetUnit, true)
            endif
            call TriggerRegisterTimerEvent(KQR, .5 / KLR, true)
            call TriggerAddCondition(KQR, Condition(function KDR))
            call SaveInteger(HY, KSR, 18, count)
            call SaveInteger(HY, KSR, 0, level)
            call SaveUnitHandle(HY, KSR, 17, targetUnit)
            call SaveUnitHandle(HY, KSR, 14, trigUnit)
            call SaveGroupHandle(HY, KSR, 16, AllocationGroup(152))
        elseif count > KLR then
            set targetUnit = null
            call FlushChildHashtable(HY, h)
            call CleanCurrentTrigger(t)
            call TriggerRegisterTimerEvent(KQR, .5 / KLR, true)
            call TriggerAddCondition(KQR, Condition(function KDR))
            call SaveInteger(HY, KSR, 18, count)
            call SaveInteger(HY, KSR, 0, level)
            call SaveUnitHandle(HY, KSR, 17, targetUnit)
            call SaveUnitHandle(HY, KSR, 14, trigUnit)
            call SaveGroupHandle(HY, KSR, 16, AllocationGroup(153))
        endif
        set t = null
        set trigUnit = null
        set KPR = null
        set KQR = null
        set g = null
        set targetUnit = null
        return false
    endfunction
    function HookshotOnSpellEffect takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit trigUnit = GetTriggerUnit()
        local real a = AngleBetweenXY(GetUnitX(trigUnit), GetUnitY(trigUnit), GetSpellTargetX(), GetSpellTargetY())
        local integer level = GetUnitAbilityLevel(trigUnit,'A0Z8')
        local integer KTR
        local integer KLR
        local boolean KMR = false
        local trigger KUR = CreateTrigger()
        if level == 0 then
            set level = GetUnitAbilityLevel(trigUnit,'A1CV')
            set KMR = true
        endif
        set KTR = 1500 + 500 * level + R2I(GetUnitCastRangeBonus(trigUnit))
        set KLR = KTR / 50
        call SaveUnitHandle(HY, h, 14, trigUnit)
        call SaveInteger(HY, h, 5, level)
        call SaveReal(HY, h, 13, a * 1.)
        call SaveInteger(HY, h, 12, KLR)
        call SaveTriggerHandle(HY, h, 11, KUR)
        call SaveBoolean(HY, h, 15, KMR)
        call TriggerRegisterTimerEvent(t, .5 / KLR, true)
        call TriggerAddCondition(t, Condition(function KKR))
        call SaveInteger(HY, h, 0, GetUnitAbilityLevel(trigUnit, GetSpellAbilityId()))
        set t = null
        set trigUnit = null
        set KUR = null
    endfunction

endscope
