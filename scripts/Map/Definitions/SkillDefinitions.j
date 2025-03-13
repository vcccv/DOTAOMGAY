
// 包含了被动和主动技能
library HeroSkillDefine requires SkillSystem

    // 技能的初始化
    function InitSkillInitializerMethod takes nothing returns nothing
        // 启明
        //call RegisterSkillInitMethodByIndex(SKILL_INDEX_ILLUMINATE, "IlluminateOnInitializer")

        // 高射火炮
        call RegisterSkillInitMethodByIndex(SKILL_INDEX_FLAKCANNON, "FlakcannonOnInitializer")
        
        // 群星坠落
        call RegisterSkillInitMethodByIndex(SKILL_INDEX_STARFALL  , "StarFallOnInitializer")
        
        // 阵风
        call RegisterSkillInitMethodByIndex(SKILL_INDEX_GUST      , "DrowRangerGustOnInitializer")

        // 锯齿飞轮
        //call RegisterSkillInitMethodByIndex(SKILL_INDEX_CHAKRAM   , "ChakramOnInitializer")

        // 强力击
        call RegisterSkillInitMethodByIndex(SKILL_INDEX_POWER_SHOT, "PowerShotOnInitializer")

        // 烈日炙烤
        call RegisterSkillInitMethodByIndex(SKILL_INDEX_SUN_RAY, "SunRayOnInitializer")

        // 幻象法球
        call RegisterSkillInitMethodByIndex(SKILL_INDEX_ILLUSORY_ORB, "IllusoryOryOnInitializer")

        // 暗影剧毒
        call RegisterSkillInitMethodByIndex(SKILL_INDEX_SHADOW_POISON, "ShadowPoisonOnInitializer")

        // 601是init
        call SaveStr(ObjectHashTable, 'A060', 601, "W_A")
        call SaveStr(ObjectHashTable, 'A0LE', 601, "WYA")
        call SaveStr(ObjectHashTable, 'A0O3', 601, "WUA")	//地精的贪婪
        call SaveStr(ObjectHashTable, 'A1W8', 601, "WSA")
        call SaveStr(ObjectHashTable, 'A0BH', 601, "WQA")
        call SaveStr(ObjectHashTable, 'A0A5', 601, "SummonSpiritBearOnInitializer")
        call SaveStr(ObjectHashTable, 'A0RP', 601, "WKA")
        call SaveStr(ObjectHashTable, 'A0QV', 601, "WHA")
        call SaveStr(ObjectHashTable, 'A0AK', 601, "WFA")
        call SaveStr(ObjectHashTable, 'P003', 601, "WCA")
        call SaveStr(ObjectHashTable, 'A0LZ', 601, "WIA")
        call SaveStr(ObjectHashTable, 'A2QM', 601, "WNA")
        call SaveStr(ObjectHashTable, 'A2TJ', 601, "WNA")
        call SaveStr(ObjectHashTable, 'A2QI', 601, "WNA")
        call SaveStr(ObjectHashTable, 'A2TI', 601, "WNA")
        call SaveStr(ObjectHashTable, 'A0BR', 601, "W1A")
        call SaveStr(ObjectHashTable, 'Z318', 601, "W1A")
        // 600?也是Init
        // 被动技能初始化？
        call SaveStr(ObjectHashTable, 'A022', 600, "F_R")
        call SaveStr(ObjectHashTable, 'A088', 600, "InitMultiCast")
        call SaveStr(ObjectHashTable, 'A0DJ', 600, "EON")
        call SaveStr(ObjectHashTable, 'A0FV', 600, "ERN")
        call SaveStr(ObjectHashTable, 'A33Q', 600, "EAN")
        call SaveStr(ObjectHashTable, 'A02C', 600, "WitchcraftOnLearn")
        call SaveStr(ObjectHashTable, 'A0N5', 600, "EBN")
        call SaveStr(ObjectHashTable, 'A1A3', 600, "Z8A")
        call SaveStr(ObjectHashTable, 'A04E', 600, "Z9A")
        call SaveStr(ObjectHashTable, 'A0RO', 600, "VVN")
        call SaveStr(ObjectHashTable, 'A0C6', 600, "VEN")
        call SaveStr(ObjectHashTable, 'A0DZ', 600, "VXN")
        call SaveStr(ObjectHashTable, 'A332', 600, "VON")
        call SaveStr(ObjectHashTable, 'A01Z', 600, "VRN")
        call SaveStr(ObjectHashTable, 'A08R', 600, "VIN")
        call SaveStr(ObjectHashTable, 'P250', 600, "VAN")
        //call SaveStr(ObjectHashTable, 'A081', 600, "VNN")
        
        call SaveStr(ObjectHashTable, 'A45B', 600, "VBN")
        call SaveStr(ObjectHashTable, 'A0O0', 600, "VCN")
        call SaveStr(ObjectHashTable, 'A041', 600, "VDN")
        call SaveStr(ObjectHashTable, 'A0N7', 600, "VFN")
        call SaveStr(ObjectHashTable, 'A0QN', 600, "VGN")
        call SaveStr(ObjectHashTable, 'A440', 600, "VHN")
        call SaveStr(ObjectHashTable, 'A0FA', 600, "VJN")
        call SaveStr(ObjectHashTable, 'A0FX', 600, "VKN")
        call SaveStr(ObjectHashTable, 'A0OI', 600, "VLN")
        call SaveStr(ObjectHashTable, 'A0LZ', 600, "VMN")
        call SaveStr(ObjectHashTable, 'A0MG', 600, "VPN")
        call SaveStr(ObjectHashTable, 'A0G5', 600, "VQN")
        call SaveStr(ObjectHashTable, 'A1HR', 600, "VSN")
        call SaveStr(ObjectHashTable, 'A13T', 600, "VTN")
        call SaveStr(ObjectHashTable, 'A00V', 600, "VUN")
        call SaveStr(ObjectHashTable, 'QM00', 600, "VWN")
        call SaveStr(ObjectHashTable, 'A0DL', 600, "VYN")
        call SaveStr(ObjectHashTable, 'A0DY', 600, "VZN")
        call SaveStr(ObjectHashTable, 'A0DB', 600, "V_N")
        call SaveStr(ObjectHashTable, 'A0A5', 600, "V0N")
        call SaveStr(ObjectHashTable, 'P067', 600, "V2N")
        call SaveStr(ObjectHashTable, 'QB0P', 600, "V1N")
        call SaveStr(ObjectHashTable, 'A02Q', 600, "V3N")
        call SaveStr(ObjectHashTable, 'A0SS', 600, "V4N")
        call SaveStr(ObjectHashTable, 'A0MY', 600, "V5N")
        call SaveStr(ObjectHashTable, 'S008', 600, "V6N")
        call SaveStr(ObjectHashTable, 'A2EY', 600, "V7N")
        call SaveStr(ObjectHashTable, 'A2E4', 600, "V8N")
        call SaveStr(ObjectHashTable, 'A03S', 600, "V9N")
        call SaveStr(ObjectHashTable, 'Q0BK', 600, "EVN")
        call SaveStr(ObjectHashTable, 'A0WQ', 600, "EEN")
        call SaveStr(ObjectHashTable, 'A15V', 600, "EXN")
        call SaveStr(ObjectHashTable, 'A09V', 600, "SRA")
        call SaveStr(ObjectHashTable, 'A1HQ', 600, "ECN")
        call SaveStr(ObjectHashTable, 'A03N', 600, "TSA")
        
        call SaveStr(ObjectHashTable, 'A0JJ', 600, "OPO")	//重击
        call SaveStr(ObjectHashTable, 'A0BE', 600, "OPO")	//狂战士之怒
        call SaveStr(ObjectHashTable, 'A081', 600, "OPO")	//时间锁定
    endfunction

    // 控制技能列表
    function ControlSkillList_Init takes nothing returns nothing
        call AddControlSkillIndex((8   - 1)* 4 + 1)
        call AddControlSkillIndex((6   - 1)* 4 + 1)
        call AddControlSkillIndex((95  - 1)* 4 + 4)
        call AddControlSkillIndex((22  - 1)* 4 + 1)
        call AddControlSkillIndex((46  - 1)* 4 + 1)
        call AddControlSkillIndex((37  - 1)* 4 + 4)
        call AddControlSkillIndex((33  - 1)* 4 + 2)
        call AddControlSkillIndex((39  - 1)* 4 + 2)
        call AddControlSkillIndex((14  - 1)* 4 + 4)
        call AddControlSkillIndex((77  - 1)* 4 + 4)
        call AddControlSkillIndex((81  - 1)* 4 + 1)
        call AddControlSkillIndex((66  - 1)* 4 + 2)
        call AddControlSkillIndex((74  - 1)* 4 + 4)
        call AddControlSkillIndex((63  - 1)* 4 + 1)
        call AddControlSkillIndex((108 - 1)* 4 + 1)
        call AddControlSkillIndex((106 - 1)* 4 + 4)
        call AddControlSkillIndex((1   - 1)* 4 + 1)
        call AddControlSkillIndex((40  - 1)* 4 + 2)
        call AddControlSkillIndex((48  - 1)* 4 + 2)
        call AddControlSkillIndex((7   - 1)* 4 + 2)
        call AddControlSkillIndex((54  - 1)* 4 + 1)
        call AddControlSkillIndex((69  - 1)* 4 + 4)
        call AddControlSkillIndex((89  - 1)* 4 + 1)
        call AddControlSkillIndex((65  - 1)* 4 + 1)
        call AddControlSkillIndex((61  - 1)* 4 + 4)
        call AddControlSkillIndex((5   - 1)* 4 + 2)
        call AddControlSkillIndex((41  - 1)* 4 + 2)
        call AddControlSkillIndex((47  - 1)* 4 + 1)
        call AddControlSkillIndex((11  - 1)* 4 + 2)
        call AddControlSkillIndex((28  - 1)* 4 + 2)
        call AddControlSkillIndex((28  - 1)* 4 + 3)
        call AddControlSkillIndex((38  - 1)* 4 + 2)
        call AddControlSkillIndex((18  - 1)* 4 + 1)
        call AddControlSkillIndex((53  - 1)* 4 + 1)
        call AddControlSkillIndex((75  - 1)* 4 + 3)
        call AddControlSkillIndex((75  - 1)* 4 + 4)
        call AddControlSkillIndex((104 - 1)* 4 + 1)
        call AddControlSkillIndex((104 - 1)* 4 + 2)
        call AddControlSkillIndex((86  - 1)* 4 + 1)
        call AddControlSkillIndex((95  - 1)* 4 + 1)
        call AddControlSkillIndex((100 - 1)* 4 + 1)
        call AddControlSkillIndex((97  - 1)* 4 + 1)
        call AddControlSkillIndex((87  - 1)* 4 + 2)
        call AddControlSkillIndex((101 - 1)* 4 + 1)
        call AddControlSkillIndex((112 - 1)* 4 + 1)
        call AddControlSkillIndex((31  - 1)* 4 + 1)
        call AddControlSkillIndex((46  - 1)* 4 + 4)
        call AddControlSkillIndex((111 - 1)* 4 + 1)
        call AddControlSkillIndex((78  - 1)* 4 + 1)
        call AddControlSkillIndex((4   - 1)* 4 + 2)
        call AddControlSkillIndex((120 - 1)* 4 + 2)
        call AddControlSkillIndex((91  - 1)* 4 + 2)
        call AddControlSkillIndex((78  - 1)* 4 + 4)
        call AddControlSkillIndex((82  - 1)* 4 + 1)
        call AddControlSkillIndex((109 - 1)* 4 + 4)
        call AddControlSkillIndex((96  - 1)* 4 + 4)
    endfunction
    
    // 使用一次a技能，便会隐藏禁用a技能随后显示启用b技能，使用b技能后又隐藏禁用b技能显示启用a技能
    function ToggleSkills_Init takes nothing returns nothing
        call ToggleSkill.Register('A1RJ', 'A20N', false) // 凤凰冲击
        
        call ToggleSkill.Register('A1YX', 'A1Z2', false) // 烈火精灵
        
        call ToggleSkill.Register('A1YY', 'A1Z3', false) // 烈日炙烤
        
        call ToggleSkill.Register('Z605', 'QFZZ', false) // 幽灵漫步
        call ToggleSkill.Register('A27F', 'A27X', false) // 隔空取物
        call ToggleSkill.Register('A085', 'A121', true) // 启明
        call ToggleSkill.Register('A11N', 'A13D', true) // X标记
        call ToggleSkill.Register('A1PH', 'A1RA', true) // 灵魂汲取
        call ToggleSkill.Register('A1A8', 'A21J', true) // 先祖之魂
        call ToggleSkill.Register('A1NI', 'A1NH', true) // 不稳定化合物
        call ToggleSkill.Register('A0SW', 'A0SX', true) // 感染
        call ToggleSkill.Register('A04Y', 'A2O9', true) // 噩梦
        call ToggleSkill.Register('A0R0', 'A2MB', true) // 黑暗之门
        
        call ToggleSkill.Register('A0G8', 'A0GC', true) // 水人复制
        
        call ToggleSkill.Register('A21F', 'A21H', true) // 脉冲新星
        
        call ToggleSkill.Register('A1MI', 'A1MN', true) // 冰晶爆轰
        
        call ToggleSkill.Register('A2E5', 'A2FX', true) // 锯齿飞轮
        call ToggleSkill.Register('A43Q', 'A43P', true) // 双飞之轮
        
        call ToggleSkill.Register('A07U', 'A24E', true) // 海妖之歌
    endfunction

    function HeroPassiveSkills_Init takes nothing returns nothing
        // 注意：第五个参数的技能Id最好不要为光环类 (因为这只是用作于显示技能 模板应该为AEev)
        // 2022/1/1 将ability.slk的
        // 替换为
        // C;X2;K"AOac"  |   C;X2;K"AEev"
        // C;X11;K4      |	 C;X11;K4
        // C;X10;K1      |	 C;X10;K1
        // C;Y     		 |	 C;Y
        // AOac的父级Id为ACac  命令光环 如果更改以此为模板的技能等级 在单位死亡时候会导致崩溃
        // 所以将其全部更改为AEev 闪避 与命令光环相同一样可以修改技能等级
        call RegisterPassiveSkill('ACac', 'Q003', 'P003', 'BOac', 'QP03', 'QP03')
        call RegisterPassiveSkill(0, 0, 'A0DW', 0, 'QP04', 0)
        call RegisterPassiveSkill('AHab', 'Q019', 'P019', 'B07M', 'QP05', 0)
        call RegisterPassiveSkill('P022', 'Q022', 'A01K', 0, 'QP06', 0)
        call RegisterPassiveSkill('P035', 'Q035', 'A0DZ', 0, 'QP07', 0)
        call RegisterPassiveSkill('A00J', 'Q036', 'A0MB', 0, 'QP08', 'QP08')
        call RegisterPassiveSkill('P047', 'Q047', 'A00K', 0, 'QP09', 'QP09')
        call RegisterPassiveSkill(0, 'Q067', 'P067', 0, 'QP0A', 0)
        call RegisterPassiveSkill('P083', 'Q083', 'A0DB', 'B03B', 'QP0B', 'QP0B')
        call RegisterPassiveSkill('P098', 'Q098', 'A041', 0, 'QP0D', 'QP0D') //月刃
        call RegisterPassiveSkill('P099', 'Q099', 'A062', 'B01W', 'QP0E', 0)
        call RegisterPassiveSkill('P102', 'Q102', 'A03S', 0, 'QP0F', 0)
        call RegisterPassiveSkill('P107', 'Q107', 'A0O0', 0, 'QP0G', 0)
        call RegisterPassiveSkill('P119', 'Q119', 'A0MX', 0, 'QP0H', 'QP0H')
        call RegisterPassiveSkill('P123', 'Q123', 'A00V', 'B00M', 'QP0I', 'QP0I')
        call RegisterPassiveSkill('P131', 'Q131', 'A0CL', 'B04D', 'QP0J', 0)
        call RegisterPassiveSkill('P133', 'Q133', 'A022', 0, 'QP0K', 'QP0K')
        call RegisterPassiveSkill('P135', 'Q135', 'A0KY', 0, 'QP0L', 'QP0L')
        call RegisterPassiveSkill('P143', 'Q143', 'A06A', 'B01B', 'QP0M', 'QP0M')
        call RegisterPassiveSkill('P147', 'Q147', 'A0BD', 'B00E', 'QP0N', 'QP0N')
        call RegisterPassiveSkill('P155', 'Q155', 'A0O3', 'B00X', 'QP0O', 0)
        call RegisterPassiveSkill('P211', 'Q211', 'A27V', 'B0EO', 'QP0P', 0)
        call RegisterPassiveSkill('P231', 'Q231', 'A03E', 'B096', 'QP0Q', 0)
        call RegisterPassiveSkill('P239', 'Q239', 'A03P', 0, 'QP0R', 'QP0R')
        call RegisterPassiveSkill('P240', 'Q240', 'A03Q', 0, 'QP0S', 'QP0S')
        call RegisterPassiveSkill(0, 0, 'A086', 'B02L', 'P247', 0)
        call RegisterPassiveSkill('AUav', 'Q250', 'P250', 'BVA1', 'QP0U', 'QP0U')
        call RegisterPassiveSkill('AOcr', 'Q251', 'A2S0', 0, 'QP0W', 'QP0W')
        call RegisterPassiveSkill(0, 0, 'A0JJ', 0, 'QP0V', 'QP0V')
        call RegisterPassiveSkill(0, 0, 'A081', 0, 'QP0X', 'QP0X')
        call RegisterPassiveSkill('P279', 'Q279', 'A0MM', 0, 'QP0Y', 0)
        call RegisterPassiveSkill('P283', 'Q283', 'A1E6', 'B03X', 'QP0Z', 0)
        call RegisterPassiveSkill('P294', 'Q294', 'A04E', 0, 'QP10', 0)
        call RegisterPassiveSkill('P302', 'Q302', 'A01N', 'B084', 'QP11', 0)
        call RegisterPassiveSkill('P303', 'Q303', 'A060', 0, 'QP12', 0)
        call RegisterPassiveSkill('P307', 'Q307', 'A06D', 0, 'QP13', 0)
        call RegisterPassiveSkill('P310', 'Q310', 'A0ES', 'B03Y', 'QP14', 'QP14')
        call RegisterPassiveSkill('P319', 'Q319', 'A0FU', 0, 'QP15', 'QP15')
        call RegisterPassiveSkill(0, 0, 'A0FA', 0, 'QP16', 'QP16')
        call RegisterPassiveSkill('P327', 'Q327', 'A0C6', 'B03P', 'QP17', 'QP17')
        call RegisterPassiveSkill(0, 0, 'A0MG', 0, 'QP18', 0)
        call RegisterPassiveSkill('P338', 'Q338', 'A0FX', 0, 'QP19', 'QP19')
        call RegisterPassiveSkill('P347', 'Q347', 'A0IF', 'B06X', 'QP1A', 0)
        call RegisterPassiveSkill('P355', 'Q355', 'A0N7', 0, 'QP1B', 0)
        call RegisterPassiveSkill('P363', 'Q363', 'AIcd', 0, 'QP1C', 'QP1C')
        call RegisterPassiveSkill('P418', 'Q418', 'A0MY', 0, 'QP1D', 0)
        call RegisterPassiveSkill('P431', 'Q431', 'A03N', 0, 'QP1E', 'QP1E')
        call RegisterPassiveSkill(0, 0, 'A1HR', 0, 'QP1F', 0)
        call RegisterPassiveSkill(0, 0, 'A0DJ', 0, 'QP1G', 0)
        call RegisterPassiveSkill(0, 0, 'QF85', 0, 'QP1H', 0)
        call RegisterPassiveSkill(0, 0, 'A1CD', 0, 'QP1I', 0)
        call RegisterPassiveSkill(0, 0, 'A19Q', 0, 'QP1J', 0)
        call RegisterPassiveSkill(0, 0, 'A0CY', 0, 'QP1K', 0)
        call RegisterPassiveSkill(0, 0, 'A0QQ', 0, 'QP1L', 0)
        call RegisterPassiveSkill(0, 0, 'A0M3', 0, 'QP1M', 0)
        call RegisterPassiveSkill(0, 0, 'A0FV', 0, 'QP1N', 0)
        call RegisterPassiveSkill(0, 0, 'A2EY', 0, 'QP1O', 0)
        call RegisterPassiveSkill(0, 0, 'A13T', 0, 'A522', 0)
        call RegisterPassiveSkill(0, 0, 'A2E4', 0, 'QP1P', 0)
        call RegisterPassiveSkill(0, 0, 'A03U', 0, 'QP1Q', 0)
        call RegisterPassiveSkill(0, 0, 'A0RO', 0, 'QP1S', 0)
        call RegisterPassiveSkill(0, 0, 'A0N5', 0, 'QP1T', 0)
        call RegisterPassiveSkill(0, 0, 'A18X', 0, 'QP1U', 0)
        call RegisterPassiveSkill(0, 0, 'A0QW', 0, 'QP1V', 0)
        call RegisterPassiveSkill(0, 0, 'A0SS', 0, 'QP1W', 0)
        call RegisterPassiveSkill(0, 0, 'A0G5', 0, 'QP1X', 0)
        call RegisterPassiveSkill(0, 0, 'A0LE', 0, 'QP1Y', 0)
        call RegisterPassiveSkill(0, 0, 'A0I8', 0, 'QP1Z', 0)
        call RegisterPassiveSkill(0, 0, 'A0NA', 0, 'QP20', 0)
        call RegisterPassiveSkill(0, 0, 'A1A3', 0, 'QP21', 0)
        call RegisterPassiveSkill(0, 0, 'A0CZ', 0, 'QP22', 0)
        call RegisterPassiveSkill(0, 0, 'A0VX', 0, 'QP23', 0)
        call RegisterPassiveSkill(0, 0, 'A088', 0, 'QP24', 0)
        call RegisterPassiveSkill('A33O', 'A33P', 'A33Q', 0, 'A33R', 0)
        call RegisterPassiveSkill('A09J', 'A23F', 'A417', 0, 0, 0)
        call RegisterPassiveSkill('A43Z', 'A442', 'A440', 0, 'QP25', 0)
        call RegisterPassiveSkill(0, 0, 'QF88', 0, 'A0VC', 0)
        call RegisterPassiveSkill('A455', 'A45C', 'A45B', 0, 'QP26', 0)
        call RegisterPassiveSkill(0, 0, 'A460', 0, 'QP27', 0)
        call RegisterPassiveSkill(0, 0, 'A34A', 0, 'QP28', 0)
        call RegisterPassiveSkill(0, 0, 'Q0BK', 0, 'QP29', 0)
        call RegisterPassiveSkill(0, 0, 'A0A8', 0, 'QP2A', 0)
        call RegisterPassiveSkill('A3J7', 'A3J7', 'A02C', 0, 'QP2B', 0)
    endfunction

    function HeroSkills_Init takes nothing returns nothing
        local integer i = 0
        local string s
        call RegisterHeroSkill(0, null, 0, 0, 0)
        set HeroSkill_Icon[0] = "UI\\Widgets\\Console\\Undead\\undead-inventory-slotfiller.blp"
        set i = 1 - 1
        call RegisterHeroSkill(i * 4 + 1, "", 'A02A', 0, 'Y001')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "volcano"), 'A17O', 0, 'Y002')
        call RegisterHeroSkill(i * 4 + 3, null, 'P003', 'QP03', 'Y003')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "forkedlightning"), 'A0IN', 'A1AW', 'Y004')
        set i = 2 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A020')), 'A020', 0, 'Y005')
        call RegisterHeroSkill(i * 4 + 2, "", 'A0JC', 0, 'Y006')
        call RegisterHeroSkill(i * 4 + 3, null, 'A0N5', 'QP1T', 'Y007')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "roar")+ SaveSkillOrder(i * 4 + 4, "r1"), 'A29G', 'A29H', 'Y008')
        set i = 3 - 1
        call RegisterHeroSkill(i * 4 + 1, null, 'A0DW', 'QP04', 'Y009')
        set HeroSkill_IsPassive[i * 4 + 1] = true
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "slow"), 'A0DX', 0, 'Y010')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "locustswarm"), 'A01B', 0, 'Y011')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "arrows")+ SaveSkillOrder(i * 4 + 4, "range only")+ SaveSkillOrder(i * 4 + 4, "shuashecheng"), 'A0DY', 'A1WB', 'Y012')
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 4, "HXBinglongTuijin")
        endif
        //set HeroSkill_IsDisabledInDeathMatch[i * 4 + 4] = true
        set i = 4 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('QB02')), 'QB02', 0, 'QY02')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A0G6')), 'A0G6', 0, 'Y014')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "replenishmana")+ SaveSkillOrder(i * 4 + 3, "replenishlife")+ SaveSkillOrder(i * 4 + 3, "abuz agi")+ SaveSkillOrder(i * 4 + 3, "str bug"), 'A0KX', 0, 'Y015')
        set HeroSkill_HasMultipleAbilities[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "item 16")+ SaveSkillOrder(i * 4 + 4, "coldarrows"), 'A0G8', 0, 'Y016')
        set i = 5 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "mounthippogryph"), 'A1E9', 0, 'Y017')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "entanglingroots"), 'A04C', 0, 'Y018')
        call RegisterHeroSkill(i * 4 + 3, null, 'P019', 'QP05', 'Y019')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "autoharvestlumber"), 'A03R', 'A0AV', 'Y020')
        set i = 6 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "spellshieldaoe"), 'A190', 0, 'Y021')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "melee only"), 'A01K', 'QP06', 'Y022')
        set HeroSkill_IsPassive[i * 4 + 2] = true
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, GetAbilityOrder('A2IS')), 'A2IS', 0, 'Y023')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "roar"), 'A0WP', 'A43D', 'Y024')
        set i = 7 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A063')), 'A063', 0, 'Y025')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "unavatar"), 'A24D', 0, 'Y026')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, GetAbilityOrder('A2KU')), 'A2KU', 0, 'Y027')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "awaken")+ SaveSkillOrder(i * 4 + 4, "avengerform")+ SaveSkillOrder(i * 4 + 4, "r2"), 'A07U', 'A38E', 'Y028')
        set i = 8 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "barkskinoff"), 'A0SK', 0, 'Y029')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "roar"), 'A0DL', 0, 'Y030')
        set HeroSkill_BalanceOffDisabledTips[i * 4 + 2] = "图腾在与水刀、连击、海象挥击、忍术、转属性和无影拳的时候只会 +100/140/180/220% 的攻击力"
        call SaveSkillOrderInBalanceOffDisabled(i * 4 + 2, "ET-Drunken")
        call SaveSkillOrderInBalanceOffDisabled(i * 4 + 2, "bgdmg1")
        call SaveSkillOrderInBalanceOffDisabled(i * 4 + 2, "bgdmg2")
        call RegisterHeroSkill(i * 4 + 3, null, 'A0DJ', 'QP1G', 'Y031')
        set HeroSkill_Tips[i * 4 + 3] = "余震有6/4.5/3.0/1.5秒的冷却时间"
        set HeroSkill_IsPassive[i * 4 + 3] = true
        if Mode__SixSkills and(not Mode__RearmCombos) then
            //	set HeroSkill_Disabled[i * 4 + 3] = true
            set HeroSkill_Disabled[i * 4 + 2] = true
        endif
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A0DH')), 'A0DH', 'A1OB', 'Y032')
        set i = 9 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "neutralinteract"), 'A0RG', 0, 'Y033')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "inv bug 1")+ SaveSkillOrder(i * 4 + 2, "ibug")+ SaveSkillOrder(i * 4 + 2, "yongjiu1")+ SaveSkillOrder(i * 4 + 2, "yongjiu2")+ SaveSkillOrder(i * 4 + 2, "yongjiu3"), 'A0MB', 'QP08', 'Y036')
        set HeroSkill_IsPassive[i * 4 + 2] = true
        set HeroSkill_Tips[i * 4 + 2] = "永久隐身效果会在攻击、施法或使用物品后消失"
        call RegisterHeroSkill(i * 4 + 3, null, 'A0DZ', 'QP07', 'Y035')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "barkskinon"), 'A0K9', 0, 'Y034')
        set i = 10 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "summongrizzly"), 'A0A5', 0, 'Y037')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A1EG')), 'A1EG', 0, 'Y038')
        call RegisterHeroSkill(i * 4 + 3, null, 'A0A8', 0, 'Y039') //协同
        if Mode__SixSkills and(not Mode__RearmCombos) then
            set HeroSkill_Disabled[i * 4 + 3] = true
        endif
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "bearform")+ SaveSkillOrder(i * 4 + 4, "unbearform")+ SaveSkillOrder(i * 4 + 4, "battleroar")+ SaveSkillOrder(i * 4 + 4, "metamorphosis")+ SaveSkillOrder(i * 4 + 4, "melee morph"), 'A0AG', 0, 'Y040')
        set HeroSkill_HasMultipleAbilities[i * 4 + 4] = true
        set i = 11 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A01F')), 'A01F', 0, 'Y041')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "restorationoff"), 'QB0E', 0, 'QY0E')
        call RegisterHeroSkill(i * 4 + 3, null, 'A18X', 'QP1U', 'Y043')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        set HeroSkill_RearmCombosDisabledTips[i * 4 + 3] = "冷却时间3秒及以下的技能每施放2次才会触发1次炽魂"
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A01P')), 'A01P', 'A09Z', 'Y044')
        set i = 12 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "whirlwind"), 'A05G', 0, 'Y045')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "healingward"), 'A047', 0, 'Y046')
        call RegisterHeroSkill(i * 4 + 3, null, 'A00K', 'QP09', 'Y047')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, "", 'A0M1', 'A1AX', 'Y048')
        set i = 13 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "neutralspell"), 'A14L', 0, 'Y049')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "arrows")+ SaveSkillOrder(i * 4 + 2, "range only"), 'A0LZ', 0, 'Y050')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "transmute"), 'A2NT', 0, 'Y051')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "battlestations")+ SaveSkillOrder(i * 4 + 4, "r4"), 'A0L3', 'A2QC', 'Y052')
        set i = 14 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "invisibility"), 'A01Z', 0, 'Y053')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "unavengerform"), 'A26N', 0, 'Y054')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "spiritlink"), 'A2ML', 0, 'Y055')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "blight"), 'A07Z', 'A44S', 'Y056')
        set i = 15 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "Locustswarm"), 'A1AA', 0, 'Y057')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "loadcorpse")+ SaveSkillOrder(i * 4 + 2, "whirlwind"), 'A1A8', 0, 'Y058')
        call RegisterHeroSkill(i * 4 + 3, null, 'A1CD', 'QP1I', 'Y059')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "board"), 'A1A1', 'A43J', 'Y060')
        set i = 16 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "carrionscarabs")+ SaveSkillOrder(i * 4 + 1, "carrionscarabsinstant"), 'A085', 0, 'Y061')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "spellsteal"), 'A10X', 0, 'Y062')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "frenzy"), 'A112', 0, 'Y063')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "range morph")+ SaveSkillOrder(i * 4 + 4, "metamorphosis")+ SaveSkillOrder(i * 4 + 4, "phoenixfire")+ SaveSkillOrder(i * 4 + 4, "creepheal"), 'QM01', 0, 'Y064')
        set HeroSkill_HasMultipleAbilities[i * 4 + 4] = true
        set i = 17 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "thunderclap"), 'A03Y', 0, 'Y065')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('QB0P')), 'QB0P', 0, 'QY0P')
        call RegisterHeroSkill(i * 4 + 3, null, 'P067', 'QP0A', 'Y067')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "berserk"), 'A0LC', 'A443', 'Y068')
        set i = 18 - 1
        call RegisterHeroSkill(i * 4 + 1, "", 'QB0J', 0, 'QY0J')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A011')), 'A011', 0, 'Y070')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "bloodlust"), 'A083', 0, 'Y071')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "carrionscarabsoff"), 'A088', 'QP24', 'Y072')
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 4, "HXmines")
        endif
        set HeroSkill_IsPassive[i * 4 + 4] = true
        set HeroSkill_BalanceOffDisabledTips[i * 4 + 4] = "多重施法的触发几率调整为：18%/30%/40%概率x2，0%/13%/15%概率x3，0%/0/%5%概率x4。每下施法会额外消耗35%魔法值。"
        set i = 19 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "drunkenhaze"), 'A049', 'A33G', 'Y073')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A05E')), 'A05E', 'A33F', 'Y074')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "manaflareoff")+ SaveSkillOrder(i * 4 + 3, "stampede"), 'A0BQ', 0, 'Y075')
        set i = i * 4 + 4
        call RegisterHeroSkill(i, SaveSkillOrder(i, "monsoon")+ SaveSkillOrder(i, "channel")+ SaveSkillOrder(i, "magicundefense"), 'A065', 0, 'Y076')
        //	set HeroSkill_Disabled[i * 4 + 4] = true
        set HeroSkill_BalanceOffDisabledTips[i] = "再装填有9/6/3的冷却时间"
        set s = SaveSkillOrder(i, "r1")+ SaveSkillOrder(i, "r4")+ SaveSkillOrder(i, "r55")+ SaveSkillOrder(i, "r18")
        //if Mode__SixSkills and(not Mode__RearmCombos) then
        if ExtraSkillsCount != 0 then
            set HeroSkill_Disabled[i] = true
        endif
        if Mode__RearmCombos == false then
            set s = SaveSkillOrder(i, "r44")+ SaveSkillOrder(i, "r95")+ SaveSkillOrder(i, "r2")+ SaveSkillOrder(i, "r3")+ SaveSkillOrder(i, "r14")+ SaveSkillOrder(i, "r17")
            set s = SaveSkillOrder(i, "r6")+ SaveSkillOrder(i, "r7")+ SaveSkillOrder(i, "r8")+ SaveSkillOrder(i, "r9")+ SaveSkillOrder(i, "r123")+ SaveSkillOrder(i, "r11")+ SaveSkillOrder(i, "r12")+ SaveSkillOrder(i, "r15")+ SaveSkillOrder(i, "r16")
            set s = SaveSkillOrder(i, "r19")+ SaveSkillOrder(i, "r20")+ SaveSkillOrder(i, "r21")+ SaveSkillOrder(i, "r22")+ SaveSkillOrder(i, "r23")+ SaveSkillOrder(i, "r24")+ SaveSkillOrder(i, "r25")
            set s = SaveSkillOrder(i, "r26")+ SaveSkillOrder(i, "r27")+ SaveSkillOrder(i, "r28")
        endif
        call SaveSkillOrderInBalanceOffDisabled(i, "r29")
        call SaveSkillOrderInBalanceOffDisabled(i, "r30")
        call SaveSkillOrderInBalanceOffDisabled(i, "r31")
        set i = 20 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A21E')), 'A21E', 0, 'Y077')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A01O')), 'A01O', 0, 'Y078')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "forceofnature"), 'AEfn', 0, 'Y079')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "stampede")+ SaveSkillOrder(i * 4 + 4, "r55"), 'A1W8', 'A1W9', 'Y080')
        set i = 21 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "spellstealoff"), 'A10D', 0, 'Y081')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "animatedead"), 'A46H', 0, 'Y082')
        call RegisterHeroSkill(i * 4 + 3, null, 'A46E', 'A46D', 'Y084')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, null, 'A0DB', 'QP0B', 'Y083')
        set HeroSkill_IsPassive[i * 4 + 4] = true
        set i = 22 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "phoenixmorph"), 'A0LL', 0, 'Y085')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "carrionscarabson"), 'A0BZ', 0, 'Y086')
        call RegisterHeroSkill(i * 4 + 3, null, 'A19Q', 'QP1J', 'Y087')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, null, 'A0CY', 'QP1K', 'Y088')
        set HeroSkill_IsDisabledInDeathMatch[i * 4 + 4] = true
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 4, "HXzhangdahaimin")
        endif
        set HeroSkill_IsPassive[i * 4 + 4] = true
        set HeroSkill_RearmCombosDisabledTips[i * 4 + 4] = "远程模型只增加 40/80/120 点攻击力"
        call SaveSkillOrderInBalanceOffDisabled(i * 4 + 4, "bgdmg1")
        call SaveSkillOrderInBalanceOffDisabled(i * 4 + 4, "bgdmg2")
        //set HeroSkill_IsDisabledInDeathMatch[i * 4 + 4] = true
        set i = 23 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "item 89"), 'A05J', 0, 'Y089')
        //if (not Mode__RearmCombos) then
        //	set s=SaveSkillOrder(i*4+1,"HXmines")
        //endif
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "stasistrap"), 'A06H', 0, 'Y090')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "selfdestruct"), 'A06B', 'A471', 'Y091')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "ward"), 'A0AK', 'A1FY', 'Y092')
        set HeroSkill_HasMultipleAbilities[i * 4 + 4] = true
        set i = 24 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "drunkenhaze"), 'A0KM', 0, 'Y093')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "ancestralspirittarget")+ SaveSkillOrder(i * 4 + 2, "build"), 'A0LV', 0, 'Y094')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "ambush"), 'A28T', 'A361', 'Y095')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "controlmagic")+ SaveSkillOrder(i * 4 + 4, "r6"), 'A0LT', 'A1CS', 'Y096')
        set i = 25 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "firebolt"), 'A042', 0, 'Y097')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "arrows"), 'A041', 'QP0D', 'Y098')
        
        //set HeroSkill_IsDisabledInDeathMatch[i * 4 + 2] = true
        set HeroSkill_IsPassive[i * 4 + 2] = true
        call RegisterHeroSkill(i * 4 + 3, null, 'A062', 'QP0E', 'Y099')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        set HeroSkill_IsDisabledInDeathMatch[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "corporealform")+ SaveSkillOrder(i * 4 + 4, "r28"), 'A054', 'A00U', 'Y100')
        set i = 26 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "possession")+ SaveSkillOrder(i * 4 + 1, "metamorphosis"), 'A064', 0, 'Y101')
        //set HeroSkill_Disabled[i*4+1]=true
        call RegisterHeroSkill(i * 4 + 2, null, 'A03S', 'QP0F', 'Y102')
        set HeroSkill_IsPassive[i * 4 + 2] = true
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "range only"), 'A03U', 'QP1Q', 'Y103')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        //set HeroSkill_IsDisabledInDeathMatch[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, "", 'A04P', 'A1AU', 'Y104')
        set i = 27 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "metamorphosis")+ SaveSkillOrder(i * 4 + 1, "bearform")+ SaveSkillOrder(i * 4 + 1, "unbearform")+ SaveSkillOrder(i * 4 + 1, "melee morph")+ SaveSkillOrder(i * 4 + 1, "bash")+ SaveSkillOrder(i * 4 + 1, "yongjiu2"), 'A0BE', 0, 'Y105')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "autodispel")+ SaveSkillOrder(i * 4 + 2, "loadarcher"), 'A21M', 'A21N', 'Y106')
        set HeroSkill_HasMultipleAbilities[i * 4 + 2] = true
        call RegisterHeroSkill(i * 4 + 3, null, 'A0O0', 'QP0G', 'Y107')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A1EJ')), 'A1EJ', 0, 'Y108')
        set i = 28 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "forkedlightning"), 'A010', 0, 'Y109')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "hex"), 'A0RX', 0, 'Y110')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "magicleash"), 'A00P', 0, 'Y111')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "ward")+ SaveSkillOrder(i * 4 + 4, "r7"), 'A00H', 'A0A1', 'Y112')
        if ExtraSkillsCount == 2 then
            set HeroSkill_Tips[i * 4 + 4] = "该技能在此模式下会减少对建筑25%伤害"
        endif
        set i = 29 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A1TA'))+ SaveSkillOrder(i * 4 + 1, "frenzyoff"), 'A1TA', 0, 'Y113')
        //set HeroSkill_Disabled[i * 4 + 1] = true
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A1T8'))+ SaveSkillOrder(i * 4 + 2, "battleroar")+ SaveSkillOrder(i * 4 + 2, "roar"), 'A1T8', 0, 'Y114')
        set HeroSkill_HasMultipleAbilities[i * 4 + 2] = true
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "manashieldon")+ SaveSkillOrder(i * 4 + 3, "manashieldoff"), 'A28Q', 0, 'Y115')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "spellstealon"), 'A1TB', 'A3FQ', 'Y116')
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 4, "HXballl")
        endif
        call SaveSkillOrderInBalanceOffDisabled(i * 4 + 4, "r30")
        set i = 30 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "thunderclap"), 'A06M', 0, 'Y117')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "drunkenhaze"), 'Acdh', 0, 'Y118')
        call RegisterHeroSkill(i * 4 + 3, null, 'A0MX', 'QP0H', 'Y119')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call SaveSkillOrderInBalanceOffDisabled(i * 4 + 3, "ET-Drunken")
        call SaveSkillOrderInBalanceOffDisabled(i * 4 + 3, "Tide-Drunken")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "elementalfury"), 'A0MQ', 'A1B6', 'Y120')
        set i = 31 - 1
        call RegisterHeroSkill(i * 4 + 1, "", 'A00S', 0, 'Y121')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "firebolt"), 'A00L', 0, 'Y122')
        call RegisterHeroSkill(i * 4 + 3, null, 'A00V', 'QP0I', 'Y123')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A2O6'))+ SaveSkillOrder(i * 4 + 4, "r8"), 'A2O6', 'A384', 'Y124')
        set i = 32 - 1
        call RegisterHeroSkill(i * 4 + 1, "", 'A004', 0, 'Y125')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "nagabuild")+ SaveSkillOrder(i * 4 + 2, "r9"), 'A1IQ', 0, 'Y126')
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 2, "HXshuidaorenshu")
        endif
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 2, "HXrenshuhaimin")
        endif
        set HeroSkill_IsPassive[i * 4 + 2] = true
        set HeroSkill_RearmCombosDisabledTips[i * 4 + 2] = "如果同时选择了无影拳或长大！，忍术只会造成 1.25/1.45/1.65/1.85倍 的伤害"
        call SaveSkillOrderInBalanceOffDisabled(i * 4 + 2, "Tide-Jinada")
        call RegisterHeroSkill(i * 4 + 3, "", 'A07A', 0, 'Y127')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "faeriefire"), 'A0B4', 0, 'Y128')
        set i = 33 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A03F')), 'A03F', 0, 'Y129')
        call RegisterHeroSkill(i * 4 + 2, "", 'A0AR', 0, 'Y130')
        set s = SaveSkillOrder(i * 4 + 2, "HXLongqilanmao")
        call RegisterHeroSkill(i * 4 + 3, null, 'A0CL', 'QP0J', 'Y131')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        //set HeroSkill_IsDisabledInDeathMatch[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "metamorphosis")+ SaveSkillOrder(i * 4 + 4, "range morph"), 'QM00', 0, 'Y132')
        set i = 34 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "orb effect"), 'A022', 'QP0K', 'Y133')
        set HeroSkill_IsPassive[i * 4 + 1] = true
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('AEbl')), 'AEbl', 0, 'Y134')
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 2, "HXshijianmanbu")
        endif
        call RegisterHeroSkill(i * 4 + 3, null, 'A0KY', 'QP0L', 'Y135')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, "", 'A0E3', 0, 'Y136')
        set i = 35 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "arrows")+ SaveSkillOrder(i * 4 + 1, "range only"), 'A026', 0, 'Y137')
        call RegisterHeroSkill(SKILL_INDEX_GUST, SaveSkillOrder(SKILL_INDEX_GUST, "silence"), 'A33A', 0, 'Y138')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "defend"), 'A2O2', 0, 'Y139')
        set HeroSkill_RearmCombosDisabledTips[i * 4 + 3] = "强击光环效果只作用于远程单位，无论你选择的是近战或远程"
        call RegisterHeroSkill(i * 4 + 4, null, 'QF88', 0, 'QY88')
        set HeroSkill_IsPassive[i * 4 + 4] = true
        set i = 36 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "channel"), 'A08N', 0, 'Y141')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "antimagicshell"), 'A08V', 0, 'Y142')
        call RegisterHeroSkill(i * 4 + 3, null, 'A06A', 'QP0M', 'Y143')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "battleroar"), 'A0ER', 'A2S8', 'Y144')
        set i = 37 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "massteleport"), 'A0O1', 0, 'Y145')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "awaken")+ SaveSkillOrder(i * 4 + 2, "unsummon"), 'A0OO', 0, 'Y146')
        set HeroSkill_HasMultipleAbilities[i * 4 + 2] = true
        call RegisterHeroSkill(i * 4 + 3, null, 'A0BD', 'QP0N', 'Y147')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, "", 'A0O2', 'A289', 'Y148')
        set i = 38 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A0O7')), 'A0O7', 0, 'Y149')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A0O6')), 'A0O6', 0, 'Y150')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, GetAbilityOrder('A30T')), 'A30T', 0, 'Y151')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A0O5')), 'A0O5', 'A1B1', 'Y152')
        set i = 39 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "preservation"), 'A0IL', 0, 'Y153')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A1NI'))+ SaveSkillOrder(i * 4 + 2, "corrosivebreath"), 'A1NI', 0, 'Y154')
        call RegisterHeroSkill(i * 4 + 3, null, 'A0O3', 'QP0O', 'Y155')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "metamorphosis")+ SaveSkillOrder(i * 4 + 4, "melee morph")+ SaveSkillOrder(i * 4 + 4, "r25"), 'QB0K', 0, 'QY0K')
        set i = 40 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "coupleinstant"), 'A0KV', 'A3UG', 'Y157')

        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "spies"), 'A0L8', 0, 'Y158')
        call RegisterHeroSkill(i * 4 + 3, "", 'A0LN', 0, 'Y159')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "corporealform")+ SaveSkillOrder(i * 4 + 4, "r11"), 'A0KU', 0, 'Y160')
        set i = 41 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A14P')), 'A14P', 0, 'Y161')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A14R')), 'A14R', 'A3WT', 'Y162')
        call RegisterHeroSkill(i * 4 + 3, null, 'A0QW', 'QP1V', 'Y163')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        set HeroSkill_RearmCombosDisabledTips[i * 4 + 3] = "冷却时间3秒及以下的技能每施放2次才会触发1次超负荷（球形闪电除外）"
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "channel"), 'A14O', 'A3FJ', 'Y164')
        set s = SaveSkillOrder(i * 4 + 4, "HXLongqilanmao")
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 4, "HXballl")
        endif
        set i = 42 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "holybolt"), 'A0QP', 0, 'Y165')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "arrows"), 'A0QN', 0, 'Y166')
        call RegisterHeroSkill(i * 4 + 3, null, 'A0QQ', 'QP1L', 'Y167')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "firebolt"), 'A0QR', 'A1B3', 'Y168')
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 4, "yidaonimane")
        endif
        set i = 43 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A1EA')), 'A1EA', 0, 'Y169')
        call RegisterHeroSkill(i * 4 + 2, "", 'A0RV', 0, 'Y170')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "range only"), 'A0RO', 'QP1S', 'Y171')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        //set HeroSkill_IsDisabledInDeathMatch[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "curse")+ SaveSkillOrder(i * 4 + 4, "spiritwolf"), 'A0RP', 'A449', 'Y172')
        //	set HeroSkill_Disabled[i*4+4]=true
        set HeroSkill_HasMultipleAbilities[i * 4 + 4] = true
        set i = 44 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "spiritlink")+ SaveSkillOrder(i * 4 + 1, "coupletarget"), 'A0S9', 0, 'Y173')
        set HeroSkill_HasMultipleAbilities[i * 4 + 1] = true
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "creepanimatedead"), 'A0SC', 0, 'Y174')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "phaseshift"), 'A0SB', 0, 'Y175')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "rainofchaos"), 'A0S8', 'A1QP', 'Y176')
        set i = 45 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "creepdevour"), 'A0Z4', 0, 'Y177')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "neutraldetectaoe"), 'A0Z5', 0, 'Y178')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "blizzard"), 'A0Z6', 0, 'Y179')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "clusterrockets"), 'A0Z8', 'A1CV', 'Y180')
        set i = 46 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "rejuvination"), 'A136', 0, 'Y181')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "r12"), 'A13T', 0, 'Y182')
        set HeroSkill_IsPassive[i * 4 + 2] = true
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 2, "HXshuidaohaimin")
        endif
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 2, "HXshuidaorenshu")
        endif
        set HeroSkill_IsPassive[i * 4 + 2] = true
        set HeroSkill_RearmCombosDisabledTips[i * 4 + 2] = "远程模型使用水刀只造成80%的范围伤害"
        call SaveSkillOrderInBalanceOffDisabled(i * 4 + 2, "bgdmg2")
        call SaveSkillOrderInBalanceOffDisabled(i * 4 + 2, "Tide-Jinada")
        call SaveSkillOrderInBalanceOffDisabled(i * 4 + 2, "Tide-Drunken")
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "incineratearrow")+ SaveSkillOrder(i * 4 + 3, "incineratearrowoff"), 'A11N', 0, 'Y183')
        call SaveSkillOrderInBalanceOffDisabled(i * 4 + 3, "r29")
        set HeroSkill_HasMultipleAbilities[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "spiritofvengeance"), 'A11K', 'Z31K', 'Y184')
        set i = 47 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A12J')), 'A12J', 0, 'Y185')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "spirittroll"), 'A12K', 0, 'Y186')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, GetAbilityOrder('A14I')), 'A14I', 0, 'Y187')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "incineratearrowon"), 'A12P', 'A1D6', 'Y188')
        set i = 48 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "creepthunderbolt"), 'A1SO', 0, 'Y189')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A1SQ')), 'A1SQ', 0, 'Y190')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "orb effect")+ SaveSkillOrder(i * 4 + 3, "range only")+ SaveSkillOrder(i * 4 + 3, GetAbilityOrder('A229'))+ SaveSkillOrder(i * 4 + 3, "multi-attack"), 'A229', 0, 'Y191')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "silence"), 'A1T5', 'A235', 'Y192')
        set i = 49 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "autodispel"), 'A1TV', 0, 'Y193')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A1SW')), 'A1SW', 0, 'Y194')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "rechargeoff"), 'A1SU', 0, 'Y195')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "deathpact"), 'A1U6', 'A30N', 'Y196')
        set i = 50 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "standdown"), 'A1YO', 0, 'Y197')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "frenzyon"), 'A1S7', 0, 'Y198')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "summongrizzly"), 'A1YR', 0, 'Y199')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A1YQ'))+ SaveSkillOrder(i * 4 + 4, "autoharvestlumber"), 'A1YQ', 'A3DE', 'Y200')
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 4, "HXzhangdahaimin")
        endif
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 4, "HXrenshuhaimin")
        endif
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 4, "HXshuidaohaimin")
        endif
        call SaveSkillOrderInBalanceOffDisabled(i * 4 + 4, "bgdmg2")
        set i = 51 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "creepthunderclap"), 'A1RJ', 0, 'Y201')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "gold2lumber")+ SaveSkillOrder(i * 4 + 2, "harvest"), 'A1YX', 0, 'Y202')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "charm")+ SaveSkillOrder(i * 4 + 3, "immolation")+ SaveSkillOrder(i * 4 + 3, "unimmolation")+ SaveSkillOrder(i * 4 + 3, "animatedead"), 'A1YY', 0, 'Y203')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "rechargeon")+ SaveSkillOrder(i * 4 + 4, "r123")+ SaveSkillOrder(i * 4 + 4, "locust"), 'A1RK', 'A43H', 'Y204')
        set i = 52 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "darkritual"), 'A0FW', 'A3OD', 'Y205')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A0GP')), 'A0GP', 0, 'Y206')
        call RegisterHeroSkill(i * 4 + 3, null, 'A0M3', 'QP1M', 'Y207')
        //set HeroSkill_Disabled[i*4+3]=true
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, null, 'A0FV', 'QP1N', 'Y208')
        set HeroSkill_IsPassive[i * 4 + 4] = true
        set HeroSkill_RearmCombosDisabledTips[i * 4 + 4] = "冷却时间在3秒及以下的技能每使用2次才触发1次战意（刺针扫射和粘稠鼻液除外）"
        set i = 53 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "wispharvest"), 'A27F', 0, 'Y209')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "tranquility"), 'A27G', 0, 'Y210')
        call RegisterHeroSkill(i * 4 + 3, null, 'A27V', 'QP0P', 'Y211')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "transmute")+ SaveSkillOrder(i * 4 + 4, "shbug"), 'A27H', 'A30J', 'Y212')
        set HeroSkill_HasMultipleAbilities[i * 4 + 4] = true
        set i = 54 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A2H3')), 'A2H3', 0, 'Y213')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "recharge")+ SaveSkillOrder(i * 4 + 2, "metamorphosis")+ SaveSkillOrder(i * 4 + 2, "shuashecheng")+ SaveSkillOrder(i * 4 + 2, "yongjiu1"), 'QB0L', 0, 'QY0L')
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 2, "HXLianji")//+ SaveSkillOrder(i * 4 + 2, "melee morph")
        endif
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "darksummoning")+ SaveSkillOrder(i * 4 + 2, "r27"), 'A2HS', 0, 'Y215')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "ancestralspirit")+ SaveSkillOrder(i * 4 + 4, "acolyteharvest"), 'A2JR', 'A2JL', 'Y216')
        set HeroSkill_HasMultipleAbilities[i * 4 + 4] = true
        //	set HeroSkill_Disabled[i * 4 + 4] = true
        set i = 55 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "steal"), 'A2JB', 0, 'Y217')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "creepheal"), 'A2J2', 0, 'Y218')
        call RegisterHeroSkill(i * 4 + 3, null, 'A2EY', 'QP1O', 'Y219')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "autodispeloff"), 'A2CI', 'A38C', 'Y220')
        set i = 56 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A2BE')), 'A2BE', 0, 'Y221')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A2IT')), 'A2IT', 0, 'Y222')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "soulburn"), 'A2HN', 0, 'Y223')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "submerge"), 'A2BG', 'A30H', 'Y224')
        set i = 57 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A2FK')), 'A2FK', 0, 'Y225')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "summonfactory"), 'A2E3', 0, 'Y226')
        call RegisterHeroSkill(i * 4 + 3, null, 'A2E4', 'QP1P', 'Y227')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "immolation")+ SaveSkillOrder(i * 4 + 4, "unimmolation")+ ""+ SaveSkillOrder(i * 4 + 4, "auraunholy"), 'A2E5', 'A43S', 'Y228')
        set i = 58 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "spiritwolf"), 'A03D', 0, 'Y229')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "deathcoil"), 'A0ZF', 0, 'Y230')
        call RegisterHeroSkill(i * 4 + 3, null, 'A03E', 'QP0Q', 'Y231')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        set HeroSkill_IsDisabledInDeathMatch[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "metamorphosis")+ SaveSkillOrder(i * 4 + 4, "melee morph")+ SaveSkillOrder(i * 4 + 4, "r95"), 'QM02', 0, 'Y232')
        
        set i = 59 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "parasite"), 'A0BH', 0, 'Y233')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "restoration")+ SaveSkillOrder(i * 4 + 2, "inv bug 1"), 'Z234', 0, 'Y234')
        set HeroSkill_IsDisabledInDeathMatch[i * 4 + 2] = true

        // 麻痹之咬
        call RegisterHeroSkill(i * 4 + 3, null, 'Q0BK', 'QP29', 'Y235')
        set HeroSkill_Disabled[i * 4 + 3] = true
        set HeroSkill_IsPassive[i * 4 + 3] = true

        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "bash")+ SaveSkillOrder(i * 4 + 4, "roar"), 'A0WQ', 0, 'Y236')
        set i = 60 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "summonphoenix"), 'A0YM', 0, 'Y237')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "deathcoil"), 'A0PL', 0, 'Y238')
        call RegisterHeroSkill(i * 4 + 3, null, 'A03P', 'QP0R', 'Y239')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, null, 'A03Q', 'QP0S', 'Y240')
        set HeroSkill_IsPassive[i * 4 + 4] = true
        set i = 61 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "range only")+ SaveSkillOrder(i * 4 + 1, "immolation")+ SaveSkillOrder(i * 4 + 1, "unimmolation"), 'A1C0', 'A418', 'Y241')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A0G2')), 'A0G2', 0, 'Y242')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "manashieldon")+ SaveSkillOrder(i * 4 + 3, "manashieldoff")+ SaveSkillOrder(i * 4 + 3, "shbug"), 'A0MP', 0, 'Y243')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "lavamonster"), 'A1AT', 0, 'Y244')
        set i = 62 - 1
        call RegisterHeroSkill(i * 4 + 1, "", 'A02H', 0, 'Y245')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "drunkenhaze"), 'A08Q', 0, 'Y246')
        call RegisterHeroSkill(i * 4 + 3, null, 'P247', 'A086', 'Y247')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "battlestations")+ SaveSkillOrder(i * 4 + 4, "r14"), 'DRKN', 0, 'Y248')
        set HeroSkill_IsDisabledInDeathMatch[i * 4 + 4] = true
        set i = 63 - 1
        call RegisterHeroSkill(i * 4 + 1, "", 'QB0H', 0, 'QY0H')
        call RegisterHeroSkill(i * 4 + 2, null, 'P250', 'QP0U', 'Y250')
        set HeroSkill_IsPassive[i * 4 + 2] = true
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "wispharvest"), 'A2S0', 'QP0W', 'Y251')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "reincarnation")+ SaveSkillOrder(i * 4 + 4, "r15"), 'A01Y', 'A1AZ', 'Y252')
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 4, "HXqwew")
        endif
        set HeroSkill_IsPassive[i * 4 + 4] = true
        set i = 64 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "channel")+ SaveSkillOrder(i * 4 + 1, "animatedead")+ ""+ SaveSkillOrder(i * 4 + 1, "tornado")+ SaveSkillOrder(i * 4 + 1, "ensnare")+ SaveSkillOrder(i * 4 + 1, "thunderclap")+ SaveSkillOrder(i * 4 + 1, "purge"), 'A10R', 'A32Z', 'Y253')
        set s = SaveSkillOrder(i * 4 + 1, "frostarmor")+ SaveSkillOrder(i * 4 + 1, "manaburn")+ SaveSkillOrder(i * 4 + 1, "heal")+ SaveSkillOrder(i * 4 + 1, "raisedead")+ ""
        set HeroSkill_HasMultipleAbilities[i * 4 + 1] = true
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A1OP')), 'A1OP', 0, 'Y254')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "firebolt"), 'A094', 0, 'Y255')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "doom"), 'A0MU', 'A0A2', 'Y256')
        set i = 65 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "impale"), 'A0X7', 0, 'Y257')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "creepheal"), 'A1H5', 0, 'Y258')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, GetAbilityOrder('A2KO')), 'A2KO', 0, 'Y259')
        call RegisterHeroSkill(i * 4 + 4, "", 'A09U', 0, 'Y260')
        set i = 66 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "berserk"), 'A05C', 0, 'Y261')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "roar"), 'A29K', 0, 'Y262')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "bash"), 'A0JJ', 0, 'Y263')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "faeriefire"), 'QB0C', 0, 'QY0C')
        set i = 67 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "shadowstrike"), 'A0Q7', 0, 'Y265')
        
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A0ME')), 'A0ME', 0, 'Y266')
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 2, "HXshijianmanbu")
        endif
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, GetAbilityOrder('A04A')), 'A04A', 0, 'Y267')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A28R')), 'A28R', 'A28S', 'Y268')
        set i = 68 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "berserk"), 'A030', 0, 'Y269')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "arrows")+ SaveSkillOrder(i * 4 + 2, "range only")+ SaveSkillOrder(i * 4 + 2, "channel"), 'AHfa', 0, 'Y270')
        call RegisterHeroSkill(i * 4 + 3, "", 'QB0A', 0, 'QY0A')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "innerfire"), 'A04Q', 0, 'Y272')
        set i = 69 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A0LK')), 'A0LK', 0, 'Y273')
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 1, "HXshijianmanbu")
        endif
        call RegisterHeroSkill(i * 4 + 2, null, 'A0CZ', 'QP22', 'Y274')
        set HeroSkill_IsPassive[i * 4 + 2] = true
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "bash"), 'A081', 'QP0X', 'Y275')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "clusterrockets")+ SaveSkillOrder(i * 4 + 4, "r16"), 'A0J1', 'A1D7', 'Y276')
        set i = 70 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "arrows")+ SaveSkillOrder(i * 4 + 1, "range only"), 'A09V', 0, 'Y277')
        call RegisterHeroSkill(i * 4 + 2, null, 'A1A3', 'QP21', 'Y278')
        set HeroSkill_IsPassive[i * 4 + 2] = true
        call RegisterHeroSkill(i * 4 + 3, null, 'A0MM', 'QP0Y', 'Y279')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "shadowstrike"), 'A080', 'A1UZ', 'Y280')
        set i = 71 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A1E7')), 'A1E7', 0, 'Y281')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "tankdroppilot"), 'A1DP', 0, 'Y282')
        call RegisterHeroSkill(i * 4 + 3, null, 'A1E6', 'QP0Z', 'Y283')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "darkportal"), 'A1AO', 'A1UV', 'Y284')
        set i = 72 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "852273"), 'A0T2', 0, 'Y285')
        set s = SaveSkillOrder(i * 4 + 1, "HXMomianwange")
        call RegisterHeroSkill(i * 4 + 2, null, 'A0SS', 'QP1W', 'Y286')
        set HeroSkill_IsPassive[i * 4 + 2] = true
        set HeroSkill_BalanceOffDisabledTips[i * 4 + 2] = "远程模型使用盛宴只造成/回复 1.75/2.75/3.75/4.75% 生命值的伤害"
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, GetAbilityOrder('A194')), 'A194', 0, 'Y287')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "decouple"), 'A0SW', 0, 'Y288')
        set i = 73 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "grabtree"), 'A0MT', 0, 'Y289')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "banish"), 'A2TD', 0, 'Y290')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "tornado"), 'A09D', 0, 'Y291')
        call RegisterHeroSkill(i * 4 + 4, GetAbilityOrder('A0CC'), 'A0CC', 'A02Z', 'Y292')
        set HeroSkill_Icon[i * 4 + 4] = "ReplaceableTextures\\CommandButtons\\BTNLifeDrain.blp"
        set i = 74 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A046')), 'A046', 'A3OH', 'Y293')
        call RegisterHeroSkill(i * 4 + 2, null, 'A04E', 'QP10', 'Y294')
        set HeroSkill_IsPassive[i * 4 + 2] = true
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "roar"), 'A226', 0, 'Y295')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "howlofterror"), 'A29I', 0, 'Y296')
        set i = 75 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "innerfire"), 'A04V', 0, 'Y297')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A0GK')), 'A0GK', 0, 'Y298')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "sleep"), 'A04Y', 0, 'Y299')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "magicleash"), 'A02Q', 'A1D9', 'Y300')
        set i = 76 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A05V')), 'A05V', 0, 'Y301')
        call RegisterHeroSkill(i * 4 + 2, null, 'A01N', 'QP11', 'Y302')
        set HeroSkill_IsPassive[i * 4 + 2] = true
        call RegisterHeroSkill(i * 4 + 3, null, 'A060', 'QP12', 'Y303')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, ""+ SaveSkillOrder(i * 4 + 4, "yidaonimane"), 'A067', 'A08P', 'Y304')
        set i = 77 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "detectaoe"), 'A06I', 0, 'Y305')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "unimmolation"), 'A06K', 0, 'Y306')
        call RegisterHeroSkill(i * 4 + 3, null, 'A06D', 'QP13', 'Y307')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "magicleash"), 'A0FL', 'A1CX', 'Y308')
        set i = 78 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "detonate"), 'A1P8', 0, 'Y309')
        call RegisterHeroSkill(i * 4 + 2, null, 'A0ES', 'QP14', 'Y310')
        set HeroSkill_IsPassive[i * 4 + 2] = true
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "bash"), 'A0G5', 'QP1X', 'Y311')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "creepheal"), 'A0G4', 'A1D8', 'Y312')
        set i = 79 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "tankloadpilot"), 'A1QW', 0, 'Y313')
        call RegisterHeroSkill(i * 4 + 2, "", 'A0CA', 0, 'Y314')
        
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "orb effect")+ SaveSkillOrder(i * 4 + 3, "range only"), 'A0CG', 0, 'Y315')
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 3, "HXLianji")
        endif
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call SaveSkillOrderInBalanceOffDisabled(i * 4 + 3, "bgdmg2")
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "disassociate"), 'A0CT', 'A3DM', 'Y316')
        call SaveSkillOrderInBalanceOffDisabled(i * 4 + 4, "r31")
        set i = 80 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "roar")+ SaveSkillOrder(i * 4 + 1, "howlofterror")+ SaveSkillOrder(i * 4 + 1, "battleroar"), 'A0EY', 0, 'Y317')
        set HeroSkill_HasMultipleAbilities[i * 4 + 1] = true
        call RegisterHeroSkill(i * 4 + 2, null, 'Z318', 'A0BR', 'Y318')
        set HeroSkill_IsPassive[i * 4 + 2] = true
        call RegisterHeroSkill(i * 4 + 3, null, 'A0FU', 'QP15', 'Y319')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 1, "852273"), 'A29J', 'A3OJ', 'Y320')
        set s = SaveSkillOrder(i * 4 + 4, "HXMomianwange")
        set i = 81 - 1
        //call RegisterHeroSkill(i*4+1,SaveSkillOrder(i*4+1,"disenchant"), 'A06O',0, 'Y321')
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "disenchant"), 'A06O', 'A3NX', 'Y321')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "voodoo"), 'A0H0', 0, 'Y322')
        call RegisterHeroSkill(i * 4 + 3, null, 'A0FA', 'QP16', 'Y323')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "lightningshield"), 'A06R', 'A1B4', 'Y324')
        set i = 82 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "dismount"), 'A0I6', 0, 'Y325')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "creepheal"), 'A0S1', 0, 'Y326')
        call RegisterHeroSkill(i * 4 + 3, null, 'A0C6', 'QP17', 'Y327')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A0E2')), 'A0E2', 'A1MR', 'Y328')
        set i = 83 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "farsight"), 'A44X', 0, 'Y61A')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "creepheal"), 'A44Z', 0, 'Y61B')
        call RegisterHeroSkill(i * 4 + 3, null, 'A0I8', 'QP1Z', 'Y331')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "shadowsight"), 'A0LH', 0, 'Y332')
        set i = 84 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "townbelloff"), 'A0I3', 0, 'Y333')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A0MF')), 'A0MF', 0, 'Y334')
        call RegisterHeroSkill(i * 4 + 3, null, 'A0MG', 'QP18', 'Y335')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, ""+ SaveSkillOrder(i * 4 + 4, "r17"), 'A0NS', 'A1DA', 'Y336')
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 4, "HXqwew")
        endif
        set i = 85 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "impale"), 'A0HW', 0, 'Y337')
        call RegisterHeroSkill(i * 4 + 2, null, 'A0FX', 'QP19', 'Y338')
        set HeroSkill_IsPassive[i * 4 + 2] = true
        set HeroSkill_RearmCombosDisabledTips[i * 4 + 2] = "远程英雄和幻象只造成一半的荒芜伤害"
        call RegisterHeroSkill(i * 4 + 3, null, 'A0NA', 'QP20', 'Y339')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        set HeroSkill_RearmCombosDisabledTips[i * 4 + 3] = "力量模型只折射 8/10/12/14% 的伤害"
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "healingspray")+ SaveSkillOrder(i * 4 + 4, "healingwave")+ SaveSkillOrder(i * 4 + 4, "r18"), 'A0H9', 0, 'Y340')
        set HeroSkill_HasMultipleAbilities[i * 4 + 4] = true
        set i = 86 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A0NM')), 'A0NM', 0, 'Y341')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "unimmolation"), 'A0NE', 0, 'Y342')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "renew"), 'A0NO', 0, 'Y343')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "tornado"), 'A0NT', 'A0NX', 'Y344')
        set i = 87 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "arrows")+ SaveSkillOrder(i * 4 + 1, "range only"), 'A0OI', 0, 'Y345')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A0OJ')), 'A0OJ', 0, 'Y346')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "r19"), 'A0IF', 'QP1A', 'Y347')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        set HeroSkill_RearmCombosDisabledTips[i * 4 + 3] = "若同时学习了球状闪电，则精气光环触发时只恢复8/10/12/14%的最大魔法"
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "blizzard"), 'A0OK', 'A1VW', 'Y348')
        set i = 88 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "autodispelon"), 'A0J5', 0, 'Y349')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "creepheal"), 'A0AS', 0, 'Y350')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "blizzard"), 'A06P', 0, 'Y351')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "inferno")+ SaveSkillOrder(i * 4 + 4, "r20"), 'S008', 'S00U', 'Y352')
        set i = 89 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "renewon"), 'A0NB', 0, 'Y353')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "carrionscarabsoff"), 'A0N8', 0, 'Y354')
        call RegisterHeroSkill(i * 4 + 3, null, 'A0N7', 'QP1B', 'Y355')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, null, 'A0MW', 'A27C', 'Y356')
        set HeroSkill_Disabled[i * 4 + 4] = true
        set i = 90 - 1
        call RegisterHeroSkill(i * 4 + 1, "", 'A0NQ', 0, 'Y357')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "devourmagic"), 'A10L', 0, 'Y358')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "darkportal"), 'A0OR', 0, 'Y359')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "renewoff"), 'A10Q', 'A1DB', 'Y360')
        set i = 91 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "rainoffire"), 'A01I', 0, 'Y361')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "flamestrike"), 'A0RA', 0, 'Y362')
        call RegisterHeroSkill(i * 4 + 3, null, 'AIcd', 'QP1C', 'Y363')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "divineshield")+ SaveSkillOrder(i * 4 + 4, "whirlwind"), 'A0R0', 0, 'Y364')
        set i = 92 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "repair, str bug"), 'A15S', 'A3JX', 'Y365')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "lumber2gold"), 'A0R5', 0, 'Y366')
        //set HeroSkill_Disabled[i*4+2]=true
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "soulpreservation")+ SaveSkillOrder(i * 4 + 3, "r21"), 'A15V', 0, 'Y367')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "metamorphosis")+ SaveSkillOrder(i * 4 + 4, "melee morph")+ SaveSkillOrder(i * 4 + 4, "r24"), 'QM03', 0, 'Y368')
        set HeroSkill_HasMultipleAbilities[i * 4 + 4] = true
        set HeroSkill_Disabled[i * 4 + 4] = true
        
        set i = 93 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "repairoff"), 'A0QE', 0, 'Y369')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "autoentangle")+ SaveSkillOrder(i * 4 + 2, "r26"), 'A0QG', 0, 'Y370')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "bloodlust"), 'A0R7', 0, 'Y371')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "manaflareon"), 'A0QK', 'A21Q', 'Y372')
        set i = 94 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "tranquility"), 'A32A', 0, 'A32T')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "curse"), 'A32C', 0, 'A32U')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "eattree")+ SaveSkillOrder(i * 4 + 3, "controlmagic"), 'A32E', 0, 'A32V')
        set HeroSkill_HasMultipleAbilities[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A32G')), 'A32G', 0, 'A32W')
        set i = 95 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "townbellon"), 'A0I7', 0, 'Y377')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "autoentangleinstant"), 'A180', 0, 'Y378')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "load"), 'A0B1', 0, 'Y379')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "cannibalize"), 'A1BX', 'A30L', 'Y380')
        set i = 96 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "repairon"), 'A1EL', 0, 'Y381')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "autoharvestgold"), 'A19V', 0, 'Y382')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "metamorphosis")+ SaveSkillOrder(i * 4 + 3, "range morph")+ SaveSkillOrder(i * 4 + 3, "r3"), 'QM04', 0, 'Y383')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A19O')), 'A19O', 'A1MV', 'Y384')
        set i = 97 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "etherealform"), 'A1MG', 0, 'Y385')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "replenish"), 'A1HS', 0, 'Y386')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "berserk"), 'A1HQ', 0, 'Y387')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "taunt")+ SaveSkillOrder(i * 4 + 4, "r22"), 'A1MI', 'A2QE', 'Y388')
        set i = 98 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A1IM')), 'A1IM', 0, 'Y389')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "whirlwind"), 'A1J7', 0, 'Y390')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "abuz agi") , 'A1HR', 'QP1F', 'Y391')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        set HeroSkill_BalanceOffDisabledTips[i * 4 + 3] = "远程模型使用能量转移只有2/3的效果"
        call RegisterHeroSkill(i * 4 + 4, ""+ SaveSkillOrder(i * 4 + 4, "ibug"), 'A1IN', 0, 'Y392')
        set i = 99 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "replenishoff"), 'A2KZ', 0, 'Y393')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "board"), 'A0H4', 0, 'Y394')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "metamorphosis")+ SaveSkillOrder(i * 4 + 3, "range morph")+ SaveSkillOrder(i * 4 + 3, "chemicalrage"), 'A1RI', 0, 'Y395')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A07Q')), 'A07Q', 0, 'Y396')
        set i = 100 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "requestsacrifice"), 'QB0F', 0, 'QY0F')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A20T')), 'A20T', 0, 'Y398')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, GetAbilityOrder('A06V')), 'A06V', 0, 'Y399')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "berserk"), 'A21F', 'A21G', 'Y400')
        set i = 101 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A1S8')), 'A1S8', 0, 'Y401')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "replenishon"), 'A1SB', 0, 'Y402')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "fingerofdeath")+ SaveSkillOrder(i * 4 + 3, "flare"), 'A1S4', 0, 'Y403')
        set HeroSkill_HasMultipleAbilities[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "blizzard"), 'A343', 'A34J', 'Y404')
        set i = 102 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "frostnova"), 'A07F', 0, 'Y405')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "frostarmor"), 'A08R', 0, 'Y406')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "innerfire"), 'A053', 0, 'Y407')
        call RegisterHeroSkill(i * 4 + 4, "", 'A05T', 'A08H', 'Y408')
        set i = 103 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A078')), 'A078', 0, 'Y409')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "silence"), 'A07M', 0, 'Y410')
        call RegisterHeroSkill(i * 4 + 3, null, 'A02C', 0, 'Y411')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "locustswarm"), 'A04N', 0, 'Y412')
        if ExtraSkillsCount == 2 then
            set HeroSkill_Tips[i * 4 + 4] = "该技能在此模式下会减少对建筑25%伤害"
        endif
        set HeroSkill_Icon[i * 4 + 4] = "ReplaceableTextures\\CommandButtons\\BTNExorcism.blp"
        set i = 104 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "freezingbreath"), 'A0X5', 0, 'Y413')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "hex"), 'A0MN', 0, 'Y414')
        call RegisterHeroSkill(i * 4 + 3, GetAbilityOrder('A02N'), 'A02N', 0, 'Y415')
        set HeroSkill_Icon[i * 4 + 3] = "ReplaceableTextures\\CommandButtons\\BTNManaDrain.blp"
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A095')), 'A095', 'A09W', 'Y416')
        set i = 105 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "magicdefense"), 'A173', 0, 'Y417')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "buff placer"), 'A0MY', 'QP1D', 'Y418')
        set HeroSkill_IsPassive[i * 4 + 2] = true
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "ward"), 'A0MS', 0, 'Y419')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "summongrizzly"), 'A013', 'A0A6', 'Y420')
        set i = 106 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A02S')), 'A02S', 'A3Y8', 'Y421')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "innerfire"), 'A037', 0, 'Y422')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "blackarrowon"), 'A1RD', 0, 'Y423')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "roar"), 'A29L', 'A447', 'Y424')
        set i = 107 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "cripple"), 'A08X', 0, 'Y425')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "creepheal"), 'A1NA', 0, 'Y426')
        set HeroSkill_HasMultipleAbilities[i * 4 + 2] = true
        call RegisterHeroSkill(i * 4 + 3, null, 'A0VX', 'QP23', 'Y427')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A1NE')), 'A1NE', 'A2IG', 'Y428')
        set i = 108 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "tankpilot"), 'A055', 0, 'Y429')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "forceboard"), 'A0RW', 0, 'Y430')
        call RegisterHeroSkill(i * 4 + 3, null, 'A03N', 'QP1E', 'Y431')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A03O')), 'A03O', 0, 'Y432')
        set i = 109 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "stomp")+ SaveSkillOrder(i * 4 + 1, "range morph")+ SaveSkillOrder(i * 4 + 1, "r44")+ SaveSkillOrder(i * 4 + 1, "metamorphosis")+ SaveSkillOrder(i * 4 + 1, "yongjiu3"), 'A332', 0, 'Y437')
        if (not Mode__RearmCombos) then
            set s = SaveSkillOrder(i * 4 + 1, "HXBinglongTuijin")
        endif
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "unstoneform"), 'A2LA', 0, 'Y438')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "townbellon"), 'A2LB', 0, 'Y439')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "unwindwalk"), 'A0Z0', 0, 'Y440')
        set i = 110 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "unravenform"), 'A2M1', 0, 'Y433')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "unrobogoblin"), 'A2LM', 0, 'Y434')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "undeadbuild"), 'A2LL', 0, 'Y435')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "metamorphosis")+ SaveSkillOrder(i * 4 + 4, "summongrizzly"), 'A2M0', 0, 'Y436')
        set HeroSkill_Disabled[i * 4 + 4] = true
        set i = 111 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "cripple"), 'A2QM', 0, 'Y443')
        set HeroSkill_HasMultipleAbilities[i * 4 + 1] = true
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "unsubmerge"), 'A2TJ', 0, 'Y444')
        set HeroSkill_HasMultipleAbilities[i * 4 + 2] = true
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "unflamingarrows"), 'A2QI', 0, 'Y445')
        set HeroSkill_HasMultipleAbilities[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "summonwareagle"), 'A2TI', 0, 'Y446')
        set HeroSkill_HasMultipleAbilities[i * 4 + 4] = true
        set i = 112 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "webon"), 'A2QT', 0, 'Y453')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, GetAbilityOrder('A2T5')), 'A2T5', 0, 'Y454')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "avengerform"), 'A2SG', 0, 'Y455')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "lavamonster"), 'A2TF', 0, 'Y456')
        set i = 113 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, GetAbilityOrder('A1PH')), 'A1PH', 0, 'Y458')
        call RegisterHeroSkill(i * 4 + 2, null, 'A33Q', 'A33R', 'Y459')
        set HeroSkill_IsPassive[i * 4 + 2] = true
        //	if (not Mode__RearmCombos) then
        //		set HeroSkill_Disabled[i * 4 + 2] = true
        //	endif
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "magicdefense"), 'A34A', 'QP28', 'A34B')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "barkskinoff"), 'A33U', 0, 'Y460')
        if (Mode__SingleDraft or Mode__MirrorDraft or Mode__AllRandom) == false then
            set i = 114 - 1
            call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "request_hero")+ SaveSkillOrder(i * 4 + 1, "r23"), 'Z601', 0, 'Y601')
            call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "mechanicalcritter"), 'Z602', 0, 'Y602')
            call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "militia"), 'Z603', 0, 'Y603')
            call RegisterHeroSkill(i * 4 + 4, null, 0, 0, 0)
            set HeroSkill_Disabled[i * 4 + 4] = true
            set i = 115 - 1
            call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "militiaconvert"), 'Z604', 0, 'Y604')
            call RegisterHeroSkill(i * 4 + 2, "", 'Z605', 0, 'Y605')
            call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "militiaoff"), 'Z606', 0, 'Y606')
            call RegisterHeroSkill(i * 4 + 4, null, 0, 0, 0)
            set HeroSkill_Disabled[i * 4 + 4] = true
            set i = 116 - 1
            call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "militiaunconvert"), 'Z607', 0, 'Y607')
            call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "mindrot"), 'Z608', 0, 'Y608')
            call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "monsoon"), 'Z609', 0, 'Y609')
            call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "mount"), 'Z610', 'A3K5', 'Y610')
            call AddControlSkillIndex(i * 4 + 4)
            call ExecuteFunc("PreloadKael_Ability")
        endif
        set i = 117 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "unload"), 'A40K', 'A40S', 'Y500')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "unloadall"), 'A40L', 'A40T', 'Y501')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "unloadallcorpses"), 'A40M', 'A40U', 'Y502')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "undeadbuild"), 'A40N', 'A40V', 'Y503')
        //set HeroSkill_Disabled[i * 4 + 4] = true	无形
        set i = 118 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "lavamonster"), 'A0QV', 0, 'Y614')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "carrionscarabs")+ SaveSkillOrder(i * 4 + 2, "carrionscarabsoff")+ SaveSkillOrder(i * 4 + 2, "carrionscarabson"), 'A43Y', 0, 'Y615')
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, "carrionscarabs")+ SaveSkillOrder(i * 4 + 3, "carrionscarabsoff")+ SaveSkillOrder(i * 4 + 3, "carrionscarabson"), 'A00T', 0, 'Y616')
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "renew"), 'A46J', 0, 'Y61K')
        set i = 119 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "soulburn"), 'A0EC', 0, 'Y329')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "lumber2gold"), 'A44U', 0, 'Y618')
        //set HeroSkill_Disabled[i * 4 + 2] = true	下注
        if Mode__SixSkills and(not Mode__RearmCombos) then
            set HeroSkill_Disabled[i * 4 + 2] = true
        endif
        call RegisterHeroSkill(i * 4 + 3, null, 'A0LE', 'QP1Y', 'Y330')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, null, 'A440', 'QP25', 'Y617')
        set HeroSkill_IsPassive[i * 4 + 4] = true
        set i = 120 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "volcano"), 'A451', 0, 'Y61C')
        call RegisterHeroSkill(i * 4 + 2, "", 'A454', 0, 'Y61D')
        call RegisterHeroSkill(i * 4 + 3, null, 'A45B', 'QP26', 'Y61E')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, GetAbilityOrder('A456')), 'A456', 0, 'Y61F')
        set i = 121 - 1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, "curse"), 'A45W', 0, 'Y61G')
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, "volcano"), 'A45X', 0, 'Y61H')
        call RegisterHeroSkill(i * 4 + 3, null, 'A460', 'QP27', 'Y61I')
        set HeroSkill_IsPassive[i * 4 + 3] = true
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, "creepthunderclap"), 'A461', 0, 'Y61J')
        set MAX_HERO_INDEX = 121
        if Mode__SingleDraft or Mode__MirrorDraft or Mode__AllRandom then
            call ExecuteFunc("AssignInvokerSkills")
        endif
    endfunction

    function AssignInvokerSkills takes nothing returns nothing
        local integer i = 1
        local integer k = 0
        local integer j = 1
        local integer array s
        local string array R2R
        local string array R3R
        
        local integer array QSX
        local integer array R5R
        local integer R6R
        local unit u = CreateUnit(Player(13), 'e00E', 0, 0, 0)
        //local integer rndIndex
        set s[1] = 1
        set s[2] = 2
        set s[3] = 3
        set s[4] = 4
        set s[5] = 5
        set s[6] = 6
        set s[7] = 7
        set s[8] = 8
        set s[9] = 9
        set s[10] = 10
        //set R4R[1] = "t"
        //set R4R[2] = "d"
        //set R4R[3] = "f"
        //set R4R[4] = "y"
        //set R4R[5] = "v"
        //set R4R[6] = "g"
        //set R4R[7] = "z"
        //set R4R[8] = "x"
        //set R4R[9] = "c"
        //set R4R[10] = "b"
        loop
        exitwhen(i == 10)
            set k = GetRandomInt(1, 10)
            set R6R = s[i]
            set s[i] = s[k]
            set s[k] = R6R
            set i = i + 1
        endloop
        set R3R[1] = "request_hero"
        set R3R[2] = "mechanicalcritter"
        set R3R[3] = "militia"
        set R3R[4] = "militiaconvert"
        set R3R[5] = "windwalk"
        set R3R[6] = "militiaoff"
        set R3R[7] = "militiaunconvert"
        set R3R[8] = "mindrot"
        set R3R[9] = "monsoon"
        set R3R[10] = "mount"
        set i = 1
        loop
            set QSX[i]='Z600'+ i
            set R5R[i]='Y600'+ i
            set R2R[i] = GetAbilitySoundById(QSX[i], SOUND_TYPE_EFFECT_LOOPED)
            set i = i + 1
        exitwhen i > 9
        endloop
        set QSX[10]='Z610'
        set R5R[10]='Y610'
        set R2R[10] = GetAbilitySoundById(QSX[10], SOUND_TYPE_EFFECT_LOOPED)
        set i = 114 -1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, R3R[s[1]]), QSX[s[1]], 0, R5R[s[1]])
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, R3R[s[2]]), QSX[s[2]], 0, R5R[s[2]])
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, R3R[s[3]]), QSX[s[3]], 0, R5R[s[3]])
        call RegisterHeroSkill(i * 4 + 4, null, 0, 0, 0)
        set HeroSkill_Disabled[i * 4 + 4] = true
        call HeroSkillBalanceSunStrike(i, QSX[s[1]], QSX[s[2]], QSX[s[3]], 0)
        set i = 115 -1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, R3R[s[4]]), QSX[s[4]], 0, R5R[s[4]])
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, R3R[s[5]]), QSX[s[5]], 0, R5R[s[5]])
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, R3R[s[6]]), QSX[s[6]], 0, R5R[s[6]])
        call RegisterHeroSkill(i * 4 + 4, null, 0, 0, 0)
        set HeroSkill_Disabled[i * 4 + 4] = true
        call HeroSkillBalanceSunStrike(i, QSX[s[4]], QSX[s[5]], QSX[s[6]], 0)
        set i = 116 -1
        call RegisterHeroSkill(i * 4 + 1, SaveSkillOrder(i * 4 + 1, R3R[s[7]]), QSX[s[7]], 0, R5R[s[7]])
        call RegisterHeroSkill(i * 4 + 2, SaveSkillOrder(i * 4 + 2, R3R[s[8]]), QSX[s[8]], 0, R5R[s[8]])
        call RegisterHeroSkill(i * 4 + 3, SaveSkillOrder(i * 4 + 3, R3R[s[9]]), QSX[s[9]], 0, R5R[s[9]])
        call RegisterHeroSkill(i * 4 + 4, SaveSkillOrder(i * 4 + 4, R3R[s[10]]), QSX[s[10]], 0, R5R[s[10]])
        call HeroSkillBalanceSunStrike(i, QSX[s[7]], QSX[s[8]], QSX[s[9]], QSX[s[10]])
        set i = 114 -1
        loop
        exitwhen i > 116 -1
            if HeroSkill_BaseId[i * 4 + 1]=='Z610' then
                call AddControlSkillIndex(i * 4 + 1)
                set i = 1231
            elseif HeroSkill_BaseId[i * 4 + 2]=='Z610' then
                call AddControlSkillIndex(i * 4 + 2)
                set i = 1231
            elseif HeroSkill_BaseId[i * 4 + 3]=='Z610' then
                call AddControlSkillIndex(i * 4 + 3)
                set i = 1231
            elseif HeroSkill_BaseId[i * 4 + 4]=='Z610' then
                call AddControlSkillIndex(i * 4 + 4)
                set i = 1231
            endif
            set i = i + 1
        endloop
        set i = 1
        //call DisplayTimedTextToPlayer(LocalPlayer, 0, 0, 10, GetObjectName('n06G'))
        loop
        exitwhen i > 10
            call UnitAddAbility(u, QSX[s[i]])
            set i = i + 1
        endloop
        call UnitAddAbility(u, 'QFZZ')
        call RemoveUnit(u)
        set u = null
    endfunction

endlibrary
