
scope Invoker

    //***************************************************************************
    //*
    //*  超震声波
    //*
    //***************************************************************************
    // 卡尔b缴械
    // 缴械时间为 1 + lv * 0.5
    // 可考虑用保持货物模拟缴械
    function L4I takes unit whichUnit, unit targetUnit, integer level returns nothing
        local unit dummyCaster = CreateUnit(GetOwningPlayer(whichUnit),'e00E', GetUnitX(targetUnit), GetUnitY(targetUnit), 0)
        call UnitAddPermanentAbility(dummyCaster,'A0VT')
        call SetUnitAbilityLevel(dummyCaster,'A0VT', level)
        call IssueTargetOrderById(dummyCaster, 852585, targetUnit)
        set dummyCaster = null
    endfunction
    function L5I takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local unit targetUnit =(LoadUnitHandle(HY, h, 17))
        local real a =(LoadReal(HY, h, 13))
        local real J0R =(LoadReal(HY, h, 193))
        local integer level =(LoadInteger(HY, h, 5))
        local integer KLR = level * 40 / 3
        local real x
        local real y
        local integer count = GetTriggerEvalCount(t)
        if count > KLR / 3 then
            call SaveReal(HY, h, 193,((J0R * .98)* 1.))
        endif
        if count > KLR or GetTriggerEventId() == EVENT_WIDGET_DEATH then
            call FlushChildHashtable(HY, h)
            call CleanCurrentTrigger(t)
            if GetTriggerEventId()!= EVENT_WIDGET_DEATH then
                call L4I(whichUnit, targetUnit, level)
            endif
        else
            set x = CoordinateX50(GetUnitX(targetUnit)+ J0R * Cos(a))
            set y = CoordinateY50(GetUnitY(targetUnit)+ J0R * Sin(a))
            call A3X(x, y, 150)
            call SetUnitPosition(targetUnit, x, y)
        endif
        set t = null
        set whichUnit = null
        set targetUnit = null
        return false
    endfunction

    // 超震声波 位移
    function L6I takes unit whichUnit, unit targetUnit, integer level returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local real a = Atan2(GetUnitY(targetUnit)-GetUnitY(whichUnit), GetUnitX(targetUnit)-GetUnitX(whichUnit))
        call UnitDamageTargetEx(whichUnit, targetUnit, 1, 20 + 60 * level)
        call SaveUnitHandle(HY, h, 2,(whichUnit))
        call SaveUnitHandle(HY, h, 17,(targetUnit))
        call SaveReal(HY, h, 13,((a)* 1.))
        call SaveReal(HY, h, 193,(6 * 1.))
        call SaveInteger(HY, h, 5,(level))
        call TriggerRegisterTimerEvent(t, .03, true)
        call TriggerRegisterDeathEvent(t, targetUnit)
        call TriggerAddCondition(t, Condition(function L5I))
        set t = null
    endfunction

    private struct DeafeningBlast extends array
        
        real damage

        static method OnCollide takes Shockwave sw, unit targ returns boolean
             // 敌对存活非魔免非无敌非守卫非建筑
             if UnitAlive(targ) and IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) and not IsUnitMagicImmune(targ) and not IsUnitInvulnerable(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                call UnitDamageTargetEx(sw.owner, targ, 7, thistype(sw).damage)
            endif
            return false
        endmethod
        
        implement ShockwaveStruct

    endstruct

    function L7I takes nothing returns nothing
        if IsUnitInGroup(GetEnumUnit(), DK) == false and IsUnitMagicImmune(GetEnumUnit()) == false then
            call GroupAddUnit(DK, GetEnumUnit())
            call L6I(U2, GetEnumUnit(), Q2)
        endif
    endfunction

    function L8I takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit dummyCaster =(LoadUnitHandle(HY, h, 19))
        local real a =(LoadReal(HY, h, 137))
        local real x2 =(LoadReal(HY, h, 66))
        local real y2 =(LoadReal(HY, h, 67))
        local group g =(LoadGroupHandle(HY, h, 22))
        local integer level =(LoadInteger(HY, h, 5))
        local real x = GetUnitX(dummyCaster)
        local real y = GetUnitY(dummyCaster)
        local group g2
        if GetDistanceBetween(x, y, x2, y2)< 100 then
            set x = x2
            set y = y2
        else
            set x = x + 33 * Cos(a)
            set y = y + 33 * Sin(a)
        endif
        call SetUnitX(dummyCaster, CoordinateX50(x))
        call SetUnitY(dummyCaster, CoordinateY50(y))
        set g2 = AllocationGroup(331)
        set U2 = dummyCaster
        set DK = g
        set Q2 = level
        call GroupEnumUnitsInRange(g2, x, y, 200, Condition(function DPX))
        call ForGroup(g2, function L7I)
        call DeallocateGroup(g2)
        if (x == x2 and y == y2) or GetTriggerEvalCount(t)> 35 then
            set g2 = AllocationGroup(332)
            set U2 = dummyCaster
            set DK = g
            set Q2 = level
            call GroupEnumUnitsInRange(g2, x, y, 250, Condition(function DPX))
            call ForGroup(g2, function L7I)
            call DeallocateGroup(g2)
            call FlushChildHashtable(HY, h)
            call CleanCurrentTrigger(t)
            call KillUnit(dummyCaster)
            call DeallocateGroup(g)
        endif
        set t = null
        set dummyCaster = null
        set g = null
        set g2 = null
        return false
    endfunction

    function L9I takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local group g =(LoadGroupHandle(HY,(h), 22))
        local integer i = 0
        local unit d
        local real a
        local real tx
        local real ty
        local real x
        local real y
        local group gg
        set gg = AllocationGroup(333)
        loop
            set d = LoadUnitHandle(HY, h, 100 + i)
            set tx = LoadReal(HY, h, 200 + i)
            set ty = LoadReal(HY, h, 300 + i)
            set a = LoadReal(HY, h, 100 + i)
            set x = GetUnitX(d)
            set y = GetUnitY(d)
            if GetDistanceBetween(x, y, tx, ty)< 100  then
                set x = tx
                set y = ty
            else
                set x = x + 33 * Cos(a)
                set y = y + 33 * Sin(a)
            endif
            call SetUnitX(d, CoordinateX50(x))
            call SetUnitY(d, CoordinateY50(y))
            set U2 = d
            set DK = g
            set Q2 = 4
            call GroupEnumUnitsInRange(gg, x, y, 200, Condition(function DHX))
            call ForGroup(gg, function L7I)
            if GetTriggerEvalCount(t)> 30 then
                call GroupClear(gg)
                set U2 = d
                set DK = g
                set Q2 = 4
                call GroupEnumUnitsInRange(gg, x, y, 250, Condition(function DHX))
                call ForGroup(gg, function L7I)
                call GroupClear(gg)
                call KillUnit(d)
            endif
            call GroupClear(gg)
            set i = i + 1
        exitwhen i == 12
        endloop
        call DeallocateGroup(gg)
        if GetTriggerEvalCount(t)> 33 then
            call FlushChildHashtable(HY,(h))
            call CleanCurrentTrigger(t)
            call DeallocateGroup(g)
        endif
        set t = null
        set d = null
        set g = null
        set gg = null
        return false
    endfunction

    // 超震声波 - A
    function MVI takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = GetTriggerUnit()
        local real a = 0
        local unit d
        local integer i = 0
        local integer Z6X = 12
        loop
            set a = 30 * i
            set d = CreateUnit(GetOwningPlayer(whichUnit),'n01X', GetUnitX(whichUnit), GetUnitY(whichUnit), a)
            call SaveUnitHandle(HY, h, 100 + i, d)
            call SaveReal(HY, h, 100 + i, a * bj_DEGTORAD)
            call SetUnitX(d, GetUnitX(whichUnit))
            call SetUnitY(d, GetUnitY(whichUnit))
            call SaveReal(HY, h, 200 + i, CoordinateX50(GetUnitX(d)+ 1000 * Cos(a * bj_DEGTORAD)))
            call SaveReal(HY, h, 300 + i, CoordinateY50(GetUnitY(d)+ 1000 * Sin(a * bj_DEGTORAD)))
            set i = i + 1
        exitwhen i == Z6X
        endloop
        call TriggerRegisterTimerEvent(t, .03, true)
        call TriggerAddCondition(t, Condition(function L9I))
        call SaveGroupHandle(HY,(h), 22,(AllocationGroup(334)))
        call SaveInteger(HY, h, 0, 10)
        set t = null
        set whichUnit = null
    endfunction

    function MEI takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = GetTriggerUnit()
        local real x = GetSpellTargetX()
        local real y = GetSpellTargetY()
        local real a = Atan2(y -GetUnitY(whichUnit), x -GetUnitX(whichUnit))
        local integer level = GetUnitAbilityLevel(whichUnit,'Z610')
        local unit dummyCaster = CreateUnit(GetOwningPlayer(whichUnit),'n01X', GetUnitX(whichUnit), GetUnitY(whichUnit), a * bj_RADTODEG)
        call TriggerRegisterTimerEvent(t, .03, true)
        call TriggerAddCondition(t, Condition(function L8I))
        call SaveUnitHandle(HY, h, 19,(dummyCaster))
        call SaveReal(HY, h, 137,((a)* 1.))
        call SaveReal(HY, h, 66,((GetUnitX(whichUnit)+ 1000* Cos(a))* 1.))
        call SaveReal(HY, h, 67,((GetUnitY(whichUnit)+ 1000* Sin(a))* 1.))
        call SaveGroupHandle(HY, h, 22,(AllocationGroup(335)))
        call SaveInteger(HY, h, 5,(level))
        set t = null
        set whichUnit = null
        set dummyCaster = null
    endfunction

    // 超震声波
    function DeafeningBlastOnSpellEffect takes nothing returns nothing
        local unit      whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local unit      targUnit  = GetSpellTargetUnit()
        local real      x = GetUnitX(whichUnit)
        local real      y = GetUnitY(whichUnit)
        local real      tx
        local real      ty
        local real      angle
        local Shockwave sw

        local integer level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real    distance  = 1075. + GetUnitCastRangeBonus(whichUnit)
        local real    damage
        local boolean isUpgrade = GetSpellAbilityId() == 'A3K5'

        if not isUpgrade then
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
            call sw.SetSpeed(1200.)
            set sw.minRadius = 275.
            set sw.maxRadius = 200.
            set sw.model = "units\\human\\phoenix\\phoenix.mdl"
            set DeafeningBlast(sw).damage = 20. + 60. * level
            set DeafeningBlast(sw).level = level
            call DeafeningBlast.Launch(sw)
        endif

        set whichUnit = null

        if GetSpellAbilityId()=='A3K5' then
            call MVI()
        else
            call MEI()
        endif
    endfunction

endscope
