scope LoneDruid

    //***************************************************************************
    //*
    //*  熊灵伙伴
    //*
    //***************************************************************************
    globals
        // 熊灵单位
        private key SPIRIT_BEAR_UNIT
        // 熊灵单位物品持有者
        private key PLAYER_SPIRIT_BEAR_ITEM_HOLD
    endglobals

    function GetUnitSummonedSpiritBear takes unit whichUnit returns unit
        return Table[GetHandleId(whichUnit)].unit[SPIRIT_BEAR_UNIT]
    endfunction
    
    // 死亡竞赛，要把身上的tp都给吐出来
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
    function IRI takes unit killingUnit, unit dyingUnit returns nothing
        local location l = GetUnitLoc(dyingUnit)
        local rect r = RectFromCenterSizeBJ(l, 400., 400.)
        local unit u = PlayerHeroes[GetPlayerId(GetOwningPlayer(dyingUnit))]
        local integer level = GetUnitAbilityLevel(u,'A0A5')
        call SetHeroXP(u, GetHeroXP(u)-(GetHeroXP(u)/(125 -(25 * level))), false)
        call UnitDamageTargetEx(killingUnit, u, 5, 100. * I2R(level))
        call EnumItemsInRect(r, null, function IOI)
        call RemoveLocation(l)
        call RemoveRect(r)
        set l = null
        set r = null
        set u = null
    endfunction
    function III takes unit killingUnit, unit dyingUnit returns nothing
        local unit spiritBear
        if IsUnitSpiritBear(dyingUnit) then
            // 还需要继承tp冷却时间
            call IRI(killingUnit, dyingUnit)
        elseif GetUnitSummonedSpiritBear(dyingUnit) != null then
            set spiritBear = GetUnitSummonedSpiritBear(dyingUnit)
            // 熊灵存活，并且主人没有A杖。
            if IsUnitAlive(spiritBear) and not IsUnitScepterUpgraded(dyingUnit) then
                call KillUnit(spiritBear)
            endif
            set spiritBear = null
        endif
    endfunction
    
    function SummonSpiritBearOnDeath takes nothing returns nothing
        call III(UEKillingUnit, UEDyingUnit)
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
    // LastSpiritBearInheritItem
    private function LastSpiritBearInheritItem takes unit spiritBear returns nothing
        local integer h          = GetHandleId(GetOwningPlayer(spiritBear))
        local unit    itemHolder = LoadUnitHandle(HY, h, 334)
        local unit    newUnit    = LoadUnitHandle(HY, h, 333)
        if itemHolder != null and not Mode__DeathMatch  then
            call UnitAddItem(newUnit, UnitRemoveItemFromSlot(itemHolder, 0))
            call UnitAddItem(newUnit, UnitRemoveItemFromSlot(itemHolder, 1))
            call UnitAddItem(newUnit, UnitRemoveItemFromSlot(itemHolder, 2))
            call UnitAddItem(newUnit, UnitRemoveItemFromSlot(itemHolder, 3))
            call UnitAddItem(newUnit, UnitRemoveItemFromSlot(itemHolder, 4))
            call UnitAddItem(newUnit, UnitRemoveItemFromSlot(itemHolder, 5))
            if GetUnitAbilityLevel(itemHolder,'A398')> 0 then
                call UnitAddPermanentAbility(newUnit,'A398')
            endif
            call SetUnitTownPortalScrollCharges(newUnit, GetUnitTownPortalScrollCharges(itemHolder))
            call SetUnitTownPortalScrollCooldown(newUnit, GetUnitTownPortalScrollCooldown(itemHolder))
        endif
        set itemHolder = null
        set newUnit    = null
    endfunction

    function SummonSpiritBearOnSpellEffectBear takes nothing returns nothing
        local unit    whichUnit = GetTriggerUnit()
        local player  p         = GetOwningPlayer(whichUnit)
        local real    x         = GetUnitX(whichUnit)
        local real    y         = GetUnitY(whichUnit)
        local group   g         
        local integer level     = GetUnitAbilityLevel(whichUnit,'A0A5')
        local integer h         = GetHandleId(p)
        local integer unitId    = 0
        local unit    first
        local unit    lastSpiritBear = null
        
        set g = AllocationGroup(266)
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
                set unitId ='n004'
            elseif (level == 2) then
                set unitId ='n018'
            elseif (level == 3) then
                set unitId ='n01C'
            else
                set unitId ='n01G'
            endif
            set lastSpiritBear = SummonUnit(whichUnit, unitId, x, y, GetUnitFacing(whichUnit))
            set Table[GetHandleId(whichUnit)].unit[SPIRIT_BEAR_UNIT] = lastSpiritBear
            call R5I(lastSpiritBear, level -1, p, true)
            call UnitAddTownPortalScrollAbility(lastSpiritBear)
            call SaveUnitHandle(HY, h, 333, lastSpiritBear)
            call LastSpiritBearInheritItem(lastSpiritBear)
            call AddSpecialEffectTarget("Abilities\\Spells\\Orc\\FeralSpirit\\feralspiritdone.mdl", lastSpiritBear, "chest")
            call RZI(lastSpiritBear)
            call SetUnitAbilityLevel(lastSpiritBear,'A09Y', level)
            call R7I(lastSpiritBear)
        else
            call AddSpecialEffectTarget("Abilities\\Spells\\Orc\\FeralSpirit\\feralspiritdone.mdl", lastSpiritBear, "chest")
            call SetWidgetLife(lastSpiritBear, GetUnitState(lastSpiritBear, UNIT_STATE_MAX_LIFE))
            call SetUnitPosition(lastSpiritBear, GetUnitX(whichUnit), GetUnitY(whichUnit))
        endif
        // 协同
        if GetUnitAbilityLevel(whichUnit,'A0A8')> 0 then
            call SetUnitMoveSpeed(lastSpiritBear, GetUnitDefaultMoveSpeed(lastSpiritBear) + 8 * GetUnitAbilityLevel(whichUnit,'A0A8'))
            
            if GetUnitAbilityLevel(lastSpiritBear,'A3IL') == 0 then
                call UnitAddPermanentAbility(lastSpiritBear,'A3IL')
            endif
            call SetUnitAbilityLevel(lastSpiritBear,'A3IL', GetUnitAbilityLevel(whichUnit,'A0A8'))
        endif
        set lastSpiritBear = null
        set whichUnit = null
        set g = null
    endfunction

endscope
