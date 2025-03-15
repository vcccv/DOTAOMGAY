
scope Ezalor

    globals
        constant integer HERO_INDEX_EZALOR = 16
    endglobals
    //***************************************************************************
    //*
    //*  启明
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_ILLUMINATE        = GetHeroSKillIndexBySlot(HERO_INDEX_EZALOR, 1)
        constant integer ILLUMINATE_ABILITY_ID         = 'A085'
        constant integer ILLUMINATE_RELEASE_ABILITY_ID = 'A121'
    endglobals

    private struct IlluminateSW extends array

        static method OnCollide takes Shockwave sw, unit targ returns boolean
            // 存活 
            if IsUnitAlive(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                if IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) then
                    call UnitDamageTargetEx(sw.owner, targ, 1, sw.damage)
                elseif sw.isUpgraded then
                    call UnitRegenLife(sw.owner, targ, sw.damage)
                endif
            endif
            return false
        endmethod
        
        static method OnPeriod takes Shockwave sw returns boolean
            local real scale = sw.GetModelScale()
            if scale < .4 then
                set scale = scale + .025
            elseif scale < 1.5 and scale > 0.4 then
                set scale = scale + .09
            else
                set scale = 1.5
            endif
            call sw.SetModelScale(scale)
            // 路上视野
            call CreateFogModifierTimedForPlayer(GetOwningPlayer(sw.owner), 2.5, sw.x, sw.y, 375)
            return false
        endmethod
        
        implement ShockwaveStruct
    endstruct
    /*
    function W1R takes nothing returns boolean
        local unit u = GetFilterUnit()
        local integer id = GetUnitTypeId(u)
        if UnitAlive(u) and IsUnitInGroup(u, Q7V) == false and not IsUnitWard(u) and IsUnitType(u, UNIT_TYPE_STRUCTURE) == false then
            call GroupAddUnit(Q7V, u)
            if IsUnitEnemy(u, Temp__Player) then
                call UnitDamageTargetEx(Temp__ArrayUnit[0], u, 1, XK[0])
            elseif X3 then
                call SetWidgetLife(u, GetWidgetLife(u)+ XK[0]* .75)
            endif
        endif
        set u = null
        return false
    endfunction
    function W2R takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer h = GetHandleId(t)
        local integer UYX = LoadInteger(ObjectHashTable, h, 0)
        local unit u = LoadUnitHandle(ObjectHashTable, h, 0)
        local real x
        local real y
        local real s = LoadReal(ObjectHashTable, h, StringHash("scale"))
        local unit source = LoadUnitHandle(ObjectHashTable, h, 1)
        local group enumGroup
        local unit  first
        local real  area = 400.
        if UYX == 1 then
            call DeallocateGroup(LoadGroupHandle(ObjectHashTable, h, 2))
            call DestroyTimerAndFlushHT_P(t)
            call KillUnit(u)
            set t = null
            set u = null
            return
        endif
        call SaveInteger(ObjectHashTable, h, 0, UYX -1)
        set x = GetWidgetX(u)+ LoadReal(ObjectHashTable, h, 3)
        set y = GetWidgetY(u)+ LoadReal(ObjectHashTable, h, 4)
        call SetUnitX(u, x)
        call SetUnitY(u, y)
        if s < .4 then
            set s = s + .025
        elseif s < 1.5 and s > .4 then
            set s = s + .09
        else
            set s = 1.5
        endif
        call SetUnitScale(u, s, s, s)
        call SaveReal(ObjectHashTable, h, StringHash("scale"), s)
        call CreateFogModifierTimedForPlayer(GetOwningPlayer(source), 2.5, x, y, 375)
        set Temp__Player = LoadPlayerHandle(ObjectHashTable, h, 2)
        set Temp__ArrayUnit[0] = source
        set XK[0] = LoadInteger(ObjectHashTable, h, 1)
        set Q7V = LoadGroupHandle(ObjectHashTable, h, 3)
        set X3 = IsUnitScepterUpgraded(source)
        call GroupEnumUnitsInRange(AK, x, y, 375, Condition(function W1R))

        set enumGroup = AllocationGroup(89)
        call GroupEnumUnitsInRange(enumGroup, x, y, area + MAX_UNIT_COLLISION, Condition(function W1R))


        call DeallocateGroup(enumGroup)

        set source = null
        set t = null
        set u = null
    endfunction
    */

    function IlluminateReleaseOnSpellEffect takes nothing returns nothing
        call SaveBoolean(ObjectHashTable, GetHandleId(GetTriggerUnit()),'A085', false)
    endfunction
    function IlluminateOnSpellCast takes nothing returns nothing
        local unit    whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local integer id        = GetUnitTypeId(whichUnit)
        if not IsUnitScepterUpgraded(whichUnit) then
            call SaveBoolean(ObjectHashTable, GetHandleId(whichUnit),'A085', false)
        endif
        set whichUnit = null
    endfunction

    function IlluminateOnUpdate takes nothing returns nothing
        local SimpleTick tick       = SimpleTick.GetExpired()

        local integer    maxCount   = SimpleTickTable[tick].integer['m']
        local integer    count      = tick.data - 1

        local unit       orbUnit    = SimpleTickTable[tick].unit['d']
        local real       scale
        local unit       whichUnit  = SimpleTickTable[tick].unit['s']
        local boolean    isUpgraded = SimpleTickTable[tick].boolean['u']
        local boolean    isRelease  = not LoadBoolean(ObjectHashTable, GetHandleId(whichUnit), 'A085')
        local real       sx
        local real       sy
        local Shockwave  sw
        local real       distance
        // 
        if count == 0 or ( isRelease ) then
            call KillUnit(orbUnit)

            set distance = 1550. + GetUnitCastRangeBonus(whichUnit)

            set sx = SimpleTickTable[tick].real['x']
            set sy = SimpleTickTable[tick].real['y']
            set sw = Shockwave.Create(whichUnit, sx, sy, SimpleTickTable[tick].real['a'], distance)
            call sw.SetModelScale(1.0)
            call sw.SetSpeed(900.)
            set sw.minRadius  = 400.
            set sw.maxRadius  = 400.
            set sw.model      = "Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl"
            set sw.isUpgraded = isUpgraded
            set sw.damage     = (maxCount-count)* 10
            call IlluminateSW.Launch(sw)
            
            call ToggleSkill.SetState(whichUnit, ILLUMINATE_ABILITY_ID, false)

            // 施法马甲
            call RemoveUnit(SimpleTickTable[tick].unit['u'])

            call tick.Destroy()
            
            set orbUnit   = null
            set whichUnit = null
            return
        endif
        set scale = 1 + (maxCount - count) * .1
        call SetUnitScale(orbUnit, scale, scale, scale)
        set tick.data = count

        set orbUnit   = null
        set whichUnit = null
    endfunction

    function IlluminateOnSpellEffect takes nothing returns nothing
        local unit    whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local player  p         = GetOwningPlayer(whichUnit)
        local real    startX    = GetWidgetX(whichUnit)
        local real    startY    = GetWidgetY(whichUnit)
        local real    angle     = Atan2(GetSpellTargetY()-startX, GetSpellTargetX()-startY)
        local real    orbX
        local real    orbY
        local integer maxCount

        local SimpleTick tick

        set maxCount = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId()) * 10 + 10

        set orbX = startX + MHUnit_GetData(whichUnit, UNIT_DATA_LAUNCH_X) * Cos(angle)
        set orbY = startY + MHUnit_GetData(whichUnit, UNIT_DATA_LAUNCH_Y) * Sin(angle)

        set tick = SimpleTick.Create(maxCount)
        call tick.Start(0.1, true, function IlluminateOnUpdate)

        set SimpleTickTable[tick].unit['s']    = whichUnit
        set SimpleTickTable[tick].unit['d']    = CreateUnit(Player(15), 'u00J', orbX, orbY, angle * bj_RADTODEG)
        set SimpleTickTable[tick].real['a']    = angle
        set SimpleTickTable[tick].real['x']    = orbX
        set SimpleTickTable[tick].real['y']    = orbY
        set SimpleTickTable[tick].integer['m'] = maxCount

        call ToggleSkill.SetState(whichUnit, ILLUMINATE_ABILITY_ID, true)

        call SaveBoolean(ObjectHashTable, GetHandleId(whichUnit), 'A085', true)
        if IsUnitScepterUpgraded(whichUnit) then
            set whichUnit = CreateUnit(p, 'h06Z', startX, startY, angle * bj_RADTODEG)
            call SetUnitX(whichUnit, startX)
            call SetUnitY(whichUnit, startY)
            call SetUnitAnimation(whichUnit, "spell")
            call QueueUnitAnimation(whichUnit, "spell")
            call SetUnitVertexColor(whichUnit, 255, 255, 255, 75)
            set SimpleTickTable[tick].boolean['u'] = true
            set SimpleTickTable[tick].unit['u'] = whichUnit
        endif
        
        set whichUnit = null
    endfunction

    //***************************************************************************
    //*
    //*  灵魂形态
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_SPIRIT_FORM               = GetHeroSKillIndexBySlot(HERO_INDEX_EZALOR, 4)
    endglobals

    function WZR takes nothing returns nothing
        local integer h = GetHandleId(GetExpiredTimer())
        local unit u = LoadUnitHandle(HY, h, 0)
        local unit d = LoadUnitHandle(HY, h, 1)
        if GetUnitTypeId(u)=='H06X' and UnitAlive(u) and GetWidgetLife(u)> 0 and IsUnitHidden(u) == false then
            if IsUnitHidden(d) then
                call ShowUnit(d, true)
                call UnitRemoveAbility(d, 'Aloc')
                call UnitAddAbility(d, 'Aloc')
            endif
            call SetUnitPosition(d, GetUnitX(u), GetUnitY(u))
        else
            if IsUnitHidden(d) == false then
                call ShowUnit(d, false)
            endif
        endif
        set u = null
        set d = null
    endfunction
    function W_R takes unit u returns nothing
        local unit d = CreateUnit(GetOwningPlayer(u),'hSPR', GetUnitX(u), GetUnitY(u), 0)
        local timer t = CreateTimer()
        call TimerStart(t, .25, true, function WZR)
        call SaveUnitHandle(HY, GetHandleId(t), 0, u)
        call SaveUnitHandle(HY, GetHandleId(t), 1, d)
        call SaveBoolean(ObjectHashTable, GetHandleId(u),'SPRT', true)
        set t = null
        set d = null
    endfunction
    function SpiritFormOnSpellEffect takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local integer level = GetUnitAbilityLevel(u,'QM01')
        local player p = GetOwningPlayer(u)
        local boolean W0R = GetUnitTypeId(u)!='H06X'
        call SetPlayerAbilityAvailable(p,SPIRIT_FORM_BLINDING_LIGHT_ABILITY_ID, W0R)
        call SetPlayerAbilityAvailable(p,SPIRIT_FORM_RECALL_ABILITY_ID, W0R)
        call SetUnitAbilityLevel(u,SPIRIT_FORM_BLINDING_LIGHT_ABILITY_ID, level)
        call SetUnitAbilityLevel(u,SPIRIT_FORM_RECALL_ABILITY_ID, level)
        if W0R then
            if LoadBoolean(ObjectHashTable, GetHandleId(u),'SPRT') != true then
                call W_R(u)
            endif
        endif
        set u = null
    endfunction

    //***************************************************************************
    //*
    //*  致盲之光
    //*
    //***************************************************************************
    globals
        constant integer SPIRIT_FORM_BLINDING_LIGHT_ABILITY_ID = 'A11X'
    endglobals
    function W6R takes nothing returns nothing
        local unit targetUnit = GetEnumUnit()
        local real x = GetUnitX(targetUnit)
        local real y = GetUnitY(targetUnit)
        local real a = Atan2(y -JJV, x -JHV)
        set x = CoordinateX50(x + 40 * Cos(a))
        set y = CoordinateY50(y + 40 * Sin(a))
        call KillTreeByCircle(x, y, 150)
        call SetUnitX(targetUnit, x)
        call SetUnitY(targetUnit, y)
        set targetUnit = null
    endfunction
    function W7R takes nothing returns nothing
        call UnitAddAbilityToTimed(GetEnumUnit(),'A3PZ', 1, 3 + JGV,'B09K')
    endfunction
    function W8R takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local player p =(LoadPlayerHandle(HY, h, 54))
        local real sx =(LoadReal(HY, h, 189))
        local real sy =(LoadReal(HY, h, 190))
        local integer CVX =(LoadInteger(HY, h, 59))
        local group g =(LoadGroupHandle(HY, h, 22))
        local integer count = GetTriggerEvalCount(t)
        set JHV = sx
        set JJV = sy
        call ForGroup(g, function W6R)
        if count == 10 then
            set JGV = CVX
            set TempPlayer = p
            call ForGroup(g, function W7R)
            call DeallocateGroup(g)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        endif
        set t = null
        set p = null
        set g = null
        return false
    endfunction
    function W9R takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local player p =(LoadPlayerHandle(HY, h, 54))
        local real sx =(LoadReal(HY, h, 189))
        local real sy =(LoadReal(HY, h, 190))
        local integer CVX =(LoadInteger(HY, h, 59))
        local group g =(LoadGroupHandle(HY, h, 22))
        call FlushChildHashtable(HY, h)
        call DestroyTrigger(t)
        set t = CreateTrigger()
        set h = GetHandleId(t)
        call TriggerRegisterTimerEvent(t, .04, true)
        call TriggerAddCondition(t, Condition(function W8R))
        call SavePlayerHandle(HY, h, 54,(p))
        call SaveReal(HY, h, 189,((sx)* 1.))
        call SaveReal(HY, h, 190,((sy)* 1.))
        call SaveGroupHandle(HY, h, 22,(g))
        call SaveInteger(HY, h, 59,(CVX))
        set t = null
        set p = null
        set g = null
        return false
    endfunction
    function SpiritFormBlindingLightOnSpellEffect takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local group g = AllocationGroup(210)
        local unit whichUnit = GetTriggerUnit()
        local real x = GetSpellTargetX()
        local real y = GetSpellTargetY()
        call KillUnit(CreateUnit(GetOwningPlayer(whichUnit),'h06P', x, y, 0))
        set TempUnit = whichUnit
        call GroupEnumUnitsInRange(g, x, y, 700, Condition(function DQX))
        call TriggerRegisterTimerEvent(t, .4, false)
        call TriggerAddCondition(t, Condition(function W9R))
        call SavePlayerHandle(HY, h, 54,(GetOwningPlayer(whichUnit)))
        call SaveReal(HY, h, 189,((x)* 1.))
        call SaveReal(HY, h, 190,((y)* 1.))
        call SaveGroupHandle(HY, h, 22,(g))
        call SaveInteger(HY, h, 59, GetUnitAbilityLevel(whichUnit, GetSpellAbilityId()))
        call EnableAttackEffectByTime(I, 8)
        set t = null
        set g = null
        set whichUnit = null
    endfunction
    //***************************************************************************
    //*
    //*  召回
    //*
    //***************************************************************************
    globals
        constant integer SPIRIT_FORM_RECALL_ABILITY_ID         = 'A10U'
    endglobals
    function WMR takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local unit targetUnit =(LoadUnitHandle(HY, h, 17))
        local real x1
        local real y1
        local real x2
        local real y2
        if GetTriggerEventId() == EVENT_WIDGET_DEATH or(GetTriggerEventId() == EVENT_UNIT_DAMAGED and GetEventDamage()> 2 and IsPlayerValid(GetOwningPlayer(GetEventDamageSource()))) then
            call DestroyEffect((LoadEffectHandle(HY, h, 175)))
            call DestroyEffect((LoadEffectHandle(HY, h, 176)))
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        elseif GetTriggerEventId() != EVENT_UNIT_DAMAGED and GetTriggerEventId() != EVENT_WIDGET_DEATH then
            set x1 = GetUnitX(whichUnit)
            set y1 = GetUnitY(whichUnit)
            set x2 = GetUnitX(targetUnit)
            set y2 = GetUnitY(targetUnit)
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl", x1, y1))
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl", x2, y2))
            call EPX(targetUnit, 4410, 1)
            call SetUnitPosition(targetUnit, GetUnitX(whichUnit), GetUnitY(whichUnit))
            call DestroyEffect(LoadEffectHandle(HY, h, 175))
            call DestroyEffect(LoadEffectHandle(HY, h, 176))
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        endif
        set t = null
        set whichUnit = null
        set targetUnit = null
        return false
    endfunction
    function WPR takes nothing returns nothing
        local unit targetUnit = GetEnumUnit()
        local real d = GetDistanceBetween(GetUnitX(targetUnit), GetUnitY(targetUnit), JDV, JFV)
        if d < JCV and LoadBoolean(HY, GetHandleId(GetOwningPlayer(targetUnit)), 139) == false then
            set JBV = targetUnit
            set JCV = d
        endif
        set targetUnit = null
    endfunction
    function SpiritFormReCallOnSpellEffect takes nothing returns nothing
        local unit targetUnit = GetSpellTargetUnit()
        local unit whichUnit = GetTriggerUnit()
        local trigger t
        local integer h
        local real N5O
        local group g = null
        local integer level = GetUnitAbilityLevel(whichUnit,SPIRIT_FORM_RECALL_ABILITY_ID)
        if targetUnit == null then
            set JBV = null
            set JCV = 999999
            set JDV = GetSpellTargetX()
            set JFV = GetSpellTargetY()
            set TempUnit = whichUnit
            set g = AllocationGroup(208)
            call GroupEnumUnitsInRange(g, 0, 0, 9999, Condition(function D4X))
            call GroupRemoveUnit(g, whichUnit)
            call ForGroup(g, function WPR)
            call DeallocateGroup(g)
            set targetUnit = JBV
            set g = null
        endif
        if targetUnit != null then
            set t = CreateTrigger()
            set h = GetHandleId(t)
            call TriggerRegisterDeathEvent(t, targetUnit)
            call TriggerRegisterDeathEvent(t, whichUnit)
            call TriggerRegisterUnitEvent(t, targetUnit, EVENT_UNIT_DAMAGED)
            call TriggerRegisterTimerEvent(t, 6 -level, false)
            call TriggerAddCondition(t, Condition(function WMR))
            call SaveUnitHandle(HY, h, 2,(whichUnit))
            call SaveUnitHandle(HY, h, 17,(targetUnit))
            call SaveEffectHandle(HY, h, 175,(AddSpecialEffectTarget("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTo.mdl", whichUnit, "origin")))
            call SaveEffectHandle(HY, h, 176,(AddSpecialEffectTarget("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTo.mdl", targetUnit, "origin")))
        endif
        set targetUnit = null
        set whichUnit = null
        set t = null
    endfunction


endscope
