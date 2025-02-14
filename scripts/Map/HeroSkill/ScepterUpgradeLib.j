
library ScepterUpgradeLib requires HeroSkillLib
    
    //***************************************************************************
    //*
    //*  神杖升级
    //*
    //***************************************************************************
    globals
        // 工程升级 用来转变技能
        integer array ScepterUpgrade_ModifyId
        integer array ScepterUpgrade_BaseId
        integer array ScepterUpgrade_UpgradedId
        integer array ScepterUpgrade_UnknownId
        integer ScepterUpgradeMaxCount = 0
    endglobals

    // 获得技能的阿哈利姆神杖升级索引 没有神杖升级就是返回 0 
    function GetSkillScepterUpgradeIndexById takes integer id returns integer
        local integer i = 1
        loop
        exitwhen i > ScepterUpgradeMaxCount
            if id == ScepterUpgrade_UpgradedId[i] or id == ScepterUpgrade_BaseId[i] then
                return i
            endif
            set i = i + 1
        endloop
        return 0
    endfunction

    // 根据基础Id来找神杖升级
    function GetScepterUpgradeIndexByBaseId takes integer id returns integer
        local integer i = 1
        loop
            if ScepterUpgrade_BaseId[i]== id then
                return i
            endif
            set i = i + 1
        exitwhen i > ScepterUpgradeMaxCount
        endloop
        return -1
    endfunction
    
    // 注册A杖升级 normalId modifyId upgradeId ScepterUpgradeMaxCount
    // 通过GetSkillScepterUpgradeIndexById来获得技能的神杖升级索引
    function RegisterScepterUpgrade takes integer normalId, integer modifyId, integer upgradeId, integer whichInteger returns integer
        // 获取原本技能的索引()
        local integer id = GetSkillIndexByBaseId(normalId)
        set ScepterUpgradeMaxCount = ScepterUpgradeMaxCount + 1
        // 基础技能
        set ScepterUpgrade_BaseId[ScepterUpgradeMaxCount] = normalId
        // 神杖升级的工程升级技能
        set ScepterUpgrade_ModifyId[ScepterUpgradeMaxCount] = modifyId
        call SetAllPlayerAbilityUnavailable(modifyId)
        // 神杖升级后的技能
        set ScepterUpgrade_UpgradedId[ScepterUpgradeMaxCount] = upgradeId
        // 未引用 参数都是0
        set ScepterUpgrade_UnknownId[ScepterUpgradeMaxCount] = whichInteger
        if id > 0 and HeroSkill_SpecialId[id]== 0 then
            set HeroSkill_SpecialId[id]= upgradeId
        endif
        return ScepterUpgradeMaxCount
    endfunction

    //***************************************************************************
    //*
    //*  Method
    //*
    //***************************************************************************
    globals
        // 神杖升级
        private integer array GetUpgradeMethod
        // 失去神杖升级
        private integer array LostUpgradeMethod
    endglobals

    function RegisterSkillGetScepterUpgradeMethod takes integer abilId, string func returns nothing
        set GetUpgradeMethod[abilId] = C2I(MHGame_GetCode(func))
        call ThrowWarning(GetUpgradeMethod[abilId] == 0, "ScepterUpgradeLib", "RegisterSkillGetScepterUpgradeMethod", "abilId", abilId, "func == 0")
    endfunction
    function RegisterSkillLostScepterUpgradeMethod takes integer abilId, string func returns nothing
        set LostUpgradeMethod[abilId] = C2I(MHGame_GetCode(func))
        call ThrowWarning(LostUpgradeMethod[abilId] == 0, "ScepterUpgradeLib", "RegisterSkillLostScepterUpgradeMethod", "abilId", abilId, "func == 0")
    endfunction
    
    function RegisterSkillScepterUpgradeMethod takes integer abilId, string getMethod, string lostMethod returns nothing
        call RegisterItemPuckupMethodByIndex(abilId, getMethod)
        call RegisterItemDropMethodByIndex(abilId, lostMethod)
    endfunction


    globals
        private key UNIT_SCEPTER_COUNT
    endglobals

    private function OnUnitGetScepterUpgrade takes unit whichUnit returns nothing
        local integer pid
        local integer abilId
        local integer i
        local integer maxSlot
        local integer scepterUpgradeIndex

        set pid     = GetPlayerId(GetOwningPlayer(whichUnit))
        set maxSlot = 4 + ExtraSkillsCount
        set i       = 1

        loop
            set abilId = HeroSkill_BaseId[PlayerSkillIndices[pid * MAX_SKILL_SLOTS + i]]
            set scepterUpgradeIndex = GetScepterUpgradeIndexByBaseId(abilId)
            if scepterUpgradeIndex > 0 then
                if ScepterUpgrade_ModifyId[scepterUpgradeIndex]> 0 then
                    call UnitAddPermanentAbility(whichUnit, ScepterUpgrade_ModifyId[scepterUpgradeIndex])
                    call UnitMakeAbilityPermanent(whichUnit, true, ScepterUpgrade_UpgradedId[scepterUpgradeIndex])
                endif

                set Event.INDEX = Event.INDEX + 1
                set Event.TrigUnit[Event.INDEX] = whichUnit
                set Event.TriggerIndex[Event.INDEX] = scepterUpgradeIndex
                call MHGame_ExecuteCodeEx(GetUpgradeMethod[scepterUpgradeIndex])
                set Event.INDEX = Event.INDEX - 1
            endif
            set i = i + 1
        exitwhen i > 4 + ExtraSkillsCount
        endloop
    endfunction

    private function OnUnitLostScepterUpgrade takes unit whichUnit returns nothing
        local integer pid
        local integer abilId
        local integer i
        local integer maxSlot
        local integer scepterUpgradeIndex

        set pid     = GetPlayerId(GetOwningPlayer(whichUnit))
        set maxSlot = 4 + ExtraSkillsCount
        set i       = 1

        loop
            set abilId = HeroSkill_BaseId[PlayerSkillIndices[pid * MAX_SKILL_SLOTS + i]]
            set scepterUpgradeIndex = GetScepterUpgradeIndexByBaseId(abilId)
            if scepterUpgradeIndex > 0 then
                call UnitRemoveAbility(whichUnit, ScepterUpgrade_ModifyId[scepterUpgradeIndex])
                if ScepterUpgrade_UpgradedId[scepterUpgradeIndex] != ScepterUpgrade_BaseId[scepterUpgradeIndex] then
                    call UnitRemoveAbility(whichUnit, ScepterUpgrade_UpgradedId[scepterUpgradeIndex])
                endif

                set Event.INDEX = Event.INDEX + 1
                set Event.TrigUnit[Event.INDEX] = whichUnit
                set Event.TriggerIndex[Event.INDEX] = scepterUpgradeIndex
                call MHGame_ExecuteCodeEx(LostUpgradeMethod[scepterUpgradeIndex])
                set Event.INDEX = Event.INDEX - 1
            endif
            set i = i + 1
        exitwhen i > 4 + ExtraSkillsCount
        endloop
    endfunction

    // 
    function UnitUpdateScepterUpgradeState takes unit whichUnit returns nothing
        
    endfunction

    // 赠品直接调添加
    function UnitAddScepterUpgrade takes unit whichUnit returns nothing
        local integer    count
        set count = Table[GetHandleId(whichUnit)].integer[UNIT_SCEPTER_COUNT] + 1
        set Table[GetHandleId(whichUnit)].integer[UNIT_SCEPTER_COUNT] = count
        if count == 1 then
            call OnUnitGetScepterUpgrade(whichUnit)
        endif
    endfunction

    function ItemAghanimScepterOnPickup takes nothing returns nothing
        local unit       whichUnit = Event.GetTriggerUnit()
        if whichUnit == null then
            return
        endif

        call UnitAddScepterUpgrade(whichUnit)

        set whichUnit = null
    endfunction

    function ItemAghanimScepterOnDrop takes nothing returns nothing
        local unit       whichUnit = Event.GetTriggerUnit()
        local integer    count     
        if whichUnit == null then
            return
        endif

        set count = Table[GetHandleId(whichUnit)].integer[UNIT_SCEPTER_COUNT] - 1
        set Table[GetHandleId(whichUnit)].integer[UNIT_SCEPTER_COUNT] = count
        if count == 0 then
            call OnUnitLostScepterUpgrade(whichUnit)
        endif

        set whichUnit = null
    endfunction
    
endlibrary