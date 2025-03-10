scope Windranger

    globals
        constant integer HERO_INDEX_WINDRANGER = 47
    endglobals
    //***************************************************************************
    //*
    //*  强力击
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_POWER_SHOT = GetHeroSKillIndexBySlot(HERO_INDEX_WINDRANGER, 2)
    endglobals
    function C9I takes nothing returns nothing
        if IsUnitInGroup(GetEnumUnit(), KQV) == false and GetUnitAbilityLevel(GetEnumUnit(),'Bcyc') == 0 then
            call UnitDamageTargetEx((KSV),(GetEnumUnit()), 1,(((KTV)* 1.))* Pow(.9,(KWV))* Pow(.99,(KUV)))
            call GroupAddUnit(KQV, GetEnumUnit())
            set KWV = KWV + 1
        endif
    endfunction
    function DVI takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit missileDummy =(LoadUnitHandle(HY, h, 45))
        local real tx =(LoadReal(HY, h, 47))
        local real ty =(LoadReal(HY, h, 48))
        local real a =(LoadReal(HY, h, 13))
        local real damage =(LoadReal(HY, h, 20))
        local integer killTreeCount =(LoadInteger(HY, h, 354))
        local integer damagingCount =(LoadInteger(HY, h, 355))
        local group D7R =(LoadGroupHandle(HY, h, 187))
        // ? 似乎不是匀速
        local real  vel = (60 * Pow(.9, damagingCount) * Pow(.99, killTreeCount))
        local real  x = CoordinateX50(GetUnitX(missileDummy) + vel * Cos(a))
        local real  y = CoordinateY50(GetUnitY(missileDummy) + vel * Sin(a))
        local group g = AllocationGroup(295)
        local real  d
        if GetTriggerEvalCount(t)> 2 then
            set d = 150
        else
            set d = 75
        endif
        call DestroyEffect(AddSpecialEffect("effects\\Tornado.mdx", x, y))
        set killTreeCount = killTreeCount + KillTreeByCircle(x, y, 75)
        call SaveInteger(HY, h, 354,(killTreeCount))
        set KQV = D7R
        set KSV = missileDummy
        set KTV = damage
        set KUV = killTreeCount
        set KWV = damagingCount
        set TempUnit = missileDummy
        call GroupEnumUnitsInRange(g, x, y, d, Condition(function DJX))
        call ForGroup(g, function C9I)
        call DeallocateGroup(g)
        call SaveInteger(HY, h, 355,(KWV))
        call SetUnitX(missileDummy, x)
        call SetUnitY(missileDummy, y)
        call SaveReal(HY, h, 100, LoadReal(HY, h, 100) + vel)
        if LoadReal(HY, h, 100) >= LoadReal(HY, h, 101) then
            call KillUnit(missileDummy)
            call DeallocateGroup(D7R)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        endif
        set t = null
        set missileDummy = null
        set D7R = null
        set g = null
        return false
    endfunction
    function PowerShotLaunch takes nothing returns nothing
        local unit whichUnit = GetTriggerUnit()
        local real x2 =(LoadReal(HY,(GetHandleId(whichUnit)), 356))
        local real y2 =(LoadReal(HY,(GetHandleId(whichUnit)), 357))
        local real DRI = RMinBJ(GetGameTime()-LoadReal(HY, GetHandleId(whichUnit), 358), 1.)
        local real a = Atan2(y2 -GetUnitY(whichUnit), x2 -GetUnitX(whichUnit))
        local trigger t
        local integer h
        local unit missileDummy
        local integer level = GetUnitAbilityLevel(whichUnit,'A12K')
        local real damage =(40 + 80 * level)*(DRI)
        local real dist = 2475. + GetUnitCastRangeBonus(whichUnit)
        set t = CreateTrigger()
        set h = GetHandleId(t)
        set missileDummy = CreateUnit(GetOwningPlayer(whichUnit),'h078', GetUnitX(whichUnit), GetUnitY(whichUnit), a * bj_RADTODEG)
        set x2 = GetUnitX(whichUnit) + 2475* Cos(a)
        set y2 = GetUnitY(whichUnit) + 2475* Sin(a)
        call SaveUnitHandle(HY, h, 45,(missileDummy))
        call SaveReal(HY, h, 47,((x2)* 1.))
        call SaveReal(HY, h, 48,((y2)* 1.))
        call SaveReal(HY, h, 13,((a)* 1.))
        call SaveReal(HY, h, 20,((damage)* 1.))

        call SaveReal(HY, h, 100, 0.)
        call SaveReal(HY, h, 101, dist)

        call SaveInteger(HY, h, 354, 0)
        call SaveInteger(HY, h, 355, 0)
        call SaveGroupHandle(HY, h, 187,(AllocationGroup(296)))
        call TriggerRegisterTimerEvent(t, .02, true)
        call TriggerAddCondition(t, Condition(function DVI))
        set whichUnit = null
        set t = null
        set missileDummy = null
    endfunction
    function DII takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit trigUnit =(LoadUnitHandle(HY, h, 14))
        call SetUnitTimeScale(trigUnit, 1)
        call FlushChildHashtable(HY, h)
        call DestroyTrigger(t)
        set t = null
        set trigUnit = null
        return false
    endfunction
    function DAI takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit trigUnit = GetTriggerUnit()
        local location l = GetSpellTargetLoc()
        local real x = GetLocationX(l)
        local real y = GetLocationY(l)
        call RemoveLocation(l)
        call SaveReal(HY,(GetHandleId(trigUnit)), 356,((x)* 1.))
        call SaveReal(HY,(GetHandleId(trigUnit)), 357,((y)* 1.))
        call SaveReal(HY,(GetHandleId(trigUnit)), 358, GetGameTime()-0.3)
        call SetUnitTimeScale(trigUnit, .75)
        call SaveUnitHandle(HY, h, 14,(trigUnit))
        call TriggerRegisterTimerEvent(t, .75, false)
        call TriggerRegisterDeathEvent(t, trigUnit)
        call TriggerAddCondition(t, Condition(function DII))
        set t = null
        set trigUnit = null
        set l = null
    endfunction
    function PowerShotOnSpellCast takes nothing returns nothing
        call SaveBoolean(HY, GetHandleId(GetTriggerUnit()), 360, false)
        call DAI()
    endfunction
    private function PowerShotOnEndCast takes nothing returns boolean
        if GetSpellAbilityId()=='A12K' then
            if (LoadBoolean(HY,(GetHandleId(GetTriggerUnit())), 360)) then
                call PowerShotLaunch()
            endif
        endif
        return false
    endfunction
    function PowerShotOnInitializer takes nothing returns nothing
        local trigger t = CreateTrigger()
        call TriggerRegisterAnyUnitEvent(t, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
        call TriggerAddCondition(t, Condition(function PowerShotOnEndCast))
        set t = null
    endfunction
    function PowerShotOnSpellEffect takes nothing returns nothing
        call SaveBoolean(HY, GetHandleId(GetTriggerUnit()), 360, true)
    endfunction

endscope
