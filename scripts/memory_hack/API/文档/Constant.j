// by Asphodelus
// 该文件仅做文档，不会被编译到地图脚本里



globals

// 标志操作：添加标志
constant integer FLAG_OPERATOR_ADD                          = 0x1
// 标志操作：删除标志
constant integer FLAG_OPERATOR_REMOVE                       = 0x0



// 事件ID：游戏开始
// @Tip：进度条满进入地图的一瞬间, 与0s事件基本等同
constant integer EVENT_ID_GAME_START					    = 0x0
// 事件ID：游戏Tick
// @Tip：同步帧
constant integer EVENT_ID_GAME_TICK					        = 0x1
// 事件ID：任意单位被创建
constant integer EVENT_ID_UNIT_CREATE				        = 0x2
// 事件ID：任意单位被删除
constant integer EVENT_ID_UNIT_REMOVE				        = 0x3
// 事件ID：任意单位攻击出手
// @Tip：前摇结束弹道出现/近战命中的一瞬间
constant integer EVENT_ID_UNIT_ATTACK_LAUNCH			    = 0x4
// 事件ID：任意单位切换仇恨目标
constant integer EVENT_ID_UNIT_SEARCH_TARGET			    = 0x5
// 事件ID：任意单位恢复生命值
constant integer EVENT_ID_UNIT_RESTORE_LIFE			        = 0x6
// 事件ID：任意单位恢复魔法值
constant integer EVENT_ID_UNIT_RESTORE_MANA			        = 0x7
// 事件ID：任意单位被驱散魔法效果
constant integer EVENT_ID_UNIT_DISPEL_BUFF			        = 0x8
// 事件ID：任意单位送回资源
constant integer EVENT_ID_UNIT_HARVEST				        = 0x9
// 事件ID：任意英雄获取经验值
constant integer EVENT_ID_HERO_GET_EXP				        = 0xA
// 事件ID：任意单位接受伤害
// @Tip：可以看做YD伤害事件的替代, 没有泄漏
constant integer EVENT_ID_UNIT_DAMAGE				        = 0xB
// 事件ID：任意单位即将受伤
// @Tip：发生在伤害命中还未开始计算的一瞬间
// 在此事件中获取不到最终伤害
// 在此事件中可以修改伤害来源、受伤单位、攻击类型和伤害类型
constant integer EVENT_ID_UNIT_DAMAGING				        = 0xC
// 事件ID：任意技能被添加
// @Tip：包括魔法效果
constant integer EVENT_ID_ABILITY_ADD				        = 0xD
// 事件ID：任意技能被删除
// @Tip：包括魔法效果
constant integer EVENT_ID_ABILITY_REMOVE				    = 0xE
// 事件ID：任意技能进入冷却
constant integer EVENT_ID_ABILITY_START_COOLDOWN		    = 0xF
// 事件ID：任意技能结束冷却
constant integer EVENT_ID_ABILITY_END_COOLDOWN		        = 0x10
// 事件ID：任意光环技能刷新
constant integer EVENT_ID_ABILITY_REFRESH_AURA		        = 0x11
// 事件ID：任意物品被删除
constant integer EVENT_ID_ITEM_REMOVE				        = 0x12
// 事件ID：任意玩家黄金变动
constant integer EVENT_ID_PLAYER_GOLD_CHANGE			    = 0x13
// 事件ID：任意玩家木材变动
constant integer EVENT_ID_PLAYER_LUMBER_CHANGE		        = 0x14
// 事件ID：任意投射物发射
// @Tip：不建议使用
constant integer EVENT_ID_MISSILE_LAUNCH				    = 0x15
// 事件ID：任意投射物命中
// @Tip：不建议使用
constant integer EVENT_ID_MISSILE_HIT				        = 0x16
// 事件ID：数据同步
// @Tip：同dz的同步
constant integer EVENT_ID_SYNC						        = 0x17
// 事件ID：游戏停止
// 异步事件
constant integer EVENT_ID_GAME_STOP					        = 0x18
// 事件ID：游戏退出
// 异步事件
constant integer EVENT_ID_GAME_EXIT					        = 0x19
// 事件ID：任意玩家离开游戏
// @Tip：包括正常退出和掉线
// 异步事件
constant integer EVENT_ID_PLAYER_LEAVE				        = 0x1A
// 事件ID：鼠标进入Frame
// 异步事件
constant integer EVENT_ID_FRAME_MOUSE_ENTER			        = 0x1B
// 事件ID：鼠标离开Frame
// 异步事件
constant integer EVENT_ID_FRAME_MOUSE_LEAVE			        = 0x1C
// 事件ID：鼠标按下Frame
// @Tip：支持左右键和中键
// 异步事件
constant integer EVENT_ID_FRAME_MOUSE_DOWN			        = 0x1D
// 事件ID：鼠标弹起Frame
// @Tip：支持左右键和中键
// 异步事件
constant integer EVENT_ID_FRAME_MOUSE_UP				    = 0x1E
// 事件ID：鼠标点击Frame
// @Tip：支持左右键和中键
// 异步事件
constant integer EVENT_ID_FRAME_MOUSE_CLICK			        = 0x1F
// 事件ID：鼠标双击Frame
// @Tip：支持左右键和中键
// 异步事件
constant integer EVENT_ID_FRAME_MOUSE_DOUBLE_CLICK	        = 0x20
// 事件ID：鼠标滚动Frame
// @Tip：即鼠标滚轮
// 异步事件
constant integer EVENT_ID_FRAME_MOUSE_SCROLL			    = 0x21
// 事件ID：本地玩家键盘弹起
// 异步事件
constant integer EVENT_ID_KEY_UP						    = 0x22
// 事件ID：本地玩家键盘按下
// 异步事件
constant integer EVENT_ID_KEY_DOWN					        = 0x23
// 事件ID：本地玩家键盘按住
// 异步事件
constant integer EVENT_ID_KEY_HOLD					        = 0x24
// 事件ID：本地玩家鼠标弹起
// 异步事件
constant integer EVENT_ID_MOUSE_UP					        = 0x25
// 事件ID：本地玩家鼠标按下
// 异步事件
constant integer EVENT_ID_MOUSE_DOWN					    = 0x26
// 事件ID：本地玩家鼠标滚动
// 异步事件
constant integer EVENT_ID_MOUSE_SCROLL				        = 0x27
// 事件ID：本地玩家鼠标移动
// 异步事件
constant integer EVENT_ID_MOUSE_MOVE					    = 0x28
// 事件ID：本地玩家按下目标指示器
// @Tip：目标指示器即攻击、技能目标、技能目标点等指示器
// 异步事件
constant integer EVENT_ID_TARGET_INDICATOR			        = 0x29
// 事件ID：本地玩家调起目标指示器
// @Tip：目标指示器即攻击、技能目标、技能目标点等指示器
// 异步事件
constant integer EVENT_ID_CALL_TARGET_MODE			        = 0x2A
// 事件ID：本地玩家调起建造指示器
// @Tip：建造指示器即用于表示建造位置的虚影
// 异步事件
constant integer EVENT_ID_CALL_BUILD_MODE			        = 0x2B
// 事件ID：本地玩家取消指示器
// @Tip：包括各种类型的指示器
// 异步事件
constant integer EVENT_ID_CANCEL_INDICATOR			        = 0x2C
// 事件ID：本地玩家发布无目标命令
// 异步事件
constant integer EVENT_ID_LOCAL_IMMEDIATE_ORDER		        = 0x2D
// 事件ID：本地玩家帧绘制
// 异步事件
constant integer EVENT_ID_FRAME_TICK					    = 0x2E
// 事件ID：血条刷新
// @Tip：Hook了血条设置位置的一瞬间
// 异步事件
constant integer EVENT_ID_REFRESH_HPBAR				        = 0x2F
// 事件ID：预渲染
// @Tip：在此事件中有血条更新, 可以作为血条刷新的替代
// 异步事件
constant integer EVENT_ID_PRERENDER					        = 0x30
// 事件ID：本地玩家改变窗口大小
// 异步事件
constant integer EVENT_ID_WINDOW_RESIZE				        = 0x31






















































// 系统时间：年
constant integer SYSTEM_TIME_YEAR	                        = 0x1
// 系统时间：月
constant integer SYSTEM_TIME_MONTH	                        = 0x2
// 系统时间：日
constant integer SYSTEM_TIME_DAY		                    = 0x3
// 系统时间：时
constant integer SYSTEM_TIME_HOUR	                        = 0x4
// 系统时间：分
constant integer SYSTEM_TIME_MINUTE	                        = 0x5
// 系统时间：秒
constant integer SYSTEM_TIME_SECOND	                        = 0x6
// 系统时间：毫秒
constant integer SYSTEM_TIME_MSECOND	                    = 0x7



// SLK表：技能
constant string SLK_TABLE_ABILITY                           = 0x0
// SLK表：魔法效果
constant string SLK_TABLE_BUFF                              = 0x1
// SLK表：单位
constant string SLK_TABLE_UNIT                              = 0x2
// SLK表：物品
constant string SLK_TABLE_ITEM                              = 0x3
// SLK表：科技
constant string SLK_TABLE_UPGRADE                           = 0x4
// SLK表：地形装饰物
constant string SLK_TABLE_DOODAD                            = 0x5
// SLK表：可破坏物
constant string SLK_TABLE_DESTRUCTABLE                      = 0x6
// SLK表：杂项
constant string SLK_TABLE_MISC                              = 0x7



// 动画类型 - 出生(估计包含训练完成、创建、召唤)
constant integer ANIM_TYPE_BIRTH                            = 0x0
// 动画类型 - 死亡
constant integer ANIM_TYPE_DEATH                            = 0x1
// 动画类型 - 腐烂
constant integer ANIM_TYPE_DECAY                            = 0x2
// 动画类型 - 英雄消散
constant integer ANIM_TYPE_DISSIPATE                        = 0x3
// 动画类型 - 站立
constant integer ANIM_TYPE_STAND                            = 0x4
// 动画类型 - 行走
constant integer ANIM_TYPE_WALK                             = 0x5
// 动画类型 - 攻击
constant integer ANIM_TYPE_ATTACK                           = 0x6
// 动画类型 - 变身
constant integer ANIM_TYPE_MORPH                            = 0x7
// 动画类型 - 睡眠
constant integer ANIM_TYPE_SLEEP                            = 0x8
// 动画类型 - 施法
constant integer ANIM_TYPE_SPELL                            = 0x9
// 动画类型 - 头像视窗
constant integer ANIM_TYPE_PORTRAIT                         = 0xA

// 子动画类型 - 定身
constant subanimtype SUBANIM_TYPE_ROOTED                    = 11
// 子动画类型 - 变形
constant subanimtype SUBANIM_TYPE_ALTERNATE_EX              = 12
// 子动画类型 - 循环
constant subanimtype SUBANIM_TYPE_LOOPING                   = 13
// 子动画类型 - 猛击
constant subanimtype SUBANIM_TYPE_SLAM                      = 14
// 子动画类型 - 投掷
constant subanimtype SUBANIM_TYPE_THROW                     = 15
// 子动画类型 - 尖刺
constant subanimtype SUBANIM_TYPE_SPIKED                    = 16
// 子动画类型 - 快速
constant subanimtype SUBANIM_TYPE_FAST                      = 17
// 子动画类型 - 旋转
constant subanimtype SUBANIM_TYPE_SPIN                      = 18
// 子动画类型 - 就绪
constant subanimtype SUBANIM_TYPE_READY                     = 19
// 子动画类型 - 引导
constant subanimtype SUBANIM_TYPE_CHANNEL                   = 20
// 子动画类型 - 防御
constant subanimtype SUBANIM_TYPE_DEFEND                    = 21
// 子动画类型 - 庆祝胜利
constant subanimtype SUBANIM_TYPE_VICTORY                   = 22
// 子动画类型 - 转身
constant subanimtype SUBANIM_TYPE_TURN                      = 23
// 子动画类型 - 往左
constant subanimtype SUBANIM_TYPE_LEFT                      = 24
// 子动画类型 - 往右
constant subanimtype SUBANIM_TYPE_RIGHT                     = 25
// 子动画类型 - 火焰
constant subanimtype SUBANIM_TYPE_FIRE                      = 26
// 子动画类型 - 血肉
constant subanimtype SUBANIM_TYPE_FLESH                     = 27
// 子动画类型 - 命中
constant subanimtype SUBANIM_TYPE_HIT                       = 28
// 子动画类型 - 受伤
constant subanimtype SUBANIM_TYPE_WOUNDED                   = 29
// 子动画类型 - 发光
constant subanimtype SUBANIM_TYPE_LIGHT                     = 30
// 子动画类型 - 温和
constant subanimtype SUBANIM_TYPE_MODERATE                  = 31
// 子动画类型 - 严厉
constant subanimtype SUBANIM_TYPE_SEVERE                    = 32
// 子动画类型 - 关键
constant subanimtype SUBANIM_TYPE_CRITICAL                  = 33
// 子动画类型 - 完成
constant subanimtype SUBANIM_TYPE_COMPLETE                  = 34
// 子动画类型 - 背运黄金
constant subanimtype SUBANIM_TYPE_GOLD                      = 35
// 子动画类型 - 背运木材
constant subanimtype SUBANIM_TYPE_LUMBER                    = 36
// 子动画类型 - 工作
constant subanimtype SUBANIM_TYPE_WORK                      = 37
// 子动画类型 - 交谈
constant subanimtype SUBANIM_TYPE_TALK                      = 38
// 子动画类型 - 第一
constant subanimtype SUBANIM_TYPE_FIRST                     = 39
// 子动画类型 - 第二
constant subanimtype SUBANIM_TYPE_SECOND                    = 40
// 子动画类型 - 第三
constant subanimtype SUBANIM_TYPE_THIRD                     = 41
// 子动画类型 - 第四
constant subanimtype SUBANIM_TYPE_FOURTH                    = 42
// 子动画类型 - 第五
constant subanimtype SUBANIM_TYPE_FIFTH                     = 43
// 子动画类型 - 一
constant subanimtype SUBANIM_TYPE_ONE                       = 44
// 子动画类型 - 二
constant subanimtype SUBANIM_TYPE_TWO                       = 45
// 子动画类型 - 三
constant subanimtype SUBANIM_TYPE_THREE                     = 46
// 子动画类型 - 四
constant subanimtype SUBANIM_TYPE_FOUR                      = 47
// 子动画类型 - 五
constant subanimtype SUBANIM_TYPE_FIVE                      = 48
// 子动画类型 - 小
constant subanimtype SUBANIM_TYPE_SMALL                     = 49
// 子动画类型 - 中
constant subanimtype SUBANIM_TYPE_MEDIUM                    = 50
// 子动画类型 - 大
constant subanimtype SUBANIM_TYPE_LARGE                     = 51
// 子动画类型 - 升级
constant subanimtype SUBANIM_TYPE_UPGRADE                   = 52
// 子动画类型 - 吸取
constant subanimtype SUBANIM_TYPE_DRAIN                     = 53
// 子动画类型 - 吞噬
constant subanimtype SUBANIM_TYPE_FILL                      = 54
// 子动画类型 - 闪电链
constant subanimtype SUBANIM_TYPE_CHAINLIGHTNING            = 55
// 子动画类型 - 吃树
constant subanimtype SUBANIM_TYPE_EATTREE                   = 56
// 子动画类型 - 呕吐
constant subanimtype SUBANIM_TYPE_PUKE                      = 57
// 子动画类型 - 抽打
constant subanimtype SUBANIM_TYPE_FLAIL                     = 58
// 子动画类型 - 关闭
constant subanimtype SUBANIM_TYPE_OFF                       = 59
// 子动画类型 - 游泳
constant subanimtype SUBANIM_TYPE_SWIM                      = 60
// 子动画类型 - 缠绕
constant subanimtype SUBANIM_TYPE_ENTANGLE                  = 61
// 子动画类型 - 狂暴
constant subanimtype SUBANIM_TYPE_BERSERK                   = 62



// 镜像轴：XY平面
constant integer MIRROR_AXIS_XY                             = 0x1
// 镜像轴：XZ平面
constant integer MIRROR_AXIS_XZ                             = 0x2
// 镜像轴：YZ平面
constant integer MIRROR_AXIS_YZ                             = 0x3



// 锚点：左上
constant integer ANCHOR_TOP_LEFT                            = 0x0
// 锚点：顶部
constant integer ANCHOR_TOP                                 = 0x1
// 锚点：右上
constant integer ANCHOR_TOP_RIGHT                           = 0x2
// 锚点：左侧
constant integer ANCHOR_LEFT                                = 0x3
// 锚点：中心
constant integer ANCHOR_CENTER                              = 0x4
// 锚点：右侧
constant integer ANCHOR_RIGHT                               = 0x5
// 锚点：左下
constant integer ANCHOR_BOTTOM_LEFT                         = 0x6
// 锚点：底部
constant integer ANCHOR_BOTTOM                              = 0x7
// 锚点：右下
constant integer ANCHOR_BOTTOM_RIGHT                        = 0x8



// Layer标志：视口
// @Tip：添加后超出边缘的子级部分不会渲染
constant integer LAYER_STYLE_VIEW_PORT                      = 0x1
// Layer标志：忽视追踪事件
// @Tip：删去后可让BACKDROP之类的ui不能被鼠标穿过
constant integer LAYER_STYLE_IGNORE_TRACK_EVENT             = 0x2



// CSimpleButton状态：禁用
constant integer SIMPLEBUTTON_STATE_DISABLE                 = 0x0
// CSimpleButton状态：启用
constant integer SIMPLEBUTTON_STATE_ENABLE                  = 0x1
// CSimpleButton状态：按下
constant integer SIMPLEBUTTON_STATE_PUSHED                  = 0x2



// 文本垂直对齐方式：顶部
constant integer TEXT_VERTEX_ALIGN_TOP                      = 0x0
// 文本垂直对齐方式：中心
constant integer TEXT_VERTEX_ALIGN_CENTER                   = 0x1
// 文本垂直对齐方式：底部
constant integer TEXT_VERTEX_ALIGN_BOTTOM                   = 0x2

// 文本水平对齐方式：左边
constant integer TEXT_HORIZON_ALIGN_LEFT                    = 0x3
// 文本水平对齐方式：中心
constant integer TEXT_HORIZON_ALIGN_CENTER                  = 0x4
// 文本水平对齐方式：右边
constant integer TEXT_HORIZON_ALIGN_RIGHT                   = 0x5



// 目标允许：地形
constant integer TARGET_ALLOW_TERRAIN                       = 0x0
// 目标允许：没有
constant integer TARGET_ALLOW_NONE                          = 0x1
// 目标允许：地面
constant integer TARGET_ALLOW_GROUND                        = 0x2
// 目标允许：空中
constant integer TARGET_ALLOW_AIR                           = 0x4
// 目标允许：建筑
constant integer TARGET_ALLOW_STRUCTURE                     = 0x8
// 目标允许：守卫
constant integer TARGET_ALLOW_WARD                          = 0x10
// 目标允许：物品
constant integer TARGET_ALLOW_ITEM                          = 0x20
// 目标允许：树木
constant integer TARGET_ALLOW_TREE                          = 0x40
// 目标允许：墙
constant integer TARGET_ALLOW_WALL                          = 0x80
// 目标允许：残骸
constant integer TARGET_ALLOW_DEBRIS                        = 0x100
// 目标允许：装饰物
constant integer TARGET_ALLOW_DECORATION                    = 0x200
// 目标允许：桥
constant integer TARGET_ALLOW_BRIDGE                        = 0x400
// 目标允许：自己
constant integer TARGET_ALLOW_SELF                          = 0x1000
// 目标允许：玩家单位
constant integer TARGET_ALLOW_PLAYER                        = 0x2000
// 目标允许：联盟
constant integer TARGET_ALLOW_ALLIES                        = 0x4000
// 目标允许：友军单位
// @Tip：等价于 玩家单位 + 联盟
constant integer TARGET_ALLOW_FRIEND                        = 0x6000
// 目标允许：中立
constant integer TARGET_ALLOW_NEUTRAL                       = 0x8000
// 目标允许：敌人
constant integer TARGET_ALLOW_ENEMIES                       = 0x10000
// 目标允许：别人
// @Tip：等价于 玩家单位 + 联盟 + 中立 + 敌人
constant integer TARGET_ALLOW_NOTSELF                       = 0x1E000
// 目标允许：可攻击的
constant integer TARGET_ALLOW_VULNERABLE                    = 0x100000
// 目标允许：无敌
constant integer TARGET_ALLOW_INVULNERABLE                  = 0x200000
// 目标允许：英雄
constant integer TARGET_ALLOW_HERO                          = 0x400000
// 目标允许：非 - 英雄
constant integer TARGET_ALLOW_NONHERO                       = 0x800000
// 目标允许：存活
constant integer TARGET_ALLOW_ALIVE                         = 0x1000000
// 目标允许：死亡
constant integer TARGET_ALLOW_DEAD                          = 0x2000000
// 目标允许：有机生物
constant integer TARGET_ALLOW_ORGANIC                       = 0x4000000
// 目标允许：机械类
constant integer TARGET_ALLOW_MECHANICAL                    = 0x8000000
// 目标允许：非 - 自爆工兵
constant integer TARGET_ALLOW_NONSAPPER                     = 0x10000000
// 目标允许：自爆工兵
constant integer TARGET_ALLOW_SAPPER                        = 0x20000000
// 目标允许：非 - 古树
constant integer TARGET_ALLOW_NONANCIENT                    = 0x40000000
// 目标允许：古树
constant integer TARGET_ALLOW_ANCIENT                       = 0x80000000



// 显示释放边框
constant integer ABILITY_FLAG_ON_CAST			            = 0x1
// 开启
// @Tip：显示上的开启; 开关类技能实际的开启; 开关光环技能的刷新
constant integer ABILITY_FLAG_SWITCH_ON			            = 0x80
// 冷却中
// @Tip：同时也是被动技能的发动
constant integer ABILITY_FLAG_ON_COOLDOWN		            = 0x200
// 无视冷却
constant integer ABILITY_FLAG_IGNORE_COOLDOWN	            = 0x400
// 来自于物品
constant integer ABILITY_FLAG_FROM_ITEM			            = 0x2000
// 开启自动释放
// @Tip：自动释放类技能实际作用的开启
constant integer ABILITY_FLAG_AUTO_CAST_ON		            = 0x80000

// 技能释放类型：无目标
constant integer ABILITY_CAST_TYPE_NONTARGET                = 0x1
// 技能释放类型：点目标
constant integer ABILITY_CAST_TYPE_POINT                    = 0x2
// 技能释放类型：指定物体目标
constant integer ABILITY_CAST_TYPE_TARGET                   = 0x4
// 技能释放类型：单独释放
constant integer ABILITY_CAST_TYPE_ALONE                    = 0x100000
// 技能释放类型：命令恢复
constant integer ABILITY_CAST_TYPE_RESTORE                  = 0x200000
// 技能释放类型：目标选取图像
constant integer ABILITY_CAST_TYPE_AREA                     = 0x1000000
// 技能释放类型：立即释放
constant integer ABILITY_CAST_TYPE_INSTANT                  = 0x2000000

// 技能命令：释放命令
constant integer ABILITY_ORDER_FLAG_CAST                    = 0x1
// 技能命令：开启命令
constant integer ABILITY_ORDER_FLAG_ON                      = 0x2
// 技能命令：关闭命令
constant integer ABILITY_ORDER_FLAG_OFF                     = 0x3

// 技能物编整数数据：基础ID
constant integer ABILITY_DEF_DATA_BASE_ID					= 0x0
// 技能物编整数数据：等级要求
constant integer ABILITY_DEF_DATA_REQ_LEVEL					= 0x1
// 技能物编整数数据：最大等级
constant integer ABILITY_DEF_DATA_MAX_LEVEL					= 0x2
// 技能物编整数数据：跳级要求
constant integer ABILITY_DEF_DATA_LEVEL_SKIP				= 0x3
// 技能物编整数数据：魔法偷取优先权
constant integer ABILITY_DEF_DATA_PRIORITY					= 0x4
// 技能物编整数数据：按钮位置 - 普通(X)
constant integer ABILITY_DEF_DATA_BUTTON_X					= 0x5
// 技能物编整数数据：按钮位置 - 普通(Y)
constant integer ABILITY_DEF_DATA_BUTTON_Y					= 0x6
// 技能物编整数数据：按钮位置 - 关闭(X)
constant integer ABILITY_DEF_DATA_UNBUTTON_X			    = 0x7
// 技能物编整数数据：按钮位置 - 关闭(Y)
constant integer ABILITY_DEF_DATA_UNBUTTON_Y			    = 0x8
// 技能物编整数数据：按钮位置 - 研究(X)
constant integer ABILITY_DEF_DATA_RESEARCH_BUTTON_X			= 0x9
// 技能物编整数数据：按钮位置 - 研究(Y)
constant integer ABILITY_DEF_DATA_RESEARCH_BUTTON_Y			= 0xA
// 技能物编整数数据：热键 - 普通
constant integer ABILITY_DEF_DATA_HOTKEY				    = 0xB
// 技能物编整数数据：热键 - 关闭
constant integer ABILITY_DEF_DATA_UNHOTKEY					= 0xC
// 技能物编整数数据：热键 - 学习
constant integer ABILITY_DEF_DATA_RESEARCH_HOTKEY           = 0xD
// 技能物编整数数据:
constant integer ABILITY_DEF_DATA_CASTER_ART_COUNT			= 0xE
// 技能物编整数数据:
constant integer ABILITY_DEF_DATA_TARGET_ART_COUNT			= 0xF
// 技能物编整数数据:
constant integer ABILITY_DEF_DATA_EFFECT_ART_COUNT			= 0x10
// 技能物编整数数据:
constant integer ABILITY_DEF_DATA_MISSILE_ART_COUNT			= 0x11
// 技能物编整数数据:
constant integer ABILITY_DEF_DATA_SPECIAL_ART_COUNT			= 0x12
// 技能物编整数数据:
constant integer ABILITY_DEF_DATA_LIGHTNING_EFFECT_COUNT    = 0x13
// 技能物编整数数据:
constant integer ABILITY_DEF_DATA_CASTER_ATTACH_COUNT		= 0x14
// 技能物编整数数据:
constant integer ABILITY_DEF_DATA_TARGET_ATTACH_COUNT		= 0x15
// 技能物编实数数据：射弹速率
constant integer ABILITY_DEF_DATA_MISSILE_SPEED				= 0x16
// 技能物编实数数据：射弹弧度
constant integer ABILITY_DEF_DATA_MISSILE_ARC				= 0x17
// 技能物编布尔值数据：射弹自导允许
constant integer ABILITY_DEF_DATA_MISSILE_HOMING		    = 0x18
// 技能物编字符串数据：名称
constant integer ABILITY_DEF_DATA_NAME						= 0x19
// 技能物编字符串数据：图标 - 普通
constant integer ABILITY_DEF_DATA_ART						= 0x1A
// 技能物编字符串数据：图标 - 关闭
constant integer ABILITY_DEF_DATA_UN_ART				    = 0x1B
// 技能物编字符串数据：图标 - 学习
constant integer ABILITY_DEF_DATA_RESEARCH_ART				= 0x1C
// 技能物编字符串数据：提示工具 - 学习
constant integer ABILITY_DEF_DATA_RESEARCH_TIP				= 0x1D
// 技能物编字符串数据：提示工具 - 学习 - 扩展
constant integer ABILITY_DEF_DATA_RESEARCH_UBERTIP			= 0x1E
// 技能物编字符串数据：音效
constant integer ABILITY_DEF_DATA_EFFECT_SOUND				= 0x1F
// 技能物编字符串数据：音效 (循环)
constant integer ABILITY_DEF_DATA_EFFECT_SOUND_LOOPED		= 0x20
// 技能物编字符串数据：全局提示
constant integer ABILITY_DEF_DATA_GLOBAL_MESSAGE		    = 0x21
// 技能物编字符串数据：全局音效
constant integer ABILITY_DEF_DATA_GLOBAL_SOUND				= 0x22

// 技能物编整数等级数据：目标允许
constant integer ABILITY_LEVEL_DEF_DATA_TARGET_ALLOW	    = 0x0
// 技能物编整数等级数据：魔法消耗
constant integer ABILITY_LEVEL_DEF_DATA_MANA_COST			= 0x1
// 技能物编整数等级数据：召唤单位类型
constant integer ABILITY_LEVEL_DEF_DATA_UNIT_ID				= 0x2
// 技能物编实数等级数据：魔法施放时间
constant integer ABILITY_LEVEL_DEF_DATA_CAST_TIME			= 0x3
// 技能物编实数等级数据：持续时间 - 普通
constant integer ABILITY_LEVEL_DEF_DATA_NORMAL_DUR			= 0x4
// 技能物编实数等级数据：持续时间 - 英雄
constant integer ABILITY_LEVEL_DEF_DATA_HERO_DUR		    = 0x5
// 技能物编实数等级数据：冷却时间
constant integer ABILITY_LEVEL_DEF_DATA_COOLDOWN		    = 0x6
// 技能物编实数等级数据：影响区域
constant integer ABILITY_LEVEL_DEF_DATA_AREA			    = 0x7
// 技能物编实数等级数据：施法距离
constant integer ABILITY_LEVEL_DEF_DATA_RANGE				= 0x8
// 技能物编实数等级数据：数据A
constant integer ABILITY_LEVEL_DEF_DATA_DATA_A				= 0x9
// 技能物编实数等级数据：数据B
constant integer ABILITY_LEVEL_DEF_DATA_DATA_B				= 0xA
// 技能物编实数等级数据：数据C
constant integer ABILITY_LEVEL_DEF_DATA_DATA_C				= 0xB
// 技能物编实数等级数据：数据D
constant integer ABILITY_LEVEL_DEF_DATA_DATA_D				= 0xC
// 技能物编实数等级数据：数据E
constant integer ABILITY_LEVEL_DEF_DATA_DATA_E				= 0xD
// 技能物编实数等级数据：数据F
constant integer ABILITY_LEVEL_DEF_DATA_DATA_F				= 0xE
// 技能物编实数等级数据：数据G
constant integer ABILITY_LEVEL_DEF_DATA_DATA_G				= 0xF
// 技能物编实数等级数据：数据H
constant integer ABILITY_LEVEL_DEF_DATA_DATA_H				= 0x10
// 技能物编实数等级数据：数据I
constant integer ABILITY_LEVEL_DEF_DATA_DATA_I				= 0x11
// 技能物编字符串等级数据：提示工具 - 普通
constant integer ABILITY_LEVEL_DEF_DATA_TIP					= 0x12		
// 技能物编字符串等级数据：提示工具 - 关闭
constant integer ABILITY_LEVEL_DEF_DATA_UN_TIP				= 0x13		
// 技能物编字符串等级数据：提示工具 - 普通 - 扩展
constant integer ABILITY_LEVEL_DEF_DATA_UBERTIP				= 0x14		
// 技能物编字符串等级数据：提示工具 - 关闭 - 扩展
constant integer ABILITY_LEVEL_DEF_DATA_UNUBERTIP			= 0x15
// 技能物编字符串等级数据：
constant integer ABILITY_LEVEL_DEF_DATA_CASTER_ART			= 0x16		
// 技能物编字符串等级数据：
constant integer ABILITY_LEVEL_DEF_DATA_TARGET_ART			= 0x17		
// 技能物编字符串等级数据：
constant integer ABILITY_LEVEL_DEF_DATA_EFFECT_ART			= 0x18		
// 技能物编字符串等级数据：
constant integer ABILITY_LEVEL_DEF_DATA_MISSILE_ART			= 0x19		
// 技能物编字符串等级数据：
constant integer ABILITY_LEVEL_DEF_DATA_SPECIAL_ART			= 0x1A		
// 技能物编字符串等级数据：
constant integer ABILITY_LEVEL_DEF_DATA_LIGHTNING_EFFECT    = 0x1B

// 技能极性：光环
constant integer ABILITY_POLARITY_AURA			            = 0x0 
// 技能极性：物理
constant integer ABILITY_POLARITY_PHYSICAL		            = 0x1 
// 技能极性：魔法
constant integer ABILITY_POLARITY_MAGIC			            = 0x2

// BUFF模板：'Binf' 心灵之火
constant integer BUFF_TEMPLATE_BINF                         'Binf' 
// BUFF模板：'Bslo' 减速
constant integer BUFF_TEMPLATE_BSLO                         'Bslo' 
// BUFF模板：'Bblo' 嗜血术
constant integer BUFF_TEMPLATE_BBLO                         'Bblo' 
// BUFF模板：'Blsh' 闪电护盾
constant integer BUFF_TEMPLATE_BLSH                         'Blsh' 
// BUFF模板：'BUfa' 霜冻护甲
constant integer BUFF_TEMPLATE_BUFA                         'BUfa' 
// BUFF模板：'Bcri' 残废
constant integer BUFF_TEMPLATE_BCRI                         'Bcri' 
// BUFF模板：'BUhf' 邪恶狂热
constant integer BUFF_TEMPLATE_BUHF                         'BUhf' 
// BUFF模板：'Bcrs' 诅咒
constant integer BUFF_TEMPLATE_BCRS                         'Bcrs' 
// BUFF模板：'BEsh' 暗影突袭
constant integer BUFF_TEMPLATE_BESH                         'BEsh' 
// BUFF模板：'Bfea' 精灵之火
constant integer BUFF_TEMPLATE_BFAE                         'Bfae' 
// BUFF模板：'Broa' 咆哮
constant integer BUFF_TEMPLATE_BROA                         'Broa' 
// BUFF模板：'BNht' 恐怖嚎叫
constant integer BUFF_TEMPLATE_BNHT                         'BNht' 
// BUFF模板：'BNab' 酸性炸弹
constant integer BUFF_TEMPLATE_BNAB                         'BNab' 
// BUFF模板：'BNso' 灵魂燃烧
constant integer BUFF_TEMPLATE_BNSO                         'BNso' 
// BUFF模板：'BNdh' 醉酒云雾
constant integer BUFF_TEMPLATE_BNDH                         'BNdh' 

// 魔法效果极性：正面
constant integer BUFF_POLARITY_POSITIVE		                = 0x0
// 魔法效果极性：负面
constant integer BUFF_POLARITY_NEGATIVE		                = 0x1
// 魔法效果极性：光环
constant integer BUFF_POLARITY_AURA			                = 0x2
// 魔法效果极性：生命周期
constant integer BUFF_POLARITY_TIMED_LIFE	                = 0x3
// 魔法效果极性：物理
constant integer BUFF_POLARITY_PHYSICAL		                = 0x4
// 魔法效果极性：魔法
constant integer BUFF_POLARITY_MAGIC			            = 0x5
// 魔法效果极性：不可驱散
constant integer BUFF_POLARITY_CANT_DISPEL	                = 0x6



// 单位数据：最大生命值
constant integer UNIT_DATA_MAX_LIFE		                    = 0x1
// 单位数据：最大魔法值
constant integer UNIT_DATA_MAX_MANA                         = 0x2
// 单位数据：生命恢复速度
// @Tip：游戏不会存储真实生命值，仅记录基础生命值和上次更改基础生命值的时间戳
// 当需要用到真实生命值的时候，才会计算：基础生命值 + (当前时间戳 - 上次的时间戳) * 生命恢复速度
// 当受到伤害、治疗或者触发器等外界因素影响生命值时就会更新基础生命值和时间戳
constant integer UNIT_DATA_LIFE_REGEN                       = 0x3
// 单位数据：魔法恢复速度
// @Tip：游戏不会存储真实魔法值，仅记录基础魔法值和上次更改基础魔法值的时间戳
// 当需要用到真实魔法值的时候，才会计算：基础魔法值 + (当前时间戳 - 上次的时间戳) * 魔法恢复速度
// 当恢复魔法或者触发器等外界因素影响魔法值时就会更新基础魔法值和时间戳
constant integer UNIT_DATA_MANA_REGEN                       = 0x4
// 单位数据：护甲值
// @Tip：指的是白字 + 绿字，若设置护甲值则会反映到白字护甲值上面
constant integer UNIT_DATA_DEF_VALUE                        = 0x5
// 单位数据：护甲类型
// @Tip：0 = 轻甲; 1 = 中甲; 2 = 重甲; 3 = 城甲; 
// 4 = 普通甲; 5 = 英雄甲; 6 = 神圣甲; 7 = 无护甲
constant integer UNIT_DATA_DEF_TYPE                         = 0x6
// 单位数据：Z轴坐标
constant integer UNIT_DATA_POSITION_Z                       = 0x7
// 单位数据：当前视野
// @Tip：不会超过1800
constant integer UNIT_DATA_CUR_SIGHT                        = 0x8
// 单位数据：射弹碰撞偏移 - Z
constant integer UNIT_DATA_IMPACT_Z                         = 0x9
// 单位数据：射弹碰撞偏移 - Z (深水)
constant integer UNIT_DATA_IMPACT_Z_SWIM                    = 0xA
// 单位数据：射弹偏移 - X
constant integer UNIT_DATA_LAUNCH_X                         = 0xB
// 单位数据：射弹偏移 - Y
constant integer UNIT_DATA_LAUNCH_Y                         = 0xC
// 单位数据：射弹偏移 - Z
constant integer UNIT_DATA_LAUNCH_Z                         = 0xD
// 单位数据：射弹偏移 - Z (深水)
constant integer UNIT_DATA_LAUNCH_Z_SWIM                    = 0xE
// 单位数据：模型缩放
constant integer UNIT_DATA_MODEL_SCALE                      = 0xF
// 单位数据：Z轴缩放
// @Tip：可以设置，但是当单位有了新的动作后就会恢复
constant integer UNIT_DATA_Z_SCALE                          = 0x10
// 单位数据：血条高度
constant integer UNIT_DATA_HPBAR_HEIGHT                     = 0x11
// 单位数据：动画播放速度
constant integer UNIT_DATA_TIME_SCALE                       = 0x12
// 单位数据：碰撞大小
constant integer UNIT_DATA_COLLISION                        = 0x13
// 单位数据：附加移速
constant integer UNIT_DATA_BONUS_MOVESPEED                  = 0x14



// 单位攻击整数数据：攻击索引
// @Tip：取值范围为0~3。其中0代表不能攻击，3代表攻击1和攻击2
constant integer UNIT_ATK_DATA_WEAPONS_ON                   = 0x1
// 单位攻击整数数据：攻击类型1
// @Tip：取值范围参考common.j中对ConvertAttackType函数的调用
constant integer UNIT_ATK_DATA_ATTACK_TYPE1                 = 0x2
// 单位攻击整数数据：攻击类型2
// @Tip：取值范围参考common.j中对ConvertAttackType函数的调用
constant integer UNIT_ATK_DATA_ATTACK_TYPE2                 = 0x3
// 单位攻击整数数据：武器类型1
// @Tip：指近战、箭矢等武器类型
constant integer UNIT_ATK_DATA_WEAPON_TYPE1                 = 0x4
// 单位攻击整数数据：武器类型2
// @Tip：指近战、箭矢等武器类型
constant integer UNIT_ATK_DATA_WEAPON_TYPE2                 = 0x5
// 单位攻击整数数据：目标允许1
// @Tip：本质是BitSet。取值范围参考文档中的目标允许常数
constant integer UNIT_ATK_DATA_TARGET_ALLOW1                = 0x6
// 单位攻击整数数据：目标允许2
// @Tip：本质是BitSet。取值范围参考文档中的目标允许常数
constant integer UNIT_ATK_DATA_TARGET_ALLOW2                = 0x7
// 单位攻击整数数据：最大目标数1
// @Tip：仅对弹射攻击有效
constant integer UNIT_ATK_DATA_TARGET_COUNT1                = 0x8
// 单位攻击整数数据：最大目标数2
// @Tip：仅对弹射攻击有效
constant integer UNIT_ATK_DATA_TARGET_COUNT2                = 0x9
// 单位攻击整数数据：基础伤害1
constant integer UNIT_ATK_DATA_BASE_DAMAGE1                 = 0xA
// 单位攻击整数数据：基础伤害2
constant integer UNIT_ATK_DATA_BASE_DAMAGE2                 = 0xB
// 单位攻击整数数据：附加伤害1
// @Tip：若设置则会反映到基础伤害上
constant integer UNIT_ATK_DATA_BONUS_DAMAGE1                = 0xC
// 单位攻击整数数据：附加伤害2
// @Tip：若设置则会反映到基础伤害上
constant integer UNIT_ATK_DATA_BONUS_DAMAGE2                = 0xD
// 单位攻击整数数据：伤害骰子数量1
constant integer UNIT_ATK_DATA_DAMAGE_DICE1                 = 0xE
// 单位攻击整数数据：伤害骰子数量2
constant integer UNIT_ATK_DATA_DAMAGE_DICE2                 = 0xF
// 单位攻击整数数据：伤害骰子面数1
constant integer UNIT_ATK_DATA_DAMAGE_SIDES1                = 0x10
// 单位攻击整数数据：伤害骰子面数2
constant integer UNIT_ATK_DATA_DAMAGE_SIDES2                = 0x11
// 单位攻击整数数据：武器声音
// @Tip：取值范围参考common.j中对ConvertWeaponType函数的调用
constant integer UNIT_ATK_DATA_WEAPON_SOUND                 = 0x12

// 单位攻击实数数据：攻击速度
// @Tip：指的攻速增幅，同时影响攻击1和攻击2
// 1代表无增幅初始状态。默认最大限制为5，最小限制为0.25
constant integer UNIT_ATK_DATA_ATTACK_SPEED                 = 0x13
// 单位攻击实数数据：主动攻击范围
constant integer UNIT_ATK_DATA_ACQUISION_RANGE              = 0x14
// 单位攻击实数数据：最小攻击范围
constant integer UNIT_ATK_DATA_MIN_RANGE                    = 0x15
// 单位攻击实数数据：攻击范围1
// @Tip：可以设置得比主动攻击范围大，单位不会主动攻击但可手动攻击
constant integer UNIT_ATK_DATA_ATTACK_RANGE1                = 0x16
// 单位攻击实数数据：攻击范围2
// @Tip：可以设置得比主动攻击范围大，单位不会主动攻击但可手动攻击
constant integer UNIT_ATK_DATA_ATTACK_RANGE2                = 0x17
// 单位攻击实数数据：攻击范围缓冲1
constant integer UNIT_ATK_DATA_RANGE_BUFFER1                = 0x18
// 单位攻击实数数据：攻击范围缓冲2
constant integer UNIT_ATK_DATA_RANGE_BUFFER2                = 0x19
// 单位攻击实数数据：攻击间隔1
constant integer UNIT_ATK_DATA_BAT1                         = 0x1A
// 单位攻击实数数据：攻击间隔2
constant integer UNIT_ATK_DATA_BAT2                         = 0x1B
// 单位攻击实数数据：攻击前摇1
constant integer UNIT_ATK_DATA_ATTACK_POINT1                = 0x1C
// 单位攻击实数数据：攻击前摇2
constant integer UNIT_ATK_DATA_ATTACK_POINT2                = 0x1D
// 单位攻击实数数据：攻击后摇1
constant integer UNIT_ATK_DATA_BACK_SWING1                  = 0x1E
// 单位攻击实数数据：攻击后摇2
constant integer UNIT_ATK_DATA_BACK_SWING2                  = 0x1F
// 单位攻击实数数据：中伤害参数1
constant integer UNIT_ATK_DATA_HALF_FACTOR1		            = 0x20
// 单位攻击实数数据：中伤害参数2
constant integer UNIT_ATK_DATA_HALF_FACTOR2		            = 0x21
// 单位攻击实数数据：小伤害参数1
constant integer UNIT_ATK_DATA_SMALL_FACTOR1		        = 0x22
// 单位攻击实数数据：小伤害参数2
constant integer UNIT_ATK_DATA_SMALL_FACTOR2		        = 0x23
// 单位攻击实数数据：全伤害范围1
constant integer UNIT_ATK_DATA_FULL_AREA1	                = 0x24
// 单位攻击实数数据：全伤害范围2
constant integer UNIT_ATK_DATA_FULL_AREA2	                = 0x25
// 单位攻击实数数据：中伤害范围1
constant integer UNIT_ATK_DATA_HALF_AREA1	                = 0x26
// 单位攻击实数数据：中伤害范围2
constant integer UNIT_ATK_DATA_HALF_AREA2	                = 0x27
// 单位攻击实数数据：小伤害范围1
constant integer UNIT_ATK_DATA_SMALL_AREA1		            = 0x28
// 单位攻击实数数据：小伤害范围2
constant integer UNIT_ATK_DATA_SMALL_AREA2		            = 0x29

// 单位物编整数数据：单位ID
constant integer UNIT_DEF_DATA_ID						    = 0x1
// 单位物编整数数据：建造时间
constant integer UNIT_DEF_DATA_BUILD_TIME				    = 0x2
// 单位物编整数数据：修理时间
constant integer UNIT_DEF_DATA_REPAIR_TIME			        = 0x3
// 单位物编整数数据：黄金消耗
constant integer UNIT_DEF_DATA_GOLD_COST				    = 0x4
// 单位物编整数数据：木材消耗
constant integer UNIT_DEF_DATA_LUMBER_COST			        = 0x5
// 单位物编整数数据：黄金奖励 - 骰子数量
constant integer UNIT_DEF_DATA_GOLD_BOUNTY_DICE		        = 0x6
// 单位物编整数数据：黄金奖励 - 骰子面数
constant integer UNIT_DEF_DATA_GOLD_BOUNTY_SIDES		    = 0x7
// 单位物编整数数据：黄金奖励 - 基础值
constant integer UNIT_DEF_DATA_GOLD_BOUNTY_BASE		        = 0x8
// 单位物编整数数据：木材奖励 - 骰子数量
constant integer UNIT_DEF_DATA_LUMBER_BOUNTY_DICE		    = 0x9
// 单位物编整数数据：木材奖励 - 骰子面数
constant integer UNIT_DEF_DATA_LUMBER_BOUNTY_SIDES	        = 0xA
// 单位物编整数数据：木材奖励 - 基础值
constant integer UNIT_DEF_DATA_LUMBER_BOUNTY_BASE		    = 0xB
// 单位物编整数数据：最大库存量
constant integer UNIT_DEF_DATA_STOCK_MAX				    = 0xC
// 单位物编整数数据：运输尺寸
constant integer UNIT_DEF_DATA_CARGO_SIZE				    = 0xD
// 单位物编整数数据：等级
constant integer UNIT_DEF_DATA_LEVEL					    = 0xE
// 单位物编整数数据：生命回复类型
constant integer UNIT_DEF_DATA_REGEN_TYPE				    = 0xF
// 单位物编整数数据：护甲类型
constant integer UNIT_DEF_DATA_DEF_TYPE				        = 0x10
// 单位物编整数数据：允许攻击模式
constant integer UNIT_DEF_DATA_WEAPONS_ON				    = 0x11
// 单位物编整数数据：目标允许1
constant integer UNIT_DEF_DATA_TARGET_ALLOW1		        = 0x12
// 单位物编整数数据：目标允许2
constant integer UNIT_DEF_DATA_TARGET_ALLOW2		        = 0x13
// 单位物编整数数据：伤害升级奖励1
constant integer UNIT_DEF_DATA_DAMAGE_UP1				    = 0x14
// 单位物编整数数据：伤害升级奖励2
constant integer UNIT_DEF_DATA_DAMAGE_UP2				    = 0x15
// 单位物编整数数据：伤害骰子数量1
constant integer UNIT_DEF_DATA_DAMAGE_DICE1			        = 0x16
// 单位物编整数数据：伤害骰子数量2
constant integer UNIT_DEF_DATA_DAMAGE_DICE2			        = 0x17
// 单位物编整数数据：伤害骰子面数1
constant integer UNIT_DEF_DATA_DAMAGE_SIDES1			    = 0x18
// 单位物编整数数据：伤害骰子面数2
constant integer UNIT_DEF_DATA_DAMAGE_SIDES2			    = 0x19
// 单位物编整数数据：基础伤害1
constant integer UNIT_DEF_DATA_DAMAGE_BASE1			        = 0x1A
// 单位物编整数数据：基础伤害2
constant integer UNIT_DEF_DATA_DAMAGE_BASE2			        = 0x1B
// 单位物编整数数据：最大目标数1
constant integer UNIT_DEF_DATA_TARGET_COUNT1			    = 0x1C
// 单位物编整数数据：最大目标数2
constant integer UNIT_DEF_DATA_TARGET_COUNT2			    = 0x1D
// 单位物编整数数据：攻击类型1
constant integer UNIT_DEF_DATA_ATTACK_TYPE1			        = 0x1E
// 单位物编整数数据：攻击类型2
constant integer UNIT_DEF_DATA_ATTACK_TYPE2		            = 0x1F
// 单位物编整数数据：武器声音1
constant integer UNIT_DEF_DATA_WEAPON_SOUND1		        = 0x20
// 单位物编整数数据：武器声音2
constant integer UNIT_DEF_DATA_WEAPON_SOUND2		        = 0x21
// 单位物编整数数据：武器类型1
constant integer UNIT_DEF_DATA_WEAPON_TYPE1		            = 0x22
// 单位物编整数数据：武器类型2
constant integer UNIT_DEF_DATA_WEAPON_TYPE2		            = 0x23
// 单位物编整数数据：初始力量
constant integer UNIT_DEF_DATA_INIT_STR			            = 0x24
// 单位物编整数数据：初始敏捷
constant integer UNIT_DEF_DATA_INIT_AGI			            = 0x25
// 单位物编整数数据：初始智力
constant integer UNIT_DEF_DATA_INIT_INT			            = 0x26
// 单位物编整数数据：主要属性
constant integer UNIT_DEF_DATA_PRIMARY_ATTR		            = 0x27
// 单位物编整数数据：种族
constant integer UNIT_DEF_DATA_RACE				            = 0x28
// 单位物编整数数据：单位类别
constant integer UNIT_DEF_DATA_TYPE				            = 0x29
// 单位物编整数数据：碰撞类型 (别人碰撞自己)
constant integer UNIT_DEF_DATA_COLLISION_TYPE_FROM_OTHER    = 0x2A
// 单位物编整数数据：碰撞类型 (自己碰撞别人)
constant integer UNIT_DEF_DATA_COLLISION_TYPE_TO_OTHER	    = 0x2B
// 单位物编整数数据：占用人口
constant integer UNIT_DEF_DATA_FOOD_USED			        = 0x2C
// 单位物编整数数据：提供人口
constant integer UNIT_DEF_DATA_FOOD_MADE			        = 0x2D
// 单位物编整数数据：附加值
constant integer UNIT_DEF_DATA_POINTS			            = 0x2E
// 单位物编整数数据：
constant integer UNIT_DEF_DATA_COLOR				        = 0x2F
// 单位物编整数数据：称谓数量
constant integer UNIT_DEF_DATA_PROPER_NAMES_COUNT           = 0x30
// 单位物编整数数据：
constant integer UNIT_DEF_DATA_LOOPING_SND_FADE_IN	        = 0x31
// 单位物编整数数据：
constant integer UNIT_DEF_DATA_LOOPING_SND_FADE_OUT	        = 0x32
// 单位物编整数数据：按钮位置 (X)
constant integer UNIT_DEF_DATA_BUTTON_X				        = 0x33
// 单位物编整数数据：按钮位置 (Y)
constant integer UNIT_DEF_DATA_BUTTON_Y				        = 0x34
// 单位物编整数数据：热键
constant integer UNIT_DEF_DATA_HOTKEY				        = 0x35
// 单位物编整数数据：
constant integer UNIT_DEF_DATA_ATTACHED_PROPS		        = 0x36

// 单位物编实数数据：雇用时间间隔
constant integer UNIT_DEF_DATA_STOCK_REGEN			        = 0x37
// 单位物编实数数据：雇佣开始时间
constant integer UNIT_DEF_DATA_STOCK_START			        = 0x38
// 单位物编实数数据：施法前摇
constant integer UNIT_DEF_DATA_CAST_POINT				    = 0x39
// 单位物编实数数据：施法后摇
constant integer UNIT_DEF_DATA_CAST_BACKSWING			    = 0x3A
// 单位物编实数数据：死亡时间
constant integer UNIT_DEF_DATA_DEATH_TIME				    = 0x3B
// 单位物编实数数据：生命恢复速度
constant integer UNIT_DEF_DATA_LIFE_REGEN				    = 0x3C
// 单位物编实数数据：最大生命值
constant integer UNIT_DEF_DATA_MAX_LIFE				        = 0x3D
// 单位物编实数数据：初始魔法值
constant integer UNIT_DEF_DATA_INIT_MANA				    = 0x3E
// 单位物编实数数据：最大魔法值
constant integer UNIT_DEF_DATA_MAX_MANA				        = 0x3F
// 单位物编实数数据：魔法恢复速度
constant integer UNIT_DEF_DATA_MANA_REGEN				    = 0x40
// 单位物编实数数据：护甲值
constant integer UNIT_DEF_DATA_DEF_VALUE				    = 0x41
// 单位物编实数数据：护甲升级奖励
constant integer UNIT_DEF_DATA_DEF_UP					    = 0x42
// 单位物编实数数据：伤害衰减参数1
constant integer UNIT_DEF_DATA_DAMAGE_LOSS1			        = 0x43
// 单位物编实数数据：伤害衰减参数2
constant integer UNIT_DEF_DATA_DAMAGE_LOSS2			        = 0x44
// 单位物编实数数据：穿透伤害距离1
constant integer UNIT_DEF_DATA_SPILL_DIST1			        = 0x45
// 单位物编实数数据：穿透伤害距离2
constant integer UNIT_DEF_DATA_SPILL_DIST2			        = 0x46
// 单位物编实数数据：穿透伤害范围1
constant integer UNIT_DEF_DATA_SPILL_RADIUS1			    = 0x47
// 单位物编实数数据：穿透伤害范围2
constant integer UNIT_DEF_DATA_SPILL_RADIUS2			    = 0x48
// 单位物编实数数据：攻击范围1
constant integer UNIT_DEF_DATA_ATTACK_RANGE1			    = 0x49
// 单位物编实数数据：攻击范围2
constant integer UNIT_DEF_DATA_ATTACK_RANGE2			    = 0x4A
// 单位物编实数数据：攻击范围缓冲1
constant integer UNIT_DEF_DATA_RANGE_BUFFER1			    = 0x4B
// 单位物编实数数据：攻击范围缓冲2
constant integer UNIT_DEF_DATA_RANGE_BUFFER2			    = 0x4C
// 单位物编实数数据：攻击间隔1
constant integer UNIT_DEF_DATA_BAT1					        = 0x4D
// 单位物编实数数据：攻击间隔2
constant integer UNIT_DEF_DATA_BAT2					        = 0x4E
// 单位物编实数数据：攻击前摇1
constant integer UNIT_DEF_DATA_ATTACK_POINT1			    = 0x4F
// 单位物编实数数据：攻击前摇2
constant integer UNIT_DEF_DATA_ATTACK_POINT2			    = 0x50
// 单位物编实数数据：攻击后摇1
constant integer UNIT_DEF_DATA_ATTACK_BACSWING1		        = 0x51
// 单位物编实数数据：攻击后摇2
constant integer UNIT_DEF_DATA_ATTACK_BACSWING2		        = 0x52
// 单位物编实数数据：全伤害范围1
constant integer UNIT_DEF_DATA_FULL_AREA1				    = 0x53
// 单位物编实数数据：全伤害范围2
constant integer UNIT_DEF_DATA_FULL_AREA2				    = 0x54
// 单位物编实数数据：半伤害范围1
constant integer UNIT_DEF_DATA_HALF_AREA1				    = 0x55
// 单位物编实数数据：半伤害范围2
constant integer UNIT_DEF_DATA_HALF_AREA2				    = 0x56
// 单位物编实数数据：小伤害范围1
constant integer UNIT_DEF_DATA_SMALL_AREA1			        = 0x57
// 单位物编实数数据：小伤害范围2
constant integer UNIT_DEF_DATA_SMALL_AREA2			        = 0x58
// 单位物编实数数据：半伤害因数1
constant integer UNIT_DEF_DATA_HALF_FACTOR1			        = 0x59
// 单位物编实数数据：半伤害因数2
constant integer UNIT_DEF_DATA_HALF_FACTOR2			        = 0x5A
// 单位物编实数数据：小伤害因数1
constant integer UNIT_DEF_DATA_SMALL_FACTOR1			    = 0x5B
// 单位物编实数数据：小伤害因数2
constant integer UNIT_DEF_DATA_SMALL_FACTOR2			    = 0x5C
// 单位物编实数数据：每级提升力量
constant integer UNIT_DEF_DATA_STR_UP					    = 0x5D
// 单位物编实数数据：每级提升敏捷
constant integer UNIT_DEF_DATA_AGI_UP					    = 0x5E
// 单位物编实数数据：每级提升智力
constant integer UNIT_DEF_DATA_INT_UP					    = 0x5F
// 单位物编实数数据：视野范围 (白天)
constant integer UNIT_DEF_DATA_SIGHT_DAY				    = 0x60
// 单位物编实数数据：视野范围 (夜晚)
constant integer UNIT_DEF_DATA_SIGHT_NIGHT			        = 0x61
// 单位物编实数数据：主动攻击范围
constant integer UNIT_DEF_DATA_ACQUISION_RANGE		        = 0x62
// 单位物编实数数据：最小攻击范围
constant integer UNIT_DEF_DATA_MIN_RANGE			        = 0x63
// 单位物编实数数据：碰撞体积
constant integer UNIT_DEF_DATA_COLLISION			        = 0x64
// 单位物编实数数据：
constant integer UNIT_DEF_DATA_FOG_RADIUS				    = 0x65
// 单位物编实数数据：
constant integer UNIT_DEF_DATA_AI_RADIUS			        = 0x66
// 单位物编实数数据：移动速度
constant integer UNIT_DEF_DATA_SPEED				        = 0x67
// 单位物编实数数据：最小移动速度
constant integer UNIT_DEF_DATA_MIN_SPEED			        = 0x68
// 单位物编实数数据：最大移动速度
constant integer UNIT_DEF_DATA_MAX_SPEED			        = 0x69
// 单位物编实数数据：转身速度
constant integer UNIT_DEF_DATA_TURN_RATE			        = 0x6A
// 单位物编实数数据：转向角度
constant integer UNIT_DEF_DATA_PROP_WIN				        = 0x6B
// 单位物编实数数据：转向补正
constant integer UNIT_DEF_DATA_ORIENT_INTERP			    = 0x6C
// 单位物编实数数据：闭塞高度
constant integer UNIT_DEF_DATA_OCCLUSION_HEIGHT		        = 0x6D
// 单位物编实数数据：高度
constant integer UNIT_DEF_DATA_HEIGHT					    = 0x6E
// 单位物编实数数据：最小高度
constant integer UNIT_DEF_DATA_MOVE_FLOOR				    = 0x6F
// 单位物编实数数据：射弹偏移 - X
constant integer UNIT_DEF_DATA_LAUNCH_X				        = 0x70
// 单位物编实数数据：射弹偏移 - Y
constant integer UNIT_DEF_DATA_LAUNCH_Y				        = 0x71
// 单位物编实数数据：射弹偏移 - Z
constant integer UNIT_DEF_DATA_LAUNCH_Z				        = 0x72
// 单位物编实数数据：射弹偏移 - Z (深水)
constant integer UNIT_DEF_DATA_LAUNCH_Z_SWIM		        = 0x73
// 单位物编实数数据：射弹碰撞偏移 - Z
constant integer UNIT_DEF_DATA_IMPACT_Z				        = 0x74
// 单位物编实数数据：射弹碰撞偏移 - Z (深水)
constant integer UNIT_DEF_DATA_IMPACT_Z_SWIM			    = 0x75
// 单位物编实数数据：混合时间
constant integer UNIT_DEF_DATA_BLEND					    = 0x76
// 单位物编实数数据：行走速度
constant integer UNIT_DEF_DATA_WALK_SPEED                   = 0x77
// 单位物编实数数据：跑步速度
constant integer UNIT_DEF_DATA_RUN_SPEED				    = 0x78
// 单位物编实数数据：选择圈缩放
constant integer UNIT_DEF_DATA_CIRCLE_SCALE			        = 0x79
// 单位物编实数数据：选择圈高度
constant integer UNIT_DEF_DATA_CIRCLE_Z				        = 0x7A
// 单位物编实数数据：射弹速率1
constant integer UNIT_DEF_DATA_MISSILE_SPEED1			    = 0x7B
// 单位物编实数数据：射弹速率2
constant integer UNIT_DEF_DATA_MISSILE_SPEED2			    = 0x7C
// 单位物编实数数据：射弹弧度1
constant integer UNIT_DEF_DATA_MISSILE_ARC1			        = 0x7D
// 单位物编实数数据：射弹弧度2
constant integer UNIT_DEF_DATA_MISSILE_ARC2			        = 0x7E
// 单位物编实数数据：阴影图像 - X轴偏移
constant integer UNIT_DEF_DATA_SHADOW_X				        = 0x7F
// 单位物编实数数据：阴影图像 - Y轴偏移
constant integer UNIT_DEF_DATA_SHADOW_Y				        = 0x80
// 单位物编实数数据：阴影图像 - 宽度
constant integer UNIT_DEF_DATA_SHADOW_WIDTH			        = 0x81
// 单位物编实数数据：阴影图像 - 高度
constant integer UNIT_DEF_DATA_SHADOW_HEIGHT			    = 0x82
// 单位物编实数数据：模型缩放
constant integer UNIT_DEF_DATA_SCALE					    = 0x83

// 单位物编布尔值数据：允许睡眠
constant integer UNIT_DEF_DATA_CAN_SLEEP				    = 0x84
// 单位物编布尔值数据：可以逃跑
constant integer UNIT_DEF_DATA_CAN_FLEE				        = 0x85
// 单位物编布尔值数据：显示UI1
constant integer UNIT_DEF_DATA_SHOW_UI1				        = 0x86
// 单位物编布尔值数据：显示UI2
constant integer UNIT_DEF_DATA_SHOW_UI2				        = 0x87

// 单位物编字符串数据：名字
constant integer UNIT_DEF_DATA_NAME					        = 0x88
// 单位物编字符串数据：模型路径
constant integer UNIT_DEF_DATA_MODEL					    = 0x89
// 单位物编字符串数据：肖像路径
constant integer UNIT_DEF_DATA_PORTRAIT				        = 0x8A
// 单位物编字符串数据：投射物图像1
constant integer UNIT_DEF_DATA_MISSILE_ART1			        = 0x8B
// 单位物编字符串数据：投射物图像2
constant integer UNIT_DEF_DATA_MISSILE_ART2			        = 0x8C
// 单位物编字符串数据：计分屏图标
constant integer UNIT_DEF_DATA_SCORE_SCREEN_ICON		    = 0x8D
// 单位物编字符串数据：图标
constant integer UNIT_DEF_DATA_ART					        = 0x8E
// 单位物编字符串数据：提示工具 - 普通
constant integer UNIT_DEF_DATA_TIP					        = 0x8F
// 单位物编字符串数据：提示工具 - 普通 - 扩展
constant integer UNIT_DEF_DATA_UBERTIP				        = 0x90

// 单位物编等级数据：需求
constant integer UNIT_LEVEL_DEF_DATA_REQUIRE                = 0x0

// 单位物编等级数据：英雄称谓
constant integer UNIT_LEVEL_DEF_DATA_PROPER_NAME            = 0x1

// 单位标志1：隐藏
constant integer UNIT_FLAG1_HIDE				            = 0x1
// 单位标志1：能被选择
// @Tip：删除后与蝗虫类似，不能被点选和框选
constant integer UNIT_FLAG1_CANSELECT                       = 0x2
// 单位标志1：能成为目标
// @Tip：删除后不能成为指示器的目标
constant integer UNIT_FLAG1_CANBETARGET			            = 0x4
// 单位标志1：无敌
// @Tip：可作为判定无敌的依据。可添加但不推荐
constant integer UNIT_FLAG1_INVULNERABLE			        = 0x8
// 单位标志1：对所有人可见
// @Tip：类似所有主基地被摧毁后，模型可以无视战争迷雾显示
constant integer UNIT_FLAG1_VISIBLE_TO_ALL		            = 0x10
// 单位标志1：可设置飞行高度
// @Tip：相当于添加删除风暴之鸦技能
constant integer UNIT_FLAG1_CANSET_FLYHEIGHT                = 0x800
// 单位标志1：钻地/潜水
constant integer UNIT_FLAG1_BURROWED				        = 0x4000000
// 单位标志1：禁止自动攻击
// @Tip：类似农民，被敌人攻击时不会主动反击
constant integer UNIT_FLAG1_AUTOATTACK_DISABLE	            = 0x10000000

// 单位标志2：死亡
constant integer UNIT_FLAG2_DEAD					        = 0x100
// 单位标志2：正在腐化
// @Tip：指死亡后到尸体完全消失这段时间
constant integer UNIT_FLAG2_DECAY					        = 0x800
// 单位标志2：建筑
constant integer UNIT_FLAG2_BUILDING	                    = 0x10000
// 单位标志2：小地图图标为金矿
constant integer UNIT_FLAG2_MINMAP_ICON_GOLD		        = 0x20000
// 单位标志2：小地图图标为中立商店
constant integer UNIT_FLAG2_MINMAP_ICON_TAVERN	            = 0x40000
// 单位标志2：小地图图标隐藏
constant integer UNIT_FLAG2_MINMAP_ICON_HIDE		        = 0x80000
// 单位标志2：眩晕
// @Tip：可作为判定眩晕的依据。手动添加后单位无视眩晕
constant integer UNIT_FLAG2_STUN				            = 0x100000
// 单位标志2：暂停
// @Tip：可作为判定暂停的依据。手动添加后单位无视暂停
constant integer UNIT_FLAG2_PAUSE				            = 0x200000
// 单位标志2：隐形
constant integer UNIT_FLAG2_INVISIBLE				        = 0x1000000
// 单位标志2：隐藏面板
constant integer UNIT_FLAG2_HIDE_PANEL		                = 0x4000000
// 单位标志2：飞行视野
// @Tip：删去后会失去飞行视野，飞行高度也不会随树而变化
constant integer UNIT_FLAG2_FLY_VISION		                = 0x20000000
// 单位标志2：幻象
constant integer UNIT_FLAG2_ILLUSION				        = 0x40000000
// 单位标志2：操纵死尸
constant integer UNIT_FLAG2_ANIMATED				        = 0x80000000

// 单位种类：泰坦族
constant integer UNIT_FLAG_TYPE_GIANT					    = 0x1
// 单位种类：不死族
constant integer UNIT_FLAG_TYPE_UNDEAD				        = 0x2
// 单位种类：召唤单位
constant integer UNIT_FLAG_TYPE_SUMMON				        = 0x4
// 单位种类：机械类
constant integer UNIT_FLAG_TYPE_MECHANICAL			        = 0x8
// 单位种类：工人
constant integer UNIT_FLAG_TYPE_PEON					    = 0x10
// 单位种类：自爆工兵
constant integer UNIT_FLAG_TYPE_SAPPER				        = 0x20
// 单位种类：城镇大厅
constant integer UNIT_FLAG_TYPE_TOWNHALL				    = 0x40
// 单位种类：古树
constant integer UNIT_FLAG_TYPE_ANCIENT				        = 0x80
// 单位种类：守卫
constant integer UNIT_FLAG_TYPE_WARD					    = 0x200
// 单位种类：可通行
constant integer UNIT_FLAG_TYPE_STANDON				        = 0x400
// 单位种类：牛头人
constant integer UNIT_FLAG_TYPE_TAUREN				        = 0x800

// 移动类型：没有
// @Tip：无视地形
constant integer UNIT_MOVE_TYPE_NONE		                = 0x0
// 移动类型：无法移动
// @Tip：类似于单位被网住
constant integer UNIT_MOVE_TYPE_DISABLE	                    = 0x1000001
// 移动类型：步行
constant integer UNIT_MOVE_TYPE_FOOT		                = 0x2000002
// 移动类型：飞行
constant integer UNIT_MOVE_TYPE_FLY		                    = 0x4000004
// 移动类型：地精地雷
// @Tip：表现为无法通过不可建造区域
constant integer UNIT_MOVE_TYPE_LANDMINE	                = 0x8000008
// 移动类型：疾风步
constant integer UNIT_MOVE_TYPE_WINDWALK	                = 0x10000010
// 移动类型：浮空 (陆)
constant integer UNIT_MOVE_TYPE_HOVER		                = 0x40000040
// 移动类型：两栖
constant integer UNIT_MOVE_TYPE_AMPH		                = 0x80000080
                                                                    
// 寻路类型：步行
constant integer UNIT_PATH_TYPE_FOOT                        = 0x0   
// 寻路类型：两栖
constant integer UNIT_PATH_TYPE_AMPH                        = 0x2   
// 寻路类型：漂浮 (水)
constant integer UNIT_PATH_TYPE_FLOAT                       = 0x4   
// 寻路类型：飞行
constant integer UNIT_PATH_TYPE_FLY                         = 0x6
                                                                    
// 碰撞类型：无
constant integer UNIT_COLLISION_TYPE_NONE			        = 0x0   
// 碰撞类型：任何
constant integer UNIT_COLLISION_TYPE_ANY			        = 0x1   
// 碰撞类型：步行
constant integer UNIT_COLLISION_TYPE_FOOT			        = 0x2   
// 碰撞类型：飞行
constant integer UNIT_COLLISION_TYPE_AIR			        = 0x4   
// 碰撞类型：建筑
constant integer UNIT_COLLISION_TYPE_BUILDING		        = 0x8   
// 碰撞类型：采集工
constant integer UNIT_COLLISION_TYPE_HARVESTER	            = 0x10  
// 碰撞类型：荒芜之地
constant integer UNIT_COLLISION_TYPE_BLIGHTED		        = 0x20  
// 碰撞类型：浮空 (陆)
constant integer UNIT_COLLISION_TYPE_HOVER		            = 0x40  
// 碰撞类型：两栖
constant integer UNIT_COLLISION_TYPE_AMPH			        = 0x80
// 碰撞类型：地面
// @Tip：实际上等于 步行 + 建筑 + 浮空 (陆) + 两栖
constant integer UNIT_COLLISION_TYPE_GROUND		            = 0xCA

// 单位状态：正常
constant integer UNIT_CUR_STATE_NORMAL                      = 0x0
// 单位状态：攻击
constant integer UNIT_CUR_STATE_ATTACK                      = 0x1
// 单位状态：施法
// @Tip：建造也属于这个状态
constant integer UNIT_CUR_STATE_SPELL                       = 0x3
// 单位状态：死亡
constant integer UNIT_CUR_STATE_DEAD                        = 0x4
// 单位状态：采集
constant integer UNIT_CUR_STATE_HARVEST                     = 0x5
// 单位状态：移动
// @Tip：不准确
constant integer UNIT_CUR_STATE_MOVE                        = 0x7

// 英雄属性：力量
constant integer HERO_ATTRIBUTE_STR                         = 0x1
// 英雄属性：智力
constant integer HERO_ATTRIBUTE_INT                         = 0x2
// 英雄属性：敏捷
constant integer HERO_ATTRIBUTE_AGI                         = 0x3



// 物品物编整数数据：基础ID
constant integer ITEM_DEF_DATA_BASE_ID		                = 0x1
// 物品物编整数数据：黄金消耗
constant integer ITEM_DEF_DATA_GOLD_COST		            = 0x2
// 物品物编整数数据：木材消耗
constant integer ITEM_DEF_DATA_LUMBER_COST	                = 0x3
// 物品物编整数数据：最大库存量
constant integer ITEM_DEF_DATA_STOCK_MAX		            = 0x4
// 物品物编整数数据：等级
constant integer ITEM_DEF_DATA_LEVEL			            = 0x5
// 物品物编整数数据：分类
constant integer ITEM_DEF_DATA_CLASS			            = 0x6
// 物品物编整数数据：使用次数
constant integer ITEM_DEF_DATA_USES			                = 0x7
// 物品物编整数数据：CD间隔组
constant integer ITEM_DEF_DATA_COOLDOWN_ID	                = 0x8
// 物品物编整数数据：热键
constant integer ITEM_DEF_DATA_HOTKEY			            = 0x9

// 物品物编布尔值数据：有效的物品转换目标
constant integer ITEM_DEF_DATA_MORPH			            = 0xA
// 物品物编布尔值数据：可作为随机物品
constant integer ITEM_DEF_DATA_PICK_RANDOM	                = 0xB
// 物品物编布尔值数据：捡取时使用
constant integer ITEM_DEF_DATA_USE_ON_PICKUP	            = 0xC
// 物品物编布尔值数据：可被市场出售
constant integer ITEM_DEF_DATA_SELLABLE		                = 0xD
// 物品物编布尔值数据：可以被抵押
constant integer ITEM_DEF_DATA_PAWNABLE		                = 0xE
// 物品物编布尔值数据：主动使用
constant integer ITEM_DEF_DATA_USABLE			            = 0xF
// 物品物编布尔值数据：使用完消失
constant integer ITEM_DEF_DATA_PERISHABLE		            = 0x10
// 物品物编布尔值数据：可以丢弃
constant integer ITEM_DEF_DATA_DROPPABLE		            = 0x11
// 物品物编布尔值数据：死亡时掉落
constant integer ITEM_DEF_DATA_DROP_ON_DEATH	            = 0x12
// 物品物编布尔值数据：无视CD间隔
constant integer ITEM_DEF_DATA_IGNORE_CD		            = 0x13

// 物品物编字符串数据：技能列表
// @Tip：多个技能用逗号隔开
constant integer ITEM_DEF_DATA_ABIL_LIST			        = 0x14
// 物品物编字符串数据：名字
constant integer ITEM_DEF_DATA_NAME			                = 0x15
// 物品物编字符串数据：图标
constant integer ITEM_DEF_DATA_ART			                = 0x16
// 物品物编字符串数据：提示工具
constant integer ITEM_DEF_DATA_TIP			                = 0x17
// 物品物编字符串数据：提示工具 - 扩展
constant integer ITEM_DEF_DATA_UBERTIP		                = 0x18


                                                                    
// 投射物整数数据：基础ID
constant integer MISSILE_DATA_BASE_ID                       = 0x0   
// 投射物整数数据：攻击类型
constant integer MISSILE_DATA_ATTACK_TYPE                   = 0x1   
// 投射物整数数据：伤害类型
constant integer MISSILE_DATA_DAMAGE_TYPE                   = 0x2   
// 投射物整数数据：武器类型
constant integer MISSILE_DATA_WEAPON_TYPE                   = 0x3   
// 投射物整数数据：伤害标志
constant integer MISSILE_DATA_DAMAGE_FLAG                   = 0x4   
// 投射物整数数据：目标允许
constant integer MISSILE_DATA_TARGET_ALLOW                  = 0x5   
// 投射物整数数据：弹射次数
constant integer MISSILE_DATA_BOUNCE_TIMES                  = 0x6   

// 投射物实数数据：基础伤害
constant integer MISSILE_DATA_DAMAGE                        = 0x7   
// 投射物实数数据：附加伤害
constant integer MISSILE_DATA_BONUS_DAMAGE                  = 0x8   
// 投射物实数数据：射弹速率
constant integer MISSILE_DATA_SPEED                         = 0x9   
// 投射物实数数据：射弹弧度
constant integer MISSILE_DATA_ARC                           = 0xA   
// 投射物实数数据：弹射范围
constant integer MISSILE_DATA_BOUNCE_RADIUS                 = 0xB   
// 投射物实数数据：伤害衰减
constant integer MISSILE_DATA_DMG_LOSS                      = 0xC   
// 投射物实数数据：穿透距离
constant integer MISSILE_DATA_SPILL_RANGE                   = 0xD   
// 投射物实数数据：穿透范围
constant integer MISSILE_DATA_SPILL_RADIUS                  = 0xE   
// 投射物实数数据：半伤害因数
constant integer MISSILE_DATA_HALF_FACTOR                   = 0xF   
// 投射物实数数据：小伤害因数
constant integer MISSILE_DATA_SMALL_FACTOR                  = 0x10  
// 投射物实数数据：全伤害范围
constant integer MISSILE_DATA_FULL_AREA                     = 0x11  
// 投射物实数数据：半伤害范围
constant integer MISSILE_DATA_HALF_AREA                     = 0x12  
// 投射物实数数据：小伤害范围
constant integer MISSILE_DATA_SMALL_AREA                    = 0x13  



// 本地命令标志：正常
constant integer LOCAL_ORDER_FLAG_NORMAL                    = 0x0
// 本地命令标志：队列
constant integer LOCAL_ORDER_FLAG_QUEUE                     = 0x1
// 本地命令标志：立即
constant integer LOCAL_ORDER_FLAG_INSTANT                   = 0x2
// 本地命令标志：单独释放
constant integer LOCAL_ORDER_FLAG_ALONE                     = 0x4
// 本地命令标志：物品命令
constant integer LOCAL_ORDER_FLAG_ITEM                      = 0x8
// 本地命令标志：命令恢复
constant integer LOCAL_ORDER_FLAG_RESTORE                   = 0x20


                                      
// 指示器类型：指示器
constant integer INDICATOR_TYPE_TARGET_MODE                 = 0x0
// 指示器类型：选择器
constant integer INDICATOR_TYPE_SELECT_MODE                 = 0x1
// 指示器类型：框选
constant integer INDICATOR_TYPE_DRAG_SELECT_MODE            = 0x2
// 指示器类型：镜头拖动
constant integer INDICATOR_TYPE_DRAG_SCROLL_MODE            = 0x3
// 指示器类型：建造指示器
constant integer INDICATOR_TYPE_BUILD_MODE                  = 0x4
// 指示器类型：信号指示器
constant integer INDICATOR_TYPE_SIGNAL_MODE                 = 0x5
// 指示器类型：任意
constant integer INDICATOR_TYPE_ANY                         = 0x6



// 玩家聊天频道：全部
constant integer CHAT_CHANNEL_ALL		                    = 0x0
// 玩家聊天频道：盟友
constant integer CHAT_CHANNEL_ALLY		                    = 0x1
// 玩家聊天频道：裁判
constant integer CHAT_CHANNEL_OBSERVER	                    = 0x2
// 玩家聊天频道：私人
constant integer CHAT_CHANNEL_PRIVATE	                    = 0x3



// 作弊标志：无敌
constant integer CHEAT_FLAG_WHOSYOURDADDY	                = 0x2
// 作弊标志：快速建造
constant integer CHEAT_FLAG_WARPTEN			                = 0x4	
// 作弊标志：无限人口
constant integer CHEAT_FLAG_POINTBREAK		                = 0x10  
// 作弊标志：无限蓝
constant integer CHEAT_FLAG_THEREISNOSPOON	                = 0x20 
// 作弊标志：不会失败
constant integer CHEAT_FLAG_STRENGTHANDHONOR                = 0x40 
// 作弊标志：不会胜利
constant integer CHEAT_FLAG_ITVEXESME		                = 0x80
// 作弊标志：取消学习技能等级限制
constant integer CHEAT_FLAG_WHOISJOHNGALT	                = 0x100
// 作弊标志：全图
constant integer CHEAT_FLAG_ISEEDEADPEOPLE	                = 0x200
// 作弊标志：全科技
constant integer CHEAT_FLAG_SYNERGY			                = 0x400
// 作弊标志：停止时间流逝
constant integer CHEAT_FLAG_DAYLIGHTSAVINGS	                = 0x800

// 调试日志等级：禁用
constant integer JASS_LOG_LEVEL_DISABLE                     = 0x0
// 调试日志等级：记录函数调用
constant integer JASS_LOG_LEVEL_CALL                        = 0x1
// 调试日志等级：记录函数带参调用
constant integer JASS_LOG_LEVEL_FUNCTION                    = 0x2

endglobals