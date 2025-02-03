
scope FacelessVoid

    //***************************************************************************
    //*
    //*  时间漫游
    //*
    //***************************************************************************
    function LCI takes nothing returns nothing
        if not IsUnitInGroup(GetEnumUnit(), L_V) then
            call GroupAddUnit(L_V, GetEnumUnit())
            call UnitAddAbilityToTimed(GetEnumUnit(), L0V, 1, 3.,'B05Q')
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\SpellShieldAmulet\\SpellShieldCaster.mdl", GetEnumUnit(), "overhead"))
        endif
    endfunction
    function LDI takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = LoadUnitHandle(HY, h, 14)
        local real x2 = LoadReal(HY, h, 66)
        local real y2 = LoadReal(HY, h, 67)
        local real a = LoadReal(HY, h, 137)
        local integer count = GetTriggerEvalCount(t)
        local real x = GetUnitX(whichUnit)
        local real y = GetUnitY(whichUnit)
        local real GXR = LoadReal(HY, h, 23)
        local real GOR = LoadReal(HY, h, 24)
        local unit dummyCaster = LoadUnitHandle(HY, h, 19)
        local group g = AllocationGroup(327)
        local group D7R = LoadGroupHandle(HY, h, 187)
        local integer level = LoadInteger(HY, h, 5)
        if GetDistanceBetween(x, y, x2, y2)<= 53 then
            set x = x2
            set y = y2
        else
            set x = GXR + 60 * Cos(a * bj_DEGTORAD)
            set y = GOR + 60 * Sin(a * bj_DEGTORAD)
        endif
        set x = CoordinateX50(x)
        set y = CoordinateY50(y)
        if level == 1 then
            set L0V ='A294'
        elseif level == 2 then
            set L0V ='A295'
        elseif level == 3 then
            set L0V ='A296'
        elseif level == 4 then
            set L0V ='A297'
        endif
        set U2 = whichUnit
        set L_V = D7R
        call GroupEnumUnitsInRange(g, x, y, 325, Condition(function DJX))
        call ForGroup(g, function LCI)
        call DeallocateGroup(g)
        call SaveReal(HY, h, 23, x * 1.)
        call SaveReal(HY, h, 24, y * 1.)
        call SetUnitPosition(whichUnit, x, y)
        if (x == x2 and y == y2) or count > LoadInteger(HY, h, 0) then
            call SetUnitX(dummyCaster, CoordinateX50(x))
            call SetUnitY(dummyCaster, CoordinateY50(y))
            call IssueImmediateOrderById(dummyCaster, 852096)
            call DeallocateGroup(D7R)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            call SetUnitAnimation(whichUnit, "stand")

            call ResetUnitVertexColor(whichUnit)
            call UnitSubNoPathingCount(whichUnit)
            call UnitSubInvulnerableCount(whichUnit)

            call SaveInteger(HY, GetHandleId(whichUnit), 4261, 2)
        endif
        set t = null
        set whichUnit = null
        set dummyCaster = null
        set D7R = null
        set g = null
        return false
    endfunction
    function TimeWalkOnSpellEffect takes nothing returns nothing
        local unit whichUnit = GetTriggerUnit()
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local real x1 = GetUnitX(whichUnit)
        local real y1 = GetUnitY(whichUnit)
        local real x2
        local real y2
        local real a
        local unit dummyCaster = CreateUnit(GetOwningPlayer(whichUnit),'e00E', x1, y1, 0)
        local real distance    = 500 + 200 * GetUnitAbilityLevel(whichUnit,'A0LK') + GetUnitCastRangeBonus(whichUnit)
        if GetSpellTargetUnit() == null then
            set x2 = GetSpellTargetX()
            set y2 = GetSpellTargetY()
        else
            set x2 = GetUnitX(GetSpellTargetUnit())
            set y2 = GetUnitY(GetSpellTargetUnit())
        endif
        set a = AngleBetweenXY(x1, y1, x2, y2)
        call SetUnitAnimationByIndex(whichUnit, 0)

        call SetUnitVertexColorEx(whichUnit, 0, 0, 0,-1)
        call UnitAddNoPathingCount(whichUnit)
        call UnitAddInvulnerableCount(whichUnit)

        call SaveInteger(HY, GetHandleId(whichUnit), 4261, 1)
        call SaveReal(HY, h, 66, x2 * 1.)
        call SaveReal(HY, h, 67, y2 * 1.)
        call SaveReal(HY, h, 23, x1 * 1.)
        call SaveReal(HY, h, 24, y1 * 1.)
        call SaveReal(HY, h, 137, a * 1.)
        call SaveInteger(HY, h, 5, GetUnitAbilityLevel(whichUnit, GetSpellAbilityId()))
        call SaveUnitHandle(HY, h, 14, whichUnit)
        call SaveUnitHandle(HY, h, 19, dummyCaster)
        call SaveGroupHandle(HY, h, 187, AllocationGroup(328))
        call SaveInteger(HY, h, 0, R2I((distance)/ 60.))
        call UnitAddPermanentAbility(dummyCaster,'A0LA')
        call SetUnitAbilityLevel(dummyCaster,'A0LA', GetUnitAbilityLevel(whichUnit,'A0LK'))
        call TriggerRegisterTimerEvent(t, .02, true)
        call TriggerAddCondition(t, Condition(function LDI))
        set whichUnit = null
        set t = null
        set dummyCaster = null
    endfunction

    //***************************************************************************
    //*
    //*  时间结界
    //*
    //***************************************************************************
    function ChronosphereFilter takes unit source, unit target returns boolean
        return UnitAlive(target) //and 
    endfunction

    function ChronosphereOnUpdate takes nothing returns nothing
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit    d = LoadUnitHandle(HY, h, 19)
        local unit    whichUnit = LoadUnitHandle(HY, h, 14)
        local integer level = LoadInteger(HY, h, 5)
        local group   g = LoadGroupHandle(HY, h, 220)
        local integer c = LoadInteger(HY, h, 28)
        local real    tx = GetUnitX(d)
        local real    ty = GetUnitY(d)
        local group   enumGroup
        local integer max = LoadInteger(HY, h, 6)
        local unit    first
        local integer size
        local integer i
        local real    area = 450.
        
        if GetTriggerEventId() == EVENT_GAME_TIMER_EXPIRED then
            set c = c + 1
            call SaveInteger(HY, h, 28, c)
            if GetUnitDistanceEx(whichUnit, d) < area then
                call UnitAddBuffByPolarity(whichUnit, whichUnit, 'B0J1', level, 5., true, BUFF_LEVEL3)
                call UpdateUnitNoLimitMoveSpeed(whichUnit)
            else
                call UnitRemoveAbility(whichUnit, 'B0J1')
                call UpdateUnitNoLimitMoveSpeed(whichUnit)
            endif

            set enumGroup = AllocationGroup(329)
            call GroupAddGroupFast(g, enumGroup)
            loop
                set first = FirstOfGroup(enumGroup)
                exitwhen first == null
                call GroupRemoveUnit(enumGroup, first)

                if not IsUnitInRangeXY(first, tx, ty, area) then
                    call GroupRemoveUnit(g, first)
                    call UnitSubStunCount(first)
                    call SetUnitTimeScale(first, 1.)
                endif
            endloop
            
            call GroupEnumUnitsInRange(enumGroup, tx, ty, area + MAX_UNIT_COLLISION, null)
            loop
                set first = FirstOfGroup(enumGroup)
                exitwhen first == null
                call GroupRemoveUnit(enumGroup, first)
                
                // 存活，不在单位组，非自己单位，非中立被动单位
                if IsUnitInRangeXY(first, tx, ty, area) and UnitAlive(first) and not IsUnitCourier(first) and not IsUnitInGroup(first, g) and not IsUnitOwnedByPlayer(first, GetOwningPlayer(whichUnit)) and GetOwningPlayer(first)!= NEUTRAL_PASSIVE_PLAYER then
                    call GroupAddUnit(g, first)
                    call UnitAddStunCount(first)
                    call SetUnitTimeScale(first, 0.)
                endif
            endloop
            call DeallocateGroup(enumGroup)
        //else
        //    set U2 = whichUnit
        //    if LKI() and not IsUnitDummy(GetTriggerUnit()) and not IsUnitWard(GetTriggerUnit()) and IsUnitInGroup(GetTriggerUnit(), g) == false then
        //        call GroupAddUnit(g, GetTriggerUnit())
        //        call LLI(GetTriggerUnit())
        //    endif
        endif
        if c > max then
            if not IsGameEnd then

                loop
                    set first = FirstOfGroup(g)
                    exitwhen first == null
                    call GroupRemoveUnit(g, first)
    
                    call UnitSubStunCount(first)
                    call SetUnitTimeScale(first, 1.)
                endloop

            endif
            call UnitRemoveAbility(whichUnit, 'B0J1')
            call UpdateUnitNoLimitMoveSpeed(whichUnit)
            
            call KillUnit(d)
            call RemoveUnit(d)
            call KillUnit(LoadUnitHandle(HY, h, 18))
            call DeallocateGroup(g)

            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        endif
        set t = null
        set d = null
        set whichUnit = null
        set g = null
        set enumGroup = null
    endfunction
    function ChronosphereOnSpellEffect takes nothing returns nothing
        local unit    whichUnit    = GetTriggerUnit()
        local integer level        = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real    tx           = GetSpellTargetX()
        local real    ty           = GetSpellTargetY()
        local unit    chronosphere = CreateUnit(GetOwningPlayer(whichUnit),'u00L', tx, ty, 0)
        local integer h
        local trigger trig
        local unit    dummy = CreateUnit(GetOwningPlayer(whichUnit),'e00E', tx, ty, 0)
        // 粉
        call UnitAddAbility(dummy,'A21K')
        set trig = CreateTrigger()
        set h = GetHandleId(trig)
        call SaveUnitHandle(HY, h, 19, chronosphere)
        call SaveUnitHandle(HY, h, 18, dummy)
        call SaveUnitHandle(HY, h, 14, whichUnit)
        call SaveGroupHandle(HY, h, 220, AllocationGroup(330))
        call SaveInteger(HY, h, 28, 0)
        call SaveInteger(HY, h, 5, level)
        if GetUnitAbilityLevel(whichUnit, 'A1D7')> 0 then
            call SaveInteger(HY, h, 6, 33 + level * 2)
        else
            call SaveInteger(HY, h, 6, 28 + level * 2)
        endif
        call SavePlayerHandle(HY, h, 0, GetOwningPlayer(whichUnit))
        call TriggerRegisterTimerEvent(trig, .1, true)
        call TriggerRegisterTimerEvent(trig, 0, false)
        //call TriggerRegisterUnitInRange(trig, d, 425, Condition(function LJI))
        call TriggerAddCondition(trig, Condition(function ChronosphereOnUpdate))
        call UnitAddAbility(chronosphere, 'A45D')
        set whichUnit = null
        set chronosphere = null
        set trig = null
        set dummy = null
    endfunction

endscope
