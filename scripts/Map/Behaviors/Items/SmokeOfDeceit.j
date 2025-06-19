
scope SmokeOfDeceit

    function IsUnitIceBlast takes unit u returns boolean
        local integer unitTypeId = GetUnitTypeId(u)
        return unitTypeId =='H0B8'
    endfunction

    // 检查单位旁边
    private function IsEnemyPlayerUnitInRange takes unit whichUnit, real area returns boolean
        local real    x         = GetUnitX(whichUnit)
        local real    y         = GetUnitY(whichUnit)
        local boolean result    = false

        init_group_variable()

        start_group_enum(x, y, area)

        // 存活，敌对，非元素(可能无意义)，非英雄单位且不是冰晶爆轰，或是防御塔
        if IsUnitAlive(whichUnit) and IsUnitEnemy(whichUnit, GetOwningPlayer(first)) /*
            */ and not IsUnitBrewmasterElement(first) and /*
            */ ( ( IsUnitType(first, UNIT_TYPE_HERO) and not IsUnitIceBlast(first) ) or GetTowerLevel(first) > 0 ) then
            set result = true
        endif

        end_group_enum()

        return result
    endfunction

    function SmokeOfDeceitBuffOnAdd takes nothing returns nothing
        local unit    whichUnit   = Event.GetTriggerUnit()

        call UnitIncTruesightImmunityCount(whichUnit)
        set whichUnit = null
    endfunction
    function SmokeOfDeceitBuffOnRemove takes nothing returns nothing
        local unit    whichUnit = Event.GetTriggerUnit()

        call UnitDecTruesightImmunityCount(whichUnit)
        set whichUnit = null
    endfunction
    
    function SmokeOfDeceitOnUpdate takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit    whichUnit =(LoadUnitHandle(HY, h, 2))
        local group   g
        local integer count
        
        if GetTriggerEventId() == EVENT_PLAYER_UNIT_ATTACKED then
            if GetAttacker() == whichUnit then
                call UnitRemoveAbility(whichUnit,'A20L')
                call UnitRemoveAbility(whichUnit,'A20S')
                call UnitRemoveAbility(whichUnit,'B0E2')
                if ((LoadInteger(HY,(GetHandleId((whichUnit))),(4302))) == 1) == false then
                    call UnitSetUsesAltIcon(whichUnit, false)
                endif
                call DestroyEffect((LoadEffectHandle(HY, h, 32)))
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
            endif
        else
            
            set count = (LoadInteger(HY, h, 34))
            set count = count + 1
            call SaveInteger(HY, h, 34,(count))
            
            // 防止相位鞋把人暴露了 相位重写后就不必要了
            // if GetUnitAbilityLevel(whichUnit,'B09Y')> 0 then
            //     call SaveBoolean(HY, h, 671,(true))
            // elseif DZO then
            //     call SaveBoolean(HY, h, 671,(false))
            //     call UnitRemoveAbility(whichUnit,'A20L')
            //     call UnitAddPermanentAbility(whichUnit,'A20L')
            // endif
            if count > 450 or IsEnemyPlayerUnitInRange(whichUnit, 1050) then
                call UnitRemoveAbility(whichUnit,'A20L')
                call UnitRemoveAbility(whichUnit,'A20S')
                call UnitRemoveAbility(whichUnit,'B0E2')
                if ((LoadInteger(HY, GetHandleId(whichUnit), 4302)) != 1) then
                    call UnitSetUsesAltIcon(whichUnit, false)
                endif
                call DestroyEffect(LoadEffectHandle(HY, h, 32))
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
            endif
            
        endif
        set t = null
        set whichUnit = null
        return false
    endfunction

    function UnitAddSmokeOfDeceitEffect takes unit whichUnit returns nothing
        local trigger t = null
        local integer h

        // 在敌人的小地图上消失
        if not IsPlayerAlly(LocalPlayer, GetOwningPlayer(whichUnit)) and not IsPlayerObserverEx(LocalPlayer) then
            call UnitSetUsesAltIcon(whichUnit, true)
        endif

        call L6X(whichUnit)
        call UnitAddPermanentAbility(whichUnit, 'A20L')
        call UnitMakeAbilityPermanent(whichUnit, true,'A20L')
        
        if not DVX(whichUnit) then
            call UnitAddPermanentAbility(whichUnit,'A20S')
            call UnitMakeAbilityPermanent(whichUnit, true,'A20S')
            call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A20S', false)
        endif
        
        set t = CreateTrigger()
        set h = GetHandleId(t)
        call SaveInteger(HY, h, 34, 0)
        call SaveUnitHandle(HY, h, 2,(whichUnit))
        
        call SaveEffectHandle(HY, h, 32,(AddSpecialEffectTarget("war3mapImported\\SmokeOfDeceit.mdx", whichUnit, "chest")))
        call TriggerRegisterAnyUnitEvent(t, EVENT_PLAYER_UNIT_ATTACKED)
        call TriggerRegisterTimerEvent(t, .1, true)
        call TriggerAddCondition(t, Condition(function SmokeOfDeceitOnUpdate))

        set t = null
    endfunction
    function ItemSmokeOfDeceit takes nothing returns nothing
        local unit  whichUnit = GetTriggerUnit()
        local real  x         = GetUnitX(whichUnit)
        local real  y         = GetUnitY(whichUnit)
        local real  area      = 1200

        init_group_variable()

        start_group_enum(x, y, area)

        // 友军，存活，非建筑，非守卫
        if IsUnitAlly(whichUnit, GetOwningPlayer(first)) and IsAliveNotStrucNotWard(first) /*
            */ and IsPlayerValid(GetOwningPlayer(first)) and not IsEnemyPlayerUnitInRange(first, 1050) then
            call UnitAddSmokeOfDeceitEffect(first)
        endif

        end_group_enum()

        set whichUnit = null
    endfunction

endscope
