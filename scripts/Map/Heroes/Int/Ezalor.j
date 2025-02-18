
scope Ezalor

    //***************************************************************************
    //*
    //*  启明
    //*
    //***************************************************************************
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
        local unit O8O = LoadUnitHandle(ObjectHashTable, h, 1)
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
        call A8X(GetOwningPlayer(O8O), 2.5, x, y, 375)
        set Temp__Player = LoadPlayerHandle(ObjectHashTable, h, 2)
        set Temp__ArrayUnit[0]= O8O
        set XK[0]= LoadInteger(ObjectHashTable, h, 1)
        set Q7V = LoadGroupHandle(ObjectHashTable, h, 3)
        set X3 = IsUnitScepterUpgraded(u)
        call GroupEnumUnitsInRange(AK, x, y, 375, Condition(function W1R))
        set O8O = null
        set t = null
        set u = null
    endfunction
    function W3R takes nothing returns nothing
        local real s
        local timer t = GetExpiredTimer()
        local integer h = GetHandleId(t)
        local integer UYX = LoadInteger(ObjectHashTable, h, 0)-1
        local unit u = LoadUnitHandle(ObjectHashTable, h, 0)
        local unit O8O
        if UYX == 0 or LoadBoolean(ObjectHashTable, GetHandleId(LoadUnitHandle(ObjectHashTable, h, 1)),'A085') == false then
            call KillUnit(u)
            set O8O = CreateUnit(Player(15),'h070', LoadReal(ObjectHashTable, h, 0), LoadReal(ObjectHashTable, h, 1), LoadReal(ObjectHashTable, h, 2))
            call SetUnitScale(O8O, .1, .1, .1)
            call SaveReal(ObjectHashTable, h, StringHash("scale"), .15)
            call SaveInteger(ObjectHashTable, h, 0, 61)
            call SaveInteger(ObjectHashTable, h, 1,(LoadInteger(ObjectHashTable, h, 1)-UYX)* 10)
            call SaveUnitHandle(ObjectHashTable, h, 0, O8O)
            call SaveGroupHandle(ObjectHashTable, h, 3, AllocationGroup(209))
            call TimerStart(t, .025, true, function W2R)
            call SaveBoolean(ObjectHashTable, GetHandleId(LoadUnitHandle(ObjectHashTable, h, 1)),'A085', false)
            call SetPlayerAbilityAvailableEx(LoadPlayerHandle(ObjectHashTable, h, 2),'A121', false)
            call SetPlayerAbilityAvailableEx(LoadPlayerHandle(ObjectHashTable, h, 2),'A085', true)
            call RemoveUnit(LoadUnitHandle(ObjectHashTable, h, 4))
            set O8O = null
            set t = null
            set u = null
            return
        endif
        set s = 1 +(LoadInteger(ObjectHashTable, h, 1)-UYX)* .1
        call SetUnitScale(u, s, s, s)
        call SaveInteger(ObjectHashTable, h, 0, UYX)
        set t = null
        set u = null
    endfunction
    function IlluminateOnSpellEffect takes nothing returns nothing
        local timer t = CreateTimer()
        local unit u = GetTriggerUnit()
        local player p = GetOwningPlayer(u)
        local real x = GetWidgetX(u)
        local real y = GetWidgetY(u)
        local real a = Atan2(GetSpellTargetY()-y, GetSpellTargetX()-x)
        local real x1 = x + 150* Cos(a)
        local real y1 = y + 150* Sin(a)
        local integer h = GetHandleId(t)
        local integer i = GetUnitAbilityLevel(u,'A085')* 10+ 10
        call SetPlayerAbilityAvailableEx(p,'A085', false)
        call SetPlayerAbilityAvailableEx(p,'A121', true)
        call UnitAddPermanentAbility(u,'A121')
        call SaveUnitHandle(ObjectHashTable, h, 0, CreateUnit(Player(15),'u00J', x1, y1, a * bj_RADTODEG))
        call SavePlayerHandle(ObjectHashTable, h, 2, p)
        call SaveInteger(ObjectHashTable, h, 0, i)
        call SaveInteger(ObjectHashTable, h, 1, i)
        call SaveReal(ObjectHashTable, h, 0, x1)
        call SaveReal(ObjectHashTable, h, 1, y1)
        call SaveReal(ObjectHashTable, h, 2, a * bj_RADTODEG)
        call SaveReal(ObjectHashTable, h, 3, 26.25 * Cos(a))
        call SaveReal(ObjectHashTable, h, 4, 26.25 * Sin(a))
        if GetUnitTypeId(u)=='e00E' then
            call SaveUnitHandle(ObjectHashTable, h, 1, PlayerHeroes[GetPlayerId(p)])
            call SaveBoolean(ObjectHashTable, GetHandleId(PlayerHeroes[GetPlayerId(p)]),'A085', true)
        else
            call SaveUnitHandle(ObjectHashTable, h, 1, u)
            call SaveBoolean(ObjectHashTable, GetHandleId(u),'A085', true)
            if GetUnitTypeId(u)>='H06W' and GetUnitTypeId(u)<='H06Y' then
                set u = CreateUnit(p,'h06Z', x, y, a * bj_RADTODEG)
                call SetUnitX(u, x)
                call SetUnitY(u, y)
                call SetUnitAnimation(u, "spell")
                call QueueUnitAnimation(u, "spell")
                call SetUnitVertexColor(u, 255, 255, 255, 75)
                call SaveUnitHandle(ObjectHashTable, h, 4, u)
            endif
        endif
        call TimerStart(t, .1, true, function W3R)
        set t = null
        set u = null
    endfunction

endscope
