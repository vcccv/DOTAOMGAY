scope Phoenix

    globals
        constant integer HERO_INDEX_PHOENIX = 51
    endglobals
    
    //***************************************************************************
    //*
    //*  凤凰俯冲
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_ICARUS_DIVE = GetHeroSKillIndexBySlot(HERO_INDEX_PHOENIX, 1)
    endglobals
    function C9A takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = LoadUnitHandle(HY, h, 2)
        local unit targetUnit = LoadUnitHandle(HY, h, 17)
        local integer level = LoadInteger(HY, h, 5)
        if GetTriggerEventId() == EVENT_WIDGET_DEATH or GetTriggerEvalCount(t) == 4 or IsUnitMagicImmune(whichUnit) then
            call WHV(targetUnit,'D011')
            call DestroyEffect((LoadEffectHandle(HY, h, 32)))
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        endif
        if GetTriggerEventId() != EVENT_WIDGET_DEATH then
            call UnitDamageTargetEx(whichUnit, targetUnit, 1, 10+(level -1)* 20)
        endif
        set t = null
        set targetUnit = null
        set whichUnit = null
        return false
    endfunction
    function DVA takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer h = GetHandleId(t)
        local unit u = LoadUnitHandle(HY, h, 0)
        local integer c = LoadInteger(HY, h, 0) + 1
        if IsUnitMagicImmune(u) or c > 20 or IsUnitDeath(u) then
            call UnitRemoveAbility(u,'A43V')
            call FlushChildHashtable(HY, h)
            call PauseTimer(t)
            call DestroyTimer(t)
        else
            call SaveInteger(HY, h, 0, c)
        endif
        set u = null
        set t = null
    endfunction
    function DEA takes unit u returns nothing
        local timer t = CreateTimer()
        call TimerStart(t, .1, true, function DVA)
        call UnitAddPermanentAbility(u,'A43V')
        call SaveUnitHandle(HY, GetHandleId(t), 0, u)
        set t = null
    endfunction
    function DXA takes unit u, unit whichUnit, integer level returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        call TriggerRegisterTimerEvent(t, 1, true)
        call TriggerRegisterDeathEvent(t, whichUnit)
        call TriggerAddCondition(t, Condition(function C9A))
        call UnitAddAbilityLevel1ToTimed(whichUnit,'C011','D011', 4)
        if IsUnitType(whichUnit, UNIT_TYPE_HERO) then
            call DEA(whichUnit)
        endif
        call SaveUnitHandle(HY, h, 2, u)
        call SaveUnitHandle(HY, h, 17, whichUnit)
        call SaveInteger(HY, h, 5,(level))
        call SaveEffectHandle(HY, h, 32,(AddSpecialEffectTarget("Environment\\LargeBuildingFire\\LargeBuildingFire1.mdl", whichUnit, "chest")))
        set t = null
    endfunction
    function DOA takes nothing returns boolean
        local unit u = GetEnumUnit()
        if IsUnitInGroup(u, PVV) == false and IsUnitMagicImmune(u) == false then
            call GroupAddUnit(PVV, u)
            call DestroyEffect(AddSpecialEffectTarget("war3mapImported\\FireBlast.mdx", u, "chest"))
            call DXA(PXV, u, PEV)
        endif
        set u = null
        return false
    endfunction
    function DRA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local integer count =(LoadInteger(HY, h, 34))
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local real sx =(LoadReal(HY, h, 189))
        local real sy =(LoadReal(HY, h, 190))
        local real tx =(LoadReal(HY, h, 47))
        local real ty =(LoadReal(HY, h, 48))
        local real a =(LoadReal(HY, h, 13))
        local real DIA =(1 -I2R(count)/ 50)* bj_PI
        local real DAA = 1400/ 2 * Cos(DIA)
        local real DNA = 500 / 2 * Sin(DIA)
        local real x = CoordinateX50(tx + DAA * Cos(a)-DNA * Sin(a))
        local real y = CoordinateY50(ty + DAA * Sin(a) + DNA * Cos(a))
        local group CNO =(LoadGroupHandle(HY, h, 133))
        local group g
        local integer level = LoadInteger(HY, h, 0)
        if GetTriggerEventId() == EVENT_WIDGET_DEATH or(GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT and GetSpellAbilityId()!='A1Z2' and count > 0) or count > 100  or C6X(whichUnit) then
            call KillTreeByCircle(x, y, 300)
            call SetUnitVertexColorEx(whichUnit,-1,-1,-1, 255)

            //if not ( GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT ) then
                call ToggleSkill.SetState(whichUnit, 'A1RJ', false)
            //endif
            
            call UnitDecNoPathingCount(whichUnit)
            
            call DeallocateGroup(CNO)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        else
            if ModuloInteger(count, 10) == 0 then
                call KillTreeByCircle(x, y, 200)
            endif
            call SaveInteger(HY, h, 34,(count + 1))
            if IsUnitType(whichUnit, UNIT_TYPE_HERO) then
                call SaveBoolean(OtherHashTable, GetHandleId(whichUnit), 99, true)
            endif
            call SetUnitX(whichUnit, x)
            call SetUnitY(whichUnit, y)
            call SetUnitFacing(whichUnit,(a + DIA -bj_PI / 2)* bj_RADTODEG)
            set g = AllocationGroup(432)
            set PVV = CNO
            set TempUnit = whichUnit
            set PXV = whichUnit
            set PEV = level
            call GroupEnumUnitsInRange(g, x, y, 325, Condition(function DQX))
            call ForGroup(g, function DOA)
            call DeallocateGroup(g)
        endif
        set t = null
        set whichUnit = null
        set g = null
        set CNO = null
        return false
    endfunction
    function IcarusDiveOnSpellEffect takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = GetTriggerUnit()
        local real sx = GetUnitX(whichUnit)
        local real sy = GetUnitY(whichUnit)
        local real a = AngleBetweenXY(sx, sy, GetSpellTargetX(), GetSpellTargetY())* bj_DEGTORAD
        local real tx = sx + 1400/ 2 * Cos(a)
        local real ty = sy + 1400/ 2 * Sin(a)
        local real L2O = GetWidgetLife(whichUnit)
        call SetWidgetLife(whichUnit, L2O -L2O * .15)
        call EPX(whichUnit, 4301, 2)
        call EPX(whichUnit, 4415, 2)
        call TriggerRegisterTimerEvent(t, .02, true)
        call TriggerRegisterDeathEvent(t, whichUnit)
        call TriggerRegisterUnitEvent(t, whichUnit, EVENT_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(t, Condition(function DRA))
        call SaveUnitHandle(HY, h, 2,(whichUnit))
        call SaveReal(HY, h, 189,((sx)* 1.))
        call SaveReal(HY, h, 190,((sy)* 1.))
        call SaveReal(HY, h, 47,((tx)* 1.))
        call SaveReal(HY, h, 48,((ty)* 1.))
        call SaveReal(HY, h, 13,((a)* 1.))
        call SaveInteger(HY, h, 0, GetUnitAbilityLevel(whichUnit, GetSpellAbilityId()))
        call SaveGroupHandle(HY, h, 133,(AllocationGroup(433)))

        call UnitIncNoPathingCount(whichUnit)

        call ToggleSkill.SetState(whichUnit, 'A1RJ', true)

        call SetUnitVertexColorEx(whichUnit,-1,-1,-1, 50)
        call UnitAddPermanentAbility(whichUnit,'A20N')
        
        set t = null
        set whichUnit = null
    endfunction

    //***************************************************************************
    //*
    //*  烈火精灵
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_FIRE_SPIRITS = GetHeroSKillIndexBySlot(HERO_INDEX_PHOENIX, 2)
    endglobals
    function D3A takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit u = LoadUnitHandle(HY, GetHandleId(t), 0)
        call ShowUnit(u, false)
        call FlushChildHashtable(HY, GetHandleId(t))
        call DestroyTimer(t)
        set u = null
        set t = null
    endfunction
    function D4A takes unit u, real d returns nothing
        local timer t = CreateTimer()
        call TimerStart(t, d, false, function D3A)
        call SaveUnitHandle(HY, GetHandleId(t), 0, u)
        set t = null
    endfunction
    function D5A takes unit whichUnit, unit missileDummy, real x, real y, integer level returns nothing
        set Temp__ArrayUnit[0] = whichUnit
        set TempInt = level
        call GroupEnumUnitsInRange(AK, x, y, 200, Condition(function D2A))
        call DestroyEffect(AddSpecialEffect("war3mapImported\\Firaga_2.mdx", x, y))
        call KillUnit(missileDummy)
        call D4A(missileDummy, 1.)
    endfunction
    function D6A takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local integer count = LoadInteger(HY, h, 34)
        local unit whichUnit = LoadUnitHandle(HY, h, 2)
        local unit targetUnit = LoadUnitHandle(HY, h, 17)
        local unit D7A = LoadUnitHandle(HY, h, 393)
        local real D8A = LoadReal(HY, h, 685)
        local real tx
        local real ty
        local real x
        local real y
        local real a
        local real r = 18
        local integer level = LoadInteger(HY, h, 0)
        if GetTriggerEventId() == EVENT_WIDGET_DEATH then
            set tx = GetUnitX(targetUnit)
            set ty = GetUnitY(targetUnit)
            call SaveReal(HY, h, 47, tx * 1.)
            call SaveReal(HY, h, 48, ty * 1.)
            call RemoveSavedHandle(HY, h, 17)
            call SaveUnitHandle(HY, h, 17, null)
        elseif targetUnit == null then
            set tx = LoadReal(HY, h, 47)
            set ty = LoadReal(HY, h, 48)
        else
            set tx = GetUnitX(targetUnit)
            set ty = GetUnitY(targetUnit)
        endif
        set a = AngleBetweenXY(GetUnitX(D7A), GetUnitY(D7A), tx, ty)
        call SetUnitFacing(D7A, a)
        set a = a * bj_DEGTORAD
        set x = GetWidgetX(D7A) + r * Cos(a)
        set y = GetWidgetY(D7A) + r * Sin(a)
        call SetUnitX(D7A, x)
        call SetUnitY(D7A, y)
        if GetDistanceBetween(x, y, tx, ty)< r * 2 then
            call D5A(whichUnit, D7A, x, y, level)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        endif
        set t = null
        set whichUnit = null
        set targetUnit = null
        set D7A = null
        return false
    endfunction
    function D9A takes unit whichUnit, unit D7A, unit targetUnit, real D8A, unit dummyCaster returns nothing
        local trigger t = null
        local integer h
        if whichUnit == targetUnit then
            call KillUnit(D7A)
            call ShowUnit(D7A, false)
            return
        endif
        set t = CreateTrigger()
        set h = GetHandleId(t)
        call SetUnitVertexColor(D7A, 255, 255, 255, 255)
        call TriggerRegisterTimerEvent(t, .02, true)
        call TriggerRegisterUnitEvent(t, whichUnit, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterDeathEvent(t, targetUnit)
        call TriggerAddCondition(t, Condition(function D6A))
        call SaveUnitHandle(HY, h, 2, whichUnit)
        call SaveUnitHandle(HY, h, 17, targetUnit)
        call SaveUnitHandle(HY, h, 393, D7A)
        call SaveReal(HY, h, 47, GetSpellTargetX()* 1.)
        call SaveReal(HY, h, 48, GetSpellTargetY()* 1.)
        call SaveReal(HY, h, 685, D8A * 1.)
        call SaveInteger(HY, h, 0, PI)
        set t = null
    endfunction
    function FVA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local integer count = LoadInteger(HY, h, 34)
        local unit whichUnit = LoadUnitHandle(HY, h, 2)
        local real sx = GetUnitX(whichUnit)
        local real sy = GetUnitY(whichUnit)
        local unit FEA = LoadUnitHandle(HY, h, 393)
        local unit FXA = LoadUnitHandle(HY, h, 394)
        local unit FOA = LoadUnitHandle(HY, h, 395)
        local unit FRA = LoadUnitHandle(HY, h, 396)
        local integer level = LoadInteger(HY, h, 0)
        local real a = GetUnitFacing(whichUnit)
        local real x
        local real y
        local group g
        local group g2
        local real VEI =-1 * 360 * .02 / 4
        local real a2
        local real IMX
        local real D8A = LoadReal(HY, h, 685)
        local real REI
        local unit dummyCaster = LoadUnitHandle(HY, h, 19)
        set PI = level
        if GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
            if GetSpellAbilityId()=='A1Z2' then
                if IsUnitDeath(FEA) == false then
                    call D9A(whichUnit, FEA, GetSpellTargetUnit(), D8A, dummyCaster)
                    call RemoveSavedHandle(HY, h, 393)
                elseif IsUnitDeath(FXA) == false then
                    call D9A(whichUnit, FXA, GetSpellTargetUnit(), D8A, dummyCaster)
                    call RemoveSavedHandle(HY, h, 394)
                elseif IsUnitDeath(FOA) == false then
                    call D9A(whichUnit, FOA, GetSpellTargetUnit(), D8A, dummyCaster)
                    call RemoveSavedHandle(HY, h, 395)
                elseif IsUnitDeath(FRA) == false then
                    call D9A(whichUnit, FRA, GetSpellTargetUnit(), D8A, dummyCaster)
                    call RemoveSavedHandle(HY, h, 396)
                    
                    call ToggleSkill.SetState(whichUnit, 'A1YX', false)
                    // call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A1Z2', false)
                    // if Rubick_AbilityFilter(whichUnit , 'A1YX') then
                    //     call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A1YX', true)
                    // endif

                    call FlushChildHashtable(HY, h)
                    call DestroyTrigger(t)
                endif
            elseif GetSpellAbilityId()=='A1RK' or GetSpellAbilityId()=='A43H' then
                if FEA != null and IsUnitDeath(FEA) == false then
                    call D9A(whichUnit, FEA, whichUnit, D8A, dummyCaster)
                endif
                if FXA != null and IsUnitDeath(FXA) == false then
                    call D9A(whichUnit, FXA, whichUnit, D8A, dummyCaster)
                endif
                if FOA != null and IsUnitDeath(FOA) == false then
                    call D9A(whichUnit, FOA, whichUnit, D8A, dummyCaster)
                endif
                if FRA != null and IsUnitDeath(FRA) == false then
                    call D9A(whichUnit, FRA, whichUnit, D8A, dummyCaster)
                endif

                call ToggleSkill.SetState(whichUnit, 'A1YX', false)
                //call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A1Z2', false)
                //if Rubick_AbilityFilter(whichUnit , 'A1YX') then
                //    call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A1YX', true)
                //endif
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
            endif
        else
            set count = count + 1
            call SaveInteger(HY, h, 34, count)
            if FEA != null and IsUnitDeath(FEA) == false then
                set IMX = 360 * 4 / 4.
                set a2 = IMX + VEI * count
                set x = CoordinateX50(sx + 200* Cos(a2 * bj_DEGTORAD))
                set y = CoordinateY50(sy + 200* Sin(a2 * bj_DEGTORAD))
                call SetUnitFacing(FEA, a2 -90)
                call SetUnitX(FEA, x)
                call SetUnitY(FEA, y)
            endif
            if FXA != null and IsUnitDeath(FXA) == false then
                set IMX = 360 * 3 / 4.
                set a2 = IMX + VEI * count
                set x = CoordinateX50(sx + 200* Cos(a2 * bj_DEGTORAD))
                set y = CoordinateY50(sy + 200* Sin(a2 * bj_DEGTORAD))
                call SetUnitFacing(FXA, a2 -90)
                call SetUnitX(FXA, x)
                call SetUnitY(FXA, y)
            endif
            if FOA != null and IsUnitDeath(FOA) == false then
                set IMX = 360 * 2 / 4.
                set a2 = IMX + VEI * count
                set x = CoordinateX50(sx + 200* Cos(a2 * bj_DEGTORAD))
                set y = CoordinateY50(sy + 200* Sin(a2 * bj_DEGTORAD))
                call SetUnitFacing(FOA, a2 -90)
                call SetUnitX(FOA, x)
                call SetUnitY(FOA, y)
            endif
            if FRA != null and IsUnitDeath(FRA) == false then
                set IMX = 360 * 1 / 4.
                set a2 = IMX + VEI * count
                set x = CoordinateX50(sx + 200* Cos(a2 * bj_DEGTORAD))
                set y = CoordinateY50(sy + 200* Sin(a2 * bj_DEGTORAD))
                call SetUnitFacing(FRA, a2 -90)
                call SetUnitX(FRA, x)
                call SetUnitY(FRA, y)
            endif
            if count > 800 or GetTriggerEventId() == EVENT_WIDGET_DEATH then
                if FEA != null and IsUnitDeath(FEA) == false then
                    call D9A(whichUnit, FEA, whichUnit, D8A, dummyCaster)
                endif
                if FXA != null and IsUnitDeath(FXA) == false then
                    call D9A(whichUnit, FXA, whichUnit, D8A, dummyCaster)
                endif
                if FOA != null and IsUnitDeath(FOA) == false then
                    call D9A(whichUnit, FOA, whichUnit, D8A, dummyCaster)
                endif
                if FRA != null and IsUnitDeath(FRA) == false then
                    call D9A(whichUnit, FRA, whichUnit, D8A, dummyCaster)
                endif

                call ToggleSkill.SetState(whichUnit, 'A1YX', false)
                // call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A1Z2', false)
                // if Rubick_AbilityFilter(whichUnit , 'A1YX') then
                //     call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A1YX', true)
                // endif
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
            else
                call SaveReal(HY, h, 685, RMinBJ(.25 + .75 *(I2R(count)/ 500.), 1))
                if count == 625 then
                    call BYX(XF, GetOwningPlayer(whichUnit))
                endif
                if count > 600 then
                    if ModuloInteger(count, 10) == 0 or ModuloInteger(count, 10) == 1 or ModuloInteger(count, 10) == 2 or ModuloInteger(count, 10) == 3 or ModuloInteger(count, 10) == 4 then
                        call SetUnitVertexColor(FEA, 255, 0, 0, 255)
                        call SetUnitVertexColor(FXA, 255, 0, 0, 255)
                        call SetUnitVertexColor(FOA, 255, 0, 0, 255)
                        call SetUnitVertexColor(FRA, 255, 0, 0, 255)
                    else
                        call SetUnitVertexColor(FEA, 255, 255, 255, 255)
                        call SetUnitVertexColor(FXA, 255, 255, 255, 255)
                        call SetUnitVertexColor(FOA, 255, 255, 255, 255)
                        call SetUnitVertexColor(FRA, 255, 255, 255, 255)
                    endif
                endif
            endif
        endif
        set t = null
        set whichUnit = null
        set FEA = null
        set FXA = null
        set FOA = null
        set FRA = null
        set g = null
        set g2 = null
        set dummyCaster = null
        return false
    endfunction
    function FireSpiritsOnSpellEffect takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = GetTriggerUnit()
        local real sx = GetUnitX(whichUnit)
        local real sy = GetUnitY(whichUnit)
        local real x
        local real y
        local unit FEA
        local unit FXA
        local unit FOA
        local unit FRA
        local real a = GetUnitFacing(whichUnit)
        local unit dummyCaster = CreateUnit(GetOwningPlayer(whichUnit),'e00E', sx, sy, 0)
        call SetWidgetLife(whichUnit, GetWidgetLife(whichUnit)-GetWidgetLife(whichUnit)* .15)
        // call UnitAddPermanentAbility(whichUnit,'A1Z2')
        // call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A1Z2', true)
        // call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A1YX', false)

        call ToggleSkill.SetState(whichUnit, 'A1YX', true)
        
        set x = GetUnitX(whichUnit) + 200* Cos(bj_DEGTORAD * 360 * 4 / 4. *-1.)
        set y = GetUnitY(whichUnit) + 200* Sin(bj_DEGTORAD * 360 * 4 / 4. *-1.)
        set FEA = CreateUnit(GetOwningPlayer(whichUnit),'h0CU', x, y, 360 * 4 / 4. *-1.)
        set x = GetUnitX(whichUnit) + 200* Cos(bj_DEGTORAD * 360 * 3 / 4. *-1.)
        set y = GetUnitY(whichUnit) + 200* Sin(bj_DEGTORAD * 360 * 3 / 4. *-1.)
        set FXA = CreateUnit(GetOwningPlayer(whichUnit),'h0CU', x, y, 360 * 3 / 4. *-1.)
        set x = GetUnitX(whichUnit) + 200* Cos(bj_DEGTORAD * 360 * 2 / 4. *-1.)
        set y = GetUnitY(whichUnit) + 200* Sin(bj_DEGTORAD * 360 * 2 / 4. *-1.)
        set FOA = CreateUnit(GetOwningPlayer(whichUnit),'h0CU', x, y, 360 * 2 / 4. *-1.)
        set x = GetUnitX(whichUnit) + 200* Cos(bj_DEGTORAD * 360 * 1 / 4. *-1.)
        set y = GetUnitY(whichUnit) + 200* Sin(bj_DEGTORAD * 360 * 1 / 4. *-1.)
        set FRA = CreateUnit(GetOwningPlayer(whichUnit),'h0CU', x, y, 360 * 1 / 4. *-1.)
        call SetUnitScale(FEA, 2.25, 2.25, 2.25)
        call SetUnitScale(FXA, 2.25, 2.25, 2.25)
        call SetUnitScale(FOA, 2.25, 2.25, 2.25)
        call SetUnitScale(FRA, 2.25, 2.25, 2.25)
        call TriggerRegisterTimerEvent(t, .02, true)
        call TriggerRegisterUnitEvent(t, whichUnit, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterDeathEvent(t, whichUnit)
        call TriggerAddCondition(t, Condition(function FVA))
        call SaveUnitHandle(HY, h, 2, whichUnit)
        call SaveUnitHandle(HY, h, 393, FEA)
        call SaveUnitHandle(HY, h, 394, FXA)
        call SaveUnitHandle(HY, h, 395, FOA)
        call SaveUnitHandle(HY, h, 396, FRA)
        call SaveUnitHandle(HY, h, 19, dummyCaster)
        call SaveInteger(HY, h, 0, GetUnitAbilityLevel(whichUnit, GetSpellAbilityId()))
        set t = null
        set whichUnit = null
        set FEA = null
        set FXA = null
        set FOA = null
        set FRA = null
        set dummyCaster = null
    endfunction
    //***************************************************************************
    //*
    //*  烈日炙烤
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_SUN_RAY = GetHeroSKillIndexBySlot(HERO_INDEX_PHOENIX, 3)
    endglobals

    function DMA takes nothing returns boolean
        local unit t = GetFilterUnit()
        if not IsUnitWard(t) and UnitAlive(t) and IsUnitType(t, UNIT_TYPE_STRUCTURE) == false and t != Temp__ArrayUnit[0]and(IsUnitType(t, UNIT_TYPE_ANCIENT) == false or DRX(t) != null) then
            call GroupAddUnit(LoadGroupHandle(ObjectHashTable, XK[0], 1), t)
        endif
        set t = null
        return false
    endfunction
    function DPA takes nothing returns nothing
        local unit t = GetEnumUnit()
        local real O3O =(Temp__ArrayReal[0] + Temp__ArrayReal[1]* GetUnitState(t, UNIT_STATE_MAX_LIFE))/ 5.
        if IsUnitAlly(Temp__ArrayUnit[0], GetOwningPlayer(t)) then
            call SetWidgetLife(t, GetWidgetLife(t) + O3O * .5)
        else
            call UnitDamageTargetEx(Temp__ArrayUnit[0], t, 3, O3O)
            call DestroyEffect(AddSpecialEffectTarget("war3mapImported\\FireRayTarget.mdx", t, "origin"))
            call CreateFogModifierTimedForPlayer(GetOwningPlayer(t), 2, GetUnitX(Temp__ArrayUnit[0]), GetUnitY(Temp__ArrayUnit[0]), 500)
        endif
        set t = null
    endfunction
    
    function DLA takes unit u, timer t, integer h returns nothing
        local player  p  = GetOwningPlayer(u)
        local integer uh = GetHandleId(u)

        call DestroyLightning(LoadLightningHandle(ObjectHashTable, h, 6))
        call DestroyLightning(LoadLightningHandle(ObjectHashTable, h, 5))
        call DestroyLightning(LoadLightningHandle(ObjectHashTable, h, 4))
        call DestroyLightning(LoadLightningHandle(ObjectHashTable, h, 3))
        call DestroyLightning(LoadLightningHandle(ObjectHashTable, h, 2))
        call DeallocateGroup(LoadGroupHandle(ObjectHashTable, h, 1))
        call SaveInteger(HY, uh, 4312, 2)

        call SaveBoolean(ObjectHashTable, uh, 'A1YY', false)
        call SaveBoolean(ObjectHashTable, uh, 'A205', false)
        
        call UnitRemoveAbility(u, 'A205')

        // if not ( GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT ) then
        //     call ToggleSkill.SetState(u, 'A1YY', false)
        // endif
        // 隐藏切换技能，变回正常情况
        call ToggleSkill.SetState(u, 'A1YY', false)

        call UnitDecDisableAttackCount(u)
        call UnitDecNoPathingCount(u)

        call SetUnitAnimation(u, "stand")
        call StopSound(HumanFireLargeSound, false, true)
        call DestroyTimerAndFlushHT_P(t)
        set p = null
    endfunction
    // 烈日炙烤
    function SunRayOnUpdate takes nothing returns nothing
        local group g = null
        local lightning l = null
        local timer t = GetExpiredTimer()
        local integer DSR
        local integer abilLevel
        local integer count = 2
        local integer h = GetHandleId(t)
        local integer UYX = LoadInteger(ObjectHashTable, h, 0)
        local unit u = LoadUnitHandle(ObjectHashTable, h, 0)
        local real IMX
        local real angle
        local real DUA
        local real DWA
        local real velX
        local real velY
        local real x2
        local real y2
        local real z2
        local real x1
        local real y1
        local real z1
        local real range
        set DSR = GetHandleId(u)
        if IsUnitDeath(u) or C5X(u) or IsUnitSilenced(u) or IsUnitPaused(u) or IsUnitCyclone(u) or UYX > 239 or LoadBoolean(ObjectHashTable, DSR, 'A1YY') then
            call DLA(u, t, h)
            set t = null
            set u = null
            return
        endif
        set x1 = GetWidgetX(u)
        set y1 = GetWidgetY(u)
        set DUA = GetWidgetLife(u)
        set angle = GetUnitFacing(u)* bj_DEGTORAD
        call SetWidgetLife(u, DUA -DUA * .0015)
        if LoadBoolean(ObjectHashTable, h, 0) then
            set angle = LoadReal(ObjectHashTable, h, 0)
            set DWA = angle -GetUnitFacing(u)* bj_DEGTORAD
            set IMX = LoadReal(ObjectHashTable, h, 1)
            set DUA = angle -IMX
            if DUA > 0 then
                set velX = bj_DEGTORAD / 2
            else
                set velX =-bj_DEGTORAD / 2
            endif
            if -180* bj_DEGTORAD > DUA or DUA > 180* bj_DEGTORAD then
                set velX =-velX
            endif
            set angle = IMX + velX
            call SaveReal(ObjectHashTable, h, 1, angle)
            if HaveSavedReal(ObjectHashTable, h, 2) then
                if 0 > DWA then
                    set DWA =-DWA
                endif
                if .02 > DWA then
                    call SaveBoolean(ObjectHashTable, h, 0, false)
                    call RemoveSavedReal(ObjectHashTable, h, 2)
                endif
            endif
            if LoadBoolean(ObjectHashTable, h, 0) then
                call SaveReal(ObjectHashTable, h, 2, DWA)
            endif
            if LoadInteger(HY, DSR, 4301) != 1 then
                call SetUnitFacing(u, angle * bj_RADTODEG)
            endif
        endif
        if LoadBoolean(ObjectHashTable, h, 1) then
            set x1 = CoordinateX50(x1 + 5 * Cos(angle))
            set y1 = CoordinateY50(y1 + 5 * Sin(angle))
            call KillTreeByCircle(x1, y1, 200)
            if IsUnitType(u, UNIT_TYPE_HERO) then
                call SaveBoolean(OtherHashTable, GetHandleId(u), 99, true)
            endif
            call SetUnitX(u, x1)
            call SetUnitY(u, y1)
        endif
        if UYX == 1 then
            call DisableTrigger(UnitEventMainTrig)
            call EXStopUnit(u)
            call EnableTrigger(UnitEventMainTrig)
        endif
        set velX = Cos(angle)
        set velY = Sin(angle)
        set angle =(GetUnitFacing(u) + 90)* bj_DEGTORAD
        set DUA = Cos(angle)
        set DWA = Sin(angle)
        set x1 = GetWidgetX(u) + 50 * velX
        set y1 = GetWidgetY(u) + 50 * velY
        call MoveLocation(Temp__Location, x1, y1)
        set z1 = GetUnitFlyHeight(u)
        if 50 > z1 then
            set z1 = 50
        endif
        set range = LoadReal(ObjectHashTable, h, 10)
        set z1 = z1 + GetLocationZ(Temp__Location)
        set x2 = x1 + range * velX
        set y2 = y1 + range * velY
        call MoveLocation(Temp__Location, x2, y2)
        set z2 = GetLocationZ(Temp__Location)
        loop
        exitwhen count == 7
            set angle = 30 *(count / 5)* Pow(-1, count)
            set IMX = 30 *((8 -count)/ 5)* Pow(-1, count)
            set l = LoadLightningHandle(ObjectHashTable, h, count)
            call MoveLightningEx(l, false, x1 + angle * DUA, y1 + angle * DWA, z1 + IMX, x2, y2, z2)
            set count = count + 1
        endloop
        call DestroyEffect(AddSpecialEffect("war3mapImported\\FireRayTarget.mdx", x2, y2))
        call SaveInteger(ObjectHashTable, h, 0, UYX + 1)
        if UYX / 10== UYX / 10. then
            set x2 = x1
            set y2 = y1
            set count = 0
            set g = LoadGroupHandle(ObjectHashTable, h, 1)
            set Temp__ArrayUnit[0] = u
            set XK[0] = h
            loop // 1300
            exitwhen count == LoadInteger(ObjectHashTable, h, 11)
                set x2 = x2 + 50 * velX
                set y2 = y2 + 50 * velY
            
                call GroupEnumUnitsInRange(AK, x2, y2, 100, Condition(function DMA))
                if count / 3 == count / 3.then
                    call CreateFogModifierTimedForPlayer(GetOwningPlayer(u), 2, x2, y2, 225)
                endif
                set count = count + 1
            endloop
            set abilLevel = LoadInteger(ObjectHashTable, h,-1)
            set angle = UYX / 239.
            set IMX = 8 * abilLevel + 8
            set Temp__ArrayReal[0] = IMX + IMX * angle
            set Temp__ArrayReal[1]=(abilLevel * 1.25 + angle *(abilLevel * 1.25))/ 100 
            call ForGroup(g, function DPA)
            call GroupClear(g)
        endif
        set g = null
        set u = null
        set t = null
        set l = null
    endfunction
    function SunRayOnSpellEffect takes nothing returns nothing
        local unit    u = GetTriggerUnit()
        local timer   t = CreateTimer()
        local integer count = 2
        local integer h     = GetHandleId(t)
        local integer uh   = GetHandleId(u)
        local real    range = 1300. + GetUnitCastRangeBonus(u)

        call UnitIncDisableAttackCount(u)
        call UnitIncNoPathingCount(u)
        call ToggleSkill.SetState(u, 'A1YY', true)

        call UnitAddPermanentAbility(u, 'A205')
        
        call SaveInteger(ObjectHashTable, uh, 'A1YY', h)
        call SaveBoolean(ObjectHashTable, uh, 'A1YY', false)
        call SaveUnitHandle(ObjectHashTable, h, 0, u)
        call SaveGroupHandle(ObjectHashTable, h, 1, AllocationGroup(435))
        call SaveBoolean(ObjectHashTable, h, 0, false)
        call SaveBoolean(ObjectHashTable, h, 1, false)
        call SaveInteger(ObjectHashTable, h,-1, GetUnitAbilityLevel(u, GetSpellAbilityId()))
        call SaveReal(ObjectHashTable, h, 10, range)
        call SaveInteger(ObjectHashTable, h, 11, R2I((range / 50)))

        call StartSound(HumanFireLargeSound)
        call SetSoundPosition(HumanFireLargeSound, GetWidgetX(u), GetWidgetY(u), 100)
        
        call SetUnitAnimationByIndex(u, LoadInteger(ObjectHashTable, GetUnitTypeId(u), 'A1P8'))

        loop
        exitwhen count == 7
            call SaveLightningHandle(ObjectHashTable, h, count, AddLightning("SRAY", false, 0, 0, 0, 0))
            set count = count + 1
        endloop

        call TimerStart(t, .025, true, function SunRayOnUpdate)
        set u = null
        set t = null
    endfunction
    function DQA takes unit u, integer abilId returns nothing
        if abilId =='A1Z3' or abilId =='A1RK' or abilId =='A43H' or abilId =='A27H' or abilId =='A30J' then
            call SaveBoolean(ObjectHashTable, GetHandleId(u), 'A1YY', true)
        endif
    endfunction
    function UQA takes nothing returns nothing
        call DQA(GetTriggerUnit(), GetSpellAbilityId())
    endfunction
    function SunRayOnInitializer takes nothing returns nothing
        call RegisterSpellEffectFunc("UQA")
    endfunction

endscope
