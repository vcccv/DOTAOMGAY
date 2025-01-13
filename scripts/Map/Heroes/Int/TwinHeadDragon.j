
scope TwinHeadDragon

    //***************************************************************************
    //*
    //*  冰封路径
    //*
    //***************************************************************************

    function U6R takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local real x =(LoadReal(HY,(h), 6))
        local real y =(LoadReal(HY,(h), 7))
        local real a =(LoadReal(HY,(h), 137))
        local unit whichUnit =(LoadUnitHandle(HY,(h), 2))
        local integer c = GetTriggerEvalCount(t)
        local real dx
        local real dy
        local group g
        local integer i
        local group gg =(LoadGroupHandle(HY,(h), 187))
        local integer level = LoadInteger(HY, h, 5)
        local unit u
        local real GEX
        set i = 0
        set g = AllocationGroup(204)
        loop
            set dx = x + 100 * i * Cos(a * bj_DEGTORAD)
            set dy = y + 100 * i * Sin(a * bj_DEGTORAD)
            set U2 = whichUnit
            set GEX =(.6 + .4 * level)-(c * .05)
            call GroupEnumUnitsInRange(g, dx, dy, 175, Condition(function DJX))
            call GroupRemoveGroup(gg, g)
            loop
                set u = FirstOfGroup(g)
            exitwhen u == null
                if IsUnitInGroup(u, gg) == false and RCX(u) == false then
                    call GroupAddUnit(gg, u)
                    call CommonUnitAddStun(u, GEX, false)
                    call UnitDamageTargetEx(whichUnit, u, 1, 50)
                    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\FreezingBreath\\FreezingBreathMissile.mdl", GetUnitX(u), GetUnitY(u)))
                endif
                call GroupRemoveUnit(g, u)
            endloop
            set i = i + 1
        exitwhen i > 13
        endloop
        call DeallocateGroup(g)
        if c == 20 *(.6 + .4 * level) then
            call DeallocateGroup(gg)
            call FlushChildHashtable(HY,(h))
            call CleanCurrentTrigger(t)
        endif
        set t = null
        set whichUnit = null
        set g = null
        set gg = null
        return false
    endfunction
    function IcePathOnLoopAction takes nothing returns boolean
        local trigger   t  = GetTriggeringTrigger()
        local integer   h  = GetHandleId(t)
        local real      x  = (LoadReal(HY, h, 6))
        local real      y  = (LoadReal(HY, h, 7))
        local real      a  = (LoadReal(HY, h, 137))
        local integer   c  = GetTriggerEvalCount(t)
        local real      dx = x + 100 * c * Cos(a * bj_DEGTORAD)
        local real      dy = y + 100 * c * Sin(a * bj_DEGTORAD)
        local real      maxDistance = LoadReal(HY, h, 1)
        local real      distance    = LoadReal(HY, h, 2) + 100.
        local unit      whichUnit   = LoadUnitHandle(HY, h, 2)
        local integer   level       = LoadInteger(HY, h, 5)
        local ubersplat ub
        local integer   i
        call SaveReal(HY, h, 2, distance)
        if distance < maxDistance then
            call SaveEffectHandle(HY, h,(609 + c),(AddSpecialEffect("effects\\IcePath.mdx", dx, dy)))
            set ub = CreateUbersplat(dx, dy, "IPTH", 255, 255, 255, 255, false, false)
            call SetUbersplatRenderAlways(ub, true)
            call SaveUbersplatHandle(HY, h,(760 + c),(ub))
        endif
        if distance >= maxDistance then
            set t = CreateTrigger()
            set h = GetHandleId(t)
            call TriggerRegisterTimerEvent(t, .05, true)
            call TriggerAddCondition(t, Condition(function U6R))
            call SaveInteger(HY, h, 5, level)
            call SaveReal(HY, h, 6,((x)* 1.))
            call SaveReal(HY, h, 7,((y)* 1.))
            call SaveReal(HY, h, 137,((a)* 1.))
            call SaveUnitHandle(HY, h, 2,(whichUnit))
            call SaveGroupHandle(HY, h, 187,(AllocationGroup(205)))
            call TriggerEvaluate(t)
        elseif c >=(.4 + .6 + .4 * level)/ .05 then
            set i = 0
            loop
                call DestroyEffect((LoadEffectHandle(HY, h,(609 + i))))
                call DestroyUbersplat((LoadUbersplatHandle(HY, h,(760 + i))))
                set i = i + 1
            exitwhen i == 14
            endloop
            call FlushChildHashtable(HY,(h))
            call CleanCurrentTrigger(t)
        endif
        set t = null
        set whichUnit = null
        return false
    endfunction
    function IcePathOnSpellEffect takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = GetTriggerUnit()
        local real x = GetUnitX(whichUnit)
        local real y = GetUnitY(whichUnit)
        local real a = AngleBetweenXY(x, y, GetSpellTargetX(), GetSpellTargetY())
        call TriggerRegisterTimerEvent(t, .05, true)
        call TriggerAddCondition(t, Condition(function IcePathOnLoopAction))
        call SaveReal(HY,(h), 6,((x)* 1.))
        call SaveReal(HY,(h), 7,((y)* 1.))
        call SaveInteger(HY, h, 5, GetUnitAbilityLevel(whichUnit,'A0O6'))
        call SaveReal(HY,(h), 137,((a)* 1.))
        call SaveReal(HY, h, 1, 1400. + GetUnitCastRangeBonus(whichUnit))
        call SaveReal(HY, h, 2, 0.)
        call SaveUnitHandle(HY,(h), 2,(whichUnit))
        call TriggerEvaluate(t)
        set t = null
        set whichUnit = null
    endfunction

    //***************************************************************************
    //*
    //*  烈火焚身
    //*
    //***************************************************************************

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
