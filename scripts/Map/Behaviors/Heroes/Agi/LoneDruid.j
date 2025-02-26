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

    // 获取单位召唤的熊灵
    function GetUnitSummonedSpiritBear takes unit whichUnit returns unit
        return Table[GetHandleId(whichUnit)].unit[SPIRIT_BEAR_UNIT]
    endfunction

    function GetPlayerSpiritBearItemHolder takes player whichPlayer returns unit
        return Table[GetHandleId(whichPlayer)].unit[PLAYER_SPIRIT_BEAR_ITEM_HOLD]
    endfunction
    
    // 死亡竞赛，要把身上的tp都给吐出来
    function SpiritBearDropItemInDeathMatch takes nothing returns nothing
        local real tx
        local real ty
        if IsPlayerSentinel(GetOwningPlayer(UEDyingUnit)) then
            set tx = GetRectCenterX(gg_rct_SentinelRevivalPoint)
            set ty = GetRectCenterY(gg_rct_SentinelRevivalPoint)
        else
            set tx = GetRectCenterX(gg_rct_ScourgeRevivalPoint)
            set ty = GetRectCenterY(gg_rct_ScourgeRevivalPoint)
        endif
        if not IsItemDeathDrop(GetEnumItem()) then
            call SetItemPosition(GetEnumItem(), tx, ty)
        endif
    endfunction

    private function AddSpiritBearItemToItemHolder takes nothing returns nothing
        local unit    spiritBear  = UEDyingUnit
        local player  whichPlayer = GetOwningPlayer(spiritBear)
        local unit    itemHolder  = GetPlayerSpiritBearItemHolder(whichPlayer)
        local integer x
        local integer y

        if not IsItemDeathDrop(GetEnumItem()) then
            call UnitAddItem(itemHolder, GetEnumItem())
        endif

        call ShowUnit(itemHolder, true)
        set itemHolder = null
        set spiritBear = null
    endfunction
    
    private function OnItemEnum takes nothing returns nothing
        local integer itemIndex = GetItemIndexEx(GetEnumItem())
        if GetWidgetLife(GetEnumItem()) > 0 and itemIndex != Item_AegisOfTheImmortal then
            if Mode__DeathMatch then
                call SpiritBearDropItemInDeathMatch()
            else
                call AddSpiritBearItemToItemHolder()
            endif
        endif
    endfunction
    function SpiritBearOnDeath takes unit killingUnit, unit dyingUnit returns nothing
        local location l           = GetUnitLoc(dyingUnit)
        local rect     r           = RectFromCenterSizeBJ(l, 400., 400.)
        local unit     spiritBear  = dyingUnit
        local unit     sourceUnit  = GetUnitSummonSource(spiritBear)
        local integer  level       = GetUnitAbilityLevel(spiritBear, 'A0A5')
        local player   whichPlayer = GetOwningPlayer(spiritBear)
        local unit     itemHolder  
        local real     x
        local real     y
        
        call SetHeroXP(sourceUnit, GetHeroXP(sourceUnit)-(GetHeroXP(sourceUnit)/(125 -(25 * level))), false)
        call UnitDamageTargetEx(killingUnit, sourceUnit, 5, 100. * I2R(level))

        if not Mode__DeathMatch then
            // 同步额外物品
            set itemHolder = GetPlayerSpiritBearItemHolder(whichPlayer)
            if itemHolder == null then
                if IsPlayerSentinel(GetOwningPlayer(spiritBear)) then
                    set x = -6390
                    set y = -5615
                else
                    set x = 5875
                    set y = 5000
                endif
                set itemHolder = CreateUnit(GetOwningPlayer(GetTriggerUnit()), 'e01F', x, y, 0)
                set Table[GetHandleId(whichPlayer)].unit[PLAYER_SPIRIT_BEAR_ITEM_HOLD] = itemHolder
                call UnitAddTownPortalScrollAbility(itemHolder)
            endif
            // 银月
            if GetUnitAbilityLevel(spiritBear, 'A398') > 0 then
                call UnitAddPermanentAbility(itemHolder, 'A398')
            endif
            // 回城卷轴
            call SetUnitTownPortalScrollCharges(itemHolder, GetUnitTownPortalScrollCharges(spiritBear))
            call SetUnitTownPortalScrollCooldown(itemHolder, GetUnitTownPortalScrollCooldown(spiritBear))
            
            // 选取物品
            call EnumItemsInRect(r, null, function OnItemEnum)
            call RemoveLocation(l)
            call RemoveRect(r)
        else
            // 死亡竞赛 把银月和tp吐出来

        endif

        set l = null
        set r = null
        set spiritBear = null
        set itemHolder = null
    endfunction
    private function OnDeath takes unit killingUnit, unit dyingUnit returns nothing
        local unit spiritBear
        if IsUnitSpiritBear(dyingUnit) then
            // 还需要继承tp冷却时间
            call SpiritBearOnDeath(killingUnit, dyingUnit)
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
        call OnDeath(UEKillingUnit, UEDyingUnit)
    endfunction
    function SummonSpiritBearOnInitializer takes nothing returns nothing
        call RegisterUnitDeathMethod("SummonSpiritBearOnDeath")
    endfunction

    function SpiritBearReturnDisableOnUpdate takes nothing returns boolean
        local trigger trig       = GetTriggeringTrigger()
        local integer h          = GetHandleId(trig)
        local unit    spiritBear = LoadUnitHandle(HY, h, 2)
        local real    time
        if GetTriggerEventId() == EVENT_UNIT_DEATH then
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(trig)
        elseif GetTriggerEventId() == EVENT_UNIT_DAMAGED then
            if GetEventDamage() > 2 and GetEventDamageSource()!= GetTriggerUnit() and IsPlayerValid(GetOwningPlayer(GetEventDamageSource())) then
                if GetUnitAbilityCooldownRemaining(spiritBear, 'A0A7') < 3.0 then
                    call SetUnitAbilityCooldownAbsolute(spiritBear, 'A0A7', 3.)
                endif
            endif
        endif
        set trig       = null
        set spiritBear = null
        return false
    endfunction
    private function CreateSpiritBearReturnDisableTrig takes unit spiritBear returns nothing
        local trigger trig = CreateTrigger()
        local integer h = GetHandleId(trig)
        call TriggerRegisterTimerEvent(trig, .2, true)
        call TriggerRegisterUnitEvent(trig, spiritBear, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(trig, spiritBear, EVENT_UNIT_DEATH)
        call TriggerAddCondition(trig, Condition(function SpiritBearReturnDisableOnUpdate))
        call SaveUnitHandle(HY, h, 2, spiritBear)
        call SaveReal(HY, h, 785, .0)
        call SaveInteger(HY, h, 34, 1)
        // call SetUnitAbilityCastpoint(spiritBear, 'A0A7', 3.)
        set trig = null
    endfunction

    private function ReturnOnSpell takes nothing returns nothing
        local unit spiritBear
        local unit sourceUnit
        if GetSpellAbilityId() == 'A0A7' then
            set spiritBear = GetTriggerUnit()
            set sourceUnit = GetUnitSummonSource(spiritBear)
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl", GetUnitX(spiritBear), GetUnitY(spiritBear)))
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl", GetUnitX(sourceUnit), GetUnitY(sourceUnit)))
            call SetUnitX(spiritBear, GetUnitX(sourceUnit) + GetRandomReal(25, 50)* Cos(GetRandomReal(0, 360)))
            call SetUnitY(spiritBear, GetUnitY(sourceUnit) + GetRandomReal(25, 50)* Sin(GetRandomReal(0, 360)))
            call DelayImmediateOrderById(spiritBear, 851972, 0)
        endif
        set spiritBear = null
        set sourceUnit = null
    endfunction
    
    function LoneDruidSummonSpiritBear_Init takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerRegisterAnyUnitEvent(trig, EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(trig, Condition(function ReturnOnSpell))
        set trig = null
    endfunction

    function SetSpiritBearBattleRoarLevel takes unit spiritBear, integer level, player p, boolean registerSpellEffectEvent returns nothing
        if level == 0 then
            return
        endif
        call UnitAddPermanentAbility(spiritBear, 'A34C')
        call SetUnitAbilityLevel(spiritBear, 'A34C', level)
        if registerSpellEffectEvent then
            call TriggerRegisterUnitEvent(UnitEventMainTrig, spiritBear, EVENT_UNIT_SPELL_EFFECT)
        endif
    endfunction

    function SummonSpiritBearOnLearn takes nothing returns nothing
        local unit    whichUnit    = GetTriggerUnit()
        local player  whichiPlayer = GetOwningPlayer(whichUnit)
        local integer level        = GetUnitAbilityLevel(whichUnit, 'A0A5')
        local unit    spiritBear

        call SetPlayerTechResearched(whichiPlayer, 'R000', level)
        if level > 1 then
            set spiritBear = GetUnitSummonedSpiritBear(whichUnit)
            if spiritBear != null then
                call AddSpecialEffectTarget("Abilities\\Spells\\Orc\\FeralSpirit\\feralspiritdone.mdl", spiritBear, "chest")
                if (level == 2) then
                    call UnitAddMaxLife(spiritBear, 400)
                    call UnitAddPermanentAbility(spiritBear, 'A0A7')
                    call CreateSpiritBearReturnDisableTrig(spiritBear)
                elseif (level == 3) then
                    call UnitAddMaxLife(spiritBear, 500)
                    call UnitAddPermanentAbility(spiritBear, 'A33C')
                elseif (level == 4) then
                    call UnitAddMaxLife(spiritBear, 400)
                    call UnitAddPermanentAbility(spiritBear, 'A03A')
                    call UnitAddPermanentAbility(spiritBear, 'A0AH')
                endif
                call SetSpiritBearBattleRoarLevel(spiritBear, level -1, whichiPlayer, true)
            endif
        endif
        set whichUnit  = null
        set spiritBear = null
    endfunction

    // LastSpiritBearInheritItem
    private function LastSpiritBearInheritItem takes unit spiritBear returns nothing
        local integer h          = GetHandleId(GetOwningPlayer(spiritBear))
        local unit    itemHolder = LoadUnitHandle(HY, h, 334)
        if itemHolder != null and not Mode__DeathMatch  then
            call UnitAddItem(spiritBear, UnitRemoveItemFromSlot(itemHolder, 0))
            call UnitAddItem(spiritBear, UnitRemoveItemFromSlot(itemHolder, 1))
            call UnitAddItem(spiritBear, UnitRemoveItemFromSlot(itemHolder, 2))
            call UnitAddItem(spiritBear, UnitRemoveItemFromSlot(itemHolder, 3))
            call UnitAddItem(spiritBear, UnitRemoveItemFromSlot(itemHolder, 4))
            call UnitAddItem(spiritBear, UnitRemoveItemFromSlot(itemHolder, 5))
            // 银月
            if GetUnitAbilityLevel(itemHolder, 'A398') > 0 then
                call UnitAddPermanentAbility(spiritBear, 'A398')
            endif
            // 回城卷轴
            call SetUnitTownPortalScrollCharges(spiritBear, GetUnitTownPortalScrollCharges(itemHolder))
            call SetUnitTownPortalScrollCooldown(spiritBear, GetUnitTownPortalScrollCooldown(itemHolder))
        endif
        set itemHolder = null
    endfunction

    function R6I takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer h = GetHandleId(t)
        local unit spiritBear = LoadUnitHandle(HY, h, 0)
        local unit sourceUnit = GetUnitSummonSource(spiritBear)
        if not IsUnitAlive(spiritBear) then
            call PauseTimer(t)
            call DestroyTimer(t)
            call FlushChildHashtable(HY, h)
        else
            if not IsUnitInRange(spiritBear, sourceUnit, 1100) and not IsUnitScepterUpgraded(sourceUnit) then
                if UnitAddPermanentAbility(spiritBear, 'A44E') then
                    call UnitIncDisableAttackCount(spiritBear)
                endif
            elseif GetUnitAbilityLevel(spiritBear, 'A44E') > 0 then
                if UnitRemoveAbility(spiritBear, 'A44E') then
                    call UnitDecDisableAttackCount(spiritBear)
                endif
            endif
        endif
        set sourceUnit = null
        set spiritBear = null
        set t = null
    endfunction
    // 
    function SpiritBearDisableAttackTrig takes unit spiritBear returns nothing
        local timer t = CreateTimer()
        local integer h = GetHandleId(t)
        call TimerStart(t, .2, true, function R6I)
        call SaveUnitHandle(HY, h, 0, spiritBear)
        call SaveUnitHandle(HY, h, 1, PlayerHeroes[GetPlayerId(GetOwningPlayer(spiritBear))])
        set t = null
    endfunction

    function SummonSpiritBearOnSpellEffectBear takes nothing returns nothing
        local unit    whichUnit = GetTriggerUnit()
        local player  p         = GetOwningPlayer(whichUnit)
        local real    x         = GetUnitX(whichUnit)
        local real    y         = GetUnitY(whichUnit)
        local group   g         
        local integer level     = GetUnitAbilityLevel(whichUnit, 'A0A5')
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
            call SetSpiritBearBattleRoarLevel(lastSpiritBear, level -1, p, true)
            call UnitAddTownPortalScrollAbility(lastSpiritBear)
            call SaveUnitHandle(HY, h, 333, lastSpiritBear)
            call LastSpiritBearInheritItem(lastSpiritBear)
            call AddSpecialEffectTarget("Abilities\\Spells\\Orc\\FeralSpirit\\feralspiritdone.mdl", lastSpiritBear, "chest")
            call CreateSpiritBearReturnDisableTrig(lastSpiritBear)
            call SetUnitAbilityLevel(lastSpiritBear, 'A09Y', level)
            call SpiritBearDisableAttackTrig(lastSpiritBear)
        else
            call AddSpecialEffectTarget("Abilities\\Spells\\Orc\\FeralSpirit\\feralspiritdone.mdl", lastSpiritBear, "chest")
            call SetWidgetLife(lastSpiritBear, GetUnitState(lastSpiritBear, UNIT_STATE_MAX_LIFE))
            call SetUnitPosition(lastSpiritBear, GetUnitX(whichUnit), GetUnitY(whichUnit))
        endif
        // 协同 
        if GetUnitAbilityLevel(whichUnit, 'A0A8') > 0 then
            // 是否会覆盖鞋子移速？
            call SetUnitMoveSpeed(lastSpiritBear, GetUnitDefaultMoveSpeed(lastSpiritBear) + 8 * GetUnitAbilityLevel(whichUnit, 'A0A8'))
            
            if GetUnitAbilityLevel(lastSpiritBear, 'A3IL') == 0 then
                call UnitAddPermanentAbility(lastSpiritBear, 'A3IL')
            endif
            call SetUnitAbilityLevel(lastSpiritBear, 'A3IL', GetUnitAbilityLevel(whichUnit, 'A0A8'))
        endif
        set lastSpiritBear = null
        set whichUnit = null
        set g = null
    endfunction

endscope
