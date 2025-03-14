
scope DrowRanger

    globals
        constant integer HERO_INDEX_DROW_RANGE = 35
    endglobals

    //***************************************************************************
    //*
    //*  阵风
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_GUST = GetHeroSKillIndexBySlot(HERO_INDEX_DROW_RANGE, 2)
        constant integer DROW_RANGER_GUST_BUFF_ID     = 'B07V'
    endglobals

    // 击退
    function PNI takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        //local unit whichUnit = LoadUnitHandle(HY, h, 2)
        local unit targetUnit = LoadUnitHandle(HY, h, 17)
        local real I3X = LoadReal(HY, h, 13)
        local real EOX = LoadReal(HY, h, 138)
        local real O3O = LoadInteger(HY, h, 0)
        local real PBI = EOX / O3O
        local real M8R
        local real M9R
        local integer c = GetTriggerEvalCount(t)
        
        if c > O3O or GetTriggerEventId() == EVENT_WIDGET_DEATH then
            call KillTreeByCircle(GetUnitX(targetUnit), GetUnitY(targetUnit), 100)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        else
            set M8R = CoordinateX50(GetUnitX(targetUnit) + PBI * Cos(I3X))
            set M9R = CoordinateY50(GetUnitY(targetUnit) + PBI * Sin(I3X))
            call SetUnitX(targetUnit, M8R)
            call SetUnitY(targetUnit, M9R)
        endif
        set t = null
        //set whichUnit = null
        set targetUnit = null
        return false
    endfunction
    private function GustRepel takes real startX, real startY, unit targetUnit, real x, real y, integer level returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local real I3X = Atan2(GetUnitY(targetUnit)-startY, GetUnitX(targetUnit)-startX)
        local real EOX = GetDistanceBetween(x, y, GetUnitX(targetUnit), GetUnitY(targetUnit))
        local real PDI = RMaxBJ(1, 350 *(1 -EOX / 900))
        //call SaveUnitHandle(HY, h, 2, whichUnit)
        call SaveUnitHandle(HY, h, 17, targetUnit)
        call SaveReal(HY, h, 13,(I3X * 1.))
        call SaveReal(HY, h, 138,(PDI * 1.))
        call SaveInteger(HY, h, 0, 25 + 5 * level)
        call TriggerRegisterTimerEvent(t, .02, true)
        call TriggerRegisterDeathEvent(t, targetUnit)
        call TriggerAddCondition(t, Condition(function PNI))
        set t = null
    endfunction

    private struct GustSW extends array

        static method OnCollide takes Shockwave sw, unit targ returns boolean
            // 敌对存活非魔免非无敌非守卫非建筑
            if IsUnitAlive(targ) and IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) and not IsUnitMagicImmune(targ) and not IsUnitInvulnerable(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                call UnitAddAreaBuffEx(sw.owner, targ, DROW_RANGER_GUST_BUFF_ID, sw.level, sw.duration, sw.herodur, false)
                call GustRepel(sw.startX, sw.startY, targ, sw.x, sw.y, sw.level)
            endif
            return false
        endmethod
        
        implement ShockwaveStruct
    endstruct

    // B07V
    function DrowSilenceBuffOnAdd takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        call UnitIncSilenceCount(whichUnit)
        set whichUnit = null
    endfunction
    function DrowSilenceBuffOnRemove takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        call UnitDecSilenceCount(whichUnit)
        set whichUnit = null
    endfunction

    function DrowRangerGustOnSpellEffect takes nothing returns nothing
        // local trigger  t = CreateTrigger()
        // local integer  h = GetHandleId(t)
        // local location l = GetSpellTargetLoc()
        // local unit u     = GetTriggerUnit()
        // local real x     = GetLocationX(l)
        // local real y     = GetLocationY(l)
        // local real I3X   = Atan2(y -GetUnitY(u), x -GetUnitX(u))
        // local unit d     = CreateUnit(GetOwningPlayer(u),'h02J', GetUnitX(u), GetUnitY(u), I3X * bj_RADTODEG)
        // local unit PKI   = CreateUnit(GetOwningPlayer(u),'e00E', GetUnitX(u), GetUnitY(u), 0)

        local unit      whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local real      sx        = GetUnitX(whichUnit)
        local real      sy        = GetUnitY(whichUnit)
        local real      tx        = GetSpellTargetX()
        local real      ty        = GetSpellTargetY()

        local integer   level    = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local Shockwave sw
        local real      distance = 900. + GetUnitCastRangeBonus(whichUnit)
        local real      angle

        set angle = RadianBetweenXY(sx, sy, tx, ty)
        set sw = Shockwave.CreateFromUnit(whichUnit, angle, distance)
        call sw.SetSpeed(2000.)
        set sw.minRadius = 250.
        set sw.maxRadius = 250.
        set sw.model     = "war3mapImported\\Gust.mdl"
        set sw.duration  = 2. + level
        set sw.herodur   = 2. + level
        set sw.level     = level
        call GustSW.Launch(sw)

        set whichUnit = null
        //call UnitAddAbility(PKI,'A0QB')
        //call SetUnitAbilityLevel(PKI,'A0QB', GetUnitAbilityLevel(u, GetSpellAbilityId()))
        //call TriggerRegisterTimerEvent(t, .02, true)
        //call TriggerAddCondition(t, Condition(function PGI))
        //call SaveUnitHandle(HY, h, 2, u)
        //call SaveUnitHandle(HY, h, 19, d)
        //call SetUnitUserData(d, GetUnitAbilityLevel(u, GetSpellAbilityId()))
        //call SaveUnitHandle(HY, h, 0, PKI)
        //call SaveReal(HY, h, 137,(I3X * 1.))
        //call SaveReal(HY, h, 64, GetUnitX(u))
        //call SaveReal(HY, h, 65, GetUnitY(u))
        //call SaveReal(HY, h, 66, GetUnitX(u) + 900 * Cos(I3X))
        //call SaveReal(HY, h, 67, GetUnitY(u) + 900 * Sin(I3X))
        //call SaveGroupHandle(HY, h, 22, AllocationGroup(345))
        //call RemoveLocation(l)
        //set t = null
        //set PKI = null
        //set l = null
        //set d = null
        //set u = null
    endfunction

    //***************************************************************************
    //*
    //*  射手天赋
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_MARKSMANSHIP = GetHeroSKillIndexBySlot(HERO_INDEX_DROW_RANGE, 4)
    endglobals

    function PLI takes nothing returns nothing
        local unit t = GetFilterUnit()
        local unit u = Temp__ArrayUnit[0]
        if OK and IsUnitType(t, UNIT_TYPE_HERO) and IsUnitEnemy(u, GetOwningPlayer(t)) and IsAliveNotStrucNotWard(GetFilterUnit()) then
            set OK = false
        endif
        set t = null
        set u = null
    endfunction
    function PMI takes nothing returns nothing
        local integer level
        local timer t = GetExpiredTimer()
        local integer h = GetHandleId(t)
        local integer id ='A0VC'
        local unit u = LoadUnitHandle(HY, h, 0)
        if GetHandleId(u)> 0 then
            set Temp__ArrayUnit[0] = u
            set OK = true
            if LoadBoolean(HY, h, 0) == false then
                if GetUnitAbilityLevel(u, id)< GetUnitAbilityLevel(u,'QF88') then
                    call SetUnitAbilityLevel(u, id, GetUnitAbilityLevel(u,'QF88'))
                endif
            endif
            call GroupEnumUnitsInRange(AK, GetWidgetX(u), GetWidgetY(u), 400 + 25, Condition(function PLI))
            if OK and not IsUnitBroken(u) then
                call SaveInteger(HY, h, 1, 0)
                if LoadBoolean(HY, h, 0) then
                    set level = LoadInteger(HY, h, 0)
                else
                    set level = GetUnitAbilityLevel(u,'QF88')
                endif
                if GetUnitAbilityLevel(u,'A2NX')!= level then
                    call UnitAddPermanentAbility(u,'A2NX')
                    call UnitAddPermanentAbility(u,'A3B6')
                    call SetUnitAbilityLevel(u,'A2NX', level)
                    if GetHeroMainAttributesType(u) != HERO_ATTRIBUTE_AGI then
                        call UnitAddPermanentAbility(u,'A33L')
                        call SetUnitAbilityLevel(u,'A33L', level)
                    endif
                endif
                set u = null
                set t = null
                return
            elseif OK == false then
                call SaveInteger(HY, h, 1, LoadInteger(HY, h, 1)+ 1)
                if IsUnitType(u, UNIT_TYPE_MELEE_ATTACKER) and LoadInteger(HY, h, 1)< 40 then
                    set u = null
                    set t = null
                    return
                endif
            endif
            call UnitRemoveAbility(u,'A2NX')
            call UnitRemoveAbility(u,'A33L')
            call UnitRemoveAbility(u,'A3B6')
        else
            call FlushChildHashtable(HY, h)
            call PauseTimer(t)
            call DestroyTimer(t)
        endif
        set u = null
        set t = null
    endfunction

    function PPI takes unit u, integer level returns nothing
        local timer t = CreateTimer()
        local integer pid = GetPlayerId(GetOwningPlayer(u))
        call SaveUnitHandle(HY, GetHandleId(t), 0, u)
        call TimerStart(t, .1, true, function PMI)
        call SaveInteger(HY, GetHandleId(t), 0, level)
        call SaveBoolean(HY, GetHandleId(t), 0, true)
        set t = null
    endfunction
    function I8R takes nothing returns nothing
        local unit PQI = LoadUnitHandle(OtherHashTable2,'ILLU', 0)
        local unit PSI = LoadUnitHandle(OtherHashTable2,'ILLU', 1)
        call RemoveSavedHandle(OtherHashTable2,'ILLU', 0)
        call RemoveSavedHandle(OtherHashTable2,'ILLU', 1)
        if GetUnitAbilityLevel(PSI,'A0VC')> 0 then
            call PPI(PQI, GetUnitAbilityLevel(PSI,'A0VC'))
        endif
        set PQI = null
        set PSI = null
    endfunction

    function Z1I takes unit u, unit t returns nothing
        local unit d
        local integer i
        if GetUnitAbilityLevel(u,'A061') == 1 then
            if GetUnitPseudoRandom(u, 'A061', 35) then	//金箍棒
                call TGA(u, t, 5)
            endif
        endif
        if GetItemOfTypeFromUnit(u, ItemRealId[I5V])!= null then	//散夜对剑
            if GetUnitPseudoRandom(u, ItemRealId[I5V], 16) then
                call ISO(t)
            endif
        elseif GetItemOfTypeFromUnit(u, ItemRealId[IPV])!= null or GetItemOfTypeFromUnit(u, ItemRealId[RLV])!= null or GetItemOfTypeFromUnit(u, ItemRealId[N1V])!= null then
            if GetUnitPseudoRandom(u, ItemRealId[IPV], 15) then	//散华和天堂之戟和白银之锋
                call IYO(t)
            endif
        endif
        if GetUnitAbilityLevel(u,'A3L2')> 0 then	//深渊之刃和小晕锤
            if IsUnitType(u, UNIT_TYPE_MELEE_ATTACKER) then
                set i = 25
            else
                set i = 10
            endif
            if LoadInteger(HY, GetHandleId(u),'bash')!= 1 and GetUnitPseudoRandom(u,'A3L2', i) then
                if GetUnitAbilityLevel(u,'A3TZ') == 1 then
                    //call YDWESetUnitAbilityState(u,'A3TZ', 1, 2.3)
                    call StartUnitAbilityCooldownAbsolute(u, 'A3TZ')
                endif
                call EPX(u,'bash', 2.3)
                call TGA(u, t, 4)
            endif
        endif
        if GetUnitAbilityLevel(u,'A0JH')> 0 or GetUnitAbilityLevel(u,'A0FJ')> 0 then
            call B1O(u, t)	//漩涡和雷神之锤
        endif
        if GetUnitAbilityLevel(u,'Afbt')> 0 and IsUnitMagicImmune(t) == false then
            call B4O(u, t)	//净魂之刃1-2级
        endif
        call B7R(u, t)	//黯灭
        if GetUnitAbilityLevel(u,'A2KV')> 0 then	//斯嘉蒂之眼
            call QZA(t, IsUnitType(u, UNIT_TYPE_MELEE_ATTACKER))
        endif
        if GetUnitAbilityLevel(u,'A1V7')> 0 then	//淬毒之珠
            call Q0A(t, u, IsUnitType(u, UNIT_TYPE_MELEE_ATTACKER))
        endif
        set d = null
    endfunction


    function MarksmanshipUpgradeMissileOnHit takes nothing returns nothing
        local unit target = MissileHitTargetUnit
        local integer h = GetHandleId(GetTriggeringTrigger())
        call UnitDamageTargetEx(LoadUnitHandle(HY, h,'xhts'), target, 2, LoadReal(HY, h,'xhts'))
        call Z1I(LoadUnitHandle(HY, h,'xhts'), target)
        set target = null
    endfunction

    function MarksmanshipUpgradeLaunch takes unit u, unit u2, unit target, real damage returns nothing
        local trigger t = LaunchMissileByUnitDummy(u2, target,'h30C', "MarksmanshipUpgradeMissileOnHit", 900, true)
        local integer h = GetHandleId(t)
        
        call SaveReal(HY, h,'xhts', damage)
        call SaveUnitHandle(HY, h,'xhts', u)
        set t = null
    endfunction

    function MarksmanshipEnumTarget takes nothing returns boolean
        return(IsUnitEnemy(TempUnit, GetOwningPlayer(GetFilterUnit())) and IsAliveNotStrucNotWard(GetFilterUnit()) and IsUnitVisibleToPlayer(GetFilterUnit(), GetOwningPlayer(TempUnit)) ) != null
    endfunction

    function MarksmanshipUpgradeOnEnum takes unit sourceUnit, unit targetUnit returns nothing
        local group   enumGroup
        local group   targGroup

        local unit    first 
        local real    damage
        local real    x
        local real    y
        local real    area
        local player  p 
        local integer i

        set damage    = (GetUnitState(sourceUnit, UNIT_STATE_ATTACK1_DAMAGE_BASE) + GetUnitState(sourceUnit, UNIT_STATE_ATTACK1_DAMAGE_BONUS) )* 0.5
        set enumGroup = AllocationGroup(79912)
        set targGroup = AllocationGroup(79913)

        set x    = GetUnitX(targetUnit)
        set y    = GetUnitY(targetUnit)
        set area = 450.
        set p    = GetOwningPlayer(sourceUnit)

        call GroupEnumUnitsInRange(enumGroup, x, y, area + MAX_UNIT_COLLISION, null)
        loop
            set first = FirstOfGroup(enumGroup)
            exitwhen first == null
            call GroupRemoveUnit(enumGroup, first)

            // 敌对 存活 非守卫 非信使 非建筑 非虚无 非无敌 可见
            if UnitAlive(first) and IsUnitInRangeXY(first, x, y, area) /*
                */ and IsUnitEnemy(first, p) and IsUnitVisibleToPlayer(first, p) /*
                */ and not IsUnitWard(first) and not IsUnitCourier(first) and not IsUnitStructure(first) /*
                */ and not IsUnitEthereal(first) and not IsUnitInvulnerable(first) then
                call GroupAddUnit(targGroup, first)
            endif

        endloop

        set i = 1
        loop
            set first = GroupPickRandomUnit(targGroup)
        exitwhen (first == null or i > 3)
            call GroupRemoveUnit(targGroup, first)
            if first != targetUnit then
                call MarksmanshipUpgradeLaunch(sourceUnit, targetUnit, first, damage)
                set i = i + 1
            endif
        endloop

        call DeallocateGroup(enumGroup)
        call DeallocateGroup(targGroup)
        set first = null
    endfunction

    function MarksmanshipUpgradeOnDamaged takes nothing returns nothing
        if not IsUnitBroken(DESource) and IsUnitScepterUpgraded(DESource) /*
            */ and GetUnitAbilityLevel(DESource, 'QF88') > 0 and IsUnitEnemy(DESource, GetOwningPlayer(DETarget)) then
            call MarksmanshipUpgradeOnEnum(DESource, DETarget)
        endif
    endfunction

    function L5E takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local timer t = CreateTimer()
        local integer id ='A0VC'
        call SaveUnitHandle(HY, GetHandleId(t), 0, u)
        call SaveBoolean(HY, GetHandleId(u), 4336821, false)
        call TimerStart(t, .1, true, function PMI)
        set t = null
        set u = null
    endfunction

    function MarksmanshipOnGetScepterUpgrade takes nothing returns nothing
        call BJDebugMsg("射手天赋神杖升级")
	    call RegisterUnitAttackFunc("MarksmanshipUpgradeOnDamaged", 0)
    endfunction
    function MarksmanshipOnLostScepterUpgrade takes nothing returns nothing
        call BJDebugMsg("射手天赋神杖升级 丢了")
    endfunction

endscope
