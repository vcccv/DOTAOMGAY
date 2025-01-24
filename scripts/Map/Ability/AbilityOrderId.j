library AbilityCustomOrderId

    globals
        private integer OrderIdBase = 950000
    endglobals

    function AllocAbilityOrderId takes integer abilId returns integer 
        set OrderIdBase = OrderIdBase + 1
        call MHAbility_SetHookOrder(abilId, OrderIdBase)
        return OrderIdBase
    endfunction

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
        call AllocAbilityOrderId('A01P')
        call AllocAbilityOrderId('A09Z')

        // 联结
        call AllocAbilityOrderId('A1TA')

        // 电子涡流
        call AllocAbilityOrderId('A14R')
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
        call AllocAbilityOrderId('A0E2')
        call AllocAbilityOrderId('A1MR')

        // 无光之盾
        call AllocAbilityOrderId('A0MF')

        // 麻痹药剂
        call AllocAbilityOrderId('A0NM')

        // 星体禁锢
        call AllocAbilityOrderId('A0OJ')

        // 燃烧枷锁
        call AllocAbilityOrderId('A19O')
        call AllocAbilityOrderId('A1MV')

        // 灵魂隔断
        call AllocAbilityOrderId('A07Q')

        // 闪电风暴
        call AllocAbilityOrderId('A06V')

        // 崩裂禁锢
        call AllocAbilityOrderId('A1S8')

        // 死亡一指
        call AllocAbilityOrderId('A095')
        call AllocAbilityOrderId('A09W')

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
        call AllocAbilityOrderId('A0DH')
        call AllocAbilityOrderId('A1OB')

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
        call AllocAbilityOrderId('A2O6')
        call AllocAbilityOrderId('A384')

        // 不稳定化合物
        call AllocAbilityOrderId('A1NI')

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
        call AllocAbilityOrderId('A02S')
        call AllocAbilityOrderId('A3Y8')
        
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
        call AllocAbilityOrderId('A28R')
        call AllocAbilityOrderId('A28S')

        // 烈火焚身
        call AllocAbilityOrderId('A0O5')

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
        call AllocAbilityOrderId('A2TH')
    endfunction

endlibrary
