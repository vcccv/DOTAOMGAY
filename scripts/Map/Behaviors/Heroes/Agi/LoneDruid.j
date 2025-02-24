scope LoneDruid

    //***************************************************************************
    //*
    //*  熊灵伙伴
    //*
    //***************************************************************************
    globals
        integer array PlayerSpiritBearTownPortalScrollCharges
    endglobals
    
    function IVI takes nothing returns nothing
        local location l
        if IsPlayerSentinel(GetOwningPlayer(GetTriggerUnit())) then
            set l = GetRectCenter(gg_rct_SentinelRevivalPoint)
        else
            set l = GetRectCenter(gg_rct_ScourgeRevivalPoint)
        endif
        if IsItemDeathDrop(GetEnumItem()) == false then
            call SetItemPositionLoc(GetEnumItem(), l)
        endif
        call RemoveLocation(l)
        set l = null
    endfunction
    function IEI takes nothing returns nothing
        local integer h = GetHandleId(GetOwningPlayer(GetTriggerUnit()))
        local unit IXI = LoadUnitHandle(HY, h, 334)
        local unit RWI = LoadUnitHandle(HY, h, 333)
        local integer x
        local integer y
        if IXI == null then
            if IsPlayerSentinel(GetOwningPlayer(RWI)) then
                set x =-6390
                set y =-5615
            else
                set x = 5875
                set y = 5000
            endif
            set IXI = CreateUnit(GetOwningPlayer(GetTriggerUnit()),'e01F', x, y, 0)
            call SaveUnitHandle(HY, h, 334, IXI)
        endif
        if IsItemDeathDrop(GetEnumItem()) == false then
            call UnitAddItem(IXI, GetEnumItem())
        endif
        if GetUnitAbilityLevel(RWI,'A398')> 0 then
            call UnitAddPermanentAbility(IXI,'A398')
        endif
        call ShowUnit(IXI, true)
        set IXI = null
        set RWI = null
    endfunction
    function IOI takes nothing returns nothing
        local integer itemIndex = GetItemIndexEx(GetEnumItem())
        if GetWidgetLife(GetEnumItem())> 0 and itemIndex != AIV then
            if Mode__DeathMatch then
                call IVI()
            else
                call IEI()
            endif
        endif
    endfunction
    function IRI takes unit R8X, unit triggerUnit returns nothing
        local location l = GetUnitLoc(triggerUnit)
        local rect r = RectFromCenterSizeBJ(l, 400., 400.)
        local unit u = PlayerHeroes[GetPlayerId(GetOwningPlayer(triggerUnit))]
        local integer level = GetUnitAbilityLevel(u,'A0A5')
        call SetHeroXP(u, GetHeroXP(u)-(GetHeroXP(u)/(125 -(25 * level))), false)
        call UnitDamageTargetEx(R8X, u, 5, 100. * I2R(level))
        call EnumItemsInRect(r, null, function IOI)
        call RemoveLocation(l)
        call RemoveRect(r)
        set l = null
        set r = null
        set u = null
    endfunction
    function III takes unit R8X, unit triggerUnit returns nothing
        if IsUnitSpiritBear(triggerUnit) then
            // 还需要继承tp冷却时间
            set PlayerSpiritBearTownPortalScrollCharges[GetPlayerId(GetOwningPlayer(triggerUnit))] = GetUnitTownPortalScrollCharges(triggerUnit)
            call IRI(R8X, triggerUnit)
        endif
    endfunction
    
    function R9I takes unit triggerUnit returns nothing
        local integer pid = GetPlayerId(GetOwningPlayer(triggerUnit))
        if triggerUnit == PlayerHeroes[pid]and HaveSavedHandle(HY, GetHandleId(GetOwningPlayer(triggerUnit)), 333) and UnitIsDead(LoadUnitHandle(HY, GetHandleId(GetOwningPlayer(triggerUnit)), 333)) == false and IsUnitScepterUpgraded(triggerUnit) == false then
            call KillUnit(LoadUnitHandle(HY, GetHandleId(GetOwningPlayer(triggerUnit)), 333))
        endif
    endfunction
    
    function SummonSpiritBearOnDeath takes nothing returns nothing
        call III(TV, SV)
        call R9I(SV)
    endfunction
    function SummonSpiritBearOnInitializer takes nothing returns nothing
        call RegisterUnitDeathMethod("SummonSpiritBearOnDeath")
    endfunction

    function RYI takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit u = LoadUnitHandle(HY, h, 2)
        local real time
        if GetTriggerEventId() == EVENT_UNIT_DEATH then
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        elseif GetTriggerEventId() == EVENT_UNIT_DAMAGED then
            if GetEventDamage()> 2 and GetEventDamageSource()!= GetTriggerUnit() and IsPlayerValid(GetOwningPlayer(GetEventDamageSource())) then
                call SaveReal(HY, h, 785, GetGameTime()* 1.)
                call SaveReal(HY, GetHandleId(u), 785, GetGameTime()* 1.)
                call SetPlayerAbilityAvailableEx(GetOwningPlayer(u),'A0A7', false)
            endif
        endif
        set time = LoadReal(HY, h, 785)
        if time + 3 < GetGameTime() then
            if (LoadInteger(HY, h, 34)) == 2 then
                call SaveInteger(HY, h, 34, 1)
                call SetPlayerAbilityAvailableEx(GetOwningPlayer(u),'A0A7', true)
            endif
        else
            if (LoadInteger(HY, h, 34)) == 1 then
                call SaveInteger(HY, h, 34, 2)
                call SetPlayerAbilityAvailableEx(GetOwningPlayer(u),'A0A7', false)
            endif
        endif
        set t = null
        set u = null
        return false
    endfunction
    function RZI takes unit RWI returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        call TriggerRegisterTimerEvent(t, .2, true)
        call TriggerRegisterUnitEvent(t, RWI, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(t, RWI, EVENT_UNIT_DEATH)
        call TriggerAddCondition(t, Condition(function RYI))
        call SaveUnitHandle(HY, h, 2, RWI)
        call SaveReal(HY, h, 785, .0)
        call SaveInteger(HY, h, 34, 1)
        call SetPlayerAbilityAvailableEx(GetOwningPlayer(RWI),'A0A7', true)
        set t = null
    endfunction

    function R5I takes unit u, integer level, player p, boolean b returns nothing
        if level == 0 then
            return
        endif
        call UnitAddPermanentAbility(u,'A34C')
        call SetUnitAbilityLevel(u,'A34C', level)
        call SetPlayerAbilityAvailable(GetOwningPlayer(u),'A34C', true)
        if b then
            call TriggerRegisterUnitEvent(UnitEventMainTrig, u, EVENT_UNIT_SPELL_EFFECT)
        endif
    endfunction

    function R3I takes nothing returns boolean
        return IsUnitSpiritBear(GetFilterUnit()) and GetUnitTypeId(GetFilterUnit())!='n01G' and UnitIsDead(GetFilterUnit()) == false
    endfunction
    function PYE takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local player p = GetOwningPlayer(u)
        local group g
        local integer level = GetUnitAbilityLevel(u,'A0A5')
        local integer i
        local unit RWI
        call SetPlayerTechResearched(GetOwningPlayer(GetTriggerUnit()),'R000', level)
        if level > 1 then
            set g = AllocationGroup(265)
            call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(u), Condition(function R3I))
            set i = CountUnitsInGroup(g)
            if (i == 1) then
                set RWI = FirstOfGroup(g)
                call AddSpecialEffectTarget("Abilities\\Spells\\Orc\\FeralSpirit\\feralspiritdone.mdl", RWI, "chest")
                if (level == 2) then
                    call UnitAddMaxLife(RWI, 400)
                    call UnitAddPermanentAbility(RWI,'A0A7')
                    call RZI(RWI)
                elseif (level == 3) then
                    call UnitAddMaxLife(RWI, 500)
                    call UnitAddPermanentAbility(RWI,'A33C')
                elseif (level == 4) then
                    call UnitAddMaxLife(RWI, 400)
                    call UnitAddPermanentAbility(RWI,'A03A')
                    call UnitAddPermanentAbility(RWI,'A0AH')
                endif
                call R5I(RWI, level -1, p, true)
            endif
            call DeallocateGroup(g)
        endif
        set g = null
        set u = null
        set RWI = null
    endfunction
    
    function R4I takes nothing returns nothing
        local integer h = GetHandleId(GetOwningPlayer(GetTriggerUnit()))
        local unit u = LoadUnitHandle(HY, h, 334)
        local unit WZV = LoadUnitHandle(HY, h, 333)
        if u != null and not Mode__DeathMatch  then
            call UnitAddItem(WZV, UnitRemoveItemFromSlot(u, 0))
            call UnitAddItem(WZV, UnitRemoveItemFromSlot(u, 1))
            call UnitAddItem(WZV, UnitRemoveItemFromSlot(u, 2))
            call UnitAddItem(WZV, UnitRemoveItemFromSlot(u, 3))
            call UnitAddItem(WZV, UnitRemoveItemFromSlot(u, 4))
            call UnitAddItem(WZV, UnitRemoveItemFromSlot(u, 5))
            if GetUnitAbilityLevel(u,'A398')> 0 then
                call UnitAddPermanentAbility(WZV,'A398')
            endif
        endif
        set u = null
        set WZV = null
    endfunction

    function SummonSpiritBearOnSpellEffectBear takes nothing returns nothing
        local unit    u     = GetTriggerUnit()
        local player  p     = GetOwningPlayer(u)
        local real    x     = GetUnitX(u)
        local real    y     = GetUnitY(u)
        local group   g     = AllocationGroup(266)
        local integer level = GetUnitAbilityLevel(u,'A0A5')
        local integer h     = GetHandleId(p)
        local integer id    = 0
        local unit    first
        local unit    lastSpiritBear = null
        
        call GroupEnumUnitsOfPlayer(g, p, null)

        loop
            set first = FirstOfGroup(g)
            exitwhen first == null
            call GroupRemoveUnit(g, first)

            if IsUnitSpiritBear(first) and not IsUnitIllusion(first) and IsUnitAlive(first) then
                set lastSpiritBear = first
                exitwhen true
            endif
            
        endloop
        call DeallocateGroup(g)
        set first = null

        if lastSpiritBear == null then
            if (level == 1) then
                set id ='n004'
            elseif (level == 2) then
                set id ='n018'
            elseif (level == 3) then
                set id ='n01C'
            else
                set id ='n01G'
            endif
            set lastSpiritBear = CreateUnit(GetOwningPlayer(u), id, x, y, GetUnitFacing(u))
            call R5I(lastSpiritBear, level -1, p, true)
            call UnitAddTownPortalScrollAbility(lastSpiritBear, PlayerSpiritBearTownPortalScrollCharges[GetPlayerId(p)])
            call SaveUnitHandle(HY, h, 333, lastSpiritBear)
            call R4I()
            call AddSpecialEffectTarget("Abilities\\Spells\\Orc\\FeralSpirit\\feralspiritdone.mdl", lastSpiritBear, "chest")
            call RZI(lastSpiritBear)
            call SetUnitAbilityLevel(lastSpiritBear,'A09Y', level)
            call R7I(lastSpiritBear)
        else
            call AddSpecialEffectTarget("Abilities\\Spells\\Orc\\FeralSpirit\\feralspiritdone.mdl", lastSpiritBear, "chest")
            call SetWidgetLife(lastSpiritBear, GetUnitState(lastSpiritBear, UNIT_STATE_MAX_LIFE))
            call SetUnitPosition(lastSpiritBear, GetUnitX(u), GetUnitY(u))
        endif
        // 协同
        if GetUnitAbilityLevel(u,'A0A8')> 0 then
            call SetUnitMoveSpeed(lastSpiritBear, GetUnitDefaultMoveSpeed(lastSpiritBear) + 8 * GetUnitAbilityLevel(u,'A0A8'))
            
            if GetUnitAbilityLevel(lastSpiritBear,'A3IL') == 0 then
                call UnitAddPermanentAbility(lastSpiritBear,'A3IL')
            endif
            call SetUnitAbilityLevel(lastSpiritBear,'A3IL', GetUnitAbilityLevel(u,'A0A8'))
        endif
        set lastSpiritBear = null
        set u = null
        set g = null
    endfunction

endscope
