
scope StormSpirit

    //***************************************************************************
    //*
    //*  球状闪电
    //*
    //***************************************************************************
    function MIR takes nothing returns nothing
        if (LoadBoolean(HY,(HWV),(GetHandleId(GetEnumUnit())))) == false then
            call SaveBoolean(HY,(HWV),(GetHandleId(GetEnumUnit())),(true))
            call UnitDamageTargetEx(HZV, GetEnumUnit(), 1, H_V *(HYV * 4 + 4)/  100 )
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl", GetEnumUnit(), "origin"))
        endif
    endfunction
    function MAR takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local integer level =(LoadInteger(HY, h, 5))
        local unit dummyCaster =(LoadUnitHandle(HY, h, 19))
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local unit MNR =(LoadUnitHandle(HY, h, 195))
        local integer Y2X =(LoadInteger(HY, h, 194))
        local real tx =(LoadReal(HY, h, 6))
        local real ty =(LoadReal(HY, h, 7))
        local real GRR = GetUnitX(whichUnit)
        local real GIR = GetUnitY(whichUnit)
        local real a = Atan2(ty -GIR, tx -GRR)
        local real LMR = LoadReal(HY, h, 0)
        local real targetX = GRR +(LMR)* Cos(a)
        local real targetY = GIR +(LMR)* Sin(a)
        local lightning APX =(LoadLightningHandle(HY, h, 196))
        local real lx =(LoadReal(HY, h, 197))
        local real ly =(LoadReal(HY, h, 198))
        local real DDO = GetUnitState(whichUnit, UNIT_STATE_MANA)
        local real MBR
        local group g = AllocationGroup(167)
        local real MCR =(LoadReal(HY, h, 199))
        local boolean MDR = LoadBoolean(HY, h, 0)
        if MDR then
            set MBR =(LMR)*( 10+ .006 * GetUnitState(whichUnit, UNIT_STATE_MAX_MANA))/  100 
        else
            set MBR =(LMR)*( 12+ .007 * GetUnitState(whichUnit, UNIT_STATE_MAX_MANA))/  100 
        endif
        set MCR = MCR + LMR
        call SaveReal(HY, h, 199,((MCR)* 1.))
        if GetTriggerEvalCount(t)> 25 then
            set lx = lx +(LMR)* Cos(a)
            set ly = ly +(LMR)* Sin(a)
            call SaveReal(HY, h, 197,((lx)* 1.))
            call SaveReal(HY, h, 198,((ly)* 1.))
        endif
        call SetUnitState(whichUnit, UNIT_STATE_MANA, RMaxBJ(DDO -MBR, 0))
        call MoveLightning(APX, true, lx, ly, targetX, targetY)
        if IsUnitType(whichUnit, UNIT_TYPE_HERO) then
            call SaveBoolean(OtherHashTable, GetHandleId(whichUnit), 99, true)
        endif
        call SetUnitX(whichUnit, targetX)
        call SetUnitY(whichUnit, targetY)
        call SetUnitPosition(dummyCaster, targetX, targetY)
        call SetUnitPosition(MNR, targetX, targetY)
        set TempUnit = whichUnit
        set HZV = whichUnit
        set HWV = h
        set HYV = level
        set H_V = MCR
        call GroupEnumUnitsInRange(g, targetX, targetY, 75 + 75 * level, Condition(function DHX))
        call ForGroup(g, function MIR)
        call DeallocateGroup(g)
        set Y2X = Y2X -1
        call SaveInteger(HY, h, 194,(Y2X))
        call SetUnitVertexColorEx(whichUnit,-1,-1,-1, 0)
        if Y2X == 0 or GetUnitState(whichUnit, UNIT_STATE_MANA)< 1 then
            call DestroyLightning(APX)
            call KillTreeByCircle(targetX, targetY, 75)
            call DestroyEffect((LoadEffectHandle(HY, h, 32)))
            call RemoveUnit(dummyCaster)
            call RemoveUnit(MNR)

            call UnitSubHideByColorCount(whichUnit)
            call UnitSubNoPathingCount(whichUnit)
            call UnitSubInvulnerableCount(whichUnit)

            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        else
            call KillTreeByCircle(targetX, targetY, 75)
        endif
        set t = null
        set dummyCaster = null
        set whichUnit = null
        set APX = null
        set g = null
        set MNR = null
        return false
    endfunction
    function BallLightningOnSpellEffect takes nothing returns nothing
        local unit whichUnit = GetTriggerUnit()
        local real sx = GetUnitX(whichUnit)
        local real sy = GetUnitY(whichUnit)
        local unit dummyCaster
        local unit MNR
        local real x
        local real y
        local trigger t
        local integer h
        local lightning APX
        local integer level = GetUnitAbilityLevel(whichUnit,'A14O')+ GetUnitAbilityLevel(whichUnit,'A3FJ')
        local real DDO = GetUnitState(whichUnit, UNIT_STATE_MANA)
        local real MBR = 30 + .08 * GetUnitState(whichUnit, UNIT_STATE_MAX_MANA)
        local boolean MDR = false
        local real EOX
        if GetUnitAbilityLevel(whichUnit,'A3FJ')> 0 then
            set MBR = 15+ .05 * GetUnitState(whichUnit, UNIT_STATE_MAX_MANA)
            set MDR = true
        endif
        call SetUnitState(whichUnit, UNIT_STATE_MANA, RMaxBJ(DDO -MBR, 0))
        if GetUnitState(whichUnit, UNIT_STATE_MANA)> 10 then
            set t = CreateTrigger()
            set h = GetHandleId(t)
            set dummyCaster = CreateUnit(GetOwningPlayer(whichUnit),'o010', sx, sy, 0)
            set MNR = CreateUnit(GetOwningPlayer(whichUnit),'H07G', sx, sy, 0)
            set APX = AddLightning("FORK", true, sx, sy, sx, sy)
            if GetSpellTargetUnit() == null then
                set x = GetSpellTargetX()
                set y = GetSpellTargetY()
            else
                set x = GetUnitX(GetSpellTargetUnit())
                set y = GetUnitY(GetSpellTargetUnit())
            endif
            set EOX = GetDistanceBetween(x, y, sx, sy)
            if EOX < 25 + 25 * level then
                call SaveReal(HY, h, 0, EOX)
            else
                call SaveReal(HY, h, 0, 25 + 25 * level)
            endif
            
            call SetUnitVertexColor(MNR, 255, 255, 255, 0)

            call UnitAddHideByColorCount(whichUnit)
            call UnitAddNoPathingCount(whichUnit)
            call UnitAddInvulnerableCount(whichUnit)

            call SetUnitPathing(dummyCaster, false)
            call SaveUnitHandle(HY, h, 19,(dummyCaster))
            call SaveUnitHandle(HY, h, 2,(whichUnit))
            call SaveUnitHandle(HY, h, 195,(MNR))
            call SaveLightningHandle(HY, h, 196,(APX))
            call SaveInteger(HY, h, 5,(level))
            call SaveReal(HY, h, 6,((x)* 1.))
            call SaveReal(HY, h, 7,((y)* 1.))
            call SaveReal(HY, h, 197,((sx)* 1.))
            call SaveReal(HY, h, 198,((sy)* 1.))
            call SaveReal(HY, h, 199,(0 * 1.))
            call SaveInteger(HY, h, 194,(IMaxBJ(R2I(SquareRoot((x -sx)*(x -sx)+(y -sy)*(y -sy))/(25 + 25 * level)), 1)))
            call SaveEffectHandle(HY, h, 32,(AddSpecialEffectTarget("effects\\Lightning_Ball_Tail_FX.mdx", MNR, "origin")))
            call TriggerRegisterTimerEvent(t, .04, true)
            call TriggerAddCondition(t, Condition(function MAR))

            call UnitDodgeMissile(whichUnit)
            call SaveBoolean(HY, h, 0, MDR)
        endif
        set whichUnit = null
        set dummyCaster = null
        set MNR = null
        set t = null
        set APX = null
    endfunction

    //***************************************************************************
    //*
    //*  雷电牵引
    //*
    //***************************************************************************
    function MGR takes nothing returns nothing
        if IsUnitEnemy(GetEnumUnit(), GetOwningPlayer(MA)) then
            call UnitDamageTargetEx(MA, GetEnumUnit(), 1, QA)
            call UnitAddAbilityToTimed(GetEnumUnit(),'A3B7', 1, 1.,'B3B7')
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl", GetEnumUnit(), "origin"))
        endif
        call UnitSubNoPathingCount(GetEnumUnit())
    endfunction
    function MHR takes nothing returns nothing
        call SetUnitPosition(GetEnumUnit(), GetUnitX(GetEnumUnit())+ 40 * Cos(LA), GetUnitY(GetEnumUnit())+ 40 * Sin(LA))
        call KillTreeByCircle(GetUnitX(GetEnumUnit()), GetUnitY(GetEnumUnit()), 200)
    endfunction

    function MJR takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer h = GetHandleId(t)
        local real a = LoadReal(HY, h, 0)
        local integer c = LoadInteger(HY, h, 0)-1
        local unit whichUnit = LoadUnitHandle(HY, h, 0)
        local real x = GetUnitX(whichUnit)
        local real y = GetUnitY(whichUnit)
        local group g = null
        if c < 1 or GetDistanceBetween(x, y, LoadReal(HY, h, 1), LoadReal(HY, h, 2))< 50 then
            set MA = whichUnit
            set QA = LoadInteger(HY, h, 5)* 50 + 50
            set g = AllocationGroup(168)
            set TempUnit = whichUnit
            call GroupEnumUnitsInRange(g, x, y, 275, Condition(function DHX))
            call GroupAddGroup(g, LoadGroupHandle(HY, h, 10))
            call ForGroup(LoadGroupHandle(HY, h, 10), function MGR)
            call DeallocateGroup(g)
            call KillTreeByCircle(x, y, 200)
            call DestroyLightning(LoadLightningHandle(HY, h, 11))
            call DeallocateGroup(LoadGroupHandle(HY, h, 10))
            call DestroyTimerAndFlushHT_HY(t)
        else
            set LA = a
            call ForGroup(LoadGroupHandle(HY, h, 10), function MHR)
            call MoveLightning(LoadLightningHandle(HY, h, 11), true, x, y, LoadReal(HY, h, 1), LoadReal(HY, h, 2))
            call SaveInteger(HY, h, 0, c)
        endif
        set whichUnit = null
        set t = null
    endfunction
    function MKR takes nothing returns boolean
        return (IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) and UnitIsDead(GetFilterUnit()) == false)!= null
    endfunction
    function LightningGrappleOnSpellEffect takes nothing returns nothing
        local unit      whichUnit = GetTriggerUnit()
        local real      x = GetUnitX(whichUnit)
        local real      y = GetUnitY(whichUnit)
        local real      dx = GetSpellTargetX()
        local real      dy = GetSpellTargetY()
        local real      angle = AngleBetweenXY(x, y, dx, dy) * bj_DEGTORAD
        local group     g = AllocationGroup(169)
        local timer     t = CreateTimer()
        local integer   h = GetHandleId(t)
        local lightning l
        local real      maxDistance
        local group     enumGroup
        local unit      first
        local real      area = 350.
        
        set maxDistance = 800 + 200 * GetUnitAbilityLevel(whichUnit, GetSpellAbilityId()) + GetUnitCastRangeBonus(whichUnit)
        if GetDistanceBetween(x, y, dx, dy) > maxDistance then
            set dx = x + maxDistance * Cos(angle)
            set dy = y + maxDistance * Sin(angle)
        endif
        set l = AddLightning("CLPB", true, x, y, dx, dy)
        call SetLightningColor(l, .75, .75, 1, .75)

        set enumGroup = AllocationGroup(2466)
        call GroupEnumUnitsInRange(enumGroup, x, y, area + MAX_UNIT_COLLISION, Condition(function MKR))

        loop
            set first = FirstOfGroup(enumGroup)
            exitwhen first == null
            call GroupRemoveUnit(enumGroup, first)

            if IsUnitType(first, UNIT_TYPE_HERO) and IsUnitInRangeXY(first, x, y, area) and UnitAlive(first) then
                call GroupAddUnit(g, first)
                call UnitAddNoPathingCount(first)
            endif
            
        endloop

        call DeallocateGroup(enumGroup)

        call TimerStart(t, .03, true, function MJR)
        call SaveInteger(HY, h, 0, R2I(GetDistanceBetween(x, y, dx, dy)/ 40)+ 1)
        call SaveReal(HY, h, 0, angle)
        call SaveInteger(HY, h, 5, GetUnitAbilityLevel(whichUnit, GetSpellAbilityId()))
        call SaveGroupHandle(HY, h, 10, g)
        call SaveLightningHandle(HY, h, 11, l)
        call SaveUnitHandle(HY, h, 0, whichUnit)
        call SaveReal(HY, h, 1, dx)
        call SaveReal(HY, h, 2, dy)
        set l = null
        set t = null
        set whichUnit = null
        set g = null
    endfunction

endscope
