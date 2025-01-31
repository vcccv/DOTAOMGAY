
scope RiddenHippogryph
    
    //***************************************************************************
    //*
    //*  俯冲
    //*
    //***************************************************************************
    function DIR takes unit u, boolean DAR returns nothing
        local unit d = CreateUnit(GetOwningPlayer(u),'e00E', GetUnitX(u), GetUnitY(u), 0)
        local integer T0V ='A462'
        local integer level = 1
        if DAR then
            set level = 2
        endif
        call UnitAddAbility(d, T0V)
        call SetUnitAbilityLevel(d, T0V, level)
        call IssueTargetOrderById(d, 852095, u)
        call AddTimedEffectToUnit("Abilities\\Spells\\Orc\\Ensnare\\ensnare_AirTarget.mdl", u, "origin", .5)
        set d = null
    endfunction
    function SwoopDownOnUpdate takes nothing returns nothing
        local integer h = GetHandleId(GetExpiredTimer())
        local unit whichUnit =(LoadUnitHandle(HY, h, 290))
        local unit trigUnit =(LoadUnitHandle(HY, h, 14))
        local real sx =(LoadReal(HY, h, 284))
        local real sy =(LoadReal(HY, h, 285))
        local real tx =(LoadReal(HY, h, 286))
        local real ty =(LoadReal(HY, h, 287))
        local real Bx =(LoadReal(HY, h, 288))
        local real By =(LoadReal(HY, h, 289))
        local real a =(LoadReal(HY, h, 137))
        local real b = 1 -a
        local boolean DBR =(LoadBoolean(HY, h, 291))
        local real DCR = RMaxBJ(GetDistanceBetween(sx, sy, tx, ty)/  1300, .2)
        local boolean bb = LoadBoolean(HY, h, 0)
        local group g = null
        local real x = CoordinateX50(sx * a * a + Bx * 2 * a * b + tx * b * b)
        local real y = CoordinateY50(sy * a * a + By * 2 * a * b + ty * b * b)
        local unit u
        local real ILX
        call SetUnitFacing(whichUnit, AngleBetweenXY(GetUnitX(whichUnit), GetUnitY(whichUnit), x, y))
        call SetUnitX(whichUnit, x)
        call SetUnitY(whichUnit, y)
        if GetDistanceBetween(x, y, tx, ty)< 50 and bb == false then
            call SaveBoolean(HY, h, 0, true)
            set g = AllocationGroup(121)
            set QN = whichUnit
            set SN = GetUnitAbilityLevel(whichUnit,'A461')
            set MN = null
            set LN = 999999
            call GroupEnumUnitsInRange(g, x, y, 300, Condition(function DRR))
            if MN != null then
                call SaveBoolean(HY, h, 1, true)
                call SaveUnitHandle(HY, h, 1, MN)
            endif
            loop
                set u = FirstOfGroup(g)
            exitwhen u == null
                call UnitDamageTargetEx(whichUnit, u, 1, SN * 50 + 50)
                call DIR(u, false)
                call GroupRemoveUnit(g, u)
            endloop
            call DeallocateGroup(g)
            set g = null
        endif
        if LoadBoolean(HY, h, 1) then
            call SetUnitPosition(LoadUnitHandle(HY, h, 1), x, y)
        endif
        if (DBR) then
            call SaveReal(HY, h, 137,((a -0.02 / DCR)* 1.))
            call SetUnitFlyHeight(whichUnit, GetUnitFlyHeight(whichUnit)+ LoadReal(HY, h, 291), 0)
        else
            call SaveReal(HY, h, 137,((a + .02 / DCR)* 1.))
            call SetUnitFlyHeight(whichUnit, GetUnitFlyHeight(whichUnit)-LoadReal(HY, h, 291), 0)
        endif
        if (a < 0 and DBR) then
            call SaveBoolean(HY, h, 291,(false))
            call SaveReal(HY, h, 288,((sx + 300 * Cos(Atan2(ty -sy, tx -sx)+(LoadReal(HY, h, 292))))* 1.))
            call SaveReal(HY, h, 289,((sy + 300 * Sin(Atan2(ty -sy, tx -sx)+(LoadReal(HY, h, 292))))* 1.))
        endif
        if (a > 1 and DBR == false) then
            if LoadBoolean(HY, h, 1) then
                call UnitDamageTargetEx(whichUnit, LoadUnitHandle(HY, h, 1), 1, 50 + 50 * GetUnitAbilityLevel(whichUnit,'A461'))
                call DIR(LoadUnitHandle(HY, h, 1), true)
                call AddTimedEffectToUnit("Abilities\\Spells\\Orc\\Ensnare\\ensnare_AirTarget.mdl", LoadUnitHandle(HY, h, 1), "origin", 1)
                call KillTreeByCircle(GetUnitX(LoadUnitHandle(HY, h, 1)), GetUnitY(LoadUnitHandle(HY, h, 1)), 200)
            endif
            call SetUnitFlyHeight(whichUnit, LoadReal(HY, h, 290), 0)
            call KillTreeByCircle(GetUnitX(whichUnit), GetUnitY(whichUnit), 200)
            call PauseTimer(GetExpiredTimer())
            call FlushChildHashtable(HY, h)
            call DestroyTimer(GetExpiredTimer())
        endif
        set whichUnit = null
        set trigUnit = null
    endfunction
    function SwoopDownOnSpellEffect takes nothing returns nothing
        local unit whichUnit = GetTriggerUnit()
        local real sx = GetUnitX(whichUnit)
        local real sy = GetUnitY(whichUnit)
        local real tx = CoordinateX50(GetSpellTargetX())
        local real ty = CoordinateY50(GetSpellTargetY())
        local timer t = CreateTimer()
        local integer h = GetHandleId(t)
        local real a = AngleBetweenXY(sx, sy, tx, ty)* bj_DEGTORAD
        if GetDistanceBetween(sx, sy, tx, ty)< 300 then
            set tx = CoordinateX50(sx + 300 * Cos(a))
            set ty = CoordinateY50(sy + 300 * Sin(a))
        endif
        call SaveUnitHandle(HY, h, 14,(whichUnit))
        call SaveUnitHandle(HY, h, 290,(whichUnit))
        call SaveReal(HY, h, 284,((sx)* 1.))
        call SaveReal(HY, h, 285,((sy)* 1.))
        call SaveReal(HY, h, 286,((tx)* 1.))
        call SaveReal(HY, h, 287,((ty)* 1.))
        call SaveReal(HY, h, 288,((sx + 300 * Cos(Atan2(ty -sy, tx -sx)-45))* 1.))
        call SaveReal(HY, h, 289,((sy + 300 * Sin(Atan2(ty -sy, tx -sx)-45))* 1.))
        call SaveReal(HY, h, 137, 1.)
        call SaveReal(HY, h, 292, 45.)
        call SaveBoolean(HY, h, 291, true)
        call SaveReal(HY, h, 290, GetUnitFlyHeight(whichUnit))
        call SaveReal(HY, h, 291, 1300/ GetDistanceBetween(sx, sy, tx, ty))
        if not IsUnitModelFlying(whichUnit) then
            call UnitAddPermanentAbility(whichUnit,'Amrf')
            call UnitRemoveAbility(whichUnit,'Amrf')
        endif
        call TimerStart(t, .02, true, function SwoopDownOnUpdate)
        set whichUnit = null
        set t = null
    endfunction

endscope
