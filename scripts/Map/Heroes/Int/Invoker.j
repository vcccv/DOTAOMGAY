
scope Invoker

    //***************************************************************************
    //*
    //*  超震声波
    //*
    //***************************************************************************
    function InvokerOnAddDeafeningBlastBuff takes nothing returns nothing
        local unit       u    = MHEvent_GetUnit()
        call UnitAddDisableAttackCount(u)
        set u = null
    endfunction
    function InvokerOnRemoveDeafeningBlastBuff takes nothing returns nothing
        local unit       u    = MHEvent_GetUnit()
        call UnitSubDisableAttackCount(u)
        set u = null
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
                call CreateBuffByPolarity(targ, 'B033', 1 + thistype(sw).level * 0.5, false, BUFF_LEVEL3)
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
        local boolean   isUpgrade = GetSpellAbilityId() == 'A3K5'
        local integer   i
        local integer   max
        local UpgradeDeafeningBlast instance

        call SetAbilityAddAction('B033', "InvokerOnAddDeafeningBlastBuff")
        call SetAbilityRemoveAction('B033', "InvokerOnRemoveDeafeningBlastBuff")

        set tx = GetSpellTargetX()
        set ty = GetSpellTargetY()
        set angle = RadianBetweenXY(x, y, tx, ty)
        if x == tx and y == ty then
            set angle = GetUnitFacing(whichUnit) * bj_DEGTORAD
        else
            set angle = RadianBetweenXY(x, y, tx, ty)
        endif

        if not isUpgrade then
            set sw = Shockwave.CreateByDistance(whichUnit, x, y, angle, distance)
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
                set sw = Shockwave.CreateByDistance(whichUnit, x, y, angle + 30. * bj_DEGTORAD * i, distance)
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
