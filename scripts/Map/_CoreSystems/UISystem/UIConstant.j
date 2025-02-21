
globals
    // 框架相对锚点(UI) 左上
    constant integer FRAMEPOINT_TOPLEFT = (0)
    // 框架相对锚点(UI) 上
    constant integer FRAMEPOINT_TOP = (1)
    // 框架相对锚点(UI) 右上
    constant integer FRAMEPOINT_TOPRIGHT = (2)
    // 框架相对锚点(UI) 左
    constant integer FRAMEPOINT_LEFT = (3)
    // 框架相对锚点(UI) 中
    constant integer FRAMEPOINT_CENTER = (4)
    // 框架相对锚点(UI) 右
    constant integer FRAMEPOINT_RIGHT = (5)
    // 框架相对锚点(UI) 左下
    constant integer FRAMEPOINT_BOTTOMLEFT = (6)
    // 框架相对锚点(UI) 下
    constant integer FRAMEPOINT_BOTTOM = (7)
    // 框架相对锚点(UI) 右下
    constant integer FRAMEPOINT_BOTTOMRIGHT = (8)
    
    // 文本对齐方式 顶部对齐
    constant integer TEXT_JUSTIFY_TOP = (0)
    // 文本对齐方式 纵向居中
    constant integer TEXT_JUSTIFY_MIDDLE = (1)
    // 文本对齐方式 底部对齐
    constant integer TEXT_JUSTIFY_BOTTOM = (2)
    // 文本对齐方式 左侧对齐
    constant integer TEXT_JUSTIFY_LEFT = (3)
    // 文本对齐方式 横向居中
    constant integer TEXT_JUSTIFY_CENTER = (4)
    // 文本对齐方式 右侧对齐
    constant integer TEXT_JUSTIFY_RIGHT = (5)

    // 原生UI 游戏UI(必要，没有它，什么都不显示)
    constant integer ORIGIN_FRAME_GAME_UI = (0)
    // 原生UI 技能按钮(含移动/停止/巡逻/攻击，共12格)
    // 每次选择单位时它会重新出现/更新
    constant integer ORIGIN_FRAME_COMMAND_BUTTON = (1)
    // 原生UI 英雄栏(F1、F2按钮对应的英雄头像所在区域)
    // 所有 HERO_BUTTONS 的父类，由 HeroButtons 控制可见性
    constant integer ORIGIN_FRAME_HERO_BAR = (2)
    // 原生UI 英雄头像(F1、F2...屏幕左侧的自己/共享控制盟友的英雄头像按钮)
    constant integer ORIGIN_FRAME_HERO_BUTTON = (3)
    // 原生UI 英雄头像下的血量条，与 HeroButtons 关联
    constant integer ORIGIN_FRAME_HERO_HP_BAR = (4)
    // 原生UI 英雄头像下的魔法条，与 HeroButtons 关联
    constant integer ORIGIN_FRAME_HERO_MANA_BAR = (5)
    // 原生UI 英雄获得新技能点时，英雄按钮发出的光
    // 与 HeroButtons 关联。当英雄新技能点时，即使所有原生UI都被隐藏，闪光也会出现
    constant integer ORIGIN_FRAME_HERO_BUTTON_INDICATOR = (6)
    // 原生UI 物品栏格按钮(共6格)
    // 当其父级可见时，每次选择物品时它会重新出现/更新
    constant integer ORIGIN_FRAME_ITEM_BUTTON = (7)
    // 原生UI 小地图
    // 使用该类型并不能直接兼容1.36新观战者模式带来的小地图位置变化(使控件位置自动随小地图位置变化)
    constant integer ORIGIN_FRAME_MINIMAP = (8)
    // 原生UI 小地图按钮
    // 0是顶部按钮，到底部的共4个按钮(发送信号、显示/隐藏地形、切换敌友/玩家颜色、显示中立敌对单位营地、编队方式)
    constant integer ORIGIN_FRAME_MINIMAP_BUTTON = (9)
    // 原生UI 系统按钮
    // 菜单，盟友，日志/聊天，任务
    constant integer ORIGIN_FRAME_SYSTEM_BUTTON = (10)
    // 原生UI 提示工具
    constant integer ORIGIN_FRAME_TOOLTIP = (11)
    // 原生UI 扩展提示工具
    constant integer ORIGIN_FRAME_UBERTOOLTIP = (12)
    // 原生UI 聊天信息显示框(玩家聊天信息)
    constant integer ORIGIN_FRAME_CHAT_MSG = (13)
    // 原生UI 单位信息显示框
    constant integer ORIGIN_FRAME_UNIT_MSG = (14)
    // 原生UI 顶部信息显示框(持续显示的变更警告消息，显示在昼夜时钟下方)
    constant integer ORIGIN_FRAME_TOP_MSG = (15)
    // 原生UI 头像(主选单位的模型视图)
    // 模型肖像区域，攻击力左边，看到单位头和嘴巴那块区域，其使用了特殊的协调系统,0在左下角绝对位置，这使得它很难与其他框架一起使用(不像其他4:3)
    constant integer ORIGIN_FRAME_PORTRAIT = (16)
    // 原生UI 世界UI
    // 游戏区域、单位、物品、特效、雾...游戏每个对象都显示在这
    constant integer ORIGIN_FRAME_WORLD_FRAME = (17)
    // 原生UI 简易UI(父级)
    constant integer ORIGIN_FRAME_SIMPLE_UI_PARENT = (18)
    // 原生UI 头像(主选单位的模型视图)(ORIGIN_FRAME_PORTRAIT)下方的生命值文字
    constant integer ORIGIN_FRAME_PORTRAIT_HP_TEXT = (19)
    // 原生UI 头像(主选单位的模型视图)(ORIGIN_FRAME_PORTRAIT)下方的魔法值文字
    constant integer ORIGIN_FRAME_PORTRAIT_MANA_TEXT = (20)
    // 原生UI 魔法效果(BUFF)状态栏(单位当前拥有光环的显示区域)，尺寸固定，最多显示8个BUFF
    constant integer ORIGIN_FRAME_UNIT_PANEL_BUFF_BAR = (21)
    // 原生UI 魔法效果(BUFF)状态栏标题(单位当前拥有光环的显示区域的标题)，默认文本是 Status:(状态：)
    constant integer ORIGIN_FRAME_UNIT_PANEL_BUFF_BAR_LABEL = (22)

    // 点击
    constant integer FRAMEEVENT_CONTROL_CLICK          = 1
    // 进入
    constant integer FRAMEEVENT_MOUSE_ENTER            = 2
    // 离开
    constant integer FRAMEEVENT_MOUSE_LEAVE            = 3
    // 弹起
    constant integer FRAMEEVENT_MOUSE_UP               = 4
    // 按下
    constant integer FRAMEEVENT_MOUSE_DOWN             = 5
    // 滚动
    constant integer FRAMEEVENT_MOUSE_WHEEL            = 6
    // 激活复选框
    constant integer FRAMEEVENT_CHECKBOX_CHECKED       = 7
    // 取消复选框
    constant integer FRAMEEVENT_CHECKBOX_UNCHECKED     = 8
    // 输入框文本变化
    constant integer FRAMEEVENT_EDITBOX_TEXT_CHANGED   = 9
    // 弹起菜单按钮变化
    constant integer FRAMEEVENT_POPUPMENU_ITEM_CHANGED = 10
    // 鼠标双击
    constant integer FRAMEEVENT_MOUSE_DOUBLECLICK      = 11
    // Sprite动画更新
    constant integer FRAMEEVENT_SPRITE_ANIM_UPDATE     = 12
    // 滚动条数值更新
    constant integer FRAMEEVENT_SLIDER_VALUE_CHANGED   = 13
endglobals
