
scope Earthshaker

    globals
        constant integer HERO_INDEX_EARTHSHAKER = 8
    endglobals
    //***************************************************************************
    //*
    //*  沟壑
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_FISSURE = GetHeroSKillIndexBySlot(HERO_INDEX_EARTHSHAKER, 1)
    endglobals
    function FissureOnSpellEffect takes nothing returns nothing
        local unit trigUnit = GetRealSpellUnit(GetTriggerUnit())
        local unit targetUnit = GetSpellTargetUnit()
        local real sx = GetUnitX(trigUnit)
        local real sy = GetUnitY(trigUnit)
        local real tx
        local real ty
        local real x
        local real y
        local real radin
        local group enumGroup = AllocationGroup(191)
        local group targGroup = AllocationGroup(192)
        local player p = GetOwningPlayer(trigUnit)
        local unit first
        local real range = 225.
        local real damage = GetUnitAbilityLevel(trigUnit, 'A0SK') * 50. + 60.
        local real duration = GetUnitAbilityLevel(trigUnit, 'A0SK') * .25 + .75
        local real maxDistance = 1320. + GetUnitCastRangeBonus(trigUnit)
        local real distance = 0.
    
        if targetUnit == null then
            set tx = GetSpellTargetX()
            set ty = GetSpellTargetY()
        else
            set tx = GetUnitX(targetUnit)
            set ty = GetUnitY(targetUnit)
        endif
    
        set radin = bj_DEGTORAD * AngleBetweenXY(sx, sy, tx, ty)
        loop
            exitwhen ( distance + 60. ) > maxDistance //i > 22 60*22=1320
    
            set distance = distance + 60.
            set x = CoordinateX50(sx + distance * Cos(radin))
            set y = CoordinateY50(sy + distance * Sin(radin))
            call GroupEnumUnitsInRange(enumGroup, x, y, range + MAX_UNIT_COLLISION, null)
    
            loop
                set first = FirstOfGroup(enumGroup)
                exitwhen first == null
                call GroupRemoveUnit(enumGroup, first)
    
                if IsUnitInRangeXY(first, x, y, range) and IsUnitEnemy(first, p) and IsAliveNotStrucNotWard(first) and IsNotAncientOrBear(first) then
                    call GroupAddUnit(targGroup, first)
                endif
    
            endloop
    
            call RemoveDestructableTimed(CreateDestructable('B000', x, y, GetRandomReal(0, 360), .5, GetRandomInt(0, 2)), 8)
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Volcano\\VolcanoDeath.mdl", x, y))
        endloop

        loop
            set first = FirstOfGroup(targGroup)
            exitwhen first == null
            call GroupRemoveUnit(targGroup, first)
    
            if UnitAlive(first) then
                call UnitDamageTargetEx(trigUnit, first, 1, damage)
                call CommonUnitAddStun(first, duration, false)
            endif
    
        endloop
    
        call DeallocateGroup(enumGroup)
        call DeallocateGroup(targGroup)
    
        set targetUnit = null
        set trigUnit = null
    endfunction

    //***************************************************************************
    //*
    //*  余震
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_AFTERSHOCK = GetHeroSKillIndexBySlot(HERO_INDEX_EARTHSHAKER, 3)
    endglobals

    function AftershockOnTriggerByUnit takes unit u, integer level returns nothing
        local real    duration
        local real    damageValue
        local real    x
        local real    y
        local real    area = 300.

        init_group_variable()

        if IsUnitBroken(u) then
            return
        endif

        set x = GetUnitX(u)
        set y = GetUnitY(u)

        set duration    = .3 + .3 * level
        set damageValue = 50 + 25 * level

        start_groupEnum(x, y, area)

        // 存活，敌对，非魔免，非无敌，非守卫，非建筑
        if IsUnitAlive(first) and IsUnitEnemy(u, GetOwningPlayer(first)) /*
            */ and not IsUnitMagicImmune(first) and not IsUnitInvulnerable(first) /*
            */ and not IsUnitWard(first) and not IsUnitStructure(first) then
            call CommonUnitAddStun(first, duration, false)
            call UnitDamageTargetEx(u, first, 1, damageValue)
        endif

        end_group_enum()

        call StartUnitAbilityCooldown(u, 'QP1G')
        call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA)* .96)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", GetUnitX(u), GetUnitY(u)))

        // 先踩地板 然后注册事件捕捉
        //set d = CreateUnit(GetOwningPlayer(u),'e00E', GetUnitX(u), GetUnitY(u), 0)
        //call UnitAddAbility(d,'A42H')
        //set CI = CreateTrigger()
        //set h = GetHandleId(CI)
        //call SDR(d)
        //call TriggerRegisterTimerEvent(CI, .02, false)
        //call TriggerAddCondition(CI, Condition(function SFR))
        //call SaveUnitHandle(HY, h, 0, d)
        //call SaveReal(HY, h, 0, duration)
        //call SaveReal(HY, h, 1, damageValue)
        //call SaveUnitHandle(HY, h, 1, u)
        //set t = null
        //call IssueImmediateOrderById(d, 852127)
        //set d = null
    endfunction

    function AftershockOnSpellEffectAS takes unit u, integer abilId returns nothing
        local integer abilLevel = GetUnitAbilityLevel(u,'A0DJ')
        if abilLevel > 0 then
            if OER(abilId) and(YDWEGetUnitAbilityState(u, 'QP1G', 1) == 0) then
                call AftershockOnTriggerByUnit(u, abilLevel)
            endif
        endif
    endfunction

    function AftershockOnSpellEffect takes nothing returns nothing
        call AftershockOnSpellEffectAS(GetTriggerUnit(), GetSpellAbilityId())
    endfunction
    function AftershockOnInitializer takes nothing returns nothing
        call RegisterSpellEffectFunc("AftershockOnSpellEffect")
    endfunction
    //***************************************************************************
    //*
    //*  回音击
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_ECHO_SLAM = GetHeroSKillIndexBySlot(HERO_INDEX_EARTHSHAKER, 4)
	    unit array H0V
    endglobals
    function SQR takes nothing returns nothing
        local real x = GetUnitX(GetEnumUnit())
        local real y = GetUnitY(GetEnumUnit())
        local integer id = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        call SetUnitX(H0V[id], x)
        call SetUnitY(H0V[id], y)
        call IssueImmediateOrderById(H0V[id], 852526)
    endfunction
    function SSR takes nothing returns nothing
        local real x = GetUnitX(GetEnumUnit())
        local real y = GetUnitY(GetEnumUnit())
        local integer id = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        if IsUnitType(GetEnumUnit(), UNIT_TYPE_HERO) or IsUnitIllusion(GetEnumUnit()) then
            call SetUnitX(H0V[id], x)
            call SetUnitY(H0V[id], y)
            call IssueImmediateOrderById(H0V[id], 852526)
        endif
    endfunction
    function STR takes nothing returns boolean
        return((not IsUnitWard(GetFilterUnit()) and IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) == false and IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(GetTriggerUnit())) and IsUnitDeath(GetFilterUnit()) == false))
    endfunction
    function SUR takes nothing returns nothing
        call UnitShareVision(GetEnumUnit(), GetOwningPlayer(UI), false)
    endfunction
    function SWR takes nothing returns nothing
        call UnitShareVision(GetEnumUnit(), GetOwningPlayer(UI), true)
    endfunction
    function SYR takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer h = GetHandleId(t)
        local group g = LoadGroupHandle(HY, h, 0)
        set UI = LoadUnitHandle(HY, h, 1)
        call ForGroup(g, function SUR)
        call DeallocateGroup(g)
        call DestroyTimerAndFlushHT_HY(t)
        set g = null
        set t = null
    endfunction
    function SZR takes group g, unit u returns nothing
        local group gg = AllocationGroup(193)
        local timer t = CreateTimer()
        call TimerStart(t, 0, false, function SYR)
        call GroupAddGroup(g, gg)
        call SaveGroupHandle(HY, GetHandleId(t), 0, gg)
        call SaveUnitHandle(HY, GetHandleId(t), 1, u)
        set gg = null
        set t = null
    endfunction
    function EchoSlamOnSpellEffect takes nothing returns nothing
        local unit whichUnit = GetTriggerUnit()
        local real x = GetUnitX(whichUnit)
        local real y = GetUnitY(whichUnit)
        local group g = AllocationGroup(194)
        local integer pid = GetPlayerId(GetOwningPlayer(whichUnit))
        local integer level = GetUnitAbilityLevel(whichUnit,'A0DH')
        call AftershockOnTriggerByUnit(whichUnit, 4)
        if level == 0 then
            set level = GetUnitAbilityLevel(whichUnit,'A1OB')
        endif
        set H0V[pid] = CreateUnit(GetOwningPlayer(whichUnit),'e00E', x, y, 0)
        call UnitAddAbility(H0V[pid],'A3L6')
        call SetUnitAbilityLevel(H0V[pid],'A3L6', level)
        call IssueImmediateOrderById(H0V[pid], 852526)
        call UnitRemoveAbility(H0V[pid],'A3L6')
        call SetUnitScale(H0V[pid], .25, .25, .25)
        call UnitAddPermanentAbility(H0V[pid],'A0DM')
        call SetUnitAbilityLevel(H0V[pid],'A0DM', level)
        set UI = whichUnit
        call GroupEnumUnitsInRange(g, x, y, 1200, Condition(function STR))
        call ForGroup(g, function SWR)
        call SZR(g, whichUnit)
        call GroupEnumUnitsInRange(g, x, y, 600, Condition(function STR))
        call ForGroup(g, function SQR)
        if GetUnitAbilityLevel(whichUnit,'A1OB')> 0 then
            call ForGroup(g, function SSR)
        endif
        call DeallocateGroup(g)
        set whichUnit = null
        set g = null
    endfunction

endscope
