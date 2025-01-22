
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
        set U2 = whichUnit
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
            call CleanCurrentTrigger(t)
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

endscope
