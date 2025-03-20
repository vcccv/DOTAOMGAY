
library SkillSystem requires AbilityUtils, UnitAbility

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
            //call ExecuteFunc("MTX")
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
            // call ExecuteFunc("M2X")
            call ExecuteFunc("M3X")
        elseif (heroIndex == 75) then
            //call ExecuteFunc("M4X")
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
            call ExecuteFunc("HauntOnInitialize")
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
            //call ExecuteFunc("PSX")
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
            // call ExecuteFunc("P4X")
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

    // 根据玩家id获得他的控制技能计数
    function GetControlSkillCountByPlayerId takes integer pid returns integer
        local integer k = 0
        local integer c = 0
        // 如果玩家已经有已选择的某个技能属于控制技能 则计数器+1
        loop
            if CONTROL_SKILL_INDEX_LIST[k]!= 0 then
                if PlayerSkillIndices[pid * MAX_SKILL_SLOTS + 1]== CONTROL_SKILL_INDEX_LIST[k]or PlayerSkillIndices[pid * MAX_SKILL_SLOTS + 2]== CONTROL_SKILL_INDEX_LIST[k]or PlayerSkillIndices[pid * MAX_SKILL_SLOTS + 3]== CONTROL_SKILL_INDEX_LIST[k]or PlayerSkillIndices[pid * MAX_SKILL_SLOTS + 4]== CONTROL_SKILL_INDEX_LIST[k]or(ExtraSkillsCount >= 1 and PlayerSkillIndices[pid * MAX_SKILL_SLOTS + 5]== CONTROL_SKILL_INDEX_LIST[k]) or(ExtraSkillsCount >= 2 and PlayerSkillIndices[pid * MAX_SKILL_SLOTS + 6]== CONTROL_SKILL_INDEX_LIST[k]) then
                    set c = c + 1
                endif
            endif
            set k = k + 1
        exitwhen k > CONTROL_SKILL_INDEX_LIST_SIZE
        endloop
        return c
    endfunction
    // 该技能索引是否属于控制技能
    function IsControlSkillByIndex takes integer skillIndex returns boolean
        local integer k = 0
        local boolean b = false
        loop
            if skillIndex == CONTROL_SKILL_INDEX_LIST[k] then
                set b = true
            endif
            set k = k + 1
        exitwhen b or k > CONTROL_SKILL_INDEX_LIST_SIZE
        endloop
        return b
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

    // 判断玩家是否拥有指定索引的技能
    // IsPlayerSkillPickedByIndex
    function IsPlayerSkillPickedByIndex takes player p, integer index returns boolean
        local integer playerIndex = GetPlayerId(p)
        local integer xx = 1
        loop
            if (PlayerSkillIndices[playerIndex * MAX_SKILL_SLOTS + xx]== index) then
                return true
            endif
            set xx = xx + 1
        exitwhen xx > 4 + ExtraSkillsCount
        endloop
        return false
    endfunction

    // 根据1~6的槽位来获取技能
    function GetPlayerSkillIndexBySolt takes player p, integer slot returns integer
        local integer playerIndex = GetPlayerId(p)
        debug call ThrowWarning(slot <=0 or slot >= 7, "System", "GetPlayerSkillIndexBySolt", "", slot, "Index Out of Bounds")
        return PlayerSkillIndices[playerIndex * MAX_SKILL_SLOTS + slot]
    endfunction

    // 检查命令冲突
    // CheckSkillOrderIdByIndex
    function CheckSkillOrderIdByIndex takes integer skillIndex1, integer skillIndex2, string targetOrder, string unknownOrder returns boolean
        local integer i
        local integer k
        // 技能1命令id列表
        local string array s1
        // 技能2命令id列表
        local string array s2
        local integer j
        local integer o
        if skillIndex2 >-1 then
            // 如果任意技能没有指定命令id，则返回false
            if not HaveSavedString(AbilityDataHashTable, skillIndex1, 0) or not HaveSavedString(AbilityDataHashTable, skillIndex2, 0) then
                return false
            endif

            set i = 0
            loop
            exitwhen not HaveSavedString(AbilityDataHashTable, skillIndex1, i)
                set s1[i] = LoadStr(AbilityDataHashTable, skillIndex1, i)
                set i = i + 1
            endloop

            set k = 0
            loop
            exitwhen not HaveSavedString(AbilityDataHashTable, skillIndex2, k)
                set s2[k] = LoadStr(AbilityDataHashTable, skillIndex2, k)
                set k = k + 1
            endloop

            // 如果任意技能没有指定命令id，则返回false
            if i == 0 or k == 0 then
                return false
            endif

            // 嵌套循环
            set j = 0
            loop
                set o = 0
            exitwhen j >= i
                loop
                exitwhen o >= k
                    // 如果s1的任意命令和s2匹配，则返回，并且s1的命令必须!=unknownOrder 意味着unknownOrder可能代表豁免命令，即便匹配了这个命令也不会返回true
                    if s1[j] == s2[o] and s1[j] != unknownOrder then
                        return true
                    endif
                    set o = o + 1
                endloop
                set j = j + 1
            endloop
            return false
        else
            // 如果没有技能2，则使技能1去匹配targetOrder
            set i = 0
            loop
            exitwhen HaveSavedString(AbilityDataHashTable, skillIndex1, i) == false
                if LoadStr(AbilityDataHashTable, skillIndex1, i) == targetOrder then
                    return true
                endif
                set i = i + 1
            endloop
            return false
        endif
        return true
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
    // Id StackLim暂时无用 普通技能 神杖/被动技能 工程升级技能 
    function RegisterHeroSkill takes integer id, string StackLim, integer baseId, integer specialId, integer changeSkill returns nothing
        if baseId > 0 then
            set HeroSkill_Icon[id] = GetAbilitySoundById(baseId, SOUND_TYPE_EFFECT_LOOPED)
            if StringLength(HeroSkill_Icon[id]) == 0 then
                // 等合并slk再说吧
                set HeroSkill_Icon[id] = GetAbilityIconById(baseId)
                // GetAbilityIconById(specialId)
                //call ThrowWarning(StringLength(HeroSkill_Icon[id]) == 0, "SkillSystem", "RegisterHeroSkill", GetObjectName(baseId), 0, "no art icon")
            endif
        endif
        //call SaveSkillOrder(id, GetAbilityOrder(baseId))
        debug call ThrowError(HeroSkill_BaseId[id] != 0, "SkillSystem", "RegisterHeroSkill", GetObjectName(baseId), id, "重复注册了")
        set HeroSkill_BaseId[id]    = baseId
        set HeroSkill_SpecialId[id] = specialId
        set HeroSkill_Modify[id]    = changeSkill
        //if sHotKey != "_" and sHotKey != "" and sHotKey != null then
        //    call SaveStr(AbilityDataHashTable, baseId, HotKeyStringHash, sHotKey)
        //endif
        set MaxHeroSkillsNumber = id
    endfunction

    //***************************************************************************
    //*
    //*  额外的附加技能(多图标技能 或 神杖给予的额外技能)
    //*
    //***************************************************************************

    // 附加技能以索引分布 1 2 3
    // 例如吞噬给予的技能最大可能同时出现2种主动
    // 一般的主动技能为1 吞巨魔给的网为1 召骷髅为2

    // 影魔z为原来的技能 x为1 y为2
    // 因此在判断快捷键时对多图标技能遍历所拥有的所有附加技能

    globals
        TableArray SubAbilitiesTable
    endglobals

    private keyword SubAbilityInit
    struct SubAbility extends array
        
        // 对于子技能有多种形态(吞噬)的个例，使用单向链表
        thistype next
        integer  abilityId
        // 子技能主技能的索引
        integer  ownerIndex

        // 属于第几号子技能
        integer  index

        private static key KEY

        static integer COUNT = 0

        // ownerIndex = 主技能索引
        static method AllocSubAbility takes integer subAbilityId, integer ownerIndex returns thistype
            local thistype this = COUNT + 1
            set COUNT = this
            set this.abilityId  = subAbilityId
            set this.ownerIndex = ownerIndex
            set SubAbilitiesTable[0].integer[subAbilityId] = this
            return this
        endmethod

        // 追加子技能(吞噬)
        method AddSubAbility takes integer subAbilityId returns thistype
            local thistype new = AllocSubAbility(subAbilityId, this.ownerIndex)
            set this.next = new
            set new.index = this.index
            return new
        endmethod
        
        static method GetIndexById takes integer abilityId returns thistype
            return SubAbilitiesTable[0].integer[abilityId]
        endmethod

        implement SubAbilityInit
    endstruct

    private module SubAbilityInit
        private static method onInit takes nothing returns nothing
            set SubAbilitiesTable = TableArray[JASS_MAX_ARRAY_SIZE]
        endmethod
    endmodule

    function GetSkillSubAbilityCountByIndex takes integer skillIndex returns integer
        return SubAbilitiesTable[skillIndex].integer[0]
    endfunction
    function GetSkillSubAbilityByIndex takes integer skillIndex, integer subAbilityIndex returns SubAbility
        return SubAbilitiesTable[skillIndex].integer[subAbilityIndex]
    endfunction

    // 基于英雄技能索引添加子技能
    function HeroSkillAddSubAbilitiesById takes integer skillIndex, integer subAbilityId returns SubAbility
        local SubAbility sb             
        local integer    subAbilityIndex
        //debug call ThrowError(SubAbility.GetIndexById(subAbilityId) != 0, "SkillSystem", "HeroSkillAddSubAbilitiesById", GetObjectName(subAbilityId), 0, "重复添加")
        set sb = SubAbility.AllocSubAbility(subAbilityId, skillIndex)
        set subAbilityIndex = SubAbilitiesTable[skillIndex].integer[0] + 1
        set SubAbilitiesTable[skillIndex].integer[0] = subAbilityIndex
        set SubAbilitiesTable[skillIndex].integer[subAbilityIndex] = sb
        set sb.index = subAbilityIndex
        return sb
    endfunction

    //***************************************************************************
    //*
    //*  切换形技能
    //*
    //***************************************************************************
    private keyword ToggleSkillInit

    struct ToggleSkill extends array

        static integer COUNT = 0
        private static key TOGGLE_SKILL_INDEX
        static TableArray ToggleSkillStateTable

        // 常态
        integer baseId
        integer upgradeId
        // 切换时
        integer alternateId
        boolean isAutoDisable
        static method Register takes integer baseId, integer activeId, boolean isAutoDisable returns nothing
            local integer skillIndex
            local thistype this = thistype.COUNT + 1
            set thistype.COUNT = this
            set Table[TOGGLE_SKILL_INDEX].integer[baseId] = this
            set Table[TOGGLE_SKILL_INDEX].integer[activeId] = this
            call PreloadAbilityById(baseId)
            call PreloadAbilityById(activeId)
            set this.baseId = baseId
            set skillIndex = GetSkillIndexByBaseId(baseId)
            set this.upgradeId = HeroSkill_SpecialId[skillIndex]
            if this.upgradeId != 0 then
                set Table[TOGGLE_SKILL_INDEX].integer[this.upgradeId] = this
            endif

            set this.alternateId   = activeId
            set this.isAutoDisable = isAutoDisable
        endmethod
        static method GetIndexById takes integer abilId returns thistype
            return Table[TOGGLE_SKILL_INDEX].integer[abilId]
        endmethod
        method GetAlternateId takes nothing returns integer
            return this.alternateId
        endmethod
        method IsAlternateId takes integer abilId returns boolean
            return abilId == this.alternateId
        endmethod
        method IsDefaultId takes integer abilId returns boolean
            return abilId == this.baseId or abilId == this.upgradeId
        endmethod
        static method IsUnitAbilityAlternated takes unit whichUnit, integer id returns boolean
            local thistype this = thistype.GetIndexById(id)
            if this == 0 then
                return false
            endif
            return ToggleSkillStateTable[this].boolean[GetHandleId(whichUnit)]
        endmethod
        // 获取指定单位的技能可用默认id，因为可能被神杖升级改变
        static method GetUnitVaildDefaultId takes unit whichUnit, integer skillId returns integer
            local thistype this = GetIndexById(skillId)
            debug call ThrowError(this == 0, "SkillSystem", "GetUnitVaildDefaultId", GetObjectName(skillId), 0, "不是ToggleSkill")
            if GetUnitAbilityLevel(whichUnit, this.baseId) > 0 then
                return this.baseId
            elseif GetUnitAbilityLevel(whichUnit, this.upgradeId) > 0 then
                return this.upgradeId
            endif
            return 0
        endmethod
 
        // true 启用切换 false禁用切换
        static method SetState takes unit whichUnit, integer skillId, boolean state returns nothing
            local thistype this = GetIndexById(skillId)
            if this == 0 then
                return
            endif
            if state then
                debug call ThrowWarning(ToggleSkillStateTable[this].boolean[GetHandleId(whichUnit)], /*
                */ "SkillSys", "SetState", "ToggleSkill", skillId, Id2String(skillId) + "已经激活了")
                call UnitDisableAbilityEx(whichUnit, GetUnitVaildDefaultId(whichUnit, this.baseId), true)
                call UnitEnableAbilityEx(whichUnit, this.alternateId, true)
                set ToggleSkillStateTable[this].boolean[GetHandleId(whichUnit)] = true
            else
                debug call ThrowWarning(not ToggleSkillStateTable[this].boolean[GetHandleId(whichUnit)], /*
                */ "SkillSys", "SetState", "ToggleSkill", skillId, Id2String(skillId) + "已经被关闭了")
                call UnitEnableAbilityEx(whichUnit, GetUnitVaildDefaultId(whichUnit, this.baseId), true)
                call UnitDisableAbilityEx(whichUnit, this.alternateId, true)
                set ToggleSkillStateTable[this].boolean[GetHandleId(whichUnit)] = false
            endif
        endmethod

        static method AbilityOnAdd takes nothing returns boolean
            local unit     whichUnit = MHEvent_GetUnit()
            local integer  id        = MHEvent_GetAbility()
            local thistype this      = GetIndexById(id)
            if this != 0 and this.IsDefaultId(id) and UnitAddPermanentAbility(whichUnit, this.alternateId) and this.isAutoDisable then
                call UnitDisableAbilityEx(whichUnit, this.alternateId, true)
                set ToggleSkillStateTable[this].boolean[GetHandleId(whichUnit)] = false
            endif
            set whichUnit = null
            return false
        endmethod
        static method AbilityOnRemove takes nothing returns boolean
            local unit     whichUnit = MHEvent_GetUnit()
            local integer  id        = MHEvent_GetAbility()
            local thistype this      = GetIndexById(id)
            if this != 0 and this.IsDefaultId(id) then
                call ToggleSkillStateTable[this].boolean.remove(GetHandleId(whichUnit))
                call UnitRemoveAbility(whichUnit, this.alternateId)
            endif
            set whichUnit = null
            return false
        endmethod
        
        // static method AbilityOnSpellEffect takes nothing returns boolean
        //     local unit     whichUnit = GetTriggerUnit()
        //     local integer  id        = GetSpellAbilityId()
        //     local thistype this      = GetIndexById(id)
        //     if this != 0 and this.isAutoToggle then
        //         if this.IsDefaultId(id) then
        //             call UnitDisableAbilityEx(whichUnit, GetUnitVaildDefaultId(whichUnit, this.baseId), true)
        //             call UnitEnableAbilityEx(whichUnit, this.alternateId, true)
        //             set ToggleSkillStateTable[this].boolean[GetHandleId(whichUnit)] = true
        //         elseif this.IsAlternateId(id) then
        //             call UnitEnableAbilityEx(whichUnit, GetUnitVaildDefaultId(whichUnit, this.baseId), true)
        //             call UnitDisableAbilityEx(whichUnit, this.alternateId, true)
        //             set ToggleSkillStateTable[this].boolean[GetHandleId(whichUnit)] = false
        //         endif
        //     endif
        //     set whichUnit = null
        //     return false
        // endmethod

        implement ToggleSkillInit
    endstruct

    private module ToggleSkillInit
        private static method onInit takes nothing returns nothing
            local trigger trig
            set trig = CreateTrigger()
            call TriggerAddCondition(trig, Condition(function thistype.AbilityOnAdd))
            call MHAbilityAddEvent_Register(trig)

            set trig = CreateTrigger()
            call TriggerAddCondition(trig, Condition(function thistype.AbilityOnRemove))
            call MHAbilityRemoveEvent_Register(trig)

            // set trig = CreateTrigger()
            // call TriggerAddCondition(trig, Condition(function thistype.AbilityOnSpellEffect))
            // call TriggerRegisterAnyUnitEvent(trig, EVENT_PLAYER_UNIT_SPELL_EFFECT)

            set ToggleSkillStateTable = TableArray[JASS_MAX_ARRAY_SIZE]
        endmethod
    endmodule

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
    function RegisterPassiveSkill takes integer realId, integer spellBookId, integer learnedId, integer buffId, integer showId, integer iillusionId returns nothing
        set PassiveAbilityMaxCount = PassiveAbilityMaxCount + 1
        set PassiveSkill_Real[PassiveAbilityMaxCount] = realId
        set PassiveSkill_SpellBook[PassiveAbilityMaxCount] = spellBookId
        set PassiveSkill_Learned[PassiveAbilityMaxCount] = learnedId
        set PassiveSkill_Buff[PassiveAbilityMaxCount] = buffId
        set PassiveSkill_Show[PassiveAbilityMaxCount] = showId
        set PassiveSkill_Illusion[PassiveAbilityMaxCount] = iillusionId
        call SetAllPlayerAbilityUnavailable(spellBookId)
    endfunction
    
    // 根据被动技能的学习id找到被动技能索引
    function GetPassiveSkillIndexByLearnedId takes integer learnedId returns integer
        local integer i = 1
        loop
            if learnedId == PassiveSkill_Learned[i] then
                return i
            endif
            set i = i + 1
        exitwhen i > PassiveAbilityMaxCount
        endloop
        return 0
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
