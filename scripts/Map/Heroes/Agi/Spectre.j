
scope Spectre

    //***************************************************************************
    //*
    //*  幽鬼之刃
    //*
    //***************************************************************************
    function SpectralDagger_Init takes nothing returns nothing
        call CreateSound("Sounds\\Spectral Dagger.mp3", false, false, false, 10, 10, "DefaultEAXON")
        call AddAbilityIDToPreloadQueue('A0I2')
        call AddAbilityIDToPreloadQueue('A0HY')
    endfunction

    function SpectralPathCreaterOnUpdate takes nothing returns nothing
        local SimpleTick tick = SimpleTick.GetExpired()

        local real    sx
        local real    sy
        local real    tx
        local real    ty
        local unit    targetUnit
        local unit    pathUnit
        local integer level

        set targetUnit = SimpleTickTable[tick].unit['t']
        if not UnitAlive(targetUnit) then
            set targetUnit = null
            call tick.Destroy()
            return
        endif

        set level      = SimpleTickTable[tick].integer['l']
        set sx         = SimpleTickTable[tick].real['x']
        set sy         = SimpleTickTable[tick].real['y']
        set tx         = GetUnitX(targetUnit)
        set ty         = GetUnitY(targetUnit)

        if GetDistanceBetween(sx, sy, tx, ty) >= 30. then
            set pathUnit = CreateUnit(GetOwningPlayer(SimpleTickTable[tick].unit['s']),('h002'), tx, ty, 0)
            call SetUnitAbilityLevel(pathUnit,('A0I2'), level)
            call SetUnitAbilityLevel(pathUnit,('A0HY'), level)
            call UnitApplyTimedLife(pathUnit, 'BTLF', 7)
            set SimpleTickTable[tick].real['x'] = tx
            set SimpleTickTable[tick].real['y'] = ty
        endif

        set SimpleTickTable[tick].real['t'] = SimpleTickTable[tick].real['t'] + 0.2
        if SimpleTickTable[tick].real['t'] > 7.0 then
            call tick.Destroy()
        endif

        set targetUnit = null
        set pathUnit   = null
    endfunction

    function UnitAddSpectralPathCreater takes unit sourceUnit, unit targetUnit, integer level returns nothing
        local SimpleTick tick
        local sound      s

        set s = CreateSound("Sounds\\Spectral Dagger.mp3", false, true, true, 10, 10, "DefaultEAXON")
        call SetSoundPosition(s, GetUnitX(targetUnit), GetUnitY(targetUnit), 0)
        call SetSoundDistanceCutoff(s, 700)
        call StartSound(s)
        call KillSoundWhenDone(s)
        set s = null

        set tick = SimpleTick.CreateEx()
        call tick.Start(0.2, true, function SpectralPathCreaterOnUpdate)
        set SimpleTickTable[tick].real['x'] = GetUnitX(targetUnit)
        set SimpleTickTable[tick].real['y'] = GetUnitY(targetUnit)
        set SimpleTickTable[tick].unit['s'] = sourceUnit
        set SimpleTickTable[tick].unit['t'] = targetUnit
        set SimpleTickTable[tick].integer['l'] = level
    endfunction

    function SpectralDaggerOnTargetUpdate takes nothing returns nothing
        local SimpleTick tick        = SimpleTick.GetExpired()
        local group      g
        local group      targetGroup 

        local unit       whichUnit
        local unit       targetUnit
        local unit       daggerUnit
        local unit       pathUnit
        local integer    level

        local unit       first

        local real       tx 
        local real       ty 
        local real       sx 
        local real       sy 
        local real       angle
        local real       area        = 150.

        set targetGroup = SimpleTickTable[tick].group['G']
        set whichUnit   = SimpleTickTable[tick].unit['s']
        set targetUnit  = SimpleTickTable[tick].unit['t']
        set daggerUnit  = SimpleTickTable[tick].unit['m']
        set level       = SimpleTickTable[tick].integer['l']
        set tx          = GetUnitX(targetUnit)
        set ty          = GetUnitY(targetUnit)
        set sx          = GetUnitX(daggerUnit)
        set sy          = GetUnitY(daggerUnit)
        set angle       = Atan2(ty - sy, tx - sx)

        if SimpleTickTable[tick].boolean['B'] then
            set SimpleTickTable[tick].boolean['B'] = false
            set pathUnit = CreateUnit(GetOwningPlayer(whichUnit), 'h002', sx, sy, 0)
            call SetUnitAbilityLevel(pathUnit, 'A0I2', level)
            call SetUnitAbilityLevel(pathUnit, 'A0HY', level)
            call UnitApplyTimedLife(pathUnit, 'BTLF', 12)
        else
            set SimpleTickTable[tick].boolean['B'] = true
        endif

        set sx = CoordinateX50(sx + 30. * Cos(angle))
        set sy = CoordinateY50(sy + 30. * Sin(angle))
        call SetUnitX(daggerUnit, sx)
        call SetUnitY(daggerUnit, sy)
        call SetUnitFacing(daggerUnit, angle * bj_RADTODEG)

        set g = AllocationGroup(388)
        call GroupEnumUnitsInRange(g, sx, sy, area + MAX_UNIT_COLLISION, null)
        
        loop
            set first = FirstOfGroup(g)
            exitwhen first == null
            call GroupRemoveUnit(g, first)

            if UnitAlive(first) and IsUnitInRangeXY(first, sx, sy, area) /*
                */ and IsUnitEnemy(first, GetOwningPlayer(whichUnit)) and not IsUnitInGroup(first, targetGroup) /*
                */ and not IsUnitWard(first) and not IsUnitStructure(first) then
                call UnitDamageTargetEx(whichUnit, first, 1, 50. * level)
                call GroupAddUnit(targetGroup, first)
                if IsUnitHeroLevel(first) then
                    call UnitAddSpectralPathCreater(whichUnit, first, level)
                endif
            endif
        endloop
        call DeallocateGroup(g)
        set g = null

        if GetUnitDistanceEx(daggerUnit, targetUnit) < 30. then
            call KillUnit(daggerUnit)
            call DeallocateGroup(targetGroup)

            call tick.Destroy()
        endif

        set targetGroup = null
        set whichUnit   = null
        set targetUnit  = null
        set daggerUnit  = null
    endfunction
    function SpectralDaggerOnUpdate takes nothing returns nothing
        local SimpleTick tick        = SimpleTick.GetExpired()
        local group      g
        local group      targetGroup 

        local unit       whichUnit
        local unit       daggerUnit
        local unit       pathUnit
        local integer    level

        local unit       first

        local real       tx 
        local real       ty 
        local real       sx 
        local real       sy 
        local real       angle
        local real       maxDist
        local real       dist
        local real       area        = 125.

        set targetGroup = SimpleTickTable[tick].group['G']
        set whichUnit   = SimpleTickTable[tick].unit['s']
        set daggerUnit  = SimpleTickTable[tick].unit['m']

        set level       = SimpleTickTable[tick].integer['l']
        set maxDist     = SimpleTickTable[tick].real['m']
        
        set tx          = SimpleTickTable[tick].real['x']
        set ty          = SimpleTickTable[tick].real['y']
        set sx          = GetUnitX(daggerUnit)
        set sy          = GetUnitY(daggerUnit)
        set angle       = SimpleTickTable[tick].real['a']

        if SimpleTickTable[tick].boolean['B'] then
            set SimpleTickTable[tick].boolean['B'] = false
            set pathUnit = CreateUnit(GetOwningPlayer(whichUnit), 'h002', sx, sy, 0)
            call SetUnitAbilityLevel(pathUnit, 'A0I2', level)
            call SetUnitAbilityLevel(pathUnit, 'A0HY', level)
            call UnitApplyTimedLife(pathUnit, 'BTLF', 12)
        else
            set SimpleTickTable[tick].boolean['B'] = true
        endif

        set sx = CoordinateX50(sx + 30. * Cos(angle))
        set sy = CoordinateY50(sy + 30. * Sin(angle))
        call SetUnitX(daggerUnit, sx)
        call SetUnitY(daggerUnit, sy)
        call SetUnitFacing(daggerUnit, angle * bj_RADTODEG)

        set g = AllocationGroup(388)
        call GroupEnumUnitsInRange(g, sx, sy, area + MAX_UNIT_COLLISION, null)
        
        loop
            set first = FirstOfGroup(g)
            exitwhen first == null
            call GroupRemoveUnit(g, first)

            // 存活 范围内 敌对 非单位组内 非守卫 非建筑
            if UnitAlive(first) and IsUnitInRangeXY(first, sx, sy, area) /*
                */ and IsUnitEnemy(first, GetOwningPlayer(whichUnit)) and not IsUnitInGroup(first, targetGroup) /*
                */ and not IsUnitWard(first) and not IsUnitStructure(first) then
                call UnitDamageTargetEx(whichUnit, first, 1, 50. * level)
                call GroupAddUnit(targetGroup, first)
                if IsUnitHeroLevel(first) then
                    call UnitAddSpectralPathCreater(whichUnit, first, level)
                endif
            endif
        endloop
        call DeallocateGroup(g)
        set g = null

        set dist = SimpleTickTable[tick].real['D'] + 30.
        set SimpleTickTable[tick].real['D'] = dist
        if dist >= maxDist then
            call KillUnit(daggerUnit)
            call DeallocateGroup(targetGroup)

            call tick.Destroy()
        endif

        set targetGroup = null
        set whichUnit   = null
        set daggerUnit  = null
    endfunction

    function LaunchSpectralDagger takes unit source, integer level returns nothing
        local SimpleTick tick
        local unit       target
        local unit       dummy
        local group      g
        local real       sx    
        local real       sy    
        local real       angle
        local real       tx
        local real       ty
        local real       maxDist = 1800. + GetUnitCastRangeBonus(source)
    
        set sx     = CoordinateX50(GetUnitX(source))
        set sy     = CoordinateY50(GetUnitY(source))
        set dummy  = CreateUnit(GetOwningPlayer(source),('h003'), sx, sy, 0)
        set tick   = SimpleTick.CreateEx()
        set g      = AllocationGroup(390)

        set target = GetSpellTargetUnit()

        set SimpleTickTable[tick].group['G'] = g
        set SimpleTickTable[tick].integer['l'] = level
        set SimpleTickTable[tick].unit['s'] = source
        set SimpleTickTable[tick].unit['m'] = dummy
        
        if target != null then
            set SimpleTickTable[tick].unit['t'] = target
            call tick.Start(0.035, true, function SpectralDaggerOnTargetUpdate)
        else
            set tx = GetSpellTargetX()
            set ty = GetSpellTargetY()
            set angle = Atan2(ty -sy, tx -sx)
            call SetUnitFacing(dummy, angle * bj_RADTODEG)
            set tx = CoordinateX50(sx + 2000. * Cos(angle))
            set ty = CoordinateY50(sy + 2000. * Sin(angle))
            set SimpleTickTable[tick].real['x'] = tx
            set SimpleTickTable[tick].real['y'] = ty
            set SimpleTickTable[tick].real['a'] = angle
            set SimpleTickTable[tick].real['m'] = maxDist
            call tick.Start(0.035, true, function SpectralDaggerOnUpdate)
        endif
  
        set target = null
        set dummy  = null
        set g      = null
    endfunction
    function SpectralPathBuffOnAdd takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        call UnitIncNoPathingCount(whichUnit)
        set whichUnit = null
    endfunction
    function SpectralPathBuffOnRemove takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        call UnitDecNoPathingCount(whichUnit)
        call UnitModifyPostion(whichUnit)
        set whichUnit = null
    endfunction
    function SpectralDaggerOnSpellEffect takes nothing returns nothing
        local unit    source = GetRealSpellUnit(GetTriggerUnit())
        local integer level     = GetUnitAbilityLevel(source, GetSpellAbilityId())

        call RegisterAbilityAddMethod('B047', "SpectralPathBuffOnAdd")
        call RegisterAbilityRemoveMethod('B047', "SpectralPathBuffOnRemove")
        call LaunchSpectralDagger(source, level)
        set source = null
    endfunction

endscope
