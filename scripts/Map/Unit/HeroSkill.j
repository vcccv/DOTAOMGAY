
library HeroAbilityLib requires AbilityCustomOrderId

    struct HeroSkill extends array
        
        integer base
        // 对于主动技能，是神杖升级，对于被动技能，是被动的提示
        integer special
        
    endstruct

    globals
        integer array PlayerAbilityList

        string  array HeroSkill_Icon
        integer array HeroSkill_Base
        integer array HeroSkill_Special
        
        integer array HeroSkill_Modify
        string  array NoBalanceOffTips
        string  array NoRearmCombosTips
        string  array ZTP
        
        boolean array HeroSkill_IsPassive
        boolean array IsMultiIconSkill
        boolean array IsNoDeathMatchSkill
        boolean array IsDisabledSkill
    endglobals

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
    function Z1E takes integer id, string Z5E returns nothing
        if Mode__BalanceOff == false then
            call SaveSkillOrder(id, Z5E)
        endif
    endfunction
    function Z6E takes integer id, string Z8E returns nothing
        if Mode__BalanceOff == false then
            call SaveSkillOrder(id, Z8E)
        endif
    endfunction
    function AddControlSkillIndex takes integer id returns nothing
        set CONTROL_SKILL_INDEX_LIST[CONTROL_SKILL_INDEX_LIST_SIZE]= id
        set CONTROL_SKILL_INDEX_LIST_SIZE = CONTROL_SKILL_INDEX_LIST_SIZE + 1
    endfunction
    // 控制技能列表
    function ControlSkillList_Init takes nothing returns nothing
        call AddControlSkillIndex((8  - 1)* 4 + 1)
        call AddControlSkillIndex((6  - 1)* 4 + 1)
        call AddControlSkillIndex((95 - 1)* 4 + 4)
        call AddControlSkillIndex((22 - 1)* 4 + 1)
        call AddControlSkillIndex((46 - 1)* 4 + 1)
        call AddControlSkillIndex((37 - 1)* 4 + 4)
        call AddControlSkillIndex((33 - 1)* 4 + 2)
        call AddControlSkillIndex((39 - 1)* 4 + 2)
        call AddControlSkillIndex((14 - 1)* 4 + 4)
        call AddControlSkillIndex((77 - 1)* 4 + 4)
        call AddControlSkillIndex((81 - 1)* 4 + 1)
        call AddControlSkillIndex((66 - 1)* 4 + 2)
        call AddControlSkillIndex((74 - 1)* 4 + 4)
        call AddControlSkillIndex((63 - 1)* 4 + 1)
        call AddControlSkillIndex((108 - 1)* 4 + 1)
        call AddControlSkillIndex((106 - 1)* 4 + 4)
        call AddControlSkillIndex((1  - 1)* 4 + 1)
        call AddControlSkillIndex((40 - 1)* 4 + 2)
        call AddControlSkillIndex((48 - 1)* 4 + 2)
        call AddControlSkillIndex((7  - 1)* 4 + 2)
        call AddControlSkillIndex((54 - 1)* 4 + 1)
        call AddControlSkillIndex((69 - 1)* 4 + 4)
        call AddControlSkillIndex((89 - 1)* 4 + 1)
        call AddControlSkillIndex((65 - 1)* 4 + 1)
        call AddControlSkillIndex((61 - 1)* 4 + 4)
        call AddControlSkillIndex((5  - 1)* 4 + 2)
        call AddControlSkillIndex((41 - 1)* 4 + 2)
        call AddControlSkillIndex((47 - 1)* 4 + 1)
        call AddControlSkillIndex((11 - 1)* 4 + 2)
        call AddControlSkillIndex((28 - 1)* 4 + 2)
        call AddControlSkillIndex((28 - 1)* 4 + 3)
        call AddControlSkillIndex((38 - 1)* 4 + 2)
        call AddControlSkillIndex((18 - 1)* 4 + 1)
        call AddControlSkillIndex((53 - 1)* 4 + 1)
        call AddControlSkillIndex((75 - 1)* 4 + 3)
        call AddControlSkillIndex((75 - 1)* 4 + 4)
        call AddControlSkillIndex((104 - 1)* 4 + 1)
        call AddControlSkillIndex((104 - 1)* 4 + 2)
        call AddControlSkillIndex((86 - 1)* 4 + 1)
        call AddControlSkillIndex((95 - 1)* 4 + 1)
        call AddControlSkillIndex((100 - 1)* 4 + 1)
        call AddControlSkillIndex((97 - 1)* 4 + 1)
        call AddControlSkillIndex((87 - 1)* 4 + 2)
        call AddControlSkillIndex((101 - 1)* 4 + 1)
        call AddControlSkillIndex((112 - 1)* 4 + 1)
        call AddControlSkillIndex((31 - 1)* 4 + 1)
        call AddControlSkillIndex((46 - 1)* 4 + 4)
        call AddControlSkillIndex((111 - 1)* 4 + 1)
        call AddControlSkillIndex((78 - 1)* 4 + 1)
        call AddControlSkillIndex((4  - 1)* 4 + 2)
        call AddControlSkillIndex((120 - 1)* 4 + 2)
        call AddControlSkillIndex((91 - 1)* 4 + 2)
        call AddControlSkillIndex((78 - 1)* 4 + 4)
        call AddControlSkillIndex((82 - 1)* 4 + 1)
        call AddControlSkillIndex((109 - 1)* 4 + 4)
        call AddControlSkillIndex((96 - 1)* 4 + 4)
    endfunction
    
    function GetNormalSkillIndex takes integer id returns integer
        local integer i = 1
        loop
            if HeroSkill_Base[i]== id then
                return i
            endif
            set i = i + 1
        exitwhen i > MaxHeroSkillsNumber
        endloop
        return - 1
    endfunction
    function GetSkillIndex takes integer id returns integer	//返回普通+A杖
        local integer i = 1
        loop
            if HeroSkill_Base[i]== id or HeroSkill_Special[i] == id then
                return i
            endif
            set i = i + 1
        exitwhen i > MaxHeroSkillsNumber
        endloop
        return - 1
    endfunction
    // Id StackLim暂时无用 普通技能 神杖技能 工程升级技能 
    function RegisterHeroSkill takes integer id, string StackLim, integer commonSkill, integer upgradeSkill, integer changeSkill, string sHotKey returns nothing
        if commonSkill > 0 then
            set HeroSkill_Icon[id]= GetAbilitySoundById(commonSkill, SOUND_TYPE_EFFECT_LOOPED)
        endif
        set HeroSkill_Base[id]= commonSkill
        set HeroSkill_Special[id]= upgradeSkill
        set HeroSkill_Modify[id]= changeSkill
        if sHotKey != "_" and sHotKey != "" and sHotKey != null then
            call SaveStr(AbilityDataHashTable, commonSkill, HotKeyStringHash, sHotKey)
        endif
        set MaxHeroSkillsNumber = id
    endfunction

    function InitHeroSkillsData takes nothing returns nothing
        local integer i = 0
        local string s
        call RegisterHeroSkill(0, null, 0, 0, 0, null)
        set HeroSkill_Icon[0]= "UI\\Widgets\\Console\\Undead\\undead-inventory-slotfiller.blp"
        set i = 1 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "thunderbolt"),'A02A', 0,'Y001', "c")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "volcano"),'A17O', 0,'Y002', "e")
        call RegisterHeroSkill(i * 4 + 3, null,'P003','QP03','Y003', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "forkedlightning"),'A0IN','A1AW','Y004', "w")
        set i = 2 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A020')),'A020', 0,'Y005', "c")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "thunderbolt"),'A0JC', 0,'Y006', "g")
        call RegisterHeroSkill(i * 4 + 3, null,'A0N5','QP1T','Y007', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "roar")+ SaveSkillOrder(i * 4 + 4, "r1"),'A29G','A29H','Y008', "w")
        set i = 3 - 1
        call RegisterHeroSkill(i * 4 + 1, null,'A0DW','QP04','Y009', null)
        set HeroSkill_IsPassive[i * 4 + 1]= true
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "slow"),'A0DX', 0,'Y010', "c")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "locustswarm"),'A01B', 0,'Y011', "r")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "arrows")+ SaveSkillOrder(i * 4 + 4, "range only")+ SaveSkillOrder(i * 4 + 4, "shuashecheng"),'A0DY','A1WB','Y012', "t")
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 4, "HXBinglongTuijin")
        endif
        //set IsNoDeathMatchSkill[i * 4 + 4]= true
        set i = 4 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('QB02')), 'QB02', 0,'QY02', "w")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A0G6')),'A0G6', 0,'Y014', "e")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "replenishmana")+ SaveSkillOrder(i * 4 + 3, "replenishlife")+ SaveSkillOrder(i * 4 + 3, "abuz agi")+ SaveSkillOrder(i * 4 + 3, "str bug"),'A0KX', 0,'Y015', null)
        set IsMultiIconSkill[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "item 16")+ SaveSkillOrder(i * 4 + 4, "coldarrows"),'A0G8', 0,'Y016', "r")
        set i = 5 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "mounthippogryph"),'A1E9', 0,'Y017', "v")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "entanglingroots"),'A04C', 0,'Y018', "e")
        call RegisterHeroSkill(i * 4 + 3, null,'P019','QP05','Y019', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "autoharvestlumber"),'A03R','A0AV','Y020', "f")
        set i = 6 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "spellshieldaoe"),'A190', 0,'Y021', "t")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "melee only"),'A01K','QP06','Y022', null)
        set HeroSkill_IsPassive[i * 4 + 2]= true
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, GetAbilityOrder('A2IS')),'A2IS', 0,'Y023', "w")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "roar"),'A0WP','A43D','Y024', "r")
        set i = 7 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A063')),'A063', 0,'Y025', "r")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "unavatar"),'A24D', 0,'Y026', "e")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, GetAbilityOrder('A2KU')),'A2KU', 0,'Y027', "d")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "awaken")+ SaveSkillOrder(i * 4 + 4, "avengerform")+ SaveSkillOrder(i * 4 + 4, "r2"),'A07U','A38E','Y028', "g")
        set i = 8 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "barkskinoff"),'A0SK', 0,'Y029', "f")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "roar"),'A0DL', 0,'Y030', "e")
        set NoBalanceOffTips[i * 4 + 2]= "图腾在与水刀、连击、海象挥击、忍术、转属性和无影拳的时候只会 +100/140/180/220% 的攻击力"
        call Z6E(i * 4 + 2, "Mode__RandomDraft-Drunken")
        call Z1E(i * 4 + 2, "bgdmg1")
        call Z1E(i * 4 + 2, "bgdmg2")
        call RegisterHeroSkill(i * 4 + 3, null,'A0DJ','QP1G','Y031', null)
        set ZTP[i * 4 + 3]= "余震有6/4.5/3.0/1.5秒的冷却时间"
        set HeroSkill_IsPassive[i * 4 + 3]= true
        if Mode__SixSkills and(not Mode__RearmCombos) then
            //	set IsDisabledSkill[i * 4 + 3]= true
            set IsDisabledSkill[i * 4 + 2]= true
        endif
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A0DH')),'A0DH','A1OB','Y032', "c")
        set i = 9 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "neutralinteract"),'A0RG', 0,'Y033', "c")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "inv bug 1")+ SaveSkillOrder(i * 4 + 2, "ibug")+ SaveSkillOrder(i * 4 + 2, "yongjiu1")+ SaveSkillOrder(i * 4 + 2, "yongjiu2")+ SaveSkillOrder(i * 4 + 2, "yongjiu3"),'A0MB','QP08','Y036', null)
        set HeroSkill_IsPassive[i * 4 + 2]= true
        set ZTP[i * 4 + 2]= "永久隐身效果会在攻击、施法或使用物品后消失"
        call RegisterHeroSkill(i * 4 + 3, null,'A0DZ','QP07','Y035', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "barkskinon"),'A0K9', 0,'Y034', "b")
        set i = 10 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "summongrizzly"),'A0A5', 0,'Y037', "b")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A1EG')),'A1EG', 0,'Y038', "r")
        call RegisterHeroSkill(i * 4 + 3, null, 'A0A8', 0, 'Y039', null) //协同
        if Mode__SixSkills and(not Mode__RearmCombos) then
            set IsDisabledSkill[i * 4 + 3]= true
        endif
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "bearform")+ SaveSkillOrder(i * 4 + 4, "unbearform")+ SaveSkillOrder(i * 4 + 4, "battleroar")+ SaveSkillOrder(i * 4 + 4, "metamorphosis")+ SaveSkillOrder(i * 4 + 4, "melee morph"),'A0AG', 0,'Y040', "f")
        set IsMultiIconSkill[i * 4 + 4]= true
        set i = 11 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A01F')),'A01F', 0,'Y041', "d")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "restorationoff"),'QB0E', 0,'QY0E', "t")
        call RegisterHeroSkill(i * 4 + 3, null,'A18X','QP1U','Y043', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        set NoRearmCombosTips[i * 4 + 3]= "冷却时间3秒及以下的技能每施放2次才会触发1次炽魂"
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A01P')),'A01P','A09Z','Y044', "g")
        set i = 12 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "whirlwind"),'A05G', 0,'Y045', "f")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "healingward"),'A047', 0,'Y046', "g")
        call RegisterHeroSkill(i * 4 + 3, null,'A00K','QP09','Y047', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "thunderbolt"),'A0M1','A1AX','Y048', "e")
        set i = 13 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "neutralspell"),'A14L', 0,'Y049', "c")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "arrows")+ SaveSkillOrder(i * 4 + 2, "range only"),'A0LZ', 0,'Y050', "w")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "transmute"),'A2NT', 0,'Y051', "t")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "battlestations")+ SaveSkillOrder(i * 4 + 4, "r4"),'A0L3','A2QC','Y052', "e")
        set i = 14 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "invisibility"),'A01Z', 0,'Y053', "t")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "unavengerform"),'A26N', 0,'Y054', "e")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "spiritlink"),'A2ML', 0,'Y055', "v")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "blight"),'A07Z','A44S','Y056', "r")
        set i = 15 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "Locustswarm"),'A1AA', 0,'Y057', "t")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "loadcorpse")+ SaveSkillOrder(i * 4 + 2, "whirlwind"),'A1A8', 0,'Y058', "c")
        call RegisterHeroSkill(i * 4 + 3, null,'A1CD','QP1I','Y059', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "board"),'A1A1','A43J','Y060', "e")
        set i = 16 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "carrionscarabs")+ SaveSkillOrder(i * 4 + 1, "carrionscarabsinstant"),'A085', 0,'Y061', "t")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "spellsteal"),'A10X', 0,'Y062', "e")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "frenzy"),'A112', 0,'Y063', "c")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "range morph")+ SaveSkillOrder(i * 4 + 4, "metamorphosis")+ SaveSkillOrder(i * 4 + 4, "phoenixfire")+ SaveSkillOrder(i * 4 + 4, "creepheal"),'QM01', 0,'Y064', "f")
        set IsMultiIconSkill[i * 4 + 4]= true
        set i = 17 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "thunderclap"),'A03Y', 0,'Y065', "c")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('QB0P')),'QB0P', 0,'QY0P', "v")
        call RegisterHeroSkill(i * 4 + 3, null,'P067','QP0A','Y067', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "berserk"),'A0LC','A443','Y068', "r")
        set i = 18 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "thunderbolt"),'QB0J', 0,'QY0J', "f")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A011')),'A011', 0,'Y070', "g")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "bloodlust"),'A083', 0,'Y071', "b")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "carrionscarabsoff"),'A088','QP24','Y072', null)
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 4, "HXmines")
        endif
        set HeroSkill_IsPassive[i * 4 + 4]= true
        set NoBalanceOffTips[i * 4 + 4]= "多重施法的触发几率调整为：18%/30%/40%概率x2，0%/13%/15%概率x3，0%/0/%5%概率x4。每下施法会额外消耗35%魔法值。"
        set i = 19 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "drunkenhaze"),'A049','A33G','Y073', "e")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A05E')),'A05E','A33F','Y074', "t")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "manaflareoff")+ SaveSkillOrder(i * 4 + 3, "stampede"),'A0BQ', 0,'Y075', "c")
        set i = i * 4 + 4
        call RegisterHeroSkill(i, SaveSkillOrder(i, "monsoon")+ SaveSkillOrder(i, "channel")+ SaveSkillOrder(i, "magicundefense"),'A065', 0,'Y076', "r")
        //	set IsDisabledSkill[i * 4 + 4]= true
        set NoBalanceOffTips[i]= "再装填有9/6/3的冷却时间"
        set s = SaveSkillOrder(i, "r1")+ SaveSkillOrder(i, "r4")+ SaveSkillOrder(i, "r55")+ SaveSkillOrder(i, "r18")
        //if Mode__SixSkills and(not Mode__RearmCombos) then
        if ExtraSkillsNumber != 0 then
            set IsDisabledSkill[i]= true
        endif
        if Mode__RearmCombos == false then
            set s = SaveSkillOrder(i, "r44")+ SaveSkillOrder(i, "r95")+ SaveSkillOrder(i, "r2")+ SaveSkillOrder(i, "r3")+ SaveSkillOrder(i, "r14")+ SaveSkillOrder(i, "r17")
            set s = SaveSkillOrder(i, "r6")+ SaveSkillOrder(i, "r7")+ SaveSkillOrder(i, "r8")+ SaveSkillOrder(i, "r9")+ SaveSkillOrder(i, "r123")+ SaveSkillOrder(i, "r11")+ SaveSkillOrder(i, "r12")+ SaveSkillOrder(i, "r15")+ SaveSkillOrder(i, "r16")
            set s = SaveSkillOrder(i, "r19")+ SaveSkillOrder(i, "r20")+ SaveSkillOrder(i, "r21")+ SaveSkillOrder(i, "r22")+ SaveSkillOrder(i, "r23")+ SaveSkillOrder(i, "r24")+ SaveSkillOrder(i, "r25")
            set s = SaveSkillOrder(i, "r26")+ SaveSkillOrder(i, "r27")+ SaveSkillOrder(i, "r28")
        endif
        call Z1E(i, "r29")
        call Z1E(i, "r30")
        call Z1E(i, "r31")
        set i = 20 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A21E')),'A21E', 0,'Y077', "t")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A01O')),'A01O', 0,'Y078', "r")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "forceofnature"),'AEfn', 0,'Y079', "f")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "stampede")+ SaveSkillOrder(i * 4 + 4, "r55"),'A1W8','A1W9','Y080', "w")
        set i = 21 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "spellstealoff"),'A10D', 0,'Y081', "t")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "animatedead"),'A46H', 0,'Y082', "d")
        call RegisterHeroSkill(i * 4 + 3, null,'A46E','A46D','Y084', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, null,'A0DB','QP0B','Y083', null)
        set HeroSkill_IsPassive[i * 4 + 4]= true
        set i = 22 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "phoenixmorph"),'A0LL', 0,'Y085', "v")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "carrionscarabson"),'A0BZ', 0,'Y086', "t")
        call RegisterHeroSkill(i * 4 + 3, null,'A19Q','QP1J','Y087', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, null,'A0CY','QP1K','Y088', null)
        set IsNoDeathMatchSkill[i * 4 + 4]= true
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 4, "HXzhangdahaimin")
        endif
        set HeroSkill_IsPassive[i * 4 + 4]= true
        set NoRearmCombosTips[i * 4 + 4]= "远程模型只增加 40/80/120 点攻击力"
        call Z1E(i * 4 + 4, "bgdmg1")
        call Z1E(i * 4 + 4, "bgdmg2")
        //set IsNoDeathMatchSkill[i * 4 + 4]= true
        set i = 23 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "item 89"),'A05J', 0,'Y089', "e")
        //if (not Mode__RearmCombos) then
        //	set s=SaveSkillOrder(i*4+1,"HXmines")
        //endif
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "stasistrap"),'A06H', 0,'Y090', "t")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "selfdestruct"),'A06B','A471','Y091', "c")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "ward"),'A0AK','A1FY','Y092', "r")
        set IsMultiIconSkill[i * 4 + 4]= true
        set i = 24 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "drunkenhaze"),'A0KM', 0,'Y093', "e")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "ancestralspirittarget")+ SaveSkillOrder(i * 4 + 2, "build"),'A0LV', 0,'Y094', "t")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "ambush"),'A28T','A361','Y095', "r")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "controlmagic")+ SaveSkillOrder(i * 4 + 4, "r6"),'A0LT','A1CS','Y096', "d")
        set i = 25 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "firebolt"),'A042', 0,'Y097', "c")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "arrows"),'A041','QP0D','Y098', null)
        
        //set IsNoDeathMatchSkill[i * 4 + 2]= true
        set HeroSkill_IsPassive[i * 4 + 2]= true
        call RegisterHeroSkill(i * 4 + 3, null,'A062','QP0E','Y099', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        set IsNoDeathMatchSkill[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "corporealform")+ SaveSkillOrder(i * 4 + 4, "r28"),'A054','A00U','Y100', "e")
        set i = 26 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "possession")+ SaveSkillOrder(i * 4 + 1, "metamorphosis"),'A064', 0,'Y101', "r")
        //set IsDisabledSkill[i*4+1]=true
        call RegisterHeroSkill(i * 4 + 2, null,'A03S','QP0F','Y102', null)
        set HeroSkill_IsPassive[i * 4 + 2]= true
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "range only"),'A03U','QP1Q','Y103', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        //set IsNoDeathMatchSkill[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "thunderbolt"),'A04P','A1AU','Y104', "t")
        set i = 27 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "metamorphosis")+ SaveSkillOrder(i * 4 + 1, "bearform")+ SaveSkillOrder(i * 4 + 1, "unbearform")+ SaveSkillOrder(i * 4 + 1, "melee morph")+ SaveSkillOrder(i * 4 + 1, "bash")+ SaveSkillOrder(i * 4 + 1, "yongjiu2"),'A0BE', 0,'Y105', "g")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "autodispel")+ SaveSkillOrder(i * 4 + 2, "loadarcher"),'A21M','A21N','Y106', "e")
        set IsMultiIconSkill[i * 4 + 2]= true
        call RegisterHeroSkill(i * 4 + 3, null,'A0O0','QP0G','Y107', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A1EJ')),'A1EJ', 0,'Y108', "r")
        set i = 28 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "forkedlightning"),'A010', 0,'Y109', "r")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "hex"),'A0RX', 0,'Y110', "d")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "magicleash"),'A00P', 0,'Y111', "e")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "ward")+ SaveSkillOrder(i * 4 + 4, "r7"),'A00H','A0A1','Y112', "w")
        if ExtraSkillsNumber == 2 then
            set ZTP[i * 4 + 4]= "该技能在此模式下会减少对建筑25%伤害"
        endif
        set i = 29 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A1TA'))+ SaveSkillOrder(i * 4 + 1, "frenzyoff"),'A1TA', 0,'Y113', "t")
        //set IsDisabledSkill[i * 4 + 1]= true
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A1T8'))+ SaveSkillOrder(i * 4 + 2, "battleroar")+ SaveSkillOrder(i * 4 + 2, "roar"),'A1T8', 0,'Y114', "w")
        set IsMultiIconSkill[i * 4 + 2]= true
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "manashieldon")+ SaveSkillOrder(i * 4 + 3, "manashieldoff"),'A28Q', 0,'Y115', "v")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "spellstealon"),'A1TB','A3FQ','Y116', "r")
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 4, "HXballl")
        endif
        call Z1E(i * 4 + 4, "r30")
        set i = 30 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "thunderclap"),'A06M', 0,'Y117', "c")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "drunkenhaze"),'Acdh', 0,'Y118', "d")
        call RegisterHeroSkill(i * 4 + 3, null,'A0MX','QP0H','Y119', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call Z6E(i * 4 + 3, "Mode__RandomDraft-Drunken")
        call Z6E(i * 4 + 3, "Tide-Drunken")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "elementalfury"),'A0MQ','A1B6','Y120', "r")
        set i = 31 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "stomp"),'A00S', 0,'Y121', "f")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "firebolt"),'A00L', 0,'Y122', "d")
        call RegisterHeroSkill(i * 4 + 3, null,'A00V','QP0I','Y123', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A2O6'))+ SaveSkillOrder(i * 4 + 4, "r8"),'A2O6','A384','Y124', "t")
        set i = 32 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "thunderbolt"),'A004', 0,'Y125', "t")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "nagabuild")+ SaveSkillOrder(i * 4 + 2, "r9"),'A1IQ', 0,'Y126', null)
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 2, "HXshuidaorenshu")
        endif
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 2, "HXrenshuhaimin")
        endif
        set HeroSkill_IsPassive[i * 4 + 2]= true
        set NoRearmCombosTips[i * 4 + 2]= "如果同时选择了无影拳或长大！，忍术只会造成 1.25/1.45/1.65/1.85倍 的伤害"
        call Z6E(i * 4 + 2, "Tide-Jinada")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "windwalk"),'A07A', 0,'Y127', "w")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "faeriefire"),'A0B4', 0,'Y128', "r")
        set i = 33 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A03F')),'A03F', 0,'Y129', "f")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "thunderbolt"),'A0AR', 0,'Y130', "t")
        set s = SaveSkillOrder(i * 4 + 2, "HXLongqilanmao")
        call RegisterHeroSkill(i * 4 + 3, null,'A0CL','QP0J','Y131', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        //set IsNoDeathMatchSkill[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "metamorphosis")+ SaveSkillOrder(i * 4 + 4, "range morph"),'QM00', 0,'Y132', "r")
        set i = 34 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "orb effect"),'A022','QP0K','Y133', null)
        set HeroSkill_IsPassive[i * 4 + 1]= true
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('AEbl')),'AEbl', 0,'Y134', "b")
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 2, "HXshijianmanbu")
        endif
        call RegisterHeroSkill(i * 4 + 3, null,'A0KY','QP0L','Y135', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "thunderbolt"),'A0E3', 0,'Y136', "v")
        set i = 35 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "arrows")+ SaveSkillOrder(i * 4 + 1, "range only"),'A026', 0,'Y137', "r")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "silence"),'A33A', 0,'Y138', "e")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "defend"),'A2O2', 0,'Y139', "t")
        set NoRearmCombosTips[i * 4 + 3]= "强击光环效果只作用于远程单位，无论你选择的是近战或远程"
        call RegisterHeroSkill(i * 4 + 4, null,'QF88', 0,'QY88', null)
        set HeroSkill_IsPassive[i * 4 + 4]= true
        set i = 36 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "channel"),'A08N', 0,'Y141', "r")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "antimagicshell"),'A08V', 0,'Y142', "e")
        call RegisterHeroSkill(i * 4 + 3, null,'A06A','QP0M','Y143', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "battleroar"),'A0ER','A2S8','Y144', "g")
        set i = 37 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "massteleport"),'A0O1', 0,'Y145', "w")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "awaken")+ SaveSkillOrder(i * 4 + 2, "unsummon"),'A0OO', 0,'Y146', "d")
        set IsMultiIconSkill[i * 4 + 2]= true
        call RegisterHeroSkill(i * 4 + 3, null,'A0BD','QP0N','Y147', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "thunderbolt"),'A0O2','A289','Y148', "r")
        set i = 38 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A0O7')),'A0O7', 0,'Y149', "d")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A0O6')),'A0O6', 0,'Y150', "t")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, GetAbilityOrder('A30T')),'A30T', 0,'Y151', "e")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A0O5')),'A0O5','A1B1','Y152', "r")
        set i = 39 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "preservation"),'A0IL', 0,'Y153', "d")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A1NI'))+ SaveSkillOrder(i * 4 + 2, "corrosivebreath"),'A1NI', 0,'Y154', "e")
        call RegisterHeroSkill(i * 4 + 3, null,'A0O3','QP0O','Y155', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "metamorphosis")+ SaveSkillOrder(i * 4 + 4, "melee morph")+ SaveSkillOrder(i * 4 + 4, "r25"),'QB0K', 0,'QY0K', "r")
        set i = 40 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "coupleinstant"),'A0KV', 'A3UG','Y157', "t")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "spies"),'A0L8', 0,'Y158', "r")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "windwalk"),'A0LN', 0,'Y159', "e")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "corporealform")+ SaveSkillOrder(i * 4 + 4, "r11"),'A0KU', 0,'Y160', "w")
        set i = 41 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A14P')),'A14P', 0,'Y161', "r")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A14R')),'A14R','A3WT','Y162', "e")
        call RegisterHeroSkill(i * 4 + 3, null,'A0QW','QP1V','Y163', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        set NoRearmCombosTips[i * 4 + 3]= "冷却时间3秒及以下的技能每施放2次才会触发1次超负荷（球形闪电除外）"
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "channel"),'A14O','A3FJ','Y164', "g")
        set s = SaveSkillOrder(i * 4 + 4, "HXLongqilanmao")
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 4, "HXballl")
        endif
        set i = 42 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "holybolt"),'A0QP', 0,'Y165', "v")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "arrows"),'A0QN', 0,'Y166', "r")
        call RegisterHeroSkill(i * 4 + 3, null,'A0QQ','QP1L','Y167', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "firebolt"),'A0QR','A1B3','Y168', "f")
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 4, "yidaonimane")
        endif
        set i = 43 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A1EA')),'A1EA', 0,'Y169', "r")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "windwalk"),'A0RV', 0,'Y170', "w")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "range only"),'A0RO','QP1S','Y171', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        //set IsNoDeathMatchSkill[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "curse")+ SaveSkillOrder(i * 4 + 4, "spiritwolf"),'A0RP','A449','Y172', "c")
        //	set IsDisabledSkill[i*4+4]=true
        set IsMultiIconSkill[i * 4 + 4]= true
        set i = 44 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "spiritlink")+ SaveSkillOrder(i * 4 + 1, "coupletarget"),'A0S9', 0,'Y173', "r")
        set IsMultiIconSkill[i * 4 + 1]= true
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "creepanimatedead"),'A0SC', 0,'Y174', "w")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "phaseshift"),'A0SB', 0,'Y175', "f")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "rainofchaos"),'A0S8','A1QP','Y176', "c")
        set i = 45 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "creepdevour"),'A0Z4', 0,'Y177', "e")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "neutraldetectaoe"),'A0Z5', 0,'Y178', "c")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "blizzard"),'A0Z6', 0,'Y179', "r")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "clusterrockets"),'A0Z8','A1CV','Y180', "t")
        set i = 46 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "rejuvination"),'A136', 0,'Y181', "e")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "r12"),'A13T', 0,'Y182', null)
        set HeroSkill_IsPassive[i * 4 + 2]= true
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 2, "HXshuidaohaimin")
        endif
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 2, "HXshuidaorenshu")
        endif
        set HeroSkill_IsPassive[i * 4 + 2]= true
        set NoRearmCombosTips[i * 4 + 2]= "远程模型使用水刀只造成80%的范围伤害"
        call Z1E(i * 4 + 2, "bgdmg2")
        call Z6E(i * 4 + 2, "Tide-Jinada")
        call Z6E(i * 4 + 2, "Tide-Drunken")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "incineratearrow")+ SaveSkillOrder(i * 4 + 3, "incineratearrowoff"),'A11N', 0,'Y183', "x")
        call Z1E(i * 4 + 3, "r29")
        set IsMultiIconSkill[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "spiritofvengeance"),'A11K','Z31K','Y184', "t")
        set i = 47 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A12J')),'A12J', 0,'Y185', "e")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "spirittroll"),'A12K', 0,'Y186', "r")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, GetAbilityOrder('A14I')),'A14I', 0,'Y187', "w")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "incineratearrowon"),'A12P','A1D6','Y188', "f")
        set i = 48 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "creepthunderbolt"),'A1SO', 0,'Y189', "r")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A1SQ')),'A1SQ', 0,'Y190', "g")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "orb effect")+ SaveSkillOrder(i * 4 + 3, "range only")+ SaveSkillOrder(i * 4 + 3, GetAbilityOrder('A229'))+ SaveSkillOrder(i * 4 + 3, "multi-attack"),'A229', 0,'Y191', "f")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "silence"),'A1T5','A235','Y192', "c")
        set i = 49 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "autodispel"),'A1TV', 0,'Y193', "c")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A1SW')),'A1SW', 0,'Y194', "d")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "rechargeoff"),'A1SU', 0,'Y195', "e")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "deathpact"),'A1U6','A30N','Y196', "r")
        set i = 50 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "standdown"),'A1YO', 0,'Y197', "e")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "frenzyon"),'A1S7', 0,'Y198', "w")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "summongrizzly"),'A1YR', 0,'Y199', "f")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A1YQ'))+ SaveSkillOrder(i * 4 + 4, "autoharvestlumber"),'A1YQ','A3DE','Y200', "r")
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 4, "HXzhangdahaimin")
        endif
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 4, "HXrenshuhaimin")
        endif
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 4, "HXshuidaohaimin")
        endif
        call Z1E(i * 4 + 4, "bgdmg2")
        set i = 51 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "creepthunderclap"),'A1RJ', 0,'Y201', "d")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "gold2lumber")+ SaveSkillOrder(i * 4 + 2, "harvest"),'A1YX', 0,'Y202', "f")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "charm")+ SaveSkillOrder(i * 4 + 3, "immolation")+ SaveSkillOrder(i * 4 + 3, "unimmolation")+ SaveSkillOrder(i * 4 + 3, "animatedead"),'A1YY', 0,'Y203', "r")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "rechargeon")+ SaveSkillOrder(i * 4 + 4, "r123")+ SaveSkillOrder(i * 4 + 4, "locust"),'A1RK','A43H','Y204', "v")
        set i = 52 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "darkritual"),'A0FW','A3OD','Y205', "g")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A0GP')),'A0GP', 0,'Y206', "r")
        call RegisterHeroSkill(i * 4 + 3, null,'A0M3','QP1M','Y207', null)
        //set IsDisabledSkill[i*4+3]=true
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, null,'A0FV','QP1N','Y208', null)
        set HeroSkill_IsPassive[i * 4 + 4]= true
        set NoRearmCombosTips[i * 4 + 4]= "冷却时间在3秒及以下的技能每使用2次才触发1次战意（刺针扫射和粘稠鼻液除外）"
        set i = 53 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "wispharvest"),'A27F', 0,'Y209', "z")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "tranquility"),'A27G', 0,'Y210', "x")
        call RegisterHeroSkill(i * 4 + 3, null,'A27V','QP0P','Y211', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "transmute")+ SaveSkillOrder(i * 4 + 4, "shbug"),'A27H','A30J','Y212', "q")
        set IsMultiIconSkill[i * 4 + 4]= true
        set i = 54 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A2H3')),'A2H3', 0,'Y213', "c")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "recharge")+ SaveSkillOrder(i * 4 + 2, "metamorphosis")+ SaveSkillOrder(i * 4 + 2, "shuashecheng")+ SaveSkillOrder(i * 4 + 2, "yongjiu1"),'QB0L', 0,'QY0L', "t")
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 2, "HXLianji")//+ SaveSkillOrder(i * 4 + 2, "melee morph")
        endif
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "darksummoning")+ SaveSkillOrder(i * 4 + 2, "r27"),'A2HS', 0,'Y215', "e")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "ancestralspirit")+ SaveSkillOrder(i * 4 + 4, "acolyteharvest"),'A2JR','A2JL','Y216', "f")
        set IsMultiIconSkill[i * 4 + 4]= true
        //	set IsDisabledSkill[i * 4 + 4]= true
        set i = 55 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "steal"),'A2JB', 0,'Y217', "w")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "creepheal"),'A2J2', 0,'Y218', "t")
        call RegisterHeroSkill(i * 4 + 3, null,'A2EY','QP1O','Y219', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "autodispeloff"),'A2CI','A38C','Y220', "d")
        set i = 56 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A2BE')),'A2BE', 0,'Y221', "c")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A2IT')),'A2IT', 0,'Y222', "t")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "soulburn"),'A2HN', 0,'Y223', "d")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "submerge"),'A2BG','A30H','Y224', "e")
        set i = 57 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A2FK')),'A2FK', 0,'Y225', "d")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "summonfactory"),'A2E3', 0,'Y226', "t")
        call RegisterHeroSkill(i * 4 + 3, null,'A2E4','QP1P','Y227', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "immolation")+ SaveSkillOrder(i * 4 + 4, "unimmolation")+ SaveSkillOrder(i * 4 + 4, "windwalk")+ SaveSkillOrder(i * 4 + 4, "auraunholy"),'A2E5','A43S','Y228', "r")
        set i = 58 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "spiritwolf"),'A03D', 0,'Y229', "v")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "deathcoil"),'A0ZF', 0,'Y230', "w")
        call RegisterHeroSkill(i * 4 + 3, null,'A03E','QP0Q','Y231', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        set IsNoDeathMatchSkill[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "metamorphosis")+ SaveSkillOrder(i * 4 + 4, "melee morph")+ SaveSkillOrder(i * 4 + 4, "r95"),'QM02', 0,'Y232', "f")
        set i = 59 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "parasite"),'A0BH', 0,'Y233', "w")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "restoration")+ SaveSkillOrder(i * 4 + 2, "inv bug 1"),'Z234', 0,'Y234', "b")
        set IsNoDeathMatchSkill[i * 4 + 2]= true
        //set IsDisabledSkill[i * 4 + 2]= true	//暂时禁用织网
        call RegisterHeroSkill(i * 4 + 3, null,'Q0BK','QP29','Y235', null)
        set IsDisabledSkill[i * 4 + 3]= true
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "bash")+ SaveSkillOrder(i * 4 + 4, "roar"),'A0WQ', 0,'Y236', "t")
        set i = 60 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "summonphoenix"),'A0YM', 0,'Y237', "d")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "deathcoil"),'A0PL', 0,'Y238', "b")
        call RegisterHeroSkill(i * 4 + 3, null,'A03P','QP0R','Y239', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, null,'A03Q','QP0S','Y240', null)
        set HeroSkill_IsPassive[i * 4 + 4]= true
        set i = 61 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "range only")+ SaveSkillOrder(i * 4 + 1, "immolation")+ SaveSkillOrder(i * 4 + 1, "unimmolation"),'A1C0','A418','Y241', "r")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A0G2')),'A0G2', 0,'Y242', "c")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "manashieldon")+ SaveSkillOrder(i * 4 + 3, "manashieldoff")+ SaveSkillOrder(i * 4 + 3, "shbug"),'A0MP', 0,'Y243', "e")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "lavamonster"),'A1AT', 0,'Y244', "g")
        set i = 62 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "thunderbolt"),'A02H', 0,'Y245', "v")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "drunkenhaze"),'A08Q', 0,'Y246', "f")
        call RegisterHeroSkill(i * 4 + 3, null,'P247','A086','Y247', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "battlestations")+ SaveSkillOrder(i * 4 + 4, "r14"),'DRKN', 0,'Y248', "r")
        set IsNoDeathMatchSkill[i * 4 + 4]= true
        set i = 63 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "thunderbolt"),'QB0H', 0,'QY0H', "t")
        call RegisterHeroSkill(i * 4 + 2, null,'P250','QP0U','Y250', null)
        set HeroSkill_IsPassive[i * 4 + 2]= true
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "wispharvest"),'A2S0','QP0W','Y251', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "reincarnation")+ SaveSkillOrder(i * 4 + 4, "r15"),'A01Y','A1AZ','Y252', null)
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 4, "HXqwew")
        endif
        set HeroSkill_IsPassive[i * 4 + 4]= true
        set i = 64 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "channel")+ SaveSkillOrder(i * 4 + 1, "animatedead")+ SaveSkillOrder(i * 4 + 1, "stomp")+ SaveSkillOrder(i * 4 + 1, "tornado")+ SaveSkillOrder(i * 4 + 1, "ensnare")+ SaveSkillOrder(i * 4 + 1, "thunderclap")+ SaveSkillOrder(i * 4 + 1, "purge"),'A10R','A32Z','Y253', "e")
        set s = SaveSkillOrder(i * 4 + 1, "frostarmor")+ SaveSkillOrder(i * 4 + 1, "manaburn")+ SaveSkillOrder(i * 4 + 1, "heal")+ SaveSkillOrder(i * 4 + 1, "raisedead")+ SaveSkillOrder(i * 4 + 1, "thunderbolt")
        set IsMultiIconSkill[i * 4 + 1]= true
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A1OP')),'A1OP', 0,'Y254', "t")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "firebolt"),'A094', 0,'Y255', "v")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "doom"),'A0MU','A0A2','Y256', "d")
        set i = 65 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "impale"),'A0X7', 0,'Y257', "e")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "creepheal"),'A1H5', 0,'Y258', "r")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, GetAbilityOrder('A2KO')),'A2KO', 0,'Y259', "d")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "windwalk"),'A09U', 0,'Y260', "v")
        set i = 66 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "berserk"),'A05C', 0,'Y261', "w")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "roar"),'A29K', 0,'Y262', "r")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "bash"),'A0JJ', 0,'Y263', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "faeriefire"),'QB0C', 0,'QY0C', "g")
        set i = 67 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "shadowstrike"),'A0Q7', 0,'Y265', "d")
        
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A0ME')),'A0ME', 0,'Y266', "b")
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 2, "HXshijianmanbu")
        endif
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, GetAbilityOrder('A04A')),'A04A', 0,'Y267', "f")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A28R')),'A28R','A28S','Y268', "w")
        set i = 68 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "berserk"),'A030', 0,'Y269', "t")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "arrows")+ SaveSkillOrder(i * 4 + 2, "range only")+ SaveSkillOrder(i * 4 + 2, "channel"),'AHfa', 0,'Y270', "r")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "windwalk"),'QB0A', 0,'QY0A', "w")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "innerfire"),'A04Q', 0,'Y272', "e")
        set i = 69 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A0LK')),'A0LK', 0,'Y273', "w")
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 1, "HXshijianmanbu")
        endif
        call RegisterHeroSkill(i * 4 + 2, null,'A0CZ','QP22','Y274', null)
        set HeroSkill_IsPassive[i * 4 + 2]= true
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "bash"),'A081','QP0X','Y275', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "clusterrockets")+ SaveSkillOrder(i * 4 + 4, "r16"),'A0J1','A1D7','Y276', "c")
        set i = 70 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "arrows")+ SaveSkillOrder(i * 4 + 1, "range only"),'A09V', 0,'Y277', "c")
        call RegisterHeroSkill(i * 4 + 2, null,'A1A3','QP21','Y278', null)
        set HeroSkill_IsPassive[i * 4 + 2]= true
        call RegisterHeroSkill(i * 4 + 3, null,'A0MM','QP0Y','Y279', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "shadowstrike"),'A080','A1UZ','Y280', "d")
        set i = 71 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A1E7')),'A1E7', 0,'Y281', "f")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "tankdroppilot"),'A1DP', 0,'Y282', "c")
        call RegisterHeroSkill(i * 4 + 3, null,'A1E6','QP0Z','Y283', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "darkportal"),'A1AO','A1UV','Y284', "e")
        set i = 72 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "852273"),'A0T2', 0,'Y285', "r")
        set s = SaveSkillOrder(i * 4 + 1, "HXMomianwange")
        call RegisterHeroSkill(i * 4 + 2, null,'A0SS','QP1W','Y286', null)
        set HeroSkill_IsPassive[i * 4 + 2]= true
        set NoBalanceOffTips[i * 4 + 2]= "远程模型使用盛宴只造成/回复 1.75/2.75/3.75/4.75% 生命值的伤害"
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, GetAbilityOrder('A194')),'A194', 0,'Y287', "w")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "decouple"),'A0SW', 0,'Y288', "t")
        set i = 73 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "grabtree"),'A0MT', 0,'Y289', "b")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "banish"),'A2TD', 0,'Y290', "c")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "tornado"),'A09D', 0,'Y291', "w")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "drain"),'A0CC','A02Z','Y292', "d")
        set HeroSkill_Icon[i * 4 + 4]= "ReplaceableTextures\\CommandButtons\\BTNLifeDrain.blp"
        set i = 74 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A046')),'A046','A3OH','Y293', "g")
        call RegisterHeroSkill(i * 4 + 2, null,'A04E','QP10','Y294', null)
        set HeroSkill_IsPassive[i * 4 + 2]= true
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "roar"),'A226', 0,'Y295', "c")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "howlofterror"),'A29I', 0,'Y296', "v")
        set i = 75 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "innerfire"),'A04V', 0,'Y297', "e")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A0GK')),'A0GK', 0,'Y298', "b")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "sleep"),'A04Y', 0,'Y299', "t")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "magicleash"),'A02Q','A1D9','Y300', "f")
        set i = 76 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A05V')),'A05V', 0,'Y301', "d")
        call RegisterHeroSkill(i * 4 + 2, null,'A01N','QP11','Y302', null)
        set HeroSkill_IsPassive[i * 4 + 2]= true
        call RegisterHeroSkill(i * 4 + 3, null,'A060','QP12','Y303', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "thunderbolt")+ SaveSkillOrder(i * 4 + 4, "yidaonimane"),'A067','A08P','Y304', "r")
        set i = 77 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "detectaoe"),'A06I', 0,'Y305', "t")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "unimmolation"),'A06K', 0,'Y306', "r")
        call RegisterHeroSkill(i * 4 + 3, null,'A06D','QP13','Y307', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "magicleash"),'A0FL','A1CX','Y308', "d")
        set i = 78 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "detonate"),'A1P8', 0,'Y309', "c")
        call RegisterHeroSkill(i * 4 + 2, null,'A0ES','QP14','Y310', null)
        set HeroSkill_IsPassive[i * 4 + 2]= true
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "bash"),'A0G5','QP1X','Y311', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "creepheal"),'A0G4','A1D8','Y312', "e")
        set i = 79 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "tankloadpilot"),'A1QW', 0,'Y313', "r")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "windwalk"),'A0CA', 0,'Y314', "c")
        
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "orb effect")+ SaveSkillOrder(i * 4 + 3, "range only"),'A0CG', 0,'Y315', null)
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 3, "HXLianji")
        endif
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call Z1E(i * 4 + 3, "bgdmg2")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "disassociate"),'A0CT','A3DM','Y316', "t")
        call Z1E(i * 4 + 4, "r31")
        set i = 80 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "roar")+ SaveSkillOrder(i * 4 + 1, "howlofterror")+ SaveSkillOrder(i * 4 + 1, "battleroar"),'A0EY', 0,'Y317', "z")
        set IsMultiIconSkill[i * 4 + 1]= true
        call RegisterHeroSkill(i * 4 + 2, null,'Z318','A0BR','Y318', null)
        set HeroSkill_IsPassive[i * 4 + 2]= true
        call RegisterHeroSkill(i * 4 + 3, null,'A0FU','QP15','Y319', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 1, "852273"),'A29J','A3OJ','Y320', "r")
        set s = SaveSkillOrder(i * 4 + 4, "HXMomianwange")
        set i = 81 - 1
        //call RegisterHeroSkill(i*4+1,SaveSkillOrder(i*4+1,"disenchant"),'A06O',0,'Y321',"m")
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "disenchant"),'A06O','A3NX','Y321', "e")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "voodoo"),'A0H0', 0,'Y322', "r")
        call RegisterHeroSkill(i * 4 + 3, null,'A0FA','QP16','Y323', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "lightningshield"),'A06R','A1B4','Y324', "c")
        set i = 82 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "dismount"),'A0I6', 0,'Y325', "e")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "creepheal"),'A0S1', 0,'Y326', "r")
        call RegisterHeroSkill(i * 4 + 3, null,'A0C6','QP17','Y327', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A0E2')),'A0E2','A1MR','Y328', "c")
        set i = 83 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "farsight"),'A44X', 0,'Y61A', "d")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "creepheal"),'A44Z', 0,'Y61B', "b")
        call RegisterHeroSkill(i * 4 + 3, null,'A0I8','QP1Z','Y331', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "shadowsight"),'A0LH', 0,'Y332', "r")
        set i = 84 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "townbelloff"),'A0I3', 0,'Y333', "d")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A0MF')),'A0MF', 0,'Y334', "g")
        call RegisterHeroSkill(i * 4 + 3, null,'A0MG','QP18','Y335', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "windwalk")+ SaveSkillOrder(i * 4 + 4, "r17"),'A0NS','A1DA','Y336', "b")
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 4, "HXqwew")
        endif
        set i = 85 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "impale"),'A0HW', 0,'Y337', "d")
        call RegisterHeroSkill(i * 4 + 2, null,'A0FX','QP19','Y338', null)
        set HeroSkill_IsPassive[i * 4 + 2]= true
        set NoRearmCombosTips[i * 4 + 2]= "远程英雄和幻象只造成一半的荒芜伤害"
        call RegisterHeroSkill(i * 4 + 3, null,'A0NA','QP20','Y339', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        set NoRearmCombosTips[i * 4 + 3]= "力量模型只折射 8/10/12/14% 的伤害"
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "healingspray")+ SaveSkillOrder(i * 4 + 4, "healingwave")+ SaveSkillOrder(i * 4 + 4, "r18"),'A0H9', 0,'Y340', "t")
        set IsMultiIconSkill[i * 4 + 4]= true
        set i = 86 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A0NM')),'A0NM', 0,'Y341', "c")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "unimmolation"),'A0NE', 0,'Y342', "v")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "renew"),'A0NO', 0,'Y343', "e")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "tornado"),'A0NT','A0NX','Y344', "d")
        set i = 87 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "arrows")+ SaveSkillOrder(i * 4 + 1, "range only"),'A0OI', 0,'Y345', "r")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A0OJ')),'A0OJ', 0,'Y346', "t")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "r19"),'A0IF','QP1A','Y347', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        set NoRearmCombosTips[i * 4 + 3]= "若同时学习了球状闪电，则精气光环触发时只恢复8/10/12/14%的最大魔法"
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "blizzard"),'A0OK','A1VW','Y348', "c")
        set i = 88 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "autodispelon"),'A0J5', 0,'Y349', "f")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "creepheal"),'A0AS', 0,'Y350', "w")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "blizzard"),'A06P', 0,'Y351', "e")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "inferno")+ SaveSkillOrder(i * 4 + 4, "r20"),'S008','S00U','Y352', "r")
        set i = 89 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "renewon"),'A0NB', 0,'Y353', "e")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "carrionscarabsoff"),'A0N8', 0,'Y354', "f")
        call RegisterHeroSkill(i * 4 + 3, null,'A0N7','QP1B','Y355', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, null,'A0MW','A27C','Y356', null)
        set IsDisabledSkill[i * 4 + 4]= true
        set i = 90 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "thunderbolt"),'A0NQ', 0,'Y357', "t")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "devourmagic"),'A10L', 0,'Y358', "g")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "darkportal"),'A0OR', 0,'Y359', "d")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "renewoff"),'A10Q','A1DB','Y360', "w")
        set i = 91 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "rainoffire"),'A01I', 0,'Y361', "f")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "flamestrike"),'A0RA', 0,'Y362', "t")
        call RegisterHeroSkill(i * 4 + 3, null,'AIcd','QP1C','Y363', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "divineshield")+ SaveSkillOrder(i * 4 + 4, "whirlwind"),'A0R0', 0,'Y364', "d")
        set i = 92 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "repair, str bug"),'A15S','A3JX','Y365', "d")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "lumber2gold"),'A0R5', 0,'Y366', "r")
        //set IsDisabledSkill[i*4+2]=true
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "soulpreservation")+ SaveSkillOrder(i * 4 + 3, "r21"),'A15V', 0,'Y367', "t")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "metamorphosis")+ SaveSkillOrder(i * 4 + 4, "melee morph")+ SaveSkillOrder(i * 4 + 4, "r24"),'QM03', 0,'Y368', "f")
        set IsMultiIconSkill[i * 4 + 4]= true
        set i = 93 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "repairoff"),'A0QE', 0,'Y369', "c")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "autoentangle")+ SaveSkillOrder(i * 4 + 2, "r26"),'A0QG', 0,'Y370', "e")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "bloodlust"),'A0R7', 0,'Y371', "r")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "manaflareon"),'A0QK','A21Q','Y372', "w")
        set i = 94 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "tranquility"),'A32A', 0,'A32T', "f")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "curse"),'A32C', 0,'A32U', "w")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "eattree")+ SaveSkillOrder(i * 4 + 3, "controlmagic"),'A32E', 0,'A32V', "d")
        set IsMultiIconSkill[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A32G')),'A32G', 0,'A32W', "r")
        set i = 95 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "townbellon"),'A0I7', 0,'Y377', "f")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "autoentangleinstant"),'A180', 0,'Y378', "c")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "load"),'A0B1', 0,'Y379', "d")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "cannibalize"),'A1BX','A30L','Y380', "b")
        set i = 96 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "repairon"),'A1EL', 0,'Y381', "c")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "autoharvestgold"),'A19V', 0,'Y382', "r")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "metamorphosis")+ SaveSkillOrder(i * 4 + 3, "range morph")+ SaveSkillOrder(i * 4 + 3, "r3"),'QM04', 0,'Y383', "e")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A19O')),'A19O','A1MV','Y384', "f")
        set i = 97 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "etherealform"),'A1MG', 0,'Y385', "c")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "replenish"),'A1HS', 0,'Y386', "e")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "berserk"),'A1HQ', 0,'Y387', "g")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "taunt")+ SaveSkillOrder(i * 4 + 4, "r22"),'A1MI','A2QE','Y388', "t")
        set i = 98 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A1IM')),'A1IM', 0,'Y389', "c")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "whirlwind"),'A1J7', 0,'Y390', "e")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "abuz agi") ,'A1HR','QP1F','Y391', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        set NoBalanceOffTips[i * 4 + 3]= "远程模型使用能量转移只有2/3的效果"
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "windwalk")+ SaveSkillOrder(i * 4 + 4, "ibug"),'A1IN', 0,'Y392', "d")
        set i = 99 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "replenishoff"),'A2KZ', 0,'Y393', "c")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "board"),'A0H4', 0,'Y394', "e")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "metamorphosis")+ SaveSkillOrder(i * 4 + 3, "range morph")+ SaveSkillOrder(i * 4 + 3, "chemicalrage"),'A1RI', 0,'Y395', "t")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A07Q')),'A07Q', 0,'Y396', "r")
        set i = 100 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "requestsacrifice"),'QB0F', 0,'QY0F', "t")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A20T')),'A20T', 0,'Y398', "c")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, GetAbilityOrder('A06V')),'A06V', 0,'Y399', "g")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "berserk"),'A21F','A21G','Y400', "v")
        set i =101 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A1S8')),'A1S8', 0,'Y401', "d")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "replenishon"),'A1SB', 0,'Y402', "c")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "fingerofdeath")+ SaveSkillOrder(i * 4 + 3, "flare"),'A1S4', 0,'Y403', "w")
        set IsMultiIconSkill[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "blizzard"),'A343','A34J','Y404', "g")
        set i ='f' - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "frostnova"),'A07F', 0,'Y405', "v")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "frostarmor"),'A08R', 0,'Y406', "f")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "innerfire"),'A053', 0,'Y407', "e")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "thunderbolt"),'A05T','A08H','Y408', "c")
        set i ='g' - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A078')),'A078', 0,'Y409', "r")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "silence"),'A07M', 0,'Y410', "e")
        call RegisterHeroSkill(i * 4 + 3, null,'A02C', 0,'Y411', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "locustswarm"),'A04N', 0,'Y412', "x")
        if ExtraSkillsNumber == 2 then
            set ZTP[i * 4 + 4]= "该技能在此模式下会减少对建筑25%伤害"
        endif
        set HeroSkill_Icon[i * 4 + 4]= "ReplaceableTextures\\CommandButtons\\BTNExorcism.blp"
        set i =104 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "freezingbreath"),'A0X5', 0,'Y413', "e")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "hex"),'A0MN', 0,'Y414', "d")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "drain"),'A02N', 0,'Y415', "r")
        set HeroSkill_Icon[i * 4 + 3]= "ReplaceableTextures\\CommandButtons\\BTNManaDrain.blp"
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A095')),'A095','A09W','Y416', "f")
        set i ='i' - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "magicdefense"),'A173', 0,'Y417', "e")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "buff placer"),'A0MY','QP1D','Y418', null)
        set HeroSkill_IsPassive[i * 4 + 2]= true
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "ward"),'A0MS', 0,'Y419', "w")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "summongrizzly"),'A013','A0A6','Y420', "v")
        set i =106 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A02S')),'A02S','A3Y8','Y421', "w")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "innerfire"),'A037', 0,'Y422', "e")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "blackarrowon"),'A1RD', 0,'Y423', "d")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "roar"),'A29L','A447','Y424', "v")
        set i ='k' - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "cripple"),'A08X', 0,'Y425', "g")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "creepheal"),'A1NA', 0,'Y426', "c")
        set IsMultiIconSkill[i * 4 + 2]= true
        call RegisterHeroSkill(i * 4 + 3, null,'A0VX','QP23','Y427', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A1NE')),'A1NE','A2IG','Y428', "t")
        set i =108 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "tankpilot"),'A055', 0,'Y429', "c")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "forceboard"),'A0RW', 0,'Y430', "e")
        call RegisterHeroSkill(i * 4 + 3, null,'A03N','QP1E','Y431', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A03O')),'A03O', 0,'Y432', "t")
        set i =109 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "stomp")+ SaveSkillOrder(i * 4 + 1, "range morph")+ SaveSkillOrder(i * 4 + 1, "r44")+ SaveSkillOrder(i * 4 + 1, "metamorphosis")+ SaveSkillOrder(i * 4 + 1, "yongjiu3"),'A332', 0,'Y437', "r")
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 1, "HXBinglongTuijin")
        endif
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "unstoneform"),'A2LA', 0,'Y438', "t")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "townbellon"),'A2LB', 0,'Y439', "e")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "unwindwalk"),'A0Z0', 0,'Y440', "w")
        set i = 110 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "unravenform"),'A2M1', 0,'Y433', "c")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "unrobogoblin"),'A2LM', 0,'Y434', "f")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "undeadbuild"),'A2LL', 0,'Y435', "r")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "metamorphosis")+ SaveSkillOrder(i * 4 + 4, "summongrizzly"),'A2M0', 0,'Y436', "d")
        set IsDisabledSkill[i * 4 + 4]= true
        set i =111 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "cripple"),'A2QM', 0,'Y443', "d")
        set IsMultiIconSkill[i * 4 + 1]= true
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "unsubmerge"),'A2TJ', 0,'Y444', "f")
        set IsMultiIconSkill[i * 4 + 2]= true
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "unflamingarrows"),'A2QI', 0,'Y445', "r")
        set IsMultiIconSkill[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "summonwareagle"),'A2TI', 0,'Y446', "t")
        set IsMultiIconSkill[i * 4 + 4]= true
        set i =112 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "webon"),'A2QT', 0,'Y453', "t")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A2T5')),'A2T5', 0,'Y454', "f")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "avengerform"),'A2SG', 0,'Y455', "e")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "lavamonster"),'A2TF', 0,'Y456', "r")
        set i ='q' - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A1PH')),'A1PH', 0,'Y458', "e")
        call RegisterHeroSkill(i * 4 + 2, null,'A33Q','A33R','Y459', null)
        set HeroSkill_IsPassive[i * 4 + 2]= true
        //	if (not Mode__RearmCombos) then
        //		set IsDisabledSkill[i * 4 + 2]= true
        //	endif
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "magicdefense"),'A34A','QP28','A34B', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "barkskinoff"),'A33U', 0,'Y460', "g")
        if (Mode__SingleDraft or Mode__MirrorDraft or Mode__AllRandom) == false then
            set i = 114 - 1
            call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "request_hero")+ SaveSkillOrder(i * 4 + 1, "r23"),'Z601', 0,'Y601', "t")
            call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "mechanicalcritter"),'Z602', 0,'Y602', "d")
            call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "militia"),'Z603', 0,'Y603', "f")
            call RegisterHeroSkill(i * 4 + 4, null, 0, 0, 0, null)
            set IsDisabledSkill[i * 4 + 4]= true
            set i = 115 - 1
            call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "militiaconvert"),'Z604', 0,'Y604', "y")
            call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "windwalk"),'Z605', 0,'Y605', "v")
            call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "militiaoff"),'Z606', 0,'Y606', "g")
            call RegisterHeroSkill(i * 4 + 4, null, 0, 0, 0, null)
            set IsDisabledSkill[i * 4 + 4]= true
            set i = 116 - 1
            call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "militiaunconvert"),'Z607', 0,'Y607', "Z")
            call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "mindrot"),'Z608', 0,'Y608', "x")
            call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "monsoon"),'Z609', 0,'Y609', "c")
            call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "mount"),'Z610','A3K5','Y610', "b")
            call AddControlSkillIndex(i * 4 + 4)
            call ExecuteFunc("PreloadKael_Ability")
        endif
        set i = 117 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "unload"),'A40K','A40S','Y500', "j")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "unloadall"),'A40L','A40T','Y501', "k")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "unloadallcorpses"),'A40M','A40U','Y502', "l")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "undeadbuild"),'A40N','A40V','Y503', "i")
        //set IsDisabledSkill[i * 4 + 4]= true	无形
        set i = 118 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "lavamonster"),'A0QV', 0,'Y614', "d")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "carrionscarabs")+ SaveSkillOrder(i * 4 + 2, "carrionscarabsoff")+ SaveSkillOrder(i * 4 + 2, "carrionscarabson"),'A43Y', 0,'Y615', "q")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "carrionscarabs")+ SaveSkillOrder(i * 4 + 3, "carrionscarabsoff")+ SaveSkillOrder(i * 4 + 3, "carrionscarabson"),'A00T', 0,'Y616', "q")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "renew"),'A46J', 0,'Y61K', "c")
        set i = 119 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "soulburn"),'A0EC', 0,'Y329', "d")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "lumber2gold"),'A44U', 0,'Y618', "e")
        //set IsDisabledSkill[i * 4 + 2]= true	下注
        if Mode__SixSkills and(not Mode__RearmCombos) then
            set IsDisabledSkill[i * 4 + 2]= true
        endif
        call RegisterHeroSkill(i * 4 + 3, null,'A0LE','QP1Y','Y330', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, null,'A440','QP25','Y617', null)
        set HeroSkill_IsPassive[i * 4 + 4]= true
        set i = 120 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "volcano"),'A451', 0,'Y61C', "w")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "stomp"),'A454', 0,'Y61D', "t")
        call RegisterHeroSkill(i * 4 + 3, null,'A45B','QP26','Y61E', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A456')),'A456', 0,'Y61F', "r")
        set i = 121 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "curse"),'A45W', 0,'Y61G', "q")
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "volcano"),'A45X', 0,'Y61H', "w")
        call RegisterHeroSkill(i * 4 + 3, null,'A460','QP27','Y61I', null)
        set HeroSkill_IsPassive[i * 4 + 3]= true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "creepthunderclap"),'A461', 0,'Y61J', "d")
        set HERO_MAX_INDEX = 121
        if Mode__SingleDraft or Mode__MirrorDraft or Mode__AllRandom then
            call ExecuteFunc("R1R")
        endif
    endfunction
    
endlibrary
