scope Phoenix

    globals
        constant integer HERO_INDEX_PHOENIX = 51
    endglobals
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
