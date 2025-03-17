scope Doom

    globals
        constant integer HERO_INDEX_DOOM = 64
    endglobals
    //***************************************************************************
    //*
    //*  吞噬
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_DEVOUR = GetHeroSKillIndexBySlot(HERO_INDEX_DOOM, 1)

        // 闪电链
        constant integer CREEPS_CHAIN_LIGHTNING_ABILITY_ID = 'A1OQ'
        // 冰甲
        constant integer CREEPS_ICE_ARMOR_ABILITY_ID       = 'A1OR'
        // 雷霆一击
        constant integer CREEPS_THUNDER_CLAP_ABILITY_ID    = 'A1OS'
        // 法力燃烧
        constant integer CREEPS_MANA_BURN_ABILITY_ID       = 'A1OT'
        // 净化
        constant integer CREEPS_PURGE_ABILITY_ID           = 'A1OU'
        // 震荡波
        constant integer CREEPS_SHOCKWAVE_ABILITY_ID       = 'A1OV'
        // 医疗
        constant integer CREEPS_HEAL_ABILITY_ID            = 'A1OZ'
        // 战争践踏
        constant integer CREEPS_WAR_STOMP_ABILITY_ID       = 'A1P0'
        // 飓风
        constant integer CREEPS_HURRICANE_ABILITY_ID       = 'A1P4'
        // 复活死尸
        constant integer CREEPS_RAISE_DEAD_ABILITY_ID      = 'A1P5'
        // 诱捕
        constant integer CREEPS_ENSNARE_ABILITY_ID         = 'A1P6'
        // 投石
        constant integer CREEPS_HURL_BOULDER_ABILITY_ID    = 'A36K'
    endglobals

    function T_E takes nothing returns nothing
        local unit u = TempUnit
        local integer hu = GetHandleId(u)
        local integer abilId1 = LoadInteger(OtherHashTable, hu,'DEVR'+ 0)
        local integer abilId2 = LoadInteger(OtherHashTable, hu,'DEVR'+ 1)
        local boolean isPassive1 = LoadBoolean(OtherHashTable, hu,'DEVR'+ 0)
        local boolean isPassive2 = LoadBoolean(OtherHashTable, hu,'DEVR'+ 1)
        if isPassive1 == false then
            call UnitRemoveAbility(u, abilId1)
            call UnitAddPermanentAbility(u, abilId1)
        endif
        if isPassive2 == false then
            call UnitRemoveAbility(u, abilId2)
            call UnitAddPermanentAbility(u, abilId2)
        endif
        set u = null
    endfunction
    function WEI takes unit u returns nothing
        call UnitRemoveAbility(u, LoadInteger(OtherHashTable, GetHandleId(u),'DEVR'+ 0))
        call UnitRemoveAbility(u, LoadInteger(OtherHashTable, GetHandleId(u),'DEVR'+ 1))
        call RemoveSavedInteger(OtherHashTable, GetHandleId(u),'DEVR'+ 0)
        call RemoveSavedInteger(OtherHashTable, GetHandleId(u),'DEVR'+ 1)
        call RemoveSavedBoolean(OtherHashTable, GetHandleId(u),'DEVR'+ 0)
        call RemoveSavedBoolean(OtherHashTable, GetHandleId(u),'DEVR'+ 1)
    endfunction
    function WXI takes unit u, integer unitTypeId returns nothing
        local integer abilId1 = 0
        local integer abilId2 = 0
        local boolean isPassive1 = false
        local boolean isPassive2 = false
        local integer passiveId1 = 0
        local integer passiveId2 = 0
        local integer hu = GetHandleId(u)
        if unitTypeId == 'n0HX' then
            // 蓝鸟 
            set abilId1 = CREEPS_CHAIN_LIGHTNING_ABILITY_ID
        elseif unitTypeId == 'nomg' then
            // 蓝胖 
            set abilId1 = CREEPS_ICE_ARMOR_ABILITY_ID
        elseif unitTypeId == 'nfpu' then
            // 极地熊怪乌尔萨战士 
            set abilId1 = CREEPS_THUNDER_CLAP_ABILITY_ID
            set abilId2 = 'QDP3'
            set isPassive2 = true
            set passiveId2 = 'S00N'
        elseif unitTypeId == 'nstl' then
            // 萨特窃魂者 抽蓝 
            set abilId1 = CREEPS_MANA_BURN_ABILITY_ID
        elseif unitTypeId == 'nsat' then
            // 萨特欺诈者 净化 
            set abilId1 = CREEPS_PURGE_ABILITY_ID
        elseif unitTypeId == 'nsth' then
            // 萨特地狱使者 波加光环 
            set abilId1 =  CREEPS_SHOCKWAVE_ABILITY_ID
            set abilId2 = 'QDP0'
            set isPassive2 = true
            set passiveId2 = 'A1OW'
        elseif unitTypeId == 'n00S' then
            // 头狼
            set abilId1 = 'QDP6'
            set passiveId1 = 'A1OX'
            set isPassive1 = true
            set passiveId2 = 'A1OY'
        elseif unitTypeId == 'nkol' then
            // 狗头人工头
            set abilId1 = 'QDP1'
            set passiveId1 = 'S00M'
            set isPassive1 = true
        elseif unitTypeId == 'nfsh' then
            // 森林巨魔牧师 回蓝和加血 
            set abilId1 = CREEPS_HEAL_ABILITY_ID
            set abilId2 = 'QDP2'
            set passiveId2 = 'A2AG'
            set isPassive2 = true
        elseif unitTypeId == 'ncnk' then
            // 半人马可汗 
            set abilId1 = CREEPS_WAR_STOMP_ABILITY_ID
        elseif unitTypeId == 'ngns' then
            // 豺狼刺客
            set abilId1 = 'QDP4'
            set passiveId1 = 'A1P1'
            set isPassive1 = true
        elseif unitTypeId == 'ngh1' then
            // 鬼魂
            set abilId1 = 'QDP7'
            set passiveId1 = 'A1P7'
            set isPassive1 = true
            set passiveId2 = 'A1PA'
        elseif unitTypeId == 'nowe' then
            // 暴怒的枭兽 
            set abilId1 = 'QDP5'
            set passiveId1 = 'A1P3'
            set isPassive1 = true
            set abilId2 =  CREEPS_HURRICANE_ABILITY_ID
        elseif unitTypeId == 'ndtw' then
            // 黑暗巨魔首领 
            set abilId1 =  CREEPS_RAISE_DEAD_ABILITY_ID
            set abilId2 =  CREEPS_ENSNARE_ABILITY_ID
        elseif unitTypeId == 'nwlg' then
            // 巨狼
            set abilId1 = 'QDP8'
            set passiveId1 = 'A1OY'
            set isPassive1 = true
        elseif unitTypeId == 'n026' then
            // 泥土傀儡 
            set abilId1 = CREEPS_HURL_BOULDER_ABILITY_ID
            set abilId2 = 'A36J'
        elseif unitTypeId == 'n127' then
            // 碎片傀儡
            set abilId1 = CREEPS_HURL_BOULDER_ABILITY_ID
        endif
        if abilId1 != 0 and(LoadInteger(OtherHashTable, hu,'DEVR'+ 0) != abilId1 or LoadInteger(OtherHashTable, hu,'DEVR'+ 1) != abilId2) then
            call WEI(u)
            call UnitAddPermanentAbility(u, abilId1)
            if isPassive1 then
                call SetPlayerAbilityAvailable(GetOwningPlayer(u), abilId1, false)
                call UnitMakeAbilityPermanent(u, true, passiveId1)
                call UnitMakeAbilityPermanent(u, true, passiveId2)
            endif
            if abilId2 != 0 then
                call UnitAddPermanentAbility(u, abilId2)
                if isPassive2 then
                    call SetPlayerAbilityAvailable(GetOwningPlayer(u), abilId2, false)
                    call UnitMakeAbilityPermanent(u, true, passiveId1)
                    call UnitMakeAbilityPermanent(u, true, passiveId2)
                endif
            endif
            call SaveInteger(OtherHashTable, hu,'DEVR'+ 0, abilId1)
            call SaveBoolean(OtherHashTable, hu,'DEVR'+ 0, isPassive1)
            call SaveInteger(OtherHashTable, hu,'DEVR'+ 1, abilId2)
            call SaveBoolean(OtherHashTable, hu,'DEVR'+ 1, isPassive2)
        endif
    endfunction
    private function GetDevourProgressText takes real r returns string
        local string c1 = "|c00ff0303"
        local string c = "||"
        local string p = " "
        local string s = c1 + c + "|r"
        local string result
        if r > 85 then
            set result = s + p + s + p + s + p + s + p + s + p + s + p + s
        elseif r > 70 then
            set result = s + p + s + p + s + p + s + p + s + p + s + p + c
        elseif r > 55 then
            set result = s + p + s + p + s + p + s + p + s + p + c + p + c
        elseif r > 40 then
            set result = s + p + s + p + s + p + s + p + c + p + c + p + c
        elseif r > 25 then
            set result = s + p + s + p + s + p + c + p + c + p + c + p + c
        elseif r > 10 then
            set result = s + p + s + p + c + p + c + p + c + p + c + p + c
        elseif r > 0 then
            set result = s + p + c + p + c + p + c + p + c + p + c + p + c
        else
            set result = c + p + c + p + c + p + c + p + c + p + c + p + c
        endif
        return result
    endfunction
    function WAI takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit trigUnit =(LoadUnitHandle(HY, h, 14))
        local integer level =(LoadInteger(HY, h, 5))
        local real HP =(LoadReal(HY, h, 232))
        local texttag tt =(LoadTextTagHandle(HY, h, 231))
        local integer count = GetTriggerEvalCount(t)
        local real WNI = RMaxBJ(HP -count, 0)
        call SetTextTagText(tt, GetDevourProgressText( 100 * WNI / HP), .018)
        call SetTextTagPosUnit(tt, trigUnit, 0)
        call SetTextTagVisibility(tt, IsUnitVisibleToPlayer(trigUnit, LocalPlayer) or IsPlayerObserverEx(LocalPlayer))
        if WNI == 0 then
            call PlayerAddUnitUnreliableGold(GetOwningPlayer(trigUnit), trigUnit, 25 * level)
        endif
        if WNI == 0 or GetTriggerEventId() == EVENT_WIDGET_DEATH then
            call SetPlayerAbilityAvailableEx(GetOwningPlayer(trigUnit),'A10R', true)
            call UnitRemoveAbility(trigUnit,'A10S')
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            call DestroyTextTag(tt)
        endif
        set t = null
        set trigUnit = null
        set tt = null
        return false
    endfunction
    function DoomDevourOnSpellEffect takes nothing returns nothing
        local unit trigUnit = GetTriggerUnit()
        local unit targetUnit = GetSpellTargetUnit()
        local integer level = GetUnitAbilityLevel(trigUnit,'A10R')
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local real HP = GetWidgetLife(targetUnit)
        local texttag tt = CreateTextTag()
        local unit dummyCaster = CreateUnit(GetOwningPlayer(trigUnit),'e00E', 0, 0, 0)
        call ALX("SPLK", GetUnitX(trigUnit), GetUnitY(trigUnit), GetUnitX(targetUnit), GetUnitY(targetUnit), .1, .1, .2, .9, .5)
        call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\Devour\\DevourEffectArt.mdl", GetUnitX(targetUnit), GetUnitY(targetUnit)))
        call SetTextTagText(tt, GetDevourProgressText( 100 ), .018)
        call SetTextTagPosUnit(tt, trigUnit, 0)
        call SetTextTagVisibility(tt, IsUnitVisibleToPlayer(trigUnit, LocalPlayer))
        call SetTextTagPermanent(tt, true)
        call SetPlayerAbilityAvailableEx(GetOwningPlayer(trigUnit),'A10R', false)
        call UnitAddPermanentAbility(trigUnit,'A10S')
        call SaveUnitHandle(HY, h, 14,(trigUnit))
        call SaveTextTagHandle(HY, h, 231,(tt))
        call SaveInteger(HY, h, 5,(level))
        call SaveReal(HY, h, 232,((HP)* 1.))
        call TriggerRegisterTimerEvent(t, .05, true)
        call TriggerRegisterDeathEvent(t, trigUnit)
        call TriggerAddCondition(t, Condition(function WAI))
        call WXI(trigUnit, GetUnitTypeId(targetUnit))
        if IsUnitType(targetUnit, UNIT_TYPE_SUMMONED) == false then
            call UnitRemoveBuffs(targetUnit, true, true)
        endif
        call UnitRemoveAbility(targetUnit,'Aetl')
        call UnitDamageTargetEx(dummyCaster, targetUnit, 4, 100000000)
        call ShowUnit(targetUnit, false)
        set t = null
        set trigUnit = null
        set targetUnit = null
        set tt = null
        set dummyCaster = null
    endfunction

    function DoomDevourOnLearn takes nothing returns nothing
        call UnitAddPermanentAbility(GetTriggerUnit(),'A10R')
        call SetUnitAbilityLevel(GetTriggerUnit(),'A10R', GetUnitAbilityLevel(GetTriggerUnit(),'A32Z'))
    endfunction
endscope
