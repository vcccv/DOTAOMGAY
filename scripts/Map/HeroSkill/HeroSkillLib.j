
library HeroSkillLib requires AbilityCustomOrderId

    function GetPlayerUltimate1Cooldown takes player whichPlayer returns real
        local integer id = GetPlayerId(whichPlayer)
        if PlayerHeroes[id] == null then
            return 0.
        endif
        return MHAbility_GetCooldown(PlayerHeroes[id], HeroSkill_BaseId[PlayerSkillIndices[id * MAX_SKILL_SLOTS + 4]])
    endfunction
    function GetPlayerUltimate2Cooldown takes player whichPlayer returns real
        local integer id = GetPlayerId(whichPlayer)
        if PlayerHeroes[id] == null then
            return 0.
        endif
        return MHAbility_GetCooldown(PlayerHeroes[id], HeroSkill_BaseId[PlayerSkillIndices[id * MAX_SKILL_SLOTS + 6]])
    endfunction
    
    function GetPlayerUltimate1CooldownText takes player whichPlayer returns string
        local real   r = GetPlayerUltimate1Cooldown(whichPlayer)
        local string s
        if r > 0 then
            set s = I2S(R2I(r))
        else
            set s = " "
        endif
        return s
    endfunction

    struct HeroSkill extends array
        
        integer base
        // 对于主动技能，是神杖升级，对于被动技能，是被动的提示
        integer special
        
    endstruct

    globals
        integer array PlayerSkillIndices

        string  array HeroSkill_Icon

        integer array HeroSkill_BaseId
        integer array HeroSkill_SpecialId
        integer array HeroSkill_Modify
        boolean array HeroSkill_IsPassive
        
        string  array HeroSkill_BalanceOffDisabledTips
        string  array HeroSkill_RearmCombosDisabledTips

        string  array HeroSkill_Tips
        boolean array HeroSkill_HasMultipleAbilities

        boolean array HeroSkill_Disabled
        boolean array HeroSkill_IsDisabledInDeathMatch
    endglobals

    globals
        integer array CONTROL_SKILL_INDEX_LIST
        integer CONTROL_SKILL_INDEX_LIST_SIZE = 0
    endglobals

    function AddControlSkillIndex takes integer id returns nothing
        set CONTROL_SKILL_INDEX_LIST[CONTROL_SKILL_INDEX_LIST_SIZE]= id
        set CONTROL_SKILL_INDEX_LIST_SIZE = CONTROL_SKILL_INDEX_LIST_SIZE + 1
    endfunction

    function SaveSkillOrder takes integer id, string s returns string
        local integer i = 0
        if s == null or s == "" then
            return null
        endif
        loop
        exitwhen not HaveSavedString(AbilityDataHashTable, id, i)
            set i = i + 1
        endloop
        call SaveStr(AbilityDataHashTable, id, i, s)
        return null
    endfunction
    function SaveSkillOrderInBalanceOffDisabled takes integer id, string order returns nothing
        if not Mode__BalanceOff then
            call SaveSkillOrder(id, order)
        endif
    endfunction
    
    function GetSkillIndexByBaseId takes integer id returns integer
        local integer i = 1
        loop
            if HeroSkill_BaseId[i] == id then
                return i
            endif
            set i = i + 1
        exitwhen i > MaxHeroSkillsNumber
        endloop
        return - 1
    endfunction
    function GetSkillIndexById takes integer id returns integer	//返回普通+A杖
        local integer i = 1
        loop
            if HeroSkill_BaseId[i] == id or HeroSkill_SpecialId[i] == id then
                return i
            endif
            set i = i + 1
        exitwhen i > MaxHeroSkillsNumber
        endloop
        return - 1
    endfunction
    function HeroSkillBalanceSunStrike takes integer id, integer aid1, integer aid2, integer aid3, integer aid4 returns nothing
        if not Mode__RearmCombos and not Mode__BalanceOff then
            if aid1 =='Z601' then
                call SaveSkillOrder(id * 4 + 1, "r23")
            elseif aid2 =='Z601' then
                call SaveSkillOrder(id * 4 + 2, "r23")
            elseif aid3 =='Z601' then
                call SaveSkillOrder(id * 4 + 3, "r23")
            elseif aid4 =='Z601' then
                call SaveSkillOrder(id * 4 + 4, "r23")
            endif
        endif
    endfunction
    // Id StackLim暂时无用 普通技能 神杖技能 工程升级技能 
    function RegisterHeroSkill takes integer id, string StackLim, integer commonSkill, integer upgradeSkill, integer changeSkill, string sHotKey returns nothing
        if commonSkill > 0 then
            set HeroSkill_Icon[id]= GetAbilitySoundById(commonSkill, SOUND_TYPE_EFFECT_LOOPED)
        endif
        set HeroSkill_BaseId[id]= commonSkill
        set HeroSkill_SpecialId[id]= upgradeSkill
        set HeroSkill_Modify[id]= changeSkill
        if sHotKey != "_" and sHotKey != "" and sHotKey != null then
            call SaveStr(AbilityDataHashTable, commonSkill, HotKeyStringHash, sHotKey)
        endif
        set MaxHeroSkillsNumber = id
    endfunction

    //***************************************************************************
    //*
    //*  被动技能
    //*
    //***************************************************************************
    globals
        integer array PassiveSkill_Real
        integer array PassiveSkill_SpellBook
        integer array PassiveSkill_Learned
        integer array PassiveSkill_Buff
        integer array PassiveSkill_Show
        integer array PassiveSkill_Illusion
        integer PassiveAbilityMaxCount = 0
    endglobals

    // 注册被动技能
    // 第一个参数为真实的技能(用这个判断)(在魔法书里面不显示)
    // 第二个参数为魔法书马甲技能(会被禁用)
    // 第三个参数为被学习的技能 被学习技能等级为0就说明没这个技能
    // 第四个参数为技能提供的Buff(没有就是0)
    // 第五个参数为显示的马甲技能(没有作用只是显示，会被-sp隐藏)
    // 第六个参数为幻象出生时添加的技能
    // PassiveAbilityMaxCount为最大被动数量
    // 实际上应该优化 但没事还是别改
    function RegisterPassiveSkill takes integer iRealSkill, integer iSpellBookSkill, integer iLearnedSkill, integer iSkillBuff, integer iShowSkill, integer iillusionUnitSkill returns nothing
        set PassiveAbilityMaxCount = PassiveAbilityMaxCount + 1
        set PassiveSkill_Real[PassiveAbilityMaxCount]= iRealSkill
        set PassiveSkill_SpellBook[PassiveAbilityMaxCount]= iSpellBookSkill
        set PassiveSkill_Learned[PassiveAbilityMaxCount]= iLearnedSkill
        set PassiveSkill_Buff[PassiveAbilityMaxCount]= iSkillBuff
        set PassiveSkill_Show[PassiveAbilityMaxCount]= iShowSkill
        set PassiveSkill_Illusion[PassiveAbilityMaxCount]= iillusionUnitSkill
        call SetAllPlayerAbilityUnavailable(iSpellBookSkill)
    endfunction

endlibrary
