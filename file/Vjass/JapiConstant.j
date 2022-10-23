
library YDWEJapi
    native EXExecuteScript takes string script returns string
    native EXDisplayChat takes player p, integer chat_recipient, string message returns nothing
    // Abilitys
    globals
        //JAPI常量 - 技能
        constant integer ABILITY_STATE_COOLDOWN = 1
        
        constant integer ABILITY_DATA_TARGS = 100 // integer
        constant integer ABILITY_DATA_CAST = 101 // real
        constant integer ABILITY_DATA_DUR = 102 // real
        constant integer ABILITY_DATA_HERODUR = 103 // real
        constant integer ABILITY_DATA_COST = 104 // integer
        constant integer ABILITY_DATA_COOL = 105 // real
        constant integer ABILITY_DATA_AREA = 106 // real
        constant integer ABILITY_DATA_RNG = 107 // real
        constant integer ABILITY_DATA_DATA_A = 108 // real
        constant integer ABILITY_DATA_DATA_B = 109 // real
        constant integer ABILITY_DATA_DATA_C = 110 // real
        constant integer ABILITY_DATA_DATA_D = 111 // real
        constant integer ABILITY_DATA_DATA_E = 112 // real
        constant integer ABILITY_DATA_DATA_F = 113 // real
        constant integer ABILITY_DATA_DATA_G = 114 // real
        constant integer ABILITY_DATA_DATA_H = 115 // real
        constant integer ABILITY_DATA_DATA_I = 116 // real
        constant integer ABILITY_DATA_UNITID = 117 // integer
    
        constant integer ABILITY_DATA_HOTKET = 200 // integer
        constant integer ABILITY_DATA_UNHOTKET = 201 // integer
        constant integer ABILITY_DATA_RESEARCH_HOTKEY = 202 // integer
        constant integer ABILITY_DATA_NAME = 203 // string
        constant integer ABILITY_DATA_ART = 204 // string
        constant integer ABILITY_DATA_TARGET_ART = 205 // string
        constant integer ABILITY_DATA_CASTER_ART = 206 // string
        constant integer ABILITY_DATA_EFFECT_ART = 207 // string
        constant integer ABILITY_DATA_AREAEFFECT_ART = 208 // string
        constant integer ABILITY_DATA_MISSILE_ART = 209 // string
        constant integer ABILITY_DATA_SPECIAL_ART = 210 // string
        constant integer ABILITY_DATA_LIGHTNING_EFFECT = 211 // string
        constant integer ABILITY_DATA_BUFF_TIP = 212 // string
        constant integer ABILITY_DATA_BUFF_UBERTIP = 213 // string
        constant integer ABILITY_DATA_RESEARCH_TIP = 214 // string
        constant integer ABILITY_DATA_TIP = 215 // string
        constant integer ABILITY_DATA_UNTIP = 216 // string
        constant integer ABILITY_DATA_RESEARCH_UBERTIP = 217 // string
        constant integer ABILITY_DATA_UBERTIP = 218 // string
        constant integer ABILITY_DATA_UNUBERTIP = 219 // string
        constant integer ABILITY_DATA_UNART = 220 // string
    endglobals

    native EXGetUnitAbility takes unit u, integer abilcode returns ability
	native EXGetUnitAbilityByIndex takes unit u, integer index returns ability
	native EXGetAbilityId takes ability abil returns integer
	native EXGetAbilityState takes ability abil, integer state_type returns real
	native EXSetAbilityState takes ability abil, integer state_type, real value returns boolean
	native EXGetAbilityDataReal takes ability abil, integer level, integer data_type returns real
	native EXSetAbilityDataReal takes ability abil, integer level, integer data_type, real value returns boolean
	native EXGetAbilityDataInteger takes ability abil, integer level, integer data_type returns integer
	native EXSetAbilityDataInteger takes ability abil, integer level, integer data_type, integer value returns boolean
	native EXGetAbilityDataString takes ability abil, integer level, integer data_type returns string
	native EXSetAbilityDataString takes ability abil, integer level, integer data_type, string value returns boolean

    static if not LIBRARY_YDWEAbilityState then
        // 技能属性 [JAPI]
        function YDWEGetUnitAbilityState takes unit u, integer abilcode, integer state_type returns real
            return EXGetAbilityState(EXGetUnitAbility(u, abilcode), state_type)
        endfunction
        // 技能数据 (整数) [JAPI]
        function YDWEGetUnitAbilityDataInteger takes unit u, integer abilcode, integer level, integer data_type returns integer
            return EXGetAbilityDataInteger(EXGetUnitAbility(u, abilcode), level, data_type)
        endfunction
        // 技能数据 (实数) [JAPI]
        function YDWEGetUnitAbilityDataReal takes unit u, integer abilcode, integer level, integer data_type returns real
            return EXGetAbilityDataReal(EXGetUnitAbility(u, abilcode), level, data_type)
        endfunction
        // 技能数据 (字符串) [JAPI]
        function YDWEGetUnitAbilityDataString takes unit u, integer abilcode, integer level, integer data_type returns string
            return EXGetAbilityDataString(EXGetUnitAbility(u, abilcode), level, data_type)
        endfunction
        // 设置技能属性 [JAPI]
        function YDWESetUnitAbilityState takes unit u, integer abilcode, integer state_type, real value returns boolean
            return EXSetAbilityState(EXGetUnitAbility(u, abilcode), state_type, value)
        endfunction
        // 设置技能数据 (整数) [JAPI]
        function YDWESetUnitAbilityDataInteger takes unit u, integer abilcode, integer level, integer data_type, integer value returns boolean
            return EXSetAbilityDataInteger(EXGetUnitAbility(u, abilcode), level, data_type, value)
        endfunction
        // 设置技能数据 (实数) [JAPI]
        function YDWESetUnitAbilityDataReal takes unit u, integer abilcode, integer level, integer data_type, real value returns boolean
            return EXSetAbilityDataReal(EXGetUnitAbility(u, abilcode), level, data_type, value)
        endfunction
        // 设置技能数据 (字符串) [JAPI]
        function YDWESetUnitAbilityDataString takes unit u, integer abilcode, integer level, integer data_type, string value returns boolean
            return EXSetAbilityDataString(EXGetUnitAbility(u, abilcode), level, data_type, value)
        endfunction
    endif

	native EXSetAbilityAEmeDataA takes ability abil, integer unitid returns boolean
    
    /* // 单位变身  [JAPI]
    function YDWEUnitTransform takes unit u, integer abilcode, integer targetid returns nothing
        call UnitAddAbility(u, abilcode)
        call EXSetAbilityDataInteger(EXGetUnitAbility(u, abilcode), 1, ABILITY_DATA_UNITID, GetUnitTypeId(u))
        call EXSetAbilityAEmeDataA(EXGetUnitAbility(u, abilcode), GetUnitTypeId(u))
        call UnitRemoveAbility(u, abilcode)
        call UnitAddAbility(u, abilcode)
        call EXSetAbilityAEmeDataA(EXGetUnitAbility(u, abilcode), targetid)
        call UnitRemoveAbility(u, abilcode)
    endfunction
    */
    //==============================================================================
    // units
    //==============================================================================
    native EXSetUnitFacing takes unit u, real angle returns nothing
    native EXPauseUnit takes unit u, boolean flag returns nothing
    native EXSetUnitCollisionType takes boolean enable, unit u, integer t returns nothing
    native EXSetUnitMoveType takes unit u, integer t returns nothing
        
    //function YDWEUnitAddStun takes unit u returns nothing
    //    call EXPauseUnit(u, true)
    //endfunction
            
    //function YDWEUnitRemoveStun takes unit u returns nothing
    //    call EXPauseUnit(u, false)
    //endfunction 
    
globals
    //------------单位数据类型--------------
    // 攻击1 伤害骰子数量
    constant unitstate UNIT_STATE_ATTACK1_DAMAGE_DICE = ConvertUnitState(0x10)
    
    // 攻击1 伤害骰子面数
    constant unitstate UNIT_STATE_ATTACK1_DAMAGE_SIDE = ConvertUnitState(0x11)
    
    // 攻击1 基础伤害
    constant unitstate UNIT_STATE_ATTACK1_DAMAGE_BASE = ConvertUnitState(0x12)
    
    // 攻击1 升级奖励
    constant unitstate UNIT_STATE_ATTACK1_DAMAGE_BONUS = ConvertUnitState(0x13)
    
    // 攻击1 最小伤害
    constant unitstate UNIT_STATE_ATTACK1_DAMAGE_MIN = ConvertUnitState(0x14)
    
    // 攻击1 最大伤害
    constant unitstate UNIT_STATE_ATTACK1_DAMAGE_MAX = ConvertUnitState(0x15)
    
    // 攻击1 全伤害范围
    constant unitstate UNIT_STATE_ATTACK1_RANGE = ConvertUnitState(0x16)
    
    // 装甲
    constant unitstate UNIT_STATE_ARMOR = ConvertUnitState(0x20)
    
    // attack 1 attribute adds
    // 攻击1 伤害衰减参数
    constant unitstate UNIT_STATE_ATTACK1_DAMAGE_LOSS_FACTOR = ConvertUnitState(0x21)
    
    // 攻击1 武器声音
    constant unitstate UNIT_STATE_ATTACK1_WEAPON_SOUND = ConvertUnitState(0x22)
    
    // 攻击1 攻击类型
    constant unitstate UNIT_STATE_ATTACK1_ATTACK_TYPE = ConvertUnitState(0x23)
    
    // 攻击1 最大目标数
    constant unitstate UNIT_STATE_ATTACK1_MAX_TARGETS = ConvertUnitState(0x24)
    
    // 攻击1 攻击间隔
    constant unitstate UNIT_STATE_ATTACK1_INTERVAL = ConvertUnitState(0x25)
    
    // 攻击1 攻击延迟/summary>
    constant unitstate UNIT_STATE_ATTACK1_INITIAL_DELAY = ConvertUnitState(0x26)
    
    // 攻击1 弹射弧度
    constant unitstate UNIT_STATE_ATTACK1_BACK_SWING = ConvertUnitState(0x28)
    
    // 攻击1 攻击范围缓冲
    constant unitstate UNIT_STATE_ATTACK1_RANGE_BUFFER = ConvertUnitState(0x27)
    
    // 攻击1 目标允许
    constant unitstate UNIT_STATE_ATTACK1_TARGET_TYPES = ConvertUnitState(0x29)
    
    // 攻击1 溅出区域
    constant unitstate UNIT_STATE_ATTACK1_SPILL_DIST = ConvertUnitState(0x56)
    
    // 攻击1 溅出半径
    constant unitstate UNIT_STATE_ATTACK1_SPILL_RADIUS = ConvertUnitState(0x57)
    
    // 攻击1 武器类型
    constant unitstate UNIT_STATE_ATTACK1_WEAPON_TYPE = ConvertUnitState(0x58)
    
    // attack 2 attributes (sorted in a sequencial order based on memory address)
    // 攻击2 伤害骰子数量
    constant unitstate UNIT_STATE_ATTACK2_DAMAGE_DICE = ConvertUnitState(0x30)
    
    // 攻击2 伤害骰子面数
    constant unitstate UNIT_STATE_ATTACK2_DAMAGE_SIDE = ConvertUnitState(0x31)
    
    // 攻击2 基础伤害
    constant unitstate UNIT_STATE_ATTACK2_DAMAGE_BASE = ConvertUnitState(0x32)
    
    // 攻击2 升级奖励
    constant unitstate UNIT_STATE_ATTACK2_DAMAGE_BONUS = ConvertUnitState(0x33)
    
    // 攻击2 伤害衰减参数
    constant unitstate UNIT_STATE_ATTACK2_DAMAGE_LOSS_FACTOR = ConvertUnitState(0x34)
    
    // 攻击2 武器声音
    constant unitstate UNIT_STATE_ATTACK2_WEAPON_SOUND = ConvertUnitState(0x35)
    
    // 攻击2 攻击类型
    constant unitstate UNIT_STATE_ATTACK2_ATTACK_TYPE = ConvertUnitState(0x36)
    
    // 攻击2 最大目标数
    constant unitstate UNIT_STATE_ATTACK2_MAX_TARGETS = ConvertUnitState(0x37)
    
    // 攻击2 攻击间隔
    constant unitstate UNIT_STATE_ATTACK2_INTERVAL = ConvertUnitState(0x38)
    
    // 攻击2 攻击延迟
    constant unitstate UNIT_STATE_ATTACK2_INITIAL_DELAY = ConvertUnitState(0x39)
    
    // 攻击2 攻击范围
    constant unitstate UNIT_STATE_ATTACK2_RANGE = ConvertUnitState(0x40)
    
    // 攻击2 攻击缓冲
    constant unitstate UNIT_STATE_ATTACK2_RANGE_BUFFER = ConvertUnitState(0x41)
    
    // 攻击2 最小伤害
    constant unitstate UNIT_STATE_ATTACK2_DAMAGE_MIN = ConvertUnitState(0x42)
    
    // 攻击2 最大伤害
    constant unitstate UNIT_STATE_ATTACK2_DAMAGE_MAX = ConvertUnitState(0x43)
    
    // 攻击2 弹射弧度
    constant unitstate UNIT_STATE_ATTACK2_BACK_SWING = ConvertUnitState(0x44)
    
    // 攻击2 目标允许类型
    constant unitstate UNIT_STATE_ATTACK2_TARGET_TYPES = ConvertUnitState(0x45)
    
    // 攻击2 溅出区域
    constant unitstate UNIT_STATE_ATTACK2_SPILL_DIST = ConvertUnitState(0x46)
    
    // 攻击2 溅出半径
    constant unitstate UNIT_STATE_ATTACK2_SPILL_RADIUS = ConvertUnitState(0x47)
    
    // 攻击2 武器类型
    constant unitstate UNIT_STATE_ATTACK2_WEAPON_TYPE = ConvertUnitState(0x59)
    
    // 装甲类型
    constant unitstate UNIT_STATE_ARMOR_TYPE = ConvertUnitState(0x50)
    
    // 攻速 取百分比
    constant unitstate UNIT_STATE_RATE_OF_FIRE = ConvertUnitState(0x51) // global attack rate of unit, work on both attacks
    // 寻敌 原生cj也有
    constant unitstate UNIT_STATE_ACQUISITION_RANGE = ConvertUnitState(0x52) // how far the unit will automatically look for targets
        
    // 生命恢复 当恢复类型为总是时 不知道如何使其刷新
    constant unitstate UNIT_STATE_LIFE_REGEN = ConvertUnitState(0x53)
    // 魔法恢复  
    constant unitstate UNIT_STATE_MANA_REGEN = ConvertUnitState(0x54)
    
    // 最小射程
    constant unitstate UNIT_STATE_MIN_RANGE = ConvertUnitState(0x55)
    
    // 目标类型
    constant unitstate UNIT_STATE_AS_TARGET_TYPE = ConvertUnitState(0x60)
    
    // 作为目标类型
    constant unitstate UNIT_STATE_TYPE = ConvertUnitState(0x61)
endglobals

globals
    // movetype EXSetUnitMoveType
	constant integer MOVE_TYPE_UNKNOWN               = 0x20 // 未知
	constant integer MOVE_TYPE_FOOT                  = 0x02 // 步行
	constant integer MOVE_TYPE_FLY                   = 0x04 // 飞行
	constant integer MOVE_TYPE_MINES			     = 0x08 // 地雷 
	constant integer MOVE_TYPE_WINDWALK				 = 0x10	// 疾风步

	//constant integer MOVE_TYPE_HORSE                 = ConvertMoveType(4)
	//constant integer MOVE_TYPE_HOVER                 = ConvertMoveType(8)
	constant integer MOVE_TYPE_FLOAT                 = 0x40	// 漂浮(水)
	constant integer MOVE_TYPE_AMPHIBIOUS            = 0x80 // 两栖
	//constant integer MOVE_TYPE_UNBUILDABLE           = ConvertMoveType(64)

	// collisiontype EXSetUnitCollisionType
	constant integer COLLISION_TYPE_UNIT			 = 1
	constant integer COLLISION_TYPE_STRUCTURE		 = 3
endglobals

native EXSetUnitCollisionType takes boolean enable, unit u, integer t returns nothing
native EXSetUnitMoveType takes unit u, integer t returns nothing

//==============================================================================
globals
    // 模型路径
    constant integer UNIT_STRING_MODEL_PATH = 13
    // 大头像模型路径
    constant integer UNIT_STRING_MODEL_PORTRAIT_PATH = 14
    // 单位阴影
    constant integer UNIT_STRING_SHADOW_PATH = 0x13
    // 模型缩放
    constant integer UNIT_REAL_MODEL_SCALE = 0x2c
    // 阴影图像 - X轴偏移
    constant integer UNIT_REAL_SHADOW_X = 0x20
    // 阴影图像 - Y轴偏移
    constant integer UNIT_REAL_SHADOW_Y = 0x21
    // 阴影图像 - 宽度
    constant integer UNIT_REAL_SHADOW_W = 0x22
    // 阴影图像 - 高度
    constant integer UNIT_REAL_SHADOW_H = 0x23
endglobals

native EXGetUnitString takes integer unitcode, integer Type returns string
native EXSetUnitString takes integer unitcode,integer Type,string value returns boolean
native EXGetUnitReal takes integer unitcode, integer Type returns real
native EXSetUnitReal takes integer unitcode,integer Type,real value returns boolean
native EXGetUnitInteger takes integer unitcode, integer Type returns integer
native EXSetUnitInteger takes integer unitcode,integer Type,integer value returns boolean
native EXGetUnitArrayString takes integer unitcode, integer Type,integer index returns string

//==============================================================================
// Items
//==============================================================================
native EXGetItemDataString takes integer itemcode, integer data_type returns string
native EXSetItemDataString takes integer itemcode, integer data_type, string value returns boolean
                
//==============================================================================
// Effects
//==============================================================================
native EXGetEffectX takes effect e returns real
native EXGetEffectY takes effect e returns real
native EXGetEffectZ takes effect e returns real
native EXSetEffectXY takes effect e, real x, real y returns nothing
native EXSetEffectZ takes effect e, real z returns nothing
native EXGetEffectSize takes effect e returns real
native EXSetEffectSize takes effect e, real size returns nothing
native EXEffectMatRotateX takes effect e, real angle returns nothing
native EXEffectMatRotateY takes effect e, real angle returns nothing
native EXEffectMatRotateZ takes effect e, real angle returns nothing //特效面对方向
native EXEffectMatScale takes effect e, real x, real y, real z returns nothing
native EXEffectMatReset takes effect e returns nothing
native EXSetEffectSpeed takes effect e, real speed returns nothing

//==============================================================================
// Buffs
//==============================================================================
// Buff的Japi在1.27a不可用，最新的YDWE版本修复了这个问题，但官方平台上似乎不可用。
native EXGetBuffDataString takes integer buffcode, integer data_type returns string
native EXSetBuffDataString takes integer buffcode, integer data_type, string value returns boolean

endlibrary

library BlzAPI
    globals
        // BlzApi UIEvent 的一些常量
    
        // 按下事件
        constant integer FRAME_EVENT_PRESSED = 1
        // 鼠标进入
        constant integer FRAME_MOUSE_ENTER = 2
        // 鼠标离开
        constant integer FRAME_MOUSE_LEAVE = 3
        // 鼠标按下
        constant integer FRAME_MOUSE_UP = 4
        // 鼠标弹起
        constant integer FRAME_MOUSE_DOWN = 5
        // 鼠标滚轮
        constant integer FRAME_MOUSE_WHEEL = 6
        // 激活焦点
        constant integer FRAME_FOCUS_ENTER = FRAME_MOUSE_ENTER
        // 取消焦点
        constant integer FRAME_FOCUS_LEAVE = FRAME_MOUSE_LEAVE
        // 激活复选框
        constant integer FRAME_CHECKBOX_CHECKED = 7
        // 取消复选框
        constant integer FRAME_CHECKBOX_UNCHECKED = 8
        // 对话框文字改变
        constant integer FRAME_EDITBOX_TEXT_CHANGED = 9
        // 开始弹出菜单项目 (POPUPMENU类似于大厅选种族)
        constant integer FRAME_POPUPMENU_ITEM_CHANGE_START = 10
        // 弹出的菜单项目被更改
        constant integer FRAME_POPUPMENU_ITEM_CHANGED = 11
        // 鼠标双击 但没找到能响应双击事件的UI
        constant integer FRAME_MOUSE_DOUBLECLICK = 12
        // 模型动画更新
        constant integer FRAME_SPRITE_ANIM_UPDATE = 13
    
        // UI Positions framepointtype
    
        // 左上
        constant integer FRAMEPOINT_TOPLEFT = 0
        // 上
        constant integer FRAMEPOINT_TOP = 1
        // 右上
        constant integer FRAMEPOINT_TOPRIGHT = 2
        // 左
        constant integer FRAMEPOINT_LEFT = 3
        // 中间
        constant integer FRAMEPOINT_CENTER = 4
        // 右
        constant integer FRAMEPOINT_RIGHT = 5
        // 左下
        constant integer FRAMEPOINT_BOTTOMLEFT = 6
        // 下
        constant integer FRAMEPOINT_BOTTOM = 7
        // 右下
        constant integer FRAMEPOINT_BOTTOMRIGHT = 8
        
    endglobals

    // 获取鼠标在游戏内的坐标X
    native DzGetMouseTerrainX takes nothing returns real
    // 获取鼠标在游戏内的坐标Y
    native DzGetMouseTerrainY takes nothing returns real
    // 获取鼠标在游戏内的坐标Z
    native DzGetMouseTerrainZ takes nothing returns real
    // 鼠标是否在游戏内
    native DzIsMouseOverUI takes nothing returns boolean
    // 获取鼠标屏幕坐标X
    native DzGetMouseX takes nothing returns integer
    // 获取鼠标屏幕坐标Y
    native DzGetMouseY takes nothing returns integer
    // 获取鼠标游戏窗口坐标X
    native DzGetMouseXRelative takes nothing returns integer
    // 获取鼠标游戏窗口坐标Y
    native DzGetMouseYRelative takes nothing returns integer
    // 设置鼠标位置
    native DzSetMousePos takes integer x, integer y returns nothing
    // 注册鼠标点击触发（sync为true时，调用TriggerExecute。为false时，直接运行action函数，可以异步不掉线，action里不要有同步操作）
    native DzTriggerRegisterMouseEvent takes trigger trig, integer btn, integer status, boolean sync, string func returns nothing
    // 注册鼠标点击触发（sync为true时，调用TriggerExecute。为false时，直接运行action函数，可以异步不掉线，action里不要有同步操作）
    native DzTriggerRegisterMouseEventByCode takes trigger trig, integer btn, integer status, boolean sync, code funcHandle returns nothing
    // 注册键盘点击触发
    native DzTriggerRegisterKeyEvent takes trigger trig, integer key, integer status, boolean sync, string func returns nothing
    // 注册键盘点击触发
    native DzTriggerRegisterKeyEventByCode takes trigger trig, integer key, integer status, boolean sync, code funcHandle returns nothing
    // 注册鼠标滚轮触发
    native DzTriggerRegisterMouseWheelEvent takes trigger trig, boolean sync, string func returns nothing
    // 注册鼠标滚轮触发
    native DzTriggerRegisterMouseWheelEventByCode takes trigger trig, boolean sync, code funcHandle returns nothing
    // 注册鼠标移动触发
    native DzTriggerRegisterMouseMoveEvent takes trigger trig, boolean sync, string func returns nothing
    // 注册鼠标移动触发
    native DzTriggerRegisterMouseMoveEventByCode takes trigger trig, boolean sync, code funcHandle returns nothing
    // 获取触发器的按键码
    native DzGetTriggerKey takes nothing returns integer
    // 获取滚轮delta
    native DzGetWheelDelta takes nothing returns integer
    // 判断按键是否按下
    native DzIsKeyDown takes integer iKey returns boolean
    // 获取触发key的玩家
    native DzGetTriggerKeyPlayer takes nothing returns player
    // 获取war3窗口宽度
    native DzGetWindowWidth takes nothing returns integer
    // 获取war3窗口高度
    native DzGetWindowHeight takes nothing returns integer
    // 获取war3客户窗口宽度
    native DzGetClientWidth takes nothing returns integer
    // 获取war3客户窗口高度
    native DzGetClientHeight takes nothing returns integer
    // 获取war3窗口X坐标
    native DzGetWindowX takes nothing returns integer
    // 获取war3窗口Y坐标
    native DzGetWindowY takes nothing returns integer
    // 注册war3窗口大小变化事件
    native DzTriggerRegisterWindowResizeEvent takes trigger trig, boolean sync, string func returns nothing
    // 注册war3窗口大小变化事件
    native DzTriggerRegisterWindowResizeEventByCode takes trigger trig, boolean sync, code funcHandle returns nothing
    // 判断窗口是否激活
    native DzIsWindowActive takes nothing returns boolean
    // 设置可摧毁物位置
    native DzDestructablePosition takes destructable d, real x, real y returns nothing
    // 设置单位位置-本地调用
    native DzSetUnitPosition takes unit whichUnit, real x, real y returns nothing
    // 异步执行函数
    native DzExecuteFunc takes string funcName returns nothing
    // 取鼠标指向的单位
    native DzGetUnitUnderMouse takes nothing returns unit
    // 设置单位的贴图
    native DzSetUnitTexture takes unit whichUnit, string path, integer texId returns nothing
    //  设置内存数值
    native DzSetMemory takes integer address, real value returns nothing
    //  替换单位类型 [BZAPI]
    native DzSetUnitID takes unit whichUnit, integer id returns nothing
    //  替换单位模型 [BZAPI]
    native DzSetUnitModel takes unit whichUnit, string path returns nothing
    //  原生 - 设置小地图背景贴图
    native DzSetWar3MapMap takes string map returns nothing
    // 注册数据同步触发器
    native DzTriggerRegisterSyncData takes trigger trig, string prefix, boolean server returns nothing
    // 同步游戏数据
    native DzSyncData takes string prefix, string data returns nothing
    // 获取同步的数据
    native DzGetTriggerSyncData takes nothing returns string
    // 获取同步数据的玩家
    native DzGetTriggerSyncPlayer takes nothing returns player
    // 隐藏界面元素
    native DzFrameHideInterface takes nothing returns nothing
    // 修改游戏世界窗口位置
    native DzFrameEditBlackBorders takes real upperHeight, real bottomHeight returns nothing
    // 头像
    native DzFrameGetPortrait takes nothing returns integer
    // 小地图
    native DzFrameGetMinimap takes nothing returns integer
    // 技能按钮
    native DzFrameGetCommandBarButton takes integer row, integer column returns integer
    // 英雄按钮
    native DzFrameGetHeroBarButton takes integer buttonId returns integer
    // 英雄血条
    native DzFrameGetHeroHPBar takes integer buttonId returns integer
    // 英雄蓝条
    native DzFrameGetHeroManaBar takes integer buttonId returns integer
    // 道具按钮
    native DzFrameGetItemBarButton takes integer buttonId returns integer
    // 小地图按钮
    native DzFrameGetMinimapButton takes integer buttonId returns integer
    // 左上菜单按钮
    native DzFrameGetUpperButtonBarButton takes integer buttonId returns integer
    // 鼠标提示
    native DzFrameGetTooltip takes nothing returns integer
    // 聊天信息
    native DzFrameGetChatMessage takes nothing returns integer
    // 单位信息
    native DzFrameGetUnitMessage takes nothing returns integer
    // 获取最上的信息
    native DzFrameGetTopMessage takes nothing returns integer
    // 取rgba色值
    native DzGetColor takes integer r, integer g, integer b, integer a returns integer
    // 设置界面更新回调（非同步）
    native DzFrameSetUpdateCallback takes string func returns nothing
    // 界面更新回调
    native DzFrameSetUpdateCallbackByCode takes code funcHandle returns nothing
    // 显示/隐藏窗体
    native DzFrameShow takes integer frame, boolean enable returns nothing
    // 创建窗体
    native DzCreateFrame takes string frame, integer parent, integer id returns integer
    // 创建简单的窗体
    native DzCreateSimpleFrame takes string frame, integer parent, integer id returns integer
    // 销毁窗体
    native DzDestroyFrame takes integer frame returns nothing
    // 加载内容目录 (Toc table of contents)
    native DzLoadToc takes string fileName returns nothing
    // 设置窗体相对位置 [0:左上|1:上|2:右上|3:左|4:中|5:右|6:左下|7:下|8:右下]
    native DzFrameSetPoint takes integer frame, integer point, integer relativeFrame, integer relativePoint, real x, real y returns nothing
    // 设置窗体绝对位置
    native DzFrameSetAbsolutePoint takes integer frame, integer point, real x, real y returns nothing
    // 清空窗体锚点
    native DzFrameClearAllPoints takes integer frame returns nothing
    // 设置窗体禁用/启用
    native DzFrameSetEnable takes integer name, boolean enable returns nothing
    // 注册用户界面事件回调
    native DzFrameSetScript takes integer frame, integer eventId, string func, boolean sync returns nothing
    //  注册UI事件回调(func handle)
    native DzFrameSetScriptByCode takes integer frame, integer eventId, code funcHandle, boolean sync returns nothing
    // 获取触发用户界面事件的玩家
    native DzGetTriggerUIEventPlayer takes nothing returns player
    // 获取触发用户界面事件的窗体
    native DzGetTriggerUIEventFrame takes nothing returns integer
    // 通过名称查找窗体
    native DzFrameFindByName takes string name, integer id returns integer
    // 通过名称查找普通窗体
    native DzSimpleFrameFindByName takes string name, integer id returns integer
    // 查找字符串
    native DzSimpleFontStringFindByName takes string name, integer id returns integer
    // 查找BACKDROP frame
    native DzSimpleTextureFindByName takes string name, integer id returns integer
    // 获取游戏用户界面
    native DzGetGameUI takes nothing returns integer
    // 点击窗体
    native DzClickFrame takes integer frame returns nothing
    // 自定义屏幕比例
    native DzSetCustomFovFix takes real value returns nothing
    // 使用宽屏模式
    native DzEnableWideScreen takes boolean enable returns nothing
    // 设置文字（支持EditBox, TextFrame, TextArea, SimpleFontString、GlueEditBoxWar3、SlashChatBox、TimerTextFrame、TextButtonFrame、GlueTextButton）
    native DzFrameSetText takes integer frame, string text returns nothing
    // 获取文字（支持EditBox, TextFrame, TextArea, SimpleFontString）
    native DzFrameGetText takes integer frame returns string
    // 设置字数限制（支持EditBox）
    native DzFrameSetTextSizeLimit takes integer frame, integer size returns nothing
    // 获取字数限制（支持EditBox）
    native DzFrameGetTextSizeLimit takes integer frame returns integer
    // 设置文字颜色（支持TextFrame, EditBox）
    native DzFrameSetTextColor takes integer frame, integer color returns nothing
    // 获取鼠标所在位置的用户界面控件指针
    native DzGetMouseFocus takes nothing returns integer
    // 设置所有锚点到目标窗体上
    native DzFrameSetAllPoints takes integer frame, integer relativeFrame returns boolean
    // 设置焦点
    native DzFrameSetFocus takes integer frame, boolean enable returns boolean
    // 设置模型（支持Sprite、Model、StatusBar）
    native DzFrameSetModel takes integer frame, string modelFile, integer modelType, integer flag returns nothing
    // 获取控件是否启用
    native DzFrameGetEnable takes integer frame returns boolean
    // 设置透明度（0-255）
    native DzFrameSetAlpha takes integer frame, integer alpha returns nothing
    // 获取透明度（0-255）
    native DzFrameGetAlpha takes integer frame returns integer
    // 设置动画
    native DzFrameSetAnimate takes integer frame, integer animId, boolean autocast returns nothing
    // 设置动画进度（autocast为false是可用）
    native DzFrameSetAnimateOffset takes integer frame, real offset returns nothing
    // 设置texture（支持Backdrop、SimpleStatusBar）
    native DzFrameSetTexture takes integer frame, string texture, integer flag returns nothing
    // 设置缩放
    native DzFrameSetScale takes integer frame, real scale returns nothing
    // 设置提示
    native DzFrameSetTooltip takes integer frame, integer tooltip returns nothing
    // 鼠标限制在用户界面内
    native DzFrameCageMouse takes integer frame, boolean enable returns nothing
    // 获取当前值（支持Slider、SimpleStatusBar、StatusBar）
    native DzFrameGetValue takes integer frame returns real
    // 设置最大最小值（支持Slider、SimpleStatusBar、StatusBar）
    native DzFrameSetMinMaxValue takes integer frame, real minValue, real maxValue returns nothing
    // 设置Step值（支持Slider）
    native DzFrameSetStepValue takes integer frame, real step returns nothing
    // 设置当前值（支持Slider、SimpleStatusBar、StatusBar）
    native DzFrameSetValue takes integer frame, real value returns nothing
    // 设置窗体大小
    native DzFrameSetSize takes integer frame, real w, real h returns nothing
    // 根据tag创建窗体
    native DzCreateFrameByTagName takes string frameType, string name, integer parent, string template, integer id returns integer
    // 设置颜色（支持SimpleStatusBar）
    native DzFrameSetVertexColor takes integer frame, integer color returns nothing
    // 不明觉厉
    native DzOriginalUIAutoResetPoint takes boolean enable returns nothing
    //  设置优先级 [NEW]
    native DzFrameSetPriority takes integer frame, integer priority returns nothing
    //  设置父窗口 [NEW]
    native DzFrameSetParent takes integer frame, integer parent returns nothing
    //  设置字体 [NEW]
    native DzFrameSetFont takes integer frame, string fileName, real height, integer flag returns nothing
    //  获取 Frame 的 高度 [NEW]
    native DzFrameGetHeight takes integer frame returns real
    //  设置对齐方式 [NEW]
    native DzFrameSetTextAlignment takes integer frame, integer align returns nothing
    //  获取 Frame 的 Parent [NEW]
    native DzFrameGetParent takes integer frame returns integer

    native DzUnitDisableInventory takes unit u, boolean b returns nothing
    native DzUnitDisableAttack takes unit u, boolean b returns nothing
    native DzUnitSilence takes unit u, boolean b returns nothing
        
endlibrary
    
