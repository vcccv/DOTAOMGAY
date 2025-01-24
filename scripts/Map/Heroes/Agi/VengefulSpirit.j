
scope VengefulSpirit

    //***************************************************************************
    //*
    //*  恐怖波动
    //*
    //***************************************************************************
    function WaveOfTerrorArmorBuff takes unit dummyCaster, real x, real y, integer level returns nothing
        call SetUnitPosition(dummyCaster, x, y)
        call IssueImmediateOrderById(dummyCaster, 852588)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\HowlOfTerror\\HowlCaster.mdl", x, y))
    endfunction
    
    function WaveOfTerrorOnUpdate takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local unit dummyCaster =(LoadUnitHandle(HY, h, 19))
        local real a =(LoadReal(HY, h, 13))
        local real x =(LoadReal(HY, h, 6))
        local real y =(LoadReal(HY, h, 7))
        local integer level =(LoadInteger(HY, h, 5))
        local group targGroup =(LoadGroupHandle(HY, h, 133))
        local group g
        local real distance    = LoadReal(HY, h, 0)
        local real maxDistance = LoadReal(HY, h, 1)
        local player p = GetOwningPlayer(whichUnit)
        local unit first
        local real area   = 300.
        local real damage = 60 + 20 * level

        if distance > maxDistance then
            call DeallocateGroup(targGroup)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        else

            set g = AllocationGroup(292)
            call GroupEnumUnitsInRange(g, x, y, area + MAX_UNIT_COLLISION, null)
            loop
                set first = FirstOfGroup(g)
                exitwhen first == null
                call GroupRemoveUnit(g, first)

                if IsUnitInRangeXY(first, x, y, area) and IsAliveNotStrucNotWard(first) and IsUnitEnemy(first, p) and not IsUnitInGroup(first, targGroup) then
                    call GroupAddUnit(targGroup, first)
                    call UnitDamageTargetEx(whichUnit, first, 7, damage)
                endif
            endloop

            call DeallocateGroup(g)

            call WaveOfTerrorArmorBuff(dummyCaster, x, y, level)
            if ModuloInteger(GetTriggerEvalCount(t), 2) == 0 then
                call KillUnit(CreateUnit(GetOwningPlayer(whichUnit),'e02A', x, y, 0))
            endif
            set x = CoordinateX50(x + 200. * Cos(a * bj_DEGTORAD))
            set y = CoordinateY50(y + 200. * Sin(a * bj_DEGTORAD))
            call SaveReal(HY, h, 6,((x)* 1.))
            call SaveReal(HY, h, 7,((y)* 1.))
            
            set distance = distance + 200
            call SaveReal(HY, h, 0, distance)
        endif
        set t = null
        set whichUnit = null
        set dummyCaster = null
        set targGroup = null
        return false
    endfunction
    function WaveOfTerrorOnSpellEffect takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local real x1 = GetUnitX(whichUnit)
        local real y1 = GetUnitY(whichUnit)
        local real x2 = GetSpellTargetX()
        local real y2 = GetSpellTargetY()
        local real a = AngleBetweenXY(x1, y1, x2, y2)
        local integer level = GetUnitAbilityLevel(whichUnit,'A17O')
        local unit dummyCaster = CreateUnit(GetOwningPlayer(whichUnit),'e00E', x1, y1, 0)
        local real maxDistance = 1400. + GetUnitCastRangeBonus(whichUnit) + ( ModuloReal(GetUnitCastRangeBonus(whichUnit), 200.) )
        //call BJDebugMsg("我有余数啊：" + R2S( ModuloReal(GetUnitCastRangeBonus(whichUnit), 200.)))
        call UnitAddPermanentAbility(dummyCaster,'A0AP')
        call SetUnitAbilityLevel(dummyCaster,'A0AP', level)
        call SaveUnitHandle(HY, h, 2,(whichUnit))
        call SaveUnitHandle(HY, h, 19,(dummyCaster))
        call SaveInteger(HY, h, 5,(level))
        call SaveReal(HY, h, 6,((x1)* 1.))
        call SaveReal(HY, h, 7,((y1)* 1.))
        call SaveReal(HY, h, 13,((a)* 1.))
        call SaveReal(HY, h, 1, maxDistance)
        call SaveReal(HY, h, 0, 0)
        call SaveGroupHandle(HY, h, 133,(AllocationGroup(293)))
        call TriggerRegisterTimerEvent(t, .1, true)
        call TriggerAddCondition(t, Condition(function WaveOfTerrorOnUpdate))
        set t = null
        set whichUnit = null
        set dummyCaster = null
    endfunction

endscope
