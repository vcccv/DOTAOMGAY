
scope CentaurWarchief

    //***************************************************************************
    //*
    //*  奔袭冲撞
    //*
    //***************************************************************************
    function OnStampedeUpdate takes nothing returns boolean
        local trigger trig      = GetTriggeringTrigger()
        local integer h         = GetHandleId(trig)
        local integer count     = LoadInteger(HY, h, 0)
        local unit    whichUnit = LoadUnitHandle(HY, h, 10)
        local group   allyGroup = LoadGroupHandle(HY, h, 0)
        local group   targGroup = LoadGroupHandle(HY, h, 1)
        local group   g
        local real    x
        local real    y
        local real    area      = 175.
        local unit    u
        local unit    first
        local real    damage
        local integer level     = LoadInteger(HY, h, 1)
        local integer size
        local integer i

        if GetTriggerEventId() == EVENT_WIDGET_DEATH then
            set u = GetTriggerUnit()
 
            //call UnitRemoveAbility(u, 'A2O4')
            call UnitRemoveAbility(u, 'B0GB')
            //call UnitRemoveAbility(u, 'A2O5')
            call UnitRemoveAbility(u, 'B0GH')
            call DestroyEffect(LoadEffectHandle(HY, h, GetHandleId(u)))
            //call DestroyEffect(LoadEffectHandle(HY, h, GetHandleId(u)))
            call GroupRemoveUnit(allyGroup, u)

            set whichUnit = null
            set targGroup = null
            set allyGroup = null
            set trig = null
            return false
        elseif count == 76 then
            // 清空了再销毁
            set i      = 1
            set size   = GroupGetSize(allyGroup)
            loop
                exitwhen i > size
                set u = GroupUnitAt(allyGroup, i)
                
                //call UnitRemoveAbility(u, 'A2O4')
                //call UnitRemoveAbility(u, 'B0GB')
                //call UnitRemoveAbility(u, 'A2O5')
                //call UnitRemoveAbility(u, 'B0GH')
                call DestroyEffect(LoadEffectHandle(HY, h, GetHandleId(u)))
                //call DestroyEffect(LoadEffectHandle(HY, h, GetHandleId(u)))
                set i = i + 1
            endloop
            set u = null

            call DeallocateGroup(allyGroup)
            call DeallocateGroup(targGroup)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(trig)

            set whichUnit = null
            set targGroup = null
            set allyGroup = null
            set trig = null
            return false
        endif

        set g      = AllocationGroup(45)
        set damage = LoadInteger(HY, h, 1) * GerHeroMainAttributesValue(LoadUnitHandle(HY, h, 10))
        
        set i      = 1
        set size   = GroupGetSize(allyGroup)
        loop
            exitwhen i > size
            set u = GroupUnitAt(allyGroup, i)
            if UnitAlive(u) then
                set x = GetUnitX(u)
                set y = GetUnitY(u)
                call GroupEnumUnitsInRange(g, x, y, area + MAX_UNIT_COLLISION, null)
                loop
                    set first = FirstOfGroup(g)
                    exitwhen first == null
                    call GroupRemoveUnit(g, first)
                    
                    if UnitAlive(first) and not IsUnitInGroup(first, targGroup)/*
                        */ and IsUnitInRangeXY(first, x, y, area) /*
                        */ and IsUnitEnemy(whichUnit, GetOwningPlayer(first)) and not IsUnitMagicImmune(first)/*
                        */ and not IsUnitWard(first) and not IsUnitType(first, UNIT_TYPE_STRUCTURE) then
                
                        call GroupAddUnit(targGroup, first)
                        call UnitAddAbilityLevel1ToTimed(first,'C017','D017', 1. + .5 * level)
                        call UnitDamageTargetEx(whichUnit, first, 1, damage)
                    endif
                endloop
            endif
            set i = i + 1
        endloop
        set u = null

        call DeallocateGroup(g)

        call SaveInteger(HY, h, 0, count + 1)
        call KillTreeByCircle(GetUnitX(whichUnit), GetUnitY(whichUnit), 150)
        set trig = null
        set whichUnit = null
        set targGroup = null
        return false
    endfunction

    function CentaurWarchiefStampedeBuffOnAdd takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        call UnitAddMoveSpeedBonusPercent(whichUnit, 1000)
        call UnitIncNoPathingCount(whichUnit)
        set whichUnit = null
    endfunction
    function CentaurWarchiefStampedeBuffOnRemove takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        call UnitSubMoveSpeedBonusPercent(whichUnit, 1000)
        call UnitDecNoPathingCount(whichUnit)
        set whichUnit = null
    endfunction

    // 还要重写，一个单位组解决而不是独立单位组独立tick
    function StampedeOnSpellEffect takes nothing returns nothing
        local unit    whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local integer level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local boolean isUpgraded = GetSpellAbilityId() == 'A384'

        local sound   s
        
        local group   g
        local player  p = GetOwningPlayer(whichUnit)
        local integer i 
        local unit    first
        local group   allyGroup
        local trigger trig
        local integer h
        
        local integer buffId = 'B0GB'

        // 死亡驱散
        if isUpgraded then
            set buffId = 'B0GH'
        endif
        set trig = CreateTrigger()
        set h    = GetHandleId(trig)

        set s = CreateSound("abilities\\Spells\\Other\\Stampede\\StampedeCaster1.wav", false, false, false, 10, 10, "DefaultEAXON")
        call StartSound(s)
        call KillSoundWhenDone(s)
        set s = null

        call RegisterAbilityAddMethod('B0GB', "CentaurWarchiefStampedeBuffOnAdd")
        call RegisterAbilityRemoveMethod('B0GB', "CentaurWarchiefStampedeBuffOnRemove")
        call RegisterAbilityAddMethod('B0GH', "CentaurWarchiefStampedeBuffOnAdd")
        call RegisterAbilityRemoveMethod('B0GH', "CentaurWarchiefStampedeBuffOnRemove")

        set g = AllocationGroup(96)
        set allyGroup= AllocationGroup(97)
        set i = 0
        loop
            
            if IsPlayerAlly(p, Player(i)) and IsPlayerUser(Player(i)) then
                
                call GroupEnumUnitsOfPlayer(g, Player(i), null)
                loop
                    set first = FirstOfGroup(g)
                    exitwhen first == null
                    call GroupRemoveUnit(g, first)

                    if not IsUnitDummy(first) and UnitAlive(first) and not IsUnitWard(first) and not IsUnitCourier(first) and not IsUnitType(first, UNIT_TYPE_STRUCTURE) then
                        //
                        call UnitAddBuffByPolarity(whichUnit, first, buffId, level, 3.75, true, BUFF_LEVEL3)
                        call TriggerRegisterDeathEvent(trig, first)
                        call GroupAddUnit(allyGroup, first)

                        call SaveEffectHandle(HY, h, GetHandleId(first), AddSpecialEffectTarget("war3mapImported\\SandBreathDamageSmall.mdx", first, GetHeroFootAttachPointName(first)))
                        //call SaveEffectHandle(HY, h, GetHandleId(first), AddSpecialEffectTarget("war3mapImported\\SandBreathDamageSmall.mdx", first, GetHeroFootAttachPointName(first)))
                    endif
                    
                endloop

            endif

            set i = i + 1
            exitwhen i == bj_MAX_PLAYERS
        endloop

        call TriggerAddCondition(trig, Condition(function OnStampedeUpdate))
        call TriggerRegisterTimerEvent(trig, .05, true)

        call SaveUnitHandle(HY, h, 10, whichUnit)
        call SaveGroupHandle(HY, h, 1, AllocationGroup(139))
      
        call SaveInteger(HY, h, 0, 0)
        call SaveInteger(HY, h, 1, 3)
        call SaveInteger(HY, h, 2, level)

        call SaveGroupHandle(HY, h, 0, allyGroup)

        call DeallocateGroup(g)
    endfunction

endscope
