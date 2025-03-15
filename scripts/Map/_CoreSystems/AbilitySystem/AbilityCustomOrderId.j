library AbilityCustomOrderId requires Base

    globals
        private integer OrderIdBase = 950000

    endglobals

    static if DEBUG_MODE then
        globals
            private constant key KEY
        endglobals
    endif

    function AllocAbilityOrderId takes integer abilId returns integer 
        set OrderIdBase = OrderIdBase + 1
        call MHAbility_SetHookOrder(abilId, OrderIdBase)
        static if DEBUG_MODE then
            call ThrowWarning(MHAbility_GetHookOrder(abilId) == 0, "AbilityCustomOrderId", "AllocAbilityOrderId", Id2String(abilId), abilId, "该技能无法被分配命令Id:" + GetObjectName(abilId))
            call ThrowWarning(Table[KEY].has(abilId), "AbilityCustomOrderId", "AllocAbilityOrderId", Id2String(abilId), abilId, "重复的技能被分配命令Id:" + GetObjectName(abilId))
            set Table[KEY][abilId] = OrderIdBase
        endif
        return OrderIdBase
    endfunction

    // 对于施法类型一致的神杖升级效果，使用此函数分配为2个技能同一个命令id
    function AllocAbilityOrderIdEx takes integer baseId, integer upgradedId returns nothing
        set OrderIdBase = OrderIdBase + 1
        call MHAbility_SetHookOrder(baseId    , OrderIdBase)
        call MHAbility_SetHookOrder(upgradedId, OrderIdBase)
        static if DEBUG_MODE then
            call ThrowWarning(MHAbility_GetHookOrder(baseId) == 0, "AbilityCustomOrderId", "baseId", Id2String(baseId), baseId, "该技能无法被分配命令Id:" + GetObjectName(baseId))
            call ThrowWarning(MHAbility_GetHookOrder(upgradedId) == 0, "AbilityCustomOrderId", "upgradedId", Id2String(upgradedId), upgradedId, "该技能无法被分配命令Id:" + GetObjectName(upgradedId))
            call ThrowWarning(Table[KEY].has(baseId), "AbilityCustomOrderId", "baseId", Id2String(baseId), baseId, "重复的技能被分配命令Id:" + GetObjectName(baseId))
            call ThrowWarning(Table[KEY].has(upgradedId), "AbilityCustomOrderId", "upgradedId", Id2String(upgradedId), upgradedId, "重复的技能被分配命令Id:" + GetObjectName(upgradedId))
            set Table[KEY][baseId] = OrderIdBase
            set Table[KEY][upgradedId] = OrderIdBase
        endif
    endfunction

    //function AllocAbilityOrderIdByIndex takes integer skillIndex returns integer 
//
    //endfunction

    function GetAbilityOrder takes integer abilId returns string
        local integer id = MHAbility_GetHookOrder(abilId)
        if id == 0 then
            return ""
        endif
        return I2S(id)
    endfunction

    function GetAbilityOrderId takes integer abilId returns integer
        return MHAbility_GetHookOrder(abilId)
    endfunction

    function AbilityCustomOrderId_Init takes nothing returns nothing
        //***************************************************************************
        //*
        //*  chainlightning
        //*
        //***************************************************************************
        // 弧形闪电
        call AllocAbilityOrderId('A020')

        // 神灭斩
        call AllocAbilityOrderIdEx('A01P', 'A09Z')
        // 联结
        call AllocAbilityOrderId('A1TA')

        // 电子涡流
        call AllocAbilityOrderId('A14R')
        // 无目标
        call AllocAbilityOrderId('A3WT')

        // 束缚击
        call AllocAbilityOrderId('A12J')

        // 追踪导弹
        call AllocAbilityOrderId('A1SQ')

        // 一闪
        call AllocAbilityOrderId('A1SW')

        // 秘法箭
        call AllocAbilityOrderId('A2BE')

        // 秘术异蛇
        call AllocAbilityOrderId('A0G2')

        // 吞噬 - 连环闪电
        call AllocAbilityOrderId('A1OQ')

        // 撕裂伤口
        call AllocAbilityOrderId('A194')

        // 蚀脑
        call AllocAbilityOrderId('A0GK')

        // 淘汰之刃
        call AllocAbilityOrderIdEx('A0E2', 'A1MR')

        // 无光之盾
        call AllocAbilityOrderId('A0MF')

        // 麻痹药剂
        call AllocAbilityOrderId('A0NM')

        // 星体禁锢
        call AllocAbilityOrderId('A0OJ')

        // 燃烧枷锁
        call AllocAbilityOrderIdEx('A19O', 'A1MV')

        // 灵魂隔断
        call AllocAbilityOrderId('A07Q')

        // 闪电风暴
        call AllocAbilityOrderId('A06V')

        // 崩裂禁锢
        call AllocAbilityOrderId('A1S8')

        // 死亡一指
        call AllocAbilityOrderIdEx('A095', 'A09W')

        // 命运敕令
        call AllocAbilityOrderId('A2T5')

        //***************************************************************************
        //*
        //*  fanofknives
        //*
        //***************************************************************************
        // 战吼
        call AllocAbilityOrderId('A2IS')

        // 激流
        call AllocAbilityOrderId('A2KU')

        // 回音击
        call AllocAbilityOrderIdEx('A0DH', 'A1OB')

        // 狂猛
        call AllocAbilityOrderId('A1EG')

        // 超强力量
        call AllocAbilityOrderId('QB0P')

        // 热导飞弹
        call AllocAbilityOrderId('A05E')

        // 战斗专注
        call AllocAbilityOrderId('A1EJ')

        // 幽魂
        call AllocAbilityOrderId('A1T8')
        
        // 奔袭冲撞
        call AllocAbilityOrderIdEx('A2O6', 'A384')

        // 不稳定化合物
        call AllocAbilityOrderId('A1NI')
        // 取消
        call AllocAbilityOrderId('A1NH')

        // 残影
        call AllocAbilityOrderId('A14P')

        // 折光
        call AllocAbilityOrderId('A1EA')

        // 高射火炮
        call AllocAbilityOrderId('A229')

        // 风行者
        call AllocAbilityOrderId('A14I')

        // 海象挥击
        call AllocAbilityOrderId('A1YQ')
        call AllocAbilityOrderId('A3DE')

        // 刺针扫射
        call AllocAbilityOrderId('A0GP')

        // 炽热锁链
        call AllocAbilityOrderId('A2H3')

        // 震荡射击
        call AllocAbilityOrderId('A2IT')

        // 死亡旋风
        call AllocAbilityOrderId('A2FK')

        // 焦土
        call AllocAbilityOrderId('A1OP')

        // 尖刺外壳
        call AllocAbilityOrderId('A2KO')

        // 痛苦尖叫
        call AllocAbilityOrderId('A04A')

        // 等离子场
        call AllocAbilityOrderId('A1E7')

        // 死亡脉冲
        call AllocAbilityOrderId('A05V')

        // 冰晶爆轰 - 激活
        call AllocAbilityOrderId('A1MN')

        // 黑暗契约
        call AllocAbilityOrderId('A1IM')

        // 恶魔敕令
        call AllocAbilityOrderId('A20T')

        // 召唤佣兽
        call AllocAbilityOrderId('A1NE')
        call AllocAbilityOrderId('A2IG')
        
        // 地狱
        call AllocAbilityOrderId('A456')

        //***************************************************************************
        //*
        //*  carrionswarm
        //*
        //***************************************************************************
        // 食腐蝠群
        call AllocAbilityOrderId('A078')

        // 震荡波
        call AllocAbilityOrderIdEx('A02S', 'A3Y8')
        
        // 龙破斩
        call AllocAbilityOrderId('A01F')

        // 波浪形态
        call AllocAbilityOrderId('QB02')
        
        // 发芽
        call AllocAbilityOrderId('A21E')

        // 冰火交加
        call AllocAbilityOrderId('A0O7')
        
        // 时间漫游
        call AllocAbilityOrderId('A0LK')

        //***************************************************************************
        //*
        //*  acidbomb
        //*
        //***************************************************************************
        // 巨浪
        call AllocAbilityOrderId('A046')
        call AllocAbilityOrderId('A3OH')

        // 变体攻击
        call AllocAbilityOrderId('A0G6')

        // 引燃
        call AllocAbilityOrderId('A011')

        // 液态火
        call AllocAbilityOrderId('A30T')

        // TB - 灵魂汲取
        call AllocAbilityOrderId('A1PH')

        //***************************************************************************
        //*
        //*  shockwave
        //*
        //***************************************************************************
        // 超声冲击波
        call AllocAbilityOrderIdEx('A28R', 'A28S')

        // 烈火焚身
        call AllocAbilityOrderIdEx('A0O5', 'A1B1')

        // 吞噬 - 冲击波
        call AllocAbilityOrderId('A1OV')

        //***************************************************************************
        //*
        //*  breathoffire
        //*
        //***************************************************************************
        // 火焰气息
        call AllocAbilityOrderId('A03F')

        // 冰封路径
        call AllocAbilityOrderId('A0O6')

        //***************************************************************************
        //*
        //*  absorb
        //*
        //***************************************************************************
        // 刷逼之力
        call AllocAbilityOrderId('A32G')
        
        // 召唤巨石
        call AllocAbilityOrderId(EARTH_SPIRIT_STONE_REMNANT)

        //***************************************************************************
        //*
        //*  mirrorimage
        //*
        //***************************************************************************
        // 镜像
        call AllocAbilityOrderId('A063')

        // 混沌之军
        call AllocAbilityOrderId('A03O')

        //***************************************************************************
        //*
        //*  blink
        //*
        //***************************************************************************
        // 传送
        call AllocAbilityOrderId('A01O')

        // 敌法b
        call AllocAbilityOrderId('AEbl')

        // 闪烁(痛苦女王)
        call AllocAbilityOrderId('A0ME')

        //***************************************************************************
        //*
        //*  drain
        //*
        //***************************************************************************
        // 法力汲取
        call AllocAbilityOrderId('A02N')

        // 生命汲取(帕格纳)
        call AllocAbilityOrderId('A0CC')
        call AllocAbilityOrderId('A02Z')
        //***************************************************************************
        //*
        //*  other
        //*
        //***************************************************************************
        // 野性之斧
        call AllocAbilityOrderId('A0O1')

        //***************************************************************************
        //*
        //*  windwalk
        //*
        //***************************************************************************
        // 疾风步 - 赏金猎
        call AllocAbilityOrderId('A07A')

        // 跳跃            
        call AllocAbilityOrderId('A0LN')

        // 隐匿            
        call AllocAbilityOrderId('A0RV')

        // 仇杀            
        call AllocAbilityOrderId('A09U')

        // 骨隐步          
        call AllocAbilityOrderId('QB0A')

        // 缩地            
        call AllocAbilityOrderId('A0CA')

        // 回光返照        
        call AllocAbilityOrderIdEx('A0NS', 'A1DA')

        // 暗影之舞        
        call AllocAbilityOrderId('A1IN')
        // 幽灵漫步        
        call AllocAbilityOrderId('Z605')

        //***************************************************************************
        //*
        //*  thunderbolt
        //*
        //***************************************************************************
        // 魔法箭   
        call AllocAbilityOrderId('A02A') 

        // 闪电击   
        call AllocAbilityOrderId('A0JC') 

        // 无敌斩   
        call AllocAbilityOrderId('A0M1') 
        call AllocAbilityOrderId('A1AX') 

        // 火焰爆轰 
        call AllocAbilityOrderId('QB0J') 

        // 暗杀     
        call AllocAbilityOrderId('A04P') 

        // 投掷飞镖 
        call AllocAbilityOrderId('A004') 

        // 神龙摆尾 
        call AllocAbilityOrderId('A0AR') 

        // 法力虚空 
        call AllocAbilityOrderId('A0E3') 

        // 原始咆哮 
        call AllocAbilityOrderId('A0O2') 
        call AllocAbilityOrderId('A289')

        // 虚空     
        call AllocAbilityOrderId('A02H') 

        // 冥火爆击 
        call AllocAbilityOrderId('QB0H') 

        // 吞噬 - 投掷巨石
        call AllocAbilityOrderId('A36K') 

        // 死神镰刀 
        call AllocAbilityOrderId('A067') 
        call AllocAbilityOrderId('A08P') 

        // 剧毒之触 
        call AllocAbilityOrderId('A0NQ') 
        // 连环霜冻 
        call AllocAbilityOrderId('A05T') 
        call AllocAbilityOrderId('A08H') 

        //***************************************************************************
        //*
        //*  stomp
        //*
        //***************************************************************************
        // 马蹄践踏        
        call AllocAbilityOrderId('A00S')

        // 吞噬 - 战争践踏 
        call AllocAbilityOrderId('A1P0')

        // 火焰重踏        
        call AllocAbilityOrderId('A454')
        
        //***************************************************************************
        //*
        //*  animatedead
        //*
        //***************************************************************************
        // 烈日炙烤  - 停止
        call AllocAbilityOrderId('A1Z3')

        // 神行百变
        call AllocAbilityOrderId('A46H')

        // 吞噬
        call AllocAbilityOrderId('A10R')

        //***************************************************************************
        //*
        //*  creepheal
        //*
        //***************************************************************************
        // 召回
        call AllocAbilityOrderId(SPIRIT_FORM_RECALL_ABILITY_ID)

        // 强攻     
        call AllocAbilityOrderId('A2J2')

        // 法力燃烧 
        call AllocAbilityOrderId('A1H5')

        // 幽冥一击 
        call AllocAbilityOrderIdEx('A0G4', 'A1D8')

        // 战斗饥渴 
        call AllocAbilityOrderId('A0S1')

        // 血之祭祀 
        call AllocAbilityOrderId('A44Z')

        // 暗言术   
        call AllocAbilityOrderId('A0AS')

        // 灵魂超度 
        call AllocAbilityOrderId('A1NA')
        
        //***************************************************************************
        //*
        //*  roar
        //*
        //***************************************************************************
        // 雷神之怒      
        call AllocAbilityOrderIdEx('A29G', 'A29H')

        // 神之力量      
        call AllocAbilityOrderIdEx('A0WP', 'A43D')

        // 强化图腾      
        call AllocAbilityOrderId('A0DL')

        // 幽魂 - 散开   
        call AllocAbilityOrderId(SPIRITS_OUT_ABILITY_ID)

        // 极度饥渴      
        call AllocAbilityOrderId('A0WQ')

        // 鱼人碎击      
        call AllocAbilityOrderId('A29K')

        // 锚击          
        call AllocAbilityOrderId('A226')

        // 毁灭阴影 - Z  
        call AllocAbilityOrderId('A0EY')

        // 两级反转      
        call AllocAbilityOrderIdEx('A29L', 'A447')

        //***************************************************************************
        //*
        //*  battleroar
        //*
        //***************************************************************************
        

        //***************************************************************************
        //*
        //*  ANcl
        //*
        //***************************************************************************
        // 锯齿飞轮
        call AllocAbilityOrderId('A2E5')
        call AllocAbilityOrderId('A43Q')

        // 双飞之轮
        call AllocAbilityOrderId('A43S')

        // 锯齿飞轮 - 收回
        call AllocAbilityOrderId('A2FX')
        // 双飞之轮 - 收回
        call AllocAbilityOrderId('A43P')

        // 先祖之魂 - 收回
        call AllocAbilityOrderId('A21J')

        // 噩梦 - 结束
        call AllocAbilityOrderId('A2O9')

        // 黑暗之门 - 结束
        call AllocAbilityOrderId('A2MB')

        // 复制 - 替换
        call AllocAbilityOrderId('A0GC')
        
        // 脉冲新星
        call AllocAbilityOrderIdEx('A21F', 'A21G')
        // 关闭
        call AllocAbilityOrderId('A21H')

        // 冰晶爆轰
        call AllocAbilityOrderIdEx('A1MI', 'A2QE')

        // 涤罪之焰
        call AllocAbilityOrderId('A2SG')
        
        // 海妖之歌
        call AllocAbilityOrderIdEx('A07U', 'A38E')
        // 关闭
        call AllocAbilityOrderId('A24E')

        // 大地之灵
        call AllocAbilityOrderId('A2QM')
        call AllocAbilityOrderId('A2TJ')
        call AllocAbilityOrderId('A2QI')
        call AllocAbilityOrderId('A2TI')

        // 遥控炸弹 引爆
        // call AllocAbilityOrderId('A1WF')
    endfunction

endlibrary
