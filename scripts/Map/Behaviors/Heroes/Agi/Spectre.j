
scope Spectre

    globals
        constant integer HERO_INDEX_SPECTRE = 85
    endglobals

    //***************************************************************************
    //*
    //*  幽鬼之刃
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_SPEACTRAL_DAGGER = GetHeroSKillIndexBySlot(HERO_INDEX_SPECTRE, 1)
    endglobals
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
        call UnitModifyPosition(whichUnit)
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

    //***************************************************************************
    //*
    //*  鬼影重重
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_HAUNT        = GetHeroSKillIndexBySlot(HERO_INDEX_SPECTRE, 4)
        constant integer HAUNT_REALITY_ABILITY_ID = 'A0HA'
    endglobals
    
    function OBA takes nothing returns nothing
        local unit targetUnit = GetEnumUnit()
        local unit trigUnit = GetTriggerUnit()
        local unit dummyCaster = CreateUnit(GetOwningPlayer(trigUnit),'e00E', GetUnitX(targetUnit), GetUnitY(targetUnit), 0)
        call SaveUnitHandle(HY,(GetHandleId(dummyCaster)), 387,(targetUnit))
        call UnitAddPermanentAbility(dummyCaster,('A0N9'))
        call SetUnitAbilityLevel(dummyCaster,('A0N9'), GetUnitAbilityLevel(trigUnit,'A0H9'))
        call IssueTargetOrderById(dummyCaster, 852274, trigUnit)
        set targetUnit = null
        set dummyCaster = null
        set trigUnit = null
    endfunction
    function OCA takes nothing returns boolean
        return((IsUnitDeath(GetFilterUnit()) == false and IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) and IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(GetTriggerUnit()))))
    endfunction
    function ODA takes nothing returns nothing
        local trigger trig = GetTriggeringTrigger()
        local integer h = GetHandleId(trig)
        local unit TJX =(LoadUnitHandle(HY, h, 386))
        local unit targetUnit =(LoadUnitHandle(HY, h, 387))
        local integer OFA =(LoadInteger(HY, h, 385))
        if GetTriggerEventId() != EVENT_WIDGET_DEATH and GetTriggerEventId() != EVENT_UNIT_ISSUED_TARGET_ORDER and GetTriggerEventId() != EVENT_UNIT_ISSUED_POINT_ORDER then
            set OFA = OFA + 1
            call SaveInteger(HY, h, 385,(OFA))
        endif
        if GetTriggerEventId() == EVENT_WIDGET_DEATH then
            call DisableTrigger(GetTriggeringTrigger())
            call FlushChildHashtable(HY,(GetHandleId(trig)))
            call SaveInteger(HY, h, 385,(OFA))
            if targetUnit == GetTriggerUnit() then
                call KillUnit(TJX)
            endif
            call DestroyTrigger(trig)
        elseif IsUnitPaused(TJX) == false then
            if OFA == 2 then
                call SetUnitVertexColor(TJX, 255, 255, 255, 255)
            endif
            if OFA > 1 then
                call DisableTrigger(trig)
                if GetUnitDistanceEx(TJX, targetUnit)< 1200 then
                    call IssueTargetOrderById(TJX, 851983, targetUnit)
                endif
                call EnableTrigger(trig)
            else
                call DisableTrigger(trig)
                if GetUnitDistanceEx(TJX, targetUnit)< 1200 then
                    call IssueTargetOrderById(TJX, 851986, targetUnit)
                endif
                call EnableTrigger(trig)
            endif
        endif
        set targetUnit = null
        set trig = null
        set TJX = null
    endfunction
    function OGA takes nothing returns boolean
        return GetUnitAbilityLevel(GetSummonedUnit(),'B06L')> 0
    endfunction
    function OHA takes nothing returns nothing
        local unit dummyCaster = GetSummoningUnit()
        local unit TJX = GetSummonedUnit()
        local unit targetUnit = LoadUnitHandle(HY, GetHandleId(dummyCaster), 387)
        local trigger t = CreateTrigger()
        call SaveUnitHandle(HY, GetHandleId(PlayerHeroes[GetPlayerId(GetOwningPlayer(dummyCaster))]), 7100 + GetHandleId(TJX), targetUnit)
        call SetUnitPathing(TJX, false)
        call SetUnitMoveSpeed(TJX, 400)
        call SetUnitX(TJX, GetUnitX(targetUnit))
        call SetUnitY(TJX, GetUnitY(targetUnit))
        call IssueTargetOrderById(TJX, 851986, targetUnit)
        call SetUnitVertexColor(TJX, 255, 255, 255, 50)
        call TriggerRegisterUnitEvent(t, TJX, EVENT_UNIT_ISSUED_TARGET_ORDER)
        call TriggerRegisterUnitEvent(t, TJX, EVENT_UNIT_ISSUED_POINT_ORDER)
        call TriggerRegisterDeathEvent(t, TJX)
        call TriggerRegisterDeathEvent(t, targetUnit)
        call TriggerRegisterTimerEvent(t, .5, true)
        call TriggerAddAction(t, function ODA)
        call DestroyEffect(AddSpecialEffect("units\\nightelf\\SpiritOfVengeance\\SpiritOfVengeance.mdl", GetUnitX(TJX), GetUnitY(TJX)))
        call SaveUnitHandle(HY, GetHandleId(t), 387, targetUnit)
        call SaveUnitHandle(HY, GetHandleId(t), 386, TJX)
        call SaveInteger(HY, GetHandleId(t), 385, 0)
        call FlushChildHashtable(HY, GetHandleId(dummyCaster))
        set dummyCaster = null
        set TJX = null
        set targetUnit = null
        set t = null
    endfunction
    function HauntOnSpellEffect takes nothing returns nothing
        local unit trigUnit = GetTriggerUnit()
        local group g = AllocationGroup(393)
        local sound s
        call UnitAddPermanentAbility(GetTriggerUnit(),'A0HA')
        call SetUnitPathing(trigUnit, false)
        call GroupEnumUnitsInRect(g, bj_mapInitialPlayableArea, Condition(function OCA))
        call ForGroup(g, function OBA)
        call SetUnitPathing(trigUnit, true)
        if FirstOfGroup(g) != null then
            set s = CreateSound("Abilities\\Spells\\Other\\ANsa\\SacrificeUnit.wav", false, false, false, 10, 10, "DefaultEAXON")
            call StartSound(s)
            call KillSoundWhenDone(s)
        endif
        call DeallocateGroup(g)
        set g = null
        set trigUnit = null
    endfunction

    function HauntOnLearn takes nothing returns nothing
        call UnitAddPermanentAbility(GetTriggerUnit(),'A0HA')
    endfunction

    function HauntOnInitialize takes nothing returns nothing
        local trigger t = CreateTrigger()
        call TriggerRegisterAnyUnitEvent(t, EVENT_PLAYER_UNIT_SUMMON)
        call TriggerAddCondition(t, Condition(function OGA))
        call TriggerAddAction(t, function OHA)
        call CreateSound("Abilities\\Spells\\Other\\ANsa\\SacrificeUnit.wav", false, false, false, 10, 10, "DefaultEAXON")
        call AddAbilityIDToPreloadQueue('A0N9')
        set t = null
    endfunction

endscope
