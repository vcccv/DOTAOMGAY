
scope QueenOfPain

    //***************************************************************************
    //*
    //*  超声冲击波
    //*
    //***************************************************************************
    private struct SonicWave extends array
        
        real damage

        static method OnCollide takes Shockwave sw, unit targ returns boolean
            // 敌对存活非无敌非守卫非建筑
            if UnitAlive(targ) and IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) and not IsUnitInvulnerable(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                call UnitDamageTargetEx(sw.owner, targ, 7, thistype(sw).damage)
            endif
            return false
        endmethod
        
        implement ShockwaveStruct

    endstruct

    function SonicWaveOnSpellEffect takes nothing returns nothing
        local unit      whichUnit = GetRealSpellUnit(GetTriggerUnit())
        //local unit      targUnit  = GetSpellTargetUnit()
        local real      x = GetUnitX(whichUnit)
        local real      y = GetUnitY(whichUnit)
        local real      tx
        local real      ty
        local real      angle
        local Shockwave sw

        local integer level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real    distance  = 900. + GetUnitCastRangeBonus(whichUnit)
        local real    damage    = 200. + 90. * level
        local boolean isUpgrade = GetSpellAbilityId() == 'A28S'

        if isUpgrade then
            set damage = 325
            if GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId()) == 3 then
                set damage = 555
            elseif GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId()) == 2 then
                set damage = 440
            endif
        endif

        set tx = GetSpellTargetX()
        set ty = GetSpellTargetY()
        set angle = RadianBetweenXY(x, y, tx, ty)
        if x == tx and y == ty then
            set angle = GetUnitFacing(whichUnit) * bj_DEGTORAD
        else
            set angle = RadianBetweenXY(x, y, tx, ty)
        endif
  
        set sw = Shockwave.CreateByDistance(whichUnit, x, y, angle, distance)
        call sw.SetSpeed(1200.)
        set sw.minRadius = 100.
        set sw.maxRadius = 450.
        set sw.model = "effects\\SonicBreathStream.mdx"
        //call sw.FixTimeScale(0.033 + 1.166)
        set SonicWave(sw).damage = damage
        call SonicWave.Launch(sw)

        set whichUnit = null
    endfunction

    /*
    function CZA takes unit u, unit dummyUnit returns boolean
        return(IsUnitEnemy(dummyUnit, GetOwningPlayer(u)) and(IsAliveNotStrucNotWard(u)))!= null
    endfunction

    // 意义不明
    // dt == 7
    function C_A takes unit u, unit triggerUnit, integer dt, real damageValue, boolean C0A returns nothing
        if CZA(triggerUnit, u) then
            if IsUnitMagicImmune(triggerUnit) == false then
                call UnitDamageTargetEx(u, triggerUnit, dt, damageValue) // 一样的
            elseif C0A then
                call UnitDamageTargetEx(u, triggerUnit, 7, damageValue)
            endif
        endif
    endfunction
    function C1A takes nothing returns nothing
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit u = LoadUnitHandle(HY, h, 0)
        local real damageValue = LoadReal(HY, h, 0)
        local real I3X = LoadReal(HY, h, 3)* bj_DEGTORAD
        local real N3X = LoadReal(HY, h, 4)
        local real tX = LoadReal(HY, h, 5)
        local real tY = LoadReal(HY, h, 6)
        local real C2A = LoadReal(HY, h, 8)
        local real LMR = LoadReal(HY, h, 9)
        local unit triggerUnit
        local group g
        local group gg
        local boolean C3A = LoadBoolean(HY, h, 10)
        local boolean C4A = false
        local integer dt = LoadInteger(HY, h, 1)
        local boolean C0A = LoadBoolean(HY, h, 0)
        if GetTriggerEventId() == EVENT_GAME_TIMER_EXPIRED then
            call SetUnitX(u, GetUnitX(u)+ N3X * Cos(I3X))
            call SetUnitY(u, GetUnitY(u)+ N3X * Sin(I3X))
            call SaveInteger(HY, h, 12, LoadInteger(HY, h, 12)+ 1)
            if GetDistanceBetween(GetUnitX(u), GetUnitY(u), tX, tY)< 100  or LoadInteger(HY, h, 12)> LoadInteger(HY, h, 13) then
                set C4A = true
                call SetUnitX(u, tX)
                call SetUnitY(u, tY)
            endif
        else
            set triggerUnit = GetTriggerUnit()
        endif
        if C3A then
            set g = LoadGroupHandle(HY, h, 2)
            set gg = AllocationGroup(430)
            set U2 = u
            call GroupEnumUnitsInRange(gg, GetUnitX(u), GetUnitY(u), C2A + LMR *(GetTriggerEvalCount(t)-1), Condition(function DUX))
            call GroupRemoveGroup(g, gg)
            loop
                set triggerUnit = FirstOfGroup(gg)
            exitwhen triggerUnit == null
                call GroupRemoveUnit(gg, triggerUnit)
                call GroupAddUnit(g, triggerUnit)
                call C_A(LoadUnitHandle(HY, h, 17), triggerUnit, dt, damageValue, C0A)
            endloop
            call DeallocateGroup(gg)
            set gg = null
            if C4A then
                call DeallocateGroup(g)
            endif
        else
            call C_A(LoadUnitHandle(HY, h, 17), triggerUnit, dt, damageValue, C0A)
        endif
        if C4A then
            call FlushChildHashtable(HY, h)
            call CleanCurrentTrigger(t)
            call KillUnit(u)
        endif
        set u = null
        set g = null
        set gg = null
        set t = null
    endfunction
    function C5A takes unit whichUnit, integer unitTypeId, real damageValue, real O_A, real C2A, real QTR, real fX, real fY, real tX, real tY, real N3X, integer dt, boolean C0A returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local real I3X = AngleBetweenXY(fX, fY, tX, tY)
        local unit u = CreateUnit(GetOwningPlayer(whichUnit), unitTypeId, fX, fY, I3X)
        local real C6A = .02
        call SetUnitX(u, fX + C2A * Cos(I3X * bj_DEGTORAD))
        call SetUnitY(u, fY + C2A * Sin(I3X * bj_DEGTORAD))
        call SaveUnitHandle(HY, h, 0, u)
        call SaveReal(HY, h, 0, damageValue)
        call SaveReal(HY, h, 1, O_A)
        call SaveReal(HY, h, 2, QTR)
        call SaveUnitHandle(HY, h, 17, whichUnit)
        if C2A != QTR then
            call SaveReal(HY, h, 8, C2A)
            call SaveReal(HY, h, 9,(QTR -C2A)* C6A)
            call SaveGroupHandle(HY, h, 2, AllocationGroup(431))
            call SaveBoolean(HY, h, 10, true)
        else
            call TriggerRegisterUnitInRange(t, u, QTR + 25, null)
        endif
        call SaveReal(HY, h, 3, I3X)
        call SaveReal(HY, h, 4, N3X * C6A)
        call SaveInteger(HY, h, 13, R2I(O_A / LoadReal(HY, h, 4))+ 1)
        call SaveReal(HY, h, 5, GetUnitX(u)+ O_A * Cos(I3X * bj_DEGTORAD))
        call SaveReal(HY, h, 6, GetUnitY(u)+ O_A * Sin(I3X * bj_DEGTORAD))
        call SaveInteger(HY, h, 1, dt)
        call SaveBoolean(HY, h, 0, C0A)
        call TriggerRegisterTimerEvent(t, C6A, true)
        call TriggerRegisterTimerEvent(t, 0, false)
        call TriggerAddCondition(t, Condition(function C1A))
        set u = null
        set t = null
    endfunction
    function BSE takes nothing returns nothing
        local real damageValue = 325
        if GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId()) == 3 then
            set damageValue = 555
        elseif GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId()) == 2 then
            set damageValue = 440
        endif
        call C5A(GetTriggerUnit(),'h02C', damageValue, 800, 100, 450, GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()), GetSpellTargetX(), GetSpellTargetY(), 800, 7, true)
    endfunction
    function SonicWaveOnSpellEffect takes nothing returns nothing
        local real damageValue = 200+ 90 * GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId())
        call C5A(GetTriggerUnit(),'h02C', damageValue, 800, 100, 450, GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()), GetSpellTargetX(), GetSpellTargetY(), 800, 7, true)
    endfunction
    */

endscope
