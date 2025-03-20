
library ScepterUpgradeSystem requires SkillSystem, ItemSystem
    
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

        private key INDEX_KEY
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

    // 根据技能id来查找神杖升级索引
    function GetScepterUpgradeIndexById takes integer abilId returns integer
        return Table[INDEX_KEY].integer[abilId]
    endfunction

    // 根据基础Id来找神杖升级
    function GetScepterUpgradeIndexByBaseId takes integer baseId returns integer
        local integer scepterUpgradeIndex = GetScepterUpgradeIndexById(baseId)
        if scepterUpgradeIndex == 0 or ScepterUpgrade_BaseId[scepterUpgradeIndex] != baseId then
            return 0
        endif
        return scepterUpgradeIndex
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

        set Table[INDEX_KEY].integer[normalId ] = ScepterUpgradeMaxCount
        set Table[INDEX_KEY].integer[upgradeId] = ScepterUpgradeMaxCount

        if id > 0 and HeroSkill_SpecialId[id] == 0 then
            set HeroSkill_SpecialId[id] = upgradeId
        endif
        return ScepterUpgradeMaxCount
    endfunction

    globals
        private key UNIT_SCEPTER_COUNT
    endglobals

    // 单位是否神杖升级
    function IsUnitScepterUpgraded takes unit whichUnit returns boolean
        return Table[GetHandleId(whichUnit)].integer[UNIT_SCEPTER_COUNT] > 0
        /*
        local item 	  whichItem
        local integer i = 0
        local integer index
        if GetUnitAbilityLevel(whichUnit, AGHANIM_BLESSING_BUFF_ID) == 1 then
            return true
        endif
        loop
            set whichItem = UnitItemInSlot(whichUnit, i)
            if whichItem != null then
                set index = GetItemIndex(whichItem)
                if (index == Item_AghanimScepterBasic or index == Item_AghanimScepter or index == Item_AghanimScepterGiftable) and GetItemUserData(whichItem) != -2 then
                    set whichItem = null
                    return true
                endif
            endif
            set i = i + 1
        exitwhen i > 5
        endloop
        set whichItem = null
        return false
        */
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

    function RegisterSkillGetScepterUpgradeMethod takes integer scepterUpgradeIndex, string func returns nothing
        set GetUpgradeMethod[scepterUpgradeIndex] = C2I(MHGame_GetCode(func))
        call ThrowError(GetUpgradeMethod[scepterUpgradeIndex] == 0, "ScepterUpgradeSystem", "RegisterSkillGetScepterUpgradeMethod", "scepterUpgradeIndex", scepterUpgradeIndex, "func == 0")
        call ThrowError(scepterUpgradeIndex == 0, "ScepterUpgradeSystem", "RegisterSkillGetScepterUpgradeMethod", "scepterUpgradeIndex", scepterUpgradeIndex, "scepterUpgradeIndex == 0")
    endfunction
    function RegisterSkillLostScepterUpgradeMethod takes integer scepterUpgradeIndex, string func returns nothing
        set LostUpgradeMethod[scepterUpgradeIndex] = C2I(MHGame_GetCode(func))
        call ThrowError(LostUpgradeMethod[scepterUpgradeIndex] == 0, "ScepterUpgradeSystem", "RegisterSkillLostScepterUpgradeMethod", "scepterUpgradeIndex", scepterUpgradeIndex, "func == 0")
    endfunction
    
    function RegisterSkillScepterUpgradeMethod takes integer scepterUpgradeIndex, string getMethod, string lostMethod returns nothing
        call RegisterSkillGetScepterUpgradeMethod(scepterUpgradeIndex, getMethod)
        call RegisterSkillLostScepterUpgradeMethod(scepterUpgradeIndex, lostMethod)
    endfunction

    function GetUnitScepterUpgradeSkillCount takes unit whichUnit returns integer
        local integer pid
        local integer count
        local integer i
        local integer maxSlot
        local integer scepterUpgradeIndex

        set pid     = GetPlayerId(GetOwningPlayer(whichUnit))
        set count   = 0
        set maxSlot = 4 + ExtraSkillsCount
        set i       = 1

        loop
            set scepterUpgradeIndex = GetScepterUpgradeIndexByBaseId(HeroSkill_BaseId[PlayerSkillIndices[pid * MAX_SKILL_SLOTS + i]])
            if scepterUpgradeIndex > 0 then
                set count = count + 1
            endif
            set i = i + 1
        exitwhen i > 4 + ExtraSkillsCount
        endloop

        return count
    endfunction

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
                if GetUpgradeMethod[scepterUpgradeIndex] != 0 then
                    set Event.INDEX = Event.INDEX + 1
                    set Event.TrigUnit[Event.INDEX] = whichUnit
                    set Event.TriggerIndex[Event.INDEX] = scepterUpgradeIndex
                    call MHGame_ExecuteCodeEx(GetUpgradeMethod[scepterUpgradeIndex])
                    set Event.INDEX = Event.INDEX - 1
                endif
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

                if LostUpgradeMethod[scepterUpgradeIndex] != 0 then
                    set Event.INDEX = Event.INDEX + 1
                    set Event.TrigUnit[Event.INDEX] = whichUnit
                    set Event.TriggerIndex[Event.INDEX] = scepterUpgradeIndex
                    call MHGame_ExecuteCodeEx(LostUpgradeMethod[scepterUpgradeIndex])
                    set Event.INDEX = Event.INDEX - 1
                endif
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
        local integer count
        set count = Table[GetHandleId(whichUnit)].integer[UNIT_SCEPTER_COUNT] + 1
        set Table[GetHandleId(whichUnit)].integer[UNIT_SCEPTER_COUNT] = count
        if count == 1 then
            call OnUnitGetScepterUpgrade(whichUnit)
        endif
    endfunction

    function ItemAghanimScepterOnPickup takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        if whichUnit == null then
            return
        endif

        //call BJDebugMsg("AghanimScepter拿了")
        call UnitAddScepterUpgrade(whichUnit)

        set whichUnit = null
    endfunction
    function ItemAghanimScepterOnDrop takes nothing returns nothing
        local unit    whichUnit = Event.GetTriggerUnit()
        local integer count     
        if whichUnit == null then
            return
        endif

        //call BJDebugMsg("AghanimScepter丢了")
        set count = Table[GetHandleId(whichUnit)].integer[UNIT_SCEPTER_COUNT] - 1
        set Table[GetHandleId(whichUnit)].integer[UNIT_SCEPTER_COUNT] = count
        if count == 0 then
            call OnUnitLostScepterUpgrade(whichUnit)
        endif

        set whichUnit = null
    endfunction

    globals
        constant integer AGHANIM_GIFTABLE_ABILITY_ID = 'A3E7'
        constant integer AGHANIM_GIFTABLE_BUFF_ID    = 'B3E7'

        constant integer AGHANIM_BLESSING_ABILITY_ID = 'A3E8'
        constant integer AGHANIM_BLESSING_BUFF_ID    = 'B3E8'
    endglobals

    function IsUnitAghanimBlessed takes unit whichUnit returns boolean
        return GetUnitAbilityLevel(whichUnit, AGHANIM_BLESSING_ABILITY_ID) > 0
    endfunction
    function IsUnitAghanimGifted takes unit whichUnit returns boolean
        return GetUnitAbilityLevel(whichUnit, AGHANIM_GIFTABLE_ABILITY_ID) > 0
    endfunction

    // 有ga的神杖或福佑就都不加
    function UnitAddAghanimBlessing takes unit whichUnit returns nothing
        if IsUnitAghanimBlessed(whichUnit) or IsUnitAghanimGifted(whichUnit) then
            return
        endif
        call UnitAddPermanentAbility(whichUnit, AGHANIM_BLESSING_ABILITY_ID)
        call UnitAddScepterUpgrade(whichUnit)
    endfunction
    function UnitAddAghanimGiftable takes unit whichUnit returns nothing
        if IsUnitAghanimGifted(whichUnit) then
            return
        endif
        call UnitAddPermanentAbility(whichUnit, AGHANIM_GIFTABLE_ABILITY_ID)
        if IsUnitAghanimBlessed(whichUnit) then
            call UnitRemoveAbility(whichUnit, AGHANIM_BLESSING_ABILITY_ID)
            call UnitRemoveAbility(whichUnit, AGHANIM_BLESSING_BUFF_ID)
        else
            call UnitAddScepterUpgrade(whichUnit)
        endif
        call SetHeroStr(whichUnit, GetHeroStr(whichUnit, false) + 10, true)
        call SetHeroInt(whichUnit, GetHeroInt(whichUnit, false) + 10, true)
        call SetHeroAgi(whichUnit, GetHeroAgi(whichUnit, false) + 10, true)
        call UnitAddPermanentAbility(whichUnit, 'A3I2')
        call UnitAddPermanentAbility(whichUnit, 'A3I3')
    endfunction

    function ItemAghanimBlessingOnPickup takes nothing returns nothing
        local unit    whichUnit = Event.GetTriggerUnit()
        local item    whichItem = Event.GetManipulatedItem()
        local integer pid
        //call BJDebugMsg("触发了")
        if whichUnit == null or ( IsUnitAghanimBlessed(whichUnit) or IsUnitAghanimGifted(whichUnit) ) then
            return
        endif

        //call BJDebugMsg("我要删啊啊啊啊")
        call SilentRemoveItem(whichItem)

        set pid = GetPlayerId(GetOwningPlayer(whichUnit))
        set PlayerExtraNetWorth[pid] = PlayerExtraNetWorth[pid] + GetItemGoldCostById(ItemRealId[Item_AghanimBlessing])
        set PlayerItemTotalGoldCostDirty[pid] = true
        
        call UnitAddAghanimBlessing(whichUnit)
  
        set whichUnit = null
        set whichItem = null
    endfunction
    
endlibrary
