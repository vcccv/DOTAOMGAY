
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
        local unit    u         = LoadUnitHandle(HY, h, 0)
        local group   targGroup = LoadGroupHandle(HY, h, 1)
        local group   g
        local real    x
        local real    y
        local real    area      = 175.
        local unit    first
        local real    damage
        local integer level     = LoadInteger(HY, h, 1)
        if GetTriggerEventId() == EVENT_WIDGET_DEATH or count == 76 then
            call UnitRemoveAbility(u, 'A2O4')
            call UnitRemoveAbility(u, 'B0GB')
            call UnitRemoveAbility(u, 'A2O5')
            call UnitRemoveAbility(u, 'B0GH')
            call DestroyEffect(LoadEffectHandle(HY, h, 3))
            call DestroyEffect(LoadEffectHandle(HY, h, 2))
            call DeallocateGroup(targGroup)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(trig)
            set trig = null
            set u = null
            set targGroup = null
            return false
        endif

        set damage = LoadInteger(HY, h, 1) * GerHeroMainAttributesValue(LoadUnitHandle(HY, h, 10))
        set g = AllocationGroup(45)
        //call BJDebugMsg("伤害是："+R2S(damage))

        set x = GetUnitX(u)
        set y = GetUnitY(u)
        call GroupEnumUnitsInRange(g, x, y, area + MAX_UNIT_COLLISION, null)
        loop
            set first = FirstOfGroup(g)
            exitwhen first == null
            call GroupRemoveUnit(g, first)
            
            if UnitAlive(first) and not IsUnitInGroup(first, targGroup)/*
                */ and IsUnitEnemy(u, GetOwningPlayer(first)) and not IsUnitMagicImmune(first)/*
                */ and not IsUnitWard(first) and not IsUnitType(first, UNIT_TYPE_STRUCTURE) then
        
                call GroupAddUnit(targGroup, first)
                call UnitAddAbilityLevel1ToTimed(first,'C017','D017', 1. + .5 * level)
                call UnitDamageTargetEx(u, first, 1, damage)

            endif
        endloop

        call DeallocateGroup(g)

        call SaveInteger(HY, h, 0, count + 1)
        call KillTreeByCircle(GetUnitX(u), GetUnitY(u), 150)
        set trig = null
        set u = null
        set targGroup = null
        return false
    endfunction
    function UnitAddStampedeBuff takes unit owner, unit u, integer level, boolean isUpgrade returns nothing
        local trigger trig        = CreateTrigger()
        local integer h           = GetHandleId(trig)
        local integer dummyAbilId = 'A2O4'

        // 死亡驱散
        if isUpgrade then
            set dummyAbilId = 'A2O5'
        endif
        call UnitAddPermanentAbility(u, dummyAbilId)

        call TriggerRegisterTimerEvent(trig, .05, true)
        call TriggerRegisterDeathEvent(trig, u)
        call TriggerAddCondition(trig, Condition(function OnStampedeUpdate))
        call SaveUnitHandle(HY, h, 0, u)
        call SaveUnitHandle(HY, h, 10, owner)
        call SaveGroupHandle(HY, h, 1, AllocationGroup(139))
        call SaveEffectHandle(HY, h, 2, AddSpecialEffectTarget("war3mapImported\\SandBreathDamageSmall.mdx", u, GetHeroFootAttachPointName(u)))
        call SaveEffectHandle(HY, h, 3, AddSpecialEffectTarget("war3mapImported\\SandBreathDamageSmall.mdx", u, GetHeroFootAttachPointName(u)))
        call SaveInteger(HY, h, 0, 0)
        call SaveInteger(HY, h, 1, 3)
        call SaveInteger(HY, h, 2, level)
        set trig = null
    endfunction

    function CentaurWarchiefStampedeBuffOnAdd takes nothing returns nothing
        local unit u = MHEvent_GetUnit()
        call UnitAddMoveSpeedBonusPercent(u, 1000)
        call UnitAddNoPathingCount(u)
        set u = null
    endfunction
    function CentaurWarchiefStampedeBuffOnRemove takes nothing returns nothing
        local unit u = MHEvent_GetUnit()
        call UnitReduceMoveSpeedBonusPercent(u, 1000)
        call UnitSubNoPathingCount(u)
        set u = null
    endfunction

    // 还要重写，一个单位组解决而不是独立单位组独立tick
    function StampedeOnSpellEffect takes nothing returns nothing
        local unit    whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local integer level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local boolean isUpgrade = GetSpellAbilityId() == 'A384'

        local sound   s
        
        local group   g = AllocationGroup(96)
        local player  p = GetOwningPlayer(whichUnit)
        local integer i 
        local unit    first

        set s = CreateSound("abilities\\Spells\\Other\\Stampede\\StampedeCaster1.wav", false, false, false, 10, 10, "DefaultEAXON")
        call StartSound(s)
        call KillSoundWhenDone(s)
        set s = null

        call SetAbilityAddAction('B0GB', "CentaurWarchiefStampedeBuffOnAdd")
        call SetAbilityRemoveAction('B0GB', "CentaurWarchiefStampedeBuffOnRemove")

        set i = 0
        loop
            
            if IsPlayerAlly(p, Player(i)) then
                
                call GroupEnumUnitsOfPlayer(g, Player(i), null)
                loop
                    set first = FirstOfGroup(g)
                    exitwhen first == null
                    call GroupRemoveUnit(g, first)

                    if GetUnitAbilityLevel(first, 'Aloc') == 0 and UnitAlive(first) and not IsUnitWard(first) and not IsUnitCourier(first) and not IsUnitType(first, UNIT_TYPE_STRUCTURE) then
                        call UnitAddStampedeBuff(whichUnit, first, level, isUpgrade)
                    endif
                    
                endloop

            endif

            set i = i + 1
            exitwhen i == bj_MAX_PLAYERS
        endloop

        call DeallocateGroup(g)
    endfunction

endscope
