library AbilityCustomOrderId

    globals
        private integer OrderIdBase = 950000
    endglobals

    function AllocAbilityOrderId takes integer abilId returns integer 
        set OrderIdBase = OrderIdBase + 1
        call MHAbility_SetHookOrder(abilId, OrderIdBase)
        return OrderIdBase
    endfunction

    function GetAbiltiyOrder takes integer abilId returns string
        local integer id = MHAbility_GetHookOrder(abilId)
        if id == 0 then
            return ""
        endif
        return I2S(id)
    endfunction

    function GetAbiltiyOrderId takes integer abilId returns integer
        return MHAbility_GetHookOrder(abilId)
    endfunction

    function InitAbilityCustomOrderId takes nothing returns nothing
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

    endfunction

endlibrary
