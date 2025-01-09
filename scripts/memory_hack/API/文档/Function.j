// by Asphodelus, vcccv
// 该文件仅做文档，不会被编译到地图脚本里






//==================================================================================
//
// [单位技能] ability.j 
//
//==================================================================================



// 基本库



    // 获取物编数据 (整数)
    // @param flag：ABILITY_DEF_DATA
    function MHAbility_GetDefDataInt takes integer aid, integer flag returns integer
    endfunction

    // 设置物编数据 (整数)
    // @param flag：ABILITY_DEF_DATA
    function MHAbility_SetDefDataInt takes integer aid, integer flag, integer value returns nothing
    endfunction

    // 获取物编数据 (实数)
    // @param flag：ABILITY_DEF_DATA
    function MHAbility_GetDefDataReal takes integer aid, integer flag returns real
    endfunction

    // 设置物编数据 (实数)
    // @param flag：ABILITY_DEF_DATA
    function MHAbility_SetDefDataReal takes integer aid, integer flag, real value returns nothing
    endfunction

    // 获取物编数据 (布尔值)
    // @param flag：ABILITY_DEF_DATA
    function MHAbility_GetDefDataBool takes integer aid, integer flag returns boolean
    endfunction

    // 设置物编数据 (布尔值)
    // @param flag：ABILITY_DEF_DATA
    function MHAbility_SetDefDataBool takes integer aid, integer flag, boolean value returns nothing
    endfunction

    // 获取物编数据 (字符串)
    // @param flag：ABILITY_DEF_DATA
    function MHAbility_GetDefDataStr takes integer aid, integer flag returns string
    endfunction

    // 设置物编数据 (字符串)
    // @param flag：ABILITY_DEF_DATA
    function MHAbility_SetDefDataStr takes integer aid, integer flag, string value returns nothing
    endfunction

    // 获取物编等级数据 (整数)
    // @param flag：ABILITY_LEVEL_DEF_DATA
    function MHAbility_GetLevelDefDataInt takes integer aid, integer level, integer flag returns integer
    endfunction

    // 设置物编等级数据 (整数)
    // @param flag：ABILITY_LEVEL_DEF_DATA
    function MHAbility_SetLevelDefDataInt takes integer aid, integer level, integer flag, integer value returns nothing
    endfunction

    // 获取物编等级数据 (实数)
    // @param flag：ABILITY_LEVEL_DEF_DATA
    function MHAbility_GetLevelDefDataReal takes integer aid, integer level, integer flag returns real
    endfunction

    // 设置物编等级数据 (实数)
    // @param flag：ABILITY_LEVEL_DEF_DATA
    function MHAbility_SetLevelDefDataReal takes integer aid, integer level, integer flag, real value returns nothing
    endfunction

    // 获取物编等级数据 (字符串)
    // @param flag：ABILITY_LEVEL_DEF_DATA
    function MHAbility_GetLevelDefDataStr takes integer aid, integer level, integer flag returns string
    endfunction

    // 设置物编等级数据 (字符串)
    // @param flag：ABILITY_LEVEL_DEF_DATA
    function MHAbility_SetLevelDefDataStr takes integer aid, integer level, integer flag, string value returns nothing
    endfunction

    // 遍历所有技能
    // @Tip：返回值为单位拥有的技能数量，包括魔法效果
    function MHAbility_GetAll takes unit u, hashtable ht returns integer
    endfunction

    // 遍历英雄技能
    // @Tip：返回值为单位拥有的英雄技能数量
    function MHAbility_GetHeroAll takes unit u, hashtable ht returns integer
    endfunction

    // 获取单位技能的基础ID
    // @Tip：主要用于用于检查继承
    function MHAbility_GetBaseId takes unit u, integer aid returns integer
    endfunction

    // 释放技能
    // @Tip：跳过魔耗、冷却和目标允许等判定强制释放。并且不会消耗魔法和进入冷却，不会触发相关事件。内部会判定技能释放类型
    function MHAbility_Cast takes unit source, widget target, real target_x, real target_y, integer aid returns boolean
    endfunction

    // 释放技能
    // @Tip：跳过魔耗、冷却和目标允许等判定强制释放。并且不会消耗魔法和进入冷却，会触发发动技能效果事件。内部会判定技能释放类型
    function MHAbility_CastEx takes unit source, widget target, real target_x, real target_y, integer aid returns boolean
    endfunction

    // 获取技能命令
    // @param order_flag：命令类型。ABILITY_ORDER_FLAG
    function MHAbility_GetOrder takes unit u, integer aid, integer order_flag returns integer
    endfunction

    // 获取技能的释放命令
    function MHAbility_GetOrderCast takes unit u, integer aid returns integer
    endfunction

    // 获取技能的开启命令
    function MHAbility_GetOrderOn takes unit u, integer aid returns integer
    endfunction

    // 获取技能的关闭命令
    function MHAbility_GetOrderOff takes unit u, integer aid returns integer
    endfunction

    // 获取技能的释放类型
    function MHAbility_GetCastType takes unit u, integer aid returns integer
    endfunction

    // 获取技能目标允许
    // @Tip：技能当前的目标允许
    function MHAbility_GetTargetAllow takes unit u, integer aid returns integer
    endfunction

    // 设置技能目标允许
    // @param target_allow：技能当前的目标允许
    function MHAbility_SetTargetAllow takes unit u, integer aid, integer target_allow returns nothing
    endfunction

    // 获取技能标志
    // @Tip：ABILITY_FLAG
    function MHAbility_GetFlag takes unit u, integer aid returns integer
    endfunction

    // 设置技能标志
    // @param flag：ABILITY_FLAG
    function MHAbility_SetFlag takes unit u, integer aid, integer flag returns nothing
    endfunction

    // 判定技能标志
    // @param flag：ABILITY_FLAG
    function MHAbility_IsFlag takes unit u, integer aid, integer flag returns boolean
    endfunction

    // 操作技能标志
    // @param op：FLAG_OPERATOR
    // @param flag：ABILITY_FLAG
    function MHAbility_FlagOperator takes unit u, integer aid, integer op, integer flag returns nothing
    endfunction

    // 是被动技能
    function MHAbility_IsPassive takes unit u, integer aid returns boolean
    endfunction

    // 在冷却中
    function MHAbility_IsOnCooldown takes unit u, integer aid returns boolean
    endfunction

    // 获取冷却
    function MHAbility_GetCooldown takes unit u, integer aid returns real
    endfunction

    // 设置冷却
    // @Tip：需要技能本身拥有冷却时间。对绝大多数被动技能和少数主动技能无法起效
    // 被动技能中挖掘尸体和重生可以设置冷却时间
    function MHAbility_SetCooldown takes unit u, integer aid, real dur returns nothing
    endfunction

    // 获取剩余持续时间
    function MHAbility_GetSpellRemain takes unit u, integer aid returns real
    endfunction

    // 设置剩余持续时间
    function MHAbility_SetSpellRemain takes unit u, integer aid, real dur returns nothing
    endfunction

    // 获取技能当前目标单位
    function MHAbility_GetTargetUnit takes unit u, integer aid returns unit
    endfunction

    // 获取技能当前目标物品
    function MHAbility_GetTargetItem takes unit u, integer aid returns item
    endfunction

    // 获取技能当前目标可破坏物
    function MHAbility_GetTargetDest takes unit u, integer aid returns destructable
    endfunction

    // 设置技能当前目标
    // @Tip：可在 发动技能效果 事件中修改技能目标
    function MHAbility_SetTarget takes unit u, integer aid, widget target returns nothing
    endfunction

    // 获取技能当前目标点X
    function MHAbility_GetTargetX takes unit u, integer aid returns real
    endfunction

    // 设置技能当前目标点X
    // @Tip：可在 发动技能效果 事件中修改技能目标点X
    function MHAbility_SetTargetX takes unit u, integer aid, real x returns nothing
    endfunction

    // 获取技能当前目标点Y
    function MHAbility_GetTargetY takes unit u, integer aid returns real
    endfunction

    // 设置技能当前目标点Y
    // @Tip：可在 发动技能效果 事件中修改技能目标点Y
    function MHAbility_SetTargetY takes unit u, integer aid, real x returns nothing
    endfunction
    
    // 隐藏
    // @Tip：计数器。类似于设置按钮坐标 (0, -11)
    // param is_hide：true - 隐藏; false - 显示
    function MHAbility_Hide takes unit u, integer aid, boolean is_hide returns nothing
    endfunction

    // 获取隐藏计数器
    function MHAbility_GetHideCount takes unit u, integer aid returns integer
    endfunction

    // 禁用
    // @Tip：计数器。
    // 禁用实际效果，不显示冷却，对大部分光环无效。正在施法中的技能会因为此禁用而中断。
    // @param is_disable：true - 禁用; false - 启用
    // @param is_hide：true - 隐藏UI; false - 显示UI
    function MHAbility_Disable takes unit u, integer aid, boolean is_disable, boolean is_hide returns nothing
    endfunction

    // 获取禁用计数器
    function MHAbility_GetDisableCount takes unit u, integer aid returns integer
    endfunction

    // 禁用Ex
    // @Tip：计数器。相当于闪电之球的关联技能
    // 不禁用实际效果，不能点击，仍然能显示冷却。禁用时不会中断正在施法的技能。
    // param is_disable：true - 禁用; false - 启用
    function MHAbility_DisableEx takes unit u, integer aid, boolean is_disable returns nothing
    endfunction

    // 获取禁用Ex计数器
    function MHAbility_GetDisableExCount takes unit u, integer aid returns integer
    endfunction

    // 判定极性
    // @param polarity：ABILITY_POLARITY
    function MHAbility_IsPolarity takes unit u, integer aid, integer polarity returns boolean
    endfunction

	// 获取前摇
    // @Tip：如果没有设置过前摇，则返回0而不是单位的物编前摇数据
    function MHAbility_GetCastpoint takes unit u, integer aid returns real
    endfunction

	// 设置前摇
    // @Tip：完全代替单位物编的前摇
    function MHAbility_SetCastpoint takes unit u, integer aid, real value returns nothing
    endfunction

	// 获取后摇
    // @Tip：如果没有设置过后摇，则返回0而不是单位的物编后摇数据
    function MHAbility_GetBackswing takes unit u, integer aid returns real
    endfunction

	// 设置后摇
    // @Tip：完全代替单位物编的后摇
    function MHAbility_SetBackswing takes unit u, integer aid, real value returns nothing
    endfunction

    // 获取来源物品
    // @Tip：获取添加该技能的物品
    function MHAbility_GetSourceItem takes unit u, integer aid returns item
    endfunction

    // 获取来源物品
    // @Tip：获取添加该技能的物品
    function MHAbility_GetAbilitySourceItem takes ability abil returns item
    endfunction



// Hook库



    // 设置命令ID
    // @Tip：命令ID可自定义。设置后可以让同模板技能互不冲突
    // 需要在技能实例进入地图之前设置。若地图上已存在实例，可先删除再添加，否则技能按钮不会显示
    function MHAbility_SetHookOrder takes integer aid, integer oid returns nothing
    endfunction

    // 获取已设置的命令ID
    // @Tip：指代 MHAbilityOrder_SetOrder 设置的命令ID
    function MHAbility_GetHookOrder takes integer aid returns integer
    endfunction

    // 恢复命令ID
    // @Tip：指代 MHAbilityOrder_SetOrder 设置的命令ID
    function MHAbility_RestoreHookOrder takes integer aid returns nothing
    endfunction

    // 设置下标数值
    // @Tip：对正常主动技能和被动技能有效
    // 设置光环技能的下标会导致游戏崩溃
    function MHAbility_SetChargeCount takes unit u, integer aid, integer value returns nothing
    endfunction

    // 获取下标数值
    // @Tip：指代 MHAbility_SetChargeCount 设置的下标数值
    function MHAbility_GetChargeCount takes unit u, integer aid returns integer
    endfunction

    // 设置下标文本
    // @Tip：对正常主动技能和被动技能有效
    // 设置光环技能的下标会导致游戏崩溃。优先级比下标数值更高
    function MHAbility_SetChargeText takes unit u, integer aid, string text returns nothing
    endfunction

    // 获取下标文本
    // @Tip：指代 MHAbility_SetChargeText 设置的下标文本
    function MHAbility_GetChargeText takes unit u, integer aid returns string
    endfunction

    // 设置下标状态
    // @Tip：指代 MHAbility_SetChargeCount/MHAbility_SetChargeText 设置的下标。可控制下标显示或隐藏
    // 设置光环技能的下标会导致游戏崩溃
    // @param flag：true =  = 隐藏
    function MHAbility_SetChargeState takes unit u, integer aid, boolean flag returns nothing
    endfunction

    // 获取下标状态
    // @Tip：指代 MHAbility_SetChargeState/MHAbility_SetChargeText 设置的下标状态
    function MHAbility_GetChargeState takes unit u, integer aid returns boolean
    endfunction

    // 设置释放类型 (实例)
    // @param cast_type：Bitset。ABILITY_CAST_TYPE
    function MHAbility_SetCastType takes unit u, integer aid, integer cast_type returns boolean
    endfunction

    // 恢复释放类型 (实例)
    function MHAbility_RestoreCastType takes unit u, integer aid returns boolean
    endfunction

    // 设置释放类型 (ID)
    // @param cast_type： Bitset。ABILITY_CAST_TYPE
    function MHAbility_SetCastTypeEx takes integer aid, integer cast_type returns boolean
    endfunction

    // 恢复释放类型 (ID)
    function MHAbility_RestoreCastTypeEx takes integer aid returns boolean
    endfunction

    // 隐藏Ex
    // @Tip：该函数隐藏的技能可被发布本地命令和按下指示器
    function MHAbility_HideEx takes unit u, integer aid, boolean is_hide returns nothing
    endfunction

    // 被隐藏Ex
    function MHAbility_IsHideEx takes unit u, integer aid returns boolean
    endfunction



// System库



    // 获取文本Frame
    // @Tip：指代冷却绘制系统中创建的CSimpleFontString。不可删除
    // @param index：1~12 = 技能栏文本; 13~18 = 按钮栏文本
    function MHDrawCooldown_GetText takes integer index returns integer
    endfunction

    // 设置小数显示间隔
    // @Tip：指技能冷却到多少以下时，文本会显示小数。默认为10
    function MHDrawCooldown_SetDivide takes real divide returns nothing
    endfunction

    // 技能绘制系统初始化
    // @Tip：仅需运行一次
    function MHDrawCooldown_Initialize takes nothing returns nothing
    endfunction

    // 获取自定义物编数据 (整数)
    // @Tip：该函数获取的是实例数据，不同单位的同一个技能的数据允许不同
    // @param flag：ABILITY_DEF_DATA
    function MHAbility_GetCustomDataInt takes unit u, integer aid, integer flag returns integer
    endfunction

    // 获取自定义物编数据 (实数)
    // @Tip：该函数获取的是实例数据，不同单位的同一个技能的数据允许不同
    // @param flag：ABILITY_DEF_DATA
    function MHAbility_GetCustomDataReal takes unit u, integer aid, integer flag returns real
    endfunction

    // 获取自定义物编数据 (布尔值)
    // @Tip：该函数获取的是实例数据，不同单位的同一个技能的数据允许不同
    // @param flag：ABILITY_DEF_DATA
    function MHAbility_GetCustomDataBool takes unit u, integer aid, integer flag returns boolean
    endfunction

    // 获取自定义物编数据 (字符串)
    // @Tip：该函数获取的是实例数据，不同单位的同一个技能的数据允许不同
    // @param flag：ABILITY_DEF_DATA
    function MHAbility_GetCustomDataStr takes unit u, integer aid, integer flag returns string
    endfunction

    // 设置自定义物编数据 (整数)
    // @Tip：该函数修改的是实例数据，不同单位的同一个技能的数据允许不同
    // @param flag：ABILITY_DEF_DATA
    function MHAbility_SetCustomDataInt takes unit u, integer aid, integer flag, integer value returns nothing
    endfunction

    // 设置自定义物编数据 (实数)
    // @Tip：该函数修改的是实例数据，不同单位的同一个技能的数据允许不同
    // @param flag：ABILITY_DEF_DATA
    function MHAbility_SetCustomDataReal takes unit u, integer aid, integer flag, real value returns nothing
    endfunction

    // 设置自定义物编数据 (布尔值)
    // @Tip：该函数修改的是实例数据，不同单位的同一个技能的数据允许不同
    // @param flag：ABILITY_DEF_DATA
    function MHAbility_SetCustomDataBool takes unit u, integer aid, integer flag, boolean value returns nothing
    endfunction

    // 设置自定义物编数据 (字符串)
    // @Tip：该函数修改的是实例数据，不同单位的同一个技能的数据允许不同
    // @param flag：ABILITY_DEF_DATA
    function MHAbility_SetCustomDataStr takes unit u, integer aid, integer flag, string value returns nothing
    endfunction

    // 获取自定义物编等级数据 (整数)
    // @Tip：该函数获取的是实例数据，不同单位的同一个技能的数据允许不同
    // @param flag：ABILITY_LEVEL_DEF_DATA
    function MHAbility_GetCustomLevelDataInt takes unit u, integer aid, integer level, integer flag returns integer
    endfunction

    // 获取自定义物编等级数据 (实数)
    // @Tip：该函数获取的是实例数据，不同单位的同一个技能的数据允许不同
    // @param flag：ABILITY_LEVEL_DEF_DATA
    function MHAbility_GetCustomLevelDataReal takes unit u, integer aid, integer level, integer flag returns real
    endfunction

    // 获取自定义物编等级数据 (字符串)
    // @Tip：该函数获取的是实例数据，不同单位的同一个技能的数据允许不同
    // @param flag：ABILITY_LEVEL_DEF_DATA
    function MHAbility_GetCustomLevelDataStr takes unit u, integer aid, integer level, integer flag returns string
    endfunction

    // 设置自定义物编等级数据 (整数)
    // @Tip：该函数修改的是实例数据，不同单位的同一个技能的数据允许不同
    // @param flag：ABILITY_LEVEL_DEF_DATA
    function MHAbility_SetCustomLevelDataInt takes unit u, integer aid, integer level, integer flag, integer value returns nothing
    endfunction

    // 设置自定义物编等级数据 (实数)
    // @Tip：该函数修改的是实例数据，不同单位的同一个技能的数据允许不同
    // @param flag：ABILITY_LEVEL_DEF_DATA
    function MHAbility_SetCustomLevelDataReal takes unit u, integer aid, integer level, integer flag, real value returns nothing
    endfunction

    // 设置自定义物编等级数据 (字符串)
    // @Tip：该函数修改的是实例数据，不同单位的同一个技能的数据允许不同
    // @param flag：ABILITY_LEVEL_DEF_DATA
    function MHAbility_SetCustomLevelDataStr takes unit u, integer aid, integer level, integer flag, string value returns nothing
    endfunction

    // 重置自定义物编数据
    // @Tip：该函数重置的是技能实例的物编数据，每个单位允许不同。仅支持非ui类型的数据
    function MHAbility_ResetCustomData takes unit u, integer aid returns nothing
    endfunction



// 事件库



    // 注册任意技能被添加事件
    // @Tip：EVENT_ID_ABILITY_ADD
    // 包括添加魔法效果
    function MHAbilityAddEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取添加技能的单位
    // @Tip：响应 任意单位添加技能 事件
    // 等价于 MHEvent_GetUnit
    function MHAbilityAddEvent_GetUnit takes nothing returns unit
    endfunction

    // 获取被添加的技能
    // @Tip：响应 任意单位添加技能 事件
    // 等价于 MHEvent_GetAbility
    function MHAbilityAddEvent_GetAbility takes nothing returns integer
    endfunction

    // 注册任意技能被删除事件
    // @Tip：EVENT_ID_ABILITY_REMOVE
    // 包括删除魔法效果
    function MHAbilityRemoveEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取删除技能的单位
    // @Tip：响应 任意单位删除技能 事件
    // 等价于 MHEvent_GetUnit
    function MHAbilityRemoveEvent_GetUnit takes nothing returns unit
    endfunction

    // 获取被删除的技能
    // @Tip：响应 任意单位删除技能 事件
    // 等价于 MHEvent_GetAbility
    function MHAbilityRemoveEvent_GetAbility takes nothing returns unit
    endfunction

    // 注册任意技能进入冷却事件
    // @Tip：EVENT_ID_ABILITY_START_COOLDOWN
    function MHAbilityStartCooldownEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取触发技能冷却的单位
    // @Tip：响应 任意单位技能进入冷却 事件
    // 等价于 MHEvent_GetUnit
    function MHAbilityStartCooldownEvent_GetUnit takes nothing returns unit
    endfunction

    // 获取触发技能冷却的技能
    // @Tip：响应 任意单位技能进入冷却 事件
    // 等价于 MHEvent_GetAbility
    function MHAbilityStartCooldownEvent_GetAbility takes nothing returns unit
    endfunction

    // 注册任意技能结束冷却事件
    // @Tip：EVENT_ID_ABILITY_END_COOLDOWN
    function MHAbilityEndCooldownEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取结束技能冷却的单位
    // @Tip：响应 任意单位技能结束冷却 事件
    // 等价于 MHEvent_GetUnit
    function MHAbilityEndCooldownEvent_GetUnit takes nothing returns unit
    endfunction

    // 获取结束技能冷却的技能
    // @Tip：响应 任意单位技能结束冷却 事件
    // 等价于 MHEvent_GetAbility
    function MHAbilityEndCooldownEvent_GetAbility takes nothing returns unit
    endfunction

    // 注册任意光环技能刷新事件
    function MHAbilityRefreshAuraEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取光环刷新的来源
    // @Tip：响应 任意光环技能刷新 事件
    // 等价于 MHEvent_GetUnit
    function MHAbilityRefreshAuraEvent_GetSource takes nothing returns unit
    endfunction

    // 获取刷新的光环技能
    // @Tip：响应 任意光环技能刷新 事件
    // 等价于 MHEvent_GetAbility
    function MHAbilityRefreshAuraEvent_GetAbility takes nothing returns integer
    endfunction

    // 获取光环刷新的目标
    // @Tip：响应 任意光环技能刷新 事件
    function MHAbilityRefreshAuraEvent_GetTarget takes nothing returns unit
    endfunction

    // 获取刷新的光环Buff
    // @Tip：响应 任意光环技能刷新 事件
    function MHAbilityRefreshAuraEvent_GetBuff takes nothing returns integer
    endfunction







//==================================================================================
//
// [单位] unit.j 
//
//==================================================================================



// 基本库



    // 选取屏幕内的单位做动作
    // @Tip：异步动作
    function MHUnit_EnumInScreen takes string callback returns nothing
    endfunction

    // 选取屏幕内的单位做动作
    // @Tip：异步动作
    function MHUnit_EnumInScreenEx takes code callback returns nothing
    endfunction

    // 创建建筑
    // @param auto_build：创建出的建筑自动建造
    // @param can_assist：创建出的建筑能被多敲
    function MHUnit_CreateBuilding takes player p, integer uid, real x, real y, boolean auto_build, boolean can_assist returns unit
    endfunction

    // 添加技能
    // @Tip：cj的 UnitAddAbility 会检查相同技能
    // @param check_duplicate：检查相同技能
    function MHUnit_AddAbility takes unit u, integer aid, boolean check_duplicate returns boolean
    endfunction

    // 删除技能
    // @Tip：cj的 UnitRemoveAbility 不会检查相同技能
    // @param check_duplicate：检查相同技能
    function MHUnit_RemoveAbility takes unit u, integer aid, boolean check_duplicate returns boolean
    endfunction

    // 获取技能
    // @param search_base：按照基础ID来查找第一个技能
    function MHUnit_GetAbility takes unit u, integer aid, boolean search_base returns ability
    endfunction

    // 获取技能数量
    // @Tip：包括魔法效果
    function MHUnit_GetAbilityCount takes unit u returns integer
    endfunction

    // 获取指定序号的技能
    // @Tip：包括魔法效果
    function MHUnit_GetAbilityByIndex takes unit u, integer index returns integer
    endfunction

    // 获取单位数据
    // @param flag：UNIT_DATA
    function MHUnit_GetData takes unit u, integer flag returns real
    endfunction

    // 设置单位数据
    // @param flag：UNIT_DATA
    function MHUnit_SetData takes unit u, integer flag, real value returns nothing
    endfunction

    // 获取单位攻击数据 (整数)
    // @param flag：UNIT_ATK_DATA
    function MHUnit_GetAtkDataInt takes unit u, integer flag returns integer
    endfunction

    // 获取单位攻击数据 (实数)
    // @param flag：UNIT_ATK_DATA
    function MHUnit_GetAtkDataReal takes unit u, integer flag returns real
    endfunction

    // 设置单位攻击数据 (整数)
    // @param flag：UNIT_ATK_DATA
    function MHUnit_SetAtkDataInt takes unit u, integer flag, integer value returns nothing
    endfunction

    // 设置单位攻击数据 (实数)
    // @param flag：UNIT_ATK_DATA
    function MHUnit_SetAtkDataReal takes unit u, integer flag, real value returns nothing
    endfunction

    // 获取单位物编数据 (整数)
    // @param flag：UNIT_DEF_DATA
    function MHUnit_GetDefDataInt takes integer uid, integer flag returns integer
    endfunction

    // 获取单位物编数据 (实数)
    // @param flag：UNIT_DEF_DATA
    function MHUnit_GetDefDataReal takes integer uid, integer flag returns real
    endfunction

    // 获取单位物编数据 (布尔值)
    // @param flag：UNIT_DEF_DATA
    function MHUnit_GetDefDataBool takes integer uid, integer flag returns boolean
    endfunction

    // 获取单位物编数据 (字符串)
    // @param flag：UNIT_DEF_DATA
    function MHUnit_GetDefDataStr takes integer uid, integer flag returns string
    endfunction

    // 设置单位物编数据 (整数)
    // @param flag：UNIT_DEF_DATA
    function MHUnit_SetDefDataInt takes integer uid, integer flag, integer value returns nothing
    endfunction

    // 设置单位物编数据 (实数)
    // @param flag：UNIT_DEF_DATA
    function MHUnit_SetDefDataReal takes integer uid, integer flag, real value returns nothing
    endfunction

    // 设置单位物编数据 (布尔值)
    // @param flag：UNIT_DEF_DATA
    function MHUnit_SetDefDataBool takes integer uid, integer flag, boolean value returns nothing
    endfunction

    // 设置单位物编数据 (字符串)
    // @param flag：UNIT_DEF_DATA
    function MHUnit_SetDefDataStr takes integer uid, integer flag, string value returns nothing
    endfunction

    // 获取单位物编等级数据 (整数)
    // @param flag：UNIT_LEVEL_DEF_DATA
    // @param level：并非等级而是序号
    function MHUnit_GetLevelDefDataInt takes integer uid, integer flag, integer level returns integer
    endfunction

    // 设置单位物编等级数据 (整数)
    // @param flag：UNIT_LEVEL_DEF_DATA
    // @param level：并非等级而是序号
    function MHUnit_GetLevelDefDataStr takes integer uid, integer flag, integer level returns string
    endfunction

    // 获取单位物编等级数据 (字符串)
    // @param flag：UNIT_LEVEL_DEF_DATA
    // @param level：并非等级而是序号
    function MHUnit_SetLevelDefDataInt takes integer uid, integer flag, integer level, integer value returns nothing
    endfunction

    // 设置单位物编等级数据 (字符串)
    // @param flag：UNIT_LEVEL_DEF_DATA
    // @param level：并非等级而是序号
    function MHUnit_SetLevelDefDataStr takes integer uid, integer flag, integer level, string value returns nothing
    endfunction

    // 获取当前攻击目标单位
    function MHUnit_GetAttackTargetUnit takes unit u returns unit
    endfunction

    // 获取当前攻击目标物品
    function MHUnit_GetAttackTargetItem takes unit u returns item
    endfunction

    // 获取当前攻击目标可破坏物
    function MHUnit_GetAttackTargetDest takes unit u returns destructable
    endfunction

    // 获取当前攻击目标点X
    function MHUnit_GetAttackTargetX takes unit u returns real
    endfunction

    // 获取当前攻击目标点Y
    function MHUnit_GetAttackTargetY takes unit u returns real
    endfunction

    // 获取当前攻击计时器剩余时间
    // @Tip：到下一次攻击开始还需多长时间
    // 移动、右键移动会启动一个0.5s的该计时器
    function MHUnit_GetAttackTimerRemain takes unit u returns real
    endfunction

    // 设置当前攻击计时器剩余时间
    // @Tip：到下一次攻击开始还需多长时间
    // 移动、右键移动会启动一个0.5s的该计时器
    function MHUnit_SetAttackTimerRemain takes unit u, real value returns nothing
    endfunction

    // 获取当前前摇计时器剩余时间
    // @Tip：攻击前摇
    function MHUnit_GetAttackPointTimerRemain takes unit u returns real
    endfunction

    // 设置当前前摇计时器剩余时间
    // @Tip：攻击前摇
    function MHUnit_SetAttackPointTimerRemain takes unit u, real value returns nothing
    endfunction

    // 获取当前后摇计时器剩余时间
    // @Tip：攻击后摇
    function MHUnit_GetBackswingTimerRemain takes unit u returns real
    endfunction

    // 设置当前后摇计时器剩余时间
    // @Tip：攻击后摇
    function MHUnit_SetBackswingTimerRemain takes unit u, real value returns nothing
    endfunction

    // 添加生命周期
    // @Tip：此处可自定义魔法效果id
    function MHUnit_ApplyTimedLife takes unit u, integer bid, real dur returns boolean
    endfunction

    // 取消生命周期
    function MHUnit_CancelTimedLife takes unit u returns nothing
    endfunction

    // 获取生命周期剩余时间
    function MHUnit_GetTimedLifeRemain takes unit u returns real
    endfunction

    // 设置生命周期剩余时间
    function MHUnit_SetTimedLifeRemain takes unit u, real value returns nothing
    endfunction

    // 单位是无敌的
    // @Tip：相当于单位的标志1包含无敌
    function MHUnit_IsInvulnerable takes unit u returns boolean
    endfunction

    // 获取单位的作为目标
    // @Tip：返回的是单位的真实作为目标类型。Bitset
    function MHUnit_GetAsTarget takes unit u returns integer
    endfunction

    // 获取单位的作为目标类型
    // @Tip：返回的是物编中 战斗 - 作为目标类型
    function MHUnit_GetAsTargetType takes unit u returns integer
    endfunction

    // 设置单位的作为目标类型
    // @Tip：设置的是物编中 战斗 - 作为目标类型
    function MHUnit_SetAsTargetType takes unit u, integer as_target_type returns nothing
    endfunction

    // 判定目标允许
    // @Tip：u 能否对 target 进行目标允许为 target_allow 的行为
    function MHUnit_CheckTargetAllow takes unit u, widget target integer target_allow returns boolean
    endfunction
    
    // 获取单位标志1
    function MHUnit_GetFlag1 takes unit u returns integer
    endfunction

    // 设置单位标志1
    // @param flag：UNIT_FLAG1
    function MHUnit_SetFlag1 takes unit u, integer flag returns nothing
    endfunction

    // 判定单位标志1
    // @param flag：UNIT_FLAG1
    function MHUnit_IsFlag1 takes unit u, integer flag returns boolean
    endfunction

    // 操作单位标志1
    // @param flag：UNIT_FLAG1
    function MHUnit_Flag1Operator takes unit u, integer op, integer flag returns nothing
    endfunction

    // 获取单位标志2
    function MHUnit_GetFlag2 takes unit u returns integer
    endfunction

    // 设置单位标志2
    // @param flag：UNIT_FLAG2
    function MHUnit_SetFlag2 takes unit u, integer flag returns nothing
    endfunction

    // 判定单位标志2
    // @param flag：UNIT_FLAG2
    function MHUnit_IsFlag2 takes unit u, integer flag returns boolean
    endfunction

    // 操作单位标志2
    // @param flag：UNIT_FLAG2
    function MHUnit_Flag2Operator takes unit u, integer op, integer flag returns nothing
    endfunction

    // 获取标志3
    // @Tip：Flag_0x60
    function MHUnit_GetFlag3 takes unit u returns integer
    endfunction

    // 设置标志3
    // @Tip：Flag_0x60
    function MHUnit_SetFlag3 takes unit u, integer value returns nothing
    endfunction

    // 获取单位种类
    function MHUnit_GetFlagType takes unit u returns integer
    endfunction

    // 设置单位种类
    // @param flag：UNIT_FLAG_TYPE
    function MHUnit_SetFlagType takes unit u, integer value returns nothing
    endfunction

    // 判定单位种类
    // @param flag：UNIT_FLAG_TYPE
    function MHUnit_IsFlagType takes unit u, integer flag returns boolean
    endfunction

    // 操作单位种类
    // @param flag：UNIT_FLAG_TYPE
    function MHUnit_FlagTypeOperator takes unit u, integer op, integer flag returns nothing
    endfunction

    // 杀死单位
    // @param killer：凶手单位
    function MHUnit_Kill takes unit victim, unit killer returns boolean
    endfunction

    // 复活单位
    // @Tip：如果要复活英雄，使用原版的复活英雄函数。
    function MHUnit_Revive takes unit u, real x, real y returns boolean
    endfunction

    // 获取凶手单位
    // @Tip：没有事件的限制，在任何时候都可以对死亡单位使用
    function MHUnit_GetKiller takes unit victim returns unit
    endfunction
    
    // 眩晕单位
    // @Tip：计数器。如果是第一次眩晕，则会添加眩晕flag, 然后对单位发布眩晕命令
    // @param is_stun：true - 眩晕; false - 解除眩晕
    function MHUnit_Stun takes unit u, boolean is_stun returns nothing
    endfunction

    // 获取眩晕计数
    function MHUnit_GetStunCount takes unit u returns integer
    endfunction

    // 设置虚无
    // @Tip：计数器
    // 可以在启用虚无前先启用'Aatk'(攻击)技能，则不会禁用攻击。如果先启用了攻击，则禁用虚无后也要禁用攻击技能来恢复计数。
    // @param is_add：true - 添加虚无; false - 移除虚无
    function MHUnit_SetEthereal takes unit u, boolean is_add returns nothing
    endfunction

    // 获取虚无计数器
    function MHUnit_GetEtherealCount takes unit u returns integer
    endfunction

    // 设置隐形
    // @Tip：计数器
    // @param is_add：true - 进入隐形; false - 退出隐形
    // @param gradient_time：渐变时间
    function MHUnit_SetInvisible takes unit u, boolean is_add, real gradient_time returns nothing
    endfunction

    // 获取隐形计数器
    function MHUnit_GetInvisionCount takes unit u returns integer
    endfunction

    // 禁用自动攻击
    // @Tip：计数器。疾风步等隐形技能同款
    // @param is_disable：true - 禁用; false - 允许
    function MHUnit_DisableAutoAttack takes unit u, boolean is_disable returns nothing
    endfunction

    // 获取禁用自动攻击计数器
    function MHUnit_GetDisableAutoAttackCount takes unit u returns integer
    endfunction

    // 获取单位状态
    function MHUnit_GetState takes unit u returns integer
    endfunction

    // 判定单位状态
    // @param state：UNIT_CUR_STATE
    function MHUnit_IsState takes unit u, integer state returns boolean
        UNIT_STATE
    endfunction

    // 禁止移动
    // @Tip：计数器。相当于狼骑网
    function MHUnit_DisableMove takes unit u, boolean is_disable returns nothing
    endfunction

    // 获取移动类型
    function MHUnit_GetMoveType takes unit u returns integer
    endfunction

    // 设置移动类型
    // @param move_type：UNIT_MOVE_TYPE
    function MHUnit_SetMoveType takes unit u, integer move_type returns nothing
    endfunction

    // 设置寻路类型
    // @param path_type：UNIT_PATH_TYPE
    function MHUnit_SetPathType takes unit u, integer path_type returns nothing
    endfunction

    // 设置碰撞类型
    // @param to_other：UNIT_COLLISION_TYPE。自己碰撞别人时
    // @param from_other：UNIT_COLLISION_TYPE。别人碰撞自己时
    function MHUnit_SetCollisionType takes unit u, integer to_other, integer from_other returns nothing
    endfunction

    // 判定可通行性
    // @Tip：判定坐标(x, y)是否允许单位u通行
    function MHUnit_CheckPosition takes unit u, real x, real y returns boolean
    endfunction

    // 修正单位坐标X
    // @Tip：若单位要移动到坐标(x, y)，获取通行性判定修正后的x坐标
    function MHUnit_ModifyPositionX takes unit u, real x, real y returns real
    endfunction

    // 修正单位坐标Y
    // @Tip：若单位要移动到坐标(x, y)，获取通行性判定修正后的y坐标
    function MHUnit_ModifyPositionY takes unit u, real x, real y returns real
    endfunction

    // 创建幻象
    // @param player：幻象所属玩家
    function MHUnit_CreateIllusion takes player p, unit u, real x, real y returns unit
    endfunction

    // 获取幻象造成伤害
    function MHUnit_GetIllusionDamageDeal takes unit u returns real
    endfunction

    // 设置幻象造成伤害
    // @param value：伤害倍率
    function MHUnit_SetIllusionDamageDeal takes unit u, real value returns nothing
    endfunction

    // 获取幻象接受伤害
    function MHUnit_GetIllusionDamageReceive takes unit u returns real
    endfunction

    // 设置幻象接受伤害
    // @param value：伤害倍率
    function MHUnit_SetIllusionDamageReceive takes unit u, real value returns nothing
    endfunction

    // 设置单位颜色
    // @Tip：类似于幻象和冰冻，不会改变单位本来的颜色
    function MHUnit_SetColor takes unit u, integer color returns nothing
    endfunction

    // 恢复单位颜色
    // @Tip：恢复单位本来的颜色
    function MHUnit_ResetColor takes unit u, integer color returns nothing
    endfunction

    // 设置模型
    // @param model_path：模型路径
    // @param flag：未知参数，一般填false
    function MHUnit_SetModel takes unit u, string model_path, boolean flag returns nothing
    endfunction

    // 设置队伍颜色
    // param color：颜色
    function MHUnit_SetTeamColor takes effect eff, playercolor color returns nothing
    endfunction

    // 设置队伍光晕
    // param glow：光晕。填playercolor就行
    function MHUnit_SetTeamGlow takes effect eff, playercolor glow returns nothing
    endfunction

    // 获取动画进度
    function MHUnit_GetAnimationProgress takes unit u returns real
    endfunction

    // 设置动画进度
    // @param progress：进度，0~1
    function MHUnit_SetAnimationProgress takes unit u, real progress returns nothing
    endfunction

    // 变身
    function MHUnit_Morph takes unit u, integer uid returns nothing
    endfunction

    // 进行一次攻击
    // @Tip：不会打断当前动作，会触发 任意单位攻击出手 事件
    function MHUnit_LaunchAttack takes unit source, integer weapons_on, widget target returns nothing
    endfunction

    // 设置朝向
    function MHUnit_SetFacing takes unit u, real deg, boolean is_instant returns nothing
    endfunction

    // 沉默
    // @Tip：计数器
    function MHUnit_Silence takes unit u, boolean is_silence returns nothing
    endfunction

    // 禁用技能
    function MHUnit_DisableAbility takes unit u, boolean is_disable, boolean is_hide, boolean disable_magic, boolean disable_physical returns nothing
    endfunction

    // 恢复生命值
    // @Tip：会触发 任意单位恢复生命值 事件
    // @param value：恢复数值。正数回血，负数扣血
    function MHUnit_RestoreLife takes unit u, real value returns nothing
    endfunction

    // 恢复生命值
    // @Tip：会触发 任意单位恢复魔法值 事件
    // @param value：恢复数值。正数回蓝，负数扣蓝
    function MHUnit_RestoreMana takes unit u, real value returns nothing
    endfunction

    // 更新信息栏
    // @Tip：在设置某些数据后可使用该函数立即刷新面板
    function MHUnit_UpdateInfoBar takes unit u returns nothing
    endfunction

    // 获取训练列表中的id
    // @param index：训练列表中的序号1~7
    function MHUnit_GetTrainId takes unit u, integer index returns integer
    endfunction

    // 取消训练
    function MHUnit_CancelTrain takes unit u, integer index returns nothing
    endfunction

    // 获取商店当前目标单位
    // @param u：商店
    // @param p：玩家
    function MHUnit_GetShopTarget takes unit u, player p returns unit
    endfunction

    // 获取当前进度计时器的速度
    // @Tip：包括训练、研究、建造和升级
    // 默认为1
    function MHUnit_GetProgressSpeed takes unit u returns real
    endfunction

    // 设置当前进度计时器的速度
    // @Tip：包括训练、研究、建造和升级
    // @param speed：速度。默认为1
    function MHUnit_SetProgressSpeed takes unit u, real speed returns nothing
    endfunction

    // 获取当前进度计时器的进度
    // @Tip：包括训练、研究、建造和升级
    // 返回一个0~1之间的值
    function MHUnit_GetProgress takes unit u returns real
    endfunction

    // 设置当前进度计时器的进度
    // @Tip：仅支持训练和研究
    // @param progress：取值范围0~1
    function MHUnit_SetProgress takes unit u, real progress returns nothing
    endfunction

    // 设置当前进度计时器的进度
    // @Tip：仅支持训练和研究
    // @param elapsed：经过的时间
    // @param total：总时间
    function MHUnit_SetProgressEx takes unit u, real elapsed, real total returns nothing
    endfunction

    // 绑定单位到单位
    function MHUnit_BindToUnit takes unit u, unit target, string attach returns nothing
    endfunction

    // 绑定单位到物品
    function MHUnit_BindToItem takes unit u, item target, string attach returns nothing
    endfunction

    // 绑定单位到可破坏物
    function MHUnit_BindToDest takes unit u, destructable target, string attach returns nothing
    endfunction

    // 绑定单位到特效
    function MHUnit_BindToEffect takes unit u, effect target, string attach returns nothing
    endfunction

    // 从物体上解绑
    function MHUnit_UnbindFromObject takes unit u returns nothing
    endfunction

    // 获取血条
    // @Tip：返回一个CStatBar(继承自CSimpleStatusBar)
    function MHUnit_GetHPBar takes unit u returns integer
    endfunction

    // 获取发布命令的玩家
    // @Tip：当前有命令时才会返回。触发发布的命令返回玩家1
    function MHUnit_GetOrderPlayer takes unit u returns player
    endfunction



// Hook库



    // 屏蔽单位命令
    // @Tip：禁止 单位u 接收来自 玩家p 的命令
    function MHUnit_DisableOrder takes unit u, player p returns nothing
    endfunction

    // 恢复单位命令
    // @Tip：指 MHUnit_DisableOrder 中屏蔽的单位
    function MHUnit_EnableOrder takes unit u, player p returns nothing
    endfunction

    // 单位被屏蔽命令
    // @Tip：单位u 已被禁止接收来自 玩家p 的命令
    function MHUnit_IsDisableOrder takes unit u, player p returns boolean
    endfunction

    // 单位失控
    // @Tip：相当于屏蔽所有玩家对 单位u 的命令
    function MHUnit_DisableControl takes unit u returns nothing
    endfunction

    // 单位恢复控制
    // @Tip：相当于恢复所有玩家对 单位u 的命令
    function MHUnit_EnableControl takes unit u returns nothing
    endfunction

    // 单位已失控
    // @Tip：相当于所有玩家已屏蔽对 单位u 的命令
    function MHUnit_IsDisableControl takes unit u returns boolean
    endfunction

    // 设置单位攻速上限
    // @Tip：单个单位的攻速上限
    function MHUnit_SetAttackSpeedLimit takes unit u, real limit returns nothing
    endfunction

    // 获取单位攻速上限
    function MHUnit_GetAttackSpeedLimit takes unit u returns real
    endfunction

    // 重置单位攻速上限
    // @Tip：指代 MHUnit_SetAttackSpeedLimit 中设置的攻速上限
    function MHUnit_ResetAttackSpeedLimit takes unit u returns nothing
    endfunction

    // 设置单位移速上限
    // @Tip：单个单位的移速上限
    function MHUnit_SetMoveSpeedLimit takes unit u, real limit returns nothing
    endfunction

    // 获取单位移速上限
    function MHUnit_GetMoveSpeedLimit takes unit u returns real
    endfunction

    // 重置单位移速上限
    // @Tip：指代 MHUnit_SetMoveSpeedLimit 中设置的移速上限
    function MHUnit_ResetMoveSpeedLimit takes unit u returns nothing
    endfunction

    // 增加额外施法距离
    function MHUnit_AddSpellRange takes unit u, real limit returns nothing
    endfunction

    // 获取额外施法距离
    // @Tip：指代 MHUnit_AddSpellRange 中增加的施法距离
    function MHUnit_GetSpellRange takes unit u returns real
    endfunction

    // 重置额外施法距离
    // @Tip：指代 MHUnit_AddSpellRange 中增加的施法距离
    function MHUnit_ResetSpellRange takes unit u returns nothing
    endfunction

    // 允许技能显示
    // @Tip：强制显示 单位u 的技能 对 玩家p
    function MHUnit_EnableViewSkill takes unit u, player p returns nothing
    endfunction

    // 禁止技能显示
    // @Tip：指 MHViewSkill_Enable 中允许的技能显示
    function MHUnit_DisableViewSkill takes unit u, player p returns nothing
    endfunction

    // 已允许技能显示
    // @Tip：已允许强制显示 单位u 的技能 对 玩家p
    function MHUnit_IsEnableViewSkill takes unit u, player p returns boolean
    endfunction

    // 设置单位名称信息
    // @Tip：仅有显示作用，不会影响 GetUnitName 等相关函数的返回值
    function MHUnit_SetInfoName takes unit u, string name returns nothing
    endfunction

    // 获取单位名称信息
    // @Tip：指 MHUnitInfo_SetName 中设置的单位名称
    function MHUnit_GetInfoName takes unit u returns string
    endfunction

    // 恢复单位名称信息
    // @Tip：指 MHUnitInfo_SetName 中设置的单位名称
    function MHUnit_RestoreInfoName takes unit u returns nothing
    endfunction

    // 设置单位种类信息
    // @Tip：仅有显示作用，不会影响单位的实际种类
    // 能让不显示种类信息的单位强制显示
    function MHUnit_SetInfoClass takes unit u, string class returns nothing
    endfunction

    // 获取单位种类信息
    // @Tip：指 MHUnitInfo_SetClass 中设置的单位种类
    function MHUnit_GetInfoClass takes unit u returns string
    endfunction

    // 恢复单位种类信息
    // @Tip：指 MHUnitInfo_SetClass 中设置的单位种类
    function MHUnit_RestoreInfoClass takes unit u returns nothing
    endfunction

    // 禁用单位的预选UI
    // @Tip：指头顶提示和血条
    function MHUnit_DisablePreSelectUI takes unit u, boolean is_disable returns nothing
    endfunction



// 事件库



    // 注册任意单位被创建事件
    // @Tip：EVENT_ID_UNIT_CREATE
    // 可用于替代进入地图事件
    function MHUnitCreateEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取被创建的单位
    // @Tip：响应 任意单位被创建 事件
    // 等价于 MHEvent_GetUnit
    function MHUnitCreateEvent_GetUnit takes nothing returns unit
    endfunction

    // 注册任意单位被删除事件
    // @Tip：EVENT_ID_UNIT_REMOVE
    // 包括触发器删除和尸体自然消失
    function MHUnitRemoveEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取被删除的单位
    // @Tip：响应 任意单位被删除 事件
    // 等价于 MHEvent_GetUnit
    function MHUnitRemoveEvent_GetUnit takes nothing returns unit
    endfunction

    // 注册任意单位攻击出手事件
    // @Tip：EVENT_ID_ATTACK_LAUNCH
    // 指攻击后摇结束，攻击伤害/弹道即将出手的时候
    // 如果是近战或者立即，则该事件过后直接进入伤害结算
    function MHUnitAttackLaunchEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取攻击来源单位
    // @Tip：响应 任意单位攻击出手 事件
    // 等价于 MHEvent_GetUnit
    function MHUnitAttackLaunchEvent_GetSource takes nothing returns unit
    endfunction

    // 获取攻击目标单位
    // @Tip：响应 任意单位攻击出手 事件
    function MHUnitAttackLaunchEvent_GetTargetUnit takes nothing returns unit
    endfunction

    // 获取攻击目标物品
    // @Tip：响应 任意单位攻击出手 事件
    function MHUnitAttackLaunchEvent_GetTargetItem takes nothing returns item
    endfunction

    // 获取攻击目标可破坏物
    // @Tip：响应 任意单位攻击出手 事件
    function MHUnitAttackLaunchEvent_GetTargetDest takes nothing returns destructable
    endfunction

    // 设置攻击目标
    // @Tip：响应 任意单位攻击出手 事件
    // 设置为 null 则可屏蔽本次攻击
    function MHUnitAttackLaunchEvent_SetTarget takes widget target returns nothing
    endfunction

    // 获取攻击索引
    // @Tip：响应 任意单位攻击出手 事件
    // 1 = 攻击1; 2 = 攻击2
    function MHUnitAttackLaunchEvent_GetWeapsOn takes nothing returns integer
    endfunction

    // 设置攻击索引
    // @Tip：响应 任意单位攻击出手 事件
    // 1 = 攻击1; 2 = 攻击2
    function MHUnitAttackLaunchEvent_SetWeapsOn takes integer weapons_on returns nothing
    endfunction

    // 屏蔽攻击出手
    function MHUnitAttackLaunchEvent_Disable takes boolean is_disable returns nothing
    endfunction

    // 注册任意单位切换仇恨目标事件
    // EVENT_ID_UNIT_SEARCH_TARGET
    function MHUnitSearchTargetEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取仇恨来源
    // @Tip：响应 任意单位切换仇恨目标 事件
    // 等价于 MHEvent_GetUnit
    function MHUnitSearchTargetEvent_GetSource takes nothing returns nothing
    endfunction

    // 获取仇恨目标
    // @Tip：响应 任意单位切换仇恨目标 事件
    function MHUnitSearchTargetEvent_GetTarget takes nothing returns unit
    endfunction

    // 设置仇恨目标
    // @Tip：响应 任意单位切换仇恨目标 事件
    function MHUnitSearchTargetEvent_SetTarget takes unit target returns nothing
    endfunction

    // 注册任意单位恢复生命值事件
    // @Tip：EVENT_ID_UNIT_RESTORE_LIFE
    // 不包括自然回血
    // 游戏不会存储真实生命值，仅记录基础生命值和上次更改基础生命值的时间戳
    // 当需要用到真实生命值的时候，才会计算：基础生命值 + (当前时间戳 - 上次的时间戳) * 生命恢复速度
    // 当受到伤害、治疗或者触发器等外界因素影响生命值时就会更新基础生命值和时间戳
    function MHUnitRestoreLifeEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取恢复生命值的单位
    // @Tip：响应 任意单位恢复生命值 事件
    // 等价于 MHEvent_GetUnit
    function MHUnitRestoreLifeEvent_GetUnit takes nothing returns unit
    endfunction

    // 获取恢复的生命值
    // @Tip：响应 任意单位恢复生命值 事件
    // 正数为回血，负数为扣血
    function MHUnitRestoreLifeEvent_GetValue takes nothing returns real
    endfunction

    // 设置恢复的生命值
    // @Tip：响应 任意单位恢复生命值 事件
    // 正数为回血，负数为扣血
    function MHUnitRestoreLifeEvent_SetValue takes real value returns nothing
    endfunction

    // 注册任意单位恢复魔法值事件
    // @Tip：EVENT_ID_UNIT_RESTORE_MANA
    // 不包括自然回蓝
    // 游戏不会存储真实魔法值，仅记录基础魔法值和上次更改基础魔法值的时间戳
    // 当需要用到真实魔法值的时候，才会计算：基础魔法值 + (当前时间戳 - 上次的时间戳) * 魔法恢复速度
    // 当恢复魔法或者触发器等外界因素影响魔法值时就会更新基础魔法值和时间戳
    function MHUnitRestoreManaEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取恢复魔法值的单位
    // @Tip：响应 任意单位恢复魔法值 事件
    // 等价于 MHEvent_GetUnit
    function MHUnitRestoreManaEvent_GetUnit takes nothing returns unit
    endfunction

    // 获取恢复的魔法值
    // @Tip：响应 任意单位恢复魔法值 事件
    // 正数为回蓝，负数为扣蓝
    function MHUnitRestoreManaEvent_GetValue takes nothing returns real
    endfunction

    // 设置恢复的魔法值
    // @Tip：响应 任意单位恢复魔法值 事件
    // 正数为回蓝，负数为扣蓝
    function MHUnitRestoreManaEvent_SetValue takes real value returns nothing
    endfunction

    // 注册任意单位被驱散魔法效果事件
    // @Tip：EVENT_ID_BUFF_DISPEL
    // 指被驱散类技能命中的一瞬间，此时获取不到被驱散的buff
    function MHUnitDispelEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取被驱散buff的单位
    // @Tip：响应 任意单位被驱散Buff 事件
    // 等价于 MHEvent_GetUnit
    // 指被驱散类技能命中的单位
    function MHUnitDispelEvent_GetTarget takes nothing returns unit
    endfunction

    // 获取驱散buff的单位
    // @Tip：响应 任意单位被驱散Buff 事件
    // 指释放驱散类技能的单位
    function MHUnitDispelEvent_GetSource takes nothing returns unit
    endfunction

    // 获取驱散伤害
    // @Tip：响应 任意单位被驱散Buff 事件
    // 指对召唤单位的伤害
    function MHUnitDispelEvent_GetDamage takes nothing returns real
    endfunction

    // 设置驱散伤害
    // @Tip：响应 任意单位被驱散Buff 事件
    // 指对召唤单位的伤害
    function MHUnitDispelEvent_SetDamage takes real dmg returns nothing
    endfunction

    // 注册任意单位送回资源事件
    // @Tip：EVENT_ID_UNIT_HARVEST
    function MHUnitHarvestEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取送回资源的单位
    // @Tip：响应 任意单位送回资源 事件
    // 对于侍僧/小精灵采矿返回金矿
    // 等价于 MHEvent_GetUnit
    function MHUnitHarvestEvent_GetUnit takes nothing returns unit
    endfunction

    // 获取送回的资源量
    // @Tip：响应 任意单位送回资源 事件
    function MHUnitHarvestEvent_GetValue takes nothing returns integer
    endfunction

    // 设置送回的资源量
    // @Tip：响应 任意单位送回资源 事件
    function MHUnitHarvestEvent_SetValue takes integer value returns nothing
    endfunction

    // 送回的资源是黄金
    // @Tip：响应 任意单位送回资源 事件
    function MHUnitHarvestEvent_IsResourceGold takes nothing returns boolean
    endfunction

    // 设置送回的资源是黄金
    // @Tip：响应 任意单位送回资源 事件
    // 设置为False可将送回的黄金变为木材，仅对农民、苦工、食尸鬼送回资源有效
    function MHUnitHarvestEvent_SetResourceGold takes boolean is_gold returns nothing
    endfunction






    
//==================================================================================
//
// [英雄] hero.j 
//
//==================================================================================



// 基本库



    // 获取最大经验值
    // @Tip：指英雄从0级升级到指定等级需要的经验值
    function MHHero_GetMaxExp takes unit u, integer level returns integer
    endfunction

    // 获取需要的经验值
    // @Tip：指英雄当前升级到指定等级需要的经验值
    function MHHero_GetNeededExp takes unit u, integer level returns integer
    endfunction

    // 获取英雄主属性
    // @Tip：1 = 力量; 2 = 智力; 3 = 敏捷
    function MHHero_GetPrimaryAttr takes unit u returns integer
    endfunction

    // 设置英雄主属性
    // @param attr：HERO_ATTRIBUTE
    function MHHero_SetPrimaryAttr takes unit u, integer attr returns nothing
    endfunction

    // 获取英雄主属性数值
    // @param include_bonus：包括加成
    function MHHero_GetPrimaryAttrValue takes unit u, boolean include_bonus returns integer
    endfunction

    // 设置英雄主属性数值
    // @param allow_bonus：允许永久奖励，貌似无效项
    function MHHero_SetPrimaryAttrValue takes unit u, integer value, boolean allow_bonus returns nothing
    endfunction

    // 获取英雄属性成长
    // @Tip：游戏不会存储实际属性，只会存储基础属性和属性成长。基础属性包括初始属性和绿字属性
    // 需要用到实际属性的时候内部才会去计算：基础属性 + 属性成长 * (英雄等级 - 1)
    function MHHero_GetAttrPlus takes unit u, integer attr returns real
    endfunction

    // 设置英雄属性成长
    // @Tip：游戏不会存储实际属性，只会存储基础属性和属性成长。基础属性包括初始属性和绿字属性
    // 需要用到实际属性的时候内部才会去计算：基础属性 + 属性成长 * (英雄等级 - 1)
    function MHHero_SetAttrPlus takes unit u, integer attr, real value returns nothing
    endfunction

    // 替换学习技能
    // @Tip：只会影响未学习的技能
    function MHHero_ModifyAbility takes unit u, integer old_id, integer new_id returns boolean
    endfunction

    // 替换学习技能Ex
    // @Tip：只会影响未学习的技能
    // @param index：要替换的技能序号。1~5
    function MHHero_ModifyAbilityEx takes unit u, integer index, integer new_id returns boolean
    endfunction

    // 替换英雄技能
    // @Tip：最好替换同源技能
    // 会同时影响已学习和未学习的技能
    function MHHero_ChangeAbility takes unit u, integer old_id, integer new_id returns boolean
    endfunction

    // 替换英雄技能Ex
    // @Tip：无同源技能限制
    // 本质上是替换学习技能 + 删除旧技能 + 添加新技能 + 设置技能等级
    function MHHero_ChangeAbilityEx takes unit u, integer old_id, integer new_id returns boolean
    endfunction



// 事件库



    // 注册任意单位获取经验值事件
    // @Tip：EVENT_ID_HERO_GET_EXP
    function MHHeroGetExpEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取获得的经验值
    // @Tip：响应 任意单位获取经验值 事件
    // 指经验值变化值
    function MHHeroGetExpEvent_GetValue takes nothing returns integer
    endfunction

    // 设置获得的经验值
    // @Tip：响应 任意单位获取经验值 事件
    // @param value：新的经验值变化值，非负数
    function MHHeroGetExpEvent_SetValue takes integer value returns nothing
    endfunction







//==================================================================================
//
// [魔法效果] buff.j 
//
//==================================================================================



// 基本库



    // 添加Buff
    // @param u：添加buff的单位
    // @param bid：buff的真实id
    // @param template：BUFF_TEMPLATE。buff的模板
    // @param dur：持续时间
    function MHBuff_Create takes unit u, integer bid, integer template, real dur returns buff
    endfunction

    // 获取Buff等级
    // @Tip：返回魔法效果的真实等级
    function MHBuff_GetLevel takes unit u, integer bid returns integer
    endfunction

    // 设置Buff等级
    // @Tip：设置魔法效果的真实等级
    // 光环技能的buff等级会被刷新
    function MHBuff_SetLevel takes unit u, integer bid, integer level returns nothing
    endfunction

    // 获取Buff基础ID
    // @Tip：主要用于检查继承
    function MHBuff_GetBaseID takes unit u, integer bid returns integer
    endfunction
    
    // 获取Buff剩余持续时间
    function MHBuff_GetRemain takes unit u, integer bid returns real
    endfunction

    // 设置Buff剩余持续时间
    function MHBuff_SetRemain takes unit u, integer bid, real dur returns nothing
    endfunction

    // 判定Buff极性
    // @param polarity：极性。BUFF_POLARITY
    function MHBuff_IsPolarity takes unit u, integer polarity returns boolean
    endfunction



// Hook库


    // 设置buff叠加
    // @Tip：解除同模板buff不叠加的限制。暂不支持投射物技能buff的叠加
    // @param buff_template：BUFF_TEMPLATE
    // @param is_enable：true - 可叠加; false - 不可叠加
    function MHBuff_SetOverlay takes integer buff_template, boolean is_enable returns nothing
    endfunction

    // 设置Buff极性
    // @param polarity：Buff极性。BUFF_POLARITY
    function MHBuff_SetPolarity takes unit u, integer bid, integer polarity, boolean is_polarity returns boolean
    endfunction

    // 恢复Buff极性
    function MHBuff_RestorePolarity takes unit u, integer bid, integer polarity returns boolean
    endfunction






    
//==================================================================================
//
// [游戏常数] constant.j 
//
//==================================================================================



// 基本库



    // 设置字节码限制
    // @Tip：有符号整数。默认限制为30w，在魔兽版本1.29或更高版本是300w。
    // 返回旧限制
    function MHConst_SetOPLimit takes integer limit returns integer
    endfunction

    // 获取字节码限制
    // @Tip：有符号整数。默认限制为30w，在魔兽版本1.29或更高版本是300w。
    function MHConst_SetOPLimit takes integer limit returns integer
    endfunction

    // 设置jass数组大小限制
    // @Tip：无符号整数。默认限制为8192。
    // 返回旧限制
    function MHConst_SetMaxArraySize takes integer limit returns integer
    endfunction

    // 解除Blp大小限制
    // @Tip：解除后为大小限制为32768x32768，默认为512*512
    // 返回旧限制
    function MHConst_UnlockBlpSizeLimit takes boolean is_unlock returns integer
    endfunction

    // 设置最大移动速度限制
    // @Tip：可突破522的最大移速
    // 只要超过522就可能会因为寻路检查点原因导致回头
    // 不推荐超过1000，回头现象严重
    // 返回旧限制
    function MHConst_SetMaxMoveSpeed takes real limit returns real
    endfunction

    // 设置最大攻速限制
    // @Tip：默认最大限制为5，即500%攻速上限
    // 可突破每秒46次的攻速限制
    // 返回旧限制
    function MHConst_SetMaxAttackSpeed takes real limit returns real
    endfunction

    // 设置最大持续时间
    // @Tip：可突破300s的最大持续时间和冷却时间的限制
    // 返回旧限制
    function MHConst_SetMaxDuration takes real limit returns real
    endfunction

    // 设置最大视野
    // @Tip：可突破1800的最大视野限制。不能设置太大的值否则会崩溃
    // 返回旧限制
    function MHConst_SetMaxSight takes real limit returns real
    endfunction

    // 设置最大人口
    // @Tip：可突破300的最大人口限制
    // 返回旧限制
    function MHConst_SetMaxFood takes integer limit returns integer
    endfunction

    // 解锁字体大小限制
    function MHConst_UnlockFontHeight takes boolean is_unlock returns integer
    endfunction
    






//==================================================================================
//
// [伤害] damage.j 
//
//==================================================================================



// 基本库

    // 伤害目标
    // @Tip：与 UnitDamageTarget 并无本质区别，只是开放了可以设置攻击伤害以及伤害标志的接口
    // @param is_physical：是攻击伤害
    // @param flag：伤害标志。疑似BitSet，取值参考表格
    function MHDamage_DamageTarget takes unit u, widget target, real dmg, attacktype atk_type, damagetype dmg_type, boolean is_physical, integer flag returns real
    endfunction



// 事件库



    // 是攻击伤害 (后伤害事件)
    // @Tip：响应YD和原版的受伤事件
    function MHDamageEvent_IsPhysical takes nothing returns boolean
    endfunction

    // 获取伤害标志 (后伤害事件)
    // @Tip：响应YD和原版的受伤事件
    // 疑似BitSet
    // 某些技能或者特殊伤害会将特殊的标志放入伤害事件中
    // 例如疾风步破隐一击的标志为0x500，远程攻击的标志为0x1
    function MHDamageEvent_GetFlag takes nothing returns integer
    endfunction

    // 获取攻击类型 (后伤害事件)
    // @Tip：响应YD和原版的受伤事件
    function MHDamageEvent_GetAtkType takes nothing returns attacktype
    endfunction

    // 获取伤害类型 (后伤害事件)
    // @Tip：响应YD和原版的受伤事件
    function MHDamageEvent_GetDmgType takes nothing returns damagetype
    endfunction

    // 获取武器类型 (后伤害事件)
    // @Tip：响应YD和原版的受伤事件
    function MHDamageEvent_GetWeapType takes nothing returns weapontype
    endfunction

    // 获取攻击类型 (整数) (后伤害事件)
    // @Tip：响应YD和原版的受伤事件
    function MHDamageEvent_GetAtkTypeInt takes nothing returns integer
    endfunction

    // 获取伤害类型 (整数) (后伤害事件)
    // @Tip：响应YD和原版的受伤事件
    function MHDamageEvent_GetDmgTypeInt takes nothing returns integer
    endfunction

    // 获取武器类型 (整数) (后伤害事件)
    // @Tip：响应YD和原版的受伤事件
    function MHDamageEvent_GetWeapTypeInt takes nothing returns integer
    endfunction

    // 设置伤害值 (后伤害事件)
    // @Tip：响应YD和原版的受伤事件
    // 修复了ydjapi设置伤害值会使得吸血变扣血的bug
    function MHDamageEvent_SetDamage takes real value returns nothing
    endfunction

    // 注册任意接收伤害事件 (前伤害事件)
    // @Tip：EVENT_ID_DAMAGING
    // 指伤害刚作用于单位的时候，此时还未结算为最终伤害
    // 发生在在伤害流程中灵魂锁链之后，反魔法外壳之前
    function MHDamagingEvent_Register takes trigger trig returns nothing
    endfunction

    // 是攻击伤害 (前伤害事件)
    // @Tip：响应MH的受伤事件
    function MHDamagingEvent_IsPhysical takes nothing returns boolean
    endfunction

    // 获取伤害值 (前伤害事件)
    // @Tip：响应MH的受伤事件
    // 指未被结算为最终伤害的初始伤害值
    function MHDamagingEvent_GetDamage takes nothing returns real
    endfunction

    // 设置伤害值 (前伤害事件)
    // @Tip：响应MH的受伤事件
    // 指未被结算为最终伤害的初始伤害值
    function MHDamagingEvent_SetDamage takes real value returns nothing
    endfunction

    // 获取伤害来源 (前伤害事件)
    // @Tip：响应MH的受伤事件
    function MHDamagingEvent_GetSource takes nothing returns unit
    endfunction

    // 设置伤害来源 (前伤害事件)
    // @Tip：响应MH的受伤事件
    function MHDamagingEvent_SetSource takes unit u returns nothing
    endfunction

    // 获取伤害目标 (前伤害事件)
    // @Tip：响应MH的受伤事件
    // 等价于 MHEvent_GetUnit
    function MHDamagingEvent_GetTarget takes nothing returns unit
    endfunction

    // 设置伤害目标 (前伤害事件)
    // @Tip：响应MH的受伤事件
    // 等价于 MHEvent_SetUnit
    function MHDamagingEvent_SetTarget takes unit u returns nothing
    endfunction

    // 获取伤害标志 (前伤害事件)
    // @Tip：响应MH的受伤事件
    // 疑似BitSet
    // 某些技能或者特殊伤害会将特殊的标志放入伤害事件中
    // 例如疾风步破隐一击的标志为0x500，远程攻击的标志为0x1
    function MHDamagingEvent_GetFlag takes nothing returns integer
    endfunction

    // 设置伤害标志 (前伤害事件)
    // @Tip：响应MH的受伤事件
    // 疑似BitSet。取值参考表格
    function MHDamagingEvent_SetFlag takes integer value returns nothing
    endfunction

    // 获取攻击类型 (前伤害事件)
    // @Tip：响应MH的受伤事件
    function MHDamagingEvent_GetAtkType takes nothing returns attacktype
    endfunction

    // 获取攻击类型 (整数) (前伤害事件)
    // @Tip：响应MH的受伤事件
    function MHDamagingEvent_GetAtkTypeInt takes nothing returns integer
    endfunction

    // 设置攻击类型 (前伤害事件)
    // @Tip：响应MH的受伤事件
    function MHDamagingEvent_SetAtkType takes attacktype atk_type returns nothing
    endfunction

    // 获取伤害类型 (前伤害事件)
    // @Tip：响应MH的受伤事件
    function MHDamagingEvent_GetDmgType takes nothing returns damagetype
    endfunction

    // 获取伤害类型 (整数) (前伤害事件)
    // @Tip：响应MH的受伤事件
    function MHDamagingEvent_GetDmgTypeInt takes nothing returns integer
    endfunction

    // 设置伤害类型 (前伤害事件)
    // @Tip：响应MH的受伤事件
    function MHDamagingEvent_SetDmgType takes damagetype dmg_type returns nothing
    endfunction

    // 获取武器类型 (前伤害事件)
    // @Tip：响应MH的受伤事件
    function MHDamagingEvent_GetWeapType takes nothing returns weapontype
    endfunction

    // 获取武器类型 (整数) (前伤害事件)
    // @Tip：响应MH的受伤事件
    function MHDamagingEvent_GetWeapTypeInt takes nothing returns integer
    endfunction

    // 设置武器类型 (前伤害事件)
    // @Tip：响应MH的受伤事件
    function MHDamagingEvent_SetWeapType takes weapontype weap_type returns nothing
    endfunction







//==================================================================================
//
// [调试] debug.j 
//
//==================================================================================



// 基本库



    // 获取当前Handle数量
    function MHDebug_GetHandleCount takes nothing returns integer
    endfunction

    // 获取最大Handle数量
    function MHDebug_GetHandleMaxCount takes nothing returns integer
    endfunction

    // 发送泄漏信息
    function MHDebug_SendLeakMessage takes nothing returns nothing
    endfunction

    // 允许崩溃跟踪
    // @Tip：启动后无法关闭。会在调用native崩溃后生成日志
    function MHDebug_EnableCrashTraceback takes nothing returns nothing
    endfunction

    // 允许异步检测
    // @Tip：启动后无法关闭。会在玩家掉线后生成日志
    function MHDebug_EnableDesyncCheck takes nothing returns nothing
    endfunction

    // 设置保留的异步日志数量
    // @Tip：默认为2，超过该数字后日志会轮换删除
    // 异步日志没有记录到异步点的时候可以尝试设置为一个较大的数或者-1
    // 过多的异步日志会导致游戏体积急剧增大
    function MHDebug_SetDesyncCheckFileCount takes integer count returns nothing
    endfunction

    // 设置异步检测记录所有函数
    // @Tip：默认情况下仅记录会引起掉线的native函数，开启后会记录所有native函数
    function MHDebug_EnableLogAllDesync takes boolean is_all returns nothing
    endfunction
    
    // 异步检测排除函数
    // @Tip：排除后异步日志不会记录该函数的调用
    function MHDebug_DesyncExcludeFunc takes string func returns nothing
    endfunction




    


//==================================================================================
//
// [Slk] slk.j 
//
//==================================================================================



// 基本库



    // 获取物编整数
    // @param table：SLK_TABLE。slk表
    // @param id：物体id
    // @param field：数据字段
    function MHSlk_GetInt takes string table, integer id, string field returns integer
    endfunction

    // 获取物编实数
    // @param table：SLK_TABLE。slk表
    // @param id：物体id
    // @param field：数据字段
    function MHSlk_GetReal takes string table, integer id, string field returns real
    endfunction

    // 获取物编布尔值
    // @param table：SLK_TABLE。slk表
    // @param id：物体id
    // @param field：数据字段
    function MHSlk_GetBool takes string table, integer id, string field returns boolean
    endfunction

    // 获取物编字符串
    // @param table：SLK_TABLE。slk表
    // @param id：物体id
    // @param field：数据字段
    function MHSlk_GetStr takes string table, integer id, string field returns string
    endfunction







//==================================================================================
//
// [特效] effect.j 
//
//==================================================================================



// 基本库



    // 获取X坐标
    function MHEffect_GetX takes effect eff returns real
    endfunction

    // 获取Y坐标
    function MHEffect_GetY takes effect eff returns real
    endfunction

    // 获取Z坐标
    function MHEffect_GetZ takes effect eff returns real
    endfunction

    // 设置X坐标
    function MHEffect_SetX takes effect eff, real value returns nothing
    endfunction

    // 设置Y坐标
    function MHEffect_SetY takes effect eff, real value returns nothing
    endfunction

    // 设置Z坐标
    function MHEffect_SetZ takes effect eff, real value returns nothing
    endfunction

    // 设置三轴坐标
    function MHEffect_SetPosition takes effect eff, real x, real y, real z returns nothing
    endfunction

    // 设置横滚角
    // @Tip：多次调用会累加。绕X轴转角 (角度制)
    function MHEffect_SetRoll takes effect eff, real deg returns nothing
    endfunction

    // 设置俯仰角
    // @Tip：多次调用会累加。绕Y轴转角 (角度制)
    function MHEffect_SetPitch takes effect eff, real deg returns nothing
    endfunction

    // 设置偏航角
    // @Tip：多次调用会累加。绕Z轴转角 (角度制)
    function MHEffect_SetYaw takes effect eff, real deg returns nothing
    endfunction

    // 设置自转角
    // @Tip：多次调用会累加。右手螺旋定则 (角度制)
    function MHEffect_Rotate takes effect eff, real deg returns nothing
    endfunction

    // 获取自转角
    function MHEffect_Rotation takes effect eff returns real
    endfunction

    // 设置方向向量
    // @Tip：向量形式。(1, 0, 0) 表示初始方向 (正东)。不需要归一化
    function MHEffect_SetVector takes effect eff, real xv, real yv, real zv returns nothing
    endfunction

    // 获取方向向量X坐标
    // @Tip：向量形式。(1, 0, 0) 表示初始方向 (正东)。已归一化
    function MHEffect_GetVectorX takes effect returns real
    endfunction

    // 获取方向向量Y坐标
    // @Tip：向量形式。(1, 0, 0) 表示初始方向 (正东)。已归一化
    function MHEffect_GetVectorY takes effect returns real
    endfunction

    // 获取方向向量Z坐标
    // @Tip：向量形式。(1, 0, 0) 表示初始方向 (正东)。已归一化
    function MHEffect_GetVectorZ takes effect returns real
    endfunction

    // 镜像操作
    // @Tip：将特效按某一平面镜像
    // @param axis：MIRROR_AXIS
    function MHEffect_SetMirror takes effect eff, integer axis returns nothing
    endfunction

    // 设置缩放
    function MHEffect_SetScale takes effect eff, real scale returns nothing
    endfunction

    // 设置三轴缩放
    function MHEffect_SetScaleEx takes effect eff, real x, real y, real z returns nothing
    endfunction

    // 设置粒子缩放
    // @Tip：多次设置会乘算叠加
    function MHEffect_SetParticleScale takes effect eff, real scale returns nothing
    endfunction

    // 重置变换
    // @Tip：重置大小和方向
    function MHEffect_ResetMatrix takes effect eff returns nothing
    endfunction

    // 设置模型
    // @param model_path：模型路径
    // @param flag：未知参数，一般填false
    function MHEffect_SetModel takes effect eff, string model_path, boolean flag returns nothing
    endfunction

    // 设置队伍颜色
    // @param color：颜色
    function MHEffect_SetTeamColor takes effect eff, playercolor color returns nothing
    endfunction

    // 设置队伍光晕
    // @param glow：光晕。填playercolor就行
    function MHEffect_SetTeamGlow takes effect eff, playercolor glow returns nothing
    endfunction

    // 隐藏
    // @param is_hide：true - 隐藏; false - 显示
    function MHEffect_Hide takes effect eff, boolean is_hide returns nothing
    endfunction
 
    // 被隐藏
    function MHEffect_IsHidden takes effect eff returns boolean
    endfunction

    // 设置透明度
    function MHEffect_SetAlpha takes effect eff, integer alpha returns nothing
    endfunction

    // 设置颜色
    // @param color：16进制颜色代码。例如0xFFFF0000表示不透明红色
    function MHEffect_SetColor takes effect eff, integer color returns nothing
    endfunction

    // 设置颜色
    // @Tip：ARGB。各颜色值取值范围为 0~255
    function MHEffect_SetColorEx takes effect eff, integer alpha, integer red, integer green, integer blue returns nothing
    endfunction

    // 设置动画
    // @param index：动画序号
    // @param rarity：概率。一般填0
    function MHEffect_SetAnimation takes effect eff, integer index, integer rarity returns nothing
    endfunction 

    // 设置动画
    // @param name：动画名
    // @param attachment：附加链接动画名。一般不填
    function MHEffect_SetAnimationByName takes effect eff, string name, string attachment returns nothing
    endfunction

    // 设置动画
    // @param anim_type：动画类型
    // @param looping：是否循环
    function MHEffect_SetAnimationByType takes effect eff, integer anim_type, boolean looping returns nothing
    endfunction

    // 获取动画进度
    // @Tip：0~1
    function MHEffect_GetAnimationProgress takes effect eff returns real
    endfunction

    // 设置动画进度
    // @param progress：进度，0~1
    function MHEffect_SetAnimationProgress takes effect eff, real progress returns nothing
    endfunction

    // 设置动画播放速度
    function MHEffect_SetTimeScale takes effect eff, real scale returns nothing
    endfunction

    // 绑定到Widget
    // @Tip：可以将特效绑定到一个单位、物品或者可破坏物上
    // @param attach_name：附加点
    function MHEffect_BindToWidget takes effect eff, widget target, string attach_name returns nothing
    endfunction 

    // 绑定到特效
    // @Tip：可以将特效绑定到另一个特效上
    // @param attach_name：附加点
    function MHEffect_BindToEffect takes effect eff, effect target, string attach_name returns nothing
    endfunction

    // 绑定到frame
    // @Tip：可以将特效绑定到frame上。仅支持CSpriteFrame和CPortraitButton
    // @param attach_name：附加点
    function MHEffect_BindToFrame takes effect eff, integer frame, string attach_name returns nothing
    endfunction 

    // 从物体上解绑
    // @Tip：可以将特效从单位、物品、可破坏物或者特效上解绑
    function MHEffect_Unbind takes effect eff returns nothing
    endfunction 

    // 选取范围内的特效做动作
    function MHEffect_EnumInRange takes real x, real y, real range, code callback returns nothing
    endfunction

    // 选取范围内的特效做动作
    function MHEffect_EnumInRangeEx takes real x, real y, real range, string func_name returns nothing
    endfunction

    // 获取选取的特效
    // @Tip：用于选取特效做动作中，指代被选取的特效
    function MHEffect_GetEnumEffect takes nothing returns effect
    endfunction



// Hook库



    // 强制渲染特效
    // @Tip：可以强制渲染大模型特效，即使特效中心不在屏幕内也能渲染
    // 仅支持没有绑定到物体的特效
    function MHEffect_ForceRender takes effect eff, boolean is_force returns nothing
    endfunction

    // 开关特效渲染
    function MHEffect_SwitchRender takes boolean is_render returns nothing
    endfunction

    // 除外特效渲染
    // @Tip：指 MHEffect_SwitchRender 关闭后仍然渲染的特效
    function MHEffect_SwitchExclude takes effect eff, boolean is_exclude returns nothing
    endfunction







//==================================================================================
//
// [投射物] missile.j 
//
//==================================================================================



// 基本库



    // 隐藏
    // @param is_hide：true - 隐藏; false - 显示
    function MHMissile_Hide takes integer missile, boolean is_hide returns nothing
    endfunction

    // 被隐藏
    function MHMissile_IsHidden takes integer missile returns boolean
    endfunction

    // 获取X坐标
    function MHMissile_GetX takes integer missile returns real
    endfunction

    // 获取Y坐标
    function MHMissile_GetY takes integer missile returns real
    endfunction

    // 获取Z坐标
    function MHMissile_GetZ takes integer missile returns real
    endfunction

    // 获取投射物来源
    function MHMissile_GetSource takes integer missile returns unit
    endfunction

    // 设置投射物来源
    function MHMissile_SetSource takes integer missile, unit source returns nothing
    endfunction

    // 获取投射物目标单位
    function MHMissile_GetTargetUnit takes integer missile returns unit
    endfunction

    // 获取投射物目标物品
    function MHMissile_GetTargetItem takes integer missile returns item
    endfunction

    // 获取投射物目标可破坏物
    function MHMissile_GetTargetDest takes integer missile returns destructable
    endfunction

    // 设置投射物目标
    function MHMissile_SetTarget takes integer missile, widget target returns nothing
    endfunction

    // 设置投射物模型
    function MHMissile_SetModel takes integer missile, string model_path returns nothing
    endfunction

    // 获取投射物技能
    function MHMissile_GetAbility takes integer missile returns integer
    endfunction
    
    // 获取投射物数据 (整数)
    // @param flag：MISSILE_DATA
    function MHMissile_GetDataInt takes integer missile, integer flag returns integer
    endfunction

    // 设置投射物数据 (整数)
    // @param flag：MISSILE_DATA
    function MHMissile_SetDataInt takes integer missile, integer flag, integer value returns nothing
    endfunction

    // 获取投射物数据 (实数)
    // @param flag：MISSILE_DATA
    function MHMissile_GetDataReal takes integer missile, integer flag returns real
    endfunction

    // 设置投射物数据 (实数)
    // @param flag：MISSILE_DATA
    function MHMissile_SetDataReal takes integer missile, integer flag, real value returns nothing
    endfunction

    // 选取范围内的投射物做动作
    // @param callback：回调函数
    function MHMissile_EnumInRange takes real x, real y, real range, code callback returns nothing
    endfunction

    // 选取范围内的投射物做动作
    // @param func_name：回调函数名
    function MHMissile_EnumInRangeEx takes real x, real y, real range, string func_name returns nothing
    endfunction

    // 获取选取的投射物
    // @Tip：在选取投射物做动作中，指代被选取的投射物
    function MHMissile_GetEnumMissile takes nothing returns integer
    endfunction



// 事件库



    // 注册任意投射物发射事件
    function MHMissileLaunchEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取发射的投射物
    // @Tip：响应 任意投射物发射 事件
    // 等价于 MHEvent_GetMissile
    function MHMissileLaunchEvent_GetMissile takes nothing returns integer
    endfunction

    // 注册任意投射物命中事件
    function MHMissileHitEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取命中的投射物
    // @Tip：响应 任意投射物命中 事件
    // 等价于 MHEvent_GetMissile
    function MHMissileHitEvent_GetMissile takes nothing returns integer
    endfunction

    // 获取目标单位
    // @Tip：响应 任意投射物命中 事件
    function MHMissileHitEvent_GetTargetUnit takes nothing returns unit
    endfunction

    // 获取目标物品
    // @Tip：响应 任意投射物命中 事件
    function MHMissileHitEvent_GetTargetItem takes nothing returns item
    endfunction

    // 获取目标可破坏物
    // @Tip：响应 任意投射物命中 事件
    function MHMissileHitEvent_GetTargetDest takes nothing returns destructable
    endfunction

    // 设置目标
    // @Tip：响应 任意投射物命中 事件
    function MHMissileHitEvent_SetTarget takes widget target returns nothing
    endfunction

    // 获取伤害
    // @Tip：响应 任意投射物命中 事件
    function MHMissileHitEvent_GetDamage takes nothing returns real
    endfunction

    // 设置伤害
    // @Tip：响应 任意投射物命中 事件
    function MHMissileHitEvent_SetDamage takes real damage returns nothing
    endfunction

    // 重置投射物
    // @Tip：重新运行投射物，重置后本次命中不会结算
    function MHMissileHitEvent_Reset takes unit source, widget target returns boolean
    endfunction







//==================================================================================
//
// [事件] event.j 
//
//==================================================================================



// 基本库



    // 获取事件ID
    // @Tip：响应MH的相关事件
    // 返回值参考常数文档EVENT_ID
    function MHEvent_GetId takes nothing returns integer
    endfunction

    // 获取事件单位
    // @Tip：响应MH的相关事件
    // 指代触发MH事件的单位
    function MHEvent_GetUnit takes nothing returns unit
    endfunction

    // 设置事件单位
    // @Tip：响应MH的部分事件
    // 指代触发MH事件的单位
    function MHEvent_SetUnit takes unit u returns nothing
    endfunction

    // 获取事件技能
    // @Tip：响应MH的相关事件
    // 指代触发MH事件的技能
    function MHEvent_GetAbility takes nothing returns integer
    endfunction

    // 设置事件技能
    // @Tip：响应MH的部分事件
    // 指代触发MH事件的技能
    function MHEvent_SetAbility takes integer aid returns nothing
    endfunction

    // 获取事件物品
    // @Tip：响应MH的相关事件
    // 指代触发MH事件的物品
    function MHEvent_GetItem takes nothing returns item
    endfunction

    // 设置事件物品
    // @Tip：响应MH的部分事件
    // 指代触发MH事件的物品
    function MHEvent_SetItem takes item it returns nothing
    endfunction

    // 获取事件玩家
    // @Tip：响应MH的相关事件
    // 指代触发MH事件的玩家
    function MHEvent_GetPlayer takes nothing returns player
    endfunction

    // 设置事件玩家
    // @Tip：响应MH的部分事件
    // 指代触发MH事件的玩家
    function MHEvent_SetPlayer takes player p returns nothing
    endfunction

    // 获取事件投射物
    // @Tip：响应MH的相关事件
    // 指代触发MH事件的投射物
    function MHEvent_GetMissile takes nothing returns integer
    endfunction

    // 设置事件投射物
    // @Tip：响应MH的部分事件
    // 指代触发MH事件的投射物
    function MHEvent_SetMissile takes integer order returns nothing
    endfunction

    // 获取事件命令
    // @Tip：响应MH的相关事件
    // 指代触发MH事件的命令
    function MHEvent_GetOrder takes nothing returns integer
    endfunction

    // 设置事件命令
    // @Tip：响应MH的部分事件
    // 指代触发MH事件的命令
    // 设置一个无效值可屏蔽相关事件的发生。例如设置命令为0
    function MHEvent_SetOrder takes integer order returns nothing
    endfunction

    // 获取事件按键
    // @Tip：响应MH的相关事件
    // 指代触发MH事件的按键
    function MHEvent_GetKey takes nothing returns integer
    endfunction

    // 设置事件按键
    // @Tip：响应MH的部分事件
    // 指代触发MH事件的按键
    // 设置一个无效值可屏蔽相关事件的发生。例如设置按键为-1
    function MHEvent_SetKey takes integer key returns nothing
    endfunction

    // 获取事件Frame
    // @Tip：响应MH的相关事件
    // 指代触发MH事件的Frame
    function MHEvent_GetFrame takes nothing returns integer
    endfunction

    // 设置事件Frame
    // @Tip：响应MH的部分事件
    // 指代触发MH事件的Frame
    function MHEvent_SetFrame takes integer frame returns nothing
    endfunction







//==================================================================================
//
// [Frame] frame.j 
//
//==================================================================================



// 基本库



    // 创建Frame
    // @param base_frame：填写fdf文件中的模板名
    // @param parent_frame：父级
    // @param priority：优先级
    function MHFrame_Create takes string base_frame, integer parent_frame, integer priority, integer id returns integer
    endfunction

    // 创建Frame
    // @Tip：该函数创建的Frame无法按名字搜索到
    // @param type_name：填写fdf关键字中的类型名
    // @param name：此处可自定义
    // @param base_frame：填写fdf文件中的模板名
    // @param parent_frame：父级
    // @param priority：优先级
    function MHFrame_CreateEx takes string type_name, string name, string base_frame, integer parent_frame,  integer priority, integer id returns integer
    endfunction

    // 创建SimpleFrame
    // @param base_frame：填写fdf文件中的模板名
    // @param parent_frame：父级
    function MHFrame_CreateSimple takes string base_frame, integer parent_frame, integer id returns integer
    endfunction

    // 创建PortraitButton
    // @Tip：原生大头像，可用于显示模型
    // @param parent_frame：父级
    function MHFrame_CreatePortrait takes integer parent_frame returns integer
    endfunction

    // 创建CSimpleTexture
    // @Tip：该类型的Frame不能有子级
    // @param parent_frame：父级
    function MHFrame_CreateSimpleTexture takes integer parent_frame returns integer
    endfunction

    // 创建CSimpleFontString
    // @Tip：该类型的Frame不能有子级
    // @param parent_frame：父级
    function MHFrame_CreateSimpleFontString takes integer parent_frame returns integer
    endfunction

    // 获取Frame
    // @Tip：按名字搜索Frame
    // 仅能搜索fdf文件中定义的frame
    function MHFrame_GetByName takes string name, integer id returns integer
    endfunction

    // 获取鼠标指向的Frame
    function MHFrame_GetUnderCursor takes nothing returns integer
    endfunction

    // 加载TOC文件
    function MHFrame_LoadTOC takes string file_path returns nothing
    endfunction

    // 删除
    function MHFrame_Destroy takes integer frame returns nothing
    endfunction

    // 更新
    function MHFrame_Update takes integer frame returns nothing
    endfunction

    // 点击
    // @Tip：对BUTTON类生效，包括SIMPLEBUTTON
    function MHFrame_Click takes integer frame returns nothing
    endfunction

    // 获取父级
    function MHFrame_GetParent takes integer frame returns integer
    endfunction

    // 设置父级
    function MHFrame_SetParent takes integer frame, integer parent_frame returns nothing
    endfunction

    // 获取子级数量
    function MHFrame_GetChildCount takes integer frame returns integer
    endfunction

    // 获取子级
    function MHFrame_GetChild takes integer frame, integer index returns integer
    endfunction

    // 获取名字
    function MHFrame_GetName takes integer frame returns string
    endfunction

    // 隐藏Frame
    // @param is_hide：true - 隐藏; false - 显示
    function MHFrame_Hide takes integer frame, boolean is_hide returns nothing
    endfunction

    // frame被隐藏
    function MHFrame_IsHidden takes integer frame returns boolean
    endfunction

    // 禁用Frame
    // @param is_disable：true - 禁用; false - 启用
    function MHFrame_Disable takes integer frame, boolean is_disable returns nothing
    endfunction

    // 获取LayerStyle
    function MHFrame_GetLayerStyle takes integer frame returns integer
    endfunction

    // 设置LayerStyle
    // @param style：LAYER_STYLE
    function MHFrame_SetLayerStyle takes integer frame, integer style returns nothing
    endfunction

    // 设置优先级
    function MHFrame_SetPriority takes integer frame, integer priority returns nothing
    endfunction

    // 设置透明度
    function MHFrame_SetAlpha takes integer frame, integer alpha returns nothing
    endfunction

    // 获取锚点类型
    // @Tip：返回0 - 绝对锚点; 返回1 - 相对锚点; 返回2 - 参数错误或无锚点
    // @param point：锚点。ANCHOR
    function MHFrame_GetPointType takes integer frame, integer point returns integer
    endfunction

    // 设置绝对锚点
    // @param point：锚点。ANCHOR
    // @param x：屏幕x坐标。取值范围 0~0.8
    // @param y：屏幕y坐标。取值范围 0~0.6
    function MHFrame_SetAbsolutePoint takes integer frame, integer point, real x, real y returns nothing
    endfunction

    // 获取绝对锚点X偏移
    // @Tip：该锚点是绝对锚点的时候才会起效
    // @param point：锚点。ANCHOR
    function MHFrame_GetAbsolutePointX takes integer frame, integer point returns real
    endfunction

    // 获取绝对锚点Y偏移
    // @Tip：该锚点是绝对锚点的时候才会起效
    // @param point：锚点。ANCHOR
    function MHFrame_GetAbsolutePointY takes integer frame, integer point returns real
    endfunction

    // 设置相对锚点
    // @Tip：设置 frame 的 point 锚点相对于 relative_frame 的 relative_point 锚点的偏移为 (x, y)
    // @param point：锚点。ANCHOR
    // @param relative_frame：相对参照的Frame
    // @param relative_point：相对参照Frame的锚点
    // @param point：锚点。ANCHOR
    // @param x：屏幕x坐标。取值范围 0~0.8
    // @param y：屏幕y坐标。取值范围 0~0.6
    function MHFrame_SetRelativePoint takes integer frame, integer point, integer relative_frame, integer relative_point, real x, real y returns nothing
    endfunction

    // 获取相对锚点Frame
    // @Tip：该锚点是相对锚点的时候才会起效
    // 指代相对参照的那个Frame
    // @param point：锚点。ANCHOR
    function MHFrame_GetRelativeFrame takes integer frame, integer point returns integer
    endfunction

    // 获取相对锚点
    // @Tip：该锚点是相对锚点的时候才会起效
    // 指代相对参照的那个Frame的锚点
    // @param point：锚点。ANCHOR
    function MHFrame_GetRelativePoint takes integer frame, integer point returns integer
    endfunction

    // 获取相对锚点X偏移
    // @Tip：该锚点是相对锚点的时候才会起效
    // 指代相对参照的那个Frame的锚点的X轴偏移
    // @param point：锚点。ANCHOR
    function MHFrame_GetRelativePointX takes integer frame, integer point returns real
    endfunction

    // 获取相对锚点Y偏移
    // @Tip：该锚点是相对锚点的时候才会起效
    // 指代相对参照的那个Frame的锚点的Y轴偏移
    // @param point：锚点。ANCHOR
    function MHFrame_GetRelativePointY takes integer frame, integer point returns real
    endfunction

    // 设置所有锚点
    // @Tip：例如将一个BACKDROP的所有锚点设置到BUTTON的锚点上，则BUTTON更改大小时BACKDROP也会跟随它改变
    // 这时MHFrame_SetSize不再起效
    function MHFrame_SetAllPoints takes integer frame, integer relative_frame returns nothing
    endfunction

    // 清除所有锚点
    function MHFrame_ClearAllPoints takes integer frame returns nothing
    endfunction

    // 判定点在frame内
    // @param x：点的屏幕x坐标
    // @param y：点的屏幕y坐标
    function MHFrame_InFrame takes real x, real y, integer frame returns boolean
    endfunction

    // 获取frame的下边界坐标
    // @Tip：屏幕坐标
    function MHFrame_GetBorderBottom takes integer frame returns real
    endfunction

    // 获取frame的左边界坐标
    // @Tip：屏幕坐标
    function MHFrame_GetBorderLeft takes integer frame returns real
    endfunction

    // 获取frame的上边界坐标
    // @Tip：屏幕坐标
    function MHFrame_GetBorderTop takes integer frame returns real
    endfunction

    // 获取frame的右边界坐标
    // @Tip：屏幕坐标
    function MHFrame_GetBorderRight takes integer frame returns real
    endfunction

    // 设置宽度
    // @param width：宽度。屏幕坐标
    function MHFrame_SetWidth takes integer frame, real width returns nothing
    endfunction

    // 获取宽度
    function MHFrame_GetWidth takes integer frame returns real
    endfunction

    // 设置高度
    // @param height：高度。屏幕坐标
    function MHFrame_SetHeight takes integer frame, real height returns nothing
    endfunction

    // 获取高度
    function MHFrame_GetHeight takes integer frame returns real
    endfunction

    // 设置尺寸
    // @param width：宽度。屏幕坐标
    // @param height：高度。屏幕坐标
    function MHFrame_SetSize takes integer frame, real width, real height returns nothing
    endfunction

    // 设置缩放
    function MHFrame_SetScale takes integer frame, real scale returns nothing
    endfunction

    // 设置颜色
    // @Tip：仅对CSimpleFontString, CSimpleTexture和CTextFrame有效
    // @param color：16进制颜色代码
    function MHFrame_SetColor takes integer frame, integer color returns nothing
    endfunction

    // 设置颜色
    // @Tip：仅对CSimpleFontString, CSimpleTexture和CTextFrame有效
    // 各颜色值取值范围为 0~255
    function MHFrame_SetColorEx takes integer frame, integer alpha, integer red, integer green, integer blue returns nothing
    endfunction

    // 设置贴图
    // @Tip：仅对CBackdropFrame, CSimpleTexture和CSimpleStatusBar有效
    // @param texture_path：贴图路径
    // @param is_tile：是否平铺
    function MHFrame_SetTexture takes integer frame, string texture_path, boolean is_tile returns nothing
    endfunction

    // 设置模型
    // @Tip：仅对CModelFrame, CSpriteFrame和CStatBar有效
    // @param model_path：模型路径
    // @param model_type：一般填0
    // @param flag：未知参数，一般填0
    function MHFrame_SetModel takes integer frame, string model_path, integer model_type, integer flag returns nothing
    endfunction

    // 设置字体
    // @Tip：仅对CEditBox, CSimpleFontString和CSimpleMessageFrame有效
    // @param font_path：字体路径 填MPQ的Fonts路径下的资源例如Fonts\DFHeiMd.ttf，或者自定义字体
    // @param height：字体大小
    // @param flag：未知参数，一般填0
    function MHFrame_SetFont takes integer frame, string font_path, real height, integer flag returns nothing
    endfunction

    // 设置字体大小
    // @Tip：仅支持CTextFrame和CSimpleFontString
    // 需要先设置字体才行
    function MHFrame_SetFontHeight takes integer frame, real height returns nothing
    endfunction

    // 设置文本
    // @Tip：仅对CEditBox, CSlashChatBox, CGlueEditBoxWar3, 
    // CSimpleFontString, CTextArea, CTextFrame, 
    // CTextButtonFrame, CTimerTextFrame和CGlueTextButtonWar3有效
    function MHFrame_SetText takes integer frame, string text returns nothing
    endfunction

    // 获取文本
    // @Tip：仅对CEditBox, CSimpleFontString, CTextArea和CTextFrame有效
    function MHFrame_GetText takes integer frame returns string
    endfunction

    // 设置文本限制
    function MHFrame_SetTextLimit takes integer frame, integer length returns nothing
    endfunction

    // 获取文本限制
    function MHFrame_GetTextLimit takes integer frame returns integer
    endfunction

    // 设置文本对齐
    // @param vertex_align：TEXT_VERTEX_ALIGN
    // @param horizon_align：TEXT_HORIZON_ALIGN
    function MHFrame_SetTextAlign takes integer frame, integer vertex_align, integer horizon_align returns nothing
    endfunction

    // 设置数值
    // @Tip：仅对CSlider, CSimpleStatusBar和CStatBar有效
    function MHFrame_SetValue takes integer frame, real value returns nothing
    endfunction

    // 获取数值
    // @Tip：仅对CSlider, CSimpleStatusBar和CStatBar有效
    function MHFrame_GetValue takes integer frame returns real
    endfunction

    // 设置数值限制
    // @Tip：仅对CSlider, CSimpleStatusBar和CStatBar有效
    // @param max_limit：最大数值
    // @param min_limit：最小数值
    function MHFrame_SetLimit takes integer frame, real max_limit, real min_limit returns nothing
    endfunction

    // 限制鼠标
    // @Tip：未发现作用
    function MHFrame_CageMouse takes integer frame, boolean flag returns nothing
    endfunction

    // 获取SimpleButton贴图
    // @Tip：仅对CSimpleButton有效
    // 返回一个CSimpleTexture
    // @param state：按钮状态。SIMPLEBUTTON_STATE
    function MHFrame_GetSimpleButtonTexture takes integer button_frame, integer state returns integer
    endfunction

    // 获取SimpleButton附加显示物
    // @Tip：仅对CSimpleButton有效
    // 指鼠标指向按钮时附加显示的frame。例如鼠标指向顶部按钮时会显示其高光贴图
    function MHFrame_GetSimpleButtonAdditiveFrame takes integer button_frame returns integer
    endfunction

    // 设置SimpleButton状态
    // @Tip：仅对CSimpleButton有效
    // @param state：按钮状态。SIMPLEBUTTON_STATE
    function MHFrame_SetSimpleButtonState takes integer button_frame, integer state returns nothing
    endfunction

    // 获取SimpleTexture的混合模式
    // @Tip：仅对CSimpleTexture有效
    function MHFrame_GetSimpleTextureBlendMode takes integer texture_frame returns blendmode
    endfunction

    // 设置SimpleTexture的混合模式
    // @Tip：仅对CSimpleTexture有效
    function MHFrame_SetSimpleTextureBlendMode takes integer texture_frame, blendmode blend_mode returns nothing
    endfunction

    // TextArea添加文本
    // @Tip：仅对CTextArea有效
    function MHFrame_AddTextAreaText takes integer text_area, string text returns nothing
    endfunction

    // 获取SpriteFrame坐标X
    // @Tip：仅对CSpriteFrame有效
    function MHFrame_GetSpriteX takes integer frame returns real
    endfunction

    // 获取SpriteFrame坐标Y
    // @Tip：仅对CSpriteFrame有效
    function MHFrame_GetSpriteY takes integer frame returns real
    endfunction

    // 获取SpriteFrame坐标Z
    // @Tip：仅对CSpriteFrame有效
    function MHFrame_GetSpriteZ takes integer frame returns real
    endfunction

    // 设置SpriteFrame坐标X
    // @Tip：仅对CSpriteFrame有效
    function MHFrame_SetSpriteX takes integer frame, real x returns nothing
    endfunction

    // 设置SpriteFrame坐标Y
    // @Tip：仅对CSpriteFrame有效
    function MHFrame_SetSpriteY takes integer frame, real y returns nothing
    endfunction

    // 设置SpriteFrame坐标Z
    // @Tip：仅对CSpriteFrame有效
    function MHFrame_SetSpriteZ takes integer frame, real z returns nothing
    endfunction

    // 设置SpriteFrame三轴坐标
    // @Tip：仅对CSpriteFrame有效
    function MHFrame_SetSpritePosition takes integer frame, real x, real y, real z returns nothing
    endfunction

    // 设置SpriteFrame横滚角
    // @Tip：仅对CSpriteFrame有效。绕X转角, 角度制
    function MHFrame_SetSpriteRoll takes integer frame, real roll returns nothing
    endfunction

    // 设置SpriteFrame俯仰角
    // @Tip：仅对CSpriteFrame有效。绕X转角, 角度制
    function MHFrame_SetSpritePitch takes integer frame, real pitch returns nothing
    endfunction

    // 设置SpriteFrame偏航角
    // @Tip：仅对CSpriteFrame有效。绕X转角, 角度制
    function MHFrame_SetSpriteYaw takes integer frame, real yaw returns nothing
    endfunction

    // 设置SpriteFrame缩放
    // @Tip：仅对CSpriteFrame有效
    function MHFrame_SetSpriteScale takes integer sprite_frame, real scale returns nothing
    endfunction

    // 设置SpriteFrame三轴缩放
    // @Tip：仅对CSpriteFrame有效
    function MHFrame_SetSpriteScaleEx takes integer sprite_frame, real x_scale, real y_scale, real z_scale returns nothing
    endfunction

    // 设置SpriteFrame颜色
    // @Tip：仅对CSpriteFrame有效
    function MHFrame_SetSpriteColor takes integer frame, real color returns nothing
    endfunction

    // 设置SpriteFrame动画
    function MHFrame_SetSpriteAnimation takes integer frame, string anim, string attach returns nothing
    endfunction

    // 设置SpriteFrame动画进度
    function MHFrame_SetSpriteAnimationProgress takes integer frame, real progress returns nothing
    endfunction

    // 获取SpriteFrame动画进度
    function MHFrame_GetSpriteAnimationProgress takes integer frame returns real
    endfunction

    // 设置SpriteFrame的贴图
    function MHFrame_SetSpriteTexture takes integer frame, string texture, integer id returns nothing
    endfunction

    // 设置PortraitButton模型
    function MHFrame_SetPortraitModel takes integer frame, string model, playercolor color returns nothing
    endfunction

    // 设置PortraitButton镜头位置
    function MHFrame_SetPortraitCameraPosition takes integer frame, real x, real y, real z returns nothing
    endfunction

    // 设置PortraitButton镜头焦点
    function MHFrame_SetPortraitCameraFocus takes integer frame, real x, real y, real z returns nothing
    endfunction



// Hook库



    // 设置屏幕限制
    // @param is_limit：true - 限制在屏幕内; false - 不限制在屏幕内
    function MHFrame_SetScreenLimit takes boolean is_limit returns boolean
    endfunction



// 事件库



    // 注册Frame事件
    // @Tip：EVENT_ID_FRAME_MOUSE_ENTER ~ EVENT_ID_FRAME_MOUSE_DOUBLECLICK
    // 为 frame 注册 event_id
    // @param event_id：frame事件ID。EVENT_ID_FRAME
    function MHFrameEvent_Register takes trigger trig, integer frame, integer event_id returns nothing
    endfunction

    // 注销Frame事件
    // @Tip：为 frame 注销 event_id
    // @param event_id：frame事件ID。EVENT_ID_FRAME
    function MHFrameEvent_Remove takes integer frame, integer event_id returns boolean
    endfunction

    // 注销Frame所有事件
    function MHFrameEvent_RemoveAll takes integer frame returns boolean
    endfunction

    // 获取滚动值
    // @Tip：响应 鼠标滚动Frame 事件
    function MHFrameScrollEvent_GetValue takes nothing returns integer
    endfunction

    // 设置滚动值
    // @Tip：响应 鼠标滚动Frame 事件
    function MHFrameScrollEvent_SetValue takes integer value returns nothing
    endfunction







//==================================================================================
//
// [游戏UI] game_ui.j 
//
//==================================================================================



// 基本库



    // 获取GameUI
    function MHUI_GetGameUI takes nothing returns integer
    endfunction

    // 获取ConsoleUI
    // @Tip：即游戏控制台
    // 实际上是一个CSimpleConsole
    function MHUI_GetConsoleUI takes nothing returns integer
    endfunction

    // 获取控制台贴图
    // @Tip：控制台一共9个贴图
    // 返回一个CSimpleTexture
    // @param index：贴图序号 1~9
    function MHUI_GetConsoleTexture takes integer index returns integer
    endfunction

    // 获取资源栏贴图
    // @Tip：返回一个CSimpleTexture
    // @param index：贴图序号 1~3。对应黄金消耗、木材消耗、人口消耗
    function MHUI_GetResourceBarTexture takes integer index returns integer
    endfunction

    // 获取fps控件
    // @Tip：返回一个CSimpleFontString
    function MHUI_GetFpsFrame takes nothing returns integer
    endfunction

    // 获取fps
    function MHUI_GetFps takes nothing returns real
    endfunction

    // 获取提示工具
    // @Tip：控制台最后两个子级之一
    // 其右下锚点跟随控制台的右下锚点偏移 (0, 0.1625)
    function MHUI_GetUberToolTip takes nothing returns integer
    endfunction

    // 获取提示工具对应的Frame
    // @Tip：指提示工具对应的Frame
    // 返回一个CCommandButton、CBuffIndicator等
    function MHUI_GetUberToolTipTarget takes nothing returns integer
    endfunction

    // 获取提示工具的图标
    // @Tip：指魔耗、黄金消耗、木材消耗等的图标，按从左到右排列
    // @param index：序号。1~4
    function MHUI_GetUberToolTipIcon takes integer index returns integer
    endfunction

    // 获取物体头顶提示
    // @Tip：控制台最后两个子级之一
    // 其底部锚点跟随单位血条的顶部锚点偏移 (0, 0.002)
    function MHUI_GetUnitTip takes nothing returns integer
    endfunction

    // 获取CWordlFrameWar3
    function MHUI_GetWorldFrameWar3 takes nothing returns integer
    endfunction

    // 获取建造指示器
    function MHUI_GetBuildFrame takes nothing returns integer
    endfunction

    // 获取时钟
    // @Tip：实际上是一个CSpriteFrame
    function MHUI_GetTimeIndicator takes nothing returns integer
    endfunction

    // 获取物品栏文本
    // @Tip：物品栏那三个字
    // 实际上是一个CSimpleFontString
    function MHUI_GetInventoryText takes nothing returns integer
    endfunction

    // 获取物品栏遮罩
    // @Tip：对于没有物品栏的单位就会显示遮罩而非物品栏
    // 实际上是一个CSimpleFrame
    function MHUI_GetInventoryCover takes nothing returns integer
    endfunction

    // 获取物品栏遮罩贴图
    // @Tip：返回一个CSimpleTexture
    function MHUI_GetInventoryTexture takes nothing returns integer
    endfunction

    // 获取状态栏
    // @Tip：该Frame的8个子级即为魔法效果图标
    function MHUI_GetBuffBar takes nothing returns integer
    endfunction

    // 获取状态栏文本
    // @Tip：实际上是一个CSimpleFontString
    function MHUI_GetBuffBarText takes nothing returns integer
    endfunction

    // 获取状态指示器
    // @Tip：魔法效果图标
    function MHUI_GetBuffIndicator takes integer index returns integer
    endfunction

    // 获取CMiniMap
    // @Tip：小地图
    function MHUI_GetMiniMap takes nothing returns integer
    endfunction

    // 刷新小地图
    // @Tip：可更新小地图的点击框和贴图位置。坐标为屏幕坐标
    function MHUI_UpdateMiniMap takes real min_x, real min_y, real max_x, real max_y returns boolean
    endfunction

    // 获取小地图信号按钮(SimpleButton)
    function MHUI_GetMiniMapSignalButton takes nothing returns integer
    endfunction

    // 获取小地图地形按钮(SimpleButton)
    function MHUI_GetMiniMapTerrainButton takes nothing returns integer
    endfunction

    // 获取小地图队伍颜色按钮(SimpleButton)
    function MHUI_GetMiniMapColorButton takes nothing returns integer
    endfunction
    
    // 获取小地图生物营地按钮(SimpleButton)
    function MHUI_GetMiniMapCreepButton takes nothing returns integer
    endfunction

    // 获取小地图队形按钮(SimpleButton)
    function MHUI_GetMiniMapFormationButton takes nothing returns integer
    endfunction

    // 获取CCommandBar
    // @Tip：技能栏 + 物品栏
    function MHUI_GetCommandBar takes nothing returns integer
    endfunction

    // 获取技能栏的按钮
    // @param index：按钮序号。取值范围为 1~12 (SimpleButton)
    function MHUI_GetSkillBarButton takes integer index returns integer
    endfunction

    // 获取技能栏的按钮
    // @param x：按钮X坐标，取值范围为 0~3
    // @param y：按钮Y坐标，取值范围为 0~2 (SimpleButton)
    function MHUI_GetSkillBarButtonEx takes integer x, integer y returns integer
    endfunction

    // 获取物品栏的按钮
    // @param index：按钮序号。取值范围为 1~6 (SimpleButton)
    function MHUI_GetItemBarButton takes integer index returns integer
    endfunction

    // 获取CHeroBar
    // @Tip：英雄按钮栏
    function MHUI_GetHeroBar takes nothing returns integer
    endfunction

    // 获取CHeroBar按钮
    // @Tip：英雄按钮
    // @param index：按钮序号。取值范围 1~7
    function MHUI_GetHeroBarButton takes integer index returns integer
    endfunction

    // 获取英雄按钮血条
    // @Tip：英雄按钮下方的血条
    function MHUI_GetHeroButtonHPBar takes integer hero_button returns integer
    endfunction

    // 获取英雄按钮蓝条
    // @Tip：英雄按钮下方的蓝条
    function MHUI_GetHeroButtonMPBar takes integer hero_button returns integer
    endfunction

    // 获取英雄按钮下标方框
    // @Tip：英雄按钮右下角技能点数字方框
    function MHUI_GetHeroButtonSubscriptFrame takes integer hero_button returns integer
    endfunction

    // 获取英雄按钮下标文本
    // @Tip：英雄按钮右下角技能点数字文本
    function MHUI_GetHeroButtonSubscriptText takes integer hero_button returns integer
    endfunction

    // 获取英雄按钮流光
    // @Tip：英雄按钮有技能点时的流光模型
    function MHUI_GetHeroButtonStreamer takes integer hero_button returns integer
    endfunction

    // 获取CPeonBar
    // @Tip：闲置农民按钮栏
    function MHUI_GetPeonBar takes nothing returns integer
    endfunction

    // 获取CPeonBarButton
    // @Tip：闲置农民按钮 (SimpleButton)
    function MHUI_GetPeonBarButton takes nothing returns integer
    endfunction

    // 获取CPortraitButton
    // @Tip：肖像(Frame) 可以用在调起指示器/选择器时 对肖像Frame使用MHFrame_Click来达到对自己施法的效果
    function MHUI_GetPortraitButton takes nothing returns integer
    endfunction

    // 获取肖像单位
    // @Tip：当前肖像单位
    function MHUI_GetPortraitButtonUnit takes nothing returns unit
    endfunction

    // 获取肖像的血量文本
    // @Tip：肖像下方的血量文本
    // 实际上是一个CSimpleFontString
    function MHUI_GetPortraitButtonHPText takes nothing returns integer
    endfunction

    // 获取肖像的蓝量文本
    // @Tip：肖像下方的蓝量文本
    // 实际上是一个CSimpleFontString
    function MHUI_GetPortraitButtonMPText takes nothing returns integer
    endfunction

    // 获取鼠标
    // @Tip：实际上是一个CSpriteFrame
    function MHUI_GetCursorFrame takes nothing returns integer
    endfunction

    // 设置鼠标模型
    function MHUI_SetCursorModel takes string model_path returns nothing
    endfunction

    // 设置鼠标拿起物品时的图标
    // @Tip：会直接改变鼠标的动画
    function MHUI_SetCursorItemIcon takes string texture_path returns nothing
    endfunction

    // 获取聊天框
    function MHUI_GetChatEditBar takes nothing returns integer
    endfunction

    // 聊天框打开
    function MHUI_IsChatEditBarOn takes nothing returns boolean
    endfunction

    // 模拟玩家聊天
    // @param player：发送聊天信息的玩家
    // @param channel：聊天频道。CHAT_CHANNEL
    function MHUI_SendPlayerChat takes player p, string msg, real dur, integer channel returns nothing
    endfunction

    // 发送聊天信息
    function MHUI_SendChatMessage takes string msg, real dur, integer color returns nothing
    endfunction

    // 发送错误信息
    // @Tip：配合播放错误音效和本地事件来可以达到自定义目标允许
    function MHUI_SendErrorMessage takes string msg, real dur, integer color returns nothing
    endfunction

    // 发送维护费用信息
    function MHUI_SendUpKeepMessage takes string msg, real dur, integer color returns nothing
    endfunction

    // 播放原生音效
    // @param label：标签。参考War3.mpq中UI\SoundInfo文件夹下的文件。也可参考物编中的声音字段
    function MHUI_PlayNativeSound takes string label returns nothing
    endfunction

    // 播放错误音效
    function MHUI_PlayErrorSound takes nothing returns nothing
    endfunction



// Hook库



    // 绘制攻击速度
    // @param is_draw：true - 绘制; false - 不绘制
    function MHUI_DrawAttackSpeed takes boolean is_draw returns nothing
    endfunction

    // 绘制移动速度
    // @param is_draw：true - 绘制; false - 不绘制
    function MHUI_DrawMoveSpeed takes boolean is_draw returns nothing
    endfunction



// 事件库



    // 注册帧绘制事件
    // @Tip：EVENT_ID_FRAME_TICK
    // 本地玩家每帧绘制时
    function MHUITickEvent_Register takes trigger trig returns nothing
    endfunction

    // 注册血条刷新事件
    function MHUIHPBarEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取刷新的血条
    // @Tip：CStatBar，也是CSimpleStatusBar
    // 等价于 MHEvent_GetFrame
    function MHUIHPBarEvent_GetHPBar takes nothing returns integer
    endfunction

    // 获取刷新血条的单位
    // @Tip：等价于 MHEvent_GetUnit
    function MHUIHPBarEvent_GetUnit takes nothing returns unit
    endfunction

    // 获取刷新血条的锚点
    // @Tip：绝对锚点。固定返回ANCHOR_TOP
    function MHUIHPBarEvent_GetPoint takes nothing returns integer
    endfunction

    // 获取刷新血条的X偏移
    // @Tip：绝对锚点
    function MHUIHPBarEvent_GetX takes nothing returns real
    endfunction

    // 设置刷新血条的X偏移
    // @param x：绝对锚点X偏移
    function MHUIHPBarEvent_SetX takes real x returns nothing
    endfunction

    // 获取刷新血条的Y偏移
    // @Tip：绝对锚点
    function MHUIHPBarEvent_GetY takes nothing returns real
    endfunction

    // 设置刷新血条的Y偏移
    // @param y：绝对锚点Y偏移
    function MHUIHPBarEvent_SetY takes real x returns nothing
    endfunction

    // 注册渲染事件
    // @Tip：EVENT_ID_RENDER
    function MHUIRenderEvent_Register takes trigger trig returns nothing
    endfunction



// System库



    // 允许绘制蓝条
    // @param is_enable：true - 允许; false - 禁止
    function MHUI_EnableDrawMPBar takes boolean is_enable returns nothing
    endfunction

    // 仅绘制盟友的蓝条
    // @param is_only：true - 仅绘制盟友的; false - 绘制所有人的
    function MHUI_OnlyDrawAllyMPBar takes boolean is_only returns nothing
    endfunction

    // 绘制英雄等级
    // @param is_draw：true - 绘制英雄等级; false - 不绘制英雄等级
    function MHUI_MPBarDrawHeroLevel takes boolean is_draw returns nothing
    endfunction

    // 修复叠字
    // @Tip：并非缩放窗口
    function MHUI_FixGarbled takes boolean is_enable returns nothing
    endfunction






    
//==================================================================================
//
// [UI数据] game_ui_data.j 
//
//==================================================================================



// 基本库



    // 获取状态指示器的Buff
    // @param index：序号1~8
    function MHUIData_GetBuffIndicatorBuff takes integer index returns integer
    endfunction

    // 获取CTargetMode的技能
    // @Tip：选择目标的时候改结构中会存储技能id
    function MHUIData_GetTargetModeAbility takes nothing returns integer
    endfunction

    // 获取CTargetMode的命令
    // @Tip：选择目标的时候该结构中会存储命令id
    function MHUIData_GetTargetModeOrder takes nothing returns integer
    endfunction

    // 获取CTargetMode的目标单位
    // @Tip：选择目标的时候该结构中会存储目标单位
    function MHUIData_GetTargetModeUnit takes nothing returns unit
    endfunction

    // 获取CTargetMode的目标物品
    // @Tip：选择目标的时候该结构中会存储目标物品
    function MHUIData_GetTargetModeItem takes nothing returns item
    endfunction

    // 获取CTargetMode的目标可破坏物
    // @Tip：选择目标的时候该结构中会存储目标可破坏物
    function MHUIData_GetTargetModeDest takes nothing returns destructable
    endfunction

    // 获取CTargetMode的释放类型
    // @Tip：选取目标的时候该结构中会存储释放类型
    function MHUIData_GetTargetModeCastType takes nothing returns integer
    endfunction

    // 获取CSelectMode的目标单位
    // @Tip：选择目标的时候该结构中会存储目标单位
    function MHUIData_GetSelectModeUnit takes nothing returns unit
    endfunction

    // 获取CSelectMode的目标物品
    // @Tip：选择目标的时候该结构中会存储目标物品
    function MHUIData_GetSelectModeItem takes nothing returns item
    endfunction

    // 获取CSelectMode的目标可破坏物
    // @Tip：选择目标的时候该结构中会存储目标可破坏物
    function MHUIData_GetSelectModeDest takes nothing returns destructable
    endfunction

	// 获取CBuildFrame的单位类型
    // @Tip：选择建造位置的时候该结构中会存储建筑的单位类型
    function MHUIData_GetBuildFrameUnitId takes nothing returns integer
    endfunction

	// 获取CBuildFrame的模型坐标X
    // @Tip：选择建造位置的时候该结构中会存储建筑的模型坐标点X
    function MHUIData_GetBuildFrameSpriteX takes nothing returns real
    endfunction

	// 获取CBuildFrame的模型坐标Y
    // @Tip：选择建造位置的时候该结构中会存储建筑的模型坐标点Y
    function MHUIData_GetBuildFrameSpriteY takes nothing returns real
    endfunction

	// 获取CBuildFrame的建造者
    // @Tip：选择建造位置的时候该结构中会存储建筑的建造者
    function MHUIData_GetBuildFrameBuilder takes nothing returns unit
    endfunction

	// 获取CBuildFrame的建造技能
    // @Tip：选择建造位置的时候该结构中会存储建造者的建造技能
    function MHUIData_GetBuildFrameBuildAbility takes nothing returns integer
    endfunction

    // 获取CCommandButton的冷却模型
    // @Tip：实际上是一个CSpriteFrame
    function MHUIData_GetCommandButtonCooldownFrame takes integer command_button returns integer
    endfunction

    // 获取CCommandButton的流光模型
    // @Tip：实际上是一个CSpriteFrame
    function MHUIData_GetCommandButtonStreamFrame takes integer command_button returns integer
    endfunction

    // 获取CCommandButton的技能ID
    // @Tip：仅对CCommandButton起效
    // CommandButton的AbilityId会有特殊情况，以下情况时，OrderId为目标Id
    // 学习技能时     AbilityId = 'AHer'; OrderId = 要学习的技能
    // 购买单位时     AbilityId = 'Asel'; OrderId = 要购买的单位...下面以此类推
    // 购买中立物品时 AbilityId = 'Asei'
    // 购买友军物品时 AbilityId = 'Amai'
    // 升级建筑时     AbilityId = 'Aupg'
    // 训练/研究时    AbilityId = 'Aque'
    // 建造建筑时     AbilityId = 建造的技能Id
    function MHUIData_GetCommandButtonAbility takes integer command_button returns integer
    endfunction

    // 获取CCommandButton的命令ID
    // @Tip：仅对CCommandButton起效
    function MHUIData_GetCommandButtonOrderId takes integer command_button returns integer
    endfunction

    // 获取CCommandButton的释放类型
    // @Tip：仅对CCommandButton起效
    function MHUIData_GetCommandButtonCastType takes integer command_button returns integer
    endfunction

    // 设置CCommandButton的释放类型
    // @Tip：仅对CCommandButton起效
    // @param cast_type：ABILITY_CAST_TYPE
    function MHUIData_SetCommandButtonCastType takes integer command_button, integer cast_type returns nothing
    endfunction

    // 获取CCommandButton的物品
    // @Tip：仅对物品栏中的CCommandButton起效
    function MHUIData_GetCommandButtonItem takes integer command_button returns item
    endfunction

    // 获取CCommandButton的提示
    // @Tip：仅对CCommandButton起效
    function MHUIData_GetCommandButtonTip takes integer command_button returns string
    endfunction

    // 获取CCommandButton的扩展提示
    // @Tip：仅对CCommandButton起效
    function MHUIData_GetCommandButtonUbertip takes integer command_button returns string
    endfunction

    // 获取CCommandButton的黄金消耗
    // @Tip：仅对CCommandButton起效
    function MHUIData_GetCommandButtonGoldCost takes integer command_button returns integer
    endfunction

    // 获取CCommandButton的木材消耗
    // @Tip：仅对CCommandButton起效
    function MHUIData_GetCommandButtonLumberCost takes integer command_button returns integer
    endfunction

    // 获取CCommandButton的魔法消耗
    // @Tip：仅对CCommandButton起效
    function MHUIData_GetCommandButtonManaCost takes integer command_button returns integer
    endfunction

    // 获取CCommandButton的人口消耗
    // @Tip：仅对CCommandButton起效
    function MHUIData_GetCommandButtonFoodCost takes integer command_button returns integer
    endfunction

    // 获取CCommandButton的快捷键
    // @Tip：仅对CCommandButton起效
    function MHUIData_GetCommandButtonHotkey takes integer command_button returns integer
    endfunction

    // 获取CCommandButton的X坐标
    // @Tip：仅对CCommandButton起效
    function MHUIData_GetCommandButtonX takes integer command_button returns integer
    endfunction

    // 获取CCommandButton的Y坐标
    // @Tip：仅对CCommandButton起效
    function MHUIData_GetCommandButtonY takes integer command_button returns integer
    endfunction

    // 设置CCommandButton的坐标
    // @Tip：仅对CCommandButton起效
    function MHUIData_SetCommandButtonXY takes integer command_button, integer x, integer y returns nothing
    endfunction

    // 获取CCommandButton的贴图路径
    // @Tip：仅对CCommandButton起效
    function MHUIData_GetCommandButtonTexture takes integer command_button returns string
    endfunction

    // 获取CCommandButton的当前冷却时间
    // @Tip：仅对CCommandButton起效
    function MHUIData_GetCommandButtonCooldown takes integer command_button returns real
    endfunction







//==================================================================================
//
// [MemHack] game.j 
//
//==================================================================================



// 基本库



    // 获取当前内存使用量
    // @Tip：单位是字节
    function MHGame_GetMemoryUsage takes nothing returns integer
    endfunction

    // 获取最大内存使用量
    // @Tip：单位是字节
    function MHGame_GetMemoryMaxUsage takes nothing returns integer
    endfunction

    // 获取游戏版本
    // @Tip：仅支持1.27a, 1.26a和1.24e
    function MHGame_GetGameVersion takes nothing returns string
    endfunction

    // 获取插件版本
    function MHGame_GetPluginVersion takes nothing returns string
    endfunction

    // 获取地图名字
    function MHGame_GetMapName takes nothing returns string
    endfunction

    // 获取地图描述
    function MHGame_GetMapDescription takes nothing returns string
    endfunction

    // 获取地图路径
    // @Tip：相对路径
    function MHGame_GetMapPath takes nothing returns string
    endfunction

    // 获取作弊标志
    // @Tip：BitSet。CHEAT_FLAG
    function MHGame_GetCheatFlag takes nothing returns integer
    endfunction

    // 设置作弊标志
    // @Tip：BitSet。CHEAT_FLAG
    // 局域网下依然有效
    function MHGame_SetCheatFlag takes integer flag returns nothing
    endfunction

    // 判定作弊标志
    // @param flag：CHEAT_FLAG
    function MHGame_IsCheatFlag takes integer flag returns boolean
    endfunction

    // 检查继承关系
    // @Tip：例如 '+w3u'(单位) 继承自 '+w3w'(Widget); 所有的被动技能都继承自 'APas'
    function MHGame_CheckInherit takes integer child_id, integer parent_id returns boolean
    endfunction

    // 获取Code
    function MHGame_GetCode takes string func_name returns code
    endfunction

    // 执行Code
    function MHGame_ExecuteCode takes code c returns integer
    endfunction

    // 执行Code
    // @Tip：使用C2I来转换code为整数，方便数组储存
    function MHGame_ExecuteCodeEx takes integer c returns integer
    endfunction

    // 执行Code
    function MHGame_ExecuteFunc takes string func_name returns integer
    endfunction

    // 删除模型缓存
    function MHGame_RemoveModelCache takes string model_path returns nothing
    endfunction

    // 获取Z轴坐标
    // @Tip：和获取点Z差不多，优点是快一点少创建一个点，异步值。
    // 注意可通行可破坏物会因为当前播放的动画改变所在点Z轴高度，不同客户端之间可破坏物动画不同步。
    // 不同客户端之间可破坏物动画不同步。
    function MHGame_GetAxisZ takes real x, real y returns real
    endfunction

    // 是局域网游戏
    function MHGame_IsLan takes nothing returns boolean
    endfunction

    // 是录像模式
    function MHGame_IsReplay takes nothing returns boolean
    endfunction



// Hook库



    // 禁止游戏暂停
    function MHGame_DisablePause takes boolean is_disable returns nothing
    endfunction



// 事件库



    // 注册游戏开始事件
    // @Tip：EVENT_ID_GAME_START
    // 指所有玩家都加载完毕进入地图的一瞬间 
    function MHGameStartEvent_Register takes trigger trig returns nothing
    endfunction

    // 注册游戏Tick事件
    // @Tip：EVENT_ID_GAME_TICK
    // 魔兽的同步帧
    function MHGameTickEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取同步帧经过的时间戳
    // @Tip：响应 游戏Tick 事件
    function MHGameTickEvent_GetStamp takes nothing returns integer
    endfunction

    // 注册游戏停止事件
    // @Tip：EVENT_ID_GAME_STOP
    // 异步事件仅支持触发器条件！
    function MHGameStopEvent_Register takes trigger trig returns nothing
    endfunction

    // 注册游戏退出事件
    // @Tip：EVENT_ID_GAME_EXIT
    // 异步事件仅支持触发器条件！
    function MHGameExitEvent_Register takes trigger trig returns nothing
    endfunction

    // 注册玩家异步事件
    // @Tip：EVENT_ID_GAME_EXIT
    // 异步事件仅支持触发器条件！
    function MHGameDesyncEvent_Register takes trigger trig returns nothing
    endfunction







//==================================================================================
//
// [单位组] group.j 
//
//==================================================================================



// 基本库



    // 获取单位数
    // @Tip：单位被删除 (RemoveUnit或尸体消失) 后仍然存在于单位组中
    // 此时获取到的单位数量不准确
    function MHGroup_GetSize takes group g returns integer
    endfunction

    // 获取有效单位数
    // @Tip：排除了被删除 (RemoveUnit或尸体消失) 的单位
    // 效率比 MHGroup_GetSize 略低
    function MHGroup_GetSizeEx takes group g returns integer
    endfunction

    // 单位组包含单位
    function MHGroup_ContainsUnit takes group g, unit u returns boolean
    endfunction

    // 获取单位组中单位
    // @Tip：获取指定序号的单位
    // 起始序号为1
    // @param index：序号起始
    function MHGroup_GetUnit takes group g, integer index returns unit
    endfunction

    // 获取随机单位
    function MHGroup_GetRandomUnit takes group g returns unit
    endfunction

    // 为单位组添加另一个单位组
    function MHGroup_AddGroup takes group this_group, group that_group returns boolean
    endfunction

    // 为单位组删除另一个单位组
    function MHGroup_RemoveGroup takes group this_group, group that_group returns boolean
    endfunction

    // 新建迭代器
    // @Tip：用于遍历单位组
    // 使用完后请删除，否则会造成内存泄漏
    function MHGroup_CreateIterator takes group g returns integer
    endfunction

    // 步进迭代器
    // @Tip：使迭代器指向下一个单位
    // @param it：单位组迭代器
    function MHGroup_SteppingIterator takes integer it returns integer
    endfunction

    // 获取迭代器指向的单位
    // @param it：单位组迭代器
    function MHGroup_GetIteratorUnit takes integer it returns unit
    endfunction

    // 迭代器失效
    // @Tip：用于判断遍历完成的依据
    // @param it：单位组迭代器
    function MHGroup_IteratorInvalid takes integer it returns boolean
    endfunction

    // 重置迭代器
    // @Tip：用于重复遍历单位组
    // 使迭代器指向单位组的起始位置
    // @param it：单位组迭代器
    function MHGroup_ResetIterator takes integer it returns nothing
    endfunction

    // 删除迭代器
    // @Tip：删除迭代器回收内存
    // @param it：单位组迭代器
    function MHGroup_DestroyIterator takes integer it returns nothing
    endfunction







//==================================================================================
//
// [物品] item.j 
//
//==================================================================================



// 基本库



    // 获取持有者
    function MHItem_GetOwner takes item it returns unit
    endfunction

    // 获取技能数量
    // @Tip：物品被持有后拥有的技能实例数量
    function MHItem_GetAbilityCount takes item it returns integer
    endfunction

    // 获取技能
    // @Tip：物品被持有后拥有的技能实例
    // 实际上技能存在于单位身上，可以使用 [单位技能] 里的函数操作
    function MHItem_GetAbility takes item it, integer index returns ability
    endfunction

    // 获取技能ID
    // @Tip：物品被持有后拥有的技能实例
    // 实际上技能存在于单位身上，可以使用 [单位技能] 里的函数操作
    function MHItem_GetAbilityId takes item it, integer index returns integer
    endfunction

    // 设置物品碰撞类型
    // @param to_other：UNIT_COLLISION_TYPE。自己碰撞别人时
    // @param from_other：UNIT_COLLISION_TYPE。别人碰撞自己时
    function MHItem_SetCollisionType takes item it, integer to_other, integer from_other returns nothing
    endfunction

    // 获取物编整数数据
    // @param flag：ITEM_DEF_DATA
    function MHItem_GetDefDataInt takes integer item_id, integer flag returns integer
    endfunction
    
    // 获取物编布尔值数据
    // @param flag：ITEM_DEF_DATA
    function MHItem_GetDefDataBool takes integer item_id, integer flag returns boolean
    endfunction

    // 获取物编字符串数据
    // @param flag：ITEM_DEF_DATA
    function MHItem_GetDefDataStr takes integer item_id, integer flag returns string
    endfunction

    // 设置物编整数数据
    // @param flag：ITEM_DEF_DATA
    function MHItem_SetDefDataInt takes integer item_id, integer flag, integer value returns nothing
    endfunction

    // 设置物编整数数据
    // @param flag：ITEM_DEF_DATA
    function MHItem_SetDefDataBool takes integer item_id, integer flag, boolean value returns nothing
    endfunction

    // 设置物编整数数据
    // @param flag：ITEM_DEF_DATA
    function MHItem_SetDefDataStr takes integer item_id, integer flag, string value returns nothing
    endfunction



// Hook库



    // 禁用预选UI
    // @Tip：指头顶提示
    function MHItem_DisablePreSelectUI takes item it, boolean is_disable returns nothing
    endfunction



// 事件库



    // 注册任意物品被删除事件
    // @Tip：EVENT_ID_ITEM_REMOVE
    function MHItemRemoveEvent_Register takes trigger trig returns nothing
    endfunction







//==================================================================================
//
// [数学] math.j 
//
//==================================================================================



// 基本库



    // 包含bit
    // @Tip：flag 包含 bit
    // 操作BitSet。例如0x7包含0x1，0x2和0x4
    // 等价于 (flag 按位与 bit) == bit
    function MHMath_IsBitSet takes integer flag, integer bit returns boolean
    endfunction

    // 添加bit
    // @Tip：为 flag 添加 bit
    // 操作BitSet。例如为0x6添加0x3结果为0x7
    // 等价于 flag 按位或 bit
    function MHMath_AddBit takes integer flag, integer bit returns integer
    endfunction

    // 删除bit
    // @Tip：为 flag 删除 bit
    // 操作BitSet。例如为0x6删除0x3结果为0x4
    // 等价于 flag 按位与 (按位取反 bit)
    function MHMath_RemoveBit takes integer flag, integer bit returns integer
    endfunction
    
    // 逻辑异或
    // @Tip：相同为真，不同为假
    function MHMath_Xor takes boolean op1, boolean op2 returns boolean
    endfunction

    // 按位取反
    // @Tip：二进制32位整数位运算
    // 例如： 按位取反 0 = 0xFFFFFFFF
    function MHMath_BitwiseNot takes integer op1 returns integer
    endfunction

    // 按位与
    // @Tip：二进制32位整数位运算
    // 例如：0x11451400 按位与 0xFF000000 = 0x11000000
    function MHMath_BitwiseAnd takes integer op1, integer op2 returns integer
    endfunction

    // 按位或
    // @Tip：二进制32位整数位运算
    // 例如：0x11000000 按位或 0x00451400 = 0x11451400
    function MHMath_BitwiseOr takes integer op1, integer op2 returns integer
    endfunction

    // 按位异或
    // @Tip：二进制32位整数位运算
    // 例如：0x11451400 按位异或 0x11451400 = 0
    function MHMath_BitwiseXor takes integer op1, integer op2 returns integer
    endfunction

    // 左移位
    // @Tip：二进制32位整数移位运算
    // op1 向左移动 op2 位
    // 例如：1 << 2 = 4 (0001 << 2 = 0100)
    // @param op1：操作数
    // @param op2：移位数
    function MHMath_LShift takes integer op1, integer op2 returns integer
    endfunction

    // 右移位
    // @Tip：二进制32位整数移位运算
    // op1 向右移动 op2 位
    // 例如：8 >> 3 = 1 (1000 >> 3 = 0001)
    // @param op1：操作数
    // @param op2：移位数
    function MHMath_RShift takes integer op1, integer op2 returns integer
    endfunction

    // 对数 (底数2)
    // @Tip：num 关于 2 的对数
    // 整数对数运算
    function MHMath_Log2 takes integer num returns integer
    endfunction

    // 取余
    function MHMath_ModI takes integer dividend, integer modulus returns integer
    endfunction

    // 取余
    function MHMath_ModF takes real dividend, real modulus returns real
    endfunction

    // 合成4Bytes
    // @Tip：例如将0x11，0x45，0x14，0x00合成0x11451400
    function MHMath_Get4Bytes takes integer byte_1, integer byte_2, integer byte_3, integer byte_4 returns integer
    endfunction

    // 转换整数为16进制字符串
    // @Tip：例如整数 0x11451400 转换为字符串 "11451400"
    // @param dec：十进制整数
    function MHMath_ToHex takes integer dec returns string
    endfunction

    // 转换16进制字符串为整数
    // @Tip：例如字符串 "11451400" 转换为整数 0x11451400
    // @param hex：16进制字符串
    function MHMath_ToDec takes string hex returns integer
    endfunction

    // 二阶贝塞尔动点坐标
    // @param start：起始点坐标
    // @param control：控制点坐标
    // @param end：中止点坐标
    // @param progress：进度，起始点进度为0，终止点进度为1
    function MHMath_Bezier2 takes real start, real control, real end, real progress returns real
    endfunction

    // 三阶贝塞尔动点坐标
    // @param start：起始点坐标
    // @param control1：控制点1坐标
    // @param control2：控制点2坐标
    // @param end：中止点坐标
    // @param progress：进度，起始点进度为0，终止点进度为1
    function MHMath_Bezier3 takes real start, real control1, real control2, real end, real progress returns real
    endfunction







//==================================================================================
//
// [Message] message.j 
//
//==================================================================================



// 基本库



    // 获取窗口宽度
    function MHMsg_GetWindowWidth takes nothing returns integer
    endfunction

    // 获取窗口高度
    function MHMsg_GetWindowHeight takes nothing returns integer
    endfunction

    // 设置窗口大小
    function MHMsg_SetWindowSize takes integer width, integer height returns boolean
    endfunction

    // 获取鼠标的屏幕坐标X
    function MHMsg_GetCursorX takes nothing returns real
    endfunction

    // 获取鼠标的屏幕坐标Y
    function MHMsg_GetCursorY takes nothing returns real
    endfunction

    // 获取鼠标的世界坐标X
    function MHMsg_GetMouseX takes nothing returns real
    endfunction

    // 获取鼠标的世界坐标Y
    function MHMsg_GetMouseY takes nothing returns real
    endfunction

    // 获取鼠标的世界坐标Z
    function MHMsg_GetMouseZ takes nothing returns real
    endfunction

    // 强制按键
    function MHMsg_PressKey takes integer key returns nothing
    endfunction

    // 按键是按下的
    function MHMsg_IsKeyDown takes integer key returns boolean
    endfunction

    // 世界坐标转屏幕坐标X
    function MHMsg_WorldToScreenX takes real x, real y, real z returns real
    endfunction

    // 世界坐标转屏幕坐标Y
    function MHMsg_WorldToScreenY takes real x, real y, real z returns real
    endfunction

    // 世界坐标转屏幕坐标缩放
    function MHMsg_WorldToScreenScale takes real x, real y, real z returns real
    endfunction

    // 屏幕坐标转世界坐标X
    function MHMsg_ScreenToWorldX takes real x, real y returns real
    endfunction

    // 屏幕坐标转世界坐标X
    function MHMsg_ScreenToWorldY takes real x, real y returns real
    endfunction

    // 世界坐标转小地图坐标X
    // @Tip：获取的结果是相对于小地图UI左下锚点的相对偏移
    function MHMsg_WorldToMinimapX takes real x returns real
    endfunction

    // 世界坐标转小地图坐标Y
    // @Tip：获取的结果是相对于小地图UI左下锚点的相对偏移
    function MHMsg_WorldToMinimapY takes real y returns real
    endfunction

    // 小地图坐标转世界坐标X
    // @Tip：填入的参数是相对于小地图UI左下锚点的相对偏移
    function MHMsg_MinimapToWorldX takes real x returns real
    endfunction

    // 小地图坐标转世界坐标Y
    // @Tip：填入的参数是相对于小地图UI左下锚点的相对偏移
    function MHMsg_MinimapToWorldY takes real y returns real
    endfunction

    // 坐标在屏幕内
    // @Tip：世界坐标
    function MHMsg_InScreen takes real x, real y returns boolean
    endfunction

    // 调起指示器/选择器
    // @Tip：强制调起指示器/选择器，进入选择目标模式
    // 需要拥有对应的技能。会触发 本地玩家调起指示器/选择器 事件
    // 调起基本命令时，技能id填0，如调起移动指示器：MHMsg_CallTargetMode(0, 0xD0032, 0x6)
    // @param aid：技能ID
    // @param oid：命令ID
    // @param flag：标志。BitSet。ABILITY_CAST_TYPE
    function MHMsg_CallTargetMode takes integer aid, integer oid, integer flag returns nothing
    endfunction

    // 调起指示器/选择器
    // @Tip：强制调起指示器/选择器，进入选择目标模式
    // 无需拥有对应的技能，但不一定能点下去。不会触发 本地玩家调起指示器/选择器 事件
    // 调起基本命令时，技能id填0，如调起移动指示器：MHMsg_CallTargetModeEx(0, 0xD0032, 0x6)
    // @param aid：技能ID
    // @param oid：命令ID
    // @param flag：标志。BitSet。ABILITY_CAST_TYPE
    function MHMsg_CallTargetModeEx takes integer aid, integer oid, integer flag returns nothing
    endfunction
    
    // 调起建造指示器
    // @Tip：强制调起建造指示器，进入选择建造位置模式
    // @param uid：建筑的单位id
    // @param flag：标志。一般填写0x100008
    function MHMsg_CallBuildMode takes integer uid, integer flag returns nothing
    endfunction

    // 取消指示器
    function MHMsg_CancelIndicator takes nothing returns nothing
    endfunction

    // 判定指示器激活
    // @param type：INDICATOR_TYPE。指示器类型
    function MHMsg_IsIndicatorOn takes integer indicator_type returns boolean
    endfunction

    // 获取鼠标指向的单位
    function MHMsg_GetCursorUnit takes nothing returns unit
    endfunction
    
    // 获取鼠标指向的物品
    function MHMsg_GetCursorItem takes nothing returns item
    endfunction

    // 获取鼠标指向的可破坏物
    function MHMsg_GetCursorDest takes nothing returns destructable
    endfunction

    // 本地玩家发送无目标命令
    // @Tip：命令会经过游戏同步后再发布
    // @param oid：命令ID
    // @param flag：标志。LOCAL_ORDER_FLAG
    function MHMsg_SendImmediateOrder takes integer oid, integer flag returns nothing
    endfunction

    // 本地玩家发送指示器命令
    // @Tip：命令会经过游戏同步后再发布
    // @param target：目标物体。填写null则为点目标命令
    // @param x：目标点X
    // @param y：目标点Y
    // @param oid：命令ID
    // @param flag：标志。LOCAL_ORDER_FLAG
    function MHMsg_SendIndicatorOrder takes widget target, real x, real y, integer oid, integer flag returns nothing
    endfunction

    // 本地玩家发送选择器命令
    // @Tip：命令会经过游戏同步后再发布
    // @param x：目标点X
    // @param y：目标点Y
    // @param oid：命令ID
    // @param flag：标志。LOCAL_ORDER_FLAG
    function MHMsg_SendSelectorOrder takes real x, real y, integer oid, integer flag returns nothing
    endfunction

    // 本地玩家发送丢弃物品命令
    // @Tip：命令会经过游戏同步后再发布
    // @param target：丢弃物品的目标。填写null则为点目标命令
    // @param x：目标点X
    // @param y：目标点Y
    // @param it：丢弃的物品
    // @param oid：命令ID
    // @param flag：标志。LOCAL_ORDER_FLAG
    function MHMsg_SendDropItemOrder takes unit target, real x, real y, item it, integer flag returns nothing
    endfunction

    // 本地玩家发送右键物体命令
    // @Tip：命令会经过游戏同步后再发布
    // @param target：右键目标
    // @param oid：命令ID
    // @param flag：标志。LOCAL_ORDER_FLAG
    function MHMsg_SendSmartOrder takes widget target, integer oid, integer flag returns nothing
    endfunction

    // 设置屏幕比例
    function MHMsg_SetCustomFovFix takes real value returns nothing
    endfunction

    // 允许宽屏模式
    function MHMsg_EnableWideScreen takes boolean is_enable returns nothing
    endfunction

    // 是宽屏启动
    function MHMsg_IsWindowedLaunch takes nothing returns boolean
    endfunction

    // 强制16:9
    // @Tip：仅窗口模式有效
    function MHMsg_ForceAspectRatio takes nothing returns nothing
    endfunction

    // 窗口无边框
    // @Tip：仅窗口模式有效
    function MHMsg_EnableBorderless takes boolean is_enable returns nothing
    endfunction

    // 窗口锁鼠
    // @Tip：仅窗口模式有效
    function MHMsg_EnableLockCursor takes boolean is_enable returns nothing
    endfunction



// 事件库



    // 注册本地玩家按键弹起事件
    // @Tip：EVENT_ID_KEY_UP
    // 异步事件仅支持触发器条件！
    function MHMsgKeyUpEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取弹起的按键
    // @Tip：响应 本地玩家按键弹起 事件
    // 等价于 MHEvent_GetKey
    function MHMsgKeyUpEvent_GetKey takes nothing returns integer
    endfunction

    // 设置弹起的按键
    // @Tip：响应 本地玩家按键弹起 事件
    // 等价于 MHEvent_SetKey
    // 设置为一个无效值即可屏蔽事件。例如设置按键为 -1
    function MHMsgKeyUpEvent_SetKey takes integer key returns nothing
    endfunction

    // 注册本地玩家按键按下事件
    // @Tip：EVENT_ID_KEY_DOWN
    // 异步事件仅支持触发器条件！
    function MHMsgKeyDownEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取按下的按键
    // @Tip：响应 本地玩家按键按下 事件
    // 等价于 MHEvent_GetKey
    function MHMsgKeyDownEvent_GetKey takes nothing returns integer
    endfunction

    // 设置按下的按键
    // @Tip：响应 本地玩家按键按下 事件
    // 等价于 MHEvent_SetKey
    // 设置为一个无效值即可屏蔽事件。例如设置按键为 -1
    function MHMsgKeyDownEvent_SetKey takes integer key returns nothing
    endfunction

    // 注册本地玩家按键按住事件
    // @Tip：EVENT_ID_KEY_HOLD
    // 异步事件仅支持触发器条件！
    function MHMsgKeyHoldEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取按住的按键
    // @Tip：响应 本地玩家按键按住 事件
    // 等价于 MHEvent_GetKey
    function MHMsgKeyHoldEvent_GetKey takes nothing returns integer
    endfunction

    // 设置按住的按键
    // @Tip：响应 本地玩家按键按住 事件
    // 等价于 MHEvent_SetKey
    // 设置为一个无效值即可屏蔽事件。例如设置按键为 -1
    function MHMsgKeyHoldEvent_SetKey takes integer key returns nothing
    endfunction

    // 注册本地玩家鼠标弹起事件
    // @Tip：EVENT_ID_MOUSE_UP
    // 异步事件仅支持触发器条件！
    function MHMsgMouseUpEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取弹起的鼠标按键
    // @Tip：响应 本地玩家鼠标弹起 事件
    // 等价于 MHEvent_GetKey
    function MHMsgMouseUpEvent_GetKey takes nothing returns integer
    endfunction

    // 设置弹起的鼠标按键
    // @Tip：响应 本地玩家鼠标弹起 事件
    // 等价于 MHEvent_SetKey
    // 设置为一个无效值即可屏蔽事件。例如设置按键为 -1
    function MHMsgMouseUpEvent_SetKey takes integer key returns nothing
    endfunction

    // 注册本地玩家鼠标按键按下事件
    // @Tip：EVENT_ID_MOUSE_DOWN
    // 异步事件仅支持触发器条件！
    function MHMsgMouseDownEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取按下的鼠标按键
    // @Tip：响应 本地玩家鼠标按下 事件
    // 等价于 MHEvent_GetKey
    function MHMsgMouseDownEvent_GetKey takes nothing returns integer
    endfunction

    // 设置按下的鼠标按键
    // @Tip：响应 本地玩家鼠标按下 事件
    // 等价于 MHEvent_SetKey
    // 设置为一个无效值即可屏蔽事件。例如设置按键为 -1
    function MHMsgMouseDownEvent_SetKey takes integer key returns nothing
    endfunction

    // 注册本地玩家鼠标滚动事件
    // @Tip：EVENT_ID_MOUSE_SCROLL
    // 异步事件仅支持触发器条件！
    function MHMsgMouseScrollEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取滚动值
    // @Tip：响应 本地玩家鼠标滚动 事件
    function MHMsgMouseScrollEvent_GetValue takes nothing returns integer
    endfunction

    // 设置滚动值
    // @Tip：响应 本地玩家鼠标滚动 事件
    function MHMsgMouseScrollEvent_SetValue takes integer value returns nothing
    endfunction

    // 注册本地玩家鼠标移动事件
    // @Tip：EVENT_ID_MOUSE_MOVE
    // 异步事件仅支持触发器条件！
    function MHMsgMouseMoveEvent_Register takes trigger trig returns nothing
    endfunction

    // 注册本地玩家按下目标指示器事件
    // @Tip：EVENT_ID_TARGET_INDICATOR
    // 异步事件仅支持触发器条件！
    function MHMsgIndicatorEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取指示器目标单位
    // @Tip：响应 本地玩家按下目标指示器 事件
    function MHMsgIndicatorEvent_GetTargetUnit takes nothing returns unit
    endfunction

    // 获取指示器目标物品
    // @Tip：响应 本地玩家按下目标指示器 事件
    function MHMsgIndicatorEvent_GetTargetItem takes nothing returns item
    endfunction

    // 获取指示器目标可破坏物
    // @Tip：响应 本地玩家按下目标指示器 事件
    function MHMsgIndicatorEvent_GetTargetDest takes nothing returns destructable
    endfunction

    // 获取指示器目标点X
    function MHMsgIndicatorEvent_GetTargetX takes nothing returns real
    endfunction

    // 获取指示器目标点Y
    function MHMsgIndicatorEvent_GetTargetY takes nothing returns real
    endfunction

    // 获取指示器按键
    // @Tip：响应 本地玩家按下目标指示器 事件
    // 等价于 MHEvent_GetKey
    function MHMsgIndicatorEvent_GetKey takes nothing returns integer
    endfunction

    // 设置指示器按键
    // @Tip：响应 本地玩家按下目标指示器 事件
    // 等价于 MHEvent_SetKey
    // 设置为一个无效值即可屏蔽事件。例如设置按键为 -1
    function MHMsgIndicatorEvent_SetKey takes integer key returns nothing
    endfunction

    // 获取指示器技能
    // @Tip：响应 本地玩家按下目标指示器 事件
    function MHMsgIndicatorEvent_GetAbility takes nothing returns integer
    endfunction

    // 获取指示器命令
    // @Tip：响应 本地玩家按下目标指示器 事件
    // 等价于 MHEvent_GetOrder
    function MHMsgIndicatorEvent_GetOrder takes nothing returns integer
    endfunction

    // 注册本地玩家按下目标选择器事件
    // @Tip：EVENT_ID_TARGET_SELECTOR
    // 异步事件仅支持触发器条件！
    function MHMsgSelectorEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取选择器目标点X
    // @Tip：响应 本地玩家按下目标选择器 事件
    function MHMsgSelectorEvent_GetTargetX takes nothing returns real
    endfunction

    // 获取选择器目标点Y
    // @Tip：响应 本地玩家按下目标选择器 事件
    function MHMsgSelectorEvent_GetTargetY takes nothing returns real
    endfunction

    // 获取选择器按键
    // @Tip：响应 本地玩家按下目标选择器 事件
    // 等价于 MHEvent_GetKey
    function MHMsgSelectorEvent_GetKey takes nothing returns integer
    endfunction

    // 设置选择器按键
    // @Tip：响应 本地玩家按下目标选择器 事件
    // 等价于 MHEvent_SetKey
    // 设置为一个无效值即可屏蔽事件。例如设置按键为 -1
    function MHMsgSelectorEvent_SetKey takes integer key returns nothing
    endfunction

    // 获取选择器技能
    // @Tip：响应 本地玩家按下目标选择器 事件
    function MHMsgSelectorEvent_GetAbility takes nothing returns integer
    endfunction

    // 获取选择器命令
    // @Tip：响应 本地玩家按下目标选择器 事件
    // 等价于 MHEvent_GetOrder
    function MHMsgSelectorEvent_GetOrder takes nothing returns integer
    endfunction

    // 注册本地玩家调起指示器/选择器事件
    // @Tip：EVENT_ID_CALL_TARGET_MODE
    // 异步事件仅支持触发器条件！
    function MHMsgCallTargetModeEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取指示器/选择器技能
    // @Tip：响应 本地玩家调起指示器/选择器 事件
    function MHMsgCallTargetModeEvent_GetAbility takes nothing returns integer
    endfunction

    // 获取指示器/选择器命令
    // @Tip：响应 本地玩家调起指示器/选择器 事件
    // 等价于 MHEvent_GetOrder
    function MHMsgCallTargetModeEvent_GetOrder takes nothing returns integer
    endfunction

    // 获取指示器/选择器释放类型
    // @Tip：响应 本地玩家调起指示器/选择器 事件
    // BitSet。ABILITY_CAST_TYPE
    function MHMsgCallTargetModeEvent_GetCastType takes nothing returns integer
    endfunction

    // 设置指示器/选择器释放类型
    // @Tip：响应 本地玩家调起指示器/选择器 事件
    // @param cast_type：释放类型。BitSet。ABILITY_CAST_TYPE
    function MHMsgCallTargetModeEvent_SetCastType takes integer cast_type returns nothing
    endfunction

    // 注册本地玩家调起建造指示器事件
    // @Tip：EVENT_ID_CALL_BUILD_MODE
    // 异步事件仅支持触发器条件！
    function MHMsgCallBuildModeEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取建造指示器命令
    // @Tip：响应 本地玩家调起建造指示器 事件
    // 等价于 MHEvent_GetOrder
    // 即建筑的单位类型
    function MHMsgCallBuildModeEvent_GetOrder takes nothing returns integer
    endfunction

    // 注册本地玩家取消指示器/选择器事件
    // @Tip：EVENT_ID_CANCEL_INDICATOR
    // 异步事件仅支持触发器条件！
    function MHMsgCancelIndicatorEvent_Register takes trigger trig returns nothing
    endfunction

    // 注册本地玩家点击命令按钮事件
    // @Tip：EVENT_ID_CLICK_COMMAND_BUTTON
    // 点击物品栏/技能栏按钮时触发
    // 异步事件仅支持触发器条件！
    function MHMsgClickButtonEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取点击的按钮
    // @Tip：响应 本地玩家点击命令按钮 事件
    // 等价于 MHEvent_GetFrame
    function MHMsgClickButtonEvent_GetButton takes nothing returns integer
    endfunction

    // 获取点击按钮的技能
    // @Tip：响应 本地玩家点击命令按钮 事件
    // 等价于 MHEvent_GetAbility
    function MHMsgClickButtonEvent_GetAbility takes nothing returns integer
    endfunction

    // 获取点击按钮的按键
    // @Tip：响应 本地玩家点击命令按钮 事件
    // 等价于 MHEvent_GetKey
    function MHMsgClickButtonEvent_GetKey takes nothing returns integer
    endfunction

    // 设置点击按钮的按键
    // @Tip：响应 本地玩家点击命令按钮 事件
    // 等价于 MHEvent_SetKey
    // 设置为一个无效值即可屏蔽事件。例如设置按键为 -1
    function MHMsgClickButtonEvent_SetKey takes integer key returns nothing
    endfunction

    // 注册本地玩家发布无目标命令事件
    // @Tip：EVENT_ID_LOCAL_IMMEDIATE_ORDER
    // 异步事件仅支持触发器条件！
    function MHMsgImmediateOrderEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取本地命令事件的命令
    // @Tip：响应 本地玩家发布命令 事件
    // 等价于 MHEvent_GetOrder
    function MHMsgLocalOrderEvent_GetOrder takes nothing returns integer
    endfunction

    // 设置本地命令事件的命令
    // @Tip：响应 本地玩家发布命令 事件
    // 等价于 MHEvent_SetOrder
    function MHMsgLocalOrderEvent_SetOrder takes integer oid returns nothing
    endfunction

    // 获取本地命令事件的标志
    // @Tip：响应 本地玩家发布命令 事件
    // LOCAL_ORDER_FLAG
    function MHMsgLocalOrderEvent_GetFlag takes nothing returns integer
    endfunction

    // 设置本地命令事件的命令标志
    // @Tip：响应 本地玩家发布命令 事件
    // @param flag：LOCAL_ORDER_FLAG
    function MHMsgLocalOrderEvent_SetFlag takes integer flag returns nothing
    endfunction

    // 注册本地玩家窗口大小变化事件
    // @Tip：EVENT_ID_WINDOW_RESIZE
    function MHMsgWindowResizeEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取原窗口宽度
    // @Tip：响应 本地玩家窗口大小变化 事件
    function MHMsgWindowResizeEvent_GetOldWidth takes nothing returns integer
    endfunction

    // 获取原窗口高度
    // @Tip：响应 本地玩家窗口大小变化 事件
    function MHMsgWindowResizeEvent_GetOldHeight takes nothing returns integer
    endfunction







//==================================================================================
//
// [玩家] player.j 
//
//==================================================================================



// 基本库



    // 本地玩家选择的单位
    function MHPlayer_GetSelectUnit takes nothing returns unit
    endfunction

    // 本地玩家选择的物品
    function MHPlayer_GetSelectItem takes nothing returns item
    endfunction

    // 检查可用性
    // @Tip：包括科技、单位、物品、技能等的可用性
    function MHPlayer_CheckAvailable takes player p, integer id returns boolean
    endfunction



// 事件库



    // 注册任意玩家黄金变动事件
    // @Tip：EVENT_ID_PLAYER_GOLD_CHANGE
    function MHPlayerGoldChangeEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取黄金变动的玩家
    // @Tip：响应 任意玩家黄金变动 事件
    // 等价于 MHEvent_GetPlayer
    function MHPlayerGoldChangeEvent_GetPlayer takes nothing returns player
    endfunction

    // 设置资源变动的玩家
    // @Tip：响应 任意玩家黄金变动 事件
    // 等价于 MHEvent_SetPlayer
    function MHPlayerGoldChangeEvent_SetPlayer takes player p returns nothing
    endfunction

    // 获取黄金变动的数值
    // @Tip：响应 任意玩家黄金变动 事件
    function MHPlayerGoldChangeEvent_GetValue takes nothing returns integer
    endfunction

    // 设置黄金变动的数值
    // @Tip：响应 任意玩家黄金变动 事件
    function MHPlayerGoldChangeEvent_SetValue takes integer value returns nothing
    endfunction

    // 获取黄金变动是否计算税率
    // @Tip：响应 任意玩家黄金变动 事件
    function MHPlayerGoldChangeEvent_IsTax takes nothing returns boolean
    endfunction

    // 设置黄金变动是否计算税率
    // @Tip：响应 任意玩家黄金变动 事件
    function MHPlayerGoldChangeEvent_SetTax takes boolean is_tax returns nothing
    endfunction

    // 注册任意玩家木材变动事件
    // @Tip：EVENT_ID_PLAYER_LUMBER_CHANGE
    function MHPlayerLumberChangeEvent_Register takes trigger trig returns nothing
    endfunction

    // 获取木材变动的玩家
    // @Tip：响应 任意玩家木材变动 事件
    // 等价于 MHEvent_GetPlayer
    function MHPlayerLumberChangeEvent_GetPlayer takes nothing returns player
    endfunction

    // 设置资源变动的玩家
    // @Tip：响应 任意玩家木材变动 事件
    // 等价于 MHEvent_SetPlayer
    function MHPlayerLumberChangeEvent_SetPlayer takes player p returns nothing
    endfunction

    // 获取木材变动的数值
    // @Tip：响应 任意玩家木材变动 事件
    function MHPlayerLumberChangeEvent_GetValue takes nothing returns integer
    endfunction

    // 设置木材变动的数值
    // @Tip：响应 任意玩家木材变动 事件
    function MHPlayerLumberChangeEvent_SetValue takes integer value returns nothing
    endfunction

    // 获取木材变动是否计算税率
    // @Tip：响应 任意玩家木材变动 事件
    function MHPlayerLumberChangeEvent_IsTax takes nothing returns boolean
    endfunction

    // 设置木材变动是否计算税率
    // @Tip：响应 任意玩家木材变动 事件
    function MHPlayerLumberChangeEvent_SetTax takes boolean is_tax returns nothing
    endfunction







//==================================================================================
//
// [字符串] string.j 
//
//==================================================================================



// 基本库



    // 转换Id为字符串
    // @Tip：例如将'AHtb'这样的整数转为字符串
    function MHString_FromId takes integer id returns string
    endfunction

    // 转换字符串为Id
    // @Tip：例如将字符串转为'AHtb'这样的整数
    function MHString_ToId takes string id returns integer
    endfunction

    // 查找字符串
    // @Tip：字符串起始位置为0。返回-1说明未搜索到
    // @param str：源字符串
    // @param target：要查找的字符串
    // @param start：源字符串中起始位置开始查找
    function MHString_Find takes string str, string target, integer start returns integer
    endfunction

    // 反转字符串
    // @Tip：不支持中文
    function MHString_Reverse takes string str returns string
    endfunction

    // 裁剪
    // @Tip：去掉两边的空格
    function MHString_Trim takes string str returns string
    endfunction

    // 裁剪左边
    // @Tip：去掉左侧的空格
    function MHString_LTrim takes string str returns string
    endfunction

    // 裁剪右边
    // @Tip：去掉右侧的空格
    function MHString_RTrim takes string str returns string
    endfunction

    // 包含字符串
    // @Tip：str 包含 target
    function MHString_Contain takes string str, string target returns boolean
    endfunction

    // 包含的字符串数
    // @Tip：str 包含的 target 数量
    function MHString_GetCount takes string str, string target returns integer
    endfunction

    // 截取字符串
    // @Tip：字符串起始位置为0。长度填入-1则截取起始位置到字符串结束位置的所有字符
    // @param start：起始位置
    // @param length：截取长度
    function MHString_Sub takes string str, integer start, integer length returns string
    endfunction

    // 替换字符串
    // @Tip：将 str 中的所有 old_str 替换为 new_str
    // @param str：源字符串
    // @param old_str：要被替换的旧字符串
    // @param new_str：即将替换的新字符串
    function MHString_Replace takes string str, string old_str, string new_str returns string
    endfunction

    // 分割字符串
    // @Tip：获取字符串 str 中被 delimiter 分割的第 index 段字符串
    // @param str：字符串
    // @param delimiter：分隔符
    // @param index：段序号。从1开始
    function MHString_Split takes string str, string delimiter, integer index returns string
    endfunction

    // 正则匹配
    function MHString_RegexMatch takes string str, string regex returns boolean
    endfunction

    // 正则搜索
    // @Tip：搜索str中匹配正则表达式regex的第index个字符串中的第capture个捕获组
    // index从1开始，捕获组为0时返回整个匹配字符串
    function MHString_RegexSearch takes string str, string regex, integer index, integer capture returns string
    endfunction

    // 正则替换
    // @Tip：将str中所有匹配正则表达式regex的字符串替换为new_val
    function MHString_RegexReplace takes string str, string regex, integer new_val returns string
    endfunction

    // 连接字符串lv3
    // @Tip：可减少连接字符串带来的字符串泄漏
    function MHString_Concat3 takes string str0, string str1, string str2 returns string
    endfunction

    // 连接字符串lv4
    // @Tip：可减少连接字符串带来的字符串泄漏
    function MHString_Concat4 takes string str0, string str1, string str2, string str3 returns string
    endfunction

    // 连接字符串lv5
    // @Tip：可减少连接字符串带来的字符串泄漏
    function MHString_Concat5 takes string str0, string str1, string str2, string str3, string str4 returns string
    endfunction

    // 连接字符串lv6
    // @Tip：可减少连接字符串带来的字符串泄漏
    function MHString_Concat6 takes string str0, string str1, string str2, string str3, string str4, string str5 returns string
    endfunction

    // 连接字符串lv7
    // @Tip：可减少连接字符串带来的字符串泄漏
    function MHString_Concat7 takes string str0, string str1, string str2, string str3, string str4, string str5, string str6 returns string
    endfunction

    // 连接字符串lv8
    // @Tip：可减少连接字符串带来的字符串泄漏
    function MHString_Concat8 takes string str0, string str1, string str2, string str3, string str4, string str5, string str6, string str7 returns string
    endfunction

    // 连接字符串lv9
    // @Tip：可减少连接字符串带来的字符串泄漏
    function MHString_Concat9 takes string str0, string str1, string str2, string str3, string str4, string str5, string str6, string str7, string str8 returns string
    endfunction

    // 连接字符串lv10
    // @Tip：可减少连接字符串带来的字符串泄漏
    function MHString_Concat10 takes string str0, string str1, string str2, string str3, string str4, string str5, string str6, string str7, string str8, string str9 returns string
    endfunction

    // 连接字符串lv11
    // @Tip：可减少连接字符串带来的字符串泄漏
    function MHString_Concat11 takes string str0, string str1, string str2, string str3, string str4, string str5, string str6, string str7, string str8, string str9, string strA returns string
    endfunction

    // 连接字符串lv12
    // @Tip：可减少连接字符串带来的字符串泄漏
    function MHString_Concat12 takes string str0, string str1, string str2, string str3, string str4, string str5, string str6, string str7, string str8, string str9, string strA, string strB returns string
    endfunction

    // 连接字符串lv13
    // @Tip：可减少连接字符串带来的字符串泄漏
    function MHString_Concat13 takes string str0, string str1, string str2, string str3, string str4, string str5, string str6, string str7, string str8, string str9, string strA, string strB, string strC returns string
    endfunction

    // 连接字符串lv14
    // @Tip：可减少连接字符串带来的字符串泄漏
    function MHString_Concat14 takes string str0, string str1, string str2, string str3, string str4, string str5, string str6, string str7, string str8, string str9, string strA, string strB, string strC, string strD returns string
    endfunction

    // 连接字符串lv15
    // @Tip：可减少连接字符串带来的字符串泄漏
    function MHString_Concat15 takes string str0, string str1, string str2, string str3, string str4, string str5, string str6, string str7, string str8, string str9, string strA, string strB, string strC, string strD, string strE returns string
    endfunction

    // 连接字符串lv16
    // @Tip：可减少连接字符串带来的字符串泄漏
    function MHString_Concat16 takes string str0, string str1, string str2, string str3, string str4, string str5, string str6, string str7, string str8, string str9, string strA, string strB, string strC, string strD, string strE, string strF returns string
    endfunction

    // 连接字符串
    // @param v_name：全局字符串数组的变量名
    // @param begin：起始序号
    // @param begin：终止序号
    function MHString_ConcatFromVar takes string v_name, integer begin, integer end returns string
    endfunction







//==================================================================================
//
// [同步] sync.j 
//
//==================================================================================



// 基本库



    // 注册数据同步事件
    // @Tip：EVENT_ID_SYNC
    // @param key：同步标签
    function MHSyncEvent_Register takes trigger trig, string key returns nothing
    endfunction

    // 发送同步数据
    // @param key：同步标签
    // @param data：同步数据
    function MHSyncEvent_Sync takes string key, string data returns nothing
    endfunction

    // 获取标签
    // @Tip：响应 数据同步 事件
    function MHSyncEvent_GetKey takes nothing returns string
    endfunction

    // 获取同步数据
    // @Tip：响应 数据同步 事件
    function MHSyncEvent_GetData takes nothing returns string
    endfunction

    // 获取来源玩家
    // @Tip：响应 数据同步 事件
    // 等价于 MHEvent_GetPlayer
    function MHSyncEvent_GetPlayer takes nothing returns player
    endfunction







//==================================================================================
//
// [工具] tool.j 
//
//==================================================================================



// 基本库



    // 获取Handle类型
    // @Tip：例如单位返回 '+w3u'，触发器返回 '+trg'
    function MHTool_GetHandleIdType takes integer hid returns integer
    endfunction

    // 获取系统时间
    // @param flag：SYSTEM_TIME
    function MHTool_GetLocalTime takes integer flag returns integer
    endfunction

    // 获取计时
    // @Tip：可用于函数运行效率测试 (ms)
    // clock()
    function MHTool_Clock takes nothing returns integer
    endfunction







//==================================================================================
//
// [触发器] trigger.j 
//
//==================================================================================



// 基本库



    // 清空触发器事件
    function MHTrigger_ClearEvent takes trigger trig returns nothing
    endfunction







//==================================================================================
//
// [Python] python.j 
//
//==================================================================================



// 基本库



    // 执行python脚本
    // @Tip：填写mpq中的路径。支持.py文件和.pyc字节码文件
    function MHPython_RunScript takes string path returns integer
    endfunction
