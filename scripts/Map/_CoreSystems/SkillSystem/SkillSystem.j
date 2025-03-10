
library SkillSystem requires AbilityCustomOrderId, AbilityUtils, UnitAbility

    function HeroOnInitializer takes integer heroIndex returns nothing
        if (heroIndex == 34) then
            call PreloadUnit('h06K')
        elseif heroIndex == 117 then
            call SetAllPlayerAbilityUnavailable('A40O')
            call SetAllPlayerAbilityUnavailable('A40P')
            call SetAllPlayerAbilityUnavailable('A40Q')
            call SetAllPlayerAbilityUnavailable('A40R')
        elseif heroIndex == 16 then
            call SetAllPlayerAbilityUnavailable('A10U')
            call SetAllPlayerAbilityUnavailable('A11X')
        elseif heroIndex == 62 then
            call ExecuteFunc("MFX")
        elseif heroIndex == 83 then
            set IX = true
        elseif heroIndex == 111 then
            call ExecuteFunc("MGX")
        elseif (heroIndex == 38) then
            call ExecuteFunc("MHX")
        elseif (heroIndex == 31) then
            call ExecuteFunc("MJX")
        elseif (heroIndex == 8) then
            call ExecuteFunc("MKX")
            call ExecuteFunc("MLX")
        elseif (heroIndex == HERO_INDEX_ENCHANTRESS) then
            // 魅惑魔女
            //call ExecuteFunc("Impetus_Init")()
            call ExecuteFunc("MMX")
        elseif (heroIndex == 95) then
            call ExecuteFunc("MPX")
        elseif (heroIndex == 12) then
            call ExecuteFunc("MQX")
        elseif heroIndex == 52 then
            call SetAllPlayerAbilityUnavailable('A30P')
        elseif heroIndex == 61 then
            call SetAllPlayerAbilityUnavailable('A419')
        elseif (heroIndex == 4) then
            // 变体精灵的变颜色
            // call ExecuteFunc("MSX")
            call ExecuteFunc("MTX")
        elseif (heroIndex == 18) then
            call ExecuteFunc("MUX")
            call ExecuteFunc("MWX")
        elseif heroIndex == 73 then
            call SetAllPlayerAbilityUnavailable('A30D')
            call SetAllPlayerAbilityUnavailable('A30E')
        elseif (heroIndex == 21) then
            // 神出鬼没
            call ExecuteFunc("MYX")
            // 预读技能
            call ExecuteFunc("RegisterPhantomLancerTrigger")
        elseif (heroIndex == 26) then
            call ExecuteFunc("M0X")
        elseif (heroIndex == 10) then
            call ExecuteFunc("LoneDruidSummonSpiritBear_Init")
        elseif (heroIndex == 23) then
            // 地精工程师
            call ExecuteFunc("M2X")
            call ExecuteFunc("M3X")
        elseif (heroIndex == 75) then
            call ExecuteFunc("M4X")
        elseif (heroIndex == 59) then
            //call ExecuteFunc("M5X")
            // 蜘蛛网
            call ExecuteFunc("BroodmotherSpinWeb_Init")
        elseif (heroIndex == 77) then
            call ExecuteFunc("M7X")
        elseif (heroIndex == 81) then
            call ExecuteFunc("M8X")
        elseif (heroIndex == 105) then
            call ExecuteFunc("M9X")
        elseif (heroIndex == 107) then
            call RegisterUnitAttackFunc("PVX", 0)
            call ExecuteFunc("PEX")
            // 灵魂超度
            set HaveVisage = true
            // call ExecuteFunc("PXX")
            call ExecuteFunc("POX")
        elseif (heroIndex == 79) then
            call ExecuteFunc("PRX")
        elseif (heroIndex == 85) then
            call ExecuteFunc("SpectralDagger_Init")
            call ExecuteFunc("PAX")
        elseif (heroIndex == 86) then
            call ExecuteFunc("PNX")
        elseif (heroIndex == 33) then
            call ExecuteFunc("PBX")
        elseif (heroIndex == 88) then
            // 术士
            call ExecuteFunc("PCX")
            call ExecuteFunc("PDX")
            // 地狱火
            call ExecuteFunc("PFX")
        elseif heroIndex == 90 then
            call ExecuteFunc("PGX")
        elseif heroIndex == 71 then
            call ExecuteFunc("PHX")
        elseif heroIndex == 91 then
            call ExecuteFunc("PJX")
        elseif heroIndex == 44 then
            call ExecuteFunc("PhaseShiftOnInit")
        elseif heroIndex == 121 then
            set AX = true
            //elseif heroIndex == 98 then
            //	call ExecuteFunc("PLX")
        elseif heroIndex == 78 then
            call ExecuteFunc("PMX")
        elseif heroIndex == 72 then
            call ExecuteFunc("InitLifestealerBuffTable")
        elseif heroIndex == 46 then
            call ExecuteFunc("PQX")
        elseif heroIndex == 47 then
            call ExecuteFunc("PSX")
        elseif heroIndex == 96 then
            call ExecuteFunc("PTX")
        elseif heroIndex == 97 then
            call ExecuteFunc("PUX")
        elseif heroIndex == 51 then
            call ExecuteFunc("PWX")
        elseif heroIndex == 49 then
            call ExecuteFunc("PYX")
        elseif heroIndex == 29 then
            call ExecuteFunc("PZX")
        elseif heroIndex == 50 then
            call ExecuteFunc("P_X")
        elseif heroIndex == 30 then
            call ExecuteFunc("CreatePrimalSplitTrigger")
        elseif heroIndex == 53 then
            call ExecuteFunc("P1X")
            call ExecuteFunc("P2X")
        elseif heroIndex == 54 then
            //	call ExecuteFunc("P3X")
            call ExecuteFunc("P4X")
        elseif heroIndex == 55 then
        elseif heroIndex == 56 then
            call ExecuteFunc("P5X")
        elseif heroIndex == 57 then
            call ExecuteFunc("P6X")
        endif
    endfunction

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

    /*
    struct HeroSkill extends array
        
        integer baseId
        // 对于主动技能，是神杖升级，对于被动技能，是被动的提示
        integer specialId
        
    endstruct
    */

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
        set CONTROL_SKILL_INDEX_LIST[CONTROL_SKILL_INDEX_LIST_SIZE] = id
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
            set HeroSkill_Icon[id] = GetAbilityIconById(commonSkill)//GetAbilitySoundById(commonSkill, SOUND_TYPE_EFFECT_LOOPED)
            if StringLength(HeroSkill_Icon[id]) == 0 then
                // 等合并slk再说吧
                set HeroSkill_Icon[id] = GetAbilitySoundById(commonSkill, SOUND_TYPE_EFFECT_LOOPED)
                // GetAbilityIconById(upgradeSkill)
                //call ThrowWarning(StringLength(HeroSkill_Icon[id]) == 0, "SkillSystem", "RegisterHeroSkill", GetObjectName(commonSkill), 0, "no art icon")
            endif
        endif
        set HeroSkill_BaseId[id] = commonSkill
        set HeroSkill_SpecialId[id] = upgradeSkill
        set HeroSkill_Modify[id] = changeSkill
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
        set PassiveSkill_Real[PassiveAbilityMaxCount] = iRealSkill
        set PassiveSkill_SpellBook[PassiveAbilityMaxCount] = iSpellBookSkill
        set PassiveSkill_Learned[PassiveAbilityMaxCount] = iLearnedSkill
        set PassiveSkill_Buff[PassiveAbilityMaxCount] = iSkillBuff
        set PassiveSkill_Show[PassiveAbilityMaxCount] = iShowSkill
        set PassiveSkill_Illusion[PassiveAbilityMaxCount] = iillusionUnitSkill
        call SetAllPlayerAbilityUnavailable(iSpellBookSkill)
    endfunction

    //***************************************************************************
    //*
    //*  Method
    //*
    //***************************************************************************
    globals
        private integer array InitializerMethod
        private boolean array SkillIndexInitialized
    endglobals

    function RegisterSkillInitMethodByIndex takes integer skillIndex, string func returns nothing
        set InitializerMethod[skillIndex] = C2I(MHGame_GetCode(func))
        call ThrowWarning(InitializerMethod[skillIndex] == 0, "SkillSystem", "RegisterSkillInitMethodByIndex", I2S(skillIndex), skillIndex, "func == 0")
    endfunction

    globals
	    boolean array HeroIndexInitialized
    endglobals
    // i = skillIndex
    function HeroSkillInitializerByIndex takes integer skillIndex returns nothing
        local integer heroIndex = R2I((I2R(skillIndex)+ 3.)/ 4.) // skillIndex2heroIndex
        if heroIndex > 151 then
            set heroIndex = 151
        endif
        if not (HeroIndexInitialized[heroIndex]) then
            call HeroOnInitializer(heroIndex)
            set HeroIndexInitialized[heroIndex] = true
        endif
        if not (SkillIndexInitialized[skillIndex]) then
            if InitializerMethod[skillIndex] != 0 then
                set Event.INDEX = Event.INDEX + 1
                set Event.TriggerIndex[Event.INDEX] = skillIndex
                call MHGame_ExecuteCodeEx(InitializerMethod[skillIndex])
                set Event.INDEX = Event.INDEX - 1
            endif
            set SkillIndexInitialized[skillIndex] = true
        endif
        // 技能初始化
        if HaveSavedString(ObjectHashTable, HeroSkill_BaseId[skillIndex], 600) and LoadBoolean(ObjectHashTable, HeroSkill_BaseId[skillIndex], 600) == false then
            call SaveBoolean(ObjectHashTable, HeroSkill_BaseId[skillIndex], 600, true)
            call ExecuteFunc(LoadStr(ObjectHashTable, HeroSkill_BaseId[skillIndex], 600))
        endif
        // 被动技能初始化
        if HaveSavedString(ObjectHashTable, HeroSkill_BaseId[skillIndex], 601) and LoadBoolean(ObjectHashTable, HeroSkill_BaseId[skillIndex], 601) == false then
            call SaveBoolean(ObjectHashTable, HeroSkill_BaseId[skillIndex], 601, true)
            call ExecuteFunc(LoadStr(ObjectHashTable, HeroSkill_BaseId[skillIndex], 601))
        endif
    endfunction
    function HeroSkillInitializerByPlayerId takes integer playerIndex returns nothing
        local integer slot = 1
        loop
            call HeroSkillInitializerByIndex(PlayerSkillIndices[playerIndex * MAX_SKILL_SLOTS + slot])
            set slot = slot + 1
        exitwhen slot > 4 + ExtraSkillsCount
        endloop
    endfunction

endlibrary
