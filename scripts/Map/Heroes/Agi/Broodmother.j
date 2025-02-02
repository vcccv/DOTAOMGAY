
scope Broodmother

    //***************************************************************************
    //*
    //*  织网
    //*
    //***************************************************************************

    function HBI takes nothing returns boolean
        return GetUnitTypeId(GetSummonedUnit())=='o003'
    endfunction
    function HCI takes nothing returns nothing
        local unit HDI = GetSummonedUnit()
        local unit HFI = PlayerHeroes[GetPlayerId(GetOwningPlayer(GetSummoningUnit()))]
        local integer h = GetHandleId(HFI)
        local integer level = GetUnitAbilityLevel(HFI,'Z234')
        local integer HGI =(LoadInteger(HY, h, 279))
        local unit HHI =(LoadUnitHandle(HY, h,( 1400+ 1)))
        local integer x = 1
        set HGI = HGI + 1
        call SetUnitVertexColorBJ(HDI, 100, 100, 100, 85)
        call UnitAddPermanentAbility(HDI,'Aloc')
        call SaveUnitHandle(HY, h,( 1400+ HGI),(HDI))
        if (HGI > level * 2) then
            call KillUnit(HHI)
            loop
            exitwhen x == HGI
                call SaveUnitHandle(HY, h,( 1400+ x),((LoadUnitHandle(HY, h,( 1400+ x + 1)))))
                set x = x + 1
            endloop
            set HGI = HGI -1
        endif
        call SaveInteger(HY, h, 279,(HGI))
        call SetUnitAbilityLevel(HDI,'A0BF', level)
        set HDI = null
        set HFI = null
        set HHI = null
    endfunction
    function SpinWebOnSpellEffect takes nothing returns nothing
        local unit d = CreateUnit(GetOwningPlayer(GetTriggerUnit()),'o003', GetSpellTargetX(), GetSpellTargetY(), 0)
        local unit u = PlayerHeroes[GetPlayerId(GetOwningPlayer(d))]
        local integer h = GetHandleId(u)
        local integer lv = GetUnitAbilityLevel(u,'Z234')
        local integer maxi =(LoadInteger(HY, h, 279))
        local unit HHI =(LoadUnitHandle(HY, h,(1400 + 1)))
        local integer x = 1
        call SetUnitAnimation(d, "birth")
        call QueueUnitAnimation(d, "stand")
        set maxi = maxi + 1
        call SetUnitVertexColorBJ(d, 100, 100, 100, 85)
        call UnitAddPermanentAbility(d,'Aloc')
        call SaveUnitHandle(HY, h,(1400 + maxi),(d))
        if (maxi > lv * 2) then
            call KillUnit(HHI)
            loop
            exitwhen x == maxi
                call SaveUnitHandle(HY, h,(1400 + x),((LoadUnitHandle(HY, h,(1400 + x + 1)))))
                set x = x + 1
            endloop
            set maxi = maxi -1
        endif
        call SaveInteger(HY, h, 279,(maxi))
        call SetUnitAbilityLevel(d,'A0BF', lv)
        set d = null
        set u = null
        set HHI = null
    endfunction
    function M5X takes nothing returns nothing
        local trigger t = CreateTrigger()
        call TriggerRegisterPlayerUnitEventBJ(t, EVENT_PLAYER_UNIT_SUMMON)
        call TriggerAddCondition(t, Condition(function HBI))
        call TriggerAddAction(t, function HCI)
        set t = null
    endfunction

    function HJI takes nothing returns boolean
        return GetOwningPlayer(GetFilterUnit()) == GetOwningPlayer(XB) and(not IsUnitDummy(GetFilterUnit()) and not IsUnitWard(GetFilterUnit()))
    endfunction
    function HKI takes nothing returns nothing
        local real x
        local real y
        local unit web
        local integer i = 1
        local unit u = GetEnumUnit()
        local boolean b = false
        if PlayerHeroes[GetPlayerId(GetOwningPlayer(u))] != null then
            loop
                set web = LoadUnitHandle(HY, GetHandleId(u), 1400 + i)
                if web != null then
                    set x = GetUnitX(web)
                    set y = GetUnitY(web)
                    if (GetDistanceBetween(x, y, GetUnitX(u), GetUnitY(u))< 875) then
                        set b = true
                    endif
                else
                    set i = 9
                endif
                set i = i + 1
            exitwhen i > 9 or b
            endloop
        endif
        if b == false then
            if IsUnitType(u, UNIT_TYPE_HERO) then
                call UnitRemoveAbility(u,'A021')
            else
                call UnitRemoveAbility(u,'A29C')
            endif
            call UnitRemoveAbility(u,'B01C')
            call SetUnitPathingEx(u, true)
        endif
        set web = null
        set u = null
    endfunction
    function HMI takes nothing returns nothing	//如果三秒内没被打则设置无视地形。
        local unit u = GetEnumUnit()
        if IsUnitType(u, UNIT_TYPE_HERO) then
            if GetUnitAbilityLevel(u,'A021') == 0 then
                call L6X(u)
                call UnitAddAbility(u,'A021')
            endif
        else
            if GetUnitAbilityLevel(u,'A29C') == 0 then
                call UnitAddAbility(u,'A29C')
            endif
        endif
        call SetUnitPathingEx(u, LoadReal(HY, GetHandleId(u), 785) + 3 > GetGameTime())
        set u = null
    endfunction
    function HPI takes nothing returns nothing//织网
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local group g
        local group gg = null
        local unit u
        if GetTriggerEventId() == EVENT_UNIT_DEATH then
            call DestroyGroup(LoadGroupHandle(HY, h, 1))
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        else
            if LoadBoolean(HY, h, 0) == false then
                set g = CreateGroup()
                call SaveBoolean(HY, h, 0, true)
                call SaveGroupHandle(HY, h, 1, g)
            endif
            set u = LoadUnitHandle(HY, h, 0)
            set g = LoadGroupHandle(HY, h, 1)
            set gg = AllocationGroup(312)
            set XB = u
            call GroupEnumUnitsInRange(gg, GetUnitX(u), GetUnitY(u), 900, Condition(function HJI))
            call GroupRemoveGroup(gg, g)
            set XB = u
            call ForGroup(g, function HKI)
            call ForGroup(gg, function HMI)
            call GroupClear(g)
            call GroupAddGroup(gg, g)
            call DeallocateGroup(gg)
            set gg = null
        endif
        set t = null
        set g = null
        set u = null
    endfunction
    function HQI takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        call TriggerRegisterTimerEvent(t, .3, true)
        call TriggerRegisterUnitEvent(t, GetTriggerUnit(), EVENT_UNIT_DEATH)
        call TriggerAddCondition(t, Condition(function HPI))
        call SaveUnitHandle(HY, h, 0, GetTriggerUnit())
        call SaveBoolean(HY, h, 0, false)
        set t = null
    endfunction
    function HSI takes nothing returns nothing
        if GetUnitTypeId(GetTriggerUnit())=='o003' then
            call HQI()
        endif
    endfunction
    // 蜘蛛网
    function M6X takes nothing returns nothing
        local trigger t = CreateTrigger()
        call YDWETriggerRegisterEnterRectSimpleNull(t, GetWorldBounds())
        call TriggerAddCondition(t, Condition(function HSI))
        set t = null
    endfunction
    
endscope
