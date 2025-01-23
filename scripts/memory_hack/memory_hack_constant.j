#pragma once
// by Asphodelu


#ifdef JapiPlaceHolder
#error "[MemHack]自定义JapiPlaceHolder被视作禁止行为"
#else
#define JapiPlaceHolder call ConvertRace(0) YDNL return
#endif

#define __MEMHACK_COUNT_ARGS_IMPL(_1,_2,_3,_4,_5,_6,_7,_8,_9,_10,_11,_12,_13,_14,_15,_16,N,...) N
#define __MEMHACK_COUNT_ARGS(...) __MEMHACK_COUNT_ARGS_IMPL(__VA_ARGS__,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0)



#define MHConvertEventID(a)                         (a)
#define MHConvertTargetAllow(a)                     (a)
#define MHConvertCheatFlag(a)                       (a)
#define MHConvertCollisionType(a)                   (a)
#define MHConvertCastType(a)                        (a)
#define MHConvertLocalOrderFlag(a)                  (a)

#define FLAG_OPERATOR_ADD                           0x1
#define FLAG_OPERATOR_REMOVE                        0x0



#define EVENT_ID_GAME_START					        0x0
#define EVENT_ID_GAME_TICK					        0x1
#define EVENT_ID_UNIT_CREATE				        0x2
#define EVENT_ID_UNIT_REMOVE				        0x3
#define EVENT_ID_UNIT_ATTACK_LAUNCH			        0x4
#define EVENT_ID_UNIT_SEARCH_TARGET			        0x5
#define EVENT_ID_UNIT_RESTORE_LIFE			        0x6
#define EVENT_ID_UNIT_RESTORE_MANA			        0x7
#define EVENT_ID_UNIT_DISPEL_BUFF			        0x8
#define EVENT_ID_UNIT_HARVEST				        0x9
#define EVENT_ID_HERO_GET_EXP				        0xA
#define EVENT_ID_UNIT_DAMAGE				        0xB
#define EVENT_ID_UNIT_DAMAGING				        0xC
#define EVENT_ID_ABILITY_ADD				        0xD
#define EVENT_ID_ABILITY_REMOVE				        0xE
#define EVENT_ID_ABILITY_START_COOLDOWN		        0xF
#define EVENT_ID_ABILITY_END_COOLDOWN		        0x10
#define EVENT_ID_ABILITY_REFRESH_AURA		        0x11
#define EVENT_ID_ITEM_REMOVE				        0x12
#define EVENT_ID_PLAYER_GOLD_CHANGE			        0x13
#define EVENT_ID_PLAYER_LUMBER_CHANGE		        0x14
#define EVENT_ID_MISSILE_LAUNCH				        0x15
#define EVENT_ID_MISSILE_HIT				        0x16
#define EVENT_ID_SYNC						        0x17
#define EVENT_ID_GAME_STOP					        0x18
#define EVENT_ID_GAME_EXIT					        0x19
#define EVENT_ID_PLAYER_LEAVE				        0x1A
#define EVENT_ID_FRAME_MOUSE_ENTER			        0x1B
#define EVENT_ID_FRAME_MOUSE_LEAVE			        0x1C
#define EVENT_ID_FRAME_MOUSE_DOWN			        0x1D
#define EVENT_ID_FRAME_MOUSE_UP				        0x1E
#define EVENT_ID_FRAME_MOUSE_CLICK			        0x1F
#define EVENT_ID_FRAME_MOUSE_DOUBLE_CLICK	        0x20
#define EVENT_ID_FRAME_MOUSE_SCROLL			        0x21
#define EVENT_ID_KEY_UP						        0x22
#define EVENT_ID_KEY_DOWN					        0x23
#define EVENT_ID_KEY_HOLD					        0x24
#define EVENT_ID_MOUSE_UP					        0x25
#define EVENT_ID_MOUSE_DOWN					        0x26
#define EVENT_ID_MOUSE_SCROLL				        0x27
#define EVENT_ID_MOUSE_MOVE					        0x28
#define EVENT_ID_TARGET_INDICATOR			        0x29
#define EVENT_ID_CALL_TARGET_MODE			        0x2A
#define EVENT_ID_CALL_BUILD_MODE			        0x2B
#define EVENT_ID_CANCEL_INDICATOR			        0x2C
#define EVENT_ID_LOCAL_IMMEDIATE_ORDER		        0x2D
#define EVENT_ID_FRAME_TICK					        0x2E
#define EVENT_ID_REFRESH_HPBAR				        0x2F
#define EVENT_ID_PRERENDER					        0x30
#define EVENT_ID_WINDOW_RESIZE				        0x31



#define SYSTEM_TIME_YEAR	                        0x1
#define SYSTEM_TIME_MONTH	                        0x2
#define SYSTEM_TIME_DAY		                        0x3
#define SYSTEM_TIME_HOUR	                        0x4
#define SYSTEM_TIME_MINUTE	                        0x5
#define SYSTEM_TIME_SECOND	                        0x6
#define SYSTEM_TIME_MSECOND	                        0x7

#define SLK_TABLE_ABILITY                           "ability"
#define SLK_TABLE_BUFF                              "buff"
#define SLK_TABLE_UNIT                              "unit"
#define SLK_TABLE_ITEM                              "item"
#define SLK_TABLE_UPGRADE                           "upgrade"
#define SLK_TABLE_DOODAD                            "doodad"
#define SLK_TABLE_DESTRUCTABLE                      "destructable"
#define SLK_TABLE_MISC                              "misc"

#define ANIM_TYPE_BIRTH                             0x0
#define ANIM_TYPE_DEATH                             0x1
#define ANIM_TYPE_DECAY                             0x2
#define ANIM_TYPE_DISSIPATE                         0x3
#define ANIM_TYPE_STAND                             0x4
#define ANIM_TYPE_WALK                              0x5
#define ANIM_TYPE_ATTACK                            0x6
#define ANIM_TYPE_MORPH                             0x7
#define ANIM_TYPE_SLEEP                             0x8
#define ANIM_TYPE_SPELL                             0x9
#define ANIM_TYPE_PORTRAIT                          0xA

#define SUBANIM_TYPE_ROOTED                         11
#define SUBANIM_TYPE_ALTERNATE_EX                   12
#define SUBANIM_TYPE_LOOPING                        13
#define SUBANIM_TYPE_SLAM                           14
#define SUBANIM_TYPE_THROW                          15
#define SUBANIM_TYPE_SPIKED                         16
#define SUBANIM_TYPE_FAST                           17
#define SUBANIM_TYPE_SPIN                           18
#define SUBANIM_TYPE_READY                          19
#define SUBANIM_TYPE_CHANNEL                        20
#define SUBANIM_TYPE_DEFEND                         21
#define SUBANIM_TYPE_VICTORY                        22
#define SUBANIM_TYPE_TURN                           23
#define SUBANIM_TYPE_LEFT                           24
#define SUBANIM_TYPE_RIGHT                          25
#define SUBANIM_TYPE_FIRE                           26
#define SUBANIM_TYPE_FLESH                          27
#define SUBANIM_TYPE_HIT                            28
#define SUBANIM_TYPE_WOUNDED                        29
#define SUBANIM_TYPE_LIGHT                          30
#define SUBANIM_TYPE_MODERATE                       31
#define SUBANIM_TYPE_SEVERE                         32
#define SUBANIM_TYPE_CRITICAL                       33
#define SUBANIM_TYPE_COMPLETE                       34
#define SUBANIM_TYPE_GOLD                           35
#define SUBANIM_TYPE_LUMBER                         36
#define SUBANIM_TYPE_WORK                           37
#define SUBANIM_TYPE_TALK                           38
#define SUBANIM_TYPE_FIRST                          39
#define SUBANIM_TYPE_SECOND                         40
#define SUBANIM_TYPE_THIRD                          41
#define SUBANIM_TYPE_FOURTH                         42
#define SUBANIM_TYPE_FIFTH                          43
#define SUBANIM_TYPE_ONE                            44
#define SUBANIM_TYPE_TWO                            45
#define SUBANIM_TYPE_THREE                          46
#define SUBANIM_TYPE_FOUR                           47
#define SUBANIM_TYPE_FIVE                           48
#define SUBANIM_TYPE_SMALL                          49
#define SUBANIM_TYPE_MEDIUM                         50
#define SUBANIM_TYPE_LARGE                          51
#define SUBANIM_TYPE_UPGRADE                        52
#define SUBANIM_TYPE_DRAIN                          53
#define SUBANIM_TYPE_FILL                           54
#define SUBANIM_TYPE_CHAINLIGHTNING                 55
#define SUBANIM_TYPE_EATTREE                        56
#define SUBANIM_TYPE_PUKE                           57
#define SUBANIM_TYPE_FLAIL                          58
#define SUBANIM_TYPE_OFF                            59
#define SUBANIM_TYPE_SWIM                           60
#define SUBANIM_TYPE_ENTANGLE                       61
#define SUBANIM_TYPE_BERSERK                        62

#define MIRROR_AXIS_XY                              0x1
#define MIRROR_AXIS_XZ                              0x2
#define MIRROR_AXIS_YZ                              0x3

#define ANCHOR_TOP_LEFT                             0x0
#define ANCHOR_TOP                                  0x1
#define ANCHOR_TOP_RIGHT                            0x2
#define ANCHOR_LEFT                                 0x3
#define ANCHOR_CENTER                               0x4
#define ANCHOR_RIGHT                                0x5
#define ANCHOR_BOTTOM_LEFT                          0x6
#define ANCHOR_BOTTOM                               0x7
#define ANCHOR_BOTTOM_RIGHT                         0x8

#define LAYER_STYLE_VIEW_PORT                       0x1
#define LAYER_STYLE_IGNORE_TRACK_EVENT              0x2

#define SIMPLEBUTTON_STATE_DISABLE                  0x0
#define SIMPLEBUTTON_STATE_ENABLE                   0x1
#define SIMPLEBUTTON_STATE_PUSHED                   0x2

#define TEXT_VERTEX_ALIGN_TOP                       0x0
#define TEXT_VERTEX_ALIGN_CENTER                    0x1
#define TEXT_VERTEX_ALIGN_BOTTOM                    0x2

#define TEXT_HORIZON_ALIGN_LEFT                     0x3
#define TEXT_HORIZON_ALIGN_CENTER                   0x4
#define TEXT_HORIZON_ALIGN_RIGHT                    0x5

#define TARGET_ALLOW_TERRAIN                        0x0
#define TARGET_ALLOW_NONE                           0x1
#define TARGET_ALLOW_GROUND                         0x2
#define TARGET_ALLOW_AIR                            0x4
#define TARGET_ALLOW_STRUCTURE                      0x8
#define TARGET_ALLOW_WARD                           0x10
#define TARGET_ALLOW_ITEM                           0x20
#define TARGET_ALLOW_TREE                           0x40
#define TARGET_ALLOW_WALL                           0x80
#define TARGET_ALLOW_DEBRIS                         0x100
#define TARGET_ALLOW_DECORATION                     0x200
#define TARGET_ALLOW_BRIDGE                         0x400
#define TARGET_ALLOW_SELF                           0x1000
#define TARGET_ALLOW_PLAYER                         0x2000
#define TARGET_ALLOW_ALLIES                         0x4000
#define TARGET_ALLOW_FRIEND                         0x6000
#define TARGET_ALLOW_NEUTRAL                        0x8000
#define TARGET_ALLOW_ENEMIES                        0x10000
#define TARGET_ALLOW_NOTSELF                        0x1E000
#define TARGET_ALLOW_VULNERABLE                     0x100000
#define TARGET_ALLOW_INVULNERABLE                   0x200000
#define TARGET_ALLOW_HERO                           0x400000
#define TARGET_ALLOW_NONHERO                        0x800000
#define TARGET_ALLOW_ALIVE                          0x1000000
#define TARGET_ALLOW_DEAD                           0x2000000
#define TARGET_ALLOW_ORGANIC                        0x4000000
#define TARGET_ALLOW_MECHANICAL                     0x8000000
#define TARGET_ALLOW_NONSAPPER                      0x10000000
#define TARGET_ALLOW_SAPPER                         0x20000000
#define TARGET_ALLOW_NONANCIENT                     0x40000000
#define TARGET_ALLOW_ANCIENT                        0x80000000

#define ABILITY_FLAG_ON_CAST			            0x1
#define ABILITY_FLAG_SWITCH_ON			            0x80
#define ABILITY_FLAG_ON_COOLDOWN		            0x200
#define ABILITY_FLAG_IGNORE_COOLDOWN	            0x400
#define ABILITY_FLAG_FROM_ITEM			            0x2000
#define ABILITY_FLAG_AUTO_CAST_ON		            0x80000

#define ABILITY_CAST_TYPE_NONTARGET                 0x1
#define ABILITY_CAST_TYPE_POINT                     0x2
#define ABILITY_CAST_TYPE_TARGET                    0x4
#define ABILITY_CAST_TYPE_ALONE                     0x100000
#define ABILITY_CAST_TYPE_RESTORE                   0x200000
#define ABILITY_CAST_TYPE_AREA                      0x1000000
#define ABILITY_CAST_TYPE_INSTANT                   0x2000000

#define ABILITY_ORDER_FLAG_CAST                     0x1
#define ABILITY_ORDER_FLAG_ON                       0x2
#define ABILITY_ORDER_FLAG_OFF                      0x3

#define ABILITY_DEF_DATA_BASE_ID					0x0
#define ABILITY_DEF_DATA_REQ_LEVEL					0x1
#define ABILITY_DEF_DATA_MAX_LEVEL					0x2
#define ABILITY_DEF_DATA_PRIORITY					0x3
#define ABILITY_DEF_DATA_BUTTON_X					0x4
#define ABILITY_DEF_DATA_BUTTON_Y					0x5
#define ABILITY_DEF_DATA_UNBUTTON_X				    0x6
#define ABILITY_DEF_DATA_UNBUTTON_Y				    0x7
#define ABILITY_DEF_DATA_RESEARCH_BUTTON_X			0x8
#define ABILITY_DEF_DATA_RESEARCH_BUTTON_Y			0x9
#define ABILITY_DEF_DATA_HOTKEY						0xA
#define ABILITY_DEF_DATA_UNHOTKEY					0xB
#define ABILITY_DEF_DATA_RESEARCH_HOTKEY            0xC
#define ABILITY_DEF_DATA_CASTER_ART_COUNT			0xD
#define ABILITY_DEF_DATA_TARGET_ART_COUNT			0xE
#define ABILITY_DEF_DATA_EFFECT_ART_COUNT			0xF
#define ABILITY_DEF_DATA_MISSILE_ART_COUNT			0x10
#define ABILITY_DEF_DATA_SPECIAL_ART_COUNT			0x11
#define ABILITY_DEF_DATA_LIGHTNING_EFFECT_COUNT		0x12
#define ABILITY_DEF_DATA_CASTER_ATTACH_COUNT		0x13
#define ABILITY_DEF_DATA_TARGET_ATTACH_COUNT		0x14
#define ABILITY_DEF_DATA_MISSILE_SPEED				0x15
#define ABILITY_DEF_DATA_MISSILE_ARC				0x16
#define ABILITY_DEF_DATA_MISSILE_HOMING				0x17
#define ABILITY_DEF_DATA_NAME						0x18
#define ABILITY_DEF_DATA_ART						0x19
#define ABILITY_DEF_DATA_UN_ART						0x1A
#define ABILITY_DEF_DATA_RESEARCH_ART				0x1B
#define ABILITY_DEF_DATA_RESEARCH_TIP				0x1C
#define ABILITY_DEF_DATA_RESEARCH_UBERTIP			0x1D
#define ABILITY_DEF_DATA_EFFECT_SOUND				0x1E
#define ABILITY_DEF_DATA_EFFECT_SOUND_LOOPED		0x1F
#define ABILITY_DEF_DATA_GLOBAL_MESSAGE				0x20
#define ABILITY_DEF_DATA_GLOBAL_SOUND				0x21

#define ABILITY_LEVEL_DEF_DATA_TARGET_ALLOW			0x0
#define ABILITY_LEVEL_DEF_DATA_MANA_COST			0x1
#define ABILITY_LEVEL_DEF_DATA_UNIT_ID				0x2
#define ABILITY_LEVEL_DEF_DATA_CAST_TIME			0x3
#define ABILITY_LEVEL_DEF_DATA_NORMAL_DUR			0x4
#define ABILITY_LEVEL_DEF_DATA_HERO_DUR				0x5
#define ABILITY_LEVEL_DEF_DATA_COOLDOWN				0x6
#define ABILITY_LEVEL_DEF_DATA_AREA					0x7
#define ABILITY_LEVEL_DEF_DATA_RANGE				0x8
#define ABILITY_LEVEL_DEF_DATA_DATA_A				0x9
#define ABILITY_LEVEL_DEF_DATA_DATA_B				0xA
#define ABILITY_LEVEL_DEF_DATA_DATA_C				0xB
#define ABILITY_LEVEL_DEF_DATA_DATA_D				0xC
#define ABILITY_LEVEL_DEF_DATA_DATA_E				0xD
#define ABILITY_LEVEL_DEF_DATA_DATA_F				0xE
#define ABILITY_LEVEL_DEF_DATA_DATA_G				0xF
#define ABILITY_LEVEL_DEF_DATA_DATA_H				0x10
#define ABILITY_LEVEL_DEF_DATA_DATA_I				0x11
#define ABILITY_LEVEL_DEF_DATA_TIP					0x12		
#define ABILITY_LEVEL_DEF_DATA_UN_TIP				0x13		
#define ABILITY_LEVEL_DEF_DATA_UBERTIP				0x14		
#define ABILITY_LEVEL_DEF_DATA_UNUBERTIP			0x15		
#define ABILITY_LEVEL_DEF_DATA_CASTER_ART			0x16		
#define ABILITY_LEVEL_DEF_DATA_TARGET_ART			0x17		
#define ABILITY_LEVEL_DEF_DATA_EFFECT_ART			0x18		
#define ABILITY_LEVEL_DEF_DATA_MISSILE_ART			0x19		
#define ABILITY_LEVEL_DEF_DATA_SPECIAL_ART			0x1A		
#define ABILITY_LEVEL_DEF_DATA_LIGHTNING_EFFECT		0x1B		

#define ABILITY_POLARITY_AURA			            0x0
#define ABILITY_POLARITY_PHYSICAL		            0x1
#define ABILITY_POLARITY_MAGIC			            0x2



#define BUFF_TEMPLATE_BINF                          'Binf'
#define BUFF_TEMPLATE_BSLO                          'Bslo'
#define BUFF_TEMPLATE_BBLO                          'Bblo'
#define BUFF_TEMPLATE_BLSH                          'Blsh'
#define BUFF_TEMPLATE_BUFA                          'BUfa'
#define BUFF_TEMPLATE_BCRI                          'Bcri'
#define BUFF_TEMPLATE_BUHF                          'BUhf'
#define BUFF_TEMPLATE_BCRS                          'Bcrs'
#define BUFF_TEMPLATE_BESH                          'BEsh'
#define BUFF_TEMPLATE_BFAE                          'Bfae'
#define BUFF_TEMPLATE_BROA                          'Broa'
#define BUFF_TEMPLATE_BNHT                          'BNht'
#define BUFF_TEMPLATE_BNAB                          'BNab'
#define BUFF_TEMPLATE_BNSO                          'BNso'
#define BUFF_TEMPLATE_BNDH                          'BNdh'

#define BUFF_POLARITY_POSITIVE		                0x0
#define BUFF_POLARITY_NEGATIVE		                0x1
#define BUFF_POLARITY_AURA			                0x2
#define BUFF_POLARITY_TIMED_LIFE	                0x3
#define BUFF_POLARITY_PHYSICAL		                0x4
#define BUFF_POLARITY_MAGIC			                0x5
#define BUFF_POLARITY_CANT_DISPEL	                0x6



#define UNIT_DATA_MAX_LIFE		                    0x1
#define UNIT_DATA_MAX_MANA                          0x2
#define UNIT_DATA_LIFE_REGEN                        0x3
#define UNIT_DATA_MANA_REGEN                        0x4
#define UNIT_DATA_DEF_VALUE                         0x5
#define UNIT_DATA_DEF_TYPE                          0x6
#define UNIT_DATA_POSITION_Z                        0x7
#define UNIT_DATA_CUR_SIGHT                         0x8
#define UNIT_DATA_IMPACT_Z                          0x9
#define UNIT_DATA_IMPACT_Z_SWIM                     0xA
#define UNIT_DATA_LAUNCH_X                          0xB
#define UNIT_DATA_LAUNCH_Y                          0xC
#define UNIT_DATA_LAUNCH_Z                          0xD
#define UNIT_DATA_LAUNCH_Z_SWIM                     0xE
#define UNIT_DATA_MODEL_SCALE                       0xF
#define UNIT_DATA_Z_SCALE                           0x10
#define UNIT_DATA_HPBAR_HEIGHT                      0x11
#define UNIT_DATA_TIME_SCALE                        0x12
#define UNIT_DATA_COLLISION                         0x13
#define UNIT_DATA_BONUS_MOVESPEED                   0x14

#define UNIT_ATK_DATA_WEAPONS_ON                    0x1
#define UNIT_ATK_DATA_ATTACK_TYPE1                  0x2
#define UNIT_ATK_DATA_ATTACK_TYPE2                  0x3
#define UNIT_ATK_DATA_WEAPON_TYPE1                  0x4
#define UNIT_ATK_DATA_WEAPON_TYPE2                  0x5
#define UNIT_ATK_DATA_TARGET_ALLOW1                 0x6
#define UNIT_ATK_DATA_TARGET_ALLOW2                 0x7
#define UNIT_ATK_DATA_TARGET_COUNT1                 0x8
#define UNIT_ATK_DATA_TARGET_COUNT2                 0x9
#define UNIT_ATK_DATA_BASE_DAMAGE1                  0xA
#define UNIT_ATK_DATA_BASE_DAMAGE2                  0xB
#define UNIT_ATK_DATA_BONUS_DAMAGE1                 0xC
#define UNIT_ATK_DATA_BONUS_DAMAGE2                 0xD
#define UNIT_ATK_DATA_DAMAGE_DICE1                  0xE
#define UNIT_ATK_DATA_DAMAGE_DICE2                  0xF
#define UNIT_ATK_DATA_DAMAGE_SIDES1                 0x10
#define UNIT_ATK_DATA_DAMAGE_SIDES2                 0x11
#define UNIT_ATK_DATA_WEAPON_SOUND                  0x12

#define UNIT_ATK_DATA_ATTACK_SPEED                  0x13
#define UNIT_ATK_DATA_ACQUISION_RANGE               0x14
#define UNIT_ATK_DATA_MIN_RANGE                     0x15
#define UNIT_ATK_DATA_ATTACK_RANGE1                 0x16
#define UNIT_ATK_DATA_ATTACK_RANGE2                 0x17
#define UNIT_ATK_DATA_RANGE_BUFFER1                 0x18
#define UNIT_ATK_DATA_RANGE_BUFFER2                 0x19
#define UNIT_ATK_DATA_BAT1                          0x1A
#define UNIT_ATK_DATA_BAT2                          0x1B
#define UNIT_ATK_DATA_ATTACK_POINT1                 0x1C
#define UNIT_ATK_DATA_ATTACK_POINT2                 0x1D
#define UNIT_ATK_DATA_BACK_SWING1                   0x1E
#define UNIT_ATK_DATA_BACK_SWING2                   0x1F
#define UNIT_ATK_DATA_HALF_FACTOR1		            0x20
#define UNIT_ATK_DATA_HALF_FACTOR2		            0x21
#define UNIT_ATK_DATA_SMALL_FACTOR1		            0x22
#define UNIT_ATK_DATA_SMALL_FACTOR2		            0x23
#define UNIT_ATK_DATA_FULL_AREA1	                0x24
#define UNIT_ATK_DATA_FULL_AREA2	                0x25
#define UNIT_ATK_DATA_HALF_AREA1	                0x26
#define UNIT_ATK_DATA_HALF_AREA2	                0x27
#define UNIT_ATK_DATA_SMALL_AREA1		            0x28
#define UNIT_ATK_DATA_SMALL_AREA2		            0x29

#define UNIT_DEF_DATA_ID						    0x1
#define UNIT_DEF_DATA_BUILD_TIME				    0x2
#define UNIT_DEF_DATA_REPAIR_TIME			        0x3
#define UNIT_DEF_DATA_GOLD_COST				        0x4
#define UNIT_DEF_DATA_LUMBER_COST			        0x5	
#define UNIT_DEF_DATA_GOLD_BOUNTY_DICE		        0x6	
#define UNIT_DEF_DATA_GOLD_BOUNTY_SIDES		        0x7	
#define UNIT_DEF_DATA_GOLD_BOUNTY_BASE		        0x8	
#define UNIT_DEF_DATA_LUMBER_BOUNTY_DICE		    0x9	
#define UNIT_DEF_DATA_LUMBER_BOUNTY_SIDES	        0xA	
#define UNIT_DEF_DATA_LUMBER_BOUNTY_BASE		    0xB	
#define UNIT_DEF_DATA_STOCK_MAX				        0xC	
#define UNIT_DEF_DATA_CARGO_SIZE				    0xD	
#define UNIT_DEF_DATA_LEVEL					        0xE	
#define UNIT_DEF_DATA_REGEN_TYPE				    0xF	
#define UNIT_DEF_DATA_DEF_TYPE				        0x10
#define UNIT_DEF_DATA_WEAPONS_ON				    0x11
#define UNIT_DEF_DATA_TARGET_ALLOW1			        0x12
#define UNIT_DEF_DATA_TARGET_ALLOW2			        0x13
#define UNIT_DEF_DATA_DAMAGE_UP1				    0x14
#define UNIT_DEF_DATA_DAMAGE_UP2				    0x15
#define UNIT_DEF_DATA_DAMAGE_DICE1			        0x16
#define UNIT_DEF_DATA_DAMAGE_DICE2			        0x17
#define UNIT_DEF_DATA_DAMAGE_SIDES1			        0x18
#define UNIT_DEF_DATA_DAMAGE_SIDES2			        0x19
#define UNIT_DEF_DATA_DAMAGE_BASE1			        0x1A
#define UNIT_DEF_DATA_DAMAGE_BASE2			        0x1B
#define UNIT_DEF_DATA_TARGET_COUNT1			        0x1C
#define UNIT_DEF_DATA_TARGET_COUNT2			        0x1D
#define UNIT_DEF_DATA_ATTACK_TYPE1			        0x1E
#define UNIT_DEF_DATA_ATTACK_TYPE2		            0x1F
#define UNIT_DEF_DATA_WEAPON_SOUND1		            0x20
#define UNIT_DEF_DATA_WEAPON_SOUND2		            0x21
#define UNIT_DEF_DATA_WEAPON_TYPE1		            0x22
#define UNIT_DEF_DATA_WEAPON_TYPE2		            0x23
#define UNIT_DEF_DATA_INIT_STR			            0x24
#define UNIT_DEF_DATA_INIT_AGI			            0x25
#define UNIT_DEF_DATA_INIT_INT			            0x26
#define UNIT_DEF_DATA_PRIMARY_ATTR		            0x27
#define UNIT_DEF_DATA_RACE				            0x28
#define UNIT_DEF_DATA_TYPE				            0x29
#define UNIT_DEF_DATA_COLLISION_TYPE_FROM_OTHER	    0x2A
#define UNIT_DEF_DATA_COLLISION_TYPE_TO_OTHER	    0x2B
#define UNIT_DEF_DATA_POINTS			            0x2C
#define UNIT_DEF_DATA_COLOR				            0x2D
#define UNIT_DEF_DATA_PROPER_NAMES_COUNT            0x2E
#define UNIT_DEF_DATA_LOOPING_SND_FADE_IN	        0x2F
#define UNIT_DEF_DATA_LOOPING_SND_FADE_OUT	        0x30
#define UNIT_DEF_DATA_BUTTON_X				        0x31
#define UNIT_DEF_DATA_BUTTON_Y				        0x32
#define UNIT_DEF_DATA_HOTKEY				        0x33
#define UNIT_DEF_DATA_ATTACHED_PROPS		        0x34

#define UNIT_DEF_DATA_STOCK_REGEN			        0x35
#define UNIT_DEF_DATA_STOCK_START			        0x36
#define UNIT_DEF_DATA_CAST_POINT				    0x37
#define UNIT_DEF_DATA_CAST_BACKSWING			    0x38
#define UNIT_DEF_DATA_DEATH_TIME				    0x39
#define UNIT_DEF_DATA_LIFE_REGEN				    0x3A
#define UNIT_DEF_DATA_MAX_LIFE				        0x3B
#define UNIT_DEF_DATA_INIT_MANA				        0x3C
#define UNIT_DEF_DATA_MAX_MANA				        0x3D
#define UNIT_DEF_DATA_MANA_REGEN				    0x3E
#define UNIT_DEF_DATA_DEF_VALUE				        0x3F
#define UNIT_DEF_DATA_DEF_UP					    0x40
#define UNIT_DEF_DATA_DAMAGE_LOSS1			        0x41
#define UNIT_DEF_DATA_DAMAGE_LOSS2			        0x42
#define UNIT_DEF_DATA_SPILL_DIST1			        0x43
#define UNIT_DEF_DATA_SPILL_DIST2			        0x44
#define UNIT_DEF_DATA_SPILL_RADIUS1			        0x45
#define UNIT_DEF_DATA_SPILL_RADIUS2			        0x46
#define UNIT_DEF_DATA_ATTACK_RANGE1			        0x47
#define UNIT_DEF_DATA_ATTACK_RANGE2			        0x48
#define UNIT_DEF_DATA_RANGE_BUFFER1			        0x49
#define UNIT_DEF_DATA_RANGE_BUFFER2			        0x4A
#define UNIT_DEF_DATA_BAT1					        0x4B
#define UNIT_DEF_DATA_BAT2					        0x4C
#define UNIT_DEF_DATA_ATTACK_POINT1			        0x4D
#define UNIT_DEF_DATA_ATTACK_POINT2			        0x4E
#define UNIT_DEF_DATA_ATTACK_BACSWING1		        0x4F
#define UNIT_DEF_DATA_ATTACK_BACSWING2		        0x50
#define UNIT_DEF_DATA_FULL_AREA1				    0x51
#define UNIT_DEF_DATA_FULL_AREA2				    0x52
#define UNIT_DEF_DATA_HALF_AREA1				    0x53
#define UNIT_DEF_DATA_HALF_AREA2				    0x54
#define UNIT_DEF_DATA_SMALL_AREA1			        0x55
#define UNIT_DEF_DATA_SMALL_AREA2			        0x56
#define UNIT_DEF_DATA_HALF_FACTOR1			        0x57
#define UNIT_DEF_DATA_HALF_FACTOR2			        0x58
#define UNIT_DEF_DATA_SMALL_FACTOR1			        0x59
#define UNIT_DEF_DATA_SMALL_FACTOR2			        0x5A
#define UNIT_DEF_DATA_STR_UP					    0x5B
#define UNIT_DEF_DATA_AGI_UP					    0x5C
#define UNIT_DEF_DATA_INT_UP					    0x5D
#define UNIT_DEF_DATA_SIGHT_DAY				        0x5E
#define UNIT_DEF_DATA_SIGHT_NIGHT			        0x5F
#define UNIT_DEF_DATA_ACQUISION_RANGE		        0x60
#define UNIT_DEF_DATA_MIN_RANGE				        0x61
#define UNIT_DEF_DATA_COLLISION				        0x62
#define UNIT_DEF_DATA_FOG_RADIUS				    0x63
#define UNIT_DEF_DATA_AI_RADIUS				        0x64
#define UNIT_DEF_DATA_SPEED					        0x65
#define UNIT_DEF_DATA_MIN_SPEED				        0x66
#define UNIT_DEF_DATA_MAX_SPEED				        0x67
#define UNIT_DEF_DATA_TURN_RATE				        0x68
#define UNIT_DEF_DATA_PROP_WIN				        0x69
#define UNIT_DEF_DATA_ORIENT_INTERP			        0x6A
#define UNIT_DEF_DATA_OCCLUSION_HEIGHT		        0x6B
#define UNIT_DEF_DATA_HEIGHT					    0x6C
#define UNIT_DEF_DATA_MOVE_FLOOR				    0x6D
#define UNIT_DEF_DATA_LAUNCH_X				        0x6E
#define UNIT_DEF_DATA_LAUNCH_Y				        0x6F
#define UNIT_DEF_DATA_LAUNCH_Z				        0x70
#define UNIT_DEF_DATA_LAUNCH_Z_SWIM			        0x71
#define UNIT_DEF_DATA_IMPACT_Z				        0x72
#define UNIT_DEF_DATA_IMPACT_Z_SWIM			        0x73
#define UNIT_DEF_DATA_BLEND					        0x74
#define UNIT_DEF_DATA_WALK_SPEED                    0x75
#define UNIT_DEF_DATA_RUN_SPEED				        0x76
#define UNIT_DEF_DATA_CIRCLE_SCALE			        0x77
#define UNIT_DEF_DATA_CIRCLE_Z				        0x78
#define UNIT_DEF_DATA_MISSILE_SPEED1			    0x79
#define UNIT_DEF_DATA_MISSILE_SPEED2			    0x7A
#define UNIT_DEF_DATA_MISSILE_ARC1			        0x7B
#define UNIT_DEF_DATA_MISSILE_ARC2			        0x7C
#define UNIT_DEF_DATA_SHADOW_X				        0x7D
#define UNIT_DEF_DATA_SHADOW_Y				        0x7E
#define UNIT_DEF_DATA_SHADOW_WIDTH			        0x7F
#define UNIT_DEF_DATA_SHADOW_HEIGHT			        0x80
#define UNIT_DEF_DATA_SCALE					        0x81

#define UNIT_DEF_DATA_CAN_SLEEP				        0x82
#define UNIT_DEF_DATA_CAN_FLEE				        0x83
#define UNIT_DEF_DATA_FOOD_USED				        0x84
#define UNIT_DEF_DATA_FOOD_MADE				        0x85
#define UNIT_DEF_DATA_SHOW_UI1				        0x86
#define UNIT_DEF_DATA_SHOW_UI2				        0x87

#define UNIT_DEF_DATA_NAME					        0x88
#define UNIT_DEF_DATA_MODEL					        0x89
#define UNIT_DEF_DATA_PORTRAIT				        0x8A
#define UNIT_DEF_DATA_MISSILE_ART1			        0x8B
#define UNIT_DEF_DATA_MISSILE_ART2			        0x8C
#define UNIT_DEF_DATA_SCORE_SCREEN_ICON		        0x8D
#define UNIT_DEF_DATA_ART					        0x8E
#define UNIT_DEF_DATA_TIP					        0x8F
#define UNIT_DEF_DATA_UBERTIP				        0x90

#define UNIT_LEVEL_DEF_DATA_REQUIRE                 0x0

#define UNIT_LEVEL_DEF_DATA_PROPER_NAME             0x1

#define UNIT_FLAG1_HIDE				                0x1
#define UNIT_FLAG1_CANSELECT                        0x2
#define UNIT_FLAG1_CANBETARGET			            0x4
#define UNIT_FLAG1_INVULNERABLE			            0x8
#define UNIT_FLAG1_VISIBLE_TO_ALL		            0x10
#define UNIT_FLAG1_CANSET_FLYHEIGHT                 0x800
#define UNIT_FLAG1_BURROWED				            0x4000000
#define UNIT_FLAG1_AUTOATTACK_DISABLE	            0x10000000

#define UNIT_FLAG2_DEAD					            0x100
#define UNIT_FLAG2_DECAY					        0x800
#define UNIT_FLAG2_BUILDING	                        0x10000
#define UNIT_FLAG2_MINMAP_ICON_GOLD		            0x20000
#define UNIT_FLAG2_MINMAP_ICON_TAVERN	            0x40000
#define UNIT_FLAG2_MINMAP_ICON_HIDE		            0x80000
#define UNIT_FLAG2_STUN				                0x100000
#define UNIT_FLAG2_PAUSE				            0x200000
#define UNIT_FLAG2_INVISIBLE				        0x1000000
#define UNIT_FLAG2_HIDE_PANEL			            0x4000000
#define UNIT_FLAG2_FLY_VISION		                0x20000000
#define UNIT_FLAG2_ILLUSION				            0x40000000
#define UNIT_FLAG2_ANIMATED				            0x80000000

#define UNIT_FLAG_TYPE_GIANT					    0x1
#define UNIT_FLAG_TYPE_UNDEAD				        0x2
#define UNIT_FLAG_TYPE_SUMMON				        0x4
#define UNIT_FLAG_TYPE_MECHANICAL			        0x8
#define UNIT_FLAG_TYPE_PEON					        0x10
#define UNIT_FLAG_TYPE_SAPPER				        0x20
#define UNIT_FLAG_TYPE_TOWNHALL				        0x40
#define UNIT_FLAG_TYPE_ANCIENT				        0x80
#define UNIT_FLAG_TYPE_WARD					        0x200
#define UNIT_FLAG_TYPE_UNKNOWN				        0x400
#define UNIT_FLAG_TYPE_TAUREN				        0x800

#define UNIT_MOVE_TYPE_NONE		                    0x0
#define UNIT_MOVE_TYPE_DISABLE	                    0x1000001
#define UNIT_MOVE_TYPE_FOOT		                    0x2000002
#define UNIT_MOVE_TYPE_FLY		                    0x4000004
#define UNIT_MOVE_TYPE_LANDMINE	                    0x8000008
#define UNIT_MOVE_TYPE_WINDWALK	                    0x10000010
#define UNIT_MOVE_TYPE_HOVER		                0x40000040
#define UNIT_MOVE_TYPE_AMPH		                    0x80000080

#define UNIT_PATH_TYPE_FOOT                         0x0
#define UNIT_PATH_TYPE_AMPH                         0x2
#define UNIT_PATH_TYPE_FLOAT                        0x4
#define UNIT_PATH_TYPE_FLY                          0x6

#define UNIT_COLLISION_TYPE_NONE			        0x0
#define UNIT_COLLISION_TYPE_ANY			            0x1
#define UNIT_COLLISION_TYPE_FOOT			        0x2
#define UNIT_COLLISION_TYPE_AIR			            0x4
#define UNIT_COLLISION_TYPE_BUILDING		        0x8
#define UNIT_COLLISION_TYPE_HARVESTER	            0x10
#define UNIT_COLLISION_TYPE_BLIGHTED		        0x20
#define UNIT_COLLISION_TYPE_HOVER		            0x40
#define UNIT_COLLISION_TYPE_AMPH			        0x80
#define UNIT_COLLISION_TYPE_GROUND		            0xCA

#define UNIT_CUR_STATE_NORMAL                       0x0
#define UNIT_CUR_STATE_ATTACK                       0x1
#define UNIT_CUR_STATE_SPELL                        0x3
#define UNIT_CUR_STATE_DEAD                         0x4
#define UNIT_CUR_STATE_HARVEST                      0x5
#define UNIT_CUR_STATE_MOVE                         0x7

#define HERO_ATTRIBUTE_STR                          0x1
#define HERO_ATTRIBUTE_INT                          0x2
#define HERO_ATTRIBUTE_AGI                          0x3



#define ITEM_DEF_DATA_BASE_ID		                0x1
#define ITEM_DEF_DATA_GOLD_COST		                0x2
#define ITEM_DEF_DATA_LUMBER_COST	                0x3
#define ITEM_DEF_DATA_STOCK_MAX		                0x4
#define ITEM_DEF_DATA_LEVEL			                0x5
#define ITEM_DEF_DATA_CLASS			                0x6
#define ITEM_DEF_DATA_USES			                0x7
#define ITEM_DEF_DATA_COOLDOWN_ID	                0x8
#define ITEM_DEF_DATA_HOTKEY			            0x9

#define ITEM_DEF_DATA_MORPH			                0xA
#define ITEM_DEF_DATA_PICK_RANDOM	                0xB
#define ITEM_DEF_DATA_USE_ON_PICKUP	                0xC
#define ITEM_DEF_DATA_SELLABLE		                0xD
#define ITEM_DEF_DATA_PAWNABLE		                0xE
#define ITEM_DEF_DATA_USABLE			            0xF
#define ITEM_DEF_DATA_PERISHABLE		            0x10
#define ITEM_DEF_DATA_DROPPABLE		                0x11
#define ITEM_DEF_DATA_DROP_ON_DEATH	                0x12
#define ITEM_DEF_DATA_IGNORE_CD		                0x13

#define ITEM_DEF_DATA_ABIL_LIST			            0x14
#define ITEM_DEF_DATA_NAME			                0x15
#define ITEM_DEF_DATA_ART			                0x16
#define ITEM_DEF_DATA_TIP			                0x17
#define ITEM_DEF_DATA_UBERTIP		                0x18



#define MISSILE_DATA_BASE_ID                        0x0
#define MISSILE_DATA_ATTACK_TYPE                    0x1
#define MISSILE_DATA_DAMAGE_TYPE                    0x2
#define MISSILE_DATA_WEAPON_TYPE                    0x3
#define MISSILE_DATA_DAMAGE_FLAG                    0x4
#define MISSILE_DATA_TARGET_ALLOW                   0x5
#define MISSILE_DATA_BOUNCE_TIMES                   0x6

#define MISSILE_DATA_DAMAGE                         0x7
#define MISSILE_DATA_BONUS_DAMAGE                   0x8
#define MISSILE_DATA_SPEED                          0x9
#define MISSILE_DATA_ARC                            0xA
#define MISSILE_DATA_BOUNCE_RADIUS                  0xB 
#define MISSILE_DATA_DMG_LOSS                       0xC
#define MISSILE_DATA_SPILL_RANGE                    0xD
#define MISSILE_DATA_SPILL_RADIUS                   0xE
#define MISSILE_DATA_HALF_FACTOR                    0xF
#define MISSILE_DATA_SMALL_FACTOR                   0x10
#define MISSILE_DATA_FULL_AREA                      0x11
#define MISSILE_DATA_HALF_AREA                      0x12
#define MISSILE_DATA_SMALL_AREA                     0x13



#define LOCAL_ORDER_FLAG_NORMAL                     0x0
#define LOCAL_ORDER_FLAG_QUEUE                      0x1
#define LOCAL_ORDER_FLAG_INSTANT                    0x2
#define LOCAL_ORDER_FLAG_ALONE                      0x4
#define LOCAL_ORDER_FLAG_ITEM                       0x8
#define LOCAL_ORDER_FLAG_RESTORE                    0x20



#define INDICATOR_TYPE_TARGET_MODE                  0x0
#define INDICATOR_TYPE_SELECT_MODE                  0x1
#define INDICATOR_TYPE_DRAG_SELECT_MODE             0x2
#define INDICATOR_TYPE_DRAG_SCROLL_MODE             0x3
#define INDICATOR_TYPE_BUILD_MODE                   0x4
#define INDICATOR_TYPE_SIGNAL_MODE                  0x5
#define INDICATOR_TYPE_ANY                          0x6



#define CHAT_CHANNEL_ALL		                    0x0
#define CHAT_CHANNEL_ALLY		                    0x1
#define CHAT_CHANNEL_OBSERVER	                    0x2
#define CHAT_CHANNEL_PRIVATE	                    0x3



#define CHEAT_FLAG_WHOSYOURDADDY	                0x2	
#define CHEAT_FLAG_WARPTEN			                0x4	
#define CHEAT_FLAG_POINTBREAK		                0x10
#define CHEAT_FLAG_THEREISNOSPOON	                0x20
#define CHEAT_FLAG_STRENGTHANDHONOR                 0x40
#define CHEAT_FLAG_ITVEXESME		                0x80
#define CHEAT_FLAG_WHOISJOHNGALT	                0x100
#define CHEAT_FLAG_ISEEDEADPEOPLE	                0x200
#define CHEAT_FLAG_SYNERGY			                0x400
#define CHEAT_FLAG_DAYLIGHTSAVINGS	                0x800

#define JASS_LOG_LEVEL_DISABLE                      0x0
#define JASS_LOG_LEVEL_CALL                         0x1
#define JASS_LOG_LEVEL_FUNCTION                     0x2
