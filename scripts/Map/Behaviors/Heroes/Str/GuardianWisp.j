scope GuardianWisp

    globals
        constant integer HERO_INDEX_GUARDIAN_WISP = 29
    endglobals
    //***************************************************************************
    //*
    //*  幽魂
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_SPRIITS    = GetHeroSKillIndexBySlot(HERO_INDEX_GUARDIAN_WISP, 2)
        constant integer SPIRITS_IN_ABILITY_ID  = 'A24A'
        constant integer SPIRITS_OUT_ABILITY_ID = 'A24B'
    endglobals
    
    function GBA takes nothing returns nothing
        local integer GCA = PWV
        local unit targetUnit = GetEnumUnit()
        local integer GDA = 662 -1 + GCA
        local real GFA =(LoadReal(HY,(GetHandleId(targetUnit)),(GDA)))
        local real ECX =(GetGameTime())
        if GFA < ECX then
            call SaveReal(HY,(GetHandleId(targetUnit)),(GDA),((ECX + 2)* 1.))
            if IsUnitType(GetEnumUnit(), UNIT_TYPE_STRUCTURE) == false then
                call UnitDamageTargetEx(PQV, targetUnit, 1, 2 + 6 * PUV)
            endif
        endif
        set targetUnit = null
    endfunction
    function GGA takes nothing returns nothing
        if IsUnitType(GetEnumUnit(), UNIT_TYPE_STRUCTURE) == false then
            call UnitDamageTargetEx(PQV, GetEnumUnit(), 1, PSV)
            if IsUnitMagicImmune(GetEnumUnit()) == false then
                call CNX(GetEnumUnit(),'A437', 3, 1,'B0DI')
                call GQX(GetEnumUnit(),'A437','B0DI')
            endif
        endif
    endfunction
    function GHA takes unit whichUnit, unit GJA returns nothing
        local group g = AllocationGroup(446)
        set TempUnit = whichUnit
        set PSV = 25 * PUV
        set PQV = whichUnit
        call GroupEnumUnitsInRange(g, GetUnitX(GJA), GetUnitY(GJA), 325, Condition(function DZX))
        call ForGroup(g, function GGA)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\FreezingBreath\\FreezingBreathMissile.mdl", GetUnitX(GJA), GetUnitY(GJA)))
        call KillUnit(GJA)
        call DeallocateGroup(g)
        call UnitApplyTimedLife(CreateUnit(GetOwningPlayer(whichUnit),'o00Q', GetUnitX(GJA), GetUnitY(GJA), 0),'BTLF', 2)
        set g = null
    endfunction
    function GKA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local unit GLA =(LoadUnitHandle(HY, h, 393))
        local unit GMA =(LoadUnitHandle(HY, h, 394))
        local unit GPA =(LoadUnitHandle(HY, h, 395))
        local unit GQA =(LoadUnitHandle(HY, h, 396))
        local unit GSA =(LoadUnitHandle(HY, h, 397))
        local real x
        local real y
        local real a
        local real d =(LoadReal(HY, h, 138))
        local real sx = GetUnitX(whichUnit)
        local real sy = GetUnitY(whichUnit)
        local real VEI
        local integer count = GetTriggerEvalCount(t)
        local real IMX
        local group g
        local integer GTA = 0
        local real time = 2.25
        local real GUA
        local integer level = LoadInteger(HY, h, 5)
        if IsUnitDeath(GLA) == false then
            set GTA = GTA + 1
        endif
        if IsUnitDeath(GMA) == false then
            set GTA = GTA + 1
        endif
        if IsUnitDeath(GPA) == false then
            set GTA = GTA + 1
        endif
        if IsUnitDeath(GQA) == false then
            set GTA = GTA + 1
        endif
        if IsUnitDeath(GSA) == false then
            set GTA = GTA + 1
        endif
        if GTA == 5 then
            set time = 2.25
        elseif GTA == 4 then
            set time = 2.1
        elseif GTA == 3 then
            set time = 1.95
        elseif GTA == 2 then
            set time = 1.8
        elseif GTA == 1 then
            set time = 1.65
        endif
        set VEI =-1 * 360 * .02 / time
        set GUA =(LoadReal(HY, h, 137)) + VEI
        call SaveReal(HY, h, 137,((GUA)* 1.))
        set PUV = level
        set PQV = whichUnit
        if count == 50 then
            call ShowUnit(GMA, true)
            call SaveBoolean(HY, h, 512,(true))
            call UnitAddPermanentAbility(GMA,'Aloc')
        endif
        if count == 100  then
            call ShowUnit(GPA, true)
            call SaveBoolean(HY, h, 513,(true))
            call UnitAddPermanentAbility(GPA,'Aloc')
        endif
        if count == 150 then
            call ShowUnit(GQA, true)
            call SaveBoolean(HY, h, 514,(true))
            call UnitAddPermanentAbility(GQA,'Aloc')
        endif
        if count == 200 then
            call ShowUnit(GSA, true)
            call SaveBoolean(HY, h, 515,(true))
            call UnitAddPermanentAbility(GSA,'Aloc')
        endif
        if GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
            if GetSpellAbilityId()==SPIRITS_IN_ABILITY_ID then
                if (LoadBoolean(HY, h, 655)) then
                    call SaveBoolean(HY, h, 655,(false))
                    call SaveBoolean(HY, h, 656,(false))
                else
                    call SaveBoolean(HY, h, 655,(true))
                    call SaveBoolean(HY, h, 656,(false))
                endif
            elseif GetSpellAbilityId()==SPIRITS_OUT_ABILITY_ID then
                if (LoadBoolean(HY, h, 656)) then
                    call SaveBoolean(HY, h, 655,(false))
                    call SaveBoolean(HY, h, 656,(false))
                else
                    call SaveBoolean(HY, h, 655,(false))
                    call SaveBoolean(HY, h, 656,(true))
                endif
            endif
        endif
        if (LoadBoolean(HY, h, 655)) then
            set d = RMaxBJ(d -5, 100)
            call SaveReal(HY, h, 138,((d)* 1.))
        elseif (LoadBoolean(HY, h, 656)) then
            set d = RMinBJ(d + 5, 875)
            call SaveReal(HY, h, 138,((d)* 1.))
        endif
        if GetTriggerEventId() == EVENT_WIDGET_DEATH or count == 950 or(IsUnitDeath(GLA) and IsUnitDeath(GMA) and IsUnitDeath(GPA) and IsUnitDeath(GQA) and IsUnitDeath(GSA)) or(count > 1 and GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT and GetSpellAbilityId()=='A1T8') then
            if GetTriggerEventId() != EVENT_UNIT_SPELL_EFFECT then
                call UnitRemoveAbility(whichUnit,SPIRITS_IN_ABILITY_ID)
                call UnitRemoveAbility(whichUnit,SPIRITS_OUT_ABILITY_ID)
            endif
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            if IsUnitDeath(GLA) == false then
                call GHA(whichUnit, GLA)
            endif
            if IsUnitDeath(GMA) == false then
                call GHA(whichUnit, GMA)
            endif
            if IsUnitDeath(GPA) == false then
                call GHA(whichUnit, GPA)
            endif
            if IsUnitDeath(GQA) == false then
                call GHA(whichUnit, GQA)
            endif
            if IsUnitDeath(GSA) == false then
                call GHA(whichUnit, GSA)
            endif
        else
            set g = AllocationGroup(447)
            if IsUnitDeath(GLA) == false and(LoadBoolean(HY, h, 511)) then
                set IMX = 360 * 5 / 5.
                set a = IMX + GUA
                set x = CoordinateX50(sx + d * Cos(a * bj_DEGTORAD))
                set y = CoordinateY50(sy + d * Sin(a * bj_DEGTORAD))
                call SetUnitX(GLA, x)
                call SetUnitY(GLA, y)
                set TempUnit = whichUnit
                call GroupEnumUnitsInRange(g, x, y, 95, Condition(function D8X))
                if FirstOfGroup(g) != null then
                    call GHA(whichUnit, GLA)
                endif
                call GroupClear(g)
                set PTV = GLA
                set PWV = 1
                set PQV = whichUnit
                call GroupEnumUnitsInRange(g, x, y, 175, Condition(function DYX))
                call ForGroup(g, function GBA)
                call GroupClear(g)
            endif
            if IsUnitDeath(GMA) == false and(LoadBoolean(HY, h, 512)) then
                set IMX = 360 * 4 / 5.
                set a = IMX + GUA
                set x = CoordinateX50(sx + d * Cos(a * bj_DEGTORAD))
                set y = CoordinateY50(sy + d * Sin(a * bj_DEGTORAD))
                call SetUnitX(GMA, x)
                call SetUnitY(GMA, y)
                set TempUnit = whichUnit
                call GroupEnumUnitsInRange(g, x, y, 95, Condition(function D8X))
                if FirstOfGroup(g) != null then
                    call GHA(whichUnit, GMA)
                endif
                call GroupClear(g)
                set PTV = GMA
                set PWV = 2
                set PQV = whichUnit
                call GroupEnumUnitsInRange(g, x, y, 175, Condition(function DYX))
                call ForGroup(g, function GBA)
                call GroupClear(g)
            endif
            if IsUnitDeath(GPA) == false and(LoadBoolean(HY, h, 513)) then
                set IMX = 360 * 3 / 5.
                set a = IMX + GUA
                set x = CoordinateX50(sx + d * Cos(a * bj_DEGTORAD))
                set y = CoordinateY50(sy + d * Sin(a * bj_DEGTORAD))
                call SetUnitX(GPA, x)
                call SetUnitY(GPA, y)
                set TempUnit = whichUnit
                call GroupEnumUnitsInRange(g, x, y, 95, Condition(function D8X))
                if FirstOfGroup(g) != null then
                    call GHA(whichUnit, GPA)
                endif
                call GroupClear(g)
                set PTV = GPA
                set PWV = 3
                set PQV = whichUnit
                call GroupEnumUnitsInRange(g, x, y, 175, Condition(function DYX))
                call ForGroup(g, function GBA)
                call GroupClear(g)
            endif
            if IsUnitDeath(GQA) == false and(LoadBoolean(HY, h, 514)) then
                set IMX = 360 * 2 / 5.
                set a = IMX + GUA
                set x = CoordinateX50(sx + d * Cos(a * bj_DEGTORAD))
                set y = CoordinateY50(sy + d * Sin(a * bj_DEGTORAD))
                call SetUnitX(GQA, x)
                call SetUnitY(GQA, y)
                set TempUnit = whichUnit
                call GroupEnumUnitsInRange(g, x, y, 95, Condition(function D8X))
                if FirstOfGroup(g) != null then
                    call GHA(whichUnit, GQA)
                endif
                call GroupClear(g)
                set PTV = GQA
                set PWV = 4
                set PQV = whichUnit
                call GroupEnumUnitsInRange(g, x, y, 175, Condition(function DYX))
                call ForGroup(g, function GBA)
                call GroupClear(g)
            endif
            if IsUnitDeath(GSA) == false and(LoadBoolean(HY, h, 515)) then
                set IMX = 360 * 1 / 5.
                set a = IMX + GUA
                set x = CoordinateX50(sx + d * Cos(a * bj_DEGTORAD))
                set y = CoordinateY50(sy + d * Sin(a * bj_DEGTORAD))
                call SetUnitX(GSA, x)
                call SetUnitY(GSA, y)
                set TempUnit = whichUnit
                call GroupEnumUnitsInRange(g, x, y, 95, Condition(function D8X))
                if FirstOfGroup(g) != null then
                    call GHA(whichUnit, GSA)
                endif
                call GroupClear(g)
                set PTV = GSA
                set PWV = 5
                set PQV = whichUnit
                call GroupEnumUnitsInRange(g, x, y, 175, Condition(function DYX))
                call ForGroup(g, function GBA)
                call GroupClear(g)
            endif
            call DeallocateGroup(g)
        endif
        set t = null
        set whichUnit = null
        set GLA = null
        set GMA = null
        set GPA = null
        set GQA = null
        set GSA = null
        set g = null
        return false
    endfunction
    function SpiritsOnSpellEffect takes nothing returns nothing
        local unit whichUnit = GetTriggerUnit()
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit GLA
        local unit GMA
        local unit GPA
        local unit GQA
        local unit GSA
        local real x
        local real y
        set x = GetUnitX(whichUnit) + 250* Cos(bj_DEGTORAD * 360 * 5 / 5. *-1.)
        set y = GetUnitY(whichUnit) + 250* Sin(bj_DEGTORAD * 360 * 5 / 5. *-1.)
        set GLA = CreateUnit(GetOwningPlayer(whichUnit),'h0CJ', x, y, 360 * 5 / 5. *-1.)
        call UnitAddPermanentAbility(GLA,'Aloc')
        set x = GetUnitX(whichUnit) + 250* Cos(bj_DEGTORAD * 360 * 4 / 5. *-1.)
        set y = GetUnitY(whichUnit) + 250* Sin(bj_DEGTORAD * 360 * 4 / 5. *-1.)
        set GMA = CreateUnit(GetOwningPlayer(whichUnit),'h0CJ', x, y, 360 * 4 / 5. *-1.)
        call ShowUnit(GMA, false)
        call SetUnitInvulnerable(GMA, true)
        set x = GetUnitX(whichUnit) + 250* Cos(bj_DEGTORAD * 360 * 3 / 5. *-1.)
        set y = GetUnitY(whichUnit) + 250* Sin(bj_DEGTORAD * 360 * 3 / 5. *-1.)
        set GPA = CreateUnit(GetOwningPlayer(whichUnit),'h0CJ', x, y, 360 * 3 / 5. *-1.)
        call ShowUnit(GPA, false)
        call SetUnitInvulnerable(GMA, true)
        set x = GetUnitX(whichUnit) + 250* Cos(bj_DEGTORAD * 360 * 2 / 5. *-1.)
        set y = GetUnitY(whichUnit) + 250* Sin(bj_DEGTORAD * 360 * 2 / 5. *-1.)
        set GQA = CreateUnit(GetOwningPlayer(whichUnit),'h0CJ', x, y, 360 * 2 / 5. *-1.)
        call ShowUnit(GQA, false)
        call SetUnitInvulnerable(GQA, true)
        set x = GetUnitX(whichUnit) + 250* Cos(bj_DEGTORAD * 360 * 1 / 5. *-1.)
        set y = GetUnitY(whichUnit) + 250* Sin(bj_DEGTORAD * 360 * 1 / 5. *-1.)
        set GSA = CreateUnit(GetOwningPlayer(whichUnit),'h0CJ', x, y, 360 * 1 / 5. *-1.)
        call ShowUnit(GSA, false)
        call SetUnitInvulnerable(GSA, true)
        call SaveUnitHandle(HY, h, 2,(whichUnit))
        call SaveUnitHandle(HY, h, 393,(GLA))
        call SaveUnitHandle(HY, h, 394,(GMA))
        call SaveUnitHandle(HY, h, 395,(GPA))
        call SaveUnitHandle(HY, h, 396,(GQA))
        call SaveUnitHandle(HY, h, 397,(GSA))
        call SaveBoolean(HY, h, 511,(true))
        call SaveBoolean(HY, h, 512,(false))
        call SaveBoolean(HY, h, 513,(false))
        call SaveBoolean(HY, h, 514,(false))
        call SaveBoolean(HY, h, 515,(false))
        call SaveBoolean(HY, h, 655,(false))
        call SaveBoolean(HY, h, 656,(false))
        call SaveReal(HY, h, 138,( 150* 1.))
        call SaveInteger(HY, h, 5, GetUnitAbilityLevel(whichUnit,'A1T8'))
        call UnitAddPermanentAbility(whichUnit,SPIRITS_OUT_ABILITY_ID)
        call UnitAddPermanentAbility(whichUnit,SPIRITS_IN_ABILITY_ID)
        call TriggerRegisterTimerEvent(t, .02, true)
        call TriggerRegisterDeathEvent(t, whichUnit)
        call TriggerRegisterUnitEvent(t, whichUnit, EVENT_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(t, Condition(function GKA))
        set whichUnit = null
        set t = null
        set GLA = null
        set GMA = null
        set GPA = null
        set GQA = null
        set GSA = null
    endfunction
endscope
