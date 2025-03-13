
scope Invoker

    //***************************************************************************
    //*
    //*  幽灵漫步
    //*
    //***************************************************************************
    function MYI takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local unit u = LoadUnitHandle(HY, GetHandleId(t), 0)
        if UnitAlive(u) then
            call UnitRemoveAbility(u,'QFZZ')
            if GetUnitAbilityLevel(u,'QFZZ') == 0 then
                call FlushChildHashtable(HY, GetHandleId(t))
                call DestroyTrigger(t)
            endif
        endif
        set t = null
        set u = null
        return false
    endfunction
    function MZI takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit dummyCaster =(LoadUnitHandle(HY, h, 19))
        local unit trigUnit =(LoadUnitHandle(HY, h, 14))
        local trigger tt
        if GetUnitAbilityLevel(trigUnit,'B08X') == 0 then
            // call SetPlayerAbilityAvailableEx(GetOwningPlayer(trigUnit),'Z605', true)
            // call UnitRemoveAbility(trigUnit,'QFZZ')
            // if GetUnitAbilityLevel(trigUnit,'QFZZ')> 0 then
            //     set tt = CreateTrigger()
            //     call TriggerRegisterTimerEvent(tt, 1, true)
            //     call TriggerAddCondition(tt, Condition(function MYI))
            //     call SaveUnitHandle(HY, GetHandleId(tt), 0, trigUnit)
            //     set tt = null
            // endif
            call ToggleSkill.SetState(trigUnit, 'Z605', false)
            call KillUnit(dummyCaster)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        else
            call SetUnitX(dummyCaster, GetUnitX(trigUnit))
            call SetUnitY(dummyCaster, GetUnitY(trigUnit))
        endif
        set t = null
        set dummyCaster = null
        set trigUnit = null
        return false
    endfunction
    function GhostWalkOnSpellEffect takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit trigUnit = GetTriggerUnit()
        local unit dummyCaster = CreateUnit(GetOwningPlayer(trigUnit),'e01V', GetUnitX(trigUnit), GetUnitY(trigUnit), 0)
        local integer level = GetUnitAbilityLevel(trigUnit,'Z605')
        call UnitAddPermanentAbility(dummyCaster,'QH50')
        call SetUnitAbilityLevel(dummyCaster,'QH50', level)
        call TriggerRegisterTimerEvent(t, .05, true)
        call TriggerAddCondition(t, Condition(function MZI))
        call SaveUnitHandle(HY, h, 19,(dummyCaster))
        call SaveUnitHandle(HY, h, 14,(trigUnit))

        call ToggleSkill.SetState(trigUnit, 'Z605', true)
        // call SetPlayerAbilityAvailableEx(GetOwningPlayer(trigUnit),'Z605', false)
        // call UnitAddAbility(trigUnit,'QFZZ')
        // call SetUnitAbilityLevel(trigUnit,'QFZZ', 1)
        set t = null
        set trigUnit = null
        set dummyCaster = null
    endfunction

    //***************************************************************************
    //*
    //*  混沌陨石
    //*
    //***************************************************************************
    function MGI takes unit whichUnit, unit targetUnit, integer level returns nothing
        local unit dummyCaster = CreateUnit(GetOwningPlayer(targetUnit),'e00E', GetUnitX(targetUnit), GetUnitY(targetUnit), 0)
        local unit MHI = CreateUnit(GetOwningPlayer(whichUnit),'e00E', GetUnitX(targetUnit), GetUnitY(targetUnit), 0)
        call UnitAddAbility(dummyCaster,'A0XK')
        call SetUnitAbilityLevel(dummyCaster,'A0XK', level)
        call UnitAddAbility(dummyCaster,'A3G2')
        call SetUnitAbilityLevel(dummyCaster,'A3G2', level)
        call SaveUnitHandle(HY, GetHandleId(dummyCaster), 0, whichUnit)
        call FJO(targetUnit, dummyCaster)
        call IOX(MHI, targetUnit, 1, 60. + level * 60., .8 + .3 * level)
        set dummyCaster = null
        set MHI = null
    endfunction
    function MJI takes nothing returns nothing
        if IsUnitInGroup(GetEnumUnit(), DK) == false then
            call GroupAddUnit(DK, GetEnumUnit())
            call MGI(TempUnit, GetEnumUnit(), Q2)
        endif
    endfunction
    function MKI takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit dummyCaster =(LoadUnitHandle(HY, h, 19))
        local real x2 =(LoadReal(HY, h, 66))
        local real y2 =(LoadReal(HY, h, 67))
        local real a =(LoadReal(HY, h, 137))
        local integer level =(LoadInteger(HY, h, 5))
        local group g =(LoadGroupHandle(HY, h, 22))
        local real x = GetUnitX(dummyCaster) + 25 * Cos(a)
        local real y = GetUnitY(dummyCaster) + 25 * Sin(a)
        local group MLI = AllocationGroup(337)
        local real GIX = GetDistanceBetween(x, y, x2, y2)
        if GIX <= 30 then
            set x = x2
            set y = y2
        endif
        call SetUnitX(dummyCaster, CoordinateX50(x))
        call SetUnitY(dummyCaster, CoordinateX50(y))
        set TempUnit = dummyCaster
        set DK = g
        set Q2 = level
        call GroupEnumUnitsInRange(MLI, x, y, 200, Condition(function DHX))
        call ForGroup(MLI, function MJI)
        call DeallocateGroup(MLI)
        if GIX <= 30 or GetTriggerEvalCount(t)> LoadInteger(HY, h, 6) then
            call DeallocateGroup(g)
            call KillUnit(dummyCaster)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        endif
        set t = null
        set dummyCaster = null
        set g = null
        set MLI = null
        return false
    endfunction
    function TornadoOnSpellEffecy takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = GetTriggerUnit()
        local integer level = GetUnitAbilityLevel(whichUnit,'Z608')
        local real x = GetSpellTargetX()
        local real y = GetSpellTargetY()
        local real a = Atan2(y -GetUnitY(whichUnit), x -GetUnitX(whichUnit))
        local unit dummyCaster
        if GetUnitTypeId(whichUnit)=='e00E' then
            if GetRandomInt(0, 1) == 1 then
                set a = a + GetRandomReal(0, bj_PI / 4)
            else
                set a = a - GetRandomReal(0, bj_PI / 4)
            endif
        endif
        set x = GetUnitX(whichUnit)
        set y = GetUnitY(whichUnit)
        set dummyCaster = CreateUnit(GetOwningPlayer(whichUnit),'n01U', x, y, a * bj_RADTODEG)
        call TriggerRegisterTimerEvent(t, .025, true)
        call TriggerAddCondition(t, Condition(function MKI))
        call SaveUnitHandle(HY, h, 19,(dummyCaster))
        call SaveReal(HY, h, 66,(x +(750 + 500. * level + GetUnitCastRangeBonus(whichUnit))* Cos(a)))
        call SaveReal(HY, h, 67,(y +(750 + 500. * level + GetUnitCastRangeBonus(whichUnit))* Sin(a)))
        call SaveInteger(HY, h, 5,(level))
        call SaveInteger(HY, h, 6, R2I((750 + 500. * level + GetUnitCastRangeBonus(whichUnit))/ 25))
        call SaveReal(HY, h, 137,((a)* 1.))
        call SaveGroupHandle(HY, h, 22,(AllocationGroup(338)))
        set t = null
        set whichUnit = null
        set dummyCaster = null
    endfunction
    //***************************************************************************
    //*
    //*  混沌陨石
    //*
    //***************************************************************************
    function M3I takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local unit targetUnit = LoadUnitHandle(HY, h, 30)
        local real damage =(LoadReal(HY, h, 20))
        local effect FX =(LoadEffectHandle(HY, h, 32))
        local integer count = GetTriggerEvalCount(t)
        call UnitDamageTargetEx(whichUnit, targetUnit, 1, damage)
        if GetUnitAbilityLevel(targetUnit,'A42R') == 0 or count == 3 then
            call SaveInteger(ObjectHashTable, GetHandleId(targetUnit),'A42R', LoadInteger(ObjectHashTable, GetHandleId(targetUnit),'A42R')-1)
            if LoadInteger(ObjectHashTable, GetHandleId(targetUnit),'A42R')<= 0 then
                call UnitRemoveAbility(targetUnit,'A42R')
                call UnitRemoveAbility(targetUnit,'B0HI')
            endif
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            call DestroyEffect(FX)
        endif
        set t = null
        set whichUnit = null
        set targetUnit = null
        set FX = null
        return false
    endfunction
    function M4I takes unit whichUnit, unit targetUnit, real damage, boolean M5I returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        call SaveUnitHandle(HY, h, 2,(whichUnit))
        call SaveUnitHandle(HY, h, 30,((targetUnit)))
        call SaveReal(HY, h, 20,((damage)* 1.))
        call SaveBoolean(HY, h, 0, M5I)
        call SaveEffectHandle(HY, h, 32,(AddSpecialEffectTarget("Environment\\SmallBuildingFire\\SmallBuildingFire2.mdl", targetUnit, "chest")))
        call TriggerRegisterTimerEvent(t, 1, true)
        call UnitAddPermanentAbility(targetUnit,'A42R')
        call SaveInteger(ObjectHashTable, GetHandleId(targetUnit),'A42R', LoadInteger(ObjectHashTable, GetHandleId(targetUnit),'A42R') + 1)
        call TriggerAddCondition(t, Condition(function M3I))
        set t = null
    endfunction
    function M6I takes nothing returns nothing
        call M4I(TempUnit, GetEnumUnit(), TempReal1 / 5, X3)
        call UnitDamageTargetEx(TempUnit, GetEnumUnit(), 1, TempReal1)
    endfunction
    function M7I takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local real x =(LoadReal(HY, h, 6))
        local real y =(LoadReal(HY, h, 7))
        local real a =(LoadReal(HY, h, 137))
        local integer level =(LoadInteger(HY, h, 5))
        local integer count = GetTriggerEvalCount(t)-26
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local real targetX
        local real targetY
        local unit dummyCaster
        local group g
        if count == 1 then
            set dummyCaster = CreateUnit(GetOwningPlayer(whichUnit),'e01L', x, y, a * bj_RADTODEG)
            call SaveUnitHandle(HY, h, 19,(dummyCaster))
        elseif count > 1 then
            set dummyCaster =(LoadUnitHandle(HY, h, 19))
        endif
        if count > 0 then
            set targetX = CoordinateX50(GetUnitX(dummyCaster) + 15* Cos(a))
            set targetY = CoordinateY50(GetUnitY(dummyCaster) + 15* Sin(a))
            call SetUnitX(dummyCaster, targetX)
            call SetUnitY(dummyCaster, targetY)
            if (count > 1 and ModuloInteger(count, 10) == 0) or count == 1 then
                set g = AllocationGroup(341)
                set TempUnit = whichUnit
                set TempReal1 = 40 + 20 * level
                call GroupEnumUnitsInRange(g, targetX, targetY, 300, Condition(function DHX))
                set X3 = count > LoadInteger(HY, h, 7)
                call ForGroup(g, function M6I)
                call DeallocateGroup(g)
                call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl", targetX, targetY))
            endif
            if count > LoadInteger(HY, h, 7) then
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
                call KillUnit(dummyCaster)
            endif
        endif
        set t = null
        set g = null
        set dummyCaster = null
        set whichUnit = null
        return false
    endfunction
    function ChaosMeteorOnSpellEffect takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = GetTriggerUnit()
        local real x = GetSpellTargetX()
        local real y = GetSpellTargetY()
        local real a = Atan2(y -GetUnitY(whichUnit), x -GetUnitX(whichUnit))
        local unit M8I = CreateUnit(GetOwningPlayer(whichUnit),'e01K', x, y, a * bj_RADTODEG)
        local integer level = GetUnitAbilityLevel(whichUnit,'Z602')
        call SetUnitTimeScale(M8I, .58)
        call UnitApplyTimedLife(M8I,'BTLF', 1.75)
        call TriggerRegisterTimerEvent(t, .05, true)
        call TriggerAddCondition(t, Condition(function M7I))
        call SaveUnitHandle(HY, h, 2,(whichUnit))
        call SaveReal(HY, h, 6,((x)* 1.))
        call SaveReal(HY, h, 7,((y)* 1.))
        call SaveReal(HY, h, 137,((a)* 1.))
        call SaveInteger(HY, h, 5, level)
        call SaveInteger(HY, h, 7, R2I((350 + 200* level + GetUnitCastRangeBonus(whichUnit))/ 16.6))
        set t = null
        set whichUnit = null
        set M8I = null
    endfunction

    //***************************************************************************
    //*
    //*  灵动迅捷
    //*
    //***************************************************************************
    function OnSpellEffectAlacrity takes nothing returns nothing
        local unit 	  targetUnit = GetSpellTargetUnit()
        local integer level 	 = GetUnitAbilityLevel(GetTriggerUnit(),'Z607')
        call UnitAddAbilityToTimed(targetUnit, 'A0VJ', level, 13, 0)
        call UnitAddAbilityToTimed(targetUnit, 'A109', level, 13, 0)
        set targetUnit = null
    endfunction

    //***************************************************************************
    //*
    //*  超震声波
    //*
    //***************************************************************************
    function InvokerOnAddDeafeningBlastBuff takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        call UnitIncDisableAttackCount(whichUnit)
        set whichUnit = null
    endfunction
    function InvokerOnRemoveDeafeningBlastBuff takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        call UnitDecDisableAttackCount(whichUnit)
        set whichUnit = null
    endfunction
    function DeafeningOnBlastKnockback takes nothing returns boolean
        local trigger t       = GetTriggeringTrigger()
        local integer h       = GetHandleId(t)
        local unit whichUnit  = (LoadUnitHandle(HY, h, 2))
        local unit targetUnit = (LoadUnitHandle(HY, h, 17))
        local real angle      = (LoadReal(HY, h, 13))
        local real speed      = (LoadReal(HY, h, 193))
        local integer level   = (LoadInteger(HY, h, 5))
        local integer max     = level * 40 / 3
        local real    x
        local real    y
        local integer count   = GetTriggerEvalCount(t)
        if count > max / 3 then
            call SaveReal(HY, h, 193,((speed * .98)* 1.))
        endif
        if count > max or GetTriggerEventId() == EVENT_WIDGET_DEATH then
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        else
            set x = CoordinateX50(GetUnitX(targetUnit) + speed * Cos(angle))
            set y = CoordinateY50(GetUnitY(targetUnit) + speed * Sin(angle))
            call KillTreeByCircle(x, y, 150)
            call SetUnitX(targetUnit, MHUnit_ModifyPositionX(targetUnit, x, y))
            call SetUnitY(targetUnit, MHUnit_ModifyPositionY(targetUnit, x, y))
        endif
        set t = null
        set whichUnit = null
        set targetUnit = null
        return false
    endfunction

    // 超震声波 位移
    function UnitAddDeafeningBlastKnockback takes unit owner, unit targetUnit, real angle, integer level returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        call SaveUnitHandle(HY, h, 2,(owner))
        call SaveUnitHandle(HY, h, 17,(targetUnit))
        call SaveReal(HY, h, 13,((angle)* 1.))
        call SaveReal(HY, h, 193,(6 * 1.))
        call SaveInteger(HY, h, 5,(level))
        call TriggerRegisterTimerEvent(t, .03, true)
        call TriggerRegisterDeathEvent(t, targetUnit)
        call TriggerAddCondition(t, Condition(function DeafeningOnBlastKnockback))
        set t = null
    endfunction

    private struct UpgradeDeafeningBlast
        
        static TableArray table = 0
        static method Create takes nothing returns thistype
            if thistype.table == 0 then
                set thistype.table = TableArray[JASS_MAX_ARRAY_SIZE]
            endif
            return thistype.allocate()
        endmethod
        method Destroy takes nothing returns nothing
            call this.deallocate()
        endmethod

    endstruct

    private struct DeafeningBlast extends array
        
        boolean               last
        UpgradeDeafeningBlast instance
        real                  damage
        integer               level

        static method OnRemove takes Shockwave sw returns nothing
            if thistype(sw).last then
                call UpgradeDeafeningBlast.table[thistype(sw).instance].flush()
                call thistype(sw).instance.Destroy()
                set thistype(sw).last = false
            endif
        endmethod

        static method OnCollide takes Shockwave sw, unit targ returns boolean
            // 敌对存活非魔免非无敌非守卫非建筑
            if UnitAlive(targ) and IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) and not IsUnitMagicImmune(targ) and not IsUnitInvulnerable(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                if thistype(sw).instance != 0 then
                    if UpgradeDeafeningBlast.table[thistype(sw).instance].handle.has(GetHandleId(targ)) then
                        return false 
                    endif
                    set UpgradeDeafeningBlast.table[thistype(sw).instance].unit[GetHandleId(targ)] = targ
                endif
                // 'B033'
                // 击退
                //call UnitAddAbilityToTimed(targ, 'A2O7', 1, 1 + thistype(sw).level * 0.5, 'B033')
                call UnitAddBuffByPolarity(sw.owner, targ, 'B033', thistype(sw).level, 1 + thistype(sw).level * 0.5, false, BUFF_LEVEL3)
                call UnitAddDeafeningBlastKnockback(sw.owner, targ, RadianBetweenXY(sw.x, sw.y, GetUnitX(targ), GetUnitY(targ)), thistype(sw).level)
                call UnitDamageTargetEx(sw.owner, targ, 1, thistype(sw).damage)
            endif
            return false
        endmethod
        
        implement ShockwaveStruct

    endstruct
    
    function DeafeningBlastOnSpellEffect takes nothing returns nothing
        local unit      whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local real      x         = GetUnitX(whichUnit)
        local real      y         = GetUnitY(whichUnit)
        local real      tx
        local real      ty
        local real      angle
        local Shockwave sw

        local integer   level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real      distance  = 1000. + GetUnitCastRangeBonus(whichUnit)
        local real      damage    = 20. + 60. * level
        local boolean   isUpgraded = GetSpellAbilityId() == 'A3K5'
        local integer   i
        local integer   max
        local UpgradeDeafeningBlast instance

        call RegisterAbilityAddMethod('B033', "InvokerOnAddDeafeningBlastBuff")
        call RegisterAbilityRemoveMethod('B033', "InvokerOnRemoveDeafeningBlastBuff")

        set tx = GetSpellTargetX()
        set ty = GetSpellTargetY()
        set angle = RadianBetweenXY(x, y, tx, ty)
        if x == tx and y == ty then
            set angle = GetUnitFacing(whichUnit) * bj_DEGTORAD
        else
            set angle = RadianBetweenXY(x, y, tx, ty)
        endif

        if not isUpgraded then
            set sw = Shockwave.CreateFromUnit(whichUnit, angle, distance)
            call sw.SetSpeed(1100.)
            call sw.SetModelScale(4.)
            set DeafeningBlast(sw).instance = 0
            set sw.minRadius = 175.
            set sw.maxRadius = 225.
            set sw.height    = 200.
            set sw.model     = "Abilities\\Spells\\Items\\WandOfNeutralization\\NeutralizationMissile.mdl"
            set DeafeningBlast(sw).damage = damage
            set DeafeningBlast(sw).level = level
            call DeafeningBlast.Launch(sw)
        else
            set instance = UpgradeDeafeningBlast.Create()
            set i   = 0
            set max = 12
            loop
                set sw = Shockwave.CreateFromUnit(whichUnit, angle + 30. * bj_DEGTORAD * i, distance)
                call sw.SetSpeed(1100.)
                call sw.SetModelScale(4.)
                set DeafeningBlast(sw).instance = instance
                set DeafeningBlast(sw).last = i == max
                set sw.minRadius = 175.
                set sw.maxRadius = 225.
                set sw.height    = 200. 
                set sw.model     = "Abilities\\Spells\\Items\\WandOfNeutralization\\NeutralizationMissile.mdl"
                set DeafeningBlast(sw).damage = damage
                set DeafeningBlast(sw).level = level
                call DeafeningBlast.Launch(sw)
                
                set i = i + 1
            exitwhen i == max
            endloop

        endif

        set whichUnit = null
    endfunction

endscope
