
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

    function IlluminateOnInitializer takes nothing returns nothing
        call ResgiterAbilityMethodSimple(ILLUMINATE_ABILITY_ID, "IlluminateAbilityOnAdd", "IlluminateAbilityOnRemove")
    endfunction
    function IlluminateAbilityOnAdd takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        if UnitAddPermanentAbility(whichUnit, ILLUMINATE_RELEASE_ABILITY_ID) then
            call UnitDisableAbility(whichUnit, ILLUMINATE_RELEASE_ABILITY_ID, true)
        endif
        set whichUnit = null
    endfunction
    function IlluminateAbilityOnRemove takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        call UnitRemoveAbility(whichUnit, ILLUMINATE_RELEASE_ABILITY_ID)
        set whichUnit = null
    endfunction

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

            call UnitShowAbility(whichUnit, ILLUMINATE_ABILITY_ID)
            call UnitDisableAbility(whichUnit, ILLUMINATE_RELEASE_ABILITY_ID, true)

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

        call UnitEnableAbility(whichUnit, ILLUMINATE_RELEASE_ABILITY_ID, true)
        call UnitHideAbility(whichUnit, ILLUMINATE_ABILITY_ID)
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

endscope
