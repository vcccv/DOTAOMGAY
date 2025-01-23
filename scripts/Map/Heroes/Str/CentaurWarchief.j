
scope CentaurWarchief

    //***************************************************************************
    //*
    //*  奔袭冲撞
    //*
    //***************************************************************************
    function HJR takes nothing returns boolean
        local unit t = GetFilterUnit()
        local unit u = Temp__ArrayUnit[0]
        local group g = LoadGroupHandle(HY, XK[0], 1)
        if IsUnitInGroup(t, g) == false and IsUnitEnemy(u, GetOwningPlayer(t)) and UnitAlive(t) and IsUnitMagicImmune(t) == false and GetUnitAbilityLevel(t,'A04R') == 0 and IsUnitType(t, UNIT_TYPE_STRUCTURE) == false and GetUnitTypeId(t)!='n00L' then
            call GroupAddUnit(g, t)
            call WJV(t,'C017','D017', 1. + .5 * GetUnitAbilityLevel(u,'A2O4'))
            call UnitDamageTargetEx(u, t, 1, XK[1])
        endif
        set g = null
        set u = null
        set t = null
        return false
    endfunction
    function HKR takes nothing returns boolean
        local trigger trig = GetTriggeringTrigger()
        local integer WFV = GetHandleId(trig)
        local integer UYX = LoadInteger(HY, WFV, 0)
        local unit u = LoadUnitHandle(HY, WFV, 0)
        local group g = LoadGroupHandle(HY, WFV, 1)
        if GetTriggerEventId() == EVENT_WIDGET_DEATH or UYX == 76 then
            call SetUnitPathing(u, true)
            call UnitRemoveAbility(u,'A2O4')
            call UnitRemoveAbility(u,'B0GB')
            call DestroyEffect(LoadEffectHandle(HY, WFV, 3))
            call DestroyEffect(LoadEffectHandle(HY, WFV, 2))
            call DeallocateGroup(g)
            call FlushChildHashtable(HY, WFV)
            call CleanCurrentTrigger(trig)
            set trig = null
            set u = null
            set g = null
            return false
        endif
        set Temp__ArrayUnit[0]= u
        set XK[0]= WFV
        set XK[1]= LoadInteger(HY, WFV, 1)* GerHeroMainAttributesValue(u)
        call SaveInteger(HY, WFV, 0, UYX + 1)
        call GroupEnumUnitsInRange(AK, GetWidgetX(u), GetWidgetY(u), 175, Condition(function HJR))
        call KillTreeByCircle(GetUnitX(u), GetUnitY(u), 150)
        set trig = null
        set u = null
        set g = null
        return false
    endfunction
    function HMR takes unit u, integer level returns nothing
        local trigger trig = CreateTrigger()
        local integer WFV = GetHandleId(trig)
        local boolean HPR = GetUnitAbilityLevel(Temp__ArrayUnit[0],'A384')> 0
        call SetUnitPathing(u, false)
        call UnitAddPermanentAbility(u,'A2O4')
        call SetUnitAbilityLevel(u,'A2O4', level) // 2级时无论如何都享受减伤效果？
        if HPR then
            call SetUnitAbilityLevel(u,'A2O4', 2)
        endif
        call TriggerRegisterTimerEvent(trig, .05, true)
        call TriggerRegisterDeathEvent(trig, u)
        call TriggerAddCondition(trig, Condition(function HKR))
        call SaveUnitHandle(HY, WFV, 0, u)
        call SaveGroupHandle(HY, WFV, 1, AllocationGroup(139))
        call SaveEffectHandle(HY, WFV, 2, AddSpecialEffectTarget("war3mapImported\\SandBreathDamageSmall.mdx", u, GetHeroFootAttachPointName(u)))
        call SaveEffectHandle(HY, WFV, 3, AddSpecialEffectTarget("war3mapImported\\SandBreathDamageSmall.mdx", u, GetHeroFootAttachPointName(u)))
        call SaveInteger(HY, WFV, 0, 0)
        call SaveInteger(HY, WFV, 1, 3)
        set trig = null
    endfunction
    function HQR takes nothing returns boolean
        local unit t = GetFilterUnit()
        local unit u = Temp__ArrayUnit[0]
        if (IsUnitType(t, UNIT_TYPE_HERO))!= null and IsUnitAlly(u, GetOwningPlayer(t)) and UnitAlive(t) and(IsUnitHaveRearmAbility(u) == false or LoadInteger(HY, GetHandleId(t),'STMP')!= 1) then
            if t != u then
                call EPX(t,'STMP', 45)
            endif
            // debug call SingleDebug( GetUnitName( t ) + " 添加奔袭冲撞 " )
            call HMR(t, GetUnitAbilityLevel(u,'A2O6')+ GetUnitAbilityLevel(u,'A384'))
        endif
        set t = null
        set u = null
        return false
    endfunction
    function StampedeOnSpellEffect takes nothing returns nothing
        local unit    whichUnit = GetRealSpellUnit(whichUnit)
        local integer level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local boolean isUpgrade = GetSpellAbilityId() == 'A384'

        local sound   s
        
        local group   g = AllocationGroup(96)
        local player  p = GetOwningPlayer(whichUnit)
        local integer i 

        set s = CreateSound("abilities\\Spells\\Other\\Stampede\\StampedeCaster1.wav", false, false, false, 10, 10, "DefaultEAXON")
        call StartSound(s)
        call KillSoundWhenDone(s)
        
        set i = 0
        loop
            exitwhen i > bj_MAX_PLAYERS
            
            if IsPlayerAlly(p, Player(i)) then
                
                call GroupEnumUnitsOfPlayer(g, Player(i), null)
                loop
                    set first = FirstOfGroup(g)
                    exitwhen first == null
                    call GroupRemoveUnit(g, first)

                    if UnitAlive(first) and not IsUnitWard(first) and not  then
                        if t != u then
                            call EPX(first,'STMP', 45)
                        endif
                        // debug call SingleDebug( GetUnitName( t ) + " 添加奔袭冲撞 " )
                        call HMR(first, GetUnitAbilityLevel(u,'A2O6')+ GetUnitAbilityLevel(u,'A384'))
                    endif
                    
                endloop

            endif

            set i = i + 1
        endloop
  
        set Temp__ArrayUnit[0]= GetTriggerUnit()
        set XK[0]= GetUnitAbilityLevel(Temp__ArrayUnit[0],'A2O6')+ GetUnitAbilityLevel(Temp__ArrayUnit[0],'A384')
        call GroupEnumUnitsInRange(AK, 0, 0, 99999, Condition(function HQR))

        call DeallocateGroup(g)
        set s = null
    endfunction

endscope
