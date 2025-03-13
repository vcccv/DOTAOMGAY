
scope Alchemist

    globals
        constant integer HERO_INDEX_ALCHEMIST = 39
    endglobals
    //***************************************************************************
    //*
    //*  不稳定化合物
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_UNSTABLE_CONCOCTION = GetHeroSKillIndexBySlot(HERO_INDEX_ALCHEMIST, 2)
    endglobals

    function D9R takes nothing returns boolean
        local unit t = GetFilterUnit()
        if IsUnitEnemy(Temp__ArrayUnit[0], GetOwningPlayer(t)) and IsAliveNotStrucNotWard(t) then
            if Temp__ArrayReal[4]== 1 and GetUnitAbilityLevel(t,'A3E9') == 1 and IsUnitMagicImmune(Temp__ArrayUnit[1]) == false then
                call SaveInteger(OtherHashTable2,'A3E9','0lvl', R2I(Temp__ArrayReal[2]))
                call SaveUnitHandle(OtherHashTable2,'A3E9','targ', Temp__ArrayUnit[1])
                call SaveUnitHandle(OtherHashTable2,'A3E9','cstr', t)
                call SaveReal(OtherHashTable2,'A3E9','0dur', Temp__ArrayReal[3])
                call ExecuteFunc("FVR")
            endif
            if UnitHasSpellShield(t) == false then
                call UnitDamageTargetEx(Temp__ArrayUnit[0], t, 2, Temp__ArrayReal[0])
                call CommonUnitAddStun(t, Temp__ArrayReal[1], false)
            else
                call UnitRemoveSpellShield(t)
            endif
        endif
        set t = null
        return false
    endfunction
    function FER takes unit u, real WLV, real x, real y, boolean b, integer abilLevel, boolean FXR returns nothing
        set Temp__ArrayReal[3] = WLV
        set WLV = WLV / 5.
        set Temp__ArrayReal[0]=(60 + 70 * abilLevel)* WLV
        set Temp__ArrayReal[1]=(1 + .75 * abilLevel)* WLV
        set Temp__ArrayReal[2] = abilLevel
        set Temp__ArrayReal[4] = 0
        set Temp__ArrayUnit[0] = I_X(u)
        set Temp__ArrayUnit[1] = u
        if FXR then
            set Temp__ArrayReal[4] = 1
        endif
        call GroupEnumUnitsInRange(AK, x, y, 200, Condition(function D9R))
        call DestroyEffect(AddSpecialEffect("Abilities\\Weapons\\DemolisherFireMissile\\DemolisherFireMissile.mdl", x, y))
        if b then
            call UnitDamageTargetEx(Temp__ArrayUnit[0], u, 2, Temp__ArrayReal[0])
            call CommonUnitAddStun(u, Temp__ArrayReal[1], false)
        endif
    endfunction
    function FOR takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = LoadUnitHandle(HY, h, 2)
        local unit targetUnit = LoadUnitHandle(HY, h, 17)
        local unit missileDummy = LoadUnitHandle(HY, h, 45)
        local real SAX = LoadReal(HY, h, 444)
        local real a = AngleBetweenXY(GetUnitX(missileDummy), GetUnitY(missileDummy), GetUnitX(targetUnit), GetUnitY(targetUnit))
        local real x = GetUnitX(missileDummy) + 18 * Cos(a * bj_DEGTORAD)
        local real y = GetUnitY(missileDummy) + 18 * Sin(a * bj_DEGTORAD)
        local integer level = LoadInteger(HY, h, 0)
        call SetUnitX(missileDummy, x)
        call SetUnitY(missileDummy, y)
        if GetDistanceBetween(x, y, GetUnitX(targetUnit), GetUnitY(targetUnit))<= 18 or(GetUnitX(targetUnit) == 0 and GetUnitY(targetUnit) == 0) then
            call KillUnit(missileDummy)
            call FER(whichUnit, SAX, x, y, false, level, LoadBoolean(HY, h, 0))
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        endif
        set t = null
        set whichUnit = null
        set targetUnit = null
        set missileDummy = null
        return false
    endfunction
    function FRR takes unit Q4X, unit to, real FIR, integer level, boolean FAR returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit missileDummy = CreateUnit(GetOwningPlayer(Q4X),'h0BD', GetUnitX(Q4X), GetUnitY(Q4X), GetUnitFacing(Q4X))
        call SaveUnitHandle(HY, h, 2, Q4X)
        call SaveUnitHandle(HY, h, 17, to)
        call SaveUnitHandle(HY, h, 45, missileDummy)
        call SaveReal(HY, h, 444, FIR * 1.)
        call SaveInteger(HY, h, 0, level)
        call SaveBoolean(HY, h, 0, FAR)
        call TriggerRegisterTimerEvent(t, .02, true)
        call TriggerAddCondition(t, Condition(function FOR))
        set missileDummy = null
        set t = null
    endfunction
    function FVR takes nothing returns nothing
        local unit whichUnit = LoadUnitHandle(OtherHashTable2,'A3E9','cstr')
        local unit targetUnit = LoadUnitHandle(OtherHashTable2,'A3E9','targ')
        local real FNR = LoadReal(OtherHashTable2,'A3E9','0dur')
        local integer level = LoadInteger(OtherHashTable2,'A3E9','0lvl')
        call FRR(whichUnit, targetUnit, FNR, level, true)
        call T4V(whichUnit)
        call FlushChildHashtable(OtherHashTable2,'A3E9')
        set whichUnit = null
        set targetUnit = null
    endfunction
    function FBR takes string s, unit targetUnit, unit trigUnit returns nothing
        local texttag tt = CreateTextTag()
        call SetTextTagPosUnit(tt, targetUnit, 64)
        call SetTextTagColor(tt, 255, 0, 0, 255)
        call SetTextTagVelocity(tt, 0, .0355)
        call SetTextTagFadepoint(tt, .15)
        call SetTextTagPermanent(tt, false)
        call SetTextTagLifespan(tt, .65)
        if (IsUnitAlly(trigUnit, LocalPlayer) or IsPlayerObserverEx(LocalPlayer)) == false then
            set s = ""
        endif
        call SetTextTagText(tt, s, .033)
        call SetTextTagVisibility(tt, true)
        set tt = null
    endfunction
    function FCR takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = LoadUnitHandle(HY, h, 2)
        local real FDR = LoadReal(HY, h, 442)
        local real KGX = GetGameTime()
        local real Y2X = 5. -(KGX -FDR)
        local real time = RMinBJ(KGX -FDR, 5.)
        local integer count = LoadInteger(HY, h, 34) + 1
        local integer i
        local string s
        local integer level = LoadInteger(HY, h, 0)
        if GetTriggerEventId() == EVENT_WIDGET_DEATH then
            call ToggleSkill.SetState(whichUnit, 'A1NI', false)
            
            call ResetUnitVertexColor(whichUnit)
            call DestroyEffect(LoadEffectHandle(HY, h, 32))
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        elseif GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
            if GetSpellAbilityId()=='A1NH' then
                call FRR(whichUnit, GetSpellTargetUnit(), time, level, false)
           
                call ToggleSkill.SetState(whichUnit, 'A1NI', false)

                call ResetUnitVertexColor(whichUnit)
                call DestroyEffect(LoadEffectHandle(HY, h, 32))
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
            endif
        else
            call SaveInteger(HY, h, 34, count)
            if Y2X >= 0 then
                set i = R2I(Y2X)
                set s = I2S(i)
                if Y2X -i >= .5 then
                    set s = s + ".5"
                else
                    set s = s + ".0"
                endif
                set i = ModuloInteger(count, 2)* 75
                call FBR(s, whichUnit, whichUnit)
                call SetUnitVertexColorEx(whichUnit, 255, 100 + i, 100 + i,-1)
            else
                call SetUnitVertexColorEx(whichUnit, 255, 0, 0,-1)
            endif
            if KGX -FDR >(5. + .5) then
                call FER(whichUnit, 5., GetWidgetX(whichUnit), GetWidgetY(whichUnit), true, level, true)

                call ToggleSkill.SetState(whichUnit, 'A1NI', false)
                call ResetUnitVertexColor(whichUnit)
                call DestroyEffect(LoadEffectHandle(HY, h, 32))
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
            endif
        endif
        set t = null
        set whichUnit = null
        return false
    endfunction
    function UnstableConcoctionOnSpellEffect takes nothing returns nothing
        local unit whichUnit = GetTriggerUnit()
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local string s = "war3mapImported\\UnstableConcoctionRangeDisplay3.mdx"
        if LocalPlayer!= GetOwningPlayer(whichUnit) then
            set s = ""
        endif
        call SaveUnitHandle(HY, h, 2, whichUnit)
        call SaveReal(HY, h, 442, GetGameTime())
        call SaveInteger(HY, h, 0, GetUnitAbilityLevel(whichUnit,'A1NI'))
        call SaveEffectHandle(HY, h, 32, AddSpecialEffectTarget(s, whichUnit, "origin"))
        call TriggerRegisterTimerEvent(t, .5, true)
        call TriggerRegisterUnitEvent(t, whichUnit, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterDeathEvent(t, whichUnit)
        call TriggerAddCondition(t, Condition(function FCR))
        // call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A1NI', false)
        // call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A1NH', true)
        // call UnitAddPermanentAbility(whichUnit,'A1NH')

        call SetUnitAbilityLevel(whichUnit, 'A1NH', GetUnitAbilityLevel(whichUnit, 'A1NI'))
        call ToggleSkill.SetState(whichUnit, 'A1NI', true)

        call TriggerEvaluate(t)
        set whichUnit = null
        set t = null
    endfunction
    //***************************************************************************
    //*
    //*  神杖合成
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_GOBLIN_GREED = GetHeroSKillIndexBySlot(HERO_INDEX_ALCHEMIST, 3)
    endglobals
    // 不包含地精贪婪版本
    private function IsItemNormalAghanimScepter takes item it returns boolean
        local integer id = GetItemTypeId(it)
        if id == ItemRealId[Item_AghanimScepter] /*
        */ or id == ItemRealId[Item_AghanimScepterBasic] then
            return true
        endif
        return false
    endfunction

    function AghanimScepterSynthOnSpellEffect takes nothing returns nothing
        local unit    targetUnit = GetSpellTargetUnit()
        local unit    whichUnit  = GetTriggerUnit()
        local integer i
        local player  targetPlayer
        local integer pid
        local integer goldCost
        local item    it
        //set bj_playerIsCrippled[0] = false
        if IsUnitType(targetUnit, UNIT_TYPE_HERO) and not IsHeroDummy(targetUnit) and not IsUnitAghanimGifted(targetUnit) then

            set targetPlayer = GetOwningPlayer(targetUnit)
            set pid = GetPlayerId(targetPlayer)
            if targetUnit != whichUnit then
                set i = 0
                loop
                exitwhen i > 5
                    // 
                    set it = UnitItemInSlot(targetUnit, i)
                    if IsItemNormalAghanimScepter(it) then
                        set goldCost = GetItemGoldCostById(GetItemTypeId(it))
                        set PlayerExtraNetWorth[pid] = PlayerExtraNetWorth[pid] + goldCost
                        call RemoveItem(it)
                        call DisplayTimedTextToPlayer(targetPlayer, 0, 0, 5, /*
                        */ GetPlayerName(GetOwningPlayer(whichUnit)) + "给予了你阿哈利姆福佑，现在销毁神杖并退还|cfffffa00" + I2S(goldCost)+ "|r 金钱。")
		                //call SetPlayerState(targetPlayer, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(targetPlayer, PLAYER_STATE_RESOURCE_GOLD) + goldCost)
                        
                        call PlayerAddUnitUnreliableGold(targetPlayer, targetUnit, goldCost)
                    endif
                    set i = i + 1
                endloop
                set it = null
                if IsUnitAghanimBlessed(targetUnit) then
                    // 仅退款
                    set goldCost = GetItemGoldCostById(ItemRealId[Item_AghanimBlessing])
                    set PlayerExtraNetWorth[pid] = PlayerExtraNetWorth[pid] + goldCost
                    call DisplayTimedTextToPlayer(targetPlayer, 0, 0, 5, /*
                    */ GetPlayerName(GetOwningPlayer(whichUnit)) + "给予了你阿哈利姆福佑，现在退还之前升级消耗的|cfffffa00" + I2S(goldCost)+ "|r 金钱。")
                    
                    call PlayerAddUnitUnreliableGold(targetPlayer, targetUnit, goldCost)
                endif
            endif

            call UnitAddAghanimGiftable(targetUnit)

            call SilentRemoveItem(GetAbilitySourceItem(GetSpellAbility()))
            // if GetOwningPlayer(targetUnit) != GetOwningPlayer(whichUnit) then
            //     set PlayerExtraNetWorth[GetPlayerId(GetOwningPlayer(whichUnit))] = PlayerExtraNetWorth[GetPlayerId(GetOwningPlayer(whichUnit))] + GetItemGoldCostById(ItemRealId[Item_AghanimScepterBasic])
            // endif
            // PlayerExtraNetWorth = 净资产

            set PlayerItemTotalGoldCostDirty[pid] = true
            set PlayerItemTotalGoldCostDirty[GetPlayerId(GetOwningPlayer(whichUnit))] = true


            //set bj_playerIsCrippled[0] = true
        endif
        set whichUnit  = null
        set targetUnit = null
    endfunction

endscope
